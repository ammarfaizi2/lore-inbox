Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263281AbTE3GHa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 May 2003 02:07:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263285AbTE3GHa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 May 2003 02:07:30 -0400
Received: from modemcable204.207-203-24.mtl.mc.videotron.ca ([24.203.207.204]:40320
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id S263281AbTE3GH2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 May 2003 02:07:28 -0400
Date: Fri, 30 May 2003 02:10:11 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@montezuma.mastecende.com
To: Linux Kernel <linux-kernel@vger.kernel.org>
cc: LSE <lse-tech@lists.sourceforge.net>, Brian Gerst <bgerst@didntduck.org>,
       William Lee Irwin III <wli@holomorphy.com>,
       Stephen Hemminger <shemminger@osdl.org>
Subject: [PATCH][ANNOUNCE][0/1] 32way/8quad NUMAQ booting with NR_IRQS = 640
Message-ID: <Pine.LNX.4.50.0305300111300.2176-100000@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is continuing on the previous patch and then pushes the envelope a 
bit more ;) The patch now also contains Brian Gerst's interrupt stub 
alignment patch.

The following system is now fully functional interrupt delivery wise;

32way/8quad NUMAQ
16 IOAPICs
320 interrupt sources in MP Table
Highest IRQ of 377

How it works:
Linux/i386 has a 256 descriptor IDT, which allows for a total of ~190 
vectors you can have for external devices (some are used for SMP and 
general system vectors). We managed to bypass this limitation by having 
per node IDTs. This affords us 190 * MAX_NUMNODES external devices, we 
choose devices to affine (interrupt servicing/delivery) to nodes/cpumasks 
depending on PCI bus location and/or IOAPIC source, this ensures that we don't 
break NUMAQ in it's current implimentation (it can't deliver interrupts 
across nodes due to the APIC addressing scheme used).

The patch has been in the -mjb tree for a number of releases and i have 
run it on UP, 8way SMP and 32way NUMAQ, however it mainly is of interest 
to the NUMAQ/x440 crowd. With this patch applied i can now access the 
NICS, SCSI HBAs and disks from all the nodes.

dmesg can be found here;

http://www.osdl.org/projects/numaqhwspprt/results/data/dmesg-32way-8quad-2.5.70-640irqs

Many thanks as usual go to OSDL for providing me cpu time on the 8quad.

Slightly more questionable bits:
I bumped up *IRQ_BITS...

 arch/i386/kernel/cpu/common.c               |   39 ++++++++--
 arch/i386/kernel/doublefault.c              |    2 
 arch/i386/kernel/entry.S                    |   20 +----
 arch/i386/kernel/head.S                     |   12 +--
 arch/i386/kernel/i8259.c                    |    4 -
 arch/i386/kernel/io_apic.c                  |  109 +++++++++++++++++++++-------
 arch/i386/kernel/irq.c                      |    2 
 arch/i386/kernel/smpboot.c                  |    6 +
 arch/i386/kernel/traps.c                    |   41 ++++++++--
 arch/i386/mm/fault.c                        |    6 -
 include/asm-i386/cpu.h                      |    2 
 include/asm-i386/desc.h                     |    9 +-
 include/asm-i386/hardirq.h                  |   20 ++---
 include/asm-i386/hw_irq.h                   |    2 
 include/asm-i386/mach-default/irq_vectors.h |    7 +
 include/asm-i386/mach-pc9800/irq_vectors.h  |    2 
 include/asm-i386/mach-visws/irq_vectors.h   |    1 
 include/asm-i386/mach-voyager/irq_vectors.h |    1 
 include/asm-i386/numaq.h                    |    3 
 include/asm-i386/segment.h                  |    2 
 include/asm-i386/srat.h                     |    3 
 include/asm-i386/thread_info.h              |    6 +
 22 files changed, 212 insertions(+), 87 deletions(-)

-- 
function.linuxpower.ca
