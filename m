Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262741AbSI1IWz>; Sat, 28 Sep 2002 04:22:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262743AbSI1IWz>; Sat, 28 Sep 2002 04:22:55 -0400
Received: from h108-129-61.datawire.net ([207.61.129.108]:11972 "EHLO
	mail.datawire.net") by vger.kernel.org with ESMTP
	id <S262741AbSI1IWy> convert rfc822-to-8bit; Sat, 28 Sep 2002 04:22:54 -0400
From: Shawn Starr <spstarr@sh0n.net>
Organization: sh0n.net
To: linux-kernel@vger.kernel.org
Subject: [PROBLEM] 2.5.39 - might_sleep() exception - ACPI/APIC, UML compile issues on MP 2000+
Date: Sat, 28 Sep 2002 04:28:23 -0400
User-Agent: KMail/1.4.6
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200209280428.23572.spstarr@sh0n.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

System info:

00:00.0 Host bridge: Advanced Micro Devices [AMD] AMD-760 MP [IGD4-2P] System Controller (rev 11)
00:01.0 PCI bridge: Advanced Micro Devices [AMD] AMD-760 MP [IGD4-2P] AGP Bridge
00:07.0 ISA bridge: Advanced Micro Devices [AMD] AMD-768 [Opus] ISA (rev 04)
00:07.1 IDE interface: Advanced Micro Devices [AMD] AMD-768 [Opus] IDE (rev 04)
00:07.3 Bridge: Advanced Micro Devices [AMD] AMD-768 [Opus] ACPI (rev 03)
00:10.0 PCI bridge: Advanced Micro Devices [AMD] AMD-768 [Opus] PCI (rev 04)
01:05.0 VGA compatible controller: ATI Technologies Inc Radeon 7500 QW
02:04.0 Multimedia audio controller: C-Media Electronics Inc CM8738 (rev 10)
02:05.0 Ethernet controller: 3Com Corporation 3c980-TX 10/100baseTX NIC [Python-T] (rev 78)
02:08.0 USB Controller: NEC Corporation USB (rev 41)
02:08.1 USB Controller: NEC Corporation USB (rev 41)	
02:08.2 USB Controller: NEC Corporation USB 2.0 (rev 02)

1) Kernel  on boot up yet lets me continue using system (In 2.5.39 right now).

>From code: mm/slab.c
=============

static inline void * __kmem_cache_alloc (kmem_cache_t *cachep, int flags)
{
        unsigned long save_flags;
        void* objp;

        if (flags & __GFP_WAIT)
                might_sleep(); <---------------

Error from dmesg:
===========

Sep 28 04:05:42 unknown kernel: Sleeping function called from illegal context at slab.c:1374
Sep 28 04:05:42 unknown kernel: dffc9ecc c0135c1c c0317f1a 0000055e 04000000 04000000 c024b160 dfe1a2c0
Sep 28 04:05:42 unknown kernel:        c010995f c15070c0 000001d0 0000055e 04000000 dfe1a2c0 c03ff840 dfe1a2c0
Sep 28 04:05:42 unknown kernel:        c0243696 0000000e c024b160 04000000 c03ff850 dfe1a2c0 00000001 c03ff850
Sep 28 04:05:42 unknown kernel: Call Trace:
Sep 28 04:05:42 unknown kernel:  [__kmem_cache_alloc+268/288]__kmem_cache_alloc+0x10c/0x120
Sep 28 04:05:42 unknown kernel:  [ide_intr+0/384]ide_intr+0x0/0x180
Sep 28 04:05:42 unknown kernel:  [request_irq+111/224]request_irq+0x6f/0xe0
Sep 28 04:05:42 unknown kernel:  [init_irq+310/896]init_irq+0x136/0x380
Sep 28 04:05:42 unknown kernel:  [ide_intr+0/384]ide_intr+0x0/0x180
Sep 28 04:05:42 unknown kernel:  [hwif_init+216/608]hwif_init+0xd8/0x260
Sep 28 04:05:42 unknown kernel:  [probe_hwif_init+45/128]probe_hwif_init+0x2d/0x80
Sep 28 04:05:42 unknown kernel:  [ide_setup_pci_device+80/128]ide_setup_pci_device+0x50/0x80
Sep 28 04:05:42 unknown kernel:  [init+58/368]init+0x3a/0x170
Sep 28 04:05:42 unknown kernel:  [init+0/368]init+0x0/0x170
Sep 28 04:05:42 unknown kernel:  [kernel_thread_helper+5/20]kernel_thread_helper+0x5/0x14

2) Kernel compile errors with ACPI disabled.

arch/i386/pci/built-in.o  net/built-in.o --end-group  -o .tmp_vmlinux
arch/i386/kernel/built-in.o: In function `MP_processor_info':
arch/i386/kernel/built-in.o(.text.init+0x4a00): undefined reference to `Dprintk'
arch/i386/kernel/built-in.o(.text.init+0x4a20): undefined reference to `Dprintk'
arch/i386/kernel/built-in.o(.text.init+0x4a31): undefined reference to `Dprintk'
arch/i386/kernel/built-in.o(.text.init+0x4a45): undefined reference to `Dprintk'
arch/i386/kernel/built-in.o(.text.init+0x4a59): undefined reference to `Dprintk'
arch/i386/kernel/built-in.o(.text.init+0x4a6d): more undefined references to `Dprintk' follow
make: *** [.tmp_vmlinux] Error 1


3) Compile errors with UML:

In file included from sched.c:19:
/usr/src/linux-2.5.39/include/linux/mm.h:165: parse error before "pte_addr_t"
/usr/src/linux-2.5.39/include/linux/mm.h:165: warning: no semicolon at end of struct or union
/usr/src/linux-2.5.39/include/linux/mm.h:165: warning: no semicolon at end of struct or union
/usr/src/linux-2.5.39/include/linux/mm.h:166: warning: type defaults to `int' in declaration of `pte'

Shawn ;/
