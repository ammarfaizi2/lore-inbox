Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964952AbWFNOGp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964952AbWFNOGp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jun 2006 10:06:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964957AbWFNOGo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jun 2006 10:06:44 -0400
Received: from mtagate1.de.ibm.com ([195.212.29.150]:54555 "EHLO
	mtagate1.de.ibm.com") by vger.kernel.org with ESMTP id S964955AbWFNOGn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jun 2006 10:06:43 -0400
Date: Wed, 14 Jun 2006 16:02:44 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: linux-kernel@vger.kernel.org, horst.hummel@de.ibm.com
Subject: [patch 12/24] s390: dasd_eckd_dump_sense bug.
Message-ID: <20060614140244.GM9475@skybase>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Horst Hummel <horst.hummel@de.ibm.com>

[S390] dasd_eckd_dump_sense bug.

The ccw dump function dasd_eckd_dump_ccw_range can crash because
it does not take care about the IDAL flag in the ccw.
Check for IDALs flag set in CCW and follow the indirect list to
print the data that is refered by the ccw.

Signed-off-by: Horst Hummel <horst.hummel@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/block/dasd_eckd.c |  147 ++++++++++++++++++++---------------------
 1 files changed, 75 insertions(+), 72 deletions(-)

diff -urpN linux-2.6/drivers/s390/block/dasd_eckd.c linux-2.6-patched/drivers/s390/block/dasd_eckd.c
--- linux-2.6/drivers/s390/block/dasd_eckd.c	2006-06-14 14:29:18.000000000 +0200
+++ linux-2.6-patched/drivers/s390/block/dasd_eckd.c	2006-06-14 14:29:47.000000000 +0200
@@ -1522,6 +1522,40 @@ dasd_eckd_ioctl(struct dasd_device *devi
 }
 
 /*
+ * Dump the range of CCWs into 'page' buffer
+ * and return number of printed chars.
+ */
+static inline int
+dasd_eckd_dump_ccw_range(struct ccw1 *from, struct ccw1 *to, char *page)
+{
+	int len, count;
+	char *datap;
+
+	len = 0;
+	while (from <= to) {
+		len += sprintf(page + len, KERN_ERR PRINTK_HEADER
+			       " CCW %p: %08X %08X DAT:",
+			       from, ((int *) from)[0], ((int *) from)[1]);
+
+		/* get pointer to data (consider IDALs) */
+		if (from->flags & CCW_FLAG_IDA)
+			datap = (char *) *((addr_t *) (addr_t) from->cda);
+		else
+			datap = (char *) ((addr_t) from->cda);
+
+		/* dump data (max 32 bytes) */
+		for (count = 0; count < from->count && count < 32; count++) {
+			if (count % 8 == 0) len += sprintf(page + len, " ");
+			if (count % 4 == 0) len += sprintf(page + len, " ");
+			len += sprintf(page + len, "%02x", datap[count]);
+		}
+		len += sprintf(page + len, "\n");
+		from++;
+	}
+	return len;
+}
+
+/*
  * Print sense data and related channel program.
  * Parts are printed because printk buffer is only 1024 bytes.
  */
@@ -1530,8 +1564,8 @@ dasd_eckd_dump_sense(struct dasd_device 
 		     struct irb *irb)
 {
 	char *page;
-	struct ccw1 *act, *end, *last;
-	int len, sl, sct, count;
+	struct ccw1 *first, *last, *fail, *from, *to;
+	int len, sl, sct;
 
 	page = (char *) get_zeroed_page(GFP_ATOMIC);
 	if (page == NULL) {
@@ -1539,7 +1573,8 @@ dasd_eckd_dump_sense(struct dasd_device 
 			    "No memory to dump sense data");
 		return;
 	}
-	len = sprintf(page, KERN_ERR PRINTK_HEADER
+	/* dump the sense data */
+	len = sprintf(page,  KERN_ERR PRINTK_HEADER
 		      " I/O status report for device %s:\n",
 		      device->cdev->dev.bus_id);
 	len += sprintf(page + len, KERN_ERR PRINTK_HEADER
@@ -1564,87 +1599,55 @@ dasd_eckd_dump_sense(struct dasd_device 
 
 		if (irb->ecw[27] & DASD_SENSE_BIT_0) {
 			/* 24 Byte Sense Data */
-			len += sprintf(page + len, KERN_ERR PRINTK_HEADER
-				       " 24 Byte: %x MSG %x, "
-				       "%s MSGb to SYSOP\n",
-				       irb->ecw[7] >> 4, irb->ecw[7] & 0x0f,
-				       irb->ecw[1] & 0x10 ? "" : "no");
+			sprintf(page + len, KERN_ERR PRINTK_HEADER
+				" 24 Byte: %x MSG %x, "
+				"%s MSGb to SYSOP\n",
+				irb->ecw[7] >> 4, irb->ecw[7] & 0x0f,
+				irb->ecw[1] & 0x10 ? "" : "no");
 		} else {
 			/* 32 Byte Sense Data */
-			len += sprintf(page + len, KERN_ERR PRINTK_HEADER
-				       " 32 Byte: Format: %x "
-				       "Exception class %x\n",
-				       irb->ecw[6] & 0x0f, irb->ecw[22] >> 4);
+			sprintf(page + len, KERN_ERR PRINTK_HEADER
+				" 32 Byte: Format: %x "
+				"Exception class %x\n",
+				irb->ecw[6] & 0x0f, irb->ecw[22] >> 4);
 		}
 	} else {
-	        len += sprintf(page + len, KERN_ERR PRINTK_HEADER
-			       " SORRY - NO VALID SENSE AVAILABLE\n");
+		sprintf(page + len, KERN_ERR PRINTK_HEADER
+			" SORRY - NO VALID SENSE AVAILABLE\n");
 	}
-	MESSAGE_LOG(KERN_ERR, "%s",
-		    page + sizeof(KERN_ERR PRINTK_HEADER));
+	printk("%s", page);
 
-	/* dump the Channel Program */
-	/* print first CCWs (maximum 8) */
-	act = req->cpaddr;
-        for (last = act; last->flags & (CCW_FLAG_CC | CCW_FLAG_DC); last++);
-	end = min(act + 8, last);
-	len = sprintf(page, KERN_ERR PRINTK_HEADER
+	/* dump the Channel Program (max 140 Bytes per line) */
+	/* Count CCW and print first CCWs (maximum 1024 % 140 = 7) */
+	first = req->cpaddr;
+	for (last = first; last->flags & (CCW_FLAG_CC | CCW_FLAG_DC); last++);
+	to = min(first + 6, last);
+	len = sprintf(page,  KERN_ERR PRINTK_HEADER
 		      " Related CP in req: %p\n", req);
-	while (act <= end) {
-		len += sprintf(page + len, KERN_ERR PRINTK_HEADER
-			       " CCW %p: %08X %08X DAT:",
-			       act, ((int *) act)[0], ((int *) act)[1]);
-		for (count = 0; count < 32 && count < act->count;
-		     count += sizeof(int))
-			len += sprintf(page + len, " %08X",
-				       ((int *) (addr_t) act->cda)
-				       [(count>>2)]);
-		len += sprintf(page + len, "\n");
-		act++;
-	}
-	MESSAGE_LOG(KERN_ERR, "%s",
-		    page + sizeof(KERN_ERR PRINTK_HEADER));
+	dasd_eckd_dump_ccw_range(first, to, page + len);
+	printk("%s", page);
 
-	/* print failing CCW area */
+	/* print failing CCW area (maximum 4) */
+	/* scsw->cda is either valid or zero  */
 	len = 0;
-	if (act <  ((struct ccw1 *)(addr_t) irb->scsw.cpa) - 2) {
-		act = ((struct ccw1 *)(addr_t) irb->scsw.cpa) - 2;
+	from = ++to;
+	fail = (struct ccw1 *)(addr_t) irb->scsw.cpa; /* failing CCW */
+	if (from <  fail - 2) {
+		from = fail - 2;     /* there is a gap - print header */
+		len += sprintf(page, KERN_ERR PRINTK_HEADER "......\n");
+	}
+	to = min(fail + 1, last);
+	len += dasd_eckd_dump_ccw_range(from, to, page + len);
+
+	/* print last CCWs (maximum 2) */
+	from = max(from, ++to);
+	if (from < last - 1) {
+		from = last - 1;     /* there is a gap - print header */
 		len += sprintf(page + len, KERN_ERR PRINTK_HEADER "......\n");
 	}
-	end = min((struct ccw1 *)(addr_t) irb->scsw.cpa + 2, last);
-	while (act <= end) {
-		len += sprintf(page + len, KERN_ERR PRINTK_HEADER
-			       " CCW %p: %08X %08X DAT:",
-			       act, ((int *) act)[0], ((int *) act)[1]);
-		for (count = 0; count < 32 && count < act->count;
-		     count += sizeof(int))
-			len += sprintf(page + len, " %08X",
-				       ((int *) (addr_t) act->cda)
-				       [(count>>2)]);
-		len += sprintf(page + len, "\n");
-		act++;
-	}
-
-	/* print last CCWs */
-	if (act <  last - 2) {
-		act = last - 2;
-		len += sprintf(page + len, KERN_ERR PRINTK_HEADER "......\n");
-	}
-	while (act <= last) {
-		len += sprintf(page + len, KERN_ERR PRINTK_HEADER
-			       " CCW %p: %08X %08X DAT:",
-			       act, ((int *) act)[0], ((int *) act)[1]);
-		for (count = 0; count < 32 && count < act->count;
-		     count += sizeof(int))
-			len += sprintf(page + len, " %08X",
-				       ((int *) (addr_t) act->cda)
-				       [(count>>2)]);
-		len += sprintf(page + len, "\n");
-		act++;
-	}
+	len += dasd_eckd_dump_ccw_range(from, last, page + len);
 	if (len > 0)
-		MESSAGE_LOG(KERN_ERR, "%s",
-			    page + sizeof(KERN_ERR PRINTK_HEADER));
+		printk("%s", page);
 	free_page((unsigned long) page);
 }
 
