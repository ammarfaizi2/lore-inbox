Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261273AbULEHZs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261273AbULEHZs (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Dec 2004 02:25:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261274AbULEHZr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Dec 2004 02:25:47 -0500
Received: from 70-56-133-193.albq.qwest.net ([70.56.133.193]:53437 "EHLO
	montezuma.fsmlabs.com") by vger.kernel.org with ESMTP
	id S261273AbULEHZc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Dec 2004 02:25:32 -0500
Date: Sun, 5 Dec 2004 00:24:55 -0700 (MST)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Ingo Molnar <mingo@elte.hu>
cc: Linux Kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH][1/2] NX: Fix noexec kernel parameter
In-Reply-To: <Pine.LNX.4.61.0412041135570.6378@montezuma.fsmlabs.com>
Message-ID: <Pine.LNX.4.61.0412050023270.6378@montezuma.fsmlabs.com>
References: <Pine.LNX.4.61.0412041135570.6378@montezuma.fsmlabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

noexec_setup runs too late to take any effect, so parse it earlier. 
Rediffed to incorporate suggestions.
 
Signed-off-by: Zwane Mwaikambo <zwane@arm.linux.org.uk>

Index: linux-2.6.10-rc2/include/asm-i386/pgtable.h
===================================================================
RCS file: /home/cvsroot/linux-2.6.10-rc2/include/asm-i386/pgtable.h,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 pgtable.h
--- linux-2.6.10-rc2/include/asm-i386/pgtable.h	25 Nov 2004 19:45:33 -0000	1.1.1.1
+++ linux-2.6.10-rc2/include/asm-i386/pgtable.h	5 Dec 2004 07:21:29 -0000
@@ -363,6 +363,8 @@ extern pte_t *lookup_address(unsigned lo
  static inline int set_kernel_exec(unsigned long vaddr, int enable) { return 0;}
 #endif
 
+extern void noexec_setup(const char *str);
+
 #if defined(CONFIG_HIGHPTE)
 #define pte_offset_map(dir, address) \
 	((pte_t *)kmap_atomic(pmd_page(*(dir)),KM_PTE0) + pte_index(address))
Index: linux-2.6.10-rc2/arch/i386/kernel/setup.c
===================================================================
RCS file: /home/cvsroot/linux-2.6.10-rc2/arch/i386/kernel/setup.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 setup.c
--- linux-2.6.10-rc2/arch/i386/kernel/setup.c	25 Nov 2004 19:45:32 -0000	1.1.1.1
+++ linux-2.6.10-rc2/arch/i386/kernel/setup.c	5 Dec 2004 07:19:33 -0000
@@ -737,6 +737,10 @@ static void __init parse_cmdline_early (
 			}
 		}
 
+		else if (!memcmp(from, "noexec=", 7))
+			noexec_setup(from + 7);
+
+
 #ifdef  CONFIG_X86_SMP
 		/*
 		 * If the BIOS enumerates physical processors before logical,
Index: linux-2.6.10-rc2/arch/i386/mm/init.c
===================================================================
RCS file: /home/cvsroot/linux-2.6.10-rc2/arch/i386/mm/init.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 init.c
--- linux-2.6.10-rc2/arch/i386/mm/init.c	25 Nov 2004 19:45:32 -0000	1.1.1.1
+++ linux-2.6.10-rc2/arch/i386/mm/init.c	5 Dec 2004 07:19:54 -0000
@@ -424,7 +424,7 @@ u64 __supported_pte_mask = ~_PAGE_NX;
  * on      Enable
  * off     Disable
  */
-static int __init noexec_setup(char *str)
+void __init noexec_setup(const char *str)
 {
 	if (!strncmp(str, "on",2) && cpu_has_nx) {
 		__supported_pte_mask |= _PAGE_NX;
@@ -433,11 +433,8 @@ static int __init noexec_setup(char *str
 		disable_nx = 1;
 		__supported_pte_mask &= ~_PAGE_NX;
 	}
-	return 1;
 }
 
-__setup("noexec=", noexec_setup);
-
 int nx_enabled = 0;
 #ifdef CONFIG_X86_PAE
 
