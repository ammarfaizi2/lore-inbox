Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263147AbUFCKhT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263147AbUFCKhT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jun 2004 06:37:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263162AbUFCKhT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jun 2004 06:37:19 -0400
Received: from ozlabs.org ([203.10.76.45]:11925 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S263147AbUFCKhM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jun 2004 06:37:12 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16574.65474.100592.887358@cargo.ozlabs.ibm.com>
Date: Thu, 3 Jun 2004 20:38:58 +1000
From: Paul Mackerras <paulus@samba.org>
To: akpm@osdl.org, torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, benh@kernel.crashing.org,
       trini@kernel.crashing.org
Subject: [PATCH][PPC32] Suppress bogus info in /proc/ppc_htab on 64-bit cpus
X-Mailer: VM 7.18 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In the ppc32 kernel, we have a /proc/ppc_htab file that trawls through
the MMU hash table and prints various statistics on it such as percent
occupancy.  However, the hash table entry format is different on
64-bit cpus (POWER3, G5) which the ppc32 kernel does support (in
32-bit mode).

This patch disables the scanning of the MMU hash table and printing of
the statistics that we get from it on 64-bit cpus.  Since the
statistics are only for interest, and the ppc32 kernel is being used
less and less on 64-bit cpus now that the ppc64 kernel is in
reasonable shape, I didn't think it worth while to add code to deal
with the 64-bit HPTE format.

Signed-off-by: Paul Mackerras <paulus@samba.org>

diff -urN linux-2.5/arch/ppc/kernel/ppc_htab.c pmac-2.5/arch/ppc/kernel/ppc_htab.c
--- linux-2.5/arch/ppc/kernel/ppc_htab.c	2003-09-27 19:46:43.000000000 +1000
+++ pmac-2.5/arch/ppc/kernel/ppc_htab.c	2003-10-16 12:04:14.000000000 +1000
@@ -101,7 +101,7 @@
 {
 	unsigned long mmcr0 = 0, pmc1 = 0, pmc2 = 0;
 	int n = 0;
-#ifdef CONFIG_PPC_STD_MMU
+#if defined(CONFIG_PPC_STD_MMU) && !defined(CONFIG_PPC64BRIDGE)
 	unsigned int kptes = 0, uptes = 0;
 	PTE *ptr;
 #endif /* CONFIG_PPC_STD_MMU */
@@ -135,6 +135,7 @@
 		goto return_string;
 	}
 
+#ifndef CONFIG_PPC64BRIDGE
 	for (ptr = Hash; ptr < Hash_end; ptr++) {
 		unsigned int mctx, vsid;
 
@@ -148,6 +149,7 @@
 		else
 			uptes++;
 	}
+#endif
 
 	n += sprintf( buffer + n,
 		      "PTE Hash Table Information\n"
@@ -155,16 +157,20 @@
 		      "Buckets\t\t: %lu\n"
  		      "Address\t\t: %08lx\n"
 		      "Entries\t\t: %lu\n"
+#ifndef CONFIG_PPC64BRIDGE
 		      "User ptes\t: %u\n"
 		      "Kernel ptes\t: %u\n"
-		      "Percent full\t: %lu%%\n",
-                      (unsigned long)(Hash_size>>10),
+		      "Percent full\t: %lu%%\n"
+#endif
+                      , (unsigned long)(Hash_size>>10),
 		      (Hash_size/(sizeof(PTE)*8)),
 		      (unsigned long)Hash,
-		      Hash_size/sizeof(PTE),
-                      uptes,
+		      Hash_size/sizeof(PTE)
+#ifndef CONFIG_PPC64BRIDGE
+                      , uptes,
 		      kptes,
 		      ((kptes+uptes)*100) / (Hash_size/sizeof(PTE))
+#endif
 		);
 
 	n += sprintf( buffer + n,
