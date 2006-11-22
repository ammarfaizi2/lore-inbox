Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1756066AbWKVRoJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756066AbWKVRoJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Nov 2006 12:44:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756068AbWKVRoJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Nov 2006 12:44:09 -0500
Received: from port254.ds1-he.adsl.cybercity.dk ([217.157.198.197]:46956 "EHLO
	gere.msconsult.dk") by vger.kernel.org with ESMTP id S1756066AbWKVRoF convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Nov 2006 12:44:05 -0500
From: rasmus@msconsult.dk (Rasmus =?utf-8?Q?B=C3=B8g?= Hansen)
To: LKML <linux-kernel@vger.kernel.org>
Cc: Rasmus B??g Hansen <rasmus@msconsult.dk>
Subject: Re: nfs3: possible recursive locking (Re: BUG: soft lockup detected on CPU#0! (2.6.18.2))
References: <867ixyvum6.fsf@gere.msconsult.dk>
	<slrnelofru.7lr.olecom@flower.upol.cz>
	<86odr6f55x.fsf@gere.msconsult.dk> <86ac2jekn2.fsf@sif.msconsult.dk>
	<20061122141233.GA2225@flower.upol.cz>
Date: Wed, 22 Nov 2006 18:43:33 +0100
Message-ID: <86odqzbcmy.fsf@sif.msconsult.dk>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Organization: MS Consult
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-MSC-MailScanner: Found to be clean
X-MSC-MailScanner-From: rasmus@msconsult.dk
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oleg Verych <olecom@flower.upol.cz> writes:

> On Wed, Nov 22, 2006 at 01:22:25PM +0100, Rasmus B??g Hansen wrote:
> []
>> >> (gitweb down, i can't check history of smbfs, and i have amd64 arch, anyway)
>> >>> Nov 12 03:54:57 gere kernel: BUG: soft lockup detected on CPU#0!
>> >>> Nov 12 03:54:57 gere kernel:  [softlockup_tick+170/195] softlockup_tick+0xaa/0xc3
>> >>> Nov 12 03:54:57 gere kernel:  [update_process_times+56/137] update_process_times+0x38/0x89
>> >>> Nov 12 03:54:57 gere kernel:  [smp_apic_timer_interrupt+105/117] smp_apic_timer_interrupt+0x69/0x75
>> >>> Nov 12 03:54:57 gere kernel:  [smbiod+238/348] smbiod+0xee/0x15c
>> >> this
>> >>
>> >>> Nov 12 03:54:57 gere kernel:  [apic_timer_interrupt+31/36] apic_timer_interrupt+0x1f/0x24
>> >>> Nov 12 03:54:57 gere kernel:  [journal_init_revoke+49/678] journal_init_revoke+0x31/0x2a6
>> >>> Nov 12 03:54:57 gere kernel:  [smbiod+238/348] smbiod+0xee/0x15c
>> >> and this *may be* double (un)lock.
>> >
>> > Hopefully lock debugging will tell.
>> 
>> I got this - I think it was this morning (somehow kernel logging was
>> disabled so I can't tell the exact time):
>
> Did this like "my server froze. It was entirely dead and had to be power
> cycled."?

Sorry, I forgot. No it didn't freeze, it is still gladly running as if
nothing happened.

>> ----
>> 
>> =============================================
>> [ INFO: possible recursive locking detected ]
>> ---------------------------------------------
>> nfsd/1788 is trying to acquire lock:
>>  (&inode->i_mutex){--..}, at: [<c02cc35c>] mutex_lock+0x8/0xa
>> 
>> but task is already holding lock:
>>  (&inode->i_mutex){--..}, at: [<c02cc35c>] mutex_lock+0x8/0xa
>> 
>> other info that might help us debug this:
>> 2 locks held by nfsd/1788:
>>  #0:  (hash_sem){----}, at: [<e0930d99>] exp_readlock+0x12/0x16 [nfsd]
>>  #1:  (&inode->i_mutex){--..}, at: [<c02cc35c>] mutex_lock+0x8/0xa
>> 
>> stack backtrace:
>>  [<c0103c10>] show_trace+0x27/0x2b
>>  [<c0103d2d>] dump_stack+0x26/0x2a
>>  [<c01353ba>] print_deadlock_bug+0xb5/0xba
>>  [<c0135420>] check_deadlock+0x61/0x71
>>  [<c0136da3>] __lock_acquire+0x334/0x9b6
>>  [<c0137b3d>] lock_acquire+0x75/0x90
>>  [<c02cb9a1>] __mutex_lock_slowpath+0x85/0x270
>>  [<c02cc35c>] mutex_lock+0x8/0xa
>>  [<e092cb75>] nfsd_setattr+0x3ca/0x574 [nfsd]
>>  [<e092e3a8>] nfsd_create_v3+0x3a6/0x540 [nfsd]
>>  [<e0934d4b>] nfsd3_proc_create+0x118/0x161 [nfsd]
>>  [<e0929751>] nfsd_dispatch+0xd8/0x1ff [nfsd]
>>  [<e08e8503>] svc_process+0x4e5/0x6da [sunrpc]
>>  [<e09294e7>] nfsd+0x1cc/0x35e [nfsd]
>>  [<c01010b9>] kernel_thread_helper+0x5/0xb
>> 
>> ----

This happens on 2.6.18.3 too:

Nov 22 18:30:11 gere kernel: Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
Nov 22 18:30:22 gere kernel:
Nov 22 18:30:22 gere kernel: =============================================
Nov 22 18:30:22 gere kernel: [ INFO: possible recursive locking detected ]
Nov 22 18:30:22 gere kernel: ---------------------------------------------
Nov 22 18:30:22 gere kernel: nfsd/1789 is trying to acquire lock:
Nov 22 18:30:22 gere kernel:  (&inode->i_mutex){--..}, at: [mutex_lock+8/10] mutex_lock+0x8/0xa
Nov 22 18:30:22 gere kernel:
Nov 22 18:30:22 gere kernel: but task is already holding lock:
Nov 22 18:30:22 gere kernel:  (&inode->i_mutex){--..}, at: [mutex_lock+8/10] mutex_lock+0x8/0xa
Nov 22 18:30:22 gere kernel:
Nov 22 18:30:22 gere kernel: other info that might help us debug this:
Nov 22 18:30:22 gere kernel: 2 locks held by nfsd/1789:
Nov 22 18:30:22 gere kernel:  #0:  (hash_sem){----}, at: [pg0+539970969/1067197440] exp_readlock+0x12/0x16 [nfsd]
Nov 22 18:30:22 gere kernel:  #1:  (&inode->i_mutex){--..}, at: [mutex_lock+8/10] mutex_lock+0x8/0xa
Nov 22 18:30:22 gere kernel:
Nov 22 18:30:22 gere kernel: stack backtrace:
Nov 22 18:30:22 gere kernel:  [show_trace+39/43] show_trace+0x27/0x2b
Nov 22 18:30:22 gere kernel:  [dump_stack+38/42] dump_stack+0x26/0x2a
Nov 22 18:30:22 gere kernel:  [print_deadlock_bug+181/186] print_deadlock_bug+0xb5/0xba
Nov 22 18:30:22 gere kernel:  [check_deadlock+97/113] check_deadlock+0x61/0x71
Nov 22 18:30:22 gere kernel:  [__lock_acquire+820/2486] __lock_acquire+0x334/0x9b6
Nov 22 18:30:22 gere kernel:  [lock_acquire+117/144] lock_acquire+0x75/0x90
Nov 22 18:30:22 gere kernel:  [__mutex_lock_slowpath+133/624] __mutex_lock_slowpath+0x85/0x270
Nov 22 18:30:22 gere kernel:  [mutex_lock+8/10] mutex_lock+0x8/0xa
Nov 22 18:30:22 gere kernel:  [pg0+539954037/1067197440] nfsd_setattr+0x3ca/0x574 [nfsd]
Nov 22 18:30:22 gere kernel:  [pg0+539960232/1067197440] nfsd_create_v3+0x3a6/0x540 [nfsd]
Nov 22 18:30:22 gere kernel:  [pg0+539987275/1067197440] nfsd3_proc_create+0x118/0x161 [nfsd]
Nov 22 18:30:22 gere kernel:  [pg0+539940689/1067197440] nfsd_dispatch+0xd8/0x1ff [nfsd]
Nov 22 18:30:22 gere kernel:  [pg0+539673859/1067197440] svc_process+0x4e5/0x6da [sunrpc]
Nov 22 18:30:22 gere kernel:  [pg0+539940071/1067197440] nfsd+0x1cc/0x35e [nfsd]
Nov 22 18:30:22 gere kernel:  [kernel_thread_helper+5/11] kernel_thread_helper+0x5/0xb

I took the first line too as to show that it happens 11 seconds after
starting knfsd. It seems that cron is starting at the same time and
squid is rebuilding it's (rather small) cache (I don't think these
have any connection). I have only NFS exports, no NFS mounts.

Regards

-- 
Rasmus Bøg Hansen
MSC Aps
Bøgesvinget 8
2740 Skovlunde
44 53 93 66

