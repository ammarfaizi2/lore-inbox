Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319010AbSHMTbF>; Tue, 13 Aug 2002 15:31:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318997AbSHMTbF>; Tue, 13 Aug 2002 15:31:05 -0400
Received: from mx1.elte.hu ([157.181.1.137]:53156 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S319010AbSHMTbE>;
	Tue, 13 Aug 2002 15:31:04 -0400
Date: Tue, 13 Aug 2002 21:35:05 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Christoph Hellwig <hch@infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [patch] CLONE_SETTLS, CLONE_SETTID, 2.5.31-BK
In-Reply-To: <Pine.LNX.4.44.0208131138500.7411-100000@home.transmeta.com>
Message-ID: <Pine.LNX.4.44.0208132133290.8460-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 13 Aug 2002, Linus Torvalds wrote:

> >     CLONE_SETTID => if present then the child TID is written to the
> >                     address specified by the fourth clone() parameter.
> 
> Except you actually test the CLONE_SETTLS bit..

doh - Joe Perches finally told me how to parse this sentence. Correct
patch is:

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
+	if (clone_flags & CLONE_SETTID)
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
 

