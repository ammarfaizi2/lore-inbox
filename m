Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285467AbRLNTW1>; Fri, 14 Dec 2001 14:22:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285464AbRLNTWR>; Fri, 14 Dec 2001 14:22:17 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:5904 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S285468AbRLNTWE>; Fri, 14 Dec 2001 14:22:04 -0500
Date: Fri, 14 Dec 2001 20:21:08 +0100
From: Jan Kara <jack@suse.cz>
To: Andrew Morton <akpm@zip.com.au>
Cc: Chris Mason <mason@suse.com>, Johan Ekenberg <johan@ekenberg.se>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: Lockups with 2.4.14 and 2.4.16
Message-ID: <20011214202107.C18256@atrey.karlin.mff.cuni.cz>
In-Reply-To: <000a01c1829f$75daf7a0$050010ac@FUTURE>, <000a01c1829f$75daf7a0$050010ac@FUTURE> <3825380000.1008348567@tiny> <3C1A3652.52B989E4@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3C1A3652.52B989E4@zip.com.au>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hello,

> Chris Mason wrote:
> > Ok, Johan sent along stack traces, and the deadlock works a little like this:
> > 
> > linux-2.4.16 + reiserfs + quota v2
> > 
> > kswapd ->
> > prune_icache->dispose_list->dquot_drop->commit_dquot->generic_file_write->
> > mark_inode_dirty->journal_begin-> wait for trans to end
> 
> uh-huh.
...
> > The only fix I see is to make sure kswapd doesn't run shrink_icache, and to
> > have it done via a dedicated daemon instead.  Does anyone have a better idea?
> 
> Well, we already need to do something like that to prevent the
> abuse of keventd in there.  It appears that somebody had a
> problem with deadlocks doing the inode writeout in kswapd but
> missed the quota problem.
> 
> Is it possible for the quota code to just bale out if PF_MEMALLOC
> is set?  To leave the dquot dirty?
  Nope. Writing of dquots works following way:
When dquot is used (referenced by inode) it's written only on explicit sync.
Otherwise it's just marked dirty. When last reference from inode to dquot is
dropped, dquot is written to disk (if marked dirty). Then it's put to the free
list from where it can be evicted by prune_dqcache().
  So when you don't write dquot when the last reference is dropped you
have to solve following issues:
  * you need to assure dquot is written sometimes
  * you need to make prune_dqcache() skip dirtified dquots

  The first problem probably can be solved using bdflush...
The second one is probably trivial as dquots use small amount of memory (~100 bytes
per user) and so we don't have to care much about vm balancing.

									Honza

--
Jan Kara <jack@suse.cz>
SuSE CR Labs
