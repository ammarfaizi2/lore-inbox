Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262643AbTDAVRz>; Tue, 1 Apr 2003 16:17:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262877AbTDAVRz>; Tue, 1 Apr 2003 16:17:55 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:22538 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S262643AbTDAVRx>; Tue, 1 Apr 2003 16:17:53 -0500
Date: Tue, 1 Apr 2003 13:28:01 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Wayne Whitney <whitney@math.berkeley.edu>
cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] 2.5.65: Caching MSR_IA32_SYSENTER_CS kills dosemu
In-Reply-To: <Pine.LNX.4.44.0303311751550.2324-100000@mf1.private>
Message-ID: <Pine.LNX.4.44.0304011320580.13867-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 31 Mar 2003, Wayne Whitney wrote:
> 
> Also, it seems that turning off preempt makes the problem go away.  At
> least, I haven't got any lockups yet.

Can you test this patch? It turns out that "get_cpu()/put_cpu()" are not 
enough - on UP they don't actually disable preemption, since the CPU 
number itself is perfectly stable at 0, of course.

But we need to disable preemption while we re-load esp0, since if we
schedule at that point our esp0 cache in the TSS structures will become
out-of-sync with the actual value of the CPU esp0.

You'd obviously have to re-enable preemption to test this, please..

			Linus

---
===== arch/i386/kernel/vm86.c 1.22 vs edited =====
--- 1.22/arch/i386/kernel/vm86.c	Mon Mar 31 14:30:01 2003
+++ edited/arch/i386/kernel/vm86.c	Tue Apr  1 13:25:28 2003
@@ -113,10 +113,14 @@
 		printk("vm86: could not access userspace vm86_info\n");
 		do_exit(SIGSEGV);
 	}
+
+	preempt_disable();
 	tss = init_tss + smp_processor_id();
 	current->thread.esp0 = current->thread.saved_esp0;
 	load_esp0(tss, current->thread.esp0);
 	current->thread.saved_esp0 = 0;
+	preempt_enable();
+
 	loadsegment(fs, current->thread.saved_fs);
 	loadsegment(gs, current->thread.saved_gs);
 	ret = KVM86->regs32;
@@ -289,10 +293,11 @@
 	asm volatile("movl %%fs,%0":"=m" (tsk->thread.saved_fs));
 	asm volatile("movl %%gs,%0":"=m" (tsk->thread.saved_gs));
 
-	tss = init_tss + get_cpu();
+	preempt_disable();
+	tss = init_tss + smp_processor_id();
 	tss->esp0 = tsk->thread.esp0 = (unsigned long) &info->VM86_TSS_ESP0;
 	disable_sysenter(tss);
-	put_cpu();
+	preempt_enable();
 
 	tsk->thread.screen_bitmap = info->screen_bitmap;
 	if (info->flags & VM86_SCREEN_BITMAP)

