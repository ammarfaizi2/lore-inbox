Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932071AbWGGNKa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932071AbWGGNKa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 09:10:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932082AbWGGNKa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 09:10:30 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:47153 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S932071AbWGGNK3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 09:10:29 -0400
Date: Fri, 7 Jul 2006 15:12:48 +0200
From: Jens Axboe <axboe@suse.de>
To: Michael Kerrisk <michael.kerrisk@gmx.net>
Cc: mtk-manpages@gmx.net, linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: splice/tee bugs?
Message-ID: <20060707131247.GX4188@suse.de>
References: <20060707070703.165520@gmx.net> <20060707040749.97f8c1fc.akpm@osdl.org> <20060707114235.243260@gmx.net> <20060707120333.GR4188@suse.de> <20060707122850.GU4188@suse.de> <20060707123110.64140@gmx.net> <20060707124105.GW4188@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060707124105.GW4188@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 07 2006, Jens Axboe wrote:
> On Fri, Jul 07 2006, Michael Kerrisk wrote:
> > Jens Axboe wrote:
> > 
> > > > > > >    In this case I can't kill it with ^C or ^\.  This is a 
> > > > > > >    hard-to-reproduce behaviour on my (x86) system, but I have 
> > > > > > >    seen it several times by now.
> > > > > > 
> > > > > > aka local DoS.  Please capture sysrq-T output next time.
> > [...]
> > > > I'll see about reproducing locally.
> > > 
> > > With your modified ktee, I can reproduce it here. Here's the ktee and wc
> > > output:
> > 
> > Good; thanks.
> > 
> > By the way, what about points a) and b) in my original mail
> > in this thread?
> 
> I'll look at them after this.

I _think_ it was due to a bad check for ipipe->nrbufs, can you see if
this works for you? It also changes some other things:

- instead of returning EAGAIN on nothing tee'd because of the possible
  deadlock problem, release/regrab the ipipe/opipe mutex if we have to.
  This makes sys_tee block for that case if SPLICE_F_NONBLOCK isn't set.

- Check that ipipe and opipe differ to avoid possible deadlock if user
  gives the same pipe.

You can still see 0 results without SPLICE_F_NONBLOCK set, if we have no
writers for instance. This is expected, not much we can do about that as
we cannot block for that condition.

diff --git a/fs/splice.c b/fs/splice.c
index 05fd278..de323df 100644
--- a/fs/splice.c
+++ b/fs/splice.c
@@ -1316,7 +1316,7 @@ static int link_pipe(struct pipe_inode_i
 	struct pipe_buffer *ibuf, *obuf;
 	int ret, do_wakeup, i, ipipe_first;
 
-	ret = do_wakeup = ipipe_first = 0;
+	i = ret = do_wakeup = ipipe_first = 0;
 
 	/*
 	 * Potential ABBA deadlock, work around it by ordering lock
@@ -1332,14 +1332,14 @@ static int link_pipe(struct pipe_inode_i
 		mutex_lock(&ipipe->inode->i_mutex);
 	}
 
-	for (i = 0;; i++) {
+	do {
 		if (!opipe->readers) {
 			send_sig(SIGPIPE, current, 0);
 			if (!ret)
 				ret = -EPIPE;
 			break;
 		}
-		if (ipipe->nrbufs - i) {
+		if (i < ipipe->nrbufs) {
 			ibuf = ipipe->bufs + ((ipipe->curbuf + i) & (PIPE_BUFFERS - 1));
 
 			/*
@@ -1370,6 +1370,7 @@ static int link_pipe(struct pipe_inode_i
 				do_wakeup = 1;
 				ret += obuf->len;
 				len -= obuf->len;
+				i++;
 
 				if (!len)
 					break;
@@ -1379,11 +1380,9 @@ static int link_pipe(struct pipe_inode_i
 
 			/*
 			 * We have input available, but no output room.
-			 * If we already copied data, return that. If we
-			 * need to drop the opipe lock, it must be ordered
-			 * last to avoid deadlocks.
+			 * If we already copied data, return that.
 			 */
-			if ((flags & SPLICE_F_NONBLOCK) || !ipipe_first) {
+			if (flags & SPLICE_F_NONBLOCK) {
 				if (!ret)
 					ret = -EAGAIN;
 				break;
@@ -1400,10 +1399,22 @@ static int link_pipe(struct pipe_inode_i
 				kill_fasync(&opipe->fasync_readers, SIGIO, POLL_IN);
 				do_wakeup = 0;
 			}
+	
+			/*
+			 * To avoid ABBA deadlocks, we need to drop the ipipe
+			 * lock before dropping/grabbing the opipe lock in
+			 * pipe_wait().
+			 */
+			if (!ipipe_first)
+				mutex_unlock(&ipipe->inode->i_mutex);
 
 			opipe->waiting_writers++;
 			pipe_wait(opipe);
 			opipe->waiting_writers--;
+
+			if (!ipipe_first)
+				mutex_lock(&ipipe->inode->i_mutex);
+
 			continue;
 		}
 
@@ -1417,12 +1428,7 @@ static int link_pipe(struct pipe_inode_i
 			if (ret)
 				break;
 		}
-		/*
-		 * pipe_wait() drops the ipipe mutex. To avoid deadlocks
-		 * with another process, we can only safely do that if
-		 * the ipipe lock is ordered last.
-		 */
-		if ((flags & SPLICE_F_NONBLOCK) || ipipe_first) {
+		if (flags & SPLICE_F_NONBLOCK) {
 			if (!ret)
 				ret = -EAGAIN;
 			break;
@@ -1437,7 +1443,18 @@ static int link_pipe(struct pipe_inode_i
 			wake_up_interruptible_sync(&ipipe->wait);
 		kill_fasync(&ipipe->fasync_writers, SIGIO, POLL_OUT);
 
+		/*
+		 * To avoid ABBA deadlocks, we need to drop the ipipe
+		 * lock before dropping/grabbing the opipe lock in
+		 * pipe_wait().
+		 */
+		if (ipipe_first)
+			mutex_unlock(&opipe->inode->i_mutex);
+
 		pipe_wait(ipipe);
+
+		if (ipipe_first)
+			mutex_lock(&opipe->inode->i_mutex);
 	}
 
 	mutex_unlock(&ipipe->inode->i_mutex);
@@ -1468,7 +1485,7 @@ static long do_tee(struct file *in, stru
 	/*
 	 * Link ipipe to the two output pipes, consuming as we go along.
 	 */
-	if (ipipe && opipe)
+	if (ipipe && opipe && ipipe != opipe)
 		return link_pipe(ipipe, opipe, len, flags);
 
 	return -EINVAL;

-- 
Jens Axboe

