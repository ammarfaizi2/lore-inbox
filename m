Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269256AbUIHR3w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269256AbUIHR3w (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Sep 2004 13:29:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269257AbUIHR3v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Sep 2004 13:29:51 -0400
Received: from mail-relay-3.tiscali.it ([213.205.33.43]:23787 "EHLO
	mail-relay-3.tiscali.it") by vger.kernel.org with ESMTP
	id S269256AbUIHR3k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Sep 2004 13:29:40 -0400
Subject: [patch 1/1] uml:fix ubd deadlock on SMP
To: akpm@osdl.org
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net, blaisorblade_spam@yahoo.it
From: blaisorblade_spam@yahoo.it
Date: Wed, 08 Sep 2004 19:25:02 +0200
Message-Id: <20040908172503.384144933@zion.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Trivial: don't lock the queue spinlock when called from the request function.
Since the faulty function must use spinlock in another case, double-case it.
And since we will never use both functions together, let no object code be
shared between them.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade_spam@yahoo.it>
---

 uml-linux-2.6.8.1-paolo/arch/um/drivers/ubd_kern.c |   36 ++++++++++++++++-----
 1 files changed, 28 insertions(+), 8 deletions(-)

diff -puN arch/um/drivers/ubd_kern.c~uml-fix-ubd-deadlock arch/um/drivers/ubd_kern.c
--- uml-linux-2.6.8.1/arch/um/drivers/ubd_kern.c~uml-fix-ubd-deadlock	2004-09-08 19:04:27.662926344 +0200
+++ uml-linux-2.6.8.1-paolo/arch/um/drivers/ubd_kern.c	2004-09-08 19:05:36.700431048 +0200
@@ -54,6 +54,7 @@
 #include "mem.h"
 #include "mem_kern.h"
 
+/*This is the queue lock. FIXME: make it per-UBD device.*/
 static spinlock_t ubd_io_lock = SPIN_LOCK_UNLOCKED;
 static spinlock_t ubd_lock = SPIN_LOCK_UNLOCKED;
 
@@ -396,14 +397,16 @@ int thread_fd = -1;
  */
 int intr_count = 0;
 
-static void ubd_finish(struct request *req, int error)
+static inline void __ubd_finish(struct request *req, int error, int lock)
 {
 	int nsect;
 
 	if(error){
- 		spin_lock(&ubd_io_lock);
+		if (lock)
+			spin_lock(&ubd_io_lock);
 		end_request(req, 0);
- 		spin_unlock(&ubd_io_lock);
+		if (lock)
+			spin_unlock(&ubd_io_lock);
 		return;
 	}
 	nsect = req->current_nr_sectors;
@@ -412,11 +415,28 @@ static void ubd_finish(struct request *r
 	req->errors = 0;
 	req->nr_sectors -= nsect;
 	req->current_nr_sectors = 0;
-	spin_lock(&ubd_io_lock);
+	if (lock)
+		spin_lock(&ubd_io_lock);
 	end_request(req, 1);
-	spin_unlock(&ubd_io_lock);
+	if (lock)
+		spin_unlock(&ubd_io_lock);
+}
+
+/* We will use only one of them, not both, i.e. ubd_finish with the io_thread
+ * and ubd_finish_nolock without the separate io thread, so it's better to waste
+ * some space to gain performance. */
+
+static void ubd_finish(struct request *req, int error)
+{
+	__ubd_finish(req, error, 1);
+}
+
+static void ubd_finish_nolock(struct request *req, int error)
+{
+	__ubd_finish(req, error, 0);
 }
 
+/*Called with ubd_io_lock not held*/
 static void ubd_handler(void)
 {
 	struct io_thread_req req;
@@ -965,6 +985,7 @@ static int prepare_mmap_request(struct u
 	return(0);
 }
 
+/*Called with ubd_io_lock held*/
 static int prepare_request(struct request *req, struct io_thread_req *io_req)
 {
 	struct gendisk *disk = req->rq_disk;
@@ -977,9 +998,7 @@ static int prepare_request(struct reques
 	if((rq_data_dir(req) == WRITE) && !dev->openflags.w){
 		printk("Write attempted on readonly ubd device %s\n", 
 		       disk->disk_name);
- 		spin_lock(&ubd_io_lock);
 		end_request(req, 0);
- 		spin_unlock(&ubd_io_lock);
 		return(1);
 	}
 
@@ -1029,6 +1048,7 @@ static int prepare_request(struct reques
 	return(0);
 }
 
+/*Called with ubd_io_lock held*/
 static void do_ubd_request(request_queue_t *q)
 {
 	struct io_thread_req io_req;
@@ -1040,7 +1060,7 @@ static void do_ubd_request(request_queue
 			err = prepare_request(req, &io_req);
 			if(!err){
 				do_io(&io_req);
-				ubd_finish(req, io_req.error);
+				ubd_finish_nolock(req, io_req.error);
 			}
 		}
 	}
_
