Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932447AbWGILOI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932447AbWGILOI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jul 2006 07:14:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932452AbWGILOI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jul 2006 07:14:08 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:48398 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S932447AbWGILOH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jul 2006 07:14:07 -0400
Date: Sun, 9 Jul 2006 13:16:29 +0200
From: Jens Axboe <axboe@suse.de>
To: "Luiz Fernando N. Capitulino" <lcapitulino@mandriva.com.br>
Cc: Andrew Morton <akpm@osdl.org>, Michael Kerrisk <mtk-manpages@gmx.net>,
       linux-kernel@vger.kernel.org, michael.kerrisk@gmx.net,
       vendor-sec@lst.de
Subject: Re: splice/tee bugs?
Message-ID: <20060709111629.GV4188@suse.de>
References: <20060707070703.165520@gmx.net> <20060707040749.97f8c1fc.akpm@osdl.org> <20060707131310.0e382585@doriath.conectiva> <20060708064131.GG4188@suse.de> <20060708180926.00b1c0f8@home.brethil> <20060709103606.GU4188@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060709103606.GU4188@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 09 2006, Jens Axboe wrote:
> On Sat, Jul 08 2006, Luiz Fernando N. Capitulino wrote:
> > 
> >  Hi Jens,
> > 
> > On Sat, 8 Jul 2006 08:41:32 +0200
> > Jens Axboe <axboe@suse.de> wrote:
> > 
> > | On Fri, Jul 07 2006, Luiz Fernando N. Capitulino wrote:
> > | > On Fri, 7 Jul 2006 04:07:49 -0700
> > | > Andrew Morton <akpm@osdl.org> wrote:
> > | > 
> > | > | On Fri, 07 Jul 2006 09:07:03 +0200
> > | > | "Michael Kerrisk" <mtk-manpages@gmx.net> wrote:
> > | > | 
> > | > | > c) Occasionally the command line just hangs, producing no output.
> > | > | >    In this case I can't kill it with ^C or ^\.  This is a 
> > | > | >    hard-to-reproduce behaviour on my (x86) system, but I have 
> > | > | >    seen it several times by now.
> > | > | 
> > | > | aka local DoS.  Please capture sysrq-T output next time.
> > | > 
> > | >  If I run lots of them in parallel, I get the following OOPs in a few
> > | > seconds:
> > | 
> > | With the patch posted? You need the i vs nrbufs fix.
> > 
> >  Yes, it fixes the problem. I didn't try it before because I thought
> > you were going to double check it [1].
> 
> Yeah the patch needs reworking, however the isolated i vs nrbufs fix is
> safe enough on its own. I'll post a full patch for inclusion, I'm afraid
> I wont be able to fully test it enough for submitting it until tomorrow
> though.

Something like this, testing would be appreciated! Michael, can you
repeat your testing as well? Thanks.

diff --git a/fs/splice.c b/fs/splice.c
index 05fd278..ecf72bc 100644
--- a/fs/splice.c
+++ b/fs/splice.c
@@ -1307,6 +1307,69 @@ asmlinkage long sys_splice(int fd_in, lo
 }
 
 /*
+ * Make sure there's data to read. Wait for input if we can, otherwise
+ * return an appropriate error.
+ */
+static int link_ipipe_prep(struct pipe_inode_info *pipe, unsigned int flags)
+{
+	int ret = 0;
+
+	mutex_lock(&pipe->inode->i_mutex);
+
+	while (!pipe->nrbufs) {
+		if (signal_pending(current)) {
+			ret = -ERESTARTSYS;
+			break;
+		}
+		if (!pipe->writers)
+			break;
+		if (!pipe->waiting_writers) {
+			if (flags & SPLICE_F_NONBLOCK) {
+				ret = -EAGAIN;
+				break;
+			}
+		}
+		pipe_wait(pipe);
+	}
+	
+	mutex_unlock(&pipe->inode->i_mutex);
+	return ret;
+}
+
+/*
+ * Make sure there's writeable room. Wait for room if we can, otherwise
+ * return an appropriate error.
+ */
+static int link_opipe_prep(struct pipe_inode_info *pipe, unsigned int flags)
+{
+	int ret = 0;
+
+	mutex_lock(&pipe->inode->i_mutex);
+
+	while (pipe->nrbufs >= PIPE_BUFFERS) {
+		if (!pipe->readers) {
+			send_sig(SIGPIPE, current, 0);
+			ret = -EPIPE;
+			break;
+		}
+		if (flags & SPLICE_F_NONBLOCK) {
+			ret = -EAGAIN;
+			break;
+		}
+		if (signal_pending(current)) {
+			ret = -ERESTARTSYS;
+			break;
+		}
+		pipe->waiting_writers++;
+		pipe_wait(pipe);
+		pipe->waiting_writers--;
+	}
+
+	mutex_unlock(&pipe->inode->i_mutex);
+	return ret;
+}
+
+/*
  * Link contents of ipipe to opipe.
  */
 static int link_pipe(struct pipe_inode_info *ipipe,
@@ -1314,9 +1377,9 @@ static int link_pipe(struct pipe_inode_i
 		     size_t len, unsigned int flags)
 {
 	struct pipe_buffer *ibuf, *obuf;
-	int ret, do_wakeup, i, ipipe_first;
+	int ret, i, nbuf;
 
-	ret = do_wakeup = ipipe_first = 0;
+	i = ret = 0;
 
 	/*
 	 * Potential ABBA deadlock, work around it by ordering lock
@@ -1324,131 +1387,65 @@ static int link_pipe(struct pipe_inode_i
 	 * could deadlock (one doing tee from A -> B, the other from B -> A).
 	 */
 	if (ipipe->inode < opipe->inode) {
-		ipipe_first = 1;
-		mutex_lock(&ipipe->inode->i_mutex);
-		mutex_lock(&opipe->inode->i_mutex);
+		mutex_lock_nested(&ipipe->inode->i_mutex, I_MUTEX_PARENT);
+		mutex_lock_nested(&opipe->inode->i_mutex, I_MUTEX_CHILD);
 	} else {
-		mutex_lock(&opipe->inode->i_mutex);
-		mutex_lock(&ipipe->inode->i_mutex);
+		mutex_lock_nested(&opipe->inode->i_mutex, I_MUTEX_PARENT);
+		mutex_lock_nested(&ipipe->inode->i_mutex, I_MUTEX_CHILD);
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
-			ibuf = ipipe->bufs + ((ipipe->curbuf + i) & (PIPE_BUFFERS - 1));
-
-			/*
-			 * If we have room, fill this buffer
-			 */
-			if (opipe->nrbufs < PIPE_BUFFERS) {
-				int nbuf = (opipe->curbuf + opipe->nrbufs) & (PIPE_BUFFERS - 1);
 
-				/*
-				 * Get a reference to this pipe buffer,
-				 * so we can copy the contents over.
-				 */
-				ibuf->ops->get(ipipe, ibuf);
-
-				obuf = opipe->bufs + nbuf;
-				*obuf = *ibuf;
-
-				/*
-				 * Don't inherit the gift flag, we need to
-				 * prevent multiple steals of this page.
-				 */
-				obuf->flags &= ~PIPE_BUF_FLAG_GIFT;
-
-				if (obuf->len > len)
-					obuf->len = len;
-
-				opipe->nrbufs++;
-				do_wakeup = 1;
-				ret += obuf->len;
-				len -= obuf->len;
-
-				if (!len)
-					break;
-				if (opipe->nrbufs < PIPE_BUFFERS)
-					continue;
-			}
-
-			/*
-			 * We have input available, but no output room.
-			 * If we already copied data, return that. If we
-			 * need to drop the opipe lock, it must be ordered
-			 * last to avoid deadlocks.
-			 */
-			if ((flags & SPLICE_F_NONBLOCK) || !ipipe_first) {
-				if (!ret)
-					ret = -EAGAIN;
-				break;
-			}
-			if (signal_pending(current)) {
-				if (!ret)
-					ret = -ERESTARTSYS;
-				break;
-			}
-			if (do_wakeup) {
-				smp_mb();
-				if (waitqueue_active(&opipe->wait))
-					wake_up_interruptible(&opipe->wait);
-				kill_fasync(&opipe->fasync_readers, SIGIO, POLL_IN);
-				do_wakeup = 0;
-			}
+		/*
+		 * If we have iterated all input buffers or ran out of
+		 * output room, break.
+		 */
+		if (i >= ipipe->nrbufs || opipe->nrbufs >= PIPE_BUFFERS)
+			break;
 
-			opipe->waiting_writers++;
-			pipe_wait(opipe);
-			opipe->waiting_writers--;
-			continue;
-		}
+		ibuf = ipipe->bufs + ((ipipe->curbuf + i) & (PIPE_BUFFERS - 1));
+		nbuf = (opipe->curbuf + opipe->nrbufs) & (PIPE_BUFFERS - 1);
 
 		/*
-		 * No input buffers, do the usual checks for available
-		 * writers and blocking and wait if necessary
+		 * Get a reference to this pipe buffer,
+		 * so we can copy the contents over.
 		 */
-		if (!ipipe->writers)
-			break;
-		if (!ipipe->waiting_writers) {
-			if (ret)
-				break;
-		}
+		ibuf->ops->get(ipipe, ibuf);
+
+		obuf = opipe->bufs + nbuf;
+		*obuf = *ibuf;
+
 		/*
-		 * pipe_wait() drops the ipipe mutex. To avoid deadlocks
-		 * with another process, we can only safely do that if
-		 * the ipipe lock is ordered last.
+		 * Don't inherit the gift flag, we need to
+		 * prevent multiple steals of this page.
 		 */
-		if ((flags & SPLICE_F_NONBLOCK) || ipipe_first) {
-			if (!ret)
-				ret = -EAGAIN;
-			break;
-		}
-		if (signal_pending(current)) {
-			if (!ret)
-				ret = -ERESTARTSYS;
-			break;
-		}
+		obuf->flags &= ~PIPE_BUF_FLAG_GIFT;
 
-		if (waitqueue_active(&ipipe->wait))
-			wake_up_interruptible_sync(&ipipe->wait);
-		kill_fasync(&ipipe->fasync_writers, SIGIO, POLL_OUT);
+		if (obuf->len > len)
+			obuf->len = len;
 
-		pipe_wait(ipipe);
-	}
+		opipe->nrbufs++;
+		ret += obuf->len;
+		len -= obuf->len;
+		i++;
+	} while (len);
 
 	mutex_unlock(&ipipe->inode->i_mutex);
 	mutex_unlock(&opipe->inode->i_mutex);
 
-	if (do_wakeup) {
+	if (ret) {
 		smp_mb();
 		if (waitqueue_active(&opipe->wait))
 			wake_up_interruptible(&opipe->wait);
 		kill_fasync(&opipe->fasync_readers, SIGIO, POLL_IN);
-	}
+	} else if (flags & SPLICE_F_NONBLOCK)
+		ret = -EAGAIN;
 
 	return ret;
 }
@@ -1464,12 +1461,23 @@ static long do_tee(struct file *in, stru
 {
 	struct pipe_inode_info *ipipe = in->f_dentry->d_inode->i_pipe;
 	struct pipe_inode_info *opipe = out->f_dentry->d_inode->i_pipe;
+	int ret;
 
 	/*
-	 * Link ipipe to the two output pipes, consuming as we go along.
+	 * Duplicate the contents of ipipe to opipe without actually
+	 * copying the data.
 	 */
-	if (ipipe && opipe)
+	if (ipipe && opipe && ipipe != opipe) {
+		ret = link_ipipe_prep(ipipe, flags);
+		if (unlikely(ret))
+			return ret;
+
+		ret = link_opipe_prep(opipe, flags);
+		if (unlikely(ret))
+			return ret;
+
 		return link_pipe(ipipe, opipe, len, flags);
+	}
 
 	return -EINVAL;
 }

-- 
Jens Axboe

