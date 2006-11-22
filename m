Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754347AbWKVMWy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754347AbWKVMWy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Nov 2006 07:22:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755084AbWKVMWy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Nov 2006 07:22:54 -0500
Received: from port254.ds1-he.adsl.cybercity.dk ([217.157.198.197]:37220 "EHLO
	gere.msconsult.dk") by vger.kernel.org with ESMTP id S1754341AbWKVMWx convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Nov 2006 07:22:53 -0500
From: rasmus@msconsult.dk (Rasmus =?utf-8?Q?B=C3=B8g?= Hansen)
To: rasmus@msconsult.dk (Rasmus =?utf-8?Q?B=C3=B8g?= Hansen)
Cc: Oleg Verych <olecom@flower.upol.cz>, LKML <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: smbfs (Re: BUG: soft lockup detected on CPU#0! (2.6.18.2))
References: <867ixyvum6.fsf@gere.msconsult.dk>
	<slrnelofru.7lr.olecom@flower.upol.cz>
	<86odr6f55x.fsf@gere.msconsult.dk>
Date: Wed, 22 Nov 2006 13:22:25 +0100
Message-ID: <86ac2jekn2.fsf@sif.msconsult.dk>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Organization: MS Consult
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-MSC-MailScanner: Found to be clean
X-MSC-MailScanner-From: rasmus@msconsult.dk
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

rasmus@msconsult.dk (Rasmus Bøg Hansen) writes:

> Oleg Verych <olecom@flower.upol.cz> writes:
>
>> [ Adding e-mail of Andrew Morton, he may have clue about who to ping ;]
>> [ MAINTAINERS.smbfs seems to be emply                                 ]
>>
>> On 2006-11-14, Rasmus BЬg Hansen wrote:
>> []
>>> [1.] One line summary of the problem:
>>>
>>> Kernel BUG's and freezes after a soft lockup.
>>>
>>> [2.] Full description of the problem/report:
>>>
>>> The night before sunday, my server froze. It was entirely dead and had
>>> to be power cycled. There was no seriel console connected but it
>>> managed to log a short BUG before, which seems related to smbfs.
>>>
>>> As it happened in the night, I am unsure what triggered the bug, but
>>> it was during the nightly backup routines, which includes running
>>> rsync over ssh (over ADSL so pretty slow) and writing some large
>>> .tar.bz2 to a smbfs drive. I assume (but do no know for sure) that it
>>> was the last one that triggered the bug.
>>
>> Nobody seems to picked this up. So.
>> Why don't you try debian's kernel 2.6.18 from unstable?
>
> I haven't tried that, partially to get rid of the initrd and have
> drivers for the controllers/disks in-kernel, partially because I like
> having built my own kernel. That might be silly, of course - I can try
> the Debian kernel, if you think it would make a difference.
>
>> I see, you've build it yourself, then try to enable some more locking
>> debuging in the "kernel hacking" section.
>
> I am now running with all lock debugging turned on. "Unfortunately"
> the machine has been running stable since the crash last weekend -
> perhaps the extra-large backup rourines at sunday may trigger it
> again...
>
>> (gitweb down, i can't check history of smbfs, and i have amd64 arch, anyway)
>>> Nov 12 03:54:57 gere kernel: BUG: soft lockup detected on CPU#0!
>>> Nov 12 03:54:57 gere kernel:  [softlockup_tick+170/195] softlockup_tick+0xaa/0xc3
>>> Nov 12 03:54:57 gere kernel:  [update_process_times+56/137] update_process_times+0x38/0x89
>>> Nov 12 03:54:57 gere kernel:  [smp_apic_timer_interrupt+105/117] smp_apic_timer_interrupt+0x69/0x75
>>> Nov 12 03:54:57 gere kernel:  [smbiod+238/348] smbiod+0xee/0x15c
>> this
>>
>>> Nov 12 03:54:57 gere kernel:  [apic_timer_interrupt+31/36] apic_timer_interrupt+0x1f/0x24
>>> Nov 12 03:54:57 gere kernel:  [journal_init_revoke+49/678] journal_init_revoke+0x31/0x2a6
>>> Nov 12 03:54:57 gere kernel:  [smbiod+238/348] smbiod+0xee/0x15c
>> and this *may be* double (un)lock.
>
> Hopefully lock debugging will tell.

I got this - I think it was this morning (somehow kernel logging was
disabled so I can't tell the exact time):

----

=============================================
[ INFO: possible recursive locking detected ]
---------------------------------------------
nfsd/1788 is trying to acquire lock:
 (&inode->i_mutex){--..}, at: [<c02cc35c>] mutex_lock+0x8/0xa

but task is already holding lock:
 (&inode->i_mutex){--..}, at: [<c02cc35c>] mutex_lock+0x8/0xa

other info that might help us debug this:
2 locks held by nfsd/1788:
 #0:  (hash_sem){----}, at: [<e0930d99>] exp_readlock+0x12/0x16 [nfsd]
 #1:  (&inode->i_mutex){--..}, at: [<c02cc35c>] mutex_lock+0x8/0xa

stack backtrace:
 [<c0103c10>] show_trace+0x27/0x2b
 [<c0103d2d>] dump_stack+0x26/0x2a
 [<c01353ba>] print_deadlock_bug+0xb5/0xba
 [<c0135420>] check_deadlock+0x61/0x71
 [<c0136da3>] __lock_acquire+0x334/0x9b6
 [<c0137b3d>] lock_acquire+0x75/0x90
 [<c02cb9a1>] __mutex_lock_slowpath+0x85/0x270
 [<c02cc35c>] mutex_lock+0x8/0xa
 [<e092cb75>] nfsd_setattr+0x3ca/0x574 [nfsd]
 [<e092e3a8>] nfsd_create_v3+0x3a6/0x540 [nfsd]
 [<e0934d4b>] nfsd3_proc_create+0x118/0x161 [nfsd]
 [<e0929751>] nfsd_dispatch+0xd8/0x1ff [nfsd]
 [<e08e8503>] svc_process+0x4e5/0x6da [sunrpc]
 [<e09294e7>] nfsd+0x1cc/0x35e [nfsd]
 [<c01010b9>] kernel_thread_helper+0x5/0xb

----

Also it doesn't seem to be related to smbfs AFAICS - I am not enough
into lock debugging to say if this is relevant, useful or just
noise...

Regards
/Rasmus

-- 
Rasmus Bøg Hansen
MSC Aps
Bøgesvinget 8
2740 Skovlunde
44 53 93 66

