Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261826AbTHaHVV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Aug 2003 03:21:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261869AbTHaHVV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Aug 2003 03:21:21 -0400
Received: from modemcable009.53-202-24.mtl.mc.videotron.ca ([24.202.53.9]:6786
	"EHLO montezuma.fsmlabs.com") by vger.kernel.org with ESMTP
	id S261826AbTHaHVU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Aug 2003 03:21:20 -0400
Date: Sun, 31 Aug 2003 03:21:04 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
To: Linux Kernel <linux-kernel@vger.kernel.org>
cc: Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>
Subject: [PATCH][2.6-mm] 4/4 linker error (overlapping sections)
Message-ID: <Pine.LNX.4.53.0308310049270.16584@montezuma.fsmlabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I got this on a NUMAQ 32way/32G kernel build with an external patch, i 
had to bump the PAGE_SIZE multiple (which is currently 2) to fix it, but 
how does this patch look instead?

ld: section __ex_table [022cd000 -> 022cd207] overlaps section .entry.text [022cb000 -> 022cdfdf]
ld: section .rodata [022cd220 -> 02314f61] overlaps section .entry.text [022cb000 -> 022cdfdf]

The resultant image is the same (checked with objdump -t before and 
after) and compiles with my patch too.

02562000 g       *ABS*  00000000 __entry_tramp_start
0256373c g       *ABS*  00000000 __entry_tramp_end
02564000 g       *ABS*  00000000 _etext
02564000 l    d  __ex_table     00000000
02564178 g       *ABS*  00000000 __stop___ex_table
02564000 g       *ABS*  00000000 __start___ex_table

Index: linux-2.6.0-test4-mm4/arch/i386/kernel/vmlinux.lds.S
===================================================================
RCS file: /build/cvsroot/linux-2.6.0-test4-mm4/arch/i386/kernel/vmlinux.lds.S,v
retrieving revision 1.2
diff -u -p -B -r1.2 vmlinux.lds.S
--- linux-2.6.0-test4-mm4/arch/i386/kernel/vmlinux.lds.S	31 Aug 2003 03:29:45 -0000	1.2
+++ linux-2.6.0-test4-mm4/arch/i386/kernel/vmlinux.lds.S	31 Aug 2003 06:06:03 -0000
@@ -29,7 +29,8 @@ SECTIONS
   __start___entry_text = .;
   .entry.text : AT (__entry_tramp_start) { *(.entry.text) }
   __entry_tramp_end = __entry_tramp_start + SIZEOF(.entry.text);
-  . = __entry_tramp_start + 2*PAGE_SIZE_asm;
+  . = __entry_tramp_end;
+  . = ALIGN(PAGE_SIZE_asm);
 #else
   .entry.text : { *(.entry.text) }
 #endif
