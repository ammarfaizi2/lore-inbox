Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265068AbUETJ6c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265068AbUETJ6c (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 May 2004 05:58:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265014AbUETJ6c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 May 2004 05:58:32 -0400
Received: from ozlabs.org ([203.10.76.45]:19089 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S265068AbUETJ6T (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 May 2004 05:58:19 -0400
Subject: Re: [patch] bug in cpuid & msr on nosmp machine
From: Rusty Russell <rusty@rustcorp.com.au>
To: Andrew Morton <akpm@osdl.org>
Cc: castet.matthieu@free.fr,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20040520015142.0ca69add.akpm@osdl.org>
References: <40AB8CDF.8060408@free.fr>
	 <20040520003240.75fd355d.akpm@osdl.org> <1085042076.7541.27.camel@bach>
	 <20040520015142.0ca69add.akpm@osdl.org>
Content-Type: text/plain
Message-Id: <1085047057.7972.38.camel@bach>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 20 May 2004 19:57:38 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-05-20 at 18:51, Andrew Morton wrote:
> Rusty Russell <rusty@rustcorp.com.au> wrote:
> > One way would be to do lock_cpu_hotplug() in cpuid_open() and introduce
> > a cpuid_close() which would do unlock_cpu_hotplug().  Another would be
> > to drop the check here, and fail the actual read.  A final way is to do
> > no checks, in which case it becomes a noop if the cpu is offline.
> 
> Too many options for me!

And this would be my preferred approach to the "cpu goes offline" race. 
Two patches in one mail is bad form, but it's late, they're short, and
I'm lazy.

Compile tested.

Rusty.

Name: on_one_cpu function
Author: Rusty Russell
Status: Booted on 2.6.5

Similar to on_each_cpu, this implements on_one_cpu.  For archs which
don't do it natively, it's implemented in terms of smp_call_function().

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .21074-linux-2.6.5/include/linux/smp.h .21074-linux-2.6.5.updated/include/linux/smp.h
--- .21074-linux-2.6.5/include/linux/smp.h	2004-03-12 07:57:26.000000000 +1100
+++ .21074-linux-2.6.5.updated/include/linux/smp.h	2004-04-05 16:21:20.000000000 +1000
@@ -8,6 +8,10 @@
 
 #include <linux/config.h>
 
+#define get_cpu()		({ preempt_disable(); smp_processor_id(); })
+#define put_cpu()		preempt_enable()
+#define put_cpu_no_resched()	preempt_enable_no_resched()
+
 #ifdef CONFIG_SMP
 
 #include <linux/preempt.h>
@@ -69,6 +73,24 @@ static inline int on_each_cpu(void (*fun
 	return ret;
 }
 
+#ifndef __HAVE_ARCH_ON_ONE_CPU
+extern int __on_one_cpu(unsigned cpu, void (*func)(void *info), void *info);
+static inline int on_one_cpu(unsigned cpu,
+			     void (*func)(void *info), void *info)
+{
+	int ret;
+
+	if (cpu == get_cpu()) {
+		func(info);
+		ret = 0;
+	} else
+		ret = __on_one_cpu(cpu, func, info);
+	put_cpu();
+	return ret;
+}
+#endif
+
+
 /*
  * True once the per process idle is forked
  */
@@ -123,6 +123,7 @@ void smp_prepare_boot_cpu(void);
 #define smp_threads_ready			1
 #define smp_call_function(func,info,retry,wait)	({ 0; })
 #define on_each_cpu(func,info,retry,wait)	({ func(info); 0; })
+#define on_one_cpu(cpu,func,info)		({ func(info); 0; })
 static inline void smp_send_reschedule(int cpu) { }
 #define num_booting_cpus()			1
 #define smp_prepare_boot_cpu()			do {} while (0)
@@ -107,8 +129,4 @@ static inline void smp_send_reschedule(i
 
 #endif /* !SMP */
 
-#define get_cpu()		({ preempt_disable(); smp_processor_id(); })
-#define put_cpu()		preempt_enable()
-#define put_cpu_no_resched()	preempt_enable_no_resched()
-
 #endif /* __LINUX_SMP_H */
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .21074-linux-2.6.5/kernel/sched.c .21074-linux-2.6.5.updated/kernel/sched.c
--- .21074-linux-2.6.5/kernel/sched.c	2004-04-05 09:04:48.000000000 +1000
+++ .21074-linux-2.6.5.updated/kernel/sched.c	2004-04-05 16:21:45.000000000 +1000
@@ -631,7 +631,29 @@ void kick_process(task_t *p)
 
 EXPORT_SYMBOL_GPL(kick_process);
 
-#endif
+#ifndef __HAVE_ARCH_ON_ONE_CPU
+struct which_cpu
+{
+	unsigned int cpu;
+	void (*func)(void *info);
+	void *info;
+};
+
+static void maybe_on_cpu(void *_which)
+{
+	struct which_cpu *which = _which;
+
+	if (smp_processor_id() == which->cpu)
+		which->func(which->info);
+}
+
+int __on_one_cpu(unsigned cpu, void (*func)(void *info), void *info)
+{
+	struct which_cpu which = { cpu, info };
+	return smp_call_function(maybe_on_cpu, &which, 1, 1);
+}
+#endif /* __HAVE_ARCH_ON_ONE_CPU */
+#endif /* CONFIG_SMP */
 
 /***
  * try_to_wake_up - wake up a thread


Name: Neater returns for i386/x86_64 cpuid/msr on Offline CPUs
Status: Untested
Depends: Misc/i386-cpu_online-BUG.patch.gz
Depends: Misc/on_one_cpu.patch.gz

You can open an MSR or CPUID file on a cpu, and then it can go down.
You'll get junk/noop; nicer to return an error on read/write in this
case.

Use on_one_cpu() as well.  It's just easier to read.

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .8202-linux-2.6.6-bk6/arch/i386/kernel/cpuid.c .8202-linux-2.6.6-bk6.updated/arch/i386/kernel/cpuid.c
--- .8202-linux-2.6.6-bk6/arch/i386/kernel/cpuid.c	2004-05-20 19:40:03.000000000 +1000
+++ .8202-linux-2.6.6-bk6.updated/arch/i386/kernel/cpuid.c	2004-05-20 19:52:36.000000000 +1000
@@ -42,48 +42,33 @@
 #include <asm/uaccess.h>
 #include <asm/system.h>
 
-#ifdef CONFIG_SMP
-
 struct cpuid_command {
-	int cpu;
+	int err;
 	u32 reg;
 	u32 *data;
 };
 
-static void cpuid_smp_cpuid(void *cmd_block)
+static inline void __do_cpuid(void *cmd_block)
 {
 	struct cpuid_command *cmd = (struct cpuid_command *)cmd_block;
 
-	if (cmd->cpu == smp_processor_id())
-		cpuid(cmd->reg, &cmd->data[0], &cmd->data[1], &cmd->data[2],
-		      &cmd->data[3]);
+	cpuid(cmd->reg, &cmd->data[0], &cmd->data[1], &cmd->data[2],
+	      &cmd->data[3]);
+	cmd->err = 0;
 }
 
-static inline void do_cpuid(int cpu, u32 reg, u32 * data)
+static inline int do_cpuid(int cpu, u32 reg, u32 * data)
 {
 	struct cpuid_command cmd;
 
-	preempt_disable();
-	if (cpu == smp_processor_id()) {
-		cpuid(reg, &data[0], &data[1], &data[2], &data[3]);
-	} else {
-		cmd.cpu = cpu;
-		cmd.reg = reg;
-		cmd.data = data;
-
-		smp_call_function(cpuid_smp_cpuid, &cmd, 1, 1);
-	}
-	preempt_enable();
-}
-#else				/* ! CONFIG_SMP */
+	cmd.reg = reg;
+	cmd.data = data;
+	cmd.err = -ENOENT;
 
-static inline void do_cpuid(int cpu, u32 reg, u32 * data)
-{
-	cpuid(reg, &data[0], &data[1], &data[2], &data[3]);
+	on_one_cpu(cpu, __do_cpuid, &cmd);
+	return cmd.err;
 }
 
-#endif				/* ! CONFIG_SMP */
-
 static loff_t cpuid_seek(struct file *file, loff_t offset, int orig)
 {
 	loff_t ret;
@@ -114,13 +99,15 @@ static ssize_t cpuid_read(struct file *f
 	u32 data[4];
 	size_t rv;
 	u32 reg = *ppos;
-	int cpu = iminor(file->f_dentry->d_inode);
+	int err, cpu = iminor(file->f_dentry->d_inode);
 
 	if (count % 16)
 		return -EINVAL;	/* Invalid chunk size */
 
 	for (rv = 0; count; count -= 16) {
-		do_cpuid(cpu, reg, data);
+		err = do_cpuid(cpu, reg, data);
+		if (err)
+			return err;
 		if (copy_to_user(tmp, &data, 16))
 			return -EFAULT;
 		tmp += 4;
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .8202-linux-2.6.6-bk6/arch/i386/kernel/msr.c .8202-linux-2.6.6-bk6.updated/arch/i386/kernel/msr.c
--- .8202-linux-2.6.6-bk6/arch/i386/kernel/msr.c	2004-05-20 19:40:03.000000000 +1000
+++ .8202-linux-2.6.6-bk6.updated/arch/i386/kernel/msr.c	2004-05-20 19:52:49.000000000 +1000
@@ -86,89 +86,53 @@ static inline int rdmsr_eio(u32 reg, u32
   return err;
 }
 
-#ifdef CONFIG_SMP
-
 struct msr_command {
-  int cpu;
   int err;
   u32 reg;
   u32 data[2];
 };
 
-static void msr_smp_wrmsr(void *cmd_block)
+static inline void __msr_wrmsr(void *cmd_block)
 {
   struct msr_command *cmd = (struct msr_command *) cmd_block;
   
-  if ( cmd->cpu == smp_processor_id() )
-    cmd->err = wrmsr_eio(cmd->reg, cmd->data[0], cmd->data[1]);
+  cmd->err = wrmsr_eio(cmd->reg, cmd->data[0], cmd->data[1]);
 }
 
-static void msr_smp_rdmsr(void *cmd_block)
+static inline void __msr_rdmsr(void *cmd_block)
 {
   struct msr_command *cmd = (struct msr_command *) cmd_block;
   
-  if ( cmd->cpu == smp_processor_id() )
-    cmd->err = rdmsr_eio(cmd->reg, &cmd->data[0], &cmd->data[1]);
+  cmd->err = rdmsr_eio(cmd->reg, &cmd->data[0], &cmd->data[1]);
 }
 
 static inline int do_wrmsr(int cpu, u32 reg, u32 eax, u32 edx)
 {
   struct msr_command cmd;
-  int ret;
 
-  preempt_disable();
-  if ( cpu == smp_processor_id() ) {
-    ret = wrmsr_eio(reg, eax, edx);
-  } else {
-    cmd.cpu = cpu;
-    cmd.reg = reg;
-    cmd.data[0] = eax;
-    cmd.data[1] = edx;
-    
-    smp_call_function(msr_smp_wrmsr, &cmd, 1, 1);
-    ret = cmd.err;
-  }
-  preempt_enable();
-  return ret;
+  cmd.reg = reg;
+  cmd.data[0] = eax;
+  cmd.data[1] = edx;
+  cmd.err = -ENOENT;
+
+  on_one_cpu(cpu, __msr_wrmsr, &cmd);
+  return cmd.err;
 }
 
 static inline int do_rdmsr(int cpu, u32 reg, u32 *eax, u32 *edx)
 {
   struct msr_command cmd;
-  int ret;
-
-  preempt_disable();
-  if ( cpu == smp_processor_id() ) {
-    ret = rdmsr_eio(reg, eax, edx);
-  } else {
-    cmd.cpu = cpu;
-    cmd.reg = reg;
-
-    smp_call_function(msr_smp_rdmsr, &cmd, 1, 1);
-    
-    *eax = cmd.data[0];
-    *edx = cmd.data[1];
 
-    ret = cmd.err;
-  }
-  preempt_enable();
-  return ret;
-}
-
-#else /* ! CONFIG_SMP */
+  cmd.reg = reg;
+  cmd.err = -ENOENT;
 
-static inline int do_wrmsr(int cpu, u32 reg, u32 eax, u32 edx)
-{
-  return wrmsr_eio(reg, eax, edx);
-}
+  on_one_cpu(cpu, __msr_rdmsr, &cmd);
 
-static inline int do_rdmsr(int cpu, u32 reg, u32 *eax, u32 *edx)
-{
-  return rdmsr_eio(reg, eax, edx);
+  *eax = cmd.data[0];
+  *edx = cmd.data[1];
+  return cmd.err;
 }
 
-#endif /* ! CONFIG_SMP */
-
 static loff_t msr_seek(struct file *file, loff_t offset, int orig)
 {
   loff_t ret = -EINVAL;


-- 
Anyone who quotes me in their signature is an idiot -- Rusty Russell

