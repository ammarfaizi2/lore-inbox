Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751351AbWINWFJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751351AbWINWFJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Sep 2006 18:05:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751352AbWINWFJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Sep 2006 18:05:09 -0400
Received: from stat9.steeleye.com ([209.192.50.41]:47850 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S1751351AbWINWFH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Sep 2006 18:05:07 -0400
Subject: Re: [GIT PATCH] (hopefully) final SCSI fixes for 2.6.19
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Alex Davis <alex14641@yahoo.com>, Linus Torvalds <torvalds@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       linux-scsi <linux-scsi@vger.kernel.org>
In-Reply-To: <20060914144703.ade9b00b.akpm@osdl.org>
References: <1158268378.3514.61.camel@mulgrave.il.steeleye.com>
	 <20060914142044.4272fc56.akpm@osdl.org>
	 <1158269859.3514.74.camel@mulgrave.il.steeleye.com>
	 <20060914144703.ade9b00b.akpm@osdl.org>
Content-Type: text/plain
Date: Thu, 14 Sep 2006 17:04:58 -0500
Message-Id: <1158271498.3514.76.camel@mulgrave.il.steeleye.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-09-14 at 14:47 -0700, Andrew Morton wrote:
> <lachrymose>If we'd been told that on July 8 and/or August 14, this might
> be fixed by now</>

OK, so mea culpa, I'll make amends

> Perhaps Alex might like to take a look into doing this (please)?

Just test out this patch, please ...

James

diff --git a/drivers/scsi/aha152x.c b/drivers/scsi/aha152x.c
index f974869..7fd56b8 100644
--- a/drivers/scsi/aha152x.c
+++ b/drivers/scsi/aha152x.c
@@ -253,6 +253,7 @@ #include <linux/kernel.h>
 #include <linux/isapnp.h>
 #include <linux/spinlock.h>
 #include <linux/workqueue.h>
+#include <linux/list.h>
 #include <asm/semaphore.h>
 #include <scsi/scsicam.h>
 
@@ -262,6 +263,8 @@ #include <scsi/scsi_host.h>
 #include <scsi/scsi_transport_spi.h>
 #include "aha152x.h"
 
+static LIST_HEAD(aha152x_host_list);
+
 
 /* DEFINES */
 
@@ -423,8 +426,6 @@ #endif /* ISAPNP */
 
 #endif /* !PCMCIA */
 
-static int registered_count=0;
-static struct Scsi_Host *aha152x_host[2];
 static struct scsi_host_template aha152x_driver_template;
 
 /*
@@ -541,6 +542,7 @@ #endif
 #ifdef __ISAPNP__
 	struct pnp_dev *pnpdev;
 #endif
+	struct list_head host_list;
 };
 
 
@@ -755,20 +757,9 @@ static inline Scsi_Cmnd *remove_SC(Scsi_
 	return ptr;
 }
 
-static inline struct Scsi_Host *lookup_irq(int irqno)
-{
-	int i;
-
-	for(i=0; i<ARRAY_SIZE(aha152x_host); i++)
-		if(aha152x_host[i] && aha152x_host[i]->irq==irqno)
-			return aha152x_host[i];
-
-	return NULL;
-}
-
 static irqreturn_t swintr(int irqno, void *dev_id, struct pt_regs *regs)
 {
-	struct Scsi_Host *shpnt = lookup_irq(irqno);
+	struct Scsi_Host *shpnt = (struct Scsi_Host *)dev_id;
 
 	if (!shpnt) {
         	printk(KERN_ERR "aha152x: catched software interrupt %d for unknown controller.\n", irqno);
@@ -791,10 +782,11 @@ struct Scsi_Host *aha152x_probe_one(stru
 		return NULL;
 	}
 
-	/* need to have host registered before triggering any interrupt */
-	aha152x_host[registered_count] = shpnt;
-
 	memset(HOSTDATA(shpnt), 0, sizeof *HOSTDATA(shpnt));
+	INIT_LIST_HEAD(&HOSTDATA(shpnt)->host_list);
+
+	/* need to have host registered before triggering any interrupt */
+	list_add_tail(&HOSTDATA(shpnt)->host_list, &aha152x_host_list);
 
 	shpnt->io_port   = setup->io_port;
 	shpnt->n_io_port = IO_RANGE;
@@ -907,12 +899,10 @@ #endif
 
 	scsi_scan_host(shpnt);
 
-	registered_count++;
-
 	return shpnt;
 
 out_host_put:
-	aha152x_host[registered_count]=NULL;
+	list_del(&HOSTDATA(shpnt)->host_list);
 	scsi_host_put(shpnt);
 
 	return NULL;
@@ -937,6 +927,7 @@ #ifdef __ISAPNP__
 #endif
 
 	scsi_remove_host(shpnt);
+	list_del(&HOSTDATA(shpnt)->host_list);
 	scsi_host_put(shpnt);
 }
 
@@ -1459,9 +1450,12 @@ static struct work_struct aha152x_tq;
  */
 static void run(void)
 {
-	int i;
-	for (i = 0; i<ARRAY_SIZE(aha152x_host); i++) {
-		is_complete(aha152x_host[i]);
+	struct aha152x_hostdata *hd;
+
+	list_for_each_entry(hd, &aha152x_host_list, host_list) {
+		struct Scsi_Host *shost = container_of((void *)hd, struct Scsi_Host, hostdata);
+		
+		is_complete(shost);
 	}
 }
 
@@ -1471,7 +1465,7 @@ static void run(void)
  */
 static irqreturn_t intr(int irqno, void *dev_id, struct pt_regs *regs)
 {
-	struct Scsi_Host *shpnt = lookup_irq(irqno);
+	struct Scsi_Host *shpnt = (struct Scsi_Host *)dev_id;
 	unsigned long flags;
 	unsigned char rev, dmacntrl0;
 
@@ -3953,16 +3947,17 @@ #if defined(__ISAPNP__)
 #endif
 	}
 
-	return registered_count>0;
+	return 1;
 }
 
 static void __exit aha152x_exit(void)
 {
-	int i;
+	struct aha152x_hostdata *hd;
 
-	for(i=0; i<ARRAY_SIZE(setup); i++) {
-		aha152x_release(aha152x_host[i]);
-		aha152x_host[i]=NULL;
+	list_for_each_entry(hd, &aha152x_host_list, host_list) {
+		struct Scsi_Host *shost = container_of((void *)hd, struct Scsi_Host, hostdata);
+		
+		aha152x_release(shost);
 	}
 }
 


