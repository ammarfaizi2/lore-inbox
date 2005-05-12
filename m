Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261981AbVELO7x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261981AbVELO7x (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 May 2005 10:59:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262000AbVELO7x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 May 2005 10:59:53 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:9128 "EHLO e33.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S261981AbVELO7f (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 May 2005 10:59:35 -0400
Date: Thu, 12 May 2005 20:40:48 +0530
From: Dinakar Guniguntala <dino@in.ibm.com>
To: Paul Jackson <pj@sgi.com>
Cc: Nathan Lynch <ntl@pobox.com>, Simon.Derr@bull.net,
       lse-tech@lists.sourceforge.net, akpm@osdl.org, nickpiggin@yahoo.com.au,
       vatsa@in.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpusets+hotplug+preepmt broken
Message-ID: <20050512151048.GA3901@in.ibm.com>
Reply-To: dino@in.ibm.com
References: <20050511191654.GA3916@in.ibm.com> <20050511195156.GE3614@otto> <20050511134235.5cecf85c.pj@sgi.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="rwEMma7ioTxnRzrJ"
Content-Disposition: inline
In-Reply-To: <20050511134235.5cecf85c.pj@sgi.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--rwEMma7ioTxnRzrJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, May 11, 2005 at 01:42:35PM -0700, Paul Jackson wrote:
> So what we'd really like to do would be to first fallback to all the
> cpus allowed in the specified tasks cpuset (no walking the cpuset
> hierarchy), and see if any of those cpus are still online to receive
> this orphan task.  Unless someone has botched the system configuration,
> and taken offline all the cpus in a cpuset, this should yield up a cpu
> that is still both allowed and online.  If that fails, then to heck with
> honoring cpuset placement - just take the first online cpu we can find.
> 

I tried your suggestion, but hit another oops. This has more to do with
hotplug+preempt looks like

Code: fc 89 ec 5d e9 8b 0e 00 00 c7 04 24 5c 49 41 c0 e8 7f 39 00 00 e8 da 87 fe ff eb c1 0f 0b 36 11 32 96 41 c0 eb 92 83 f8
 <6>note: cpuoff.sh[25439] exited with preempt_count 1
scheduling while atomic: cpuoff.sh/0x10000001/25439
 [<c04010d2>] schedule+0x4b2/0x4c0
 [<c0152da0>] unmap_page_range+0xc0/0xe0
 [<c0401988>] cond_resched+0x28/0x40
 [<c0152f56>] unmap_vmas+0x196/0x290
 [<c0157c93>] exit_mmap+0xa3/0x1a0
 [<c011ce53>] mmput+0x43/0x100
 [<c01222f0>] do_exit+0xf0/0x3b0
 [<c01047da>] die+0x18a/0x190
 [<c0104bb0>] do_invalid_op+0x0/0xd0
 [<c0104c5e>] do_invalid_op+0xae/0xd0
 [<c011bbe7>] migrate_dead+0xa7/0xc0
 [<c0400f14>] schedule+0x2f4/0x4c0
 [<c040112b>] preempt_schedule+0x4b/0x70
 [<c040112b>] preempt_schedule+0x4b/0x70
 [<c0103fd7>] error_code+0x4f/0x54
 [<c040007b>] svc_proc_unregister+0x1b/0x20
 [<c011007b>] __acpi_map_table+0x7b/0xc0
 [<c011bbe7>] migrate_dead+0xa7/0xc0
 [<c011fef9>] profile_handoff_task+0x39/0x50
 [<c011bc62>] migrate_dead_tasks+0x62/0x90
 [<c011bda6>] migration_call+0x116/0x2c0
 [<c0142102>] __stop_machine_run+0x92/0xb0
 [<c012ddad>] notifier_call_chain+0x2d/0x50
 [<c013a3cb>] cpu_down+0x16b/0x2a0
 [<c027db0b>] store_online+0x5b/0x80
 [<c027ab25>] sysdev_store+0x35/0x40
 [<c019f14e>] flush_write_buffer+0x3e/0x50
 [<c019f1b8>] sysfs_write_file+0x58/0x80
 [<c0163a36>] vfs_write+0xc6/0x180
 [<c0163bc1>] sys_write+0x51/0x80
 [<c01034e5>] syscall_call+0x7/0xb


On 2.6.12-rc4-mm1 it is even worse, it panics

Booting processor 2/1 eip 3000
Calibrating delay using timer specific routine.. 1800.08 BogoMIPS (lpj=900043)
CPU2: Intel Pentium III (Cascades) stepping 04
Unable to handle kernel NULL pointer dereference<7>CPU0 attaching sched-domain:
 at virtual address 00000001
 printing eip:
00000001
*pde = 000001e3
*pte = 00000001
Oops: 0000 [#1]
PREEMPT SMP
Modules linked in:
CPU:    2
EIP:    0060:[<00000001>]    Not tainted VLI
EFLAGS: 00010006   (2.6.12-rc4-mm1)
EIP is at 0x1
eax: c18c0000   ebx: c04758a0   ecx: 00000001   edx: e8c13eb4
esi: ffffffff   edi: c185c030   ebp: c18c1f80   esp: c18c1f2c
ds: 007b   es: 007b   ss: 0068
Process swapper (pid: 0, threadinfo=c18c0000 task=c185c030)
Stack: c0114e0d e8c13eb4 c18c0000 c0103ecc c18c0000 00000008 00000002 ffffffff
       c185c030 c18c1f80 00000001 0000007b 0000007b fffffffb c04048a0 00000060
       00000206 c040511c 00000003 00000000 00000000 c18c0000 c01033ee 00000003
Call Trace:
 [<c0114e0d>] smp_call_function_interrupt+0x3d/0x60
 [<c0103ecc>] call_function_interrupt+0x1c/0x24
 [<c04048a0>] schedule+0x0/0x7c0
 [<c040511c>] preempt_schedule_irq+0x4c/0x80
 [<c01033ee>] need_resched+0x1f/0x21
 [<c011516f>] start_secondary+0x10f/0x1a0
Code:  Bad EIP value.
 <0>Kernel panic - not syncing: Fatal exception in interrupt
Booting processor 3/2 eip 3000
Initializing CPU#3

I really havent had a chance to investigate whats going on, should be able to
do that tomorrow. Here is the patch I tried, my .config and scripts

	-Dinakar



--rwEMma7ioTxnRzrJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="dyn-sd-v0.6-0.patch"

diff -Naurp linux-2.6.12-rc2-mm3.orig/include/linux/cpuset.h linux-2.6.12-rc2-mm3-0/include/linux/cpuset.h
--- linux-2.6.12-rc2-mm3.orig/include/linux/cpuset.h	2005-05-11 19:44:42.000000000 +0530
+++ linux-2.6.12-rc2-mm3-0/include/linux/cpuset.h	2005-05-12 16:54:15.000000000 +0530
@@ -19,6 +19,7 @@ extern void cpuset_init_smp(void);
 extern void cpuset_fork(struct task_struct *p);
 extern void cpuset_exit(struct task_struct *p);
 extern cpumask_t cpuset_cpus_allowed(const struct task_struct *p);
+extern const cpumask_t cpuset_task_cpus_allowed(const struct task_struct *p);
 void cpuset_init_current_mems_allowed(void);
 void cpuset_update_current_mems_allowed(void);
 void cpuset_restrict_to_mems_allowed(unsigned long *nodes);
@@ -38,6 +39,10 @@ static inline cpumask_t cpuset_cpus_allo
 {
 	return cpu_possible_map;
 }
+static inline cpumask_t cpuset_task_cpus_allowed(struct task_struct *p)
+{
+	return cpu_possible_map;
+}
 
 static inline void cpuset_init_current_mems_allowed(void) {}
 static inline void cpuset_update_current_mems_allowed(void) {}
diff -Naurp linux-2.6.12-rc2-mm3.orig/kernel/cpuset.c linux-2.6.12-rc2-mm3-0/kernel/cpuset.c
--- linux-2.6.12-rc2-mm3.orig/kernel/cpuset.c	2005-05-11 19:44:42.000000000 +0530
+++ linux-2.6.12-rc2-mm3-0/kernel/cpuset.c	2005-05-12 17:19:53.000000000 +0530
@@ -1445,6 +1445,31 @@ cpumask_t cpuset_cpus_allowed(const stru
 	return mask;
 }
 
+/**
+ * cpuset_task_cpus_allowed - return cpus_allowed mask from a tasks cpuset.
+ * @tsk: pointer to task_struct from which to obtain cpuset->cpus_allowed.
+ *
+ * Description: Returns the cpumask_t cpus_allowed of the cpuset
+ * attached to the specified @tsk.  Unlike cpuset_cpus_allowed(),
+ * is not guaranteed to return a non-empty subset of cpu_online_map.
+ * Does not walk up the cpuset hierarchy, and does not attempt to
+ * acquire the cpuset_sem.  If called on a task about to exit,
+ * where tsk->cpuset is already NULL, return cpu_online_map.
+ *
+ * Call with task locked.
+ **/
+
+const cpumask_t cpuset_task_cpus_allowed(const struct task_struct *tsk)
+{
+	struct cpuset *cs = tsk->cpuset;
+
+	if (!cs)
+		return cpu_online_map;
+	if (cpus_intersects(cs->cpus_allowed, cpu_online_map))
+		return cs->cpus_allowed;
+	return cpu_online_map;
+}
+
 void cpuset_init_current_mems_allowed(void)
 {
 	current->mems_allowed = NODE_MASK_ALL;
diff -Naurp linux-2.6.12-rc2-mm3.orig/kernel/sched.c linux-2.6.12-rc2-mm3-0/kernel/sched.c
--- linux-2.6.12-rc2-mm3.orig/kernel/sched.c	2005-05-11 19:44:42.000000000 +0530
+++ linux-2.6.12-rc2-mm3-0/kernel/sched.c	2005-05-12 16:50:04.000000000 +0530
@@ -4301,7 +4301,7 @@ static void move_task_off_dead_cpu(int d
 
 	/* No more Mr. Nice Guy. */
 	if (dest_cpu == NR_CPUS) {
-		tsk->cpus_allowed = cpuset_cpus_allowed(tsk);
+		tsk->cpus_allowed = cpuset_task_cpus_allowed(tsk);
 		dest_cpu = any_online_cpu(tsk->cpus_allowed);
 
 		/*

--rwEMma7ioTxnRzrJ
Content-Type: application/x-tar-gz
Content-Disposition: attachment; filename="test-scripts.tar.gz"
Content-Transfer-Encoding: base64

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
JjWpSU36c9N/AHBIqMoAyAAA

--rwEMma7ioTxnRzrJ--
