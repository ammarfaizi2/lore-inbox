Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262430AbTD3Ujj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Apr 2003 16:39:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262437AbTD3Ujj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Apr 2003 16:39:39 -0400
Received: from mail.gmx.de ([213.165.65.60]:62403 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S262430AbTD3Ujc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Apr 2003 16:39:32 -0400
Date: Wed, 30 Apr 2003 22:51:46 +0200
From: Felix =?ISO-8859-1?B?S/xobGluZw==?= <fxkuehl@gmx.de>
To: linux-kernel@vger.kernel.org
Cc: mingo@redhat.com
Subject: [PATCH] PROBLEM: BIOS hangs after reboot with local APIC
Message-Id: <20030430225146.5eaa3f55.felix@viking.nest>
X-Mailer: Sylpheed version 0.7.4 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

when I reboot my laptop the BIOS complains about a keyboard controller
failure and timer interrupts not working. On the BIOS password screen
the keyboard doesn't work. If I disable the BIOS password the system
hangs a bit later on the POST screen. I tried all reboot methods via the
kernel command line without success. I saw this problem with Debian
Woody's precompiled 2.4.18 kernel, self compiled Debian 2.4.20 sources
and Linux 2.4.21-rc1+ACPI patch. This problem only occurs if
CONFIG_X86_LOCAL_APIC is enabled. With CONFIG_X86_LOCAL_APIC disabled it
reboots just fine.

My guess is that it's a BIOS bug as I've never had this problem on other
machines before. I found a workaround: disable the local APIC before
rebooting. I don't really know how it works. Just calling
disable_local_APIC wasn't enough, so I copied a bit more code from
apic_pm_suspend (arch/i386/kernel/apic.c:465) to machine_restart
(arch/i386/kernel/process.c:369). I'm pretty sure that this is not the
proper way to do it but it works here. A patch against 2.4.21-rc1 can be
found at the end of this email.

Best regards,
  Felix

System Information:

Linux 2.4.21-rc1 with acpi-20030424-2.4.21-rc1.diff.gz

Output from scripts/ver_linux:
Linux trabant 2.4.21-rc1 #16 Wed Apr 30 20:07:14 CEST 2003 i686 mobile AMD Athlon(tm) XP 2000+ AuthenticAMD GNU/Linux
 
Gnu C                  gcc-3.2 (GCC) 3.2.3 20030309 (Debian prerelease)
Gnu make               3.80
util-linux             2.11y
mount                  2.11y
modutils               2.4.21
e2fsprogs              1.32
pcmcia-cs              3.1.33
PPP                    2.4.2b3
Linux C Library        2.3.1
Dynamic linker (ldd)   2.3.1
Procps                 3.1.6
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               4.5.2
Modules Loaded         soundcore input ohci1394 ieee1394 via-rhine mii ehci-hcd usb-uhci usbcore rtc

/proc/cpuinfo
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 8
model name      : mobile AMD Athlon(tm) XP 2000+
stepping        : 1
cpu MHz         : 1658.556
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 mmx fxsr sse syscall mmxext 3dnowext 3dnow
bogomips        : 3309.56

/proc/interrupts
           CPU0       
  0:     276279          XT-PIC  timer
  1:        641          XT-PIC  keyboard
  2:          0          XT-PIC  cascade
  5:          2          XT-PIC  ohci1394
  8:          4          XT-PIC  rtc
  9:          5          XT-PIC  acpi
 10:        877          XT-PIC  usb-uhci, eth0
 11:          0          XT-PIC  PCI device 1524:1410 (ENE Technology Inc), usb-uhci, ehci-hcd
 12:        536          XT-PIC  PS/2 Mouse
 14:       7100          XT-PIC  ide0
 15:          1          XT-PIC  ide1
NMI:          0 
LOC:     275894 
ERR:        167

/proc/ioports
0000-001f : dma1
0020-003f : pic1
0040-005f : timer
0060-006f : keyboard
0070-007f : rtc
0080-008f : dma page reg
00a0-00bf : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-0177 : ide1
01f0-01f7 : ide0
0376-0376 : ide1
03c0-03df : vesafb
03f6-03f6 : ide0
0cf8-0cff : PCI conf1
1100-110f : VIA Technologies, Inc. VT82C586B PIPC Bus Master IDE
  1100-1107 : ide0
  1108-110f : ide1
1200-121f : VIA Technologies, Inc. USB
  1200-121f : usb-uhci
1300-131f : VIA Technologies, Inc. USB (#2)
  1300-131f : usb-uhci
4000-40ff : PCI CardBus #02
4400-44ff : PCI CardBus #02
c000-dfff : PCI Bus #01
e100-e1ff : VIA Technologies, Inc. VT8233 AC97 Audio Controller
e200-e2ff : VIA Technologies, Inc. AC97 Modem Controller
e300-e3ff : VIA Technologies, Inc. VT6102 [Rhine-II]
  e300-e3ff : via-rhine
ff00-ff7f : VIA Technologies, Inc. IEEE 1394 Host Controller

/proc/iomem
00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000e0000-000effff : Extension ROM
000f0000-000fffff : System ROM
00100000-0efeffff : System RAM
  00100000-0024ed36 : Kernel code
  0024ed37-002cf4bf : Kernel data
0eff0000-0effffbf : ACPI Tables
0effffc0-0effffff : ACPI Non-volatile Storage
10000000-10000fff : PCI device 1524:1410 (ENE Technology Inc)
10400000-107fffff : PCI CardBus #02
10800000-10bfffff : PCI CardBus #02
90000000-9fffffff : PCI Bus #01
  90000000-97ffffff : S3 Inc. VT8751 [ProSavageDDR P4M266] VGA Controller
    90000000-90eeffff : vesafb
a0000000-a3ffffff : VIA Technologies, Inc. P/KN266 Host Bridge
e0000000-efffffff : PCI Bus #01
  e0000000-e007ffff : S3 Inc. VT8751 [ProSavageDDR P4M266] VGA Controller
f0000000-f00000ff : VIA Technologies, Inc. USB 2.0
  f0000000-f00000ff : ehci-hcd
f0000100-f00001ff : VIA Technologies, Inc. VT6102 [Rhine-II]
  f0000100-f00001ff : via-rhine
fedff800-fedfffff : VIA Technologies, Inc. IEEE 1394 Host Controller
  fedff800-fedfffff : ohci1394
fff80000-ffffffff : reserved

Relevant parts from dmesg:
[...]
Local APIC disabled by BIOS -- reenabling.
Found and enabled local APIC!
Initializing CPU#0
Detected 1658.556 MHz processor.
[...]
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 0383fbff c1cbfbff 00000000 00000000
CPU:             Common caps: 0383fbff c1cbfbff 00000000 00000000
CPU: AMD mobile AMD Athlon(tm) XP 2000+ stepping 01
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
[...]
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 1658.5779 MHz.
..... host bus clock speed is 265.3724 MHz.
cpu: 0, clocks: 2653724, slice: 1326862
CPU0<T0:2653712,T1:1326848,D:2,S:1326862,C:2653724>
[...]

Workaround:
--- linux-2.4.21-rc1-acpi.orig/arch/i386/kernel/process.c       2003-04-30 21:13:20.000000000 +0200
+++ linux/arch/i386/kernel/process.c    2003-04-30 20:04:49.000000000 +0200
@@ -47,6 +47,9 @@
 #ifdef CONFIG_MATH_EMULATION
 #include <asm/math_emu.h>
 #endif
+#ifdef CONFIG_X86_LOCAL_APIC
+#include <asm/apic.h>
+#endif
 
 #include <linux/irq.h>
 
@@ -400,6 +403,20 @@
         */
        smp_send_stop();
        disable_IO_APIC();
+#else
+#ifdef CONFIG_X86_LOCAL_APIC
+       {
+       unsigned int l, h;
+       unsigned long flags;
+       __save_flags(flags);
+       __cli();
+       disable_local_APIC();
+       rdmsr(MSR_IA32_APICBASE, l, h);
+       l &= ~MSR_IA32_APICBASE_ENABLE;
+       wrmsr(MSR_IA32_APICBASE, l, h);
+       __restore_flags(flags);
+       }
+#endif
 #endif
 
        if(!reboot_thru_bios) {
