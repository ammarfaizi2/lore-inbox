Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267315AbUGNMRX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267315AbUGNMRX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jul 2004 08:17:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267367AbUGNMRX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jul 2004 08:17:23 -0400
Received: from aun.it.uu.se ([130.238.12.36]:31705 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S267253AbUGNMQ1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jul 2004 08:16:27 -0400
Date: Wed, 14 Jul 2004 14:16:17 +0200 (MEST)
Message-Id: <200407141216.i6ECGHxg008332@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: akpm@osdl.org
Subject: [PATCH][2.6.8-rc1-mm1] drivers/scsi/sg.c gcc341 inlining fix
Cc: dgilbert@interlog.com, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

gcc-3.4.1 errors out in 2.6.8-rc1-mm1 at drivers/scsi/sg.c:

drivers/scsi/sg.c: In function `sg_ioctl':
drivers/scsi/sg.c:209: sorry, unimplemented: inlining failed in call to 'sg_jif_to_ms': function body not available
drivers/scsi/sg.c:930: sorry, unimplemented: called from here
make[2]: *** [drivers/scsi/sg.o] Error 1
make[1]: *** [drivers/scsi] Error 2
make: *** [drivers] Error 2

sg_jif_to_ms() is marked inline but used defore its function
body is available. Moving it nearer the top of sg.c (together
with sg_ms_to_jif() for consistency) fixes the problem.

Signed-off-by: Mikael Pettersson <mikpe@csd.uu.se>

--- linux-2.6.8-rc1-mm1/drivers/scsi/sg.c.~1~	2004-07-14 12:58:34.000000000 +0200
+++ linux-2.6.8-rc1-mm1/drivers/scsi/sg.c	2004-07-14 13:45:26.000000000 +0200
@@ -225,6 +225,30 @@
 #define SZ_SG_REQ_INFO sizeof(sg_req_info_t)
 
 static int
+sg_ms_to_jif(unsigned int msecs)
+{
+	if ((UINT_MAX / 2U) < msecs)
+		return INT_MAX;	/* special case, set largest possible */
+	else
+		return ((int) msecs <
+			(INT_MAX / 1000)) ? (((int) msecs * HZ) / 1000)
+		    : (((int) msecs / 1000) * HZ);
+}
+
+static inline unsigned
+sg_jif_to_ms(int jifs)
+{
+	if (jifs <= 0)
+		return 0U;
+	else {
+		unsigned int j = (unsigned int) jifs;
+		return (j <
+			(UINT_MAX / 1000)) ? ((j * 1000) / HZ) : ((j / HZ) *
+								  1000);
+	}
+}
+
+static int
 sg_open(struct inode *inode, struct file *filp)
 {
 	int dev = iminor(inode);
@@ -2575,30 +2599,6 @@
 	free_pages((unsigned long) buff, order);
 }
 
-static int
-sg_ms_to_jif(unsigned int msecs)
-{
-	if ((UINT_MAX / 2U) < msecs)
-		return INT_MAX;	/* special case, set largest possible */
-	else
-		return ((int) msecs <
-			(INT_MAX / 1000)) ? (((int) msecs * HZ) / 1000)
-		    : (((int) msecs / 1000) * HZ);
-}
-
-static inline unsigned
-sg_jif_to_ms(int jifs)
-{
-	if (jifs <= 0)
-		return 0U;
-	else {
-		unsigned int j = (unsigned int) jifs;
-		return (j <
-			(UINT_MAX / 1000)) ? ((j * 1000) / HZ) : ((j / HZ) *
-								  1000);
-	}
-}
-
 static unsigned char allow_ops[] = { TEST_UNIT_READY, REQUEST_SENSE,
 	INQUIRY, READ_CAPACITY, READ_BUFFER, READ_6, READ_10, READ_12,
 	MODE_SENSE, MODE_SENSE_10, LOG_SENSE
