Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261268AbULEHTf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261268AbULEHTf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Dec 2004 02:19:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261272AbULEHTf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Dec 2004 02:19:35 -0500
Received: from 70-56-133-193.albq.qwest.net ([70.56.133.193]:44477 "EHLO
	montezuma.fsmlabs.com") by vger.kernel.org with ESMTP
	id S261268AbULEHTb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Dec 2004 02:19:31 -0500
Date: Sun, 5 Dec 2004 00:18:37 -0700 (MST)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Ingo Molnar <mingo@elte.hu>
cc: Linux Kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Andi Kleen <ak@suse.de>
Subject: Re: [PATCH] NX: Fix noexec kernel parameter / x86_64
In-Reply-To: <Pine.LNX.4.61.0412042356340.6378@montezuma.fsmlabs.com>
Message-ID: <Pine.LNX.4.61.0412050016560.6378@montezuma.fsmlabs.com>
References: <Pine.LNX.4.61.0412041135570.6378@montezuma.fsmlabs.com>
 <Pine.LNX.4.61.0412042356340.6378@montezuma.fsmlabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

noexec_setup runs too late to take any effect, so parse it earlier. 
Rediffed to incorporate suggestions.

Signed-off-by: Zwane Mwaikambo <zwane@arm.linux.org.uk>

Index: linux-2.6.10-rc2-mm3-x86_64/include/asm-x86_64/pgtable.h
===================================================================
RCS file: /home/cvsroot/linux-2.6.10-rc2-mm3/include/asm-x86_64/pgtable.h,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 pgtable.h
--- linux-2.6.10-rc2-mm3-x86_64/include/asm-x86_64/pgtable.h	24 Nov 2004 16:14:38 -0000	1.1.1.1
+++ linux-2.6.10-rc2-mm3-x86_64/include/asm-x86_64/pgtable.h	5 Dec 2004 07:14:44 -0000
@@ -20,6 +20,7 @@ extern unsigned long __supported_pte_mas
 
 #define swapper_pml4 init_level4_pgt
 
+extern void nonx_setup(const char *str);
 extern void paging_init(void);
 extern void clear_kernel_mapping(unsigned long addr, unsigned long size);
 
Index: linux-2.6.10-rc2-mm3-x86_64/arch/x86_64/kernel/setup.c
===================================================================
RCS file: /home/cvsroot/linux-2.6.10-rc2-mm3/arch/x86_64/kernel/setup.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 setup.c
--- linux-2.6.10-rc2-mm3-x86_64/arch/x86_64/kernel/setup.c	24 Nov 2004 16:17:13 -0000	1.1.1.1
+++ linux-2.6.10-rc2-mm3-x86_64/arch/x86_64/kernel/setup.c	5 Dec 2004 07:14:59 -0000
@@ -312,6 +312,9 @@ static __init void parse_cmdline_early (
 		if (!memcmp(from,"oops=panic", 10))
 			panic_on_oops = 1;
 
+		if (!memcmp(from, "noexec=", 7))
+			nonx_setup(from + 7);
+
 	next_char:
 		c = *(from++);
 		if (!c)
Index: linux-2.6.10-rc2-mm3-x86_64/arch/x86_64/kernel/setup64.c
===================================================================
RCS file: /home/cvsroot/linux-2.6.10-rc2-mm3/arch/x86_64/kernel/setup64.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 setup64.c
--- linux-2.6.10-rc2-mm3-x86_64/arch/x86_64/kernel/setup64.c	24 Nov 2004 16:17:12 -0000	1.1.1.1
+++ linux-2.6.10-rc2-mm3-x86_64/arch/x86_64/kernel/setup64.c	5 Dec 2004 07:13:58 -0000
@@ -50,7 +50,7 @@ Control non executable mappings for 64bi
 on	Enable(default)
 off	Disable
 */ 
-static int __init nonx_setup(char *str)
+void __init nonx_setup(const char *str)
 {
 	if (!strcmp(str, "on")) {
                 __supported_pte_mask |= _PAGE_NX; 
@@ -59,11 +59,8 @@ static int __init nonx_setup(char *str)
 		do_not_nx = 1;
 		__supported_pte_mask &= ~_PAGE_NX;
         } 
-        return 1;
 } 
 
-__setup("noexec=", nonx_setup); 
-
 /*
  * Great future plan:
  * Declare PDA itself and support (irqstack,tss,pml4) as per cpu data.
