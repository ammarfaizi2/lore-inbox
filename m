Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262758AbSI1J0x>; Sat, 28 Sep 2002 05:26:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262759AbSI1J0x>; Sat, 28 Sep 2002 05:26:53 -0400
Received: from natwar.webmailer.de ([192.67.198.70]:25994 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S262758AbSI1J0v>; Sat, 28 Sep 2002 05:26:51 -0400
Date: Sat, 28 Sep 2002 11:21:30 +0200
From: Dominik Brodowski <linux@brodo.de>
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Cc: hpa@zytor.com, cpufreq@www.linux.org.uk
Subject: cpufreq patches for 2.5.39 follow
Message-ID: <20020928112130.A1217@brodo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.16i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

The following patches add CPU frequency and volatage scaling
support (Intel SpeedStep, AMD PowerNow, etc.) to kernel 2.5.39.

As was discussed during the 2.5.32 cpufreq thread, the cpufreq patches 
have been reworked to use a policy-based approach now. A cpufreq policy 
consists of four values:
cpu	-	the affected CPU nr., or CPUFREQ_ALL_CPUS for all cpus
min	-	minimum frequency in kHz
max	-	maximum frequency in kHz
policy	-	CPUFREQ_POLICY_PERFORMANCE or CPUFREQ_POLICY_POWERSAVE

The interface to userspace is /proc/cpufreq, and the user can "echo" a new
policy into this file using the following syntax:
[cpu:]min_freq:max_freq:policy		or
[cpu%]min_pctg%max_pctg%policy

with policy either "powersave" or "performance". The cpu argument is
optional. 

In cpufreq drivers for "dumb" hardware which can only be set to a specific
frequency (and not to a frequency range), one value within the policy range
is selected, and the CPU is statically set to this frequency until a new
policy is set. "Virtual" dynamic frequency changing is not yet implemented.

For more information, please take a look at the file Documentation/cpufreq in 
patch 4/5.

The patches, as well as backports to 2.4.19 and 2.4.20-pre7 are also 
available at http://www.brodo.de/cpufreq/ :
http://www.brodo.de/cpufreq/cpufreq-2.5.39-core-1
http://www.brodo.de/cpufreq/cpufreq-2.5.39-i386-core-1
http://www.brodo.de/cpufreq/cpufreq-2.5.39-i386-drivers-1
http://www.brodo.de/cpufreq/cpufreq-2.5.39-doc-1
http://www.brodo.de/cpufreq/cpufreq-2.5.39-24api-1


Patch 1/5: cpufreq-core
-----------------------
The cpufreq core offers a common interface to the CPU clock 
speed features of ARM, PPC and x86 CPUs.  

In order for this code to be built, an architecture must define the
CONFIG_CPU_FREQ configuration symbol.  The i386 code follows in
parts 2 and 3, the ARM and PPC ports will most likely follow in the 
next days or weeks.

Specifically on ARM CPUs, cpufreq_notify_transition is especially 
important, since various ARM system on a chip implementations 
derive peripheral clocks from the CPU clock (eg, LCD controllers, 
SDRAM controllers, etc). The core allows these peripherals to take 
action either prior and/or after the actual CPU clock adjustment so 
we don't go out of tolerance. Please note that CPUFREQ_TRANSITION_NOTIFIERS
are only called on "dumb" cpufreq hardware. On Transmeta Crusoe processors,
where core frequency changes have no external implications, these can safely
be ignored.


Patch 2/5: cpufreq-i386-core
----------------------------
The main part of this patch is a CPUFreq transition notifier in 
arch/i386/kernel/time.c. It updates the i386-specific cpu_khz, 
cpu_data[].loops_per_jiffy and fast_gettimeoffset_quotient on 
each frequency change.

Additionally, this patch allows "cpu_khz" to be exported (it is needed 
for some cpufreq drivers) and adds transmeta-related MSR #defines to 
asm-i386/msr.h


Patch 3/5: cpufreq-i386-drivers
-------------------------------
Six i386 CPUFreq drivers are ready to be merged this time. These are:
elanfreq.c:	  The AMD Elan CPU family offers extensive clock scaling
longhaul.c:	  VIA Longhaul processor clock + voltage scaling
longrun.c:        Transmeta Crusoe Longrun clock + voltage scaling
p4-clockmod.c:    clock modulation on P4 Xeon processors
powernow-k6.c:	  mobile AMD K6-2+ / mobile AMD K6-3+ clock scaling
speedstep.c:	  clock and voltage scaling on mobile Intel Pentium 3 and 4s,
		  but (unfortunately) only on ICH2-M or ICH3-M based
                  chipsets.

Support for mobile AMD K7 processors is still in development.


Patch 4/5: cpufreq-doc
----------------------
an entry to the CREDITS and the MAINTAINERS files, Config.help texts, and
extensive documentation in linux/Documentation/cpufreq


Patch 5/5: cpufreq-core-24api
-----------------------------
Some user-space tools already rely on the "old", one-frequency
/proc/sys/cpu/ interface suggested previously. This add-on patch allows a
CONFIG option which emulates this interface but still uses the policy
interface towards the cpufreq drivers.
Please note that the other patches do not rely on this patch and work fine 
without this patch applied, but only with the /proc/cpufreq interface.


Comments welcome; however please ensure that the cpufreq development
list at cpufreq@www.linux.org.uk receives a copy of all comments.

	Dominik
