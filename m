Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964885AbWEaJS6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964885AbWEaJS6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 May 2006 05:18:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964912AbWEaJS5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 May 2006 05:18:57 -0400
Received: from mx5.redainternet.nl ([82.98.244.137]:21510 "EHLO
	mx5.redainternet.nl") by vger.kernel.org with ESMTP id S964885AbWEaJS4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 May 2006 05:18:56 -0400
Message-ID: <447D5F7C.8020401@inn.nl>
Date: Wed, 31 May 2006 11:18:52 +0200
From: Arend Freije <afreije@inn.nl>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de-AT; rv:1.8.0.1) Gecko/20060418 SeaMonkey/1.0
MIME-Version: 1.0
To: Neil Brown <neilb@suse.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: RAID-1 and Reiser4 issue: umount hangs
References: <4478CF33.80609@inn.nl>	<17528.55008.287088.705263@cse.unsw.edu.au>	<44797136.4050707@inn.nl> <17530.14115.195147.46212@cse.unsw.edu.au>
In-Reply-To: <17530.14115.195147.46212@cse.unsw.edu.au>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Brown wrote:
> On Sunday May 28, Arend Freije wrote:
>   
>> Neil Brown wrote:
>>     
>>> # echo t > /proc/sysrq-trigger
>>>
>>> and look at the resulting kernel messages, particularly for the
>>> unmount process.  If they don't make sense to you, post them.  
>>>       
>> Tnx for your response. After recompiling the kernel with magic_sysrq
>> enabled, rebooting, and repeating umount with the reiser4 md device, the
>> following trace contains a reiser4-entry:
>>     
>
> This looks very much like a reiser4 problem rather than a raid
> problem, or at least you will need someone very familiar with reiser4
> to understand what is going on here.
>
> I recommend you post this information to 
>    reiserfs-dev@namesys.com
>   
That would be reiserfs-list@namesys.com
> (and  cc: to linux-kernel too if you like) to make sure someone
> knowledgeable sees it.
>
> I suspect reiser4 has some kernel threads that it uses.  They might
> have 'obvious' names like  
>    ent:....
>    ktxnmgrd
> from looking at the source.  Including the stack trace of these and
> anything else with 'reiser4' in the trace would probably be helpful.
>
> NeilBrown
>
>   


Alexander Zarochentsev wrote:

>>> would it work better with "no_write_barrier" mount option?
>>>      
>> It would indeed. What's the purpose of this option?
>>    
>
> It disables write barrier support in reiser4 which may be buggy.  It is
> not necessary that reiser4 code has a bug, but the elevator, md device
> or disk driver code.


Alexander,

You're probably right. I found several posts on the linux-kernel list
involving problems with write barrier support in combination with SATA
and ext3 . So I tried:

# mkfs -t ext3 /dev/md/0
# mount -o barrier=1 /dev/md/0 /mnt
# cp -a $src /mnt
# umount /mnt

And indeed, umount hangs now as well.
So it seems to be a linux-kernel issue after all...

The call traces of interrest with the ext3 case seem to be:

> kjournald     D 00000000     0  6790      1                6745 (L-TLB)
> f104ddcc 00000000 c1808320 00000000 00000000 f76cb2b0 c011b591 dfcc3a90
> 5b666c00 003d092c 00000000 00000000 dfcc3a90 c1808320 00000000 c1808320
> 00000000 5b666c00 003d092c f7c77a90 f7c77bb8 c1808320 00000000 f104de38
> Call Trace:
> [<c011b591>] __wake_up_common+0x41/0x70
> [<c0315766>] io_schedule+0x26/0x30
> [<c016af13>] sync_buffer+0x53/0x60
> [<c03158f5>] __wait_on_bit+0x45/0x70
> [<c016aec0>] sync_buffer+0x0/0x60
> [<c016aec0>] sync_buffer+0x0/0x60
> [<c03159bd>] out_of_line_wait_on_bit+0x9d/0xc0
> [<c0136a30>] wake_bit_function+0x0/0x60
> [<c0136a30>] wake_bit_function+0x0/0x60
> [<c016ee0e>] sync_dirty_buffer+0x5e/0xd0
> [<f9d57055>] journal_write_commit_record+0x95/0x140 [jbd]
> [<f9d5cd18>] journal_free_journal_head+0x18/0x20 [jbd]
> [<f9d5d266>] journal_put_journal_head+0x96/0x100 [jbd]
> [<f9d56207>] journal_unfile_buffer+0x67/0xb0 [jbd]
> [<f9d57ca7>] journal_commit_transaction+0xba7/0x13a0 [jbd]
> [<c0314f85>] preempt_schedule+0x45/0x70
> [<c012ab24>] lock_timer_base+0x24/0x50
> [<c012ad91>] try_to_del_timer_sync+0x51/0x60
> [<f9d5aa45>] kjournald+0xa5/0x220 [jbd]
> [<c01369d0>] autoremove_wake_function+0x0/0x60
> [<c01369d0>] autoremove_wake_function+0x0/0x60
> [<c0102fa2>] ret_from_fork+0x6/0x14
> [<f9d5a990>] commit_timeout+0x0/0x10 [jbd]
> [<f9d5a9a0>] kjournald+0x0/0x220 [jbd]
> [<c0101225>] kernel_thread_helper+0x5/0x10

and

> umount        D C014761A     0  6806   6779                     (NOTLB)
> f0d0fe60 00000000 c1808320 c014761a f05efc9c f0d0fe6c 00000000 0000000e
> f548d48c f548d484 00000000 00000001 f0d0fe60 c011b600 f548d484 c1808320
> 0007a120 f80c8400 003d0930 dfcd1a70 dfcd1b98 f548d400 f548d464 f0d0fe88
> Call Trace:
> [<c014761a>] find_get_pages+0x5a/0x70
> [<c011b600>] __wake_up+0x40/0x60
> [<f9d5ad35>] journal_kill_thread+0xc5/0x110 [jbd]
> [<c01369d0>] autoremove_wake_function+0x0/0x60
> [<c01369d0>] autoremove_wake_function+0x0/0x60
> [<f9eb2510>] ext3_clear_inode+0x20/0x40 [ext3]
> [<f9d5c181>] journal_destroy+0x11/0x1e0 [jbd]
> [<c018567d>] dispose_list+0xcd/0xf0
> [<f9eb21f9>] ext3_put_super+0x29/0x1b0 [ext3]
> [<c01857ad>] invalidate_inodes+0x5d/0x80
> [<c0170f76>] generic_shutdown_super+0x156/0x160
> [<c0171aed>] kill_block_super+0x2d/0x50



Kind Regards,

Arend Freije






 

