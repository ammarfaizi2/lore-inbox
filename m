Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264948AbTFTVyt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jun 2003 17:54:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264946AbTFTVyq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jun 2003 17:54:46 -0400
Received: from webmail.netapps.org ([12.162.17.40]:53420 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S264943AbTFTVye (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jun 2003 17:54:34 -0400
To: trivial@rustcorp.com.au, torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Fix compilation with CONFIG_MELAN
X-Message-Flag: Warning: May contain useful information
X-Priority: 1
X-MSMail-Priority: High
From: Roland Dreier <roland@topspin.com>
Date: 20 Jun 2003 15:08:29 -0700
Message-ID: <52el1ol7vm.fsf@topspin.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Common Lisp)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 20 Jun 2003 22:08:31.0934 (UTC) FILETIME=[7C689DE0:01C33778]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes compilation when CONFIG_MELAN is turned on.
The problem is that <asm-i386/mach-default/mach_resources.h> includes
the bogus construction

#ifdef CONFIG_MELAN
standard_io_resources[1] = { "pic1", 0x20, 0x21, IORESOURCE_BUSY };
standard_io_resources[5] = { "pic2", 0xa0, 0xa1, IORESOURCE_BUSY };
#endif

at the top level.  I tried this with Debian's gcc 2.95 and Red Hat's
gcc 3.2, and neither will accept it (they complain about a duplicate
declaration of standard_io_resources when building arch/i386/setup.c).

To duplicate this, you can do "make defconfig" and then go into "make
menuconfig" and change "Processor family" to "Elan".  Building that
config fails for me.

I assume the following is what was intended.

 - Roland

===== include/asm-i386/mach-default/mach_resources.h 1.1 vs edited =====
--- 1.1/include/asm-i386/mach-default/mach_resources.h	Thu Mar 13 17:17:51 2003
+++ edited/include/asm-i386/mach-default/mach_resources.h	Fri Jun 20 15:06:05 2003
@@ -9,18 +9,22 @@
 
 struct resource standard_io_resources[] = {
 	{ "dma1", 0x00, 0x1f, IORESOURCE_BUSY },
+#ifndef CONFIG_MELAN
 	{ "pic1", 0x20, 0x3f, IORESOURCE_BUSY },
+#else
+	{ "pic1", 0x20, 0x21, IORESOURCE_BUSY },
+#endif
 	{ "timer", 0x40, 0x5f, IORESOURCE_BUSY },
 	{ "keyboard", 0x60, 0x6f, IORESOURCE_BUSY },
 	{ "dma page reg", 0x80, 0x8f, IORESOURCE_BUSY },
+#ifndef CONFIG_MELAN
 	{ "pic2", 0xa0, 0xbf, IORESOURCE_BUSY },
+#else
+	{ "pic2", 0xa0, 0xa1, IORESOURCE_BUSY },
+#endif
 	{ "dma2", 0xc0, 0xdf, IORESOURCE_BUSY },
 	{ "fpu", 0xf0, 0xff, IORESOURCE_BUSY }
 };
-#ifdef CONFIG_MELAN
-standard_io_resources[1] = { "pic1", 0x20, 0x21, IORESOURCE_BUSY };
-standard_io_resources[5] = { "pic2", 0xa0, 0xa1, IORESOURCE_BUSY };
-#endif
 
 #define STANDARD_IO_RESOURCES (sizeof(standard_io_resources)/sizeof(struct resource))
 
