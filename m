Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261691AbUKXAHP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261691AbUKXAHP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Nov 2004 19:07:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261372AbUKXAFa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Nov 2004 19:05:30 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:17559 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S261618AbUKXACn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Nov 2004 19:02:43 -0500
Date: Tue, 23 Nov 2004 18:02:21 -0600
From: Brent Casavant <bcasavan@sgi.com>
Reply-To: Brent Casavant <bcasavan@sgi.com>
To: Lee Revell <rlrevell@joe-job.com>
cc: celeron2002@chile.com, linux-kernel@vger.kernel.org
Subject: Re: bug in mm/slab.c
In-Reply-To: <1101250929.5207.1.camel@krustophenia.net>
Message-ID: <Pine.SGI.4.58.0411231754430.46250@kzerza.americas.sgi.com>
References: <34591.200.113.104.46.1101247993.squirrel@mail.chile.com>
 <1101250929.5207.1.camel@krustophenia.net>
Organization: "Silicon Graphics, Inc."
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Nov 2004, Lee Revell wrote:

> On Tue, 2004-11-23 at 19:13 -0300, celeron2002@chile.com wrote:

> > nvidia: module license 'NVIDIA' taints kernel.
> > ACPI: PCI interrupt 0000:02:00.0[A] -> GSI 11 (level, low) -> IRQ 11
> > NVRM: loading NVIDIA Linux x86 NVIDIA Kernel Module  1.0-6111  Tue Jul 27
> > 07:55:38 PDT 2004
> > kmem_cache_create: duplicate cache sgpool-8
> > ------------[ cut here ]------------
> > kernel BUG at mm/slab.c:1442!
>
> Not only do you have the nvidia module loaded, but it looks like the
> nvidia module caused your oops.
>
> Did you see the line about 'module license NVIDIA taints kernel'?
> Google for what this means and you will understand why this bug report
> is offtopic.

Not necessarily.  We tripped over this one at SGI the other day,
though on IA64.  Unfortunately I don't know the specifics of the
kernel that was being used, other than it is 2.6.5 based and fairly
heavily patched.  But it most definitely did not have an nVidia
driver loaded.  See the backtrace and related information below.

The theory right now is that SCSI support was compiled into the
kernel, but for some reason a load of scsi_mod.ko was attempted
from the initrd.  This would obviously cause a problem as both
would try to create sgpool-8.

Unfortunately I have few other details.  Just noting that this
has been seen elsewhere very recently.

Brent Casavant

Loading kernel/drivers/scsi/scsi_mod.ko
kmem_cache_create: duplicate cache sgpool-8
kernel BUG at mm/slab.c:1348!
insmod[1256]: bugcheck! 0 [1]

Pid: 1256, CPU 2, comm:               insmod
psr : 0000101008026038 ifs : 8000000000000998 ip  : [<a00000010011be90>]    Not tainted (2.6.5-7.109.14-sn2-sgidev-steiner )
ip is at kmem_cache_create+0xb0/0xbe0
unat: 0000000000000000 pfs : 0000000000000998 rsc : 0000000000000003
rnat: e00000bc3be84c80 bsps: e00000bc3be84880 pr  : 5199164592a59665
ldrs: 0000000000000000 ccv : 0000000000000000 fpsr: 0009804c8a70033f
csd : 0000000000000000 ssd : 0000000000000000
b0  : a00000010011be90 b6  : e00000b0022df210 b7  : e000000001fffc00
f6  : 10023bf75522a80000000 f7  : 10008fa00000000000000
f8  : 1003e0000000006206d20 f9  : 10019c40da4028f488854
f10 : 0fffbccccccccc8c00000 f11 : 1003e0000000000000000
r1  : a000000100ee3910 r2  : ffffffffffffd3fd r3  : 0000000000000000
r8  : 000000000000001e r9  : a000000100b6c158 r10 : 0000000000000001
r11 : 0000000000004000 r12 : e0000130030bfe20 r13 : e0000130030b8000
r14 : a000000100b4b3c8 r15 : a000000100d02130 r16 : 0000000000000001
r17 : a000000100b6c118 r18 : ffffffffffffffff r19 : a000000100b6c158
r20 : 0000000300000000 r21 : 00000000000016ee r22 : a000000100d02000
r23 : e0000130030bfd30 r24 : 0000000000000000 r25 : e0000130030bfd48
r26 : e00000bc3be84c80 r27 : 000000000000e8f0 r28 : 000000000000ffde
r29 : a000000100d27cb8 r30 : 0000000000000000 r31 : a000000100d03078

Call Trace:
 [<a000000100019120>] show_stack+0x80/0xa0
                                sp=e0000130030bf9f0 bsp=e0000130030b9258
 [<a00000010003b790>] die+0x1b0/0x2c0
                                sp=e0000130030bfbc0 bsp=e0000130030b9220
 [<a00000010003cdb0>] ia64_bad_break+0x2f0/0x400
                                sp=e0000130030bfbc0 bsp=e0000130030b91f0
 [<a00000010000ff00>] ia64_leave_kernel+0x0/0x260
                                sp=e0000130030bfc50 bsp=e0000130030b91f0
 [<a00000010011be90>] kmem_cache_create+0xb0/0xbe0
                                sp=e0000130030bfe20 bsp=e0000130030b9130
 [<a0000002081485c0>] scsi_init_queue+0xa0/0x1b0 [scsi_mod]
                                sp=e0000130030bfe30 bsp=e0000130030b90d0
 [<a000000208148280>] init_scsi+0x20/0x2c0 [scsi_mod]
                                sp=e0000130030bfe30 bsp=e0000130030b90a8
 [<a0000001000eea90>] sys_init_module+0x390/0x760
                                sp=e0000130030bfe30 bsp=e0000130030b9030
 [<a00000010000fd80>] ia64_ret_from_syscall+0x0/0x20
                                sp=e0000130030bfe30 bsp=e0000130030b9030

-- 
Brent Casavant                          If you had nothing to fear,
bcasavan@sgi.com                        how then could you be brave?
Silicon Graphics, Inc.                    -- Queen Dama, Source Wars
