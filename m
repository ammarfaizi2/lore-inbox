Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265193AbUD3Sd4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265193AbUD3Sd4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Apr 2004 14:33:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265213AbUD3Sd4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Apr 2004 14:33:56 -0400
Received: from the.earth.li ([193.201.200.66]:4546 "EHLO the.earth.li")
	by vger.kernel.org with ESMTP id S265193AbUD3Sdu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Apr 2004 14:33:50 -0400
Date: Fri, 30 Apr 2004 19:33:49 +0100
From: Jonathan McDowell <noodles@earth.li>
To: Mirko Caserta <mirko@mcaserta.com>
Cc: Linux Kernel ML <linux-kernel@vger.kernel.org>
Subject: Re: Initio INI-9X00U/UW error handling in 2.6
Message-ID: <20040430183349.GX2360@earth.li>
References: <opr619y8b4psnffn@mail.mcaserta.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="7iMSBzlTiPOCCT2k"
Content-Disposition: inline
In-Reply-To: <opr619y8b4psnffn@mail.mcaserta.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--7iMSBzlTiPOCCT2k
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 26, 2004 at 01:24:34PM +0200, Mirko Caserta wrote:
> I was just wondering if someone is working on a fix for this:
> 
> i91u: PCI Base=0xD000, IRQ=11, BIOS=0xFF000, SCSI ID=7
> i91u: Reset SCSI Bus ...
> ERROR: SCSI host `INI9100U' has no error handling
> ERROR: This is not a safe way to run your SCSI host
...

Try the attached; I wrote it a while back and made a cleanup based on
comments from James Bottomley, but no one else seemed to be using the
driver. It worked for me however.

J.

-- 
] http://www.earth.li/~noodles/ []  Hitler and a TGB.  On a bike.  At  [
]  PGP/GPG Key @ the.earth.li   []   158mph.  End of thread.  Have a   [
] via keyserver, web or email.  []            nice 'froup.             [
] RSA: 4DC4E7FD / DSA: 5B430367 []                                     [

--7iMSBzlTiPOCCT2k
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="initio.patch"

diff -ruN linux-2.6.5.orig/drivers/scsi/ini9100u.c linux-2.6.5/drivers/scsi/ini9100u.c
--- linux-2.6.5.orig/drivers/scsi/ini9100u.c	2004-04-30 19:36:05.000000000 +0100
+++ linux-2.6.5/drivers/scsi/ini9100u.c	2004-04-30 19:40:06.000000000 +0100
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
@@ -550,6 +553,15 @@
 		return tul_device_reset(pHCB, (ULONG) SCpnt, SCpnt->device->id, reset_flags);
 }
 
+int i91u_bus_reset(Scsi_Cmnd * SCpnt)
+{
+	HCS *pHCB;
+
+	pHCB = (HCS *) SCpnt->device->host->base;
+	tul_reset_scsi(pHCB, 0);
+	return SUCCESS;
+}
+
 /*
  * Return the "logical geometry"
  */
diff -ruN linux-2.6.5.orig/drivers/scsi/ini9100u.h linux-2.6.5/drivers/scsi/ini9100u.h
--- linux-2.6.5.orig/drivers/scsi/ini9100u.h	2003-12-18 02:58:56.000000000 +0000
+++ linux-2.6.5/drivers/scsi/ini9100u.h	2004-04-30 19:39:30.000000000 +0100
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

--7iMSBzlTiPOCCT2k--
