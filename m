Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261820AbTCaTRI>; Mon, 31 Mar 2003 14:17:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261831AbTCaTRH>; Mon, 31 Mar 2003 14:17:07 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:5385 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S261820AbTCaTRE>; Mon, 31 Mar 2003 14:17:04 -0500
Date: Mon, 31 Mar 2003 11:27:13 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Wayne Whitney <whitney@math.berkeley.edu>
cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] 2.5.65: Caching MSR_IA32_SYSENTER_CS kills dosemu
In-Reply-To: <Pine.LNX.4.44.0303311106560.2060-100000@mf1.private>
Message-ID: <Pine.LNX.4.44.0303311122070.5431-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 31 Mar 2003, Wayne Whitney wrote:
>
> I run dosemu 1.0.2.1 on the 2.5.x kernels.  Upgrading from 2.5.64 to
> 2.5.65 (or 2.5.66) causes dosemu to no longer work:  it locks up the
> machine shortly after I run it.

There appears to be at least one bug (that is longstanding but might be 
made worse by the MSR stuff). However, that one should matter only with 
preemption enabled. What's your configuration?

Also, do you actually have a new library that uses SYSENTER (ie recent 
redhat beta), and whct kind of CPU do you have?

		Linus


----
===== arch/i386/kernel/vm86.c 1.21 vs edited =====
--- 1.21/arch/i386/kernel/vm86.c	Sun Mar  9 18:49:37 2003
+++ edited/arch/i386/kernel/vm86.c	Mon Mar 31 11:23:50 2003
@@ -289,9 +289,10 @@
 	asm volatile("movl %%fs,%0":"=m" (tsk->thread.saved_fs));
 	asm volatile("movl %%gs,%0":"=m" (tsk->thread.saved_gs));
 
-	tss = init_tss + smp_processor_id();
+	tss = init_tss + get_cpu();
 	tss->esp0 = tsk->thread.esp0 = (unsigned long) &info->VM86_TSS_ESP0;
 	disable_sysenter(tss);
+	put_cpu();
 
 	tsk->thread.screen_bitmap = info->screen_bitmap;
 	if (info->flags & VM86_SCREEN_BITMAP)

