Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261729AbSIXRaB>; Tue, 24 Sep 2002 13:30:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261728AbSIXR2s>; Tue, 24 Sep 2002 13:28:48 -0400
Received: from d12lmsgate-3.de.ibm.com ([195.212.91.201]:54684 "EHLO
	d12lmsgate-3.de.ibm.com") by vger.kernel.org with ESMTP
	id <S261731AbSIXRWp> convert rfc822-to-8bit; Tue, 24 Sep 2002 13:22:45 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Organization: IBM Deutschland GmbH
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: [PATCH] 2.5.38 s390 fixes: 20_ending.
Date: Tue, 24 Sep 2002 19:23:22 +0200
X-Mailer: KMail [version 1.4]
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200209241923.22089.schwidefsky@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Cleanup s390_process_IRQ a little, the ending_status argument is never
really used.

diff -urN linux-2.5.38/drivers/s390/cio/cio.c linux-2.5.38-s390/drivers/s390/cio/cio.c
--- linux-2.5.38/drivers/s390/cio/cio.c	Tue Sep 24 17:43:45 2002
+++ linux-2.5.38-s390/drivers/s390/cio/cio.c	Tue Sep 24 17:43:45 2002
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

