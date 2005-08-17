Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750892AbVHQFmX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750892AbVHQFmX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Aug 2005 01:42:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750893AbVHQFmX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Aug 2005 01:42:23 -0400
Received: from ms-smtp-04.nyroc.rr.com ([24.24.2.58]:10736 "EHLO
	ms-smtp-04.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1750890AbVHQFmW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Aug 2005 01:42:22 -0400
Subject: [RFC][PATCH] Mobil Pentium 4 HT and the NMI
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Wed, 17 Aug 2005 01:42:17 -0400
Message-Id: <1124257337.5764.101.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm trying to get the nmi working with my laptop (IBM ThinkPad G41) and
after debugging it a while, I found that the nmi code doesn't want to
set it up for this particular CPU.

Here I have:

$ cat /proc/cpuinfo
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 15
model           : 4
model name      : Mobile Intel(R) Pentium(R) 4 CPU 3.33GHz
stepping        : 1
cpu MHz         : 3320.084
cache size      : 1024 KB
physical id     : 0
siblings        : 2
core id         : 0
cpu cores       : 1
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 3
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe pni
monitor ds_cpl est tm2 cid xtpr
bogomips        : 6642.39

processor       : 1
vendor_id       : GenuineIntel
cpu family      : 15
model           : 4
model name      : Mobile Intel(R) Pentium(R) 4 CPU 3.33GHz
stepping        : 1
cpu MHz         : 3320.084
cache size      : 1024 KB
physical id     : 0
siblings        : 2
core id         : 0
cpu cores       : 1
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 3
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe pni
monitor ds_cpl est tm2 cid xtpr
bogomips        : 6637.46



And the following code shows:

$ cat linux-2.6.13-rc6/arch/i386/kernel/nmi.c

[...]

void setup_apic_nmi_watchdog (void)
{
        switch (boot_cpu_data.x86_vendor) {
        case X86_VENDOR_AMD:
                if (boot_cpu_data.x86 != 6 && boot_cpu_data.x86 != 15)
                        return;
                setup_k7_watchdog();
                break;
        case X86_VENDOR_INTEL:
                 switch (boot_cpu_data.x86) {
                case 6:
                        if (boot_cpu_data.x86_model > 0xd)
                                return;

                        setup_p6_watchdog();
                        break;
                case 15:
                        if (boot_cpu_data.x86_model > 0x3)
                                return;
 
Here I get boot_cpu_data.x86_model == 0x4.  So I decided to change it
and reboot.  I now seem to have a working NMI.  So, unless there's
something know to be bad about this processor and the NMI. I'm
submitting the following patch.

-- Steve

Signed-off-by: Steven Rostedt <rostedt@goodmis.org>

--- linux-2.6.13-rc6-git1/arch/i386/kernel/nmi.c.orig	2005-08-17 01:34:21.000000000 -0400
+++ linux-2.6.13-rc6-git1/arch/i386/kernel/nmi.c	2005-08-17 01:40:13.000000000 -0400
@@ -195,7 +195,7 @@ static void disable_lapic_nmi_watchdog(v
 			wrmsr(MSR_P6_EVNTSEL0, 0, 0);
 			break;
 		case 15:
-			if (boot_cpu_data.x86_model > 0x3)
+			if (boot_cpu_data.x86_model > 0x4)
 				break;
 
 			wrmsr(MSR_P4_IQ_CCCR0, 0, 0);
@@ -432,7 +432,7 @@ void setup_apic_nmi_watchdog (void)
 			setup_p6_watchdog();
 			break;
 		case 15:
-			if (boot_cpu_data.x86_model > 0x3)
+			if (boot_cpu_data.x86_model > 0x4)
 				return;
 
 			if (!setup_p4_watchdog())


