Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751055AbWGQQo6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751055AbWGQQo6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jul 2006 12:44:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750954AbWGQQcW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jul 2006 12:32:22 -0400
Received: from mail.kroah.org ([69.55.234.183]:39354 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1750955AbWGQQcI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jul 2006 12:32:08 -0400
Date: Mon, 17 Jul 2006 09:27:55 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk, Jens Axboe <axboe@suse.de>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 25/45] splice: fix problems with sys_tee()
Message-ID: <20060717162755.GZ4829@kroah.com>
References: <20060717160652.408007000@blue.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="splice-fix-problems-with-sys_tee.patch"
In-Reply-To: <20060717162452.GA4829@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.

------------------
Several issues noticed/fixed:

- We cannot reliably block in link_pipe() while holding both input and output
  mutexes. So do preparatory checks before locking down both mutexes and doing
  the link.

- The ipipe->nrbufs vs i check was bad, because we could have dropped the
  ipipe lock in-between. This causes us to potentially look at unknown
  buffers if we were racing with someone else reading this pipe.

Signed-off-by: Jens Axboe <axboe@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 fs/splice.c |  230 +++++++++++++++++++++++++++++++++---------------------------
 1 file changed, 129 insertions(+), 101 deletions(-)

--- linux-2.6.17.6.orig/fs/splice.c
+++ linux-2.6.17.6/fs/splice.c
@@ -1295,6 +1295,85 @@ asmlinkage long sys_splice(int fd_in, lo
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
@@ -1302,9 +1381,7 @@ static int link_pipe(struct pipe_inode_i
 		     size_t len, unsigned int flags)
 {
 	struct pipe_buffer *ibuf, *obuf;
-	int ret, do_wakeup, i, ipipe_first;
-
-	ret = do_wakeup = ipipe_first = 0;
+	int ret = 0, i = 0, nbuf;
 
 	/*
 	 * Potential ABBA deadlock, work around it by ordering lock
@@ -1312,7 +1389,6 @@ static int link_pipe(struct pipe_inode_i
 	 * could deadlock (one doing tee from A -> B, the other from B -> A).
 	 */
 	if (ipipe->inode < opipe->inode) {
-		ipipe_first = 1;
 		mutex_lock(&ipipe->inode->i_mutex);
 		mutex_lock(&opipe->inode->i_mutex);
 	} else {
@@ -1320,118 +1396,55 @@ static int link_pipe(struct pipe_inode_i
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
+	/*
+	 * If we put data in the output pipe, wakeup any potential readers.
+	 */
+	if (ret > 0) {
 		smp_mb();
 		if (waitqueue_active(&opipe->wait))
 			wake_up_interruptible(&opipe->wait);
@@ -1452,14 +1465,29 @@ static long do_tee(struct file *in, stru
 {
 	struct pipe_inode_info *ipipe = in->f_dentry->d_inode->i_pipe;
 	struct pipe_inode_info *opipe = out->f_dentry->d_inode->i_pipe;
+	int ret = -EINVAL;
 
 	/*
-	 * Link ipipe to the two output pipes, consuming as we go along.
+	 * Duplicate the contents of ipipe to opipe without actually
+	 * copying the data.
 	 */
-	if (ipipe && opipe)
-		return link_pipe(ipipe, opipe, len, flags);
+	if (ipipe && opipe && ipipe != opipe) {
+		/*
+		 * Keep going, unless we encounter an error. The ipipe/opipe
+		 * ordering doesn't really matter.
+		 */
+		ret = link_ipipe_prep(ipipe, flags);
+		if (!ret) {
+			ret = link_opipe_prep(opipe, flags);
+			if (!ret) {
+				ret = link_pipe(ipipe, opipe, len, flags);
+				if (!ret && (flags & SPLICE_F_NONBLOCK))
+					ret = -EAGAIN;
+			}
+		}
+	}
 
-	return -EINVAL;
+	return ret;
 }
 
 asmlinkage long sys_tee(int fdin, int fdout, size_t len, unsigned int flags)

--
