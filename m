Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265798AbSLXUIh>; Tue, 24 Dec 2002 15:08:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265800AbSLXUIh>; Tue, 24 Dec 2002 15:08:37 -0500
Received: from mx2.elte.hu ([157.181.151.9]:49858 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S265798AbSLXUIg>;
	Tue, 24 Dec 2002 15:08:36 -0500
Date: Tue, 24 Dec 2002 21:20:21 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Jamie Lokier <lk@tantalophile.demon.co.uk>,
       Ulrich Drepper <drepper@redhat.com>, <bart@etpmod.phys.tue.nl>,
       <davej@codemonkey.org.uk>, <hpa@transmeta.com>,
       <terje.eggestad@scali.com>, <matti.aarnio@zmailer.org>,
       <hugh@veritas.com>, <linux-kernel@vger.kernel.org>
Subject: Re: Intel P6 vs P7 system call performance
In-Reply-To: <Pine.LNX.4.44.0212241126020.1219-100000@home.transmeta.com>
Message-ID: <Pine.LNX.4.44.0212242116290.6603-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 24 Dec 2002, Linus Torvalds wrote:

> Ingo, would you mind taking a look at the patch, to see if you see any
> paths where we don't follow the new segment register rules. It looks
> like swsuspend isn't properly saving and restoring segment register
> contents. so that will need double-checking (it wasn't correct before
> either, so this doesn't make it any worse, at least).

this reminds me of another related matter that is not fixed yet, which bug
caused XFree86 to crash if it was linked against the new libpthreads - in
vm86 mode we did not save/restore %gs [and %fs] properly, which breaks
new-style threading. The attached patch is against the 2.4 backport of the
threading stuff, i'll do a 2.5 patch after christmas eve :-)

	Ingo

--- linux/include/asm-i386/processor.h.orig	2002-12-06 11:49:24.000000000 +0100
+++ linux/include/asm-i386/processor.h	2002-12-06 11:52:39.000000000 +0100
@@ -388,6 +388,7 @@
 	struct vm86_struct	* vm86_info;
 	unsigned long		screen_bitmap;
 	unsigned long		v86flags, v86mask, saved_esp0;
+	unsigned int		saved_fs, saved_gs;
 /* IO permissions */
 	int		ioperm;
 	unsigned long	io_bitmap[IO_BITMAP_SIZE+1];
--- linux/arch/i386/kernel/vm86.c.orig	2002-12-06 11:50:26.000000000 +0100
+++ linux/arch/i386/kernel/vm86.c	2002-12-06 11:53:40.000000000 +0100
@@ -113,6 +113,8 @@
 	tss = init_tss + smp_processor_id();
 	tss->esp0 = current->thread.esp0 = current->thread.saved_esp0;
 	current->thread.saved_esp0 = 0;
+	loadsegment(fs, current->thread.saved_fs);
+	loadsegment(gs, current->thread.saved_gs);
 	ret = KVM86->regs32;
 	return ret;
 }
@@ -277,6 +279,9 @@
  */
 	info->regs32->eax = 0;
 	tsk->thread.saved_esp0 = tsk->thread.esp0;
+	asm volatile("movl %%fs,%0":"=m" (tsk->thread.saved_fs));
+	asm volatile("movl %%gs,%0":"=m" (tsk->thread.saved_gs));
+
 	tss = init_tss + smp_processor_id();
 	tss->esp0 = tsk->thread.esp0 = (unsigned long) &info->VM86_TSS_ESP0;
 

