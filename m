Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932663AbWEXIQM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932663AbWEXIQM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 May 2006 04:16:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932661AbWEXIQM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 May 2006 04:16:12 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:17066 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932656AbWEXIQL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 May 2006 04:16:11 -0400
Date: Wed, 24 May 2006 18:15:45 +1000
From: David Chinner <dgc@sgi.com>
To: Balbir Singh <balbir@in.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] Per-superblock unused dentry LRU lists.
Message-ID: <20060524081545.GI7418631@melbourne.sgi.com>
References: <20060524012412.GB7412499@melbourne.sgi.com> <20060524050214.GB9639@in.ibm.com> <20060524061933.GG7418631@melbourne.sgi.com> <20060524070605.GA7743@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060524070605.GA7743@in.ibm.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 24, 2006 at 12:36:06PM +0530, Balbir Singh wrote:
> > > You can use trylock. Please see the patches in -mm to fix the umount
> > > race.
> > 
> > I'm not sure what unmount race you are talking about.
> > 
> > AFAICT, there is no race here - we've got a reference on the superblock so  it
> > can't go away and the lru list is protected by the dcache_lock, so there's
> > nothing else we can race with. However, we can deadlock by taking the
> > s_umount lock here. So why even bother to try to take the lock when we don't
> > actually need it?
> 
> Please read the thread at http://lkml.org/lkml/2006/4/2/101.

Ok, thanks for the pointer. it's a completely differnt sort of race you're
talking about ;)

I'll have to look at the -mm tree and how the locking is different
there before commenting further.

> > > > +		if (__put_super_and_need_restart(sb) && count)
> > > > +			goto restart;
> > > 
> > > Comment please.
> > 
> > I'm not sure what a comment needs to explain that the code doesn't.
> > Which bit do you think needs commenting?
> 
> I was referring to the __put_super_and_need_restart() part.

Ok. i didn't think it necessary given it's use in several other places
and the comment at the head of __put_super_and_need_restart() explain
exactly what it does and when to use it. Comment added anyway.

> > > This should not be required with per super-block dentries. The only
> > > reason, I think we moved dentries to the tail is to club all entries
> > > from the sb together (to free them all at once).
> > 
> > I think we still need to do that. We get called in contexts that aren't
> > related to unmounting, so we want these dentries to be the first
> > to be reclaimed from that superblock when we next call prune_dcache().
> 
> Is it? I quickly checked the callers of shrink_dcache_sb() and all of
> them seem to be mount related. shrink_dcache_parent() is another story.
> Am I missing something? Code reference will be particularly useful.

I thought you were referring to shrink_dcache_parent(). At least, I
was, and the hunk of diff that your comment followed after was from
select_parent(). Please correct me if I'm wrong, but I think we're
agreeing that it's doing the right thing in select_parent().

The modified shrink_dcache_sb() doesn't do do any list moving at all,
it simply frees all the dentries on the superblock in a single pass.....

Cheers,

Dave.
-- 
Dave Chinner
R&D Software Enginner
SGI Australian Software Group
