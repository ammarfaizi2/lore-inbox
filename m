Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318989AbSHMTGL>; Tue, 13 Aug 2002 15:06:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318986AbSHMTGL>; Tue, 13 Aug 2002 15:06:11 -0400
Received: from mx1.elte.hu ([157.181.1.137]:49314 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S318989AbSHMTGJ>;
	Tue, 13 Aug 2002 15:06:09 -0400
Date: Tue, 13 Aug 2002 21:09:54 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Christoph Hellwig <hch@infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [patch] CLONE_SETTLS, CLONE_SETTID, 2.5.31-BK
In-Reply-To: <Pine.LNX.4.44.0208131138500.7411-100000@home.transmeta.com>
Message-ID: <Pine.LNX.4.44.0208132100120.7535-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 13 Aug 2002, Linus Torvalds wrote:

> >     CLONE_SETTLS => if present then the third clone() syscall parameter
> >                     is the new TLS.
> > 
> >     CLONE_SETTID => if present then the child TID is written to the
> >                     address specified by the fourth clone() parameter.
> 
> Except you actually test the CLONE_SETTLS bit..

We've tested clone_startup() with real threads on a 2.4-backported version
of yesterday's final TLS API quite extensively, and it works as expected.  
(as we've tested earlier incarnations of the TLS API and code as well.)

This portion of the code is not changed by CLONE_SETTLS - so it should
work equally well, unless i've done something stupid ... I'll backport
this and will fit glibc to the new API later today. (Ulrich's on LW)

> This looks basically ok, although that "struct thread_struct *t" still
> serves no useful purpose..

this was just me shortening some code a bit. I've attached a new patch
that gets rid of those unrelated changes and does the CLONE_SETTLS /
CLONE_SETTID bits only.

	Ingo

--- linux/arch/i386/kernel/process.c.orig	Tue Aug 13 21:08:01 2002
+++ linux/arch/i386/kernel/process.c	Tue Aug 13 21:10:36 2002
@@ -579,6 +579,35 @@
 	unlazy_fpu(tsk);
 	struct_cpy(&p->thread.i387, &tsk->thread.i387);
 
+	/*
+	 * Set a new TLS for the child thread?
+	 */
+	if (clone_flags & CLONE_SETTLS) {
+		struct desc_struct *desc;
+		struct user_desc info;
+		int idx;
+
+		if (copy_from_user(&info, (void *)childregs->esi, sizeof(info)))
+			return -EFAULT;
+		if (LDT_empty(&info))
+			return -EINVAL;
+
+		idx = info.entry_number;
+		if (idx < GDT_ENTRY_TLS_MIN || idx > GDT_ENTRY_TLS_MAX)
+			return -EINVAL;
+
+		desc = p->thread.tls_array + idx - GDT_ENTRY_TLS_MIN;
+		desc->a = LDT_entry_a(&info);
+		desc->b = LDT_entry_b(&info);
+	}
+
+	/*
+	 * Notify the child of the TID?
+	 */
+	if (clone_flags & CLONE_SETTLS)
+		if (put_user(p->pid, (pid_t *)childregs->edx))
+			return -EFAULT;
+
 	if (unlikely(NULL != tsk->thread.ts_io_bitmap)) {
 		p->thread.ts_io_bitmap = kmalloc(IO_BITMAP_BYTES, GFP_KERNEL);
 		if (!p->thread.ts_io_bitmap)
--- linux/include/linux/sched.h.orig	Tue Aug 13 21:01:51 2002
+++ linux/include/linux/sched.h	Tue Aug 13 21:08:56 2002
@@ -45,6 +45,8 @@
 #define CLONE_THREAD	0x00010000	/* Same thread group? */
 #define CLONE_NEWNS	0x00020000	/* New namespace group? */
 #define CLONE_SYSVSEM	0x00040000	/* share system V SEM_UNDO semantics */
+#define CLONE_SETTLS	0x00080000	/* create a new TLS for the child */
+#define CLONE_SETTID	0x00100000	/* write the TID back to userspace */
 
 #define CLONE_SIGNAL	(CLONE_SIGHAND | CLONE_THREAD)
 

