Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264165AbUEaL6R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264165AbUEaL6R (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 May 2004 07:58:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264270AbUEaL6R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 May 2004 07:58:17 -0400
Received: from verein.lst.de ([212.34.189.10]:37548 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S264165AbUEaL6A (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 May 2004 07:58:00 -0400
Date: Mon, 31 May 2004 13:57:54 +0200
From: Christoph Hellwig <hch@lst.de>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] runtime selection of CONFIG_PARIDE_EPATC8
Message-ID: <20040531115754.GA16245@lst.de>
Mail-Followup-To: Christoph Hellwig <hch>, akpm@osdl.org,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

drivers/block/paride/epat.c support two slightly different protocol
variants.  Currently it's compile-time selected by CONFIG_PARIDE_EPATC8,
but this patch adds a epatc8 module option to allow runtime selection.
CONFIG_PARIDE_EPATC8 stays for now but I'd like to kill it int 2.7.

The basic patch is from the Debian kernel package (Author unknown) but
I reworked it a bit.


--- 1.7/drivers/block/paride/epat.c	2002-11-15 03:03:17 +01:00
+++ edited/drivers/block/paride/epat.c	2004-05-31 13:16:02 +02:00
@@ -31,6 +31,12 @@
 #define j44(a,b)		(((a>>4)&0x0f)+(b&0xf0))
 #define j53(a,b)		(((a>>3)&0x1f)+((b<<4)&0xe0))
 
+static int epatc8;
+
+module_param(epatc8, int, 0);
+MODULE_PARM_DESC(epatc8, "support for the Shuttle EP1284 chip, "
+	"used in any recent Imation SuperDisk (LS-120) drive.");
+
 /* cont =  0   IDE register file
    cont =  1   IDE control registers
    cont =  2   internal EPAT registers
@@ -209,15 +215,18 @@
 {       pi->saved_r0 = r0();
         pi->saved_r2 = r2();
 
-#ifdef CONFIG_PARIDE_EPATC8
  	/* Initialize the chip */
-        CPP(0);CPP(0x40);CPP(0xe0);              
-        w0(0);w2(1);w2(4);
-        WR(0x8,0x12);WR(0xc,0x14);WR(0x12,0x10);
-        WR(0xe,0xf);WR(0xf,4);
-     /* WR(0xe,0xa);WR(0xf,4); */
-        WR(0xe,0xd);WR(0xf,0);
-     /* CPP(0x30); */
+	CPP(0);
+
+	if (epatc8) {
+		CPP(0x40);CPP(0xe0);              
+		w0(0);w2(1);w2(4);
+		WR(0x8,0x12);WR(0xc,0x14);WR(0x12,0x10);
+		WR(0xe,0xf);WR(0xf,4);
+		/* WR(0xe,0xa);WR(0xf,4); */
+		WR(0xe,0xd);WR(0xf,0);
+		/* CPP(0x30); */
+	}
 
         /* Connect to the chip */
 	CPP(0xe0);
@@ -227,15 +236,10 @@
           /* Request EPP */
           w0(0x40);w2(6);w2(7);w2(4);w2(0xc);w2(4);
         }
-#else
- 	CPP(0); CPP(0xe0);
-	w0(0); w2(1); w2(4);
-	if (pi->mode >= 3) {
-		w0(0); w2(1); w2(4); w2(0xc);
-		w0(0x40); w2(6); w2(7); w2(4); w2(0xc); w2(4);
+
+	if (!epatc8) {
+		WR(8,0x10); WR(0xc,0x14); WR(0xa,0x38); WR(0x12,0x10);
 	}
-	WR(8,0x10); WR(0xc,0x14); WR(0xa,0x38); WR(0x12,0x10);
-#endif
 }
 
 static void epat_disconnect (PIA *pi)
@@ -320,6 +324,9 @@
 
 static int __init epat_init(void)
 {
+#ifdef CONFIG_PARIDE_EPATC8
+	epatc8 = 1;
+#endif
 	return pi_register(&epat)-1;
 }
 
