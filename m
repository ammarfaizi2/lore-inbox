Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263680AbTKRQRQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Nov 2003 11:17:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263693AbTKRQRQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Nov 2003 11:17:16 -0500
Received: from modemcable137.219-201-24.mc.videotron.ca ([24.201.219.137]:43907
	"EHLO montezuma.fsmlabs.com") by vger.kernel.org with ESMTP
	id S263680AbTKRQRL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Nov 2003 11:17:11 -0500
Date: Tue, 18 Nov 2003 11:16:06 -0500 (EST)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
cc: Ingo Molnar <mingo@elte.hu>, "Martin J. Bligh" <mbligh@aracnet.com>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
       Hugh Dickins <hugh@veritas.com>
Subject: Re: [PATCH][2.6-mm] Fix 4G/4G X11/vm86 oops
In-Reply-To: <Pine.LNX.4.44.0311180743330.14133-100000@home.osdl.org>
Message-ID: <Pine.LNX.4.53.0311181113150.11537@montezuma.fsmlabs.com>
References: <Pine.LNX.4.44.0311180743330.14133-100000@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Nov 2003, Linus Torvalds wrote:

> Hmm. I don't see anything. However, it's a lot easier to read the
> gcc-generated assembly ("make arch/i386/kernel/vm86.s") than it is to read
> the objdump disassembly.
>
> 
> It's also a lot easier to see what the assembly language is when giving 
> the
> 
> 	-fno-reorder-blocks

I'll recompile and verify that the bug can be reproduced and worked around 
with that flag.
 
> switch to gcc. Without it, modern gcc's tend to have _way_ too many jumps 
> around. But maybe that actually changes the behaviour too.

Here are diffs from the do_sys_vm86 only.

--- asm-before	2003-11-18 10:56:02.967643808 -0500
+++ asm-after	2003-11-18 10:55:37.880457640 -0500
@@ -897,6 +897,10 @@
 .LFE473:
 .Lfe4:
 	.size	sys_vm86,.Lfe4-sys_vm86
+	.section	.rodata.str1.1
+.LC6:
+	.string	"ooh la la\n"
+	.text
 	.p2align 4,,15
 	.type	do_sys_vm86,@function
 do_sys_vm86:
@@ -1053,29 +1057,37 @@
 	jne	.L213
 .L210:
 	.loc 1 315 0
+	pushl	$.LC6
+.LCFI98:
+	call	printk
+	.loc 1 316 0
 	movl	4(%esi), %edx
 #APP
 	xorl %eax,%eax; movl %eax,%fs; movl %eax,%gs
 	movl %edi,%esp
 	movl %edx,%ebp
 	jmp resume_userspace
-	.loc 1 323 0
 #NO_APP
-	popl	%ebx
-.LCFI98:
+.LBE53:
 	popl	%esi
 .LCFI99:
-	popl	%edi
+	.loc 1 324 0
+	popl	%ebx
 .LCFI100:
+	popl	%esi
+.LCFI101:
+	popl	%edi
+.LCFI102:
 	ret
 	.loc 1 313 0
 	.p2align 4,,7
 .L213:
+.LBB65:
 	pushl	%esi
-.LCFI101:
+.LCFI103:
 	call	mark_screen_rdonly
 	popl	%eax
-.LCFI102:
+.LCFI104:
 	jmp	.L210
 	.loc 1 310 0
 .L212:
@@ -1083,7 +1095,7 @@
 	jmp	.L197
 	.loc 14 454 0
 .L211:
-.LBB65:
+.LBB66:
 	movw	36(%edx), %ax
 	movw	%ax, 16(%ecx)
 	.loc 14 455 0
@@ -1097,7 +1109,7 @@
 	.p2align 4,,7
 .L183:
 	.loc 1 283 0
-.LBE65:
+.LBE66:
 	movl	$0, 1468(%esi)
 	.loc 1 284 0
 	jmp	.L182
@@ -1115,7 +1127,7 @@
 	movl	$28672, 1468(%esi)
 	.loc 1 287 0
 	jmp	.L182
-.LBE53:
+.LBE65:
 .LFE475:
 .Lfe5:
 	.size	do_sys_vm86,.Lfe5-do_sys_vm86

