Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285468AbRLNT11>; Fri, 14 Dec 2001 14:27:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285469AbRLNT1R>; Fri, 14 Dec 2001 14:27:17 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:15888 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S285468AbRLNT1H>; Fri, 14 Dec 2001 14:27:07 -0500
Date: Fri, 14 Dec 2001 20:26:13 +0100
From: Jan Kara <jack@suse.cz>
To: Chris Mason <mason@suse.com>
Cc: Andrew Morton <akpm@zip.com.au>, Johan Ekenberg <johan@ekenberg.se>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: Lockups with 2.4.14 and 2.4.16
Message-ID: <20011214202613.D18256@atrey.karlin.mff.cuni.cz>
In-Reply-To: <000a01c1829f$75daf7a0$050010ac@FUTURE> <000a01c1829f$75daf7a0$050010ac@FUTURE> <3825380000.1008348567@tiny> <3C1A3652.52B989E4@zip.com.au> <3845670000.1008352380@tiny>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3845670000.1008352380@tiny>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Friday, December 14, 2001 09:26:42 AM -0800 Andrew Morton
> <akpm@zip.com.au> wrote:
> 
> >> So, this will hit any journaled FS that uses quotas and logs inodes under
> >> during a write.  ext3 doesn't seem to do special things for quota anymore,
> >> so it should be affected too.
> > 
> > mm.. most of the ext3 damage-avoidance hacks are around writepage().
> 
> sct talked about how the ext3 data logging code allowed quotas to be
> consistent after a crash.  Perhaps this was just in 2.2.x...
> 
> > 
> >> The only fix I see is to make sure kswapd doesn't run shrink_icache, and to
> >> have it done via a dedicated daemon instead.  Does anyone have a better
> >> idea?
> > 
> > Well, we already need to do something like that to prevent the
> > abuse of keventd in there.  It appears that somebody had a
> > problem with deadlocks doing the inode writeout in kswapd but
> > missed the quota problem.
> > 
> > Is it possible for the quota code to just bale out if PF_MEMALLOC
> > is set?  To leave the dquot dirty?
> 
> We could change prune_icache to skip inodes with dirty quota fields.  It
> already skips dirty inodes, so this isn't a huge change.
  Umm. I don't think it's good idea (at least with current state) - if any
data was written to inode, quota was dirtified and probably never written
so you're going to have *lots* of inodes with dirty quota... So you end up
freeing nothing.
  I think that leaving writing of dquots on bdflush or some other thread
would be better solution...

								Honza
--
Jan Kara <jack@suse.cz>
SuSE CR Labs
