Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262060AbUD1UWL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262060AbUD1UWL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Apr 2004 16:22:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262052AbUD1UTt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Apr 2004 16:19:49 -0400
Received: from outmx001.isp.belgacom.be ([195.238.3.51]:31953 "EHLO
	outmx001.isp.belgacom.be") by vger.kernel.org with ESMTP
	id S262045AbUD1USz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Apr 2004 16:18:55 -0400
Subject: [PATCH 2.6.6-rc3] as-io isolation ?
From: FabF <Fabian.Frederick@skynet.be>
To: lkml <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="=-g+0cANcq5QByI0zr8aK2"
Message-Id: <1083183861.4618.13.camel@bluerhyme.real3>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 28 Apr 2004 22:24:21 +0200
X-RAVMilter-Version: 8.4.3(snapshot 20030212) (outmx001.isp.belgacom.be)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-g+0cANcq5QByI0zr8aK2
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi,

	Here's a patch _idea_ to isolate anticipatory I/O from normal I/O
scheduler process by adding a specific put io context method so that
ll_rw_blk stuff could be as-iosched transparent.I guess we could point
as iosched exit instead of exit_io_context as well ...

Regards,
FabF

--=-g+0cANcq5QByI0zr8aK2
Content-Disposition: attachment; filename=asiocontext1.diff
Content-Type: text/x-patch; name=asiocontext1.diff; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

diff -Naur orig/drivers/block/as-iosched.c edited/drivers/block/as-iosched.c
--- orig/drivers/block/as-iosched.c	2004-04-04 05:36:13.000000000 +0200
+++ edited/drivers/block/as-iosched.c	2004-04-28 22:05:21.000000000 +0200
@@ -222,6 +222,16 @@
 	return ret;
 }
 
+void as_put_io_context(struct io_context *ioc)
+{
+	if (ioc == NULL)
+		return;
+        if (ioc->aic && ioc->aic->dtor)
+        	ioc->aic->dtor(ioc->aic);
+	put_io_context(ioc);
+	
+}
+
 /*
  * If the current task has no AS IO context then create one and initialise it.
  * Then take a ref on the task's io context and return it.
@@ -231,10 +241,8 @@
 	struct io_context *ioc = get_io_context(GFP_ATOMIC);
 	if (ioc && !ioc->aic) {
 		ioc->aic = alloc_as_io_context();
-		if (!ioc->aic) {
-			put_io_context(ioc);
-			ioc = NULL;
-		}
+		if (!ioc->aic) 
+			as_put_io_context(ioc);
 	}
 	return ioc;
 }
@@ -1015,7 +1023,7 @@
 		}
 	}
 
-	put_io_context(arq->io_context);
+	as_put_io_context(arq->io_context);
 out:
 	arq->state = AS_RQ_POSTSCHED;
 }
@@ -1183,10 +1191,8 @@
 		/* In case we have to anticipate after this */
 		copy_io_context(&ad->io_context, &arq->io_context);
 	} else {
-		if (ad->io_context) {
-			put_io_context(ad->io_context);
-			ad->io_context = NULL;
-		}
+		if (ad->io_context) 
+			as_put_io_context(ad->io_context);
 
 		if (ad->current_write_count != 0)
 			ad->current_write_count--;
@@ -1837,7 +1843,7 @@
 	BUG_ON(!list_empty(&ad->fifo_list[REQ_ASYNC]));
 
 	mempool_destroy(ad->arq_pool);
-	put_io_context(ad->io_context);
+	as_put_io_context(ad->io_context);
 	kfree(ad->hash);
 	kfree(ad);
 }
diff -Naur orig/drivers/block/ll_rw_blk.c edited/drivers/block/ll_rw_blk.c
--- orig/drivers/block/ll_rw_blk.c	2004-04-28 19:13:23.000000000 +0200
+++ edited/drivers/block/ll_rw_blk.c	2004-04-28 22:06:35.000000000 +0200
@@ -2844,13 +2844,12 @@
 	BUG_ON(atomic_read(&ioc->refcount) == 0);
 
 	if (atomic_dec_and_test(&ioc->refcount)) {
-		if (ioc->aic && ioc->aic->dtor)
-			ioc->aic->dtor(ioc->aic);
 		kfree(ioc);
+		ioc=NULL;
 	}
 }
 
-/* Called by the exitting task */
+/* Called by the exiting task */
 void exit_io_context(void)
 {
 	unsigned long flags;
@@ -2859,10 +2858,10 @@
 	local_irq_save(flags);
 	ioc = current->io_context;
 	if (ioc) {
-		if (ioc->aic && ioc->aic->exit)
+		if (ioc->aic && ioc->aic->exit){
 			ioc->aic->exit(ioc->aic);
-		put_io_context(ioc);
-		current->io_context = NULL;
+			as_put_io_context(ioc);
+		}
 	} else
 		WARN_ON(1);
 	local_irq_restore(flags);

--=-g+0cANcq5QByI0zr8aK2--

