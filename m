Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262083AbSI3OS6>; Mon, 30 Sep 2002 10:18:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262085AbSI3OSh>; Mon, 30 Sep 2002 10:18:37 -0400
Received: from d06lmsgate-5.uk.ibm.com ([195.212.29.5]:60878 "EHLO
	d06lmsgate-5.uk.ibm.com") by vger.kernel.org with ESMTP
	id <S262083AbSI3NoC> convert rfc822-to-8bit; Mon, 30 Sep 2002 09:44:02 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Organization: IBM Deutschland GmbH
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: [PATCH] 2.5.39 s390 (22/26): s390_process_IRQ.
Date: Mon, 30 Sep 2002 15:04:06 +0200
X-Mailer: KMail [version 1.4]
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200209301504.06810.schwidefsky@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Cleanup s390_process_IRQ a little, the ending_status argument is never
really used.

diff -urN linux-2.5.39/drivers/s390/cio/cio.c linux-2.5.39-s390/drivers/s390/cio/cio.c
--- linux-2.5.39/drivers/s390/cio/cio.c	Mon Sep 30 13:33:37 2002
+++ linux-2.5.39-s390/drivers/s390/cio/cio.c	Mon Sep 30 13:33:37 2002
@@ -1065,9 +1065,9 @@
  * for cc=0 and cc=1 after tsch
  */
 static inline int
-s390_process_IRQ_normal(unsigned int irq,
-			int ending_status)
+s390_process_IRQ_normal(unsigned int irq)
 {
+	int ending_status;
 	unsigned int fctl;	/* function control */
 	unsigned int stctl;	/* status   control */
 	unsigned int actl;	/* activity control */
@@ -1315,8 +1315,7 @@
  * for cc=3 after tsch
  */
 static inline int
-s390_process_IRQ_notoper(unsigned int irq,
-			 int ending_status)
+s390_process_IRQ_notoper(unsigned int irq)
 {
 	devstat_t *dp;
 	devstat_t *udp;
@@ -1379,7 +1378,7 @@
 	 * take fast exit if no handler is available
 	 */
 	if (!ioinfo[irq]->ui.flags.ready)
-		return (ending_status);
+		return 0;
 	
 	memcpy (udp, &(ioinfo[irq]->devstat), 
 		sizeof(devstat_t) - 
@@ -1417,7 +1416,6 @@
 	int irb_cc;		/* cond code from irb */
 
 	int issense = 0;
-	int ending_status = 0;
 	devstat_t *dp;
 	devstat_t *udp;
 	scsw_t *scsw;
@@ -1610,25 +1608,14 @@
 
 	switch (irb_cc) {
 	case 1:		/* status pending */
-
 		dp->flag |= DEVSTAT_STATUS_PENDING;
 
 	case 0:		/* normal i/o interruption */
+		return s390_process_IRQ_normal(irq);
 
-		ending_status = s390_process_IRQ_normal(irq, ending_status);
-
-
-		break;
-
-	case 3:		/* device/path not operational */
-
-		ending_status = s390_process_IRQ_notoper(irq, ending_status); 
-
-		break;
-
+	default:	/* device/path not operational */
+		return s390_process_IRQ_notoper(irq);
 	}
-
-	return (ending_status);
 }
 
 /*

