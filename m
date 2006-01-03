Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964820AbWACVLK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964820AbWACVLK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 16:11:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964819AbWACVHv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 16:07:51 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:50319 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S932539AbWACVHm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 16:07:42 -0500
To: torvalds@osdl.org
Subject: [PATCH 48/50] mips: task_thread_info()
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Message-Id: <E1EttNb-0008Sl-Eq@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Tue, 03 Jan 2006 21:07:39 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

References: <20060103210515.5135@ftp.linux.org.uk>
In-Reply-To: <20060103210515.5135@ftp.linux.org.uk>

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

---

 arch/mips/kernel/ptrace.c           |    2 +-
 arch/mips/kernel/ptrace32.c         |    4 ++--
 arch/mips/kernel/smp_mt.c           |    7 +++----
 arch/mips/kernel/syscall.c          |    2 +-
 arch/mips/kernel/traps.c            |    2 +-
 arch/mips/pmc-sierra/yosemite/smp.c |    4 ++--
 arch/mips/sgi-ip27/ip27-smp.c       |    4 ++--
 arch/mips/sibyte/cfe/smp.c          |    2 +-
 8 files changed, 13 insertions(+), 14 deletions(-)

3d3f558e9c924cc0a4b1ed08493dba5e6aa391e9
diff --git a/arch/mips/kernel/ptrace.c b/arch/mips/kernel/ptrace.c
index 506fef3..9de759e 100644
--- a/arch/mips/kernel/ptrace.c
+++ b/arch/mips/kernel/ptrace.c
@@ -442,7 +442,7 @@ long arch_ptrace(struct task_struct *chi
 		break;
 
 	case PTRACE_GET_THREAD_AREA:
-		ret = put_user(child->thread_info->tp_value,
+		ret = put_user(task_thread_info(child)->tp_value,
 				(unsigned long __user *) data);
 		break;
 
diff --git a/arch/mips/kernel/ptrace32.c b/arch/mips/kernel/ptrace32.c
index 5d022b0..9433f06 100644
--- a/arch/mips/kernel/ptrace32.c
+++ b/arch/mips/kernel/ptrace32.c
@@ -393,7 +393,7 @@ asmlinkage int sys32_ptrace(int request,
 		break;
 
 	case PTRACE_GET_THREAD_AREA:
-		ret = put_user(child->thread_info->tp_value,
+		ret = put_user(task_thread_info(child)->tp_value,
 				(unsigned int __user *) (unsigned long) data);
 		break;
 
@@ -407,7 +407,7 @@ asmlinkage int sys32_ptrace(int request,
 		break;
 
 	case PTRACE_GET_THREAD_AREA_3264:
-		ret = put_user(child->thread_info->tp_value,
+		ret = put_user(task_thread_info(child)->tp_value,
 				(unsigned long __user *) (unsigned long) data);
 		break;
 
diff --git a/arch/mips/kernel/smp_mt.c b/arch/mips/kernel/smp_mt.c
index d429544..794a1c3 100644
--- a/arch/mips/kernel/smp_mt.c
+++ b/arch/mips/kernel/smp_mt.c
@@ -287,6 +287,7 @@ void prom_prepare_cpus(unsigned int max_
  */
 void prom_boot_secondary(int cpu, struct task_struct *idle)
 {
+	struct thread_info *gp = task_thread_info(idle);
 	dvpe();
 	set_c0_mvpcontrol(MVPCONTROL_VPC);
 
@@ -307,11 +308,9 @@ void prom_boot_secondary(int cpu, struct
 	write_tc_gpr_sp( __KSTK_TOS(idle));
 
 	/* global pointer */
-	write_tc_gpr_gp((unsigned long)idle->thread_info);
+	write_tc_gpr_gp((unsigned long)gp);
 
-	flush_icache_range((unsigned long)idle->thread_info,
-					   (unsigned long)idle->thread_info +
-					   sizeof(struct thread_info));
+	flush_icache_range((unsigned long)gp, (unsigned long)(gp + 1));
 
 	/* finally out of configuration and into chaos */
 	clear_c0_mvpcontrol(MVPCONTROL_VPC);
diff --git a/arch/mips/kernel/syscall.c b/arch/mips/kernel/syscall.c
index ee98eeb..42fb39f 100644
--- a/arch/mips/kernel/syscall.c
+++ b/arch/mips/kernel/syscall.c
@@ -262,7 +262,7 @@ asmlinkage int sys_olduname(struct oldol
 
 void sys_set_thread_area(unsigned long addr)
 {
-	struct thread_info *ti = current->thread_info;
+	struct thread_info *ti = task_thread_info(current);
 
 	ti->tp_value = addr;
 
diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
index 7058893..59a1879 100644
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -519,7 +519,7 @@ static inline int simulate_llsc(struct p
  */
 static inline int simulate_rdhwr(struct pt_regs *regs)
 {
-	struct thread_info *ti = current->thread_info;
+	struct thread_info *ti = task_thread_info(current);
 	unsigned int opcode;
 
 	if (unlikely(get_insn_opcode(regs, &opcode)))
diff --git a/arch/mips/pmc-sierra/yosemite/smp.c b/arch/mips/pmc-sierra/yosemite/smp.c
index 0527170..f17f575 100644
--- a/arch/mips/pmc-sierra/yosemite/smp.c
+++ b/arch/mips/pmc-sierra/yosemite/smp.c
@@ -93,8 +93,8 @@ void __init prom_prepare_cpus(unsigned i
  */
 void prom_boot_secondary(int cpu, struct task_struct *idle)
 {
-	unsigned long gp = (unsigned long) idle->thread_info;
-	unsigned long sp = gp + THREAD_SIZE - 32;
+	unsigned long gp = (unsigned long) task_thread_info(idle);
+	unsigned long sp = __KSTK_TOP(idle);
 
 	secondary_sp = sp;
 	secondary_gp = gp;
diff --git a/arch/mips/sgi-ip27/ip27-smp.c b/arch/mips/sgi-ip27/ip27-smp.c
index 3a8291b..dbef3f6 100644
--- a/arch/mips/sgi-ip27/ip27-smp.c
+++ b/arch/mips/sgi-ip27/ip27-smp.c
@@ -168,8 +168,8 @@ void __init prom_prepare_cpus(unsigned i
  */
 void __init prom_boot_secondary(int cpu, struct task_struct *idle)
 {
-	unsigned long gp = (unsigned long) idle->thread_info;
-	unsigned long sp = gp + THREAD_SIZE - 32;
+	unsigned long gp = (unsigned long)task_thread_info(idle);
+	unsigned long sp = __KSTK_TOS(idle);
 
 	LAUNCH_SLAVE(cputonasid(cpu),cputoslice(cpu),
 		(launch_proc_t)MAPPED_KERN_RW_TO_K0(smp_bootstrap),
diff --git a/arch/mips/sibyte/cfe/smp.c b/arch/mips/sibyte/cfe/smp.c
index e848512..4477af3 100644
--- a/arch/mips/sibyte/cfe/smp.c
+++ b/arch/mips/sibyte/cfe/smp.c
@@ -60,7 +60,7 @@ void prom_boot_secondary(int cpu, struct
 
 	retval = cfe_cpu_start(cpu_logical_map(cpu), &smp_bootstrap,
 			       __KSTK_TOS(idle),
-			       (unsigned long)idle->thread_info, 0);
+			       (unsigned long)task_thread_info(idle), 0);
 	if (retval != 0)
 		printk("cfe_start_cpu(%i) returned %i\n" , cpu, retval);
 }
-- 
0.99.9.GIT

