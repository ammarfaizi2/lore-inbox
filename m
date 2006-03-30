Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751118AbWC3Iv1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751118AbWC3Iv1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 03:51:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751197AbWC3Iv1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 03:51:27 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:14930 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1751118AbWC3Iv1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 03:51:27 -0500
Date: Thu, 30 Mar 2006 10:51:34 +0200
From: Jens Axboe <axboe@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: [PATCH][RFC] splice support
Message-ID: <20060330085134.GP13476@suse.de>
References: <20060329122841.GC8186@suse.de> <20060329143758.607c1ccc.akpm@osdl.org> <20060330074534.GL13476@suse.de> <20060330000240.156f4933.akpm@osdl.org> <20060330081008.GO13476@suse.de> <20060330002726.48cf0ffb.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060330002726.48cf0ffb.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 30 2006, Andrew Morton wrote:
> Jens Axboe <axboe@suse.de> wrote:
> >
> > > find_get_pages() does "find me the next N pages above `index' which are
> >  > presently in pagecache'.  So it can return an array of page*'s which do not
> >  > represent contiguous pages in the file - there can be holes in there.
> >  > 
> >  > IOW: pages[n]->index !necessarily= pages[n+1]->index-1
> >  > 
> >  > Maybe the code handles that by making sure that all the pages in the range
> >  > are already in pagecache - I didn't check.  But that would take some heroic
> >  > locking.
> > 
> >  It doesn't, I'm assuming that find_get_pages() returns consequtive pages
> >  atm. Would seem like the sane interface :-)
> 
> Yeah, sorry.  It's a "gather what's presently there" thing.  For writeback.
> 
> Nick has some gang-lookup-slots code.  So instead of populating an array of
> page*'s you can populate an array of (effectively) page**'s.  Then one
> could walk that.   All while holding ->tree_lock.    This doesn't help ;)
> 
> Or you could walk the pages[] array until you hit an ->index which doesn't
> match and then toss the rest away.  That's a bit of extra work, but in the
> common case all the pages will be good.  Perhaps.
> 
> >  We continue doing find_or_create_page() on the remaining, but using 'i'
> >  as the 'index' addition. So if we had non-conseq pages, we'd be screwed.
> 
> Yup.
> 
> Probably the simplest for now is an open-coded find_get_page() loop.  Later
> on we should optimise that into a find_get_contig_pages() which only takes
> tree_lock a single time.
> 
> Doing it with a new radix_tree_gang_lookup_contig_name_me_longer() would be
> relatively straightforward too.  It would bale out as soon as it hit a
> not-present slot.

I'll go for the simple approach right now, going over the returned
find_get_pages() array and moving pages around and filling holes doesn't
sound too alluring. Thanks!

-- 
Jens Axboe

