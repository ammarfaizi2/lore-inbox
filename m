Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267482AbSLRTi4>; Wed, 18 Dec 2002 14:38:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267484AbSLRTi4>; Wed, 18 Dec 2002 14:38:56 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:21893 "EHLO
	mtvmime02.veritas.com") by vger.kernel.org with ESMTP
	id <S267482AbSLRTiy>; Wed, 18 Dec 2002 14:38:54 -0500
Date: Wed, 18 Dec 2002 19:48:07 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Linus Torvalds <torvalds@transmeta.com>
cc: Dave Hansen <haveblue@us.ibm.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] smpboot magical numbers
Message-ID: <Pine.LNX.4.44.0212181943570.2179-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anyone experimenting with different THREAD_SIZE or PAGE_SIZE on i386
runs into magical mystery numbers in do_boot_cpu esp initialization.
Remove those and use the same stack top in startup_32 as thereafter.

Oh, and what's that phys_to_virt(8192)?  Goodness! it's actually the
trampoline_base we (hopefully) got from early alloc_bootmem_low_pages.
Yes, could do with a lot more cleanup, but I'll stick here for safety.

Hugh

--- 2.5.52/arch/i386/kernel/smpboot.c	Fri Nov 22 23:44:10 2002
+++ linux/arch/i386/kernel/smpboot.c	Wed Dec 18 19:11:25 2002
@@ -806,7 +806,8 @@
 
 	/* So we see what's up   */
 	printk("Booting processor %d/%d eip %lx\n", cpu, apicid, start_eip);
-	stack_start.esp = (void *) (1024 + PAGE_SIZE + (char *)idle->thread_info);
+	/* Stack for startup_32 can be just as for start_secondary onwards */
+	stack_start.esp = (void *) idle->thread.esp;
 
 	/*
 	 * This grunge runs the startup process for
@@ -879,7 +880,7 @@
 			Dprintk("CPU has booted.\n");
 		} else {
 			boot_error= 1;
-			if (*((volatile unsigned char *)phys_to_virt(8192))
+			if (*((volatile unsigned char *)trampoline_base)
 					== 0xA5)
 				/* trampoline started but...? */
 				printk("Stuck ??\n");
@@ -901,7 +902,7 @@
 	}
 
 	/* mark "stuck" area as not stuck */
-	*((volatile unsigned long *)phys_to_virt(8192)) = 0;
+	*((volatile unsigned long *)trampoline_base) = 0;
 
 	if(clustered_apic_mode) {
 		printk("Restoring NMI vector\n");

