Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269424AbUJLAZg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269424AbUJLAZg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Oct 2004 20:25:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269415AbUJLAX5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Oct 2004 20:23:57 -0400
Received: from host157-148.pool8289.interbusiness.it ([82.89.148.157]:26243
	"EHLO zion.localdomain") by vger.kernel.org with ESMTP
	id S269402AbUJLATJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Oct 2004 20:19:09 -0400
Subject: [patch 09/10] uml: fix ubd deadlock on SMP
To: akpm@osdl.org
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net, blaisorblade_spam@yahoo.it,
       chrisw@osdl.org
From: blaisorblade_spam@yahoo.it
Date: Tue, 12 Oct 2004 02:18:03 +0200
Message-Id: <20041012001803.E2A9B8699@zion.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: BlaisorBlade <blaisorblade_spam@yahoo.it>, Chris Wright <chrisw@osdl.org>

Avoid deadlocking onto the request lock in the UBD driver, i.e. don't lock the
queue spinlock when called from the request function.

In detail:
Rename ubd_finish() to __ubd_finish() and remove ubd_io_lock from it.
Add wrapper, ubd_finish(), which grabs lock before calling __ubd_finish().
Update do_ubd_request to use the lock free __ubd_finish() to avoid
deadlock.  Also, apparently prepare_request is called with ubd_io_lock
held, so remove locks there.

Signed-off-by: Chris Wright <chrisw@osdl.org>
Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade_spam@yahoo.it>
---

 linux-2.6.9-current-paolo/arch/um/drivers/ubd_kern.c |   19 ++++++++++++-------
 1 files changed, 12 insertions(+), 7 deletions(-)

diff -puN arch/um/drivers/ubd_kern.c~uml-ubd-deadlock-revised arch/um/drivers/ubd_kern.c
--- linux-2.6.9-current/arch/um/drivers/ubd_kern.c~uml-ubd-deadlock-revised	2004-10-12 01:22:16.360058936 +0200
+++ linux-2.6.9-current-paolo/arch/um/drivers/ubd_kern.c	2004-10-12 01:52:22.521480664 +0200
@@ -396,14 +396,13 @@ int thread_fd = -1;
  */
 int intr_count = 0;
 
-static void ubd_finish(struct request *req, int error)
+/* call ubd_finish if you need to serialize */
+static void __ubd_finish(struct request *req, int error)
 {
 	int nsect;
 
 	if(error){
- 		spin_lock(&ubd_io_lock);
 		end_request(req, 0);
- 		spin_unlock(&ubd_io_lock);
 		return;
 	}
 	nsect = req->current_nr_sectors;
@@ -412,11 +411,17 @@ static void ubd_finish(struct request *r
 	req->errors = 0;
 	req->nr_sectors -= nsect;
 	req->current_nr_sectors = 0;
-	spin_lock(&ubd_io_lock);
 	end_request(req, 1);
+}
+
+static inline void ubd_finish(struct request *req, int error)
+{
+ 	spin_lock(&ubd_io_lock);
+	__ubd_finish(req, error);
 	spin_unlock(&ubd_io_lock);
 }
 
+/* Called without ubd_io_lock held */
 static void ubd_handler(void)
 {
 	struct io_thread_req req;
@@ -965,6 +970,7 @@ static int prepare_mmap_request(struct u
 	return(0);
 }
 
+/* Called with ubd_io_lock held */
 static int prepare_request(struct request *req, struct io_thread_req *io_req)
 {
 	struct gendisk *disk = req->rq_disk;
@@ -977,9 +983,7 @@ static int prepare_request(struct reques
 	if((rq_data_dir(req) == WRITE) && !dev->openflags.w){
 		printk("Write attempted on readonly ubd device %s\n", 
 		       disk->disk_name);
- 		spin_lock(&ubd_io_lock);
 		end_request(req, 0);
- 		spin_unlock(&ubd_io_lock);
 		return(1);
 	}
 
@@ -1029,6 +1033,7 @@ static int prepare_request(struct reques
 	return(0);
 }
 
+/* Called with ubd_io_lock held */
 static void do_ubd_request(request_queue_t *q)
 {
 	struct io_thread_req io_req;
@@ -1040,7 +1045,7 @@ static void do_ubd_request(request_queue
 			err = prepare_request(req, &io_req);
 			if(!err){
 				do_io(&io_req);
-				ubd_finish(req, io_req.error);
+				__ubd_finish(req, io_req.error);
 			}
 		}
 	}
_
