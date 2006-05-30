Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932397AbWE3X4e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932397AbWE3X4e (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 19:56:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932538AbWE3X4e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 19:56:34 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:9945 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932397AbWE3X4c (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 19:56:32 -0400
Date: Wed, 31 May 2006 09:56:06 +1000
From: David Chinner <dgc@sgi.com>
To: Jan Blunck <jblunck@suse.de>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       viro@zeniv.linux.org.uk
Subject: Re: [patch 5/5] vfs: per superblock dentry unused list
Message-ID: <20060530235606.GL8069029@melbourne.sgi.com>
References: <20060526110655.197949000@suse.de>> <20060526110803.159085000@suse.de> <20060529030834.GU8069029@melbourne.sgi.com> <20060529115443.GG21024@hasse.suse.de> <20060530000443.GB8069029@melbourne.sgi.com> <20060530100633.GH21024@hasse.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060530100633.GH21024@hasse.suse.de>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 30, 2006 at 12:06:33PM +0200, Jan Blunck wrote:
> On Tue, May 30, David Chinner wrote:
> 
> > You've just described the embodiment of the two order's of magnitude
> > issue I mentioned. That's not a wrong assumption - think of the
> > above case with global_unused count now being 1.28*10^7 instead of
> > 1.28x10^4. How many dentries do you have to free before freeing any
> > on the small superblock if we don't free one per call? (quick
> > answer: 99.9%).
> > 
> > If we shrink one per call, we've freed all 128 dentries while there
> > is still 1*10^5 dentries on the large list. That seems like a much
> > better balance to make within the constraints of the shrinker
> > resolution we have to work with.
> 
> With the effect that the dcache is completely useless for small filesystems
> as long as there is one big one.

Not necessarily. I think that as long as the small filesystem is not
being used, then we _should_ be reclaiming slowly from it,
regardless of how big the other filesystems are.  That's the way the
global list ends up working now as the dentries for the small
filesystem get purged according to LRU.

> Filesystems where regularily a small amount
> of files is used don't have any cached dentries but the filesystem where
> someone touched every file still has a lot of dentries in cache although they
> are never used again.

Or alternatively small filesystems with no activity and dentries
that will never get used again never get trimmed while the large
fielsytem with lots of activity gets trimmed. This can lead to
thousands of pages being pinned in slabs that we don't try to
free up until we've already free >90% of the overall caches.
That's not very appealing, IMO.

So I suggest the question is this - how do you define "not being
used"? I guess dentry age or "last dentry was added to list at time
X" (recorded in dput()) would be one way of determining this.

Say something like:

dput():
	list_add(&dentry->d_lru, &dentry->d_sb->s_unused);
	dentry->s_sb->s_unused_age = jiffies +
				(&dentry->d_sb->s_dentry_stat.age_limit * HZ);

prune_dcache():

	tmp = sb->s_dentry_stat.nr_unused/((unused/count)+1);
	if ((tmp == 0) && time_after(jiffies, sb->s_unused_age))
		tmp = 1;

That would turn over small unused dentry lists that have not been
modified for age_limit seconds. That means that small caches that
are being used are not reclaimed prematurely, and those small
caches would also be reclaimed after some time if they are not
being used. That seems to address both our concerns.....

Thoughts?

Cheers,

Dave.
-- 
Dave Chinner
R&D Software Enginner
SGI Australian Software Group
