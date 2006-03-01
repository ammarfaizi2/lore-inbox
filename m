Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932610AbWCAHsO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932610AbWCAHsO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Mar 2006 02:48:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932618AbWCAHsO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Mar 2006 02:48:14 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:49312 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932610AbWCAHsN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Mar 2006 02:48:13 -0500
Date: Tue, 28 Feb 2006 23:48:07 -0800
From: Paul Jackson <pj@sgi.com>
To: Paul Jackson <pj@sgi.com>
Cc: ebiederm@xmission.com, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: + proc-dont-lock-task_structs-indefinitely-cpuset-fix-2.patch
 added to -mm tree
Message-Id: <20060228234807.55f1b25f.pj@sgi.com>
In-Reply-To: <20060228212501.25464659.pj@sgi.com>
References: <200603010120.k211KqVP009559@shell0.pdx.osdl.net>
	<20060228181849.faaf234e.pj@sgi.com>
	<20060228183610.5253feb9.akpm@osdl.org>
	<20060228194525.0faebaaa.pj@sgi.com>
	<20060228201040.34a1e8f5.pj@sgi.com>
	<m1irqypxf5.fsf@ebiederm.dsl.xmission.com>
	<20060228212501.25464659.pj@sgi.com>
Organization: SGI
X-Mailer: Sylpheed version 2.1.7 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I am seeing as a separate bug the crash during boot that I reported
> last, when I turned on some DEBUG options. 

I have narrowed it down to between the following two patches
in *-mm (patch numbers 20 and 90 in 2.6.16-rc5-mm1, roughly):

    multiple-exports-of-strpbrk.patch == ok
    git-drm.patch == bad

I have to set this aside for now.

As stated before, the bad patch won't boot on my ia64 SN2 Altix
sn2_defconfig plus debug options:

> CONFIG_DEBUG_SLAB=y
> CONFIG_DEBUG_SPINLOCK=y
> CONFIG_DEBUG_SPINLOCK_SLEEP=y

It fails with:
==============

pci_hotplug: PCI Hot Plug PCI Core version: 0.5
SGI Altix RTC Timer: v2.1, 20 MHz
EFI Time Services Driver v0.4
Linux agpgart interface v0.101 (c) Dave Jones
sn_console: Console driver init
ttySG0 at I/O 0x0 (irq = 0) is a SGI SN L1
Unable to handle kernel NULL pointer dereference (address 0000000000000058)
swapper[1]: Oops 8813272891392 [1]
Modules linked in:

Pid: 1, CPU 0, comm:              swapper
psr : 0000101008026018 ifs : 800000000000040b ip  : [<a0000001001ea8b0>]    Not tainted
ip is at sysfs_create_group+0x30/0x2a0
unat: 0000000000000000 pfs : 0000000000000308 rsc : 0000000000000003
rnat: 0000000002000027 bsps: 0000000000000002 pr  : 0000000000005649
ldrs: 0000000000000000 ccv : 0000000000000000 fpsr: 0009804c8a70433f
csd : 0000000000000000 ssd : 0000000000000000
b0  : a000000100809190 b6  : e000023002310080 b7  : a0000001008091e0
f6  : 1003e0000000000000000 f7  : 1003e20c49ba5e353f7cf
f8  : 1003e0000000000003398 f9  : 1003e000000000000007f
f10 : 1003e0000000000000000 f11 : 1003e0000000000000000
r1  : a000000100c70d60 r2  : 0000000000000058 r3  : a000000100a866a8
r8  : 0000000000000000 r9  : a000000100c96920 r10 : ffffffffffffffff
r11 : 0000000000000400 r12 : e00002343bd97d50 r13 : e00002343bd90000
r14 : a000000100a87378 r15 : a000000100c96920 r16 : a000000100a866b0
r17 : 00000000000003c0 r18 : 0000000000000001 r19 : 0000000000000002
r20 : ffffffffffffffff r21 : 0000000000000000 r22 : 000000000000000e
r23 : a000000100a72150 r24 : a000000100812c40 r25 : a000000100a72670
r26 : a000000100a88c20 r27 : a0000001008f3b88 r28 : e00002bc3a0432f0
r29 : 0000000000000001 r30 : a0000001007cac58 r31 : a0000001008091e0

Call Trace:
 [<a0000001000132c0>] show_stack+0x40/0xa0
                                sp=e00002343bd978e0 bsp=e00002343bd91278
 [<a000000100013af0>] show_regs+0x7d0/0x800
                                sp=e00002343bd97ab0 bsp=e00002343bd91228
 [<a000000100036df0>] die+0x210/0x320
                                sp=e00002343bd97ab0 bsp=e00002343bd911d8
 [<a00000010005a840>] ia64_do_page_fault+0x900/0xa80
                                sp=e00002343bd97ad0 bsp=e00002343bd91178
 [<a00000010000bd00>] ia64_leave_kernel+0x0/0x290
                                sp=e00002343bd97b80 bsp=e00002343bd91178
 [<a0000001001ea8b0>] sysfs_create_group+0x30/0x2a0
                                sp=e00002343bd97d50 bsp=e00002343bd91120
 [<a000000100809190>] topology_cpu_callback+0x70/0xc0
                                sp=e00002343bd97d60 bsp=e00002343bd910f0
 [<a000000100809260>] topology_sysfs_init+0x80/0x120
                                sp=e00002343bd97d60 bsp=e00002343bd910d0
 [<a000000100009860>] init+0x580/0x8e0
                                sp=e00002343bd97d60 bsp=e00002343bd910a8
 [<a000000100011780>] kernel_thread_helper+0xe0/0x100
                                sp=e00002343bd97e30 bsp=e00002343bd91080
 [<a000000100009140>] start_kernel_thread+0x20/0x40
                                sp=e00002343bd97e30 bsp=e00002343bd91080
 <0>Kernel panic - not syncing: Attempted to kill init!
                                                                                

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
