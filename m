Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267565AbUBSUpZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Feb 2004 15:45:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267568AbUBSUpY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Feb 2004 15:45:24 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:12185 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S267565AbUBSUpQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Feb 2004 15:45:16 -0500
Date: Thu, 19 Feb 2004 20:45:15 +0000
From: viro@parcelfarce.linux.theplanet.co.uk
To: Linus Torvalds <torvalds@osdl.org>
Cc: Tridge <tridge@samba.org>, Jamie Lokier <jamie@shareable.org>,
       "H. Peter Anvin" <hpa@zytor.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Eureka! (was Re: UTF-8 and case-insensitivity)
Message-ID: <20040219204515.GG31035@parcelfarce.linux.theplanet.co.uk>
References: <Pine.LNX.4.58.0402181511420.18038@home.osdl.org> <20040219081027.GB4113@mail.shareable.org> <Pine.LNX.4.58.0402190759550.1222@ppc970.osdl.org> <20040219163838.GC2308@mail.shareable.org> <Pine.LNX.4.58.0402190853500.1222@ppc970.osdl.org> <20040219182948.GA3414@mail.shareable.org> <Pine.LNX.4.58.0402191124080.1270@ppc970.osdl.org> <20040219200554.GE31035@parcelfarce.linux.theplanet.co.uk> <Pine.LNX.4.58.0402191217050.1439@ppc970.osdl.org> <Pine.LNX.4.58.0402191226240.1439@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0402191226240.1439@ppc970.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 19, 2004 at 12:32:55PM -0800, Linus Torvalds wrote:
> Anyway, if we're willing to make some other changes to the VFS layer, we 
> could make all of this a bit more efficient by _not_ requiring the actual 
> filesystem lookup to take place.
> 
> If we had a flag that allowed a dentry to not have a d_inode pointer, but
> still _not_ be considered automatically negative, then we could just make
> a loop that fills the dcache directly from the readdir() data inside the
> kernel, without calling down to the filesystem to look up the inode.
> 
> That would save a _lot_ of memory - quite often we'd only need the dentry 
> itself.

> So then we could have a dcache that is fully populated, even though the
> actual inode data hasn't been loaded yet.
> 
> Comments?

*Ugh*

	That will cause all sorts of nastiness for filesystems that _have_
case-insensitive lookups.  Remember the crap we had to deal with to avoid
multiple dentries for directory?  It will come back, AFAICS.

	Another thing I really don't like is that we now get real lookups
on hashed dentry.  That potentially changes a lot and can lead to very
interesting results for some filesystems.
