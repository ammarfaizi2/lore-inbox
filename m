Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261975AbUB2F2P (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Feb 2004 00:28:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261979AbUB2F2O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Feb 2004 00:28:14 -0500
Received: from m013-078.nv.iinet.net.au ([203.217.13.78]:22286 "EHLO
	mail.adixein.com") by vger.kernel.org with ESMTP id S261975AbUB2F2K
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Feb 2004 00:28:10 -0500
From: "Elliot Mackenzie" <macka@adixein.com>
To: "'Len Brown'" <len.brown@intel.com>, "'Randy.Dunlap'" <rddunlap@osdl.org>
Cc: <linux-kernel@vger.kernel.org>
Subject: [PATCH]: PROBLEM: Panic booting from USB disk in ioremap.c (line 81)
Date: Sun, 29 Feb 2004 15:28:55 +1000
Keywords: macka@adixein.com
Message-ID: <001101c3fe84$eec59450$4301a8c0@waverunner>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.2627
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
In-Reply-To: <1077783113.22401.69.camel@dhcppc4>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel-devs:

This patch simply adds a sanity check to bootflag.c to detect a bad RSDT
pointer and avoids a kernel panic on boot with some buggy BIOSes.  The
patch is an "interim" patch, as we believe Len Brown has plans to use
the ACPI code to manage SBF in future.

Initial post:
>We have a problem booting vanilla 2.6.2 and 2.6.3 kernels from a USB
disk >(Transcend JetFlash, both 128MB USB 2 and 256MB USB 1). During
what appears >to be PCI device enumeration, we get the following panic:

Len Brown:
>bootflag.c should not use its own private ACPI table parser/mapper --
>this is a bug:
>http://bugme.osdl.org/show_bug.cgi?id=1922

This is an interim patch for anyone that is wrestling with the same
issue.  
Thank you to Randy Dunlap for his helpful assistance early in the
process (and for some of the code below).  

Kind regards,
Doug Turk and Elliot Mackenzie.


========================================================================
====
--- linux-2.6.3/arch/i386/kernel/bootflag.c	Wed Feb 18 13:59:06 2004
+++ linux-2.6.3-doug/arch/i386/kernel/bootflag.c	Tue Feb 24
23:18:51 2004
@@ -192,22 +192,37 @@
 	}
 	if(i>0xFFFE0)
 		return 0;
-		
-		
+
 	rsdt = ioremap(rsdtbase, rsdtlen);
 	if(rsdt == 0)
 		return 0;
-		
-	i = readl(rsdt + 4);
+
+	/* Check the RSDT signature */
+	if (memcmp(rsdt, "RSDT", 4))
+	{
+		iounmap(rsdt);
+		printk(KERN_WARNING "SBF: Could not map RSDT: bad
signature\n");
+		return 0;
+	}
+
 	
 	/*
 	 *	Remap if needed
 	 */
-	 
+	i = readl(rsdt + 4);
+
 	if(i > rsdtlen)
 	{
 		rsdtlen = i;
 		iounmap(rsdt);
+		/* Verify that the RSDT length is sane. */
+		if (rsdtlen > 0x1000) {	/* arbitrary for now */
+			printk(KERN_ERR "SBF: invalid rsdtlen = 0x%x\n",
+					rsdtlen);
+			return 0;
+		}
+
 		rsdt = ioremap(rsdtbase, rsdtlen);
 		if(rsdt == 0)
 			return 0;


