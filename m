Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268674AbUILLXN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268674AbUILLXN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Sep 2004 07:23:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268672AbUILLXM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Sep 2004 07:23:12 -0400
Received: from aun.it.uu.se ([130.238.12.36]:63482 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S268674AbUILLVl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Sep 2004 07:21:41 -0400
Date: Sun, 12 Sep 2004 13:21:30 +0200 (MEST)
Message-Id: <200409121121.i8CBLUYA015151@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: James.Bottomley@HansenPartnership.com, marcelo.tosatti@cyclades.com
Subject: [PATCH][2.4.28-pre3] 53c700 scsi driver gcc-3.4 fixes
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes gcc-3.4 cast-as-lvalue warnings in the 2.4.28-pre3
kernel's drivers/scsi/53c700.h. With the exception of NCR_700_set_SXFER(),
the changes are all backports from the 2.6 kernel.

/Mikael

--- linux-2.4.28-pre3/drivers/scsi/53c700.h.~1~	2002-02-26 13:26:57.000000000 +0100
+++ linux-2.4.28-pre3/drivers/scsi/53c700.h	2004-09-12 02:09:09.000000000 +0200
@@ -109,8 +109,11 @@
 static inline void
 NCR_700_set_SXFER(Scsi_Device *SDp, __u8 sxfer)
 {
-	((unsigned long)SDp->hostdata) &= 0xffffff00;
-	((unsigned long)SDp->hostdata) |= sxfer & 0xff;
+	long l = (long)SDp->hostdata;
+
+	l &= 0xffffff00;
+	l |= sxfer & 0xff;
+	SDp->hostdata = (void *)l;
 }
 static inline __u8 NCR_700_get_SXFER(Scsi_Device *SDp)
 {
@@ -119,8 +122,11 @@
 static inline void
 NCR_700_set_depth(Scsi_Device *SDp, __u8 depth)
 {
-	((unsigned long)SDp->hostdata) &= 0xffff00ff;
-	((unsigned long)SDp->hostdata) |= (0xff00 & (depth << 8));
+	long l = (long)SDp->hostdata;
+
+	l &= 0xffff00ff;
+	l |= 0xff00 & (depth << 8);
+	SDp->hostdata = (void *)l;
 }
 static inline __u8
 NCR_700_get_depth(Scsi_Device *SDp)
@@ -140,12 +146,12 @@
 static inline void
 NCR_700_set_flag(Scsi_Device *SDp, __u32 flag)
 {
-	((unsigned long)SDp->hostdata) |= (flag & 0xffff0000);
+	SDp->hostdata = (void *)((long)SDp->hostdata | (flag & 0xffff0000));
 }
 static inline void
 NCR_700_clear_flag(Scsi_Device *SDp, __u32 flag)
 {
-	((unsigned long)SDp->hostdata) &= ~(flag & 0xffff0000);
+	SDp->hostdata = (void *)((long)SDp->hostdata & ~(flag & 0xffff0000));
 }
 
 /* These represent the Nexus hashing functions.  A Nexus in SCSI terms
