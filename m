Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262473AbUCHLoY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Mar 2004 06:44:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262477AbUCHLoX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Mar 2004 06:44:23 -0500
Received: from svr44.ehostpros.com ([66.98.192.92]:41601 "EHLO
	svr44.ehostpros.com") by vger.kernel.org with ESMTP id S262473AbUCHLoT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Mar 2004 06:44:19 -0500
From: "Amit S. Kale" <amitkale@emsyssoft.com>
Organization: EmSysSoft
To: Andrew Morton <akpm@osdl.org>
Subject: Re: kgdb for mainline kernel: core-lite [patch 1/3]
Date: Mon, 8 Mar 2004 17:14:05 +0530
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org, trini@kernel.crashing.org, george@mvista.com,
       pavel@ucw.cz
References: <200403081504.30840.amitkale@emsyssoft.com> <20040308030722.01948c93.akpm@osdl.org> <200403081650.18641.amitkale@emsyssoft.com>
In-Reply-To: <200403081650.18641.amitkale@emsyssoft.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200403081714.05521.amitkale@emsyssoft.com>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - svr44.ehostpros.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - emsyssoft.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 08 Mar 2004 4:50 pm, Amit S. Kale wrote:
> On Monday 08 Mar 2004 4:37 pm, Andrew Morton wrote:
> > "Amit S. Kale" <amitkale@emsyssoft.com> wrote:
> > > On Monday 08 Mar 2004 3:56 pm, Andrew Morton wrote:
> > >  > "Amit S. Kale" <amitkale@emsyssoft.com> wrote:
> > >  > > Here are features that are present only in full kgdb:
> > >  > >  1. Thread support  (aka info threads)
> > >  >
> > >  > argh, disaster.  I discussed this with Tom a week or so ago when it
> > >  > looked like this it was being chopped out and I recall being told
> > >  > that the discussion was referring to something else.
> > >  >
> > >  > Ho-hum, sorry.  Can we please put this back in?
> > >
> > >  Err., well this is one of the particularly dirty parts of kgdb. That's
> > > why it's been kept away. It takes care of correct thread backtraces in
> > > some rare cases.
> >
> > Let me just make sure we're taking about the same thing here.  Are you
> > saying that with kgdb-lite, `info threads' is completely missing, or does
> > it just not work correctly with threads (as opposed to heavyweight
> > processes)?
>
> info threads shows a list of threads. Heavy/light weight processes doesn't
> matter. Thread frame shown is incorrect.
>
> I looked at i386 dependent code again. Following code in it is incorrect. I
> never noticed it because this code is rarely used in full version of kgdb:
>
> +void sleeping_thread_to_gdb_regs(unsigned long *gdb_regs, struct
> task_struct *p)
> ....
> +	gdb_regs[_EBP] = *(int *)p->thread.esp;
>
> We can't guss ebp this way. This line should be removed.
>
> +	gdb_regs[_DS] = __KERNEL_DS;
> +	gdb_regs[_ES] = __KERNEL_DS;
> +	gdb_regs[_PS] = 0;
> +	gdb_regs[_CS] = __KERNEL_CS;
> +	gdb_regs[_PC] = p->thread.eip;
> +	gdb_regs[_ESP] = p->thread.esp;
>
> This should be gdb_regs[_ESP] = &p->thread.esp

That's not correct it. It should be gdb_regs[_ESP] = p->thread.esp;
Even with these changes I can't get thread listing correctly.

Here is the intrusive piece of code that helps get thread state correctly. Any 
ideas on cleaning it?

--- linux-2.6.3-kgdb.orig/include/linux/sched.h	2004-02-24 10:44:47.000000000 
+0530
+++ linux-2.6.3-kgdb/include/linux/sched.h	2004-03-04 18:42:56.324188184 +0530
@@ -173,7 +173,9 @@
 
 #define	MAX_SCHEDULE_TIMEOUT	LONG_MAX
 extern signed long FASTCALL(schedule_timeout(signed long timeout));
-asmlinkage void schedule(void);
+asmlinkage void do_schedule(void);
+asmlinkage void kern_schedule(void);
+asmlinkage void kern_do_schedule(struct pt_regs);
 
 struct namespace;
 
@@ -907,6 +909,15 @@
 
 #endif /* CONFIG_SMP */
 
+static inline void schedule(void)
+{
+#ifdef CONFIG_KGDB_THREAD
+	kern_schedule();
+#else
+	do_schedule();
+#endif
+}
+
--- linux-2.6.3-kgdb.orig/kernel/sched.c	2004-03-04 13:38:03.000000000 +0530
+++ linux-2.6.3-kgdb/kernel/sched.c	2004-03-04 18:42:56.327187728 +0530
@@ -1592,7 +1592,7 @@

 /*
  * schedule() is the main scheduler function.
  */
-asmlinkage void schedule(void)
+asmlinkage void do_schedule(void)
 {
 	long *switch_count;
 	task_t *prev, *next;
@@ -1764,6 +1764,23 @@
 
 EXPORT_SYMBOL(default_wake_function);
 
+asmlinkage void user_schedule(void)
+{
+#ifdef CONFIG_KGDB_THREAD
+	current->thread.debuggerinfo = NULL;
+#endif
+	do_schedule();
+}
+
+#ifdef CONFIG_KGDB_THREAD
+asmlinkage void kern_do_schedule(struct pt_regs regs)
+{
+	current->thread.debuggerinfo = &regs;
+	do_schedule();
+	current->thread.debuggerinfo = NULL;
+}
+#endif
+


-Amit

>
> > >  If you consider it an absolutely must, we can do something so that the
> > > dirty part is kept away and info threads almost always works.
> >
> > Yes, I'd consider `info threads' support a must-have.  I'm rather
> > surprised that others do not?
>
> Present threads support code changes calling convention of do_IRQ. Most
> believe that to be an absolute no.
>
> Since you consider it a must-have, I'll check whether above changes
> suggested by me make info threads listing correct in most cases.
>
> -Amit

