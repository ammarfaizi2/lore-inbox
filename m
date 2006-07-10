Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161348AbWGJGoj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161348AbWGJGoj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 02:44:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161351AbWGJGoj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 02:44:39 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:31286 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1161348AbWGJGoi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 02:44:38 -0400
Date: Mon, 10 Jul 2006 08:43:55 +0200
From: Jens Axboe <axboe@suse.de>
To: Michael Kerrisk <michael.kerrisk@gmx.net>
Cc: lcapitulino@mandriva.com.br, vendor-sec@lst.de,
       linux-kernel@vger.kernel.org, mtk-manpages@gmx.net, akpm@osdl.org
Subject: Re: splice/tee bugs?
Message-ID: <20060710064355.GB4141@suse.de>
References: <20060707070703.165520@gmx.net> <20060707040749.97f8c1fc.akpm@osdl.org> <20060707131310.0e382585@doriath.conectiva> <20060708064131.GG4188@suse.de> <20060708180926.00b1c0f8@home.brethil> <20060709103606.GU4188@suse.de> <20060709111629.GV4188@suse.de> <20060709134703.0aa5bc41@home.brethil> <20060709175744.GZ4188@suse.de> <20060710062551.307040@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060710062551.307040@gmx.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 10 2006, Michael Kerrisk wrote:
> > >  Should we use the first patch for it? It does work too.
> > 
> > No, I'll rebase the patch for 2.6.17.x - basically you just need to
> > change the two mutex_lock_nested() to mutex_lock() and that is it. But
> > first I'd like Michael to retest as well (and more importantly, I'll do
> > some testing myself too).
> 
> Jens,
> 
> Could you post a 2.6.17 patch please.

Here's a 2.6.17.x version.

--- linux-2.6.17/fs/splice.c~	2006-07-10 08:42:55.000000000 +0200
+++ linux-2.6.17/fs/splice.c	2006-07-10 08:43:20.000000000 +0200
@@ -1295,6 +1295,85 @@
 }
 
 /*
+ * Make sure there's data to read. Wait for input if we can, otherwise
+ * return an appropriate error.
+ */
+static int link_ipipe_prep(struct pipe_inode_info *pipe, unsigned int flags)
+{
+	int ret;
+
+	/*
+	 * Check ->nrbufs without the inode lock first. This function
+	 * is speculative anyways, so missing one is ok.
+	 */
+	if (pipe->nrbufs)
+		return 0;
+
+	ret = 0;
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
+	int ret;
+
+	/*
+	 * Check ->nrbufs without the inode lock first. This function
+	 * is speculative anyways, so missing one is ok.
+	 */
+	if (pipe->nrbufs < PIPE_BUFFERS)
+		return 0;
+
+	ret = 0;
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
@@ -1302,9 +1381,9 @@
 		     size_t len, unsigned int flags)
 {
 	struct pipe_buffer *ibuf, *obuf;
-	int ret, do_wakeup, i, ipipe_first;
+	int ret, i, nbuf;
 
-	ret = do_wakeup = ipipe_first = 0;
+	i = ret = 0;
 
 	/*
 	 * Potential ABBA deadlock, work around it by ordering lock
@@ -1312,7 +1391,6 @@
 	 * could deadlock (one doing tee from A -> B, the other from B -> A).
 	 */
 	if (ipipe->inode < opipe->inode) {
-		ipipe_first = 1;
 		mutex_lock(&ipipe->inode->i_mutex);
 		mutex_lock(&opipe->inode->i_mutex);
 	} else {
@@ -1320,123 +1398,58 @@
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
-			ibuf = ipipe->bufs + ((ipipe->curbuf + i) & (PIPE_BUFFERS - 1));
-
-			/*
-			 * If we have room, fill this buffer
-			 */
-			if (opipe->nrbufs < PIPE_BUFFERS) {
-				int nbuf = (opipe->curbuf + opipe->nrbufs) & (PIPE_BUFFERS - 1);
-
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
@@ -1452,12 +1465,23 @@
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

