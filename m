Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932226AbWE3KGf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932226AbWE3KGf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 06:06:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932208AbWE3KGf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 06:06:35 -0400
Received: from cantor.suse.de ([195.135.220.2]:17385 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932197AbWE3KGe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 06:06:34 -0400
Date: Tue, 30 May 2006 12:06:33 +0200
From: Jan Blunck <jblunck@suse.de>
To: David Chinner <dgc@sgi.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       viro@zeniv.linux.org.uk
Subject: Re: [patch 5/5] vfs: per superblock dentry unused list
Message-ID: <20060530100633.GH21024@hasse.suse.de>
References: <20060526110655.197949000@suse.de>> <20060526110803.159085000@suse.de> <20060529030834.GU8069029@melbourne.sgi.com> <20060529115443.GG21024@hasse.suse.de> <20060530000443.GB8069029@melbourne.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060530000443.GB8069029@melbourne.sgi.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 30, David Chinner wrote:

> You've just described the embodiment of the two order's of magnitude
> issue I mentioned. That's not a wrong assumption - think of the
> above case with global_unused count now being 1.28*10^7 instead of
> 1.28x10^4. How many dentries do you have to free before freeing any
> on the small superblock if we don't free one per call? (quick
> answer: 99.9%).
> 
> If we shrink one per call, we've freed all 128 dentries while there
> is still 1*10^5 dentries on the large list. That seems like a much
> better balance to make within the constraints of the shrinker
> resolution we have to work with.

With the effect that the dcache is completely useless for small filesystems
as long as there is one big one. Filesystems where regularily a small amount
of files is used don't have any cached dentries but the filesystem where
someone touched every file still has a lot of dentries in cache although they
are never used again.

> Hmm - need to do something with that age_limit field, right? That
> would imply we need a timestamp in the dentry as well, and we don't
> shrink any sb that doesn't have dentries older than the age limit.
> If we scan all the sb's and still have more to free, then we halve
> the age limit and scan again....

This probably is the way to go.

> > No. prune_dcache() is working on the unused list in the opposite (reverse)
> > direction. shrink_dcache_sb() (basically my prune_dcache_sb()) is shrinking
> > all unused dentries. In that case it is better to visit the unused list in the
> > normal (forward) direction (~only one pass).
> 
> Why? Forward or reverse it's only one traversal to free all dentries
> - you go till the list is empty. Either way, with the prefetch of
> the next entry in the list there's little perfomrance difference
> once you've got outside some tiny subset of the list that might be
> hot in cache....

Ooops, I was still thinking of the global-unused-list here.
