Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751027AbWHXKZY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751027AbWHXKZY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 06:25:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751025AbWHXKZY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 06:25:24 -0400
Received: from ausmtp04.au.ibm.com ([202.81.18.152]:5784 "EHLO
	ausmtp04.au.ibm.com") by vger.kernel.org with ESMTP
	id S1751024AbWHXKZX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 06:25:23 -0400
Date: Thu, 24 Aug 2006 15:56:18 +0530
From: Gautham R Shenoy <ego@in.ibm.com>
To: rusty@rustcorp.com.au, torvalds@osdl.org, akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, arjan@intel.linux.com, davej@redhat.com,
       mingo@elte.hu, vatsa@in.ibm.com, dipankar@in.ibm.com,
       ashok.raj@intel.com
Subject: [RFC][PATCH 0/4] Redesign cpu_hotplug locking.
Message-ID: <20060824102618.GA2395@in.ibm.com>
Reply-To: ego@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

While running some tests involving simultaneous cpu_hotplugging
and changing of cpu_freq governors with 2.6.18-rc4-git1 kernel, 
I hit the BUG_ON() in the cpufreq_p4_target(p4-clockmod.c).

------------[ cut here ]------------
kernel BUG at arch/i386/kernel/cpu/cpufreq/p4-clockmod.c:142!
invalid opcode: 0000 [#1]
SMP 
Modules linked in: i2c_piix4 aic7xxx sd_mod
CPU:    0
EIP:    0060:[<c100fd7c>]    Not tainted VLI
EFLAGS: 00010297   (2.6.18-rc4-git1 #1) 
EIP is at cpufreq_p4_target+0xc3/0x12c
eax: f63ba000   ebx: 00000001   ecx: c101e7c3   edx: f63ba000
esi: f757f400   edi: ffffffff   ebp: f63bad58   esp: f63bad38
ds: 007b   es: 007b   ss: 0068
Process bash (pid: 4432, ti=f63ba000 task=f5daa030 task.ti=f63ba000)
Stack: 00000008 00000001 0004c4b4 002625a0 00000002 c100fcb9 f757f400 00000001 
       f63bad74 c120d0d8 ffffffea 002625a0 f757f400 00000001 00000000 f63bad94 
       c120de4c 00000004 c12d8448 c12dfd38 002625a0 00000001 f757f400 f63badbc 
Call Trace:
 [<c1004cf4>] show_stack_log_lvl+0x87/0x8f
 [<c1004e64>] show_registers+0x125/0x18e
 [<c1005057>] die+0x116/0x1e1
 [<c1281812>] do_trap+0x7c/0x96
 [<c1005312>] do_invalid_op+0x95/0x9c
 [<c10049e1>] error_code+0x39/0x40
 [<c120d0d8>] __cpufreq_driver_target+0x54/0x62
 [<c120de4c>] cpufreq_governor_performance+0x34/0x40
 [<c120d194>] __cpufreq_governor+0x57/0xea
 [<c120d45d>] __cpufreq_set_policy+0x151/0x1bd
 [<c120c463>] store_scaling_governor+0x83/0xb8
 [<c120c630>] store+0x38/0x49
 [<c109f384>] flush_write_buffer+0x23/0x2b
 [<c109f3dc>] sysfs_write_file+0x50/0x71
 [<c1067c00>] vfs_write+0xab/0x153
 [<c1067d43>] sys_write+0x3b/0x60
 [<c1003d29>] sysenter_past_esp+0x56/0x8d
Code: 00 83 f8 1f 89 c3 7f 47 89 c1 89 e0 ba 01 00 00 00 25 00 f0 ff ff d3 e2 8b 00 e8 c8 e9 00 00 89 e0 25 00 f0 ff ff 39 58 10 74 08 <0f> 0b 8e 00 43 ff 29 c1 8b 45 e0 8b 14 c5 c0 ee 2f c1 89 d8 e8 
EIP: [<c100fd7c>] cpufreq_p4_target+0xc3/0x12c SS:ESP 0068:f63bad38
 <7>kobject msr1: cleaning up
kobject_uevent
fill_kobj_path: path = '/class/cpuid/cpu1'
kobject cpu1: cleaning up
kobject_uevent
fill_kobj_path: path = '/devices/system/cpu/cpu1'
------------[ cut here ]------------

The problem occured due to a race window opened up by the 2-lock scheme
in cpu_down().

	mutex_lock(&cpu_bitmask_lock);
	p = __stop_machine_run(take_cpu_down, NULL, cpu);
	mutex_unlock(&cpu_bitmask_lock);
	<snip>
	/* Introduces a window here, where stale-data (which _will_ be cleaned
         * up in CPU_DEAD processing) can be accessed, causing  unpleasant
	 * things to occur. This window is opened because of two-lock scheme
	 * in cpu_up and cpu_down.
	 */
				    
	/* CPU is completely dead: tell everyone.  Too late to complain. */
	if (blocking_notifier_call_chain(&cpu_chain, CPU_DEAD,
			(void *)(long)cpu) == NOTIFY_BAD)

The hotplug operation is not complete *until* a CPU_DEAD notification has been
sent to all the subscribers.(cpufreq being one of them). 
As a result, after  __stop_machine_run() on cpuX, there's a window open for
cpufreq to go ahead and try changing frequency on cpuX, since bit corresponding
to cpuX is still set in policy->cpus mask, which will be unset only on 
receiving a CPU_DEAD notification.

In future, we may face simillar scenarios where the subsystems are 
maintaining the snapshot of the online cpus and the snapshot is updated only on a
CPU_UP_PREPARE or a CPU_DEAD event, allowing other tasks to perform some *nasty* 
operation between __stop_machine()_run and CPU_DEAD notification.

To solve this, I eliminated mutex_lock(&cpu_add_remove_lock) from both 
cpu_down and cpu_up and moved mutex_lock(&cpu_bitmask_lock) in its place.
The locks surrounding __stop_machin_run() and __cpu_up() were removed.
This, however gave rise to new set of LUKEWARM IQ's emanating from 
cpufreq_cpu_callback and cpufreq_stat_cpu_callback.

The offending functions were (cpufreq_set_policy &cpufreq_driver_target) and 
cpufreq_update_policy which were being called from cpufreq_cpu_callback and
cpufreq_stat_cpu_callback respectively on CPU_ONLINE and CPU_DOWN_PREPARE
events. These offenders call lock_cpu_hotplug ( YUCK!)

The possible solutions to cpu_hotplug "locking" summarized from the
previous discussion threads are:

i) Clean up the whole code and ensure there are *NO* recursive lock takers.

ii) Have a per-subsystem cpu_hotplug_lock and let cpu_down(/up) acquire
all these locks before performing a hotplug.

iii) Implement cpu_hotplug_lock as Refcount + Waitqueue.

(i) is ugly. We've seen Arjan give a try at cleaning up workqueue + ondemand
mess.

(ii) Though has been introduced recently in workqueue.c , it will only lead to
more deadlock scenarios since more locks would have to be acquired. 

Eg: workqueue + cpufreq(ondemand) ABBA deadlock scenario. Consider
- task1: echo ondemand > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
- task2: echo 0 > /sys/devices/system/cpu/cpu1/online
entering the system at the same time.

task1: calls store_scaling_governor which takes lock_cpu_hotplug.

task2: thru a blocking_notifier_call_chain(CPU_DOWN_PREPARE) 
to workqueue subsystem holds workqueue_mutex.

task1: calls create_workqueue from cpufreq_governor_dbs[ondemand] 
which tries taking workqueue_mutex but can't.

task2: thru blocking_notifier_call_chain(CPU_DOWN_PREPARE) calls
cpufreq_driver_target(cpufreq subsystem),which tries to take lock_cpu_hotplug
but cant since it is already taken by task1.

A typical ABBA deadlock!!!

Replicating this persubsystem-cpu-hotplug lock model across all other
cpu_hotplug-sensitive subsystems would only create more such problems as 
notifier_callback does not follow any specific ordering while notifying 
the subsystems. 

(iii) makes sense as it is closest to RWSEMs. 
So here's an implementation on the lines of (c).

There are two types of tasks interested in cpu_hotplug
- ones who want to *prevent* a hotplug event.
- ones who want to *perform* a cpu hotplug.

For sake of simplicity let's call the former ones readers (though I would 
have prefered inhibitors or somthing fancier!) and latter ones writers.
Let write operation = cpu_hotplug operation.

-The protocol is analogous to RWSEM, *only not so fair* .
- Readers assume control iff:	
	a) No other reader holds a reference and no writer is writing.
	OR							
	b) Atleast one reader holds a reference.				
- The reader is blocked iff a write operation is ongoing.
- Writer gets to perform a write iff:
	*No* reader has a reference AND no writer is writing.
- In any other case, the writer is blocked.
- Writer, on completion would  wake up other waiting writers 
over the waiting readers.
- The *last* reader wakes up the first waiting writer.
- The *last* writer wakes up all the waiting readers.

Rules:
1)Those intending to prevent a hotplug operation, will call 
into cpu_hotplug_disable() and cpu_hotplug_enable(), inplace of
lock_cpu_hotplug and unlock_cpu_hotplug respectively.

2)Those intending to perform a hotplug operation(cpu_up and cpu_down)
will call cpu_hotplug_begin() and cpu_hotplug_done() instead of
mutex_lock(&cpu_add_remove_lock) and mutex_unlock(&cpu_add_remove_lock)
respectively.

3)The callbacks *WILL NOT* try to cpu_hotplug_disable(), because
they are called from a point where the hotplug operation has already
begun. So cpu's won't disappear untill they return.

[patch 1/4]: Cleans up of cpufreq callback code so that Rule (3) is honoured.

[patch 2/4]: Reverts the changes made to kernel/workqueue.c so that Rule(3)
is honoured.

[patch 3/4]:Implements REFCOUNT + WAITQUEUE implementation of cpu_hotplug
"locking".Honours Rule(2). This is the important patch!

[patch 4/4]: Renames lock_cpu_hotplug to cpu_hotplug_disable and 
unlock_cpu_hotplug to cpu_hotplug_enable throughout the kernel, so that
Rule (1) is honoured.

The patches are against linux-2.6.18-rc4-git1.

Awaiting your feedback.

Regards
ego
-- 
Gautham R Shenoy
Linux Technology Center
IBM India.
"Freedom comes with a price tag of responsibility, which is still a bargain,
because Freedom is priceless!"
