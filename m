Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755927AbWKVOFt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755927AbWKVOFt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Nov 2006 09:05:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755942AbWKVOFt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Nov 2006 09:05:49 -0500
Received: from raven.upol.cz ([158.194.120.4]:44244 "EHLO raven.upol.cz")
	by vger.kernel.org with ESMTP id S1755927AbWKVOFs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Nov 2006 09:05:48 -0500
Date: Wed, 22 Nov 2006 14:12:33 +0000
To: Rasmus B??g Hansen <rasmus@msconsult.dk>
Cc: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: nfs3: possible recursive locking (Re: BUG: soft lockup detected on CPU#0! (2.6.18.2))
Message-ID: <20061122141233.GA2225@flower.upol.cz>
References: <867ixyvum6.fsf@gere.msconsult.dk> <slrnelofru.7lr.olecom@flower.upol.cz> <86odr6f55x.fsf@gere.msconsult.dk> <86ac2jekn2.fsf@sif.msconsult.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86ac2jekn2.fsf@sif.msconsult.dk>
User-Agent: Mutt/1.5.13 (2006-08-11)
From: Oleg Verych <olecom@flower.upol.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 22, 2006 at 01:22:25PM +0100, Rasmus B??g Hansen wrote:
[]
> >> (gitweb down, i can't check history of smbfs, and i have amd64 arch, anyway)
> >>> Nov 12 03:54:57 gere kernel: BUG: soft lockup detected on CPU#0!
> >>> Nov 12 03:54:57 gere kernel:  [softlockup_tick+170/195] softlockup_tick+0xaa/0xc3
> >>> Nov 12 03:54:57 gere kernel:  [update_process_times+56/137] update_process_times+0x38/0x89
> >>> Nov 12 03:54:57 gere kernel:  [smp_apic_timer_interrupt+105/117] smp_apic_timer_interrupt+0x69/0x75
> >>> Nov 12 03:54:57 gere kernel:  [smbiod+238/348] smbiod+0xee/0x15c
> >> this
> >>
> >>> Nov 12 03:54:57 gere kernel:  [apic_timer_interrupt+31/36] apic_timer_interrupt+0x1f/0x24
> >>> Nov 12 03:54:57 gere kernel:  [journal_init_revoke+49/678] journal_init_revoke+0x31/0x2a6
> >>> Nov 12 03:54:57 gere kernel:  [smbiod+238/348] smbiod+0xee/0x15c
> >> and this *may be* double (un)lock.
> >
> > Hopefully lock debugging will tell.
> 
> I got this - I think it was this morning (somehow kernel logging was
> disabled so I can't tell the exact time):

Did this like "my server froze. It was entirely dead and had to be power
cycled."?

> ----
> 
> =============================================
> [ INFO: possible recursive locking detected ]
> ---------------------------------------------
> nfsd/1788 is trying to acquire lock:
>  (&inode->i_mutex){--..}, at: [<c02cc35c>] mutex_lock+0x8/0xa
> 
> but task is already holding lock:
>  (&inode->i_mutex){--..}, at: [<c02cc35c>] mutex_lock+0x8/0xa
> 
> other info that might help us debug this:
> 2 locks held by nfsd/1788:
>  #0:  (hash_sem){----}, at: [<e0930d99>] exp_readlock+0x12/0x16 [nfsd]
>  #1:  (&inode->i_mutex){--..}, at: [<c02cc35c>] mutex_lock+0x8/0xa
> 
> stack backtrace:
>  [<c0103c10>] show_trace+0x27/0x2b
>  [<c0103d2d>] dump_stack+0x26/0x2a
>  [<c01353ba>] print_deadlock_bug+0xb5/0xba
>  [<c0135420>] check_deadlock+0x61/0x71
>  [<c0136da3>] __lock_acquire+0x334/0x9b6
>  [<c0137b3d>] lock_acquire+0x75/0x90
>  [<c02cb9a1>] __mutex_lock_slowpath+0x85/0x270
>  [<c02cc35c>] mutex_lock+0x8/0xa
>  [<e092cb75>] nfsd_setattr+0x3ca/0x574 [nfsd]
>  [<e092e3a8>] nfsd_create_v3+0x3a6/0x540 [nfsd]
>  [<e0934d4b>] nfsd3_proc_create+0x118/0x161 [nfsd]
>  [<e0929751>] nfsd_dispatch+0xd8/0x1ff [nfsd]
>  [<e08e8503>] svc_process+0x4e5/0x6da [sunrpc]
>  [<e09294e7>] nfsd+0x1cc/0x35e [nfsd]
>  [<c01010b9>] kernel_thread_helper+0x5/0xb
> 
> ----
> 
> Also it doesn't seem to be related to smbfs AFAICS - I am not enough

Yes, it doen't.

> into lock debugging to say if this is relevant, useful or just
> noise...

Do you think, i am? In prev. message there was smbiod() function in the
stach dump. And that, what i've pointed, was close enough to forest of
spinlocks in sources of that function. That's it.

Try to search archives for any nfsd bugs. I'm not interested in it, there
are many people on this.

____
