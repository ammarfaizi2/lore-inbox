Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751085AbVKJQAd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751085AbVKJQAd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Nov 2005 11:00:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751095AbVKJQAd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Nov 2005 11:00:33 -0500
Received: from fmr22.intel.com ([143.183.121.14]:22929 "EHLO
	scsfmr002.sc.intel.com") by vger.kernel.org with ESMTP
	id S1751085AbVKJQAc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Nov 2005 11:00:32 -0500
Date: Thu, 10 Nov 2005 07:59:32 -0800
From: Ashok Raj <ashok.raj@intel.com>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, ak@muc.de,
       zwane@arm.linux.org.uk, rusty@rustycorp.com.au, vatsa@in.ibm.com,
       jschopp@austin.ibm.com, nathanl@austin.ibm.com,
       anil.s.keshavamurthy@intel.com
Subject: Documentation for CPU hotplug support
Message-ID: <20051110075932.A16271@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew

CPU hotplug support didnt have a readme for general help.

Thanks to Andi for some feedback. 

Consider for -mm so if people have updates they can do when it gets
up the tree.

I added authors as much as i can remember, if roles have changed, please
send updates to this document.

-- 
Cheers,
Ashok Raj
- Open Source Technology Center


First cut Documentation update for cpu hotplug.

Signed-off-by: Ashok Raj <ashok.raj@intel.com>
--------------------------------------------------------
 Documentation/cpu-hotplug.txt |  269 ++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 269 insertions(+)

Index: linux-2.6.14-mm1/Documentation/cpu-hotplug.txt
===================================================================
--- /dev/null
+++ linux-2.6.14-mm1/Documentation/cpu-hotplug.txt
@@ -0,0 +1,269 @@
+					CPU hotplug Support in Linux(tm) Kernel
+
+Authors:
+
+General Core Infrastructure:
+
+Rusty Russell: 		rusty@rustycorp.com.au
+Srivatsa Vaddagiri: vatsa@in.ibm.com
+
+i386:
+Zwane:				zwane@arm.linux.org.uk
+
+ppc64:
+Joel Schopp:		jschopp@austin.ibm.com
+Nathan Lynch:		nathanl@austin.ibm.com
+
+
+ia64/x86_64:
+Ashok Raj			ashok.raj@intel.com
+Anil (ACPI support)	anil.s.keshavamurthy@intel.com
+
+Introduction
+
+	Modern advances in system architectures have introduced advanced error
+reporting and correction capabilities in processors. CPU architectures permit
+partitioning support, where compute resources of a single CPU could be made
+available to virtual machine environments. There are couple OEMS that
+support NUMA hardware which are hot pluggable as well, where physical
+node insertion and removal require CPU hotplug support.
+
+Such advances require CPU available to a kernel to be removed either for
+provisioning reasons, or for RAS purposes to keep an offending CPU off
+system execution path. Hence the need for CPU hotplug support in the
+Linux kernel.
+
+A more novel use of CPU-hotplug support is its use in suspend
+resume support for SMP. Dual-core and HT support makes even
+a laptop run SMP kernels which didn't support these methods. SMP support
+for suspend/resume is a work in progress. This is a work in progress in
+ACPI for now.
+
+General Stuff about CPU Hotplug
+--------------------------------
+
+cpu_possible_map: Bitmap of possible CPUs that can ever be available in the
+system. This is used to allocated some boot time memory for per_cpu variables
+that aren't designed to grow/shrink as CPUs are made available or removed.
+Trimming it accurately for your system needs upfront can save some
+boot time memory. See below for how we use heuristics in x86_64 case
+to keep this under check.
+
+cpu_online_map: Bitmap of all CPUs currently online.
+
+cpu_present_map: Bitmap of CPUs currently present in the system. Not all
+of them may be online. One could choose to start with maxcpus=n boot time
+parameter to limit the number of boot time CPUs.
+
+When manipulating with cpu maps, please use one of the appropriate
+ones already defined.
+
+Never use anything other than cpumask_t to represent
+bitmap of CPUs.
+
+#include <linux/cpumask.h>
+
+for_each_cpu			- Iterate over cpu_possible_map
+for_each_online_cpu		- Iterate over cpu_online_map
+for_each_present_cpu	- Iterate over cpu_present_map
+for_each_cpu_mask(x,mask)	- Iterate over some random collection of cpu mask.
+
+#include <linux/cpu.h>
+lock_cpu_hotplug() and unlock_cpu_hotplug():
+Used to stop cpu hotplug from being started.
+
+CPU Hotplug - Frequently Asked Questions.
+
+Q: How to i enable my kernel to support CPU hotplug?
+A: When doing make defconfig, Enable CPU hotplug support
+
+   "Processor type and Features" -> Support for Hotpluggable CPUs
+
+Make sure that you have CONFIG_HOTPLUG, and CONFIG_SMP turned on as well.
+
+You would need to enable CONFIG_HOTPLUG_CPU for SMP suspend/resume support
+as well.
+
+Q: What architectures support CPU hotplug?
+A: As of 2.6.14, the following architectures support CPU hotplug.
+
+i386 (Intel), ppc, ppc64, parisc, s390, ia64 and x86_64
+
+Q: How to test if hotplug is supported on the newly built kernel?
+A: You should now notice an entry in sysfs.
+
+Check if sysfs is mounted, using the "mount" command. You should notice
+an entry as shown below in the output.
+
+....
+none on /sys type sysfs (rw)
+....
+
+if this is not mounted, do the following.
+
+#mkdir /sysfs
+#mount -t sysfs sys /sys
+
+now you should see entries for all present cpu, the following is an example
+in a 8-way system.
+
+#pwd
+#/sys/devices/system/cpu
+#ls -l
+total 0
+drwxr-xr-x  10 root root 0 Sep 19 07:44 .
+drwxr-xr-x  13 root root 0 Sep 19 07:45 ..
+drwxr-xr-x   3 root root 0 Sep 19 07:44 cpu0
+drwxr-xr-x   3 root root 0 Sep 19 07:44 cpu1
+drwxr-xr-x   3 root root 0 Sep 19 07:44 cpu2
+drwxr-xr-x   3 root root 0 Sep 19 07:44 cpu3
+drwxr-xr-x   3 root root 0 Sep 19 07:44 cpu4
+drwxr-xr-x   3 root root 0 Sep 19 07:44 cpu5
+drwxr-xr-x   3 root root 0 Sep 19 07:44 cpu6
+drwxr-xr-x   3 root root 0 Sep 19 07:48 cpu7
+
+Under each directory you would find an "online" file which is the control
+file to logically online/offline a processor.
+
+Q: What is logical CPU hotplug and Physical CPU hotplug?
+A: Logical CPU hotplug just removes the presence of the CPU from the
+kernel image. Physical CPU hotplug refers to the electrical isolation
+of the CPU from the system. For support of physical hotplug there needs
+to be a method such as ACPI that interfaces with the system BIOS to
+pass notification of removal to kernel, such as the Attention button in
+PCI based hotplug.
+
+Q: How do i logically offline a CPU?
+A: Do the following.
+
+#echo 0 > /sys/devices/system/cpu/cpuX/online
+
+once the logical offline is successful, check
+
+#cat /proc/interrupts
+
+you should now not see the CPU that you removed.
+
+Q: Why cant i remove CPU0 on some systems?
+A: Some architectures may have some special dependency on a certain CPU.
+
+For e.g in IA64 platforms we have ability to sent platform interrupts to the
+OS. a.k.a Corrected Platform Error Interrupts (CPEI). In current ACPI
+specifications, we dint have a way to change the target CPU. Hence if the
+current ACPI version doesn't support such re-direction, we disable that CPU
+by making it not-removable.
+
+Q: How do i find out if a particular CPU is not removable?
+A: Depending on the implementation, some architectures may show this by the
+absence of the "online" file. This is done if it can be determined ahead of
+time that this CPU cannot be removed.
+
+In some situations, this can be a run time check, i.e if you try to remove the
+last CPU, this will not be permitted. You can find such failures by
+investigating the return value of the "echo" command.
+
+Q: What happens when a CPU is being logically offlined?
+A: The following happen, listed in no particular order :-)
+
+- A notification is sent to in-kernel registered modules by sending an event
+  CPU_DOWN_PREPARE
+- All process is migrated away from this outgoing CPU to a new CPU
+- All interrupts targeted to this CPU is migrated to a new CPU
+- timers/bottom half/task lets are also migrated to a new CPU
+- Once all services are migrated, kernel calls an arch specific routine
+  __cpu_disable() to perform arch specific cleanup.
+- Once this is successful, an event for successful cleanup is sent by an event
+  CPU_DEAD.
+
+  "It is expected that each service cleans up when the CPU_DOWN_PREPARE
+  notifier is called, when CPU_DEAD is called its expected there is nothing
+  running on behalf of this CPU that was offlined"
+
+Q: If i have some kernel code that needs to be aware of CPU arrival and
+   departure, how to i arrange for proper notification?
+A: This is what you would need in your kernel code to receive notifications.
+
+    #include <linux/cpu.h>
+	static int __cpuinit foobar_cpu_callback(struct notifier_block *nfb,
+								unsigned long action, void *hcpu)
+	{
+		unsigned int cpu = (unsigned long)hcpu;
+
+		switch (action) {
+		case CPU_ONLINE:
+			foobar_online_action(cpu);
+			break;
+		case CPU_DEAD:
+			foobar_dead_action(cpu);
+			break;
+		}
+		return NOTIFY_OK;
+	}
+
+	static struct notifier_block foobar_cpu_notifer =
+	{
+	   .notifier_call = foobar_cpu_callback,
+	};
+
+
+In your init function,
+
+	register_cpu_notifier(&foobar_cpu_notifier);
+
+You can fail PREPARE notifiers if something doesn't work to prepare resources.
+This will stop the activity and send a following CANCELED event back.
+
+CPU_DEAD should not be failed, its just a goodness indication, but bad
+things will happen if a notifier in path sent a BAD notify code.
+
+Q: I don't see my action being called for all CPUs already up and running?
+A: Yes, CPU notifiers are called only when new CPUs are on-lined or offlined.
+   If you need to perform some action for each cpu already in the system, then
+
+  for_each_online_cpu(i) {
+		foobar_cpu_callback(&foobar_cpu_notifier, CPU_UP_PREPARE, i);
+		foobar_cpu_callback(&foobar-cpu_notifier, CPU_ONLINE, i);
+  }
+
+Q: If i would like to develop cpu hotplug support for a new architecture,
+   what do i need at a minimum?
+A: The following are what is required for CPU hotplug infrastructure to work
+   correctly.
+
+    - Make sure you have an entry in Kconfig to enable CONFIG_HOTPLUG_CPU
+	- __cpu_up() 		- Arch interface to bring up a CPU
+	- __cpu_disable()	- Arch interface to shutdown a CPU, no more interrupts
+						  can be handled by the kernel after the routine
+						  returns. Including local APIC timers etc are
+						  shutdown.
+	- __cpu_die()		- This actually supposed to ensure death of the CPU.
+						  Actually look at some example code in other arch
+						  that implement CPU hotplug. The processor is taken
+						  down from the idle() loop for that specific
+						  architecture. __cpu_die() typically waits for some
+						  per_cpu state to be set, to ensure the processor
+						  dead routine is called to be sure positively.
+
+Q: I need to ensure the a particular cpu is not removed when there is some
+   work specific to this cpu is in progress.
+A: Take a look at drivers/cpufreq/cpufreq.c. Typically you would acquire
+   the cpucontrol lock via lock_cpu_hotplug() and unlock_cpu_hotplug().
+
+   When you are in the notification callbacks, you don't need to acquire the
+   lock. use the current_in_hotplug() call to verify is the current
+   thread is performing the hotplug functions. This will ensure you don't
+   end up with deadlocks trying to acquire cpucontrol while its already held
+   by the current caller.
+
+Q: How do we determine how many CPUs are available for hotplug.
+A: There is no clear spec defined way from ACPI that can give us that
+   information today. Based on some input from Natalie of Unisys,
+   that the MADT ACPI tables marks those possible CPUs in a system with
+   disabled status.
+
+   Andi implemented some simple heuristics that count the number of disabled
+   CPUs in MADT as hotpluggable CPUS.  In the case there are no disabled CPUS
+   we assume 1/2 the number of CPUs currently present can be hotplugged.
+
+   Caveat: Today's MADT can only provide 256 entries since the apicid field
+   in MADT is only 8 bits.
