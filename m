Return-Path: <linux-kernel-owner+w=401wt.eu-S1030319AbXAEF3J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030319AbXAEF3J (ORCPT <rfc822;w@1wt.eu>);
	Fri, 5 Jan 2007 00:29:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030312AbXAEF3J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Jan 2007 00:29:09 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.146]:43033 "EHLO e6.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030308AbXAEF3F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Jan 2007 00:29:05 -0500
Date: Fri, 5 Jan 2007 11:02:22 +0530
From: Suparna Bhattacharya <suparna@in.ibm.com>
To: linux-aio@kvack.org, akpm@osdl.org, drepper@redhat.com
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       jakub@redhat.com, mingo@elte.hu
Subject: [PATCHSET 4][PATCH 1/1] AIO fallback for pipes, sockets and pollable fds
Message-ID: <20070105053222.GA12568@in.ibm.com>
Reply-To: suparna@in.ibm.com
References: <20061227153855.GA25898@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061227153855.GA25898@in.ibm.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


As glibc POSIX AIO switches over completely to using native AIO it needs
basic AIO support for various file types - including sockets, pipes etc.
Since userland will no longer be simulating asynchronous behaviour
with threads, it expects the underlying implementation to be asynchronous.
Which is still an issue with native linux AIO. 

One (not so appealing) alternative that has been considered in the past is
a fallback path that spawns a kernel thread per AIO request. This in some
sense amounts to pushing the problem down from user to kernel space.
Fortunately we can do better. We can effectively simulate AIO in kernel
using async poll and O_NONBLOCK for all pollable fds, i.e. sockets, pipes
etc.

With this scheme in place, all that needs to be done to add AIO support
for any pollable file type is to make sure that the corresponding 
f_op->aio_read/aio_write implements O_NONBLOCK behaviour if called in
aio context, i.e. with an async kiocb. The high level common AIO code
takes care of the rest, by enabling retries for completing the rest of
the IO to be initiated directly via poll wait notifications.

This fallback option should be good enough to get us to working POSIX AIO,
now that filesystem AIO already takes care of ISREG files which do not
support O_NONBLOCK. I have tested this with modified pipetest runs, also
using sockets instead of pipes.


---

 linux-2.6.20-rc1-root/fs/aio.c     |   54 +++++++++++++++++++++++++++++++++++++
 linux-2.6.20-rc1-root/fs/pipe.c    |   17 +++++++----
 linux-2.6.20-rc1-root/net/socket.c |    6 ++--
 3 files changed, 69 insertions(+), 8 deletions(-)

diff -puN fs/aio.c~aio-fallback-nonblock fs/aio.c
--- linux-2.6.20-rc1/fs/aio.c~aio-fallback-nonblock	2007-01-03 19:16:36.000000000 +0530
+++ linux-2.6.20-rc1-root/fs/aio.c	2007-01-05 10:29:52.000000000 +0530
@@ -30,6 +30,7 @@
 #include <linux/highmem.h>
 #include <linux/workqueue.h>
 #include <linux/security.h>
+#include <linux/poll.h>
 #include <linux/eventpoll.h>
 
 #include <asm/kmap_types.h>
@@ -1315,6 +1316,42 @@ static void aio_advance_iovec(struct kio
 	BUG_ON(ret > 0 && iocb->ki_left == 0);
 }
 
+/* Wrapper structure used by poll queuing */
+struct aio_pqueue {
+	poll_table pt;
+	struct kiocb *iocb;
+};
+
+static int aio_cancel_wait(struct kiocb *iocb, struct io_event *event)
+{
+	wait_queue_head_t *wq = (struct wait_queue_head_t *)iocb->private;
+	if (wq)
+		wake_up(wq);
+	event->res = iocb->ki_nbytes - iocb->ki_left;
+	event->res2 = 0;
+	/* drop the cancel reference */
+	aio_put_req(iocb);
+	return 0;
+}
+
+/* Sets things up for a readiness event to trigger the iocb's retry */
+static void aio_poll_table_queue_proc(struct file *file,
+			wait_queue_head_t *whead, poll_table *pt)
+{
+	struct kiocb *iocb = container_of(pt, struct aio_pqueue, pt)->iocb;
+
+	if (unlikely(iocb->private && iocb->ki_dtor)) {
+		/* FIXME: We really shouldn't have to do this */
+		/* the siocb allocation in socket.c is unused AFAIK */
+		iocb->ki_dtor(iocb);
+		iocb->ki_dtor = NULL;
+	}
+
+	iocb->private = whead;
+	iocb->ki_cancel = aio_cancel_wait;
+	prepare_to_wait(whead, &iocb->ki_wait.wait, 0);
+}
+
 static ssize_t aio_rw_vect_retry(struct kiocb *iocb)
 {
 	struct file *file = iocb->ki_filp;
@@ -1334,6 +1371,7 @@ static ssize_t aio_rw_vect_retry(struct 
 		opcode = IOCB_CMD_PWRITEV;
 	}
 
+ready:
 	do {
 		ret = rw_op(iocb, &iocb->ki_iovec[iocb->ki_cur_seg],
 			    iocb->ki_nr_segs - iocb->ki_cur_seg,
@@ -1352,6 +1390,22 @@ static ssize_t aio_rw_vect_retry(struct 
 	if ((ret == 0) || (iocb->ki_left == 0))
 		ret = iocb->ki_nbytes - iocb->ki_left;
 
+	if (ret == -EAGAIN && file->f_op->poll) {
+		/* This means fop->aio_read implements O_NONBLOCK behaviour */
+		/* Let us try to simulate aio retries using ->poll */
+		struct aio_pqueue pollq = {.iocb = iocb};
+		int events = (opcode == IOCB_CMD_PWRITEV) ?
+			POLLOUT | POLLERR | POLLHUP :
+			POLLIN | POLLERR | POLLHUP;
+
+		init_poll_funcptr(&pollq.pt, aio_poll_table_queue_proc);
+		ret = file->f_op->poll(file, &pollq.pt);
+		if (ret >= 0) {
+			if (ret & events)
+				goto ready;
+			ret = -EIOCBRETRY;
+		}
+	}
 	return ret;
 }
 
diff -puN net/socket.c~aio-fallback-nonblock net/socket.c
--- linux-2.6.20-rc1/net/socket.c~aio-fallback-nonblock	2007-01-03 19:16:36.000000000 +0530
+++ linux-2.6.20-rc1-root/net/socket.c	2007-01-03 19:16:36.000000000 +0530
@@ -701,7 +701,8 @@ static ssize_t do_sock_read(struct msghd
 	msg->msg_controllen = 0;
 	msg->msg_iov = (struct iovec *)iov;
 	msg->msg_iovlen = nr_segs;
-	msg->msg_flags = (file->f_flags & O_NONBLOCK) ? MSG_DONTWAIT : 0;
+	msg->msg_flags = ((file->f_flags & O_NONBLOCK) || !is_sync_kiocb(iocb))
+				? MSG_DONTWAIT : 0;
 
 	return __sock_recvmsg(iocb, sock, msg, size, msg->msg_flags);
 }
@@ -741,7 +742,8 @@ static ssize_t do_sock_write(struct msgh
 	msg->msg_controllen = 0;
 	msg->msg_iov = (struct iovec *)iov;
 	msg->msg_iovlen = nr_segs;
-	msg->msg_flags = (file->f_flags & O_NONBLOCK) ? MSG_DONTWAIT : 0;
+	msg->msg_flags = ((file->f_flags & O_NONBLOCK) || !is_sync_kiocb(iocb))
+				? MSG_DONTWAIT : 0;
 	if (sock->type == SOCK_SEQPACKET)
 		msg->msg_flags |= MSG_EOR;
 
diff -puN fs/pipe.c~aio-fallback-nonblock fs/pipe.c
--- linux-2.6.20-rc1/fs/pipe.c~aio-fallback-nonblock	2007-01-03 19:16:36.000000000 +0530
+++ linux-2.6.20-rc1-root/fs/pipe.c	2007-01-03 19:16:36.000000000 +0530
@@ -226,14 +226,16 @@ pipe_read(struct kiocb *iocb, const stru
 	struct pipe_inode_info *pipe;
 	int do_wakeup;
 	ssize_t ret;
-	struct iovec *iov = (struct iovec *)_iov;
+	struct iovec iov_array[nr_segs];
+	struct iovec *iov = iov_array;
 	size_t total_len;
 
-	total_len = iov_length(iov, nr_segs);
+	total_len = iov_length(_iov, nr_segs);
 	/* Null read succeeds. */
 	if (unlikely(total_len == 0))
 		return 0;
 
+	memcpy(iov, _iov, nr_segs * sizeof(struct iovec));
 	do_wakeup = 0;
 	ret = 0;
 	mutex_lock(&inode->i_mutex);
@@ -302,7 +304,8 @@ redo:
 			 */
 			if (ret)
 				break;
-			if (filp->f_flags & O_NONBLOCK) {
+			if (filp->f_flags & O_NONBLOCK ||
+					!is_sync_kiocb(iocb)) {
 				ret = -EAGAIN;
 				break;
 			}
@@ -339,15 +342,17 @@ pipe_write(struct kiocb *iocb, const str
 	struct pipe_inode_info *pipe;
 	ssize_t ret;
 	int do_wakeup;
-	struct iovec *iov = (struct iovec *)_iov;
+	struct iovec iov_array[nr_segs];
+	struct iovec *iov = iov_array;
 	size_t total_len;
 	ssize_t chars;
 
-	total_len = iov_length(iov, nr_segs);
+	total_len = iov_length(_iov, nr_segs);
 	/* Null write succeeds. */
 	if (unlikely(total_len == 0))
 		return 0;
 
+	memcpy(iov, _iov, nr_segs * sizeof(struct iovec));
 	do_wakeup = 0;
 	ret = 0;
 	mutex_lock(&inode->i_mutex);
@@ -473,7 +478,7 @@ redo2:
 		}
 		if (bufs < PIPE_BUFFERS)
 			continue;
-		if (filp->f_flags & O_NONBLOCK) {
+		if (filp->f_flags & O_NONBLOCK || !is_sync_kiocb(iocb)) {
 			if (!ret)
 				ret = -EAGAIN;
 			break;
_

-- 
Suparna Bhattacharya (suparna@in.ibm.com)
Linux Technology Center
IBM Software Lab, India

