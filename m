Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965045AbWFIUcp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965045AbWFIUcp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 16:32:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965036AbWFIUcp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 16:32:45 -0400
Received: from mx1.redhat.com ([66.187.233.31]:25257 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932264AbWFIUcn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 16:32:43 -0400
Subject: Re: [Ext2-devel] [RFC 0/13] extents and 48bit ext3
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Jeff Garzik <jeff@garzik.org>
Cc: Andreas Dilger <adilger@clusterfs.com>, Andrew Morton <akpm@osdl.org>,
       "ext2-devel@lists.sourceforge.net" <ext2-devel@lists.sourceforge.net>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, Mingming Cao <cmm@us.ibm.com>,
       linux-fsdevel@vger.kernel.org, Stephen Tweedie <sct@redhat.com>
In-Reply-To: <44898EE3.6080903@garzik.org>
References: <1149816055.4066.60.camel@dyn9047017069.beaverton.ibm.com>
	 <4488E1A4.20305@garzik.org> <20060609083523.GQ5964@schatzie.adilger.int>
	 <44898EE3.6080903@garzik.org>
Content-Type: text/plain
Date: Fri, 09 Jun 2006 21:32:15 +0100
Message-Id: <1149885135.5776.100.camel@sisko.sctweedie.blueyonder.co.uk>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-27) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 2006-06-09 at 11:08 -0400, Jeff Garzik wrote:

> Stuffing more and more features into fs/ext3 means you are following the 
> path that leads to reiser4...  where EVERYTHING under the hood is 
> mutable, all within fs/ext3.

> Why do you insist upon calling the end result ext3, when the truth is 
> that you are slowing rewriting ext3?

The trouble is, does it make sense to do otherwise?

Should large file support have resulted in ext4?  ACLs/xattrs, ext5?
Htree, ext6?  Online resize, ext7?  Yes, let's make it ext8 for extents!

> Here's a key question for ext3 developers, which I bet has no answer: 
> when is it enough?

When is the Linux syscall interface enough?  When should we just bump it
and cut out all the compatibility interfaces?

No, we don't; we let people configure certain obsolete bits out (a.out
support etc), but we keep it in the tree despite the indirection cost to
maintain multiple interfaces etc.

> > While this is partly true, one of the big benefits is that you can
> > transparently upgrade your system to use the new features and improve
> > performance without a long outage window.  Having a completely separate
> 
> Changing the name to ext4 doesn't erase this capability.

The name is irrelevant here.  FWIW, something we've considered is to
make the user visibility of a batch of new features more obvious by
labelling them "ext4", so "mke4fs" would automatically enable those
features and the filesystem could register "ext4" as an fs type in the
kernel.

But that could be done without forking the codebase.  It would just be a
matter of binding feature flag sets to the given name.  What you're
talking about is forking the codebase itself, and I don't see the need
for that right now.

> > ext4 filesystem doesn't improve the compatibility story at all.  There
> > has been renewed discussion on implementing "mounting ext3 without a
> > journal", just for a recovery mode, because ext2 will not be modified
> > to get all of these features (running e2fsck on a huge filesystem each
> > reboot would be insane).
> 
> So now you are going backwards, and implementing ext2-within-ext3?

No, it would be a readonly emergency mode, not writable ext2 at all.

> Are you ready to admit, yet, that ext3 is 100% mutable in the minds of 
> ext3 developers?

The kernel syscall interface is 100% mutable by the same criteria.
Except in each case it's not "mutable", it's "extensible", which is a
*far* different thing.

> If all the ext3 developers are on board, that just implies that there is 
> no clear definition of what "ext3" really means.  With this patch 
> series, and with future plans described here and elsewhere, the name 
> "ext3" will become more and more meaningless.

Does the continuing addition of futexes, inotify, $FAVOURITE_FEATURE_OF_
THE_DAY mean that "Linux" is more and more meaningless?  I fail to see
much difference.  An application coded for linux-2.0's public interfaces
will, for the most part, if we do our jobs right, continue to work on
2.6.  An application coded for 2.6, expecting to use AIO, large files,
futexes and NPTL, will definitely not run on 2.0.  The incremental
extension of ext3 doesn't seem to be a fundamentally different concept.

Backwards compatibility of the kernel ABI is considered important; so in
ext3, the developers have a high regard for backwards compatibility of
on-disk data.  Personally I see that as an asset, not a problem; indeed,
it was the single most important design criterion from the outset.

--Stephen


