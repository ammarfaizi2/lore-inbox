Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266090AbUAFXPA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jan 2004 18:15:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266098AbUAFXOu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jan 2004 18:14:50 -0500
Received: from the.earth.li ([193.201.200.66]:29370 "EHLO the.earth.li")
	by vger.kernel.org with ESMTP id S266090AbUAFXO1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jan 2004 18:14:27 -0500
Date: Tue, 6 Jan 2004 23:14:26 +0000
From: Jonathan McDowell <noodles@earth.li>
To: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Patch for reset in ini9100u [Initio 9100U(W)]
Message-ID: <20040106231426.GR1845@earth.li>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

I have an IWill 2935UW SCSI controller which uses the ini9100u driver.
This has been working fine under 2.4 but I've recently built up a box of
spare bits including the controller and installed 2.6 on it. The driver
is marked broken in 2.6, apparently because of a lack of reset/abort
functionality as it compiles and runs ok. So I've taken a stab at
getting reset support back. Patch is below and it's received minimal
testing - it boots, removes the callback trace and error message and
doesn't seem to cause problems (the only disk in the machine is on this
card).

-----------
diff -u linux-2.6.1-rc2.orig/drivers/scsi/ini9100u.c linux-2.6.1-rc2/drivers/scsi/ini9100u.c
--- linux-2.6.1-rc2.orig/drivers/scsi/ini9100u.c	2004-01-06 22:56:04.000000000 +0000
+++ linux-2.6.1-rc2/drivers/scsi/ini9100u.c	2004-01-06 22:58:04.000000000 +0000
@@ -106,6 +106,8 @@
  *		- Changed the assumption that HZ = 100
  * 10/17/03 mc	- v1.04
  *		- added new DMA API support
+ * 06/01/04 jmd	- v1.04a
+ *		- Re-add reset_bus support
  **************************************************************************/
 
 #define CVT_LINUX_VERSION(V,P,S)        (V * 65536 + P * 256 + S)
@@ -149,6 +151,7 @@
 	.queuecommand	= i91u_queue,
 //	.abort		= i91u_abort,
 //	.reset		= i91u_reset,
+	.eh_bus_reset_handler = i91u_bus_reset,
 	.bios_param	= i91u_biosparam,
 	.can_queue	= 1,
 	.this_id	= 1,
@@ -161,7 +164,7 @@
 char *i91uCopyright = "Copyright (C) 1996-98";
 char *i91uInitioName = "by Initio Corporation";
 char *i91uProductName = "INI-9X00U/UW";
-char *i91uVersion = "v1.04";
+char *i91uVersion = "v1.04a";
 
 #define TULSZ(sz)     (sizeof(sz) / sizeof(sz[0]))
 #define TUL_RDWORD(x,y)         (short)(inl((int)((ULONG)((ULONG)x+(UCHAR)y)) ))
@@ -587,6 +590,15 @@
 		return tul_device_reset(pHCB, (ULONG) SCpnt, SCpnt->device->id, reset_flags);
 }
 
+int i91u_bus_reset(Scsi_Cmnd * SCpnt)
+{
+	HCS *pHCB;
+
+	pHCB = (HCS *) SCpnt->device->host->base;
+	tul_reset_scsi_bus(pHCB);
+	return SUCCESS;
+}
+
 /*
  * Return the "logical geometry"
  */
diff -u linux-2.6.1-rc2.orig/drivers/scsi/ini9100u.h linux-2.6.1-rc2/drivers/scsi/ini9100u.h
--- linux-2.6.1-rc2.orig/drivers/scsi/ini9100u.h	2003-12-18 02:58:56.000000000 +0000
+++ linux-2.6.1-rc2/drivers/scsi/ini9100u.h	2004-01-06 22:58:35.000000000 +0000
@@ -82,10 +82,11 @@
 extern int i91u_queue(Scsi_Cmnd *, void (*done) (Scsi_Cmnd *));
 extern int i91u_abort(Scsi_Cmnd *);
 extern int i91u_reset(Scsi_Cmnd *, unsigned int);
+extern int i91u_bus_reset(Scsi_Cmnd *);
 extern int i91u_biosparam(struct scsi_device *, struct block_device *,
 		sector_t, int *);
 
-#define i91u_REVID "Initio INI-9X00U/UW SCSI device driver; Revision: 1.03g"
+#define i91u_REVID "Initio INI-9X00U/UW SCSI device driver; Revision: 1.04a"
 
 #define VIRT_TO_BUS(i)  (unsigned int) virt_to_bus((void *)(i))
 #define ULONG   unsigned long
-----------

J.

-- 
] http://www.earth.li/~noodles/ []  "0 tends to simplify things a bit  [
]  PGP/GPG Key @ the.earth.li   []   when you multiply by it..." --    [
] via keyserver, web or email.  []             Bill McColl             [
] RSA: 4DC4E7FD / DSA: 5B430367 []                                     [
