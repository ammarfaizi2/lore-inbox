Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267556AbUBSU22 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Feb 2004 15:28:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267554AbUBSU22
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Feb 2004 15:28:28 -0500
Received: from fw.osdl.org ([65.172.181.6]:34741 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267556AbUBSU2J (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Feb 2004 15:28:09 -0500
Date: Thu, 19 Feb 2004 12:32:55 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: viro@parcelfarce.linux.theplanet.co.uk
cc: Tridge <tridge@samba.org>, Jamie Lokier <jamie@shareable.org>,
       "H. Peter Anvin" <hpa@zytor.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Eureka! (was Re: UTF-8 and case-insensitivity)
In-Reply-To: <Pine.LNX.4.58.0402191217050.1439@ppc970.osdl.org>
Message-ID: <Pine.LNX.4.58.0402191226240.1439@ppc970.osdl.org>
References: <16435.60448.70856.791580@samba.org> <Pine.LNX.4.58.0402181457470.18038@home.osdl.org>
 <16435.61622.732939.135127@samba.org> <Pine.LNX.4.58.0402181511420.18038@home.osdl.org>
 <20040219081027.GB4113@mail.shareable.org> <Pine.LNX.4.58.0402190759550.1222@ppc970.osdl.org>
 <20040219163838.GC2308@mail.shareable.org> <Pine.LNX.4.58.0402190853500.1222@ppc970.osdl.org>
 <20040219182948.GA3414@mail.shareable.org> <Pine.LNX.4.58.0402191124080.1270@ppc970.osdl.org>
 <20040219200554.GE31035@parcelfarce.linux.theplanet.co.uk>
 <Pine.LNX.4.58.0402191217050.1439@ppc970.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 19 Feb 2004, Linus Torvalds wrote:
> > 
> > What about dentry getting dropped in the middle of that loop _and_
> > another task setting the first bit again before the loop ends?
> 
> Hey, you snipped the part where I said that the application has to have 
> its own locking around the loop and around the lookup to avoid races. 

[ That, btw, implies that we do need to make the "set bit one" a system 
  call of its own, so that somebody elses "lseek(fd, 0, SEEK_SET)" wouldn't 
  mess up. Mea culpa. ]

Anyway, if we're willing to make some other changes to the VFS layer, we 
could make all of this a bit more efficient by _not_ requiring the actual 
filesystem lookup to take place.

If we had a flag that allowed a dentry to not have a d_inode pointer, but
still _not_ be considered automatically negative, then we could just make
a loop that fills the dcache directly from the readdir() data inside the
kernel, without calling down to the filesystem to look up the inode.

That would save a _lot_ of memory - quite often we'd only need the dentry 
itself.

That would require a third bit in the VFS dentry flags (something like
D_DENTRY_LIKELY_POSITIVE), and would require that "d_lookup()" not just 
assume that a dentry without an inode is always negative (check the new 
flag, and if so, do the filesystem lookup when the lookup actually 
happens).

Doesn't look _too_ bad, and considering the potential memory savings (and 
not having to seek around the disk to look up the inode data), it would 
probably be worth thinking about at least as a "second stage".

So then we could have a dcache that is fully populated, even though the
actual inode data hasn't been loaded yet.

Comments?

		Linus
