Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269170AbUJKS0k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269170AbUJKS0k (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Oct 2004 14:26:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269169AbUJKS0k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Oct 2004 14:26:40 -0400
Received: from lax-gate3.raytheon.com ([199.46.200.232]:54470 "EHLO
	lax-gate3.raytheon.com") by vger.kernel.org with ESMTP
	id S269171AbUJKSZO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Oct 2004 14:25:14 -0400
Subject: Re: [patch] CONFIG_PREEMPT_REALTIME, 'Fully Preemptible Kernel', VP-2.6.9-rc4-mm1-T4
To: Ingo Molnar <mingo@elte.hu>
Cc: Andrew Morton <akpm@osdl.org>, Daniel Walker <dwalker@mvista.com>,
       "K.R. Foley" <kr@cybsft.com>, linux-kernel@vger.kernel.org,
       Florian Schmidt <mista.tapas@gmx.net>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Lee Revell <rlrevell@joe-job.com>, Rui Nuno Capela <rncbc@rncbc.org>
X-Mailer: Lotus Notes Release 5.0.8  June 18, 2001
Message-ID: <OF29AF5CB7.227D041F-ON86256F2A.0062D210@raytheon.com>
From: Mark_H_Johnson@raytheon.com
Date: Mon, 11 Oct 2004 13:23:57 -0500
X-MIMETrack: Serialize by Router on RTSHOU-DS01/RTS/Raytheon/US(Release 6.5.2|June 01, 2004) at
 10/11/2004 01:24:00 PM
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
X-SPAM: 0.00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>i've released the -T4 VP patch:
>
>
http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.9-rc4-mm1-T4


I would have to say this is "very rough" at this point. I had the following
problems in the build:
 [1] kernel/ksyms.c - undefined symbols
 [2] kernel/mutex.c - obvious cut / paste problems
 [3] XFS has incompatible mutex definition
 [4] suspicious warnings
 [5] missing symbols for modules
Details at the end.

I booted w/ SMP and the machine threw a lot of error messages about
sleeping in
an invalid context. For example:

include/linux/rwsem.h:43
in_atomic():1 [00010001], irqs_disabled():1
[<c011f0ea>] __might_sleep+0xca/0xe0
[<c01390d4>] rw_mutex_read_lock+0x34/0x50
[<c0122dbd>] profile_hook+0x1d/0x50
[<c0123338>] profile_tick+0x68/0x70
[<c01150ad>] smp_apic_timer_interrupt+0x5d/0xf0
[<c0105820>] default_idle+0x0/0x40
[<c010854a>] apic_timer_interrupt+0x1a/0x20
[<c0105820>] default_idle+0x0/0x40
[<c011007b>] dmi_get_system_info+0xb/0x20
[<c010585a>] default_idle+0x3a/0x40
[<c03b4a4d>] start_kernel+0x19d/0x1e0
[<c03b4440>] unknown_bootoption+0x0/0x180

(somehow managed to stop the scrolling console with the above message
displayed...)

Finally died with a kernel BUG
kernel BUG at kernel/latenc.c:419!
invalid operand: 0000 [#1]
PREEMPT SMP
Modules linked in microcode dm_mod uhci_hcd ext3 jbd
CPU:     1
EIP:    0001:[<00000000>]    Not tainted VLI
EFLAGS: c1663f38  (2.6.9-rc4-mm1-VP-T4)
EIP is at 0x0
eax: 00000000   ebx: c1663f54   ecx: c0109a8c   edx: c1663f78
esi: 0000000c   edi: c1663f28   ebp: c1663f3c   esp: c1663f78
ds: 007b   es: 07b   ss: 4f03   preempt: 00000001
Process swapper (pid: 0, threadinfo=c1662000 task=c165e550)
 <0> Kernel panic - not syncing: Attempted to kill the idle task!

Rebooting with num_cpus=1 and appeared to make it farther but then the
console scrolled like crazy and finally said "console shuts up ..."
and the machine appeared to be hung. Could not scroll the window up
or down to see the full message. Had to power off / on to get the
machine back up. Going back to -T3 until I see some fixes.

If the machine managed to record some good data in /var/log/messages
I will send them separately to you for reference.

--Mark H Johnson
  <mailto:Mark_H_Johnson@raytheon.com>

Details on build problems / work arounds follow:

[1] ksyms.c - I commented these lines out, to get a complete build, but
there appears to
be code that expects rtc_lock to be defined. See #5.

arch/i386/kernel/i386_ksyms.c:166 error: `rtc_lock' undeclared here (not in
a function)
arch/i386/kernel/i386_ksyms.c:166 error: initializer element is not
constant
arch/i386/kernel/i386_ksyms.c:166 error: (near initialization for
`__ksymtab_rtc_lock.value')
followed by a similar error for atomic_dec_and_lock at line 177.

[2] mutex.c - several symbols were defined twice, fixed by changing the
names to
the functions preceeding them. See lines 108, 201, 213, 297.

[3] XFS compile failed as follows:
  CC [M]  fs/xfs/quota/xfs_dquot.o
In file included from fs/xfs/linux-2.6/xfs_linux.h:63,
                 from fs/xfs/xfs.h:35,
                 from fs/xfs/quota/xfs_dquot.c:33:
fs/xfs/linux-2.6/mutex.h:45: error: conflicting types for `mutex_t'
include/asm/spinlock.h:79: error: previous declaration of `mutex_t'
In file included from fs/xfs/linux-2.6/xfs_linux.h:102,
                 from fs/xfs/xfs.h:35,
                 from fs/xfs/quota/xfs_dquot.c:33:
fs/xfs/linux-2.6/xfs_vnode.h:578:30: macro "mutex_lock" requires 2
arguments, but only 1 given
fs/xfs/linux-2.6/xfs_vnode.h:585:30: macro "mutex_lock" requires 2
arguments, but only 1 given
fs/xfs/quota/xfs_dquot.c:1327:23: macro "mutex_lock" requires 2 arguments,
but only 1 given
fs/xfs/quota/xfs_dquot.c:1390:41: macro "mutex_lock" requires 2 arguments,
but only 1 given
fs/xfs/linux-2.6/xfs_vnode.h: In function `vn_flagset':
fs/xfs/linux-2.6/xfs_vnode.h:578: warning: statement with no effect
fs/xfs/linux-2.6/xfs_vnode.h: In function `vn_flagclr':
fs/xfs/linux-2.6/xfs_vnode.h:585: warning: statement with no effect
Turned off XFS in the build.

[4] I considered the following warnings to be "suspicious" but am not sure
if they are really problems or not.

  CC      security/selinux/ss/policydb.o
fs/dcache.c: In function `prune_dcache':
fs/dcache.c:391: warning: passing arg 1 of `cond_resched_lock' from
incompatible pointer type
  CC      security/selinux/ss/services.o
  CC      fs/inode.o
fs/inode.c: In function `invalidate_list':
fs/inode.c:317: warning: passing arg 1 of `cond_resched_lock' from
incompatible pointer type

[5] Several modules had undefined symbols. The messages were...

Kernel: arch/i386/boot/bzImage is ready
*** Warning: "mutex_trylock_bh" [drivers/net/ppp_synctty.ko] undefined!
*** Warning: "del_mtd_partitions" [drivers/mtd/maps/scx200_docflash.ko]
undefined!
*** Warning: "add_mtd_partitions" [drivers/mtd/maps/scx200_docflash.ko]
undefined!
*** Warning: "i2o_msg_in_to_virt" [drivers/message/i2o/i2o_scsi.ko]
undefined!
*** Warning: "i2o_msg_out_to_virt" [drivers/message/i2o/i2o_core.ko]
undefined!
*** Warning: "i2o_msg_in_to_virt" [drivers/message/i2o/i2o_core.ko]
undefined!
*** Warning: "i2o_msg_in_to_virt" [drivers/message/i2o/i2o_block.ko]
undefined!
*** Warning: "rtc_lock" [drivers/char/nvram.ko] undefined!
*** Warning: "rtc_lock" [drivers/char/mwave/mwave.ko] undefined!
*** Warning: "rtc_lock" [drivers/block/floppy.ko] undefined!
...
if [ -r System.map ]; then /sbin/depmod -ae -F System.map -b
/var/tmp/kernel-2.6.9rc4mm1VPT4-root -r 2.6.9-rc4-mm1-VP-T4; fi
WARNING: /var/tmp/kernel-2.6.9
rc4mm1VPT4-root/lib/modules/2.6.9-rc4-mm1-VP-T4/kernel/drivers/net/ppp_synctty.ko
 needs unknown symbol mutex_trylock_bh
WARNING: /var/tmp/kernel-2.6.9
rc4mm1VPT4-root/lib/modules/2.6.9-rc4-mm1-VP-T4/kernel/drivers/mtd/maps/scx200_docflash.ko
 needs unknown symbol del_mtd_partitions
WARNING: /var/tmp/kernel-2.6.9
rc4mm1VPT4-root/lib/modules/2.6.9-rc4-mm1-VP-T4/kernel/drivers/mtd/maps/scx200_docflash.ko
 needs unknown symbol add_mtd_partitions
WARNING: /var/tmp/kernel-2.6.9
rc4mm1VPT4-root/lib/modules/2.6.9-rc4-mm1-VP-T4/kernel/drivers/message/i2o/i2o_scsi.ko
 needs unknown symbol i2o_msg_in_to_virt
WARNING: /var/tmp/kernel-2.6.9
rc4mm1VPT4-root/lib/modules/2.6.9-rc4-mm1-VP-T4/kernel/drivers/message/i2o/i2o_core.ko
 needs unknown symbol i2o_msg_in_to_virt
WARNING: /var/tmp/kernel-2.6.9
rc4mm1VPT4-root/lib/modules/2.6.9-rc4-mm1-VP-T4/kernel/drivers/message/i2o/i2o_core.ko
 needs unknown symbol i2o_msg_out_to_virt
WARNING: /var/tmp/kernel-2.6.9
rc4mm1VPT4-root/lib/modules/2.6.9-rc4-mm1-VP-T4/kernel/drivers/message/i2o/i2o_block.ko
 needs unknown symbol i2o_msg_in_to_virt
WARNING: /var/tmp/kernel-2.6.9
rc4mm1VPT4-root/lib/modules/2.6.9-rc4-mm1-VP-T4/kernel/drivers/char/nvram.ko
 needs unknown symbol rtc_lock
WARNING: /var/tmp/kernel-2.6.9
rc4mm1VPT4-root/lib/modules/2.6.9-rc4-mm1-VP-T4/kernel/drivers/char/mwave/mwave.ko
 needs unknown symbol rtc_lock
WARNING: /var/tmp/kernel-2.6.9
rc4mm1VPT4-root/lib/modules/2.6.9-rc4-mm1-VP-T4/kernel/drivers/block/floppy.ko
 needs unknown symbol rtc_lock



