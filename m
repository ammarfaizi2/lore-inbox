Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262469AbSLZSvC>; Thu, 26 Dec 2002 13:51:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263039AbSLZSvB>; Thu, 26 Dec 2002 13:51:01 -0500
Received: from [195.39.17.254] ([195.39.17.254]:4100 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S262469AbSLZSvA>;
	Thu, 26 Dec 2002 13:51:00 -0500
Date: Thu, 26 Dec 2002 08:47:11 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Ingo Molnar <mingo@elte.hu>, Jamie Lokier <lk@tantalophile.demon.co.uk>,
       Ulrich Drepper <drepper@redhat.com>, bart@etpmod.phys.tue.nl,
       davej@codemonkey.org.uk, hpa@transmeta.com, terje.eggestad@scali.com,
       matti.aarnio@zmailer.org, hugh@veritas.com,
       linux-kernel@vger.kernel.org
Subject: Re: Intel P6 vs P7 system call performance
Message-ID: <20021226074711.GA170@elf.ucw.cz>
References: <Pine.LNX.4.44.0212221111080.31068-100000@localhost.localdomain> <Pine.LNX.4.44.0212241126020.1219-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0212241126020.1219-100000@home.transmeta.com>
User-Agent: Mutt/1.4i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Ok, one final optimization.
> 
> We have traditionally held ES/DS constant at __KERNEL_DS in the kernel,
> and we've used that to avoid saving unnecessary segment registers over
> context switches etc.
> 
> I realized that there is really no reason to use __KERNEL_DS for this, and
> that as far as the kernel is concerned, the only thing that matters is
> that it's a flat 32-bit segment. So we might as well make the kernel
> always load ES/DS with __USER_DS instead, which has the advantage that we
> can avoid one set of segment loads for the "sysenter/sysexit" case.
> 
> (We still need to load ES/DS at entry to the kernel, since we cannot rely
> on user space not trying to do strange things. But once we load them with
> __USER_DS, we at least don't need to restore them on return to user mode
> any more, since "sysenter" only works in a flat 32-bit user mode anyway
> (*)).
> 
> This doesn't matter much for a P4 (surprisingly, a P4 does very well
> indeed on segment loads), but it does make a difference on PIII-class
> CPU's.
> 
> This makes a PIII do a "getpid()" system call in something like 160
> cycles (a P4 is at 430 cycles, oh well).
> 
> Ingo, would you mind taking a look at the patch, to see if you see any
> paths where we don't follow the new segment register rules. It looks like
> swsuspend isn't properly saving and restoring segment register contents.
> so that will need double-checking (it wasn't correct before either, so
> this doesn't make it any worse, at least).

Does this look like fixing it?
								Pavel

--- clean/arch/i386/kernel/suspend_asm.S	2002-12-18 22:20:47.000000000 +0100
+++ linux-swsusp/arch/i386/kernel/suspend_asm.S	2002-12-26 08:45:34.000000000 +0100
@@ -64,9 +64,10 @@
 	jb .L1455
 	.p2align 4,,7
 .L1453:
-	movl $104,%eax
+	movl $__USER_DS,%eax
 
 	movw %ax, %ds
+	movw %ax, %es
 	movl saved_context_esp, %esp
 	movl saved_context_ebp, %ebp
 	movl saved_context_eax, %eax


-- 
Worst form of spam? Adding advertisment signatures ala sourceforge.net.
What goes next? Inserting advertisment *into* email?
