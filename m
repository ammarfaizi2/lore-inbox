Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261889AbTKQVra (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Nov 2003 16:47:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261892AbTKQVra
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Nov 2003 16:47:30 -0500
Received: from modemcable137.219-201-24.mc.videotron.ca ([24.201.219.137]:39555
	"EHLO montezuma.fsmlabs.com") by vger.kernel.org with ESMTP
	id S261889AbTKQVr1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Nov 2003 16:47:27 -0500
Date: Mon, 17 Nov 2003 16:46:22 -0500 (EST)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Ingo Molnar <mingo@elte.hu>
cc: "Martin J. Bligh" <mbligh@aracnet.com>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
       Hugh Dickins <hugh@veritas.com>
Subject: Re: [PATCH][2.6-mm] Fix 4G/4G X11/vm86 oops
In-Reply-To: <Pine.LNX.4.53.0311151427080.30079@montezuma.fsmlabs.com>
Message-ID: <Pine.LNX.4.53.0311171639260.30079@montezuma.fsmlabs.com>
References: <Pine.LNX.4.44.0311141344290.5877-100000@home.osdl.org>
 <Pine.LNX.4.53.0311141954160.27998@montezuma.fsmlabs.com>
 <Pine.LNX.4.53.0311151427080.30079@montezuma.fsmlabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 15 Nov 2003, Zwane Mwaikambo wrote:

> The 4G/4G page fault handling path doesn't appear to handle faults 
> happening whilst in vm86. The regs->xcs != __USER_CS so it confused the in 
> kernel test.
> 
> However i'm still debugging the X11 triple fault in test9-mm3

I've managed to `fix` the triple fault (see further below for the patch 
in all it's glory). Unfortunately i have been unable to come up with a 
simpler workaround which is fewer instructions and easier to debug. I have 
tried the following;

mb()/barrier()
flush_tlb_all()
wbinvd()
outb(0x80,0x00)
local_irq_save(flags); local_irq_enable(); loop(); local_irq_restore(flags);
long_loop()

What i do know is that in the following code;

	__asm__ __volatile__(
		"xorl %%eax,%%eax; movl %%eax,%%fs; movl %%eax,%%gs\n\t"
		"movl %0,%%esp\n\t"
		"movl %1,%%ebp\n\t"
		"jmp resume_userspace"
		: /* no outputs */
		:"r" (&info->regs), "r" (tsk->thread_info) : "ax");

It does get to resume_userspace as putting a $0 into %ebp will oops in 
__switch_to

And here is the current 'workaround'. Any hints?

Index: arch/i386/kernel/vm86.c
===================================================================
RCS file: /build/cvsroot/linux-2.6.0-test9-mm3/arch/i386/kernel/vm86.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 vm86.c
--- arch/i386/kernel/vm86.c	13 Nov 2003 08:07:17 -0000	1.1.1.1
+++ arch/i386/kernel/vm86.c	17 Nov 2003 21:45:13 -0000
@@ -312,6 +311,8 @@ static void do_sys_vm86(struct kernel_vm
 	tsk->thread.screen_bitmap = info->screen_bitmap;
 	if (info->flags & VM86_SCREEN_BITMAP)
 		mark_screen_rdonly(tsk);
+
+	printk("ooh la la\n");
 	__asm__ __volatile__(
 		"xorl %%eax,%%eax; movl %%eax,%%fs; movl %%eax,%%gs\n\t"
 		"movl %0,%%esp\n\t"
