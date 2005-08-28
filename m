Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750758AbVH1Tnf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750758AbVH1Tnf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Aug 2005 15:43:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750761AbVH1Tnf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Aug 2005 15:43:35 -0400
Received: from stat16.steeleye.com ([209.192.50.48]:4749 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S1750758AbVH1Tne (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Aug 2005 15:43:34 -0400
Subject: Re: [PATCH] make radix tree gang lookup faster by using a bitmap
	search
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20050827105355.360bd26a.akpm@osdl.org>
References: <1125159996.5159.8.camel@mulgrave>
	 <20050827105355.360bd26a.akpm@osdl.org>
Content-Type: text/plain
Date: Sun, 28 Aug 2005 14:43:20 -0500
Message-Id: <1125258200.5048.18.camel@mulgrave>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-6) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-08-27 at 10:53 -0700, Andrew Morton wrote:
> I'd say the main naivety in gang lookup is the awkward top-level iteration
> algorithm.  The way it bales out all the way to the top level of the tree
> once __lookup() hits the end of the slots[] array, even though results[]
> isn't full yet.  It's surely possible to go back up the tree just a
> sufficient distance to resume the iteration, rather than all the way to the
> top.  But it's hard, and it's all in CPU cache anyway there.
> 
> It would be much simpler if it was using recursion, of course.

I agree; I actually checked this point: most page gang lookups do have
to restart the search.  At least using a bitmap gets it back on point
much faster.  The page radix tree lookups are usually at most four
levels deep, anyway.

> >  This patch replaces
> > the integer count with an unsigned long representing the bitmap of
> > occupied elements.  We then use that bitmap to find the first occupied
> > entry instead of looping over all the entries from the beginning of the
> > radix node.
> 
> But only in __lookup().  I think most gang lookups use
> radix_tree_gang_lookup_tag() -> __lookup_tag().
> 
> And __lookup_tag() could use find_next_bit() on the tags anyway, as the
> comment says.  I spent a bit of time doing that, had some bug, shelved it,
> never got on to fixing it up.
> 
> There's a userspace test/devel setup at
> http://www.zip.com.au/~akpm/linux/patches/stuff/rtth.tar.gz, btw.

OK ... I'll take a look.  I didn't mean to do this, it's just that for
the idr replacement code I had to use bitmap lookup, so this seemed like
a natural precursor.

> > The penalty of doing this is that on 32 bit machines, the size of the
> > radix tree array is reduced from 64 to 32 (so an unsigned long can
> > represent the bitmap).
> 
> If we did the bitmap lookup in __lookup_tag() we wouldn't have this
> restriction.
> 
> Maybe we can
> 
> a) fix radix_tree_gang_lookup() to use find_next_bit()

Well, not quite; with the size changes, the tag map now never overflows
an unsigned long.

> b) remove radix_tree_node.count

yes, did that.

> c) Add a new tag field which simply means "present"

> d) remove radix_tree_gang_lookup() and __lookup() altogether

> e) Implement radix_tree_gang_lookup() via radix_tree_gang_lookup_tag()
> 
> That would involve setting and clearing bit in the "present" tag field when
> adding and removing items.

OK, I see how to do all of this using the currently implemented logic
(the occupied word is what you would like to be the present tag).  I'll
see what I can do.

> > I also exported radix_tree_preload() so modules can make use of radix
> > trees.
> 
> uh, OK.  Note that radix_tree_preload() uses prempt_disable() protection. 
> So it has the limitation that the guarantee which it provides will become
> unreliable, kernel-wide, if anyone anywhere tries to do a
> radix_tree_insert() from interrupt context.

radix_tree_insert() is reliable from IRQ provided you don't try to use
radix_tree_preload() and you defined your radix tree gfp flag to be
GFP_ATOMIC.  preloading is only optional, and should only be done really
if you have process context to preload with GFP_KERNEL.  Preloading with
GFP_ATOMIC is pretty pointless since radix_tree_insert() will also try
to allocate with the radix tree flags.

James


