Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030368AbVKCQDV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030368AbVKCQDV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 11:03:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030369AbVKCQDU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 11:03:20 -0500
Received: from mailgw.cvut.cz ([147.32.3.235]:32472 "EHLO mailgw.cvut.cz")
	by vger.kernel.org with ESMTP id S1030368AbVKCQDT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 11:03:19 -0500
Message-ID: <436A34C5.2060108@vc.cvut.cz>
Date: Thu, 03 Nov 2005 17:03:17 +0100
From: Petr Vandrovec <vandrove@vc.cvut.cz>
User-Agent: Mozilla/5.0 (X11; U; Linux i686 (x86_64); en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: cs, en
MIME-Version: 1.0
To: ashok.raj@intel.com
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: powernow-k8 schedules in atomic since sunday :-(
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Ashok,
   your change '[PATCH] create and destroy cpufreq sysfs entries based on cpu 
notifiers' causes problems with powernow-k8 driver.  powernow-k8 uses 
set_cpus_allowed() (it even calls schedule() explicitly for no reason), and when 
you've changed code from lock_cpu_hotplug() to preempt_disable() 
set_cpus_allowed() now complains that schedule() is not allowed while preemption 
is disabled...

   I think that some better solution is needed.  As I want cpufreq while my 
system does not support CPU hotplug I've put preempt_{disable,enable} calls you 
added to the __cpufreq_driver_target in my kernel under CONFIG_HOTPLUG_CPU, and 
my system is now as happy as it was before your change.  But I'm sure there is 
solution to use both CPU hotplug and cpufreq at same time...

   Kernel on the system is built with SMP and PREEMPT enabled, together with all 
debugging you can think about.
						Thanks,
							Petr Vandrovec


-- Responsible change --
commit c32b6b8e524d2c337767d312814484d9289550cf
tree 02e634b0b48db6eccc8774369366daa1893921ea
parent d434fca737bee0862625c2377b987a7713b6b487
author Ashok Raj <ashok.raj@intel.com> Sun, 30 Oct 2005 14:59:54 -0800
committer Linus Torvalds <torvalds@g5.osdl.org> Sun, 30 Oct 2005 17:37:14 -0800

     [PATCH] create and destroy cpufreq sysfs entries based on cpu notifiers
     - Converting lock_cpu_hotplug()/unlock_cpu_hotplug() to disable/enable preempt.
     The locking was smack in the middle of the notification path, when the
     hotplug is already holding the lock. I tried another solution to avoid this
     so avoid taking locks if we know we are from notification path. The solution
     was getting very ugly and i decided this was probably good for this iteration
     until someone who understands cpufreq could do a better job than me.

-- relevant dmesg part --
powernow-k8: Found 1 AMD Athlon 64 / Opteron processors (version 1.50.4)
powernow-k8:    0 : fid 0xc (2000 MHz), vid 0x6 (1400 mV)
powernow-k8:    1 : fid 0xa (1800 MHz), vid 0x8 (1350 mV)
powernow-k8:    2 : fid 0x2 (1000 MHz), vid 0x12 (1100 mV)
cpu_init done, current fid 0xc, vid 0x6
scheduling while atomic: modprobe/0x00000001/3920

Call Trace:<ffffffff801cc745>{sysfs_new_dirent+37} <ffffffff80371c3d>{schedule+125}
        <ffffffff80172049>{kmem_cache_alloc+153} 
<ffffffff803746d5>{_spin_unlock_irqrestore+21}
        <ffffffff801371cf>{set_cpus_allowed+351} 
<ffffffff801cc7c9>{sysfs_make_dirent+41}
        <ffffffff8016f660>{check_poison_obj+48} <ffffffff8016f4a6>{poison_obj+70}
        <ffffffff881c4074>{:powernow_k8:powernowk8_target+100}
        <ffffffff803029aa>{__cpufreq_driver_target+90} 
<ffffffff80303bbb>{cpufreq_governor_performance+27}
        <ffffffff80302b31>{__cpufreq_governor+145} 
<ffffffff80302fe2>{__cpufreq_set_policy+306}
        <ffffffff80303077>{cpufreq_set_policy+87} 
<ffffffff803020c4>{cpufreq_add_dev+916}
        <ffffffff803024e0>{handle_update+0} <ffffffff8015b360>{__link_module+0}
        <ffffffff8029d969>{sysdev_driver_register+169} 
<ffffffff80303278>{cpufreq_register_driver+136}
        <ffffffff8015b4d3>{sys_init_module+323} <ffffffff80126881>{ia32_sysret+0}

Debug: sleeping function called from invalid context at include/asm/semaphore.h:105
in_atomic():1, irqs_disabled():0

Call Trace:<ffffffff801392d6>{__might_sleep+198} 
<ffffffff881c4123>{:powernow_k8:powernowk8_target+275}
        <ffffffff803029aa>{__cpufreq_driver_target+90} 
<ffffffff80303bbb>{cpufreq_governor_performance+27}
        <ffffffff80302b31>{__cpufreq_governor+145} 
<ffffffff80302fe2>{__cpufreq_set_policy+306}
        <ffffffff80303077>{cpufreq_set_policy+87} 
<ffffffff803020c4>{cpufreq_add_dev+916}
        <ffffffff803024e0>{handle_update+0} <ffffffff8015b360>{__link_module+0}
        <ffffffff8029d969>{sysdev_driver_register+169} 
<ffffffff80303278>{cpufreq_register_driver+136}
        <ffffffff8015b4d3>{sys_init_module+323} <ffffffff80126881>{ia32_sysret+0}

[hundreds of same/simillar messages removed]

