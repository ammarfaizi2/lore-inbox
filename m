Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262036AbVAYRs6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262036AbVAYRs6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 12:48:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262037AbVAYRs6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 12:48:58 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:38080 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S262036AbVAYRse (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 12:48:34 -0500
Date: Tue, 25 Jan 2005 09:48:13 -0800
From: Jason Uhlenkott <jasonuhl@sgi.com>
To: Sachithanantham_Saravanan@emc.com
Cc: linux-ia64@vger.kernel.org, yakker@sgi.com, yakker@turbolinux.com,
       yakker@alacritech.com, matt@aparity.com, linux-kernel@vger.kernel.org
Subject: Re: LKCD on 2.6 IA64 Linux Kernel
Message-ID: <20050125174813.GA295389@dragonfly.engr.sgi.com>
References: <50C05B7AA7D6924FB5E384EF14BC647BCBBD63@inba1mx2.corp.emc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <50C05B7AA7D6924FB5E384EF14BC647BCBBD63@inba1mx2.corp.emc.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 25, 2005 at 03:16:21PM -0000, Sachithanantham_Saravanan@emc.com wrote:
> Hi all,
> 
> I tried using lkcd on a ia64 machine running on 2.6.5-7.111 SuSe Kernel for
> debugging. I configured the swap device as the dump device and I created
> panics,oops to generate dumps. The dump happens in /var/log/dump on a "lkcd
> save" after a reboot. When I use lcrash to trace the task of the process
> that caused the dump, I get some data misalignment errors as listed below.
> And interestingly this happens only for the trace of the process that
> generated the panic/oops. For all other processes in the dump trace is
> giving me the proper output. Looks like the issue is specific to ia64 as I
> did not encounter any such errors on my i386 machine on the same kernel. 
> Pointers to any patches or what the problem is will be of help to me.
> 
> >> trace
> lcrash(9187): unaligned access to 0x6000000001185ff7, ip=0x400000000004fa90
> lcrash(9187): unaligned access to 0x6000000001185ff6, ip=0x400000000004fa90
> lcrash(9187): unaligned access to 0x6000000001185ff5, ip=0x400000000004fa90
> lcrash(9187): unaligned access to 0x6000000001185ff4, ip=0x400000000004fa90
> Can't find trace for running task!
> ================================================================
> STACK TRACE FOR TASK: 0xe0000001cc458000 (insmod)
> 
> ================================================================

Make sure you have the following, which will synthesize switch_stacks
for running tasks.  This is already in the latest from
lkcd.sourceforge.net and in newer SUSE kernels.


Index: linux/drivers/dump/dump_fmt.c
===================================================================
--- linux.orig/drivers/dump/dump_fmt.c	2004-11-18 11:13:46.454793251 -0800
+++ linux/drivers/dump/dump_fmt.c	2004-11-18 11:14:12.551656418 -0800
@@ -194,19 +194,8 @@
 void dump_lcrash_save_context(int cpu, const struct pt_regs *regs, 
 	struct task_struct *tsk)
 {
-	dump_header_asm.dha_smp_current_task[cpu] = (unsigned long)tsk;
-	if (regs)
-		__dump_save_regs(&dump_header_asm.dha_smp_regs[cpu], regs);
-
-	/* take a snapshot of the stack */
-	/* doing this enables us to tolerate slight drifts on this cpu */
-
-	if (dump_header_asm.dha_stack[cpu]) {
-		memcpy((void *)dump_header_asm.dha_stack[cpu],
-				STACK_START_POSITION(tsk),
-				THREAD_SIZE);
-	}
-	dump_header_asm.dha_stack_ptr[cpu] = (unsigned long)(tsk->thread_info);
+	/* This level of abstraction might be redundantly redundant */
+	__dump_save_context(cpu, regs, tsk);
 }
 
 /* write out the header */
Index: linux/drivers/dump/dump_i386.c
===================================================================
--- linux.orig/drivers/dump/dump_i386.c	2004-11-18 11:13:46.454793251 -0800
+++ linux/drivers/dump/dump_i386.c	2004-11-18 11:14:12.556539265 -0800
@@ -90,6 +90,23 @@
 	}
 }
 
+void
+__dump_save_context(int cpu, const struct pt_regs *regs, 
+	struct task_struct *tsk)
+{
+	dump_header_asm.dha_smp_current_task[cpu] = (unsigned long)tsk;
+	__dump_save_regs(&dump_header_asm.dha_smp_regs[cpu], regs);
+
+	/* take a snapshot of the stack */
+	/* doing this enables us to tolerate slight drifts on this cpu */
+
+	if (dump_header_asm.dha_stack[cpu]) {
+		memcpy((void *)dump_header_asm.dha_stack[cpu],
+				STACK_START_POSITION(tsk),
+				THREAD_SIZE);
+	}
+	dump_header_asm.dha_stack_ptr[cpu] = (unsigned long)(tsk->thread_info);
+}
 
 #ifdef CONFIG_SMP
 extern cpumask_t irq_affinity[];
Index: linux/drivers/dump/dump_ia64.c
===================================================================
--- linux.orig/drivers/dump/dump_ia64.c	2004-11-18 11:13:46.454793251 -0800
+++ linux/drivers/dump/dump_ia64.c	2004-11-18 11:14:12.651266493 -0800
@@ -69,20 +69,45 @@
 	return 0;
 }
 
+/* a structure to get arguments into the following callback routine */
+struct unw_args {
+	int cpu;
+	struct task_struct *tsk;
+};
+
+static void
+do_save_sw(struct unw_frame_info *info, void *arg)
+{
+	struct unw_args *uwargs = (struct unw_args *)arg;
+	int cpu = uwargs->cpu;
+	struct task_struct *tsk = uwargs->tsk;
+
+	dump_header_asm.dha_stack_ptr[cpu] = (uint64_t)info->sw;
+
+	if (tsk && dump_header_asm.dha_stack[cpu]) {
+		memcpy((void *)dump_header_asm.dha_stack[cpu],
+				STACK_START_POSITION(tsk),
+				THREAD_SIZE);
+	}
+}
+
 void
-__dump_save_regs(struct pt_regs *dest_regs, const struct pt_regs *regs)
+__dump_save_context(int cpu, const struct pt_regs *regs, 
+	struct task_struct *tsk)
 {
-	*dest_regs = *regs;
+	struct unw_args uwargs;
 
-        /* In case of panic dumps, we collects regs on entry to panic.
-         * so, we shouldn't 'fix' ssesp here again. But it is hard to
-         * tell just looking at regs whether ssesp need fixing. We make
-         * this decision by looking at xss in regs. If we have better
-         * means to determine that ssesp are valid (by some flag which
-         * tells that we are here due to panic dump), then we can use
-         * that instead of this kludge.
-	 */
-	 
+	dump_header_asm.dha_smp_current_task[cpu] = (unsigned long)tsk;
+
+	if (regs) {
+		dump_header_asm.dha_smp_regs[cpu] = *regs;
+	}
+
+	/* save a snapshot of the stack in a nice state for unwinding */
+	uwargs.cpu = cpu;
+	uwargs.tsk = tsk;
+
+	unw_init_running(do_save_sw, (void *)&uwargs);
 }
 
 #ifdef CONFIG_SMP
Index: linux/drivers/dump/dump_ppc64.c
===================================================================
--- linux.orig/drivers/dump/dump_ppc64.c	2004-11-18 11:13:46.454793251 -0800
+++ linux/drivers/dump/dump_ppc64.c	2004-11-18 11:14:12.567281528 -0800
@@ -219,6 +219,24 @@
 	return 0 /* FIXME */ ;
 }
 
+void
+__dump_save_context(int cpu, const struct pt_regs *regs, 
+	struct task_struct *tsk)
+{
+	dump_header_asm.dha_smp_current_task[cpu] = (unsigned long)tsk;
+	__dump_save_regs(&dump_header_asm.dha_smp_regs[cpu], regs);
+
+	/* take a snapshot of the stack */
+	/* doing this enables us to tolerate slight drifts on this cpu */
+
+	if (dump_header_asm.dha_stack[cpu]) {
+		memcpy((void *)dump_header_asm.dha_stack[cpu],
+				STACK_START_POSITION(tsk),
+				THREAD_SIZE);
+	}
+	dump_header_asm.dha_stack_ptr[cpu] = (unsigned long)(tsk->thread_info);
+}
+
 /*
  * Name: __dump_configure_header()
  * Func: Configure the dump header with all proper values.
Index: linux/drivers/dump/dump_x8664.c
===================================================================
--- linux.orig/drivers/dump/dump_x8664.c	2004-11-18 11:13:46.455769820 -0800
+++ linux/drivers/dump/dump_x8664.c	2004-11-18 11:14:12.572164374 -0800
@@ -76,6 +76,24 @@
 		memcpy(dest_regs, regs, sizeof(struct pt_regs));
 }
 
+void
+__dump_save_context(int cpu, const struct pt_regs *regs, 
+	struct task_struct *tsk)
+{
+	dump_header_asm.dha_smp_current_task[cpu] = (unsigned long)tsk;
+	__dump_save_regs(&dump_header_asm.dha_smp_regs[cpu], regs);
+
+	/* take a snapshot of the stack */
+	/* doing this enables us to tolerate slight drifts on this cpu */
+
+	if (dump_header_asm.dha_stack[cpu]) {
+		memcpy((void *)dump_header_asm.dha_stack[cpu],
+				STACK_START_POSITION(tsk),
+				THREAD_SIZE);
+	}
+	dump_header_asm.dha_stack_ptr[cpu] = (unsigned long)(tsk->thread_info);
+}
+
 #ifdef CONFIG_SMP
 extern cpumask_t irq_affinity[];
 extern irq_desc_t irq_desc[];
Index: linux/include/linux/dump.h
===================================================================
--- linux.orig/include/linux/dump.h	2004-11-18 11:13:46.455769820 -0800
+++ linux/include/linux/dump.h	2004-11-18 11:14:12.587789484 -0800
@@ -408,6 +408,7 @@
 extern void	__dump_cleanup(void);
 extern void	__dump_init(u64);
 extern void	__dump_save_regs(struct pt_regs *, const struct pt_regs *);
+extern void	__dump_save_context(int cpu, const struct pt_regs *, struct task_struct *tsk);
 extern int	__dump_configure_header(const struct pt_regs *);
 extern int	__dump_irq_enable(void);
 extern void	__dump_irq_restore(void);
