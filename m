Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268279AbUJUQNg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268279AbUJUQNg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 12:13:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268756AbUJUQMS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 12:12:18 -0400
Received: from mail8.spymac.net ([195.225.149.8]:42960 "EHLO mail8")
	by vger.kernel.org with ESMTP id S268496AbUJUQGo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 12:06:44 -0400
Message-ID: <4177FAB0.6090406@spymac.com>
Date: Thu, 21 Oct 2004 20:06:40 +0200
From: Gunther Persoons <gunther_persoons@spymac.com>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040916)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: linux-kernel@vger.kernel.org
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-rc4-mm1-U9
References: <20041013061518.GA1083@elte.hu> <20041014002433.GA19399@elte.hu> <20041014143131.GA20258@elte.hu> <20041014234202.GA26207@elte.hu> <20041015102633.GA20132@elte.hu> <20041016153344.GA16766@elte.hu> <20041018145008.GA25707@elte.hu> <20041019124605.GA28896@elte.hu> <20041019180059.GA23113@elte.hu> <20041020094508.GA29080@elte.hu> <20041021132717.GA29153@elte.hu>
In-Reply-To: <20041021132717.GA29153@elte.hu>
X-Enigmail-Version: 0.86.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:

>i have released the -U9 Real-Time Preemption patch, which can be
>downloaded from:
>
>  http://redhat.com/~mingo/realtime-preempt/
>
>this too is a fixes-only release. It includes more driver fixes and
>improvements from Thomas Gleixner.
>
>Changes since -U8.1:
>
> - USB semaphore->completion conversion from Thomas Gleixner
>
> - netconsole fixes from Michal Schmidt
>
> - fbcon fixes
>
> - added counted semaphores, this is now used by firewire, XFS and ACPI. 
>   This could fix the firewire breakage - but testing would be welcome.
>
> - PREEMPT_ACTIVE irqs-enabled critical path removal.
>
> - fixed irqs-off raw spinlock primitives on UP: they enabled irqs 
>   before enabling preemption, creating a window for an interrupt to
>   slip in and increase the critical path.
>
> - made the deadlock detector not crash the current process - it will
>   just hang. This produces far nicer log output while still not
>   endangering stability. Also, fixed a bug in the detector that happens 
>   if the trace buffer overflows.
>
> - made the atomic-counter-underflow detector non-fatal as well, for the
>   same reasons.
>
>to create a -U9 tree from scratch, the patching order is:
>
>   http://kernel.org/pub/linux/kernel/v2.6/linux-2.6.8.tar.bz2
> + http://kernel.org/pub/linux/kernel/v2.6/testing/patch-2.6.9-rc4.bz2
> + http://kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.9-rc4/2.6.9-rc4-mm1/2.6.9-rc4-mm1.bz2
> + http://redhat.com/~mingo/realtime-preempt/realtime-preempt-2.6.9-rc4-mm1-U9
>
>	Ingo
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>  
>
Hey,

The kernel booted now with my firewire card plugged in. However when i 
try to mount my reiser4 partition i get following error

BUG: semaphore recursion deadlock detected!
.. current task mount/10514 is already holding ccb5bb4c.
c022d6cb cf25d8f0 ccb5bae8 00002912 ccb5bb4c 00000000 ccb5bb48 ccb5a000
       ccb5bb4c cf25d8f0 00000000 ccb5bb48 c0344760 ccb5bb4c 0000019d 
ccb5bb50
       ccb5bb50 cf25d8f0 00000002 ccabdc00 ccb5bb4c d0b26a08 ccabdd4c 
c0120005
Call Trace:
 [<c022d6cb>] __rwsem_deadlock+0xd9/0x12d (4)
 [<c0344760>] down_write+0x103/0x1a6 (48)
 [<d0b26a08>] kcond_wait+0xaa/0xac [reiser4] (36)
 [<c0120005>] do_fork+0x133/0x18a (8)
 [<c03443a8>] out_of_line_wait_on_bit+0x91/0x99 (32)
 [<c0134273>] wake_bit_function+0x0/0x55 (28)
 [<c0134c36>] check_preempt_timing+0x6e/0x1a4 (16)
 [<c034471a>] down_write+0xbd/0x1a6 (56)
 [<c034471a>] down_write+0xbd/0x1a6 (12)
 [<d0b280b0>] start_ktxnmgrd+0x98/0x9a [reiser4] (36)
 [<d0b33716>] reiser4_fill_super+0x3b/0x71 [reiser4] (28)
 [<c0160854>] sb_set_blocksize+0x2e/0x5d (588)
 [<c01603fd>] get_sb_bdev+0xf9/0x132 (24)
 [<d0b2d569>] reiser4_get_sb+0x2f/0x33 [reiser4] (68)
 [<d0b336db>] reiser4_fill_super+0x0/0x71 [reiser4] (20)
 [<c016061a>] do_kern_mount+0x4f/0xc0 (4)
 [<c0175945>] do_new_mount+0x9c/0xe1 (36)
 [<c0175feb>] do_mount+0x145/0x194 (44)
 [<c034471a>] down_write+0xbd/0x1a6 (48)
 [<c0175e4d>] copy_mount_options+0x63/0xbc (32)
 [<c0176459>] sys_mount+0x9f/0xe0 (32)
 [<c01060b1>] sysenter_past_esp+0x52/0x71 (44)
preempt count: 00000003
. 3-level deep critical section nesting:
.. entry 1: down_write+0x1a1/0x1a6 / (0x0)
.. entry 2: down_write+0x6a/0x1a6 / (0x0)
.. entry 3: print_traces+0x17/0x50 / (0x0)

------------[ cut here ]------------
kernel BUG at lib/rwsem-generic.c:601!
invalid operand: 0000 [#1]
PREEMPT
Modules linked in: reiser4 airo_cs airo ohci_hcd ehci_hcd 8139cp mii 
ohci1394 ieee1394 snd_intel8x0 snd_ac97_codec usbhid uhci_hcd intel_agp 
agpgart snd_seq_oss snd_seq_midi_event snd_seq snd_seq_device 
snd_pcm_oss snd_pcm snd_timer snd_page_alloc snd_mixer_oss snd usbcore 
vfat fat
CPU:    0
EIP:    0060:[<c022dc15>]    Not tainted VLI
EFLAGS: 00010202   (2.6.9-rc4-mm1-RT-U9.1)
EIP is at up_write+0x1dc/0x1e9
eax: cca0a000   ebx: ccb5bb48   ecx: 0000002f   edx: cf25d8f0
esi: ccb5bb4c   edi: ccabdc00   ebp: cf1ad970   esp: cca0bf84
ds: 007b   es: 007b   ss: 0068   preempt: 00000001
Process ktxnmgrd (pid: 10544, threadinfo=cca0a000 task=cf1ad970)
Stack: 00000001 cf1ad970 ccabdc00 cf1ad970 ccb5bb48 ccabdc00 ccabdc00 
cf1ad970
       d0b26b9f ccabdc00 cdf87000 ccabdd4c d0b27de5 ccabdc00 c0105fda 
cf205260
       d0b27d4c 00000000 cc9d5400 00000000 00000000 00000000 cca0a000 
d0b27d4c
Call Trace:
 [<d0b26b9f>] kcond_broadcast+0x23/0x46 [reiser4] (36)
 [<d0b27de5>] ktxnmgrd+0x99/0x22c [reiser4] (16)
 [<c0105fda>] ret_from_fork+0x6/0x14 (8)
 [<d0b27d4c>] ktxnmgrd+0x0/0x22c [reiser4] (8)
 [<d0b27d4c>] ktxnmgrd+0x0/0x22c [reiser4] (28)
 [<c01042a9>] kernel_thread_helper+0x5/0xb (16)
preempt count: 00000002
. 2-level deep critical section nesting:
.. entry 1: die+0x39/0x198 / (0x0)
.. entry 2: print_traces+0x17/0x50 / (0x0)

