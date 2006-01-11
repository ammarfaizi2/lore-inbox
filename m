Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751364AbWAKFQb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751364AbWAKFQb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 00:16:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751372AbWAKFQa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 00:16:30 -0500
Received: from tornado.reub.net ([202.89.145.182]:24199 "EHLO tornado.reub.net")
	by vger.kernel.org with ESMTP id S1751364AbWAKFQa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 00:16:30 -0500
Message-ID: <43C4947C.1040703@reub.net>
Date: Wed, 11 Jan 2006 18:15:40 +1300
From: Reuben Farrelly <reuben-lkml@reub.net>
User-Agent: Thunderbird 1.6a1 (Windows/20060109)
MIME-Version: 1.0
To: Neil Brown <neilb@suse.de>
CC: Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.15-mm2
References: <20060107052221.61d0b600.akpm@osdl.org>	<43BFD8C1.9030404@reub.net>	<20060107133103.530eb889.akpm@osdl.org>	<43C38932.7070302@reub.net>	<20060110104759.GA30546@elte.hu>	<43C3A85A.7000003@reub.net>	<20060110044240.3d3aa456.akpm@osdl.org>	<20060110131618.GA27123@elte.hu> <17348.34472.105452.831193@cse.unsw.edu.au>
In-Reply-To: <17348.34472.105452.831193@cse.unsw.edu.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/01/2006 5:16 p.m., Neil Brown wrote:
> On Tuesday January 10, mingo@elte.hu wrote:
>> * Andrew Morton <akpm@osdl.org> wrote:
>>
>>> Reuben Farrelly <reuben-lkml@reub.net> wrote:
>>>> Ok here's the latest one, this time with KALLSYMS_ALL, CONFIG_FRAME_POINTER, 
>>>>  CONFIG_DETECT_SOFTLOCKUP and the DEBUG_WARN_ON(current->state != TASK_RUNNING); 
>>>>  patch from Ingo.
>>> This is quite ugly.  I'd be suspecting a block layer problem: RAID or 
>>> the underlying device driver (ahci) has lost an IO.
>> yeah, now it more looks like that to me too. What happens is a raid1 
>> resync happens in the background - which is one of the more complex 
>> raid1 workloads - and there've been a good number of md patches 
>> recently. Reuben, does -git5 show the same symptoms?
> 
> There isn't a resync happening - if there was you would a process
> called
>    mdX_resync
> (for some X).
> 
> What I see here is:
>  pdflush at:
> Call Trace:
>   [<c02a2f72>] md_write_start+0xbc/0x150
>   [<c029a659>] make_request+0x51/0x432
>   [<c01e1146>] generic_make_request+0xbe/0x13d
>   [<c01e120e>] submit_bio+0x49/0xd3
> 
> So it is trying to write to a raid1 which was 'clean' and needs to
> be marked 'dirty' (or 'active') before the first write.
> md_start_write arranges for the array's thread to do this.
> What is that thread doing?
> 
> md2_raid1     D F7227200     0   386     11           390   382 (L-TLB)
>   ...
> Call Trace:
>   [<c029d004>] md_super_wait+0xd5/0xea
>   [<c02a4f93>] bitmap_unplug+0x1d8/0x1df
>   [<c029b72b>] raid1d+0x7d/0x555
>   [<c02a211a>] md_thread+0x44/0x14f
> 
> It probably hasn't tried to write out the superblock, and just
> now it is writing out some write-intent-bitmap entries and waiting
> for the write to complete.
> 
> md_super_wait is waiting for 'pending_writes' to become zero.
> It is incremented when any superblock or bitmap write starts, and
> is decremented when that write completes.
> 
> So a lost write request in one of the components of the array could
> cause this, but it is too easy to simply blame it on someone else....
> 
> But there is something I don't understand....
> 
> If md2_raid1 is in bitmap_unplug, that means there are outstanding
> write requests to md2_raid1, so the one that pdflush is currently
> generating cannot be the first.
> 
> This suggests that pdflush is not writing to md2, but to something
> else.
> Ahhhh.. md0_raid1 is also blocked:
> Call Trace:
>   [<c029d004>] md_super_wait+0xd5/0xea
>   [<c029ec29>] md_update_sb+0xc9/0x153
>   [<c02a3a20>] md_check_recovery+0x182/0x437
>   [<c029b6cd>] raid1d+0x1f/0x555
> 
> It has just updated the superblocks for md0 and is waiting for those
> writes to complete.  But they don't seem to want to complete.
> 
> So it seems that two raid1 arrays are blocked in slightly different
> places.
> 
> I'm tempted to blame the IO scheduled, only because there have been
> vaguely similar problems in the recent past that can be avoided by
> changing the scheduler.
> 
> Reuben:  could you check what IO scheduler your drives are using, and 
> try changing it.  I suspect they use 'as' by default.  Try 'cfq' or
> 'deadline'.

By default it was using 'deadline', but I just added elevator=as to my kernel 
command line, and it still failed in the same way :(  I'm building all four 
schedulers into the kernel (should probably optimise that to one someday but not 
now..)

I'm tempted to see if I can narrow it down to a specific -gitX release, maybe 
that would narrow it down to say, 200 or so patches ;-)

reuben


