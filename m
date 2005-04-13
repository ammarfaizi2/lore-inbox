Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261184AbVDMIc5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261184AbVDMIc5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Apr 2005 04:32:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261192AbVDMIc4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Apr 2005 04:32:56 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:52667 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261184AbVDMIcd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Apr 2005 04:32:33 -0400
Date: Wed, 13 Apr 2005 10:32:02 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Li Shaohua <shaohua.li@intel.com>
Cc: lkml <linux-kernel@vger.kernel.org>,
       ACPI-DEV <acpi-devel@lists.sourceforge.net>,
       Len Brown <len.brown@intel.com>, Zwane Mwaikambo <zwane@linuxpower.ca>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 6/6]suspend/resume SMP support
Message-ID: <20050413083202.GA1361@elf.ucw.cz>
References: <1113283867.27646.434.camel@sli10-desk.sh.intel.com> <20050412105115.GD17903@elf.ucw.cz> <1113309627.5155.3.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1113309627.5155.3.camel@sli10-desk.sh.intel.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > Using CPU hotplug to support suspend/resume SMP. Both S3 and S4 use
> > > disable/enable_nonboot_cpus API. The S4 part is based on Pavel's
> > > original S4 SMP patch.
> > 
> > I tested it on 2x PII(?) 550MHz system. Suspend went ok, resume loaded
> > image from disk, but then I got
> > 
> > Thawing cpus ....
> > Booting processor 1/0 eip 3000
> > 
> > ...and very funny effect on keyboard leds. They started to blink
> > (panic-like), but with very wrong frequency. It looked like 2 cpus
> > doing panic blinks at once...
> Check if /sys/device/system/cpu/cpu1/online attribute works. If it
> works, then it's other issue. I only tested the patches in two HT based
> systems.

Ok, this is PIII system 550MHz system:

root@hobit:/home/pavel# cat /proc/cpuinfo
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 7
model name      : Pentium III (Katmai)
stepping        : 3
cpu MHz         : 551.309
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
mca cmov pat pse36 mmx fxsr sse
bogomips        : 1085.44

core id         : 255
cpu cores       : 1
processor       : 1
vendor_id       : GenuineIntel
cpu family      : 6
model           : 7
model name      : Pentium III (Katmai)
stepping        : 3
cpu MHz         : 551.309
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
mca cmov pat pse36 mmx fxsr sse
bogomips        : 1097.72

core id         : 255
cpu cores       : 1
root@hobit:/home/pavel#

Offlining CPU seems to work ok:

root@hobit:/sys/devices/system/cpu/cpu1# cat online
1
root@hobit:/sys/devices/system/cpu/cpu1# echo 0 > online
root@hobit:/sys/devices/system/cpu/cpu1# sync
root@hobit:/sys/devices/system/cpu/cpu1# cat /proc/cpuinfo
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 7
model name      : Pentium III (Katmai)
stepping        : 3
cpu MHz         : 551.309
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
mca cmov pat pse36 mmx fxsr sse
bogomips        : 1085.44

core id         : 255
cpu cores       : 1
root@hobit:/sys/devices/system/cpu/cpu1#

Putting cpu back online, I get:

Booting processor 1/0 eip 3000

on console, and mess in syslog. Seems like my cpu #1 panicked but cpu
#0 just keeps going?!

root@hobit:/sys/devices/system/cpu/cpu1# dmesg | tail -20
 [<c02c758f>] vt_console_print+0x24f/0x260
 [<c02c7340>] vt_console_print+0x0/0x260
 [<c01247e7>] __call_console_drivers+0x57/0x60
 [<c01248e0>] call_console_drivers+0x80/0x110
 [<c0124d8e>] release_console_sem+0x4e/0xc0
 [<c0124c12>] vprintk+0x192/0x240
 [<c0528891>] preempt_schedule_irq+0x51/0x80
 [<c02adeca>] acpi_processor_idle+0x0/0x265
 [<c010325e>] need_resched+0x1f/0x21
 [<c02adeca>] acpi_processor_idle+0x0/0x265
 [<c0124a77>] printk+0x17/0x20
 [<c010b583>] cpu_init+0x73/0x360
 [<c0117bd6>] start_secondary+0x6/0x170
Code: d2 74 bd fc 8b 44 24 28 b9 0e 00 00 00 8b 74 24 14 01 c6 b8 0e
00 00 00 89 74 24 1c 8b 74 24 30 89 44 24 10 8b 7c 24 1c 83 c6 10 <f3>
a5 8b 74 24 24 8b 44 24 1c 89 4c 24 10 01 ee f7 d5 21 ee 89
 <0>Kernel panic - not syncing: Attempted to kill the idle task!
 Stuck ??
Inquiring remote APIC #0...
... APIC #0 ID: 00000000
... APIC #0 VERSION: 00040011
... APIC #0 SPIV: 000000ff
root@hobit:/sys/devices/system/cpu/cpu1# dmesg | tail -25
 [<c011d001>] activate_task+0x1/0xa0
 [<c011d128>] resched_task+0x68/0x90
 [<c011d8ba>] try_to_wake_up+0x2aa/0x2f0
 [<c025ed7a>] fbcon_cursor+0x19a/0x270
 [<c02c4958>] hide_cursor+0x18/0x30
 [<c02c758f>] vt_console_print+0x24f/0x260
 [<c02c7340>] vt_console_print+0x0/0x260
 [<c01247e7>] __call_console_drivers+0x57/0x60
 [<c01248e0>] call_console_drivers+0x80/0x110
 [<c0124d8e>] release_console_sem+0x4e/0xc0
 [<c0124c12>] vprintk+0x192/0x240
 [<c0528891>] preempt_schedule_irq+0x51/0x80
 [<c02adeca>] acpi_processor_idle+0x0/0x265
 [<c010325e>] need_resched+0x1f/0x21
 [<c02adeca>] acpi_processor_idle+0x0/0x265
 [<c0124a77>] printk+0x17/0x20
 [<c010b583>] cpu_init+0x73/0x360
 [<c0117bd6>] start_secondary+0x6/0x170
Code: d2 74 bd fc 8b 44 24 28 b9 0e 00 00 00 8b 74 24 14 01 c6 b8 0e
00 00 00 89 74 24 1c 8b 74 24 30 89 44 24 10 8b 7c 24 1c 83 c6 10 <f3>
a5 8b 74 24 24 8b 44 24 1c 89 4c 24 10 01 ee f7 d5 21 ee 89
 <0>Kernel panic - not syncing: Attempted to kill the idle task!
 Stuck ??
Inquiring remote APIC #0...
... APIC #0 ID: 00000000
... APIC #0 VERSION: 00040011
... APIC #0 SPIV: 000000ff
root@hobit:/sys/devices/system/cpu/cpu1#

								Pavel
-- 
Boycott Kodak -- for their patent abuse against Java.
