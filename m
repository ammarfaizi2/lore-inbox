Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285433AbRLNR6H>; Fri, 14 Dec 2001 12:58:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285435AbRLNR55>; Fri, 14 Dec 2001 12:57:57 -0500
Received: from roc-24-169-102-121.rochester.rr.com ([24.169.102.121]:12698
	"EHLO roc-24-169-102-121.rochester.rr.com") by vger.kernel.org
	with ESMTP id <S285433AbRLNR5j>; Fri, 14 Dec 2001 12:57:39 -0500
Date: Fri, 14 Dec 2001 12:53:00 -0500
From: Chris Mason <mason@suse.com>
To: Andrew Morton <akpm@zip.com.au>
cc: Johan Ekenberg <johan@ekenberg.se>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        jack@suse.cz, linux-kernel@vger.kernel.org
Subject: Re: Lockups with 2.4.14 and 2.4.16
Message-ID: <3845670000.1008352380@tiny>
In-Reply-To: <3C1A3652.52B989E4@zip.com.au>
In-Reply-To: <000a01c1829f$75daf7a0$050010ac@FUTURE>
 ,	<000a01c1829f$75daf7a0$050010ac@FUTURE> <3825380000.1008348567@tiny>
 <3C1A3652.52B989E4@zip.com.au>
X-Mailer: Mulberry/2.1.0 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Friday, December 14, 2001 09:26:42 AM -0800 Andrew Morton
<akpm@zip.com.au> wrote:

> Chris Mason wrote:
>> 
>> Ok, Johan sent along stack traces, and the deadlock works a little like
>> this:
>> 
>> linux-2.4.16 + reiserfs + quota v2
>> 
>> kswapd ->
>> prune_icache->dispose_list->dquot_drop->commit_dquot->generic_file_write->
>> mark_inode_dirty->journal_begin-> wait for trans to end
> 
> uh-huh.
> 
>> Some process in the transaction is waiting on kswapd to free ram.
> 
> This is unfamiliar.  Where does a process block on kswapd in this
> manner?  Not __alloc_pages I think.

It kinda blocks on kswapd by default when the process in the transaction
needs to read a block, or allocate one for the commit.  Since kswapd is stuck
waiting on the log, eventually a process holding the transaction will try to
allocate something when there are no pages freeable with GFP_NOFS.

It was much worse when we just had GFP_BUFFER before, but the deadlock is
still there.

>  
>> So, this will hit any journaled FS that uses quotas and logs inodes under
>> during a write.  ext3 doesn't seem to do special things for quota anymore,
>> so it should be affected too.
> 
> mm.. most of the ext3 damage-avoidance hacks are around writepage().

sct talked about how the ext3 data logging code allowed quotas to be
consistent after a crash.  Perhaps this was just in 2.2.x...

> 
>> The only fix I see is to make sure kswapd doesn't run shrink_icache, and to
>> have it done via a dedicated daemon instead.  Does anyone have a better
>> idea?
> 
> Well, we already need to do something like that to prevent the
> abuse of keventd in there.  It appears that somebody had a
> problem with deadlocks doing the inode writeout in kswapd but
> missed the quota problem.
> 
> Is it possible for the quota code to just bale out if PF_MEMALLOC
> is set?  To leave the dquot dirty?

We could change prune_icache to skip inodes with dirty quota fields.  It
already skips dirty inodes, so this isn't a huge change.

I'll try this, and also add kinoded so we can avoid using keventd.  I'm wary
of the affects on the VM if kinoded can't keep up though, so I'd like to keep
the shrink_icache call in kswapd if possible.

Johan, expect this to take at least a week before I suggest installing on
production machines.  Things are very intertwined here, and these changes
will probably have side effects that need dealing with.

Turning quotas off will solve the problem in the short term.

-chris

