Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263135AbUB0Vwj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Feb 2004 16:52:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263150AbUB0Vwj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Feb 2004 16:52:39 -0500
Received: from e35.co.us.ibm.com ([32.97.110.133]:5267 "EHLO e35.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S263135AbUB0VwY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Feb 2004 16:52:24 -0500
Date: Fri, 27 Feb 2004 15:51:36 -0600 (CST)
From: olof@austin.ibm.com
To: torvalds@osdl.org
cc: benh@kernel.crashing.org, <linux-kernel@vger.kernel.org>,
       <linuxppc64-dev@lists.linuxppc.org>
Subject: [PATCH] ppc64: Add iommu=on for enabling DART on small-mem machines
Message-ID: <Pine.A41.4.44.0402271524190.43108-100000@forte.austin.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Below patch makes it possible for people like me with a small-mem G5 to
enable the DART. I see two reasons for wanting to do so:

1. To debug/test DART/iommu code itself (small audience, including
   myself).
2. To debug drivers on small-mem machines, since bad pci_map*() usage will
   be punished (possibly larger audience).


Thanks,

-Olof


===== arch/ppc64/kernel/prom.c 1.56 vs edited =====
--- 1.56/arch/ppc64/kernel/prom.c	Fri Feb 27 16:44:57 2004
+++ edited/arch/ppc64/kernel/prom.c	Fri Feb 27 15:48:10 2004
@@ -516,6 +516,9 @@
 	return mem;
 }

+#ifdef CONFIG_PMAC_DART
+static int dart_force_on;
+#endif

 static unsigned long __init
 prom_initialize_lmb(unsigned long mem)
@@ -539,10 +542,12 @@
 		prom_print(opt);
 		prom_print(RELOC("\n"));
 		opt += 6;
-		while(*opt && *opt == ' ')
+		while (*opt && *opt == ' ')
 			opt++;
 		if (!strncmp(opt, RELOC("off"), 3))
 			nodart = 1;
+		else if (!strncmp(opt, RELOC("on"), 2))
+			RELOC(dart_force_on) = 1;
 	}
 #else
 	nodart = 1;
@@ -763,8 +768,10 @@
 	extern unsigned long dart_tablebase;
 	extern unsigned long dart_tablesize;

-	/* Only reserve DART space if machine has more than 2Gb of RAM */
-	if (lmb_end_of_DRAM() <= 0x80000000ull)
+	/* Only reserve DART space if machine has more than 2GB of RAM
+	 * or if requested with iommu=on on cmdline.
+	 */
+	if (lmb_end_of_DRAM() <= 0x80000000ull && !RELOC(dart_force_on))
 		return;

 	/* 512 pages is max DART tablesize. */




Olof Johansson                                        Office: 4E002/905
Linux on Power Development                            IBM Systems Group
Email: olof@austin.ibm.com                          Phone: 512-838-9858
All opinions are my own and not those of IBM


