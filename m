Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266775AbUIITj3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266775AbUIITj3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 15:39:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264502AbUIITid
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 15:38:33 -0400
Received: from fw.osdl.org ([65.172.181.6]:42124 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266854AbUIIT3N (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 15:29:13 -0400
Date: Thu, 9 Sep 2004 12:29:06 -0700
From: Chris Wright <chrisw@osdl.org>
To: BlaisorBlade <blaisorblade_spam@yahoo.it>
Cc: Chris Wright <chrisw@osdl.org>,
       user-mode-linux-devel@lists.sourceforge.net, akpm@osdl.org,
       jdike@addtoit.com, linux-kernel@vger.kernel.org
Subject: Re: [uml-devel] Re: [patch 1/1] uml:fix ubd deadlock on SMP
Message-ID: <20040909122906.N1973@build.pdx.osdl.net>
References: <20040908172503.384144933@zion.localdomain> <200409092002.19134.blaisorblade_spam@yahoo.it> <20040909113228.M1973@build.pdx.osdl.net> <200409092044.54512.blaisorblade_spam@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200409092044.54512.blaisorblade_spam@yahoo.it>; from blaisorblade_spam@yahoo.it on Thu, Sep 09, 2004 at 08:44:54PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* BlaisorBlade (blaisorblade_spam@yahoo.it) wrote:
> Yes, thanks a lot for your help.

Rename ubd_finish() to __ubd_finsh() and remove ubd_io_lock from it.
Add wrapper, ubd_finish(), which grabs lock before calling __ubd_finish().
Update do_ubd_request to use the lock free __ubd_finish() to avoid
deadlock.  Also, apparently prepare_request is called with ubd_io_lock
held, so remove locks there.

Signed-off-by: Chris Wright <chrisw@osdl.org>

===== arch/um/drivers/ubd_kern.c 1.38 vs edited =====
--- 1.38/arch/um/drivers/ubd_kern.c	2004-09-07 23:33:13 -07:00
+++ edited/arch/um/drivers/ubd_kern.c	2004-09-09 12:18:01 -07:00
@@ -396,14 +396,20 @@
  */
 int intr_count = 0;
 
-static void ubd_finish(struct request *req, int error)
+static inline void ubd_finish(struct request *req, int error)
+{
+ 	spin_lock(&ubd_io_lock);
+	__ubd_finish(req, error);
+	spin_unlock(&ubd_io_lock);
+}
+
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
@@ -412,11 +418,10 @@
 	req->errors = 0;
 	req->nr_sectors -= nsect;
 	req->current_nr_sectors = 0;
-	spin_lock(&ubd_io_lock);
 	end_request(req, 1);
-	spin_unlock(&ubd_io_lock);
 }
 
+/* Called without ubd_io_lock held */
 static void ubd_handler(void)
 {
 	struct io_thread_req req;
@@ -965,6 +970,7 @@
 	return(0);
 }
 
+/* Called with ubd_io_lock held */
 static int prepare_request(struct request *req, struct io_thread_req *io_req)
 {
 	struct gendisk *disk = req->rq_disk;
@@ -977,9 +983,7 @@
 	if((rq_data_dir(req) == WRITE) && !dev->openflags.w){
 		printk("Write attempted on readonly ubd device %s\n", 
 		       disk->disk_name);
- 		spin_lock(&ubd_io_lock);
 		end_request(req, 0);
- 		spin_unlock(&ubd_io_lock);
 		return(1);
 	}
 
@@ -1029,6 +1033,7 @@
 	return(0);
 }
 
+/* Called with ubd_io_lock held */
 static void do_ubd_request(request_queue_t *q)
 {
 	struct io_thread_req io_req;
@@ -1040,7 +1045,7 @@
 			err = prepare_request(req, &io_req);
 			if(!err){
 				do_io(&io_req);
-				ubd_finish(req, io_req.error);
+				__ubd_finish(req, io_req.error);
 			}
 		}
 	}
