Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266905AbTGTLHw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Jul 2003 07:07:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266921AbTGTLHw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Jul 2003 07:07:52 -0400
Received: from fed1mtao01.cox.net ([68.6.19.244]:46835 "EHLO
	fed1mtao01.cox.net") by vger.kernel.org with ESMTP id S266905AbTGTLHo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Jul 2003 07:07:44 -0400
Date: Sun, 20 Jul 2003 04:22:43 -0700
From: "Barry K. Nathan" <barryn@pobox.com>
To: linuxppc-dev@lists.linuxppc.org, linux-kernel@vger.kernel.org,
       akpm@osdl.org, torvalds@osdl.org, rusty@rustcorp.com.au
Subject: [PATCH] fix PPC compile failure with 2.6.0-test1-bk1
Message-ID: <20030720112242.GA12345@ip68-4-255-84.oc.oc.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There are (at least) three compile failures on PowerMacs in
2.6.0-test1-bk1.

The first (actually a link failure, not a compile failure) is
bugme.osdl.org bug 954. That bug has a trivial fix (view the bug at
bugme.osdl.org to see the fix; it's also been posted to lkml).

The second is bug 965. This failure happens because PPC doesn't have its
own local_t implementation. The quick fix is to have PPC use the
asm-generic implementation. I've attached a patch to that bug which does
that.

Finally, bug 966 is caused by Rusty's "Centralize Linker Symbols" patch,
which is now in Linus' BK tree. The patch at the bottom of this message
is an attempt to (partially) fix PPC and make it compile again. AFAICT
this patch doesn't get everything, but it's enough to compile and boot
on my iMac, and I want to get feedback on this patch before I create
another patch to finish the job.

Some particular points of concern:

(a) This continues to perpetuate the char[] section.h stuff. Is this a
settled matter, or does anyone (Andrew?) still think this might be
incorrect? If anyone's wondering what I mean, see this post:
http://marc.theaimsgroup.com/?l=linux-kernel&m=105867566108404&w=2

(b) Should I #include the asm-generic stuff from
include/asm-ppc/sections.h, or should I copy-and-paste? Right now
I'm opting for the former.

(c) Look at the typecast in the second hunk of the
arch/ppc/kernel/setup.c patch. If I don't put it there, PTRRELOC tries
to typecast __bss_start to an unsigned long (OK) and then back to a
char[] (not OK, breaks the compile). More specifically, this happens:

arch/ppc/kernel/setup.c: In function `early_init':
arch/ppc/kernel/setup.c:280: cast specifies array type
make[1]: *** [arch/ppc/kernel/setup.o] Error 1

This typecast seems ugly to me, but OTOH I can't think of any cleaner
alternatives (i.e., I can think of alternatives, but they all seem even
uglier to me).

-Barry K. Nathan <barryn@pobox.com>

diff -ruN linux-2.6.0-test1-bk1-bkn1/arch/ppc/kernel/setup.c linux-2.6.0-test1-bk1-bkn2/arch/ppc/kernel/setup.c
--- linux-2.6.0-test1-bk1-bkn1/arch/ppc/kernel/setup.c	2003-07-14 07:00:13.000000000 -0700
+++ linux-2.6.0-test1-bk1-bkn2/arch/ppc/kernel/setup.c	2003-07-19 19:16:20.000000000 -0700
@@ -268,7 +268,7 @@
 unsigned long
 early_init(int r3, int r4, int r5)
 {
-	extern char __bss_start, _end;
+	extern char _end[];
  	unsigned long phys;
 	unsigned long offset = reloc_offset();
 
@@ -277,7 +277,7 @@
 
 	/* First zero the BSS -- use memset, some arches don't have
 	 * caches on yet */
-	memset_io(PTRRELOC(&__bss_start), 0, &_end - &__bss_start);
+	memset_io(PTRRELOC((char*)__bss_start), 0, _end - __bss_start);
 
 	/*
 	 * Identify the CPU type and fix up code sections
@@ -591,7 +591,6 @@
 void __init setup_arch(char **cmdline_p)
 {
 	extern int panic_timeout;
-	extern char _etext[], _edata[];
 	extern char *klimit;
 	extern void do_init_bootmem(void);
 
diff -ruN linux-2.6.0-test1-bk1-bkn1/arch/ppc/syslib/prom_init.c linux-2.6.0-test1-bk1-bkn2/arch/ppc/syslib/prom_init.c
--- linux-2.6.0-test1-bk1-bkn1/arch/ppc/syslib/prom_init.c	2003-07-20 01:47:34.000000000 -0700
+++ linux-2.6.0-test1-bk1-bkn2/arch/ppc/syslib/prom_init.c	2003-07-20 01:40:38.000000000 -0700
@@ -133,7 +133,6 @@
 struct device_node *allnodes;
 
 extern char *klimit;
-extern char _stext;
 
 static void __init
 prom_exit(void)
@@ -601,7 +600,7 @@
 	/* copy the holding pattern code to someplace safe (0) */
 	/* the holding pattern is now within the first 0x100
 	   bytes of the kernel image -- paulus */
-	memcpy((void *)0, &_stext, 0x100);
+	memcpy((void *)0, _stext, 0x100);
 	flush_icache_range(0, 0x100);
 
 	/* look for cpus */
@@ -631,7 +630,7 @@
 		prom_print(path);
 		*(ulong *)(0x4) = 0;
 		call_prom("start-cpu", 3, 0, node,
-			  (char *)__secondary_hold - &_stext, cpu);
+			  (char *)__secondary_hold - _stext, cpu);
 		prom_print("...");
 		for ( i = 0 ; (i < 10000) && (*(ulong *)(0x4) == 0); i++ )
 			;
@@ -708,7 +707,7 @@
 	void *result[3];
 
  	/* Default */
- 	phys = (unsigned long) &_stext;
+ 	phys = (unsigned long) _stext;
 
 	/* First get a handle for the stdout device */
 	prom = pp;
@@ -766,7 +765,7 @@
 				 &prom_mmu, sizeof(prom_mmu)) <= 0) {
 		prom_print(" no MMU found\n");
 	} else if ((int)call_prom_ret("call-method", 4, 4, result, "translate",
-				      prom_mmu, &_stext, 1) != 0) {
+				      prom_mmu, _stext, 1) != 0) {
 		prom_print(" (translate failed)\n");
 	} else {
 		/* We assume the phys. address size is 3 cells */
@@ -882,7 +881,7 @@
 		 * are in the hash table - the aim is to try to avoid
 		 * getting DSI exceptions while copying the kernel image.
 		 */
-		for (ptr = ((unsigned long) &_stext) & PAGE_MASK;
+		for (ptr = ((unsigned long) _stext) & PAGE_MASK;
 		     ptr < (unsigned long)bi + space; ptr += PAGE_SIZE)
 			x = *(volatile unsigned long *)ptr;
 	}
diff -ruN linux-2.6.0-test1-bk1-bkn1/include/asm-ppc/sections.h linux-2.6.0-test1-bk1-bkn2/include/asm-ppc/sections.h
--- linux-2.6.0-test1-bk1-bkn1/include/asm-ppc/sections.h	2003-05-04 16:53:42.000000000 -0700
+++ linux-2.6.0-test1-bk1-bkn2/include/asm-ppc/sections.h	2003-07-19 19:15:59.000000000 -0700
@@ -26,6 +26,9 @@
 #define __openfirmwarefunc(__argopenfirmware) \
 	__argopenfirmware __openfirmware; \
 	__argopenfirmware
-	
+
+/* we need the generic references to section boundaries, too */
+#include <asm-generic/sections.h>
+
 #endif /* _PPC_SECTIONS_H */
 #endif /* __KERNEL__ */
