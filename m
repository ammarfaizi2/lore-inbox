Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315653AbSEIIbJ>; Thu, 9 May 2002 04:31:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315654AbSEIIbI>; Thu, 9 May 2002 04:31:08 -0400
Received: from [202.135.142.196] ([202.135.142.196]:61200 "EHLO
	wagner.rustcorp.com.au") by vger.kernel.org with ESMTP
	id <S315653AbSEIIbH>; Thu, 9 May 2002 04:31:07 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: torvalds@transmeta.com
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Hotplug CPU prep II: CLONE_IDLETASK
Date: Thu, 09 May 2002 18:34:21 +1000
Message-Id: <E175jNV-0007W9-00@wagner.rustcorp.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, please apply.

This changes CLONE_PID ("if my pid is 0, copy it") to CLONE_IDLETASK
("if I have CAP_SYS_MODULE, set child's pid to zero").

This is requires for creating new idle processes without being an idle
process.

Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

Name: CLONE_PID removal, CLONE_INITTASK added.
Author: Rusty Russell
Depends: Hotcpu/do-fork.patch.gz

D: This patch cleans up the idle thread creation code by redefining
D: CLONE_PID to CLONE_IDLETASK: "create a 0-pid process".

diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal working-2.5.14-dofork/include/linux/sched.h working-2.5.14-dofork+clonepid/include/linux/sched.h
--- working-2.5.14-dofork/include/linux/sched.h	Thu May  9 18:30:41 2002
+++ working-2.5.14-dofork+clonepid/include/linux/sched.h	Thu May  9 18:25:21 2002
@@ -39,7 +39,7 @@
 #define CLONE_FS	0x00000200	/* set if fs info shared between processes */
 #define CLONE_FILES	0x00000400	/* set if open files shared between processes */
 #define CLONE_SIGHAND	0x00000800	/* set if signal handlers and blocked signals shared */
-#define CLONE_PID	0x00001000	/* set if pid shared */
+#define CLONE_IDLETASK	0x00001000	/* set if new pid should be 0 */
 #define CLONE_PTRACE	0x00002000	/* set if we want to let tracing continue on the child too */
 #define CLONE_VFORK	0x00004000	/* set if the parent wants the child to wake it up on mm_release */
 #define CLONE_PARENT	0x00008000	/* set if we want to have the same parent as the cloner */
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal working-2.5.14-dofork/arch/alpha/kernel/smp.c working-2.5.14-dofork+clonepid/arch/alpha/kernel/smp.c
--- working-2.5.14-dofork/arch/alpha/kernel/smp.c	Thu Mar 21 14:14:37 2002
+++ working-2.5.14-dofork+clonepid/arch/alpha/kernel/smp.c	Thu May  9 18:25:22 2002
@@ -439,7 +439,7 @@
 	/* Don't care about the contents of regs since we'll never
 	   reschedule the forked task. */
 	struct pt_regs regs;
-	return do_fork(CLONE_VM|CLONE_PID, 0, &regs, 0);
+	return do_fork(CLONE_VM|CLONE_IDLETASK, 0, &regs, 0);
 }
 
 /*
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal working-2.5.14-dofork/arch/i386/kernel/smpboot.c working-2.5.14-dofork+clonepid/arch/i386/kernel/smpboot.c
--- working-2.5.14-dofork/arch/i386/kernel/smpboot.c	Thu May  9 18:30:41 2002
+++ working-2.5.14-dofork+clonepid/arch/i386/kernel/smpboot.c	Thu May  9 18:25:22 2002
@@ -536,7 +536,7 @@
 	 * don't care about the eip and regs settings since
 	 * we'll never reschedule the forked task.
 	 */
-	return do_fork(CLONE_VM|CLONE_PID, 0, &regs, 0);
+	return do_fork(CLONE_VM|CLONE_IDLETASK, 0, &regs, 0);
 }
 
 /* which physical APIC ID maps to which logical CPU number */
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal working-2.5.14-dofork/arch/ia64/kernel/smpboot.c working-2.5.14-dofork+clonepid/arch/ia64/kernel/smpboot.c
--- working-2.5.14-dofork/arch/ia64/kernel/smpboot.c	Tue Apr 23 11:39:33 2002
+++ working-2.5.14-dofork+clonepid/arch/ia64/kernel/smpboot.c	Thu May  9 18:25:22 2002
@@ -398,7 +398,7 @@
 	 * don't care about the eip and regs settings since
 	 * we'll never reschedule the forked task.
 	 */
-	return do_fork(CLONE_VM|CLONE_PID, 0, 0, 0);
+	return do_fork(CLONE_VM|CLONE_IDLETASK, 0, 0, 0);
 }
 
 static void __init
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal working-2.5.14-dofork/arch/mips/kernel/smp.c working-2.5.14-dofork+clonepid/arch/mips/kernel/smp.c
--- working-2.5.14-dofork/arch/mips/kernel/smp.c	Mon Apr 15 11:47:11 2002
+++ working-2.5.14-dofork+clonepid/arch/mips/kernel/smp.c	Thu May  9 18:25:22 2002
@@ -122,7 +122,7 @@
 
 		/* Spawn a new process normally.  Grab a pointer to
 		   its task struct so we can mess with it */
-		do_fork(CLONE_VM|CLONE_PID, 0, &regs, 0);
+		do_fork(CLONE_VM|CLONE_IDLETASK, 0, &regs, 0);
 		p = prev_task(&init_task);
 
 		/* Schedule the first task manually */
@@ -151,7 +151,7 @@
 		 * The following code is purely to make sure
 		 * Linux can schedule processes on this slave.
 		 */
-		kernel_thread(0, NULL, CLONE_PID);
+		kernel_thread(0, NULL, CLONE_IDLETASK);
 		p = prev_task(&init_task);
 		sprintf(p->comm, "%s%d", "Idle", i);
 		init_tasks[i] = p;
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal working-2.5.14-dofork/arch/mips64/sgi-ip27/ip27-init.c working-2.5.14-dofork+clonepid/arch/mips64/sgi-ip27/ip27-init.c
--- working-2.5.14-dofork/arch/mips64/sgi-ip27/ip27-init.c	Thu Mar 21 14:14:41 2002
+++ working-2.5.14-dofork+clonepid/arch/mips64/sgi-ip27/ip27-init.c	Thu May  9 18:25:22 2002
@@ -490,7 +490,7 @@
 			 * The following code is purely to make sure
 			 * Linux can schedule processes on this slave.
 			 */
-			kernel_thread(0, NULL, CLONE_PID);
+			kernel_thread(0, NULL, CLONE_IDLETASK);
 			p = prev_task(&init_task);
 			sprintf(p->comm, "%s%d", "Idle", num_cpus);
 			init_tasks[num_cpus] = p;
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal working-2.5.14-dofork/arch/ppc/kernel/smp.c working-2.5.14-dofork+clonepid/arch/ppc/kernel/smp.c
--- working-2.5.14-dofork/arch/ppc/kernel/smp.c	Thu May  9 18:30:41 2002
+++ working-2.5.14-dofork+clonepid/arch/ppc/kernel/smp.c	Thu May  9 18:26:00 2002
@@ -343,7 +343,7 @@
 		/* create a process for the processor */
 		/* only regs.msr is actually used, and 0 is OK for it */
 		memset(&regs, 0, sizeof(struct pt_regs));
-		p = do_fork(CLONE_VM|CLONE_PID, 0, &regs, 0);
+		p = do_fork(CLONE_VM|CLONE_IDLETASK, 0, &regs, 0);
 		if (IS_ERR(p))
 			panic("failed fork for CPU %d", i);
 		init_idle(p, i);
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal working-2.5.14-dofork/arch/ppc64/kernel/smp.c working-2.5.14-dofork+clonepid/arch/ppc64/kernel/smp.c
--- working-2.5.14-dofork/arch/ppc64/kernel/smp.c	Mon May  6 11:11:52 2002
+++ working-2.5.14-dofork+clonepid/arch/ppc64/kernel/smp.c	Thu May  9 18:25:22 2002
@@ -640,7 +640,7 @@
 
 		memset(&regs, 0, sizeof(struct pt_regs));
 
-		if (do_fork(CLONE_VM|CLONE_PID, 0, &regs, 0) < 0)
+		if (do_fork(CLONE_VM|CLONE_IDLETASK, 0, &regs, 0) < 0)
 			panic("failed fork for CPU %d", i);
 		p = prev_task(&init_task);
 		if (!p)
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal working-2.5.14-dofork/arch/s390/kernel/smp.c working-2.5.14-dofork+clonepid/arch/s390/kernel/smp.c
--- working-2.5.14-dofork/arch/s390/kernel/smp.c	Thu Mar 21 14:14:41 2002
+++ working-2.5.14-dofork+clonepid/arch/s390/kernel/smp.c	Thu May  9 18:25:22 2002
@@ -511,7 +511,7 @@
        /* don't care about the psw and regs settings since we'll never
           reschedule the forked task. */
        memset(&regs,0,sizeof(struct pt_regs));
-       return do_fork(CLONE_VM|CLONE_PID, 0, &regs, 0);
+       return do_fork(CLONE_VM|CLONE_IDLETASK, 0, &regs, 0);
 }
 
 static void __init do_boot_cpu(int cpu)
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal working-2.5.14-dofork/arch/s390x/kernel/smp.c working-2.5.14-dofork+clonepid/arch/s390x/kernel/smp.c
--- working-2.5.14-dofork/arch/s390x/kernel/smp.c	Thu Mar 21 14:14:41 2002
+++ working-2.5.14-dofork+clonepid/arch/s390x/kernel/smp.c	Thu May  9 18:25:22 2002
@@ -490,7 +490,7 @@
        /* don't care about the psw and regs settings since we'll never
           reschedule the forked task. */
        memset(&regs,0,sizeof(struct pt_regs));
-       return do_fork(CLONE_VM|CLONE_PID, 0, &regs, 0);
+       return do_fork(CLONE_VM|CLONE_IDLETASK, 0, &regs, 0);
 }
 
 static void __init do_boot_cpu(int cpu)
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal working-2.5.14-dofork/arch/sparc/kernel/sun4d_smp.c working-2.5.14-dofork+clonepid/arch/sparc/kernel/sun4d_smp.c
--- working-2.5.14-dofork/arch/sparc/kernel/sun4d_smp.c	Mon May  6 16:00:09 2002
+++ working-2.5.14-dofork+clonepid/arch/sparc/kernel/sun4d_smp.c	Thu May  9 18:25:22 2002
@@ -214,7 +214,7 @@
 			int no;
 
 			/* Cook up an idler for this guy. */
-			kernel_thread(start_secondary, NULL, CLONE_PID);
+			kernel_thread(start_secondary, NULL, CLONE_IDLETASK);
 
 			cpucount++;
 
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal working-2.5.14-dofork/arch/sparc/kernel/sun4m_smp.c working-2.5.14-dofork+clonepid/arch/sparc/kernel/sun4m_smp.c
--- working-2.5.14-dofork/arch/sparc/kernel/sun4m_smp.c	Mon May  6 16:00:09 2002
+++ working-2.5.14-dofork+clonepid/arch/sparc/kernel/sun4m_smp.c	Thu May  9 18:25:22 2002
@@ -187,7 +187,7 @@
 			int timeout;
 
 			/* Cook up an idler for this guy. */
-			kernel_thread(start_secondary, NULL, CLONE_PID);
+			kernel_thread(start_secondary, NULL, CLONE_IDLETASK);
 
 			cpucount++;
 
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal working-2.5.14-dofork/arch/sparc64/kernel/smp.c working-2.5.14-dofork+clonepid/arch/sparc64/kernel/smp.c
--- working-2.5.14-dofork/arch/sparc64/kernel/smp.c	Mon May  6 11:11:52 2002
+++ working-2.5.14-dofork+clonepid/arch/sparc64/kernel/smp.c	Thu May  9 18:25:22 2002
@@ -268,7 +268,7 @@
 			int no;
 
 			prom_printf("Starting CPU %d... ", i);
-			kernel_thread(NULL, NULL, CLONE_PID);
+			kernel_thread(NULL, NULL, CLONE_IDLETASK);
 			cpucount++;
 
 			p = prev_task(&init_task);
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal working-2.5.14-dofork/arch/x86_64/kernel/smpboot.c working-2.5.14-dofork+clonepid/arch/x86_64/kernel/smpboot.c
--- working-2.5.14-dofork/arch/x86_64/kernel/smpboot.c	Tue Apr 23 11:39:33 2002
+++ working-2.5.14-dofork+clonepid/arch/x86_64/kernel/smpboot.c	Thu May  9 18:25:22 2002
@@ -483,7 +483,7 @@
 	 * don't care about the rip and regs settings since
 	 * we'll never reschedule the forked task.
 	 */
-	return do_fork(CLONE_VM|CLONE_PID, 0, &regs, 0);
+	return do_fork(CLONE_VM|CLONE_IDLETASK, 0, &regs, 0);
 }
 
 #if APIC_DEBUG
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal working-2.5.14-dofork/kernel/fork.c working-2.5.14-dofork+clonepid/kernel/fork.c
--- working-2.5.14-dofork/kernel/fork.c	Thu May  9 18:30:41 2002
+++ working-2.5.14-dofork+clonepid/kernel/fork.c	Thu May  9 18:25:22 2002
@@ -136,8 +136,8 @@
 	struct task_struct *p;
 	int pid;
 
-	if (flags & CLONE_PID)
-		return current->pid;
+	if (flags & CLONE_IDLETASK)
+		return 0;
 
 	spin_lock(&lastpid_lock);
 	if((++last_pid) & 0xffff8000) {
@@ -624,13 +624,10 @@
 	retval = -EPERM;
 
 	/* 
-	 * CLONE_PID is only allowed for the initial SMP swapper
-	 * calls
+	 * CLONE_IDLETASK is used to create idle threads.
 	 */
-	if (clone_flags & CLONE_PID) {
-		if (current->pid)
-			goto fork_out;
-	}
+	if ((clone_flags & CLONE_IDLETASK) && !capable(CAP_SYS_MODULE))
+		goto fork_out;
 
 	retval = -ENOMEM;
 	p = dup_task_struct(current);
