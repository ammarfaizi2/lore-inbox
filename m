Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267357AbUBSVWQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Feb 2004 16:22:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267321AbUBSVV5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Feb 2004 16:21:57 -0500
Received: from fw.osdl.org ([65.172.181.6]:20189 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267256AbUBSVVo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Feb 2004 16:21:44 -0500
Date: Thu, 19 Feb 2004 13:26:30 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: viro@parcelfarce.linux.theplanet.co.uk
cc: Tridge <tridge@samba.org>, Jamie Lokier <jamie@shareable.org>,
       "H. Peter Anvin" <hpa@zytor.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Eureka! (was Re: UTF-8 and case-insensitivity)
In-Reply-To: <20040219204515.GG31035@parcelfarce.linux.theplanet.co.uk>
Message-ID: <Pine.LNX.4.58.0402191255540.1439@ppc970.osdl.org>
References: <Pine.LNX.4.58.0402181511420.18038@home.osdl.org>
 <20040219081027.GB4113@mail.shareable.org> <Pine.LNX.4.58.0402190759550.1222@ppc970.osdl.org>
 <20040219163838.GC2308@mail.shareable.org> <Pine.LNX.4.58.0402190853500.1222@ppc970.osdl.org>
 <20040219182948.GA3414@mail.shareable.org> <Pine.LNX.4.58.0402191124080.1270@ppc970.osdl.org>
 <20040219200554.GE31035@parcelfarce.linux.theplanet.co.uk>
 <Pine.LNX.4.58.0402191217050.1439@ppc970.osdl.org>
 <Pine.LNX.4.58.0402191226240.1439@ppc970.osdl.org>
 <20040219204515.GG31035@parcelfarce.linux.theplanet.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 19 Feb 2004 viro@parcelfarce.linux.theplanet.co.uk wrote:
> 
> > So then we could have a dcache that is fully populated, even though the
> > actual inode data hasn't been loaded yet.
> > 
> > Comments?
> 
> *Ugh*
> 
> 	That will cause all sorts of nastiness for filesystems that _have_
> case-insensitive lookups.  Remember the crap we had to deal with to avoid
> multiple dentries for directory?  It will come back, AFAICS.


No no. Look at how this works:
 - only one dentry actually exists. It is marked "tentative", which means 
   that nobody will use it as-such without doing a lookup on it. It has 
   zero impact on aliases etc, because it's really just a place-holder: it
   doesn't point to any inodes at all, it only says "there may or may not
   be a file here"

   NOTE! This dentry is in no way case-insensitive. It happens to have 
   _exactly_ the contents (and hash) that the readdir entry had, but it
   has no meaning outside of that.

 - each caller of "__d_lookup()" will have to check if it's a tentative 
   dentry and basically ignore it if so.

   There aren't that many of them, and I think it all comes together in
   "do_lookup()", which may be the _only_ place that actually cares right
   now. Look at how that works right now:

		dentry = __d_lookup(..);
		if (!dentry)
			goto needs_lookup;	/* This case will allocate a whole 
					new dentry and use that for lookup */

		/* NEW CASE! */
		if (dentry->d_flags & D_TENTATIVE)
			goto needs_lookup_with_this_dentry;
	done:
		path->mnt = mnt;
		path->dentry = dentry;
		return 0;

	/*
	 * NEW CASE!!
	 *
	 * Unhash the tentative one, and look up a real one.
	 */
	needs_lookup_with_this_dentry:
		d_drop(dentry);
		dentry = NULL;

	/* OLD REGULAR CASE */
	needs_lookup:
		...

In other words, neither the low-level filesystem NOR anything else really 
ever sees the tentative dentry (the above is the really stupid approach: a 
slightly more clever one will avoid the "real_lookup()" alloc_dentry() 
thing and just use the tentative dentry after having unhashed it and 
verified that it's the only user).

See? Nobody actually ever sees the "raw dentry". They all go through 
__d_lookup(), and the rule would be:

 - if "d_lookup()" sees a tentative dentry, it will just unhash it and 
   drop it (it has the dcache lock, so it can do that)
 - all callers of "__d_lookup()" will have to check for D_TENTATIVE, and 
   decide what to do with it. I think there are exactly _three_ callers, 
   and one of them is d_lookup() itself.

See? Very very minimal impact that I can see (really, the biggest part
would be to do the dentry re-use in the better version of "do_lookup()" -
that would mean some re-organization, but maybe that optimization isn't
even worth it).

Or did I miss anything?

		Linus
