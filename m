Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261771AbTILSDD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Sep 2003 14:03:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261786AbTILSDD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Sep 2003 14:03:03 -0400
Received: from f04s07.cac.psu.edu ([128.118.141.35]:46838 "EHLO
	f04n07.cac.psu.edu") by vger.kernel.org with ESMTP id S261771AbTILSBV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Sep 2003 14:01:21 -0400
To: linux-kernel@vger.kernel.org
Subject: IBM X31 laptop, apm, test[245]
From: bxf4@psu.edu (Brian P. Flaherty)
Date: Fri, 12 Sep 2003 14:01:20 -0400
Message-ID: <87isnx51jj.fsf@havers.hhdev.psu.edu>
User-Agent: Gnus/5.1002 (Gnus v5.10.2) Emacs/21.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I have encountered a problem with APM on 2.6-test[45], compared with
test2.  I think this is related to the kernel's apm.  I have APM on
in the BIOS.  I am using both suspend and hibernation in the BIOS, not
swsusp.  Both work under Debian kernel 2.4.21-4-686.  Hibernation
works fine under test2.  That is, when I close the lid or press Fn-F12
(the hibernation key combination), the screen goes blank, the little
moon flashes, and the hard-disk is going.  Eventually, the IBM
hibernation picture and progress bar comes up.  Then, once the
hibernation save is done, it goes into suspend mode for 30 minutes and
then shuts down.  After suspend ends, I can restart the machine from
hibernation by pressing the power button.  It comes up and I can
continue to work.  I am pretty sure that suspend also works under
test2.  I can go into suspend and then restore, if I stop the apmd
driver before suspending.  (I think that is necessary on this machine
with test2, I'm still working on this problem.)  All this is using
2.6.0-test2 built from Debian's source package.

Under 2.6.0-test4 and test5, suspend and hibernate don't work.  If I
press the suspend or hibernate keys, the screen goes blank, the little
moon flashes, but there is no disk activity.  The hibernation file
isn't saved and the machine hangs in this pre-suspend state.  I need
to power-cycle it to get it back.  Both test4 and test5 sources were
downloaded from kernel.org, and with test4 sources, I did try the mm6
patches.  Also, there doesn't appear to be an oops file associated
with these hangs.  I checked /var/log/ksymoops, but don't see any
here.

The apm section of my kernel .configs for test2 and test5 are
identical.  (I've only been working with test5 lately, not test4.)

#
# Power management options (ACPI, APM)
#
CONFIG_PM=y
CONFIG_SOFTWARE_SUSPEND=y

#
# ACPI Support
#
# CONFIG_ACPI is not set
CONFIG_APM=y
# CONFIG_APM_IGNORE_USER_SUSPEND is not set
CONFIG_APM_DO_ENABLE=y
CONFIG_APM_CPU_IDLE=y
CONFIG_APM_DISPLAY_BLANK=y
CONFIG_APM_RTC_IS_GMT=y
CONFIG_APM_ALLOW_INTS=y
# CONFIG_APM_REAL_MODE_POWER_OFF is not set


I diff'ed the apm.c file in my Debian test2 source and in test5 (test2 is the
first file):

511c511
< static unsigned long apm_save_cpus(void)
---
> static cpumask_t apm_save_cpus(void)
513c513
< 	unsigned long x = current->cpus_allowed;
---
> 	cpumask_t x = current->cpus_allowed;
515c515
< 	set_cpus_allowed(current, 1UL << 0);
---
> 	set_cpus_allowed(current, cpumask_of_cpu(0));
520c520
< static inline void apm_restore_cpus(unsigned long mask)
---
> static inline void apm_restore_cpus(cpumask_t mask)
531c531
< #define apm_save_cpus()	0
---
> #define apm_save_cpus()		(current->cpus_allowed)
596c596
< 	unsigned long		cpus;
---
> 	cpumask_t		cpus;
638c638
< 	unsigned long		cpus;
---
> 	cpumask_t		cpus;
916c916
< 	set_cpus_allowed(current, 1UL << 0);
---
> 	set_cpus_allowed(current, cpumask_of_cpu(0));
1201c1201
< 	device_suspend(3, SUSPEND_POWER_DOWN);
---
> 	device_suspend(3);
1235c1235
< 	device_resume(RESUME_POWER_ON);
---
> 	device_resume();
1349c1349
< 				device_resume(RESUME_POWER_ON);
---
> 				device_resume();
1707c1707
< 	set_cpus_allowed(current, 1UL << 0);
---
> 	set_cpus_allowed(current, cpumask_of_cpu(0));
2083c2083
< 
---
> MODULE_ALIAS_MISCDEV(APM_MINOR_DEV);

Before I start copying parts of test2 apm.c into the test5 version, I
wanted to ask knowledgeable people about it.  Any suggestions will be
welcome.

My system information follows.  If there's more to tell, let me know.
Thanks for your time.

Brian Flaherty


System information:
IBM Thinkpad X31, Type 2672

cat /proc/cpuinfo: 
processor	: 0
vendor_id	: GenuineIntel
cpu family	: 6
model		: 9
model name	: Intel(R) Pentium(R) M processor 1400MHz
stepping	: 5
cpu MHz		: 599.527
cache size	: 1024 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 2
wp		: yes
flags		: fpu vme de pse tsc msr mce cx8 apic sep mtrr pge mca \
 cmov pat clflush dts acpi mmx fxsr sse sse2 tm pbe tm2 est
bogomips	: 1186.66

(cpudynd is running)

gautama:~# free
             total       used       free     shared    buffers
             cached
Mem:       1034940      39864     995076          0       4720
             16112
-/+ buffers/cache:      19032    1015908
Swap:      1421272          0    1421272

uname -a 
Linux gautama 2.6.0-test2 #1 Thu Sep 11 11:49:54 EDT 2003 i686 GNU/Linux

gautama:~# hdparm /dev/hda

/dev/hda:
 multcount    = 16 (on)
 IO_support   =  0 (default 16-bit)
 unmaskirq    =  0 (off)
 using_dma    =  1 (on)
 keepsettings =  0 (off)
 readonly     =  0 (off)
 readahead    = 256 (on)
 geometry     = 5901/16/63, sectors = 72008693, start = 0

gautama:~# lspci
00:00.0 Host bridge: Intel Corp.: Unknown device 3340 (rev 03)
00:01.0 PCI bridge: Intel Corp.: Unknown device 3341 (rev 03)
00:1d.0 USB Controller: Intel Corp. 82801DB USB (Hub #1) (rev 01)
00:1d.1 USB Controller: Intel Corp. 82801DB USB (Hub #2) (rev 01)
00:1d.2 USB Controller: Intel Corp. 82801DB USB (Hub #3) (rev 01)
00:1d.7 USB Controller: Intel Corp. 82801DB USB EHCI Controller (rev 01)
00:1e.0 PCI bridge: Intel Corp. 82801BAM/CAM PCI Bridge (rev 81)
00:1f.0 ISA bridge: Intel Corp.: Unknown device 24cc (rev 01)
00:1f.1 IDE interface: Intel Corp.: Unknown device 24ca (rev 01)
00:1f.3 SMBus: Intel Corp. 82801DB SMBus (rev 01)
00:1f.5 Multimedia audio controller: Intel Corp. 82801DB AC'97 Audio (rev 01)
00:1f.6 Modem: Intel Corp. 82801DB AC'97 Modem (rev 01)
01:00.0 VGA compatible controller: ATI Technologies Inc Radeon Mobility M6 LY
02:00.0 CardBus bridge: Ricoh Co Ltd RL5c476 II (rev aa)
02:00.1 CardBus bridge: Ricoh Co Ltd RL5c476 II (rev aa)
02:00.2 FireWire (IEEE 1394): Ricoh Co Ltd R5C552 IEEE 1394 Controller (rev 02)
02:01.0 Ethernet controller: Intel Corp.: Unknown device 101e (rev 03)
02:02.0 Network controller: Intel Corp.: Unknown device 1043 (rev 04)

Program versions:

gcc (GCC) 3.3.1 20030626 (Debian prerelease)
Copyright (C) 2003 Free Software Foundation, Inc.
This is free software; see the source for copying conditions.  There is NO
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

GNU ld version 2.14.90.0.4 20030523 Debian GNU/Linux
Copyright 2002 Free Software Foundation, Inc.
This program is free software; you may redistribute it under the terms of
the GNU General Public License.  This program has absolutely no warranty.

module-init-tools version 0.9.13-pre

