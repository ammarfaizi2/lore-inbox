Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285427AbRLNR2t>; Fri, 14 Dec 2001 12:28:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285429AbRLNR2b>; Fri, 14 Dec 2001 12:28:31 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:40200 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S285427AbRLNR2R>; Fri, 14 Dec 2001 12:28:17 -0500
Message-ID: <3C1A3652.52B989E4@zip.com.au>
Date: Fri, 14 Dec 2001 09:26:42 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.17-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Chris Mason <mason@suse.com>
CC: Johan Ekenberg <johan@ekenberg.se>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        jack@suse.cz, linux-kernel@vger.kernel.org
Subject: Re: Lockups with 2.4.14 and 2.4.16
In-Reply-To: <000a01c1829f$75daf7a0$050010ac@FUTURE>,
		<000a01c1829f$75daf7a0$050010ac@FUTURE> <3825380000.1008348567@tiny>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Mason wrote:
> 
> Ok, Johan sent along stack traces, and the deadlock works a little like this:
> 
> linux-2.4.16 + reiserfs + quota v2
> 
> kswapd ->
> prune_icache->dispose_list->dquot_drop->commit_dquot->generic_file_write->
> mark_inode_dirty->journal_begin-> wait for trans to end

uh-huh.

> Some process in the transaction is waiting on kswapd to free ram.

This is unfamiliar.  Where does a process block on kswapd in this
manner?  Not __alloc_pages I think.
 
> So, this will hit any journaled FS that uses quotas and logs inodes under
> during a write.  ext3 doesn't seem to do special things for quota anymore, so
> it should be affected too.

mm.. most of the ext3 damage-avoidance hacks are around writepage().

> The only fix I see is to make sure kswapd doesn't run shrink_icache, and to
> have it done via a dedicated daemon instead.  Does anyone have a better idea?

Well, we already need to do something like that to prevent the
abuse of keventd in there.  It appears that somebody had a
problem with deadlocks doing the inode writeout in kswapd but
missed the quota problem.

Is it possible for the quota code to just bale out if PF_MEMALLOC
is set?  To leave the dquot dirty?

-
