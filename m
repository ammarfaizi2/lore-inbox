Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264239AbTKUDRv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Nov 2003 22:17:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264241AbTKUDRv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Nov 2003 22:17:51 -0500
Received: from nat-68-172-17-106.ne.rr.com ([68.172.17.106]:13556 "EHLO
	trip.jpj.net") by vger.kernel.org with ESMTP id S264239AbTKUDRr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Nov 2003 22:17:47 -0500
Subject: Kernel oops at boot with 2.6.0-test9, 2.4.21ELsmp on Opteron 248
From: Paul Venezia <pvenezia@jpj.net>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: 
Message-Id: <1069384437.3807.2308.camel@soul.jpj.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 20 Nov 2003 22:13:57 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a new dual Opteron 248 system here with an MSI K8T Master2-FAR
mainboard that isn't happy with 2.6.0-test. In fact, it's not altogether
happy with any SMP kernel so far, but will boot RedHat's 2.4.21EL single
processor kernel and appears to function normally.

I'm having problems compiling 2.6.0-test9 through bk22 on this box,
erroring here:

  CC      arch/x86_64/kernel/head64.o
  CC      arch/x86_64/kernel/init_task.o
  CPP     arch/x86_64/kernel/vmlinux.lds.s
  CC [M]  arch/x86_64/kernel/msr.o
make[1]: *** No rule to make target `arch/x86_64/kernel/cpuid.c', needed
by `arch/x86_64/kernel/cpuid.o'.  Stop.
make: *** [arch/x86_64/kernel] Error 2

I've tried various -mm patches, but error elsewhere:

  CC      arch/x86_64/kernel/nmi.o
arch/x86_64/kernel/nmi.c: In function `nmi_watchdog_tick':
arch/x86_64/kernel/nmi.c:317: warning: ISO C90 forbids mixed
declarations and code
  CC      arch/x86_64/kernel/io_apic.o
arch/x86_64/kernel/io_apic.c:1215: redefinition of
`disable_edge_ioapic_irq'
include/asm/io_apic.h:178: `disable_edge_ioapic_irq' previously defined
here
arch/x86_64/kernel/io_apic.c:1259: redefinition of `end_edge_ioapic_irq'
include/asm/io_apic.h:180: `end_edge_ioapic_irq' previously defined here
arch/x86_64/kernel/io_apic.c:1346: redefinition of
`mask_and_ack_level_ioapic_irq'
include/asm/io_apic.h:179: `mask_and_ack_level_ioapic_irq' previously
defined here
include/asm/io_apic.h:178: warning: `disable_edge_ioapic_irq' defined
but not used
include/asm/io_apic.h:179: warning: `mask_and_ack_level_ioapic_irq'
defined but not used
include/asm/io_apic.h:180: warning: `end_edge_ioapic_irq' defined but
not used
make[1]: *** [arch/x86_64/kernel/io_apic.o] Error 1
make: *** [arch/x86_64/kernel] Error 2


2.4.22 vanilla compile breaks at

gcc -D__KERNEL__ -I/usr/src/linux-2.4.22/include -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common
-fomit-frame-pointer -mno-red-zone -mcmodel=kernel -pipe
-fno-reorder-blocks -finline-limit=2000 -fno-strength-reduce
-Wno-sign-compare -fno-asynchronous-unwind-tables   -nostdinc
-iwithprefix include -DKBUILD_BASENAME=mpparse  -c -o mpparse.o
mpparse.c
mpparse.c: In function `mp_register_ioapic':
mpparse.c:763: warning: long unsigned int format, different type arg
(arg 5)
mpparse.c:763: warning: long unsigned int format, different type arg
(arg 5)
mpparse.c: In function `mp_parse_prt':
mpparse.c:952: too few arguments to function `acpi_pci_link_get_irq'
make[1]: *** [mpparse.o] Error 1
make[1]: Leaving directory `/usr/src/linux-2.4.22/arch/x86_64/kernel'
make: *** [_dir_arch/x86_64/kernel] Error 2

I removed ACPI support and the kernel built and booted, seeing both
processors, but the tg3 driver wouldn't load, not finding the hardware,;
the 2.4.21EL kernel has no issues with this module. Is there a patch I'm
missing? 

There was significant oddness with this kernel, however, as top would
show CPU stats oscillating between 33.3% irq, softirq, and iowait per
CPU, and 0.0% every odd second. This was on a quiescent system.

I can compile 2.6.0-test9-bk22 from Arjan's source RPM successfully. I'm
obviously missing a patch. Regardless, an attempt to boot any 2.6.0
kernel, single or SMP fails on load with a 

slab: error in check_poison_obj(): "biovec-#" object was modified after
freeing

then a slew of acpi-related errors rapidly scroll ad infinitum.

A SMP boot of RedHat's 2.4.21-4.1EL kernel gives back:

Code: bad RIP value

then a call trace to stop_this_cpu.

A straight install of SuSE SLES 64 simply won't boot, as the kernel
2.4.19 kernel is SMP, and panics with the same error as above.

I don't have an older Opteron box, so I can't tell if this is related to
the new CPUs or not.

-Paul

