Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932151AbWCAFZL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932151AbWCAFZL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Mar 2006 00:25:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932170AbWCAFZL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Mar 2006 00:25:11 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:30374 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S932151AbWCAFZJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Mar 2006 00:25:09 -0500
Date: Tue, 28 Feb 2006 21:25:01 -0800
From: Paul Jackson <pj@sgi.com>
To: ebiederm@xmission.com (Eric W. Biederman)
Cc: akpm@osdl.org, ebiederm@xmission.com, linux-kernel@vger.kernel.org
Subject: Re: + proc-dont-lock-task_structs-indefinitely-cpuset-fix-2.patch
 added to -mm tree
Message-Id: <20060228212501.25464659.pj@sgi.com>
In-Reply-To: <m1irqypxf5.fsf@ebiederm.dsl.xmission.com>
References: <200603010120.k211KqVP009559@shell0.pdx.osdl.net>
	<20060228181849.faaf234e.pj@sgi.com>
	<20060228183610.5253feb9.akpm@osdl.org>
	<20060228194525.0faebaaa.pj@sgi.com>
	<20060228201040.34a1e8f5.pj@sgi.com>
	<m1irqypxf5.fsf@ebiederm.dsl.xmission.com>
Organization: SGI
X-Mailer: Sylpheed version 2.1.7 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric wrote:
> I can kill a kernel this way as well.  Thanks this looks like
> a good reproducer I will see if  I can figure out why.

I suspect two problems, one with your patches that the fuser provokes,
and a separate bug earlier in *-mm that the DEBUG options noted below
provoke.

Details:

In addition to the problem that shows up with the three patches
>     proc-dont-lock-task_structs-indefinitely.patch
>     proc-dont-lock-task_structs-indefinitely-git-nfs-fix.patch
>     proc-dont-lock-task_structs-indefinitely-cpuset-fix.patch

when running the fuser command:
>     /bin/fuser -n tcp 5553

I am seeing as a separate bug the crash during boot that I reported
last, when I turned on some DEBUG options.  That crash occurs even with
none of your proc patches.

That is, to be specific, with this patch at the top of my applied stack:
     rtc-subsystem-rs5c372-driver.patch

and these patches at the front of my unapplied queue:
     trivial-cleanup-to-proc_check_chroot.patch
     proc-fix-the-inode-number-on-proc-pid-fd.patch

and the debug options:
> CONFIG_DEBUG_SLAB=y
> CONFIG_DEBUG_SPINLOCK=y
> CONFIG_DEBUG_SPINLOCK_SLEEP=y

I die during system boot with:
==============================

...
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
psr : 0000101008026018 ifs : 800000000000040b ip  : [<a0000001001f0a50>]    Not tainted
ip is at sysfs_create_group+0x30/0x2a0
unat: 0000000000000000 pfs : 0000000000000308 rsc : 0000000000000003
rnat: 0000000002000027 bsps: 0000000000000002 pr  : 0000000000005649
ldrs: 0000000000000000 ccv : 0000000000000000 fpsr: 0009804c8a70433f
csd : 0000000000000000 ssd : 0000000000000000
b0  : a00000010081ad30 b6  : e000023002310080 b7  : a00000010081ad80
f6  : 1003e0000000000000000 f7  : 1003e20c49ba5e353f7cf
f8  : 1003e0000000000002ff0 f9  : 1003e0000000000000068
f10 : 1003e0000000000000000 f11 : 1003e0000000000000000
r1  : a000000100c93ab0 r2  : 0000000000000058 r3  : a000000100aa3560
r8  : 0000000000000000 r9  : a000000100cba7a0 r10 : ffffffffffffffff
r11 : 0000000000000400 r12 : e00002343bdb7d50 r13 : e00002343bdb0000
r14 : a000000100aa8300 r15 : a000000100cba7a0 r16 : a000000100aa3568
r17 : 00000000000003c0 r18 : 0000000000000001 r19 : 0000000000000002
r20 : ffffffffffffffff r21 : 000000000000000e r22 : 0000000000000000
r23 : a000000100a94eb8 r24 : a000000100824c80 r25 : a000000100aa3b18
r26 : 0000000000004000 r27 : a000000100913e80 r28 : e00002343b2d3918
r29 : 0000000000000001 r30 : a0000001007d9228 r31 : a00000010081ad80

Call Trace:
 [<a000000100013280>] show_stack+0x40/0xa0
                                sp=e00002343bdb78e0 bsp=e00002343bdb1298
 [<a000000100013ab0>] show_regs+0x7d0/0x800
                                sp=e00002343bdb7ab0 bsp=e00002343bdb1248
 [<a000000100036970>] die+0x210/0x320
                                sp=e00002343bdb7ab0 bsp=e00002343bdb1200
 [<a00000010005a800>] ia64_do_page_fault+0x900/0xa80
                                sp=e00002343bdb7ad0 bsp=e00002343bdb1198
 [<a00000010000bbc0>] ia64_leave_kernel+0x0/0x290
                                sp=e00002343bdb7b80 bsp=e00002343bdb1198
 [<a0000001001f0a50>] sysfs_create_group+0x30/0x2a0
                                sp=e00002343bdb7d50 bsp=e00002343bdb1140
 [<a00000010081ad30>] topology_cpu_callback+0x70/0xc0
                                sp=e00002343bdb7d60 bsp=e00002343bdb1110
 [<a00000010081ae00>] topology_sysfs_init+0x80/0x120
                                sp=e00002343bdb7d60 bsp=e00002343bdb10f0
 [<a000000100009860>] init+0x580/0x8e0
                                sp=e00002343bdb7d60 bsp=e00002343bdb10c8
 [<a000000100011740>] kernel_thread_helper+0xe0/0x100
                                sp=e00002343bdb7e30 bsp=e00002343bdb10a0
 [<a000000100009140>] start_kernel_thread+0x20/0x40
                                sp=e00002343bdb7e30 bsp=e00002343bdb10a0
 <0>Kernel panic - not syncing: Attempted to kill init!


-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
