Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261172AbVCXWTP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261172AbVCXWTP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Mar 2005 17:19:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261170AbVCXWTP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Mar 2005 17:19:15 -0500
Received: from rev.193.226.232.24.euroweb.hu ([193.226.232.24]:59034 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S261172AbVCXWSq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Mar 2005 17:18:46 -0500
To: akpm@osdl.org
CC: linux-kernel@vger.kernel.org
Subject: [PATCH] FUSE: comments and documentation
Message-Id: <E1DEaek-0007kp-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 24 Mar 2005 23:18:22 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This adds lots of documentation for the userspace - kernel interface.

Signed-off-by: Miklos Szeredi <miklos@szeredi.hu>

 Documentation/filesystems/fuse.txt |  130 +++++++++++++++++++++++++++++++++++++
 fs/fuse/dev.c                      |  114 ++++++++++++++++++++++++++++----
 2 files changed, 230 insertions(+), 14 deletions(-)

diff -pruN linux-2.6.12-rc1-mm2/Documentation/filesystems/fuse.txt linux-fuse/Documentation/filesystems/fuse.txt
--- linux-2.6.12-rc1-mm2/Documentation/filesystems/fuse.txt	1970-01-01 01:00:00.000000000 +0100
+++ linux-fuse/Documentation/filesystems/fuse.txt	2005-03-24 23:06:06.000000000 +0100
@@ -0,0 +1,130 @@
+The following diagram shows how a filesystem operation (in this
+example unlink) is performed in FUSE.
+
+NOTE: everything in this description is greatly simplified
+
+ |  "rm /mnt/fuse/file"               |  FUSE filesystem daemon
+ |                                    |
+ |                                    |  >sys_read()
+ |                                    |    >fuse_dev_read()
+ |                                    |      >request_wait()
+ |                                    |        [sleep on fc->waitq]
+ |                                    |
+ |  >sys_unlink()                     |
+ |    >fuse_unlink()                  |
+ |      [get request from             |
+ |       fc->unused_list]             |
+ |      >request_send()               |
+ |        [queue req on fc->pending]  |
+ |        [wake up fc->waitq]         |        [woken up]
+ |        >request_wait_answer()      |
+ |          [sleep on req->waitq]     |
+ |                                    |      <request_wait()
+ |                                    |      [remove req from fc->pending]
+ |                                    |      [copy req to read buffer]
+ |                                    |      [add req to fc->processing]
+ |                                    |    <fuse_dev_read()
+ |                                    |  <sys_read()
+ |                                    |
+ |                                    |  [perform unlink]
+ |                                    |
+ |                                    |  >sys_write()
+ |                                    |    >fuse_dev_write()
+ |                                    |      [look up req in fc->processing]
+ |                                    |      [remove from fc->processing]
+ |                                    |      [copy write buffer to req]
+ |          [woken up]                |      [wake up req->waitq]
+ |                                    |    <fuse_dev_write()
+ |                                    |  <sys_write()
+ |        <request_wait_answer()      |
+ |      <request_send()               |
+ |      [add request to               |
+ |       fc->unused_list]             |
+ |    <fuse_unlink()                  |
+ |  <sys_unlink()                     |
+
+There are a couple of ways in which to deadlock a FUSE filesystem.
+Since we are talking about unprivileged userspace programs,
+something must be done about these.
+
+Scenario 1 -  Simple deadlock
+-----------------------------
+
+ |  "rm /mnt/fuse/file"               |  FUSE filesystem daemon
+ |                                    |
+ |  >sys_unlink("/mnt/fuse/file")     |
+ |    [acquire inode semaphore        |
+ |     for "file"]                    |
+ |    >fuse_unlink()                  |
+ |      [sleep on req->waitq]         |
+ |                                    |  <sys_read()
+ |                                    |  >sys_unlink("/mnt/fuse/file")
+ |                                    |    [acquire inode semaphore
+ |                                    |     for "file"]
+ |                                    |    *DEADLOCK*
+
+The solution for this is to allow requests to be interrupted while
+they are in userspace:
+
+ |      [interrupted by signal]       |
+ |    <fuse_unlink()                  |
+ |    [release semaphore]             |    [semaphore acquired]
+ |  <sys_unlink()                     |
+ |                                    |    >fuse_unlink()
+ |                                    |      [queue req on fc->pending]
+ |                                    |      [wake up fc->waitq]
+ |                                    |      [sleep on req->waitq]
+
+If the filesystem daemon was single threaded, this will stop here,
+since there's no other thread to dequeue and execute the request.
+In this case the solution is to kill the FUSE daemon as well.  If
+there are multiple serving threads, you just have to kill them as
+long as any remain.
+
+Moral: a filesystem which deadlocks, can soon find itself dead.
+
+Scenario 2 - Tricky deadlock
+----------------------------
+
+This one needs a carefully crafted filesystem.  It's a variation on
+the above, only the call back to the filesystem is not explicit,
+but is caused by a pagefault.
+
+ |  Kamikaze filesystem thread 1      |  Kamikaze filesystem thread 2
+ |                                    |
+ |  [fd = open("/mnt/fuse/file")]     |  [request served normally]
+ |  [mmap fd to 'addr']               |
+ |  [close fd]                        |  [FLUSH triggers 'magic' flag]
+ |  [read a byte from addr]           |
+ |    >do_page_fault()                |
+ |      [find or create page]         |
+ |      [lock page]                   |
+ |      >fuse_readpage()              |
+ |         [queue READ request]       |
+ |         [sleep on req->waitq]      |
+ |                                    |  [read request to buffer]
+ |                                    |  [create reply header before addr]
+ |                                    |  >sys_write(addr - headerlength)
+ |                                    |    >fuse_dev_write()
+ |                                    |      [look up req in fc->processing]
+ |                                    |      [remove from fc->processing]
+ |                                    |      [copy write buffer to req]
+ |                                    |        >do_page_fault()
+ |                                    |           [find or create page]
+ |                                    |           [lock page]
+ |                                    |           * DEADLOCK *
+
+Solution is again to let the the request be interrupted (not
+elaborated further).
+
+An additional problem is that while the write buffer is being
+copied to the request, the request must not be interrupted.  This
+is because the destination address of the copy may not be valid
+after the request is interrupted.
+
+This is solved with doing the copy atomically, and allowing
+interruption while the page(s) belonging to the write buffer are
+faulted with get_user_pages().  The 'req->locked' flag indicates
+when the copy is taking place, and interruption is delayed until
+this flag is unset.
+
diff -pruN linux-2.6.12-rc1-mm2/fs/fuse/dev.c linux-fuse/fs/fuse/dev.c
--- linux-2.6.12-rc1-mm2/fs/fuse/dev.c	2005-03-24 23:04:36.000000000 +0100
+++ linux-fuse/fs/fuse/dev.c	2005-03-24 23:02:31.000000000 +0100
@@ -108,6 +108,11 @@ struct fuse_req *fuse_get_request(struct
 	return do_get_request(fc);
 }
 
+/*
+ * Non-interruptible version of the above function is for operations
+ * which can't legally return -ERESTART{SYS,NOINTR}.  This can still
+ * return NULL, but only in case the signal is SIGKILL.
+ */
 struct fuse_req *fuse_get_request_nonint(struct fuse_conn *fc)
 {
 	int intr;
@@ -127,6 +132,7 @@ static void fuse_putback_request(struct 
 	else
 		fuse_request_free(req);
 
+	/* If we are in debt decrease that first */
 	if (fc->outstanding_debt)
 		fc->outstanding_debt--;
 	else
@@ -151,7 +157,17 @@ void fuse_release_background(struct fuse
 	spin_unlock(&fuse_lock);
 }
 
-/* Called with fuse_lock, unlocks it */
+/*
+ * This function is called when a request is finished.  Either a reply
+ * has arrived or it was interrupted (and not yet sent) or some error
+ * occured during communication with userspace, or the device file was
+ * closed.  It decreases the referece count for the request.  In case
+ * of a background request the referece to the stored objects are
+ * released.  The requester thread is woken up (if still waiting), and
+ * finally the request is either freed or put on the unused_list
+ *
+ * Called with fuse_lock, unlocks it
+ */
 static void request_end(struct fuse_conn *fc, struct fuse_req *req)
 {
 	int putback;
@@ -178,10 +194,37 @@ static void request_end(struct fuse_conn
 		fuse_putback_request(fc, req);
 }
 
+/*
+ * Unfortunately request interruption not just solves the deadlock
+ * problem, it causes problems too.  These stem from the fact, that an
+ * interrupted request is continued to be processed in userspace,
+ * while all the locks and object references (inode and file) held
+ * during the operation are released.
+ *
+ * To release the locks is exactly why there's a need to interrupt the
+ * request, so there's not a lot that can be done about this, except
+ * introduce additional locking in userspace.
+ *
+ * More important is to keep inode and file references until userspace
+ * has replied, otherwise FORGET and RELEASE could be sent while the
+ * inode/file is still used by the filesystem.
+ *
+ * For this reason the concept of "background" request is introduced.
+ * An interrupted request is backgrounded if it has been already sent
+ * to userspace.  Backgrounding involves getting an extra reference to
+ * inode(s) or file used in the request, and adding the request to
+ * fc->background list.  When a reply is received for a background
+ * request, the object references are released, and the request is
+ * removed from the list.  If the filesystem is unmounted while there
+ * are still background requests, the list is walked and references
+ * are released as if a reply was received.
+ *
+ * There's one more use for a background request.  The RELEASE message is
+ * always sent as background, since it doesn't return an error or
+ * data.
+ */
 static void background_request(struct fuse_conn *fc, struct fuse_req *req)
 {
-	/* Need to get hold of the inode(s) and/or file used in the
-	   request, so FORGET and RELEASE are not sent too early */
 	req->background = 1;
 	list_add(&req->bg_entry, &fc->background);
 	if (req->inode)
@@ -233,7 +276,7 @@ static void request_wait_answer(struct f
 	if (req->locked) {
 		/* This is uninterruptible sleep, because data is
 		   being copied to/from the buffers of req.  During
-		   locked state, there musn't be any filesystem
+		   locked state, there mustn't be any filesystem
 		   operation (e.g. page fault), since that could lead
 		   to deadlock */
 		spin_unlock(&fuse_lock);
@@ -268,7 +311,12 @@ static void queue_request(struct fuse_co
 	req->in.h.len = sizeof(struct fuse_in_header) +
 		len_args(req->in.numargs, (struct fuse_arg *) req->in.args);
 	if (!req->preallocated) {
-		/* decrease outstanding_sem, but without blocking... */
+		/* If request is not preallocated (either FORGET or
+		   RELEASE), then still decrease outstanding_sem, so
+		   user can't open infinite number of files while not
+		   processing the RELEASE requests.  However for
+		   efficiency do it without blocking, so if down()
+		   would block, just increase the debt instead */
 		if (down_trylock(&fc->outstanding_sem))
 			fc->outstanding_debt++;
 	}
@@ -298,6 +346,11 @@ void request_send(struct fuse_conn *fc, 
 	request_send_wait(fc, req, 1);
 }
 
+/*
+ * Non-interruptible version of the above function is for operations
+ * which can't legally return -ERESTART{SYS,NOINTR}.  This can still
+ * be interrupted but only with SIGKILL.
+ */
 void request_send_nonint(struct fuse_conn *fc, struct fuse_req *req)
 {
 	request_send_wait(fc, req, 0);
@@ -348,6 +401,11 @@ void fuse_send_init(struct fuse_conn *fc
 	request_send_background(fc, req);
 }
 
+/*
+ * Lock the request.  Up to the next unlock_request() there mustn't be
+ * anything that could cause a page-fault.  If the request was already
+ * interrupted bail out.
+ */
 static inline int lock_request(struct fuse_req *req)
 {
 	int err = 0;
@@ -362,6 +420,11 @@ static inline int lock_request(struct fu
 	return err;
 }
 
+/*
+ * Unlock request.  If it was interrupted during being locked, the
+ * requester thread is currently waiting for it to be unlocked, so
+ * wake it up.
+ */
 static inline void unlock_request(struct fuse_req *req)
 {
 	if (req) {
@@ -373,15 +436,6 @@ static inline void unlock_request(struct
 	}
 }
 
-/* Why all this complex one-page-at-a-time copying needed instead of
-   just copy_to/from_user()?  The reason is that blocking on a page
-   fault must be avoided while the request is locked.  This is because
-   if servicing that pagefault happens to be done by this filesystem,
-   an unbreakable deadlock can occur.  So the code is careful to allow
-   request interruption during get_user_pages(), and only lock the
-   request while doing kmapped copying, which cannot block.
- */
-
 struct fuse_copy_state {
 	int write;
 	struct fuse_req *req;
@@ -406,6 +460,7 @@ static void fuse_copy_init(struct fuse_c
 	cs->nr_segs = nr_segs;
 }
 
+/* Unmap and put previous page of userspace buffer */
 static inline void fuse_copy_finish(struct fuse_copy_state *cs)
 {
 	if (cs->mapaddr) {
@@ -419,6 +474,10 @@ static inline void fuse_copy_finish(stru
 	}
 }
 
+/*
+ * Get another pagefull of userspace buffer, and map it to kernel
+ * address space, and lock request
+ */
 static int fuse_copy_fill(struct fuse_copy_state *cs)
 {
 	unsigned long offset;
@@ -450,6 +509,7 @@ static int fuse_copy_fill(struct fuse_co
 	return lock_request(cs->req);
 }
 
+/* Do as much copy to/from userspace buffer as we can */
 static inline int fuse_copy_do(struct fuse_copy_state *cs, void **val,
 			       unsigned *size)
 {
@@ -467,6 +527,10 @@ static inline int fuse_copy_do(struct fu
 	return ncpy;
 }
 
+/*
+ * Copy a page in the request to/from the userspace buffer.  Must be
+ * done atomically
+ */
 static inline int fuse_copy_page(struct fuse_copy_state *cs, struct page *page,
 				 unsigned offset, unsigned count, int zeroing)
 {
@@ -492,6 +556,7 @@ static inline int fuse_copy_page(struct 
 	return 0;
 }
 
+/* Copy pages in the request to/from userspace buffer */
 static int fuse_copy_pages(struct fuse_copy_state *cs, unsigned nbytes,
 			   int zeroing)
 {
@@ -513,6 +578,7 @@ static int fuse_copy_pages(struct fuse_c
 	return 0;
 }
 
+/* Copy a single argument in the request to/from userspace buffer */
 static int fuse_copy_one(struct fuse_copy_state *cs, void *val, unsigned size)
 {
 	while (size) {
@@ -524,6 +590,7 @@ static int fuse_copy_one(struct fuse_cop
 	return 0;
 }
 
+/* Copy request arguments to/from userspace buffer */
 static int fuse_copy_args(struct fuse_copy_state *cs, unsigned numargs,
 			  unsigned argpages, struct fuse_arg *args,
 			  int zeroing)
@@ -541,6 +608,7 @@ static int fuse_copy_args(struct fuse_co
 	return err;
 }
 
+/* Wait until a request is available on the pending list */
 static void request_wait(struct fuse_conn *fc)
 {
 	DECLARE_WAITQUEUE(wait, current);
@@ -559,6 +627,15 @@ static void request_wait(struct fuse_con
 	remove_wait_queue(&fc->waitq, &wait);
 }
 
+/*
+ * Read a single request into the userspace filesystem's buffer.  This
+ * function waits until a request is available, then removes it from
+ * the pending list and copies request data to userspace buffer.  If
+ * no reply is needed (FORGET) or request has been interrupted or
+ * there was an error during the copying then it's finished by calling
+ * request_end().  Otherwise add it to the processing list, and set
+ * the 'sent' flag.
+ */
 static ssize_t fuse_dev_readv(struct file *file, const struct iovec *iov,
 			      unsigned long nr_segs, loff_t *off)
 {
@@ -631,6 +708,7 @@ static ssize_t fuse_dev_read(struct file
 	return fuse_dev_readv(file, &iov, 1, off);
 }
 
+/* Look up request on processing list by unique ID */
 static struct fuse_req *request_find(struct fuse_conn *fc, unsigned unique)
 {
 	struct list_head *entry;
@@ -667,6 +745,13 @@ static int copy_out_args(struct fuse_cop
 			      out->page_zeroing);
 }
 
+/*
+ * Write a single reply to a request.  First the header is copied from
+ * the write buffer.  The request is then searched on the processing
+ * list by the unique ID found in the header.  If found, then remove
+ * it from the list and copy the rest of the buffer to the request.
+ * The request is finished by calling request_end()
+ */
 static ssize_t fuse_dev_writev(struct file *file, const struct iovec *iov,
 			       unsigned long nr_segs, loff_t *off)
 {
@@ -756,6 +841,7 @@ static unsigned fuse_dev_poll(struct fil
 	return mask;
 }
 
+/* Abort all requests on the given list (pending or processing) */
 static void end_requests(struct fuse_conn *fc, struct list_head *head)
 {
 	while (!list_empty(head)) {
