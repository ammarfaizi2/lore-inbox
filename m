Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267542AbUBSUTM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Feb 2004 15:19:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267543AbUBSUTM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Feb 2004 15:19:12 -0500
Received: from fw.osdl.org ([65.172.181.6]:23215 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267542AbUBSUTI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Feb 2004 15:19:08 -0500
Date: Thu, 19 Feb 2004 12:23:53 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: viro@parcelfarce.linux.theplanet.co.uk
cc: Tridge <tridge@samba.org>, Jamie Lokier <jamie@shareable.org>,
       "H. Peter Anvin" <hpa@zytor.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Eureka! (was Re: UTF-8 and case-insensitivity)
In-Reply-To: <20040219200554.GE31035@parcelfarce.linux.theplanet.co.uk>
Message-ID: <Pine.LNX.4.58.0402191217050.1439@ppc970.osdl.org>
References: <16435.60448.70856.791580@samba.org> <Pine.LNX.4.58.0402181457470.18038@home.osdl.org>
 <16435.61622.732939.135127@samba.org> <Pine.LNX.4.58.0402181511420.18038@home.osdl.org>
 <20040219081027.GB4113@mail.shareable.org> <Pine.LNX.4.58.0402190759550.1222@ppc970.osdl.org>
 <20040219163838.GC2308@mail.shareable.org> <Pine.LNX.4.58.0402190853500.1222@ppc970.osdl.org>
 <20040219182948.GA3414@mail.shareable.org> <Pine.LNX.4.58.0402191124080.1270@ppc970.osdl.org>
 <20040219200554.GE31035@parcelfarce.linux.theplanet.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 19 Feb 2004 viro@parcelfarce.linux.theplanet.co.uk wrote:

> On Thu, Feb 19, 2004 at 11:48:50AM -0800, Linus Torvalds wrote:
> > The VFS rule is:
> >  - all new dentries start off with the two magic bits clear
> >  - whenever we shrink a dentry, we clear the two magic bits in the parent
> > 
> > and that is _all_ the VFS layer ever does. Even Al won't find this 
> > obnoxious (yeah, we might clear the bits after a timeout on things that 
> > need re-validation, but that's in the noise).
>  
> > Notice what the above does? After the above loop, bit two will be set IFF 
> > the dentry cache now contains every single name in the directory. 
> > Otherwise it will be clear. Bit two will basically be a "dcache complete" 
> > bit.
> 
> What about dentry getting dropped in the middle of that loop _and_
> another task setting the first bit again before the loop ends?

Hey, you snipped the part where I said that the application has to have 
its own locking around the loop and around the lookup to avoid races. 

We can avoid that requirement by using sequence numbers and making it a
bit more complex, but the simple version was for samba only (ie "only one
app that wants this").

Realize that none of this makes the internal kernel (or filesystem) data
structures be wrong, so even if the app has a bug and doesn't do the right
locking, at worst that just results in problems for that application, not
for the rest of the system.

But yes, if we want to make others use this, we'd need to have the kernel 
actually support some kind of locking, probably by just making the whole 
readdir loop be inside the kernel itself (at which point we can use the 
inode semaphore for this).

The "dcache full" bit could be potentially useful regardless of any
case-ignorant operating system emulation crap, although I don't see any
really obvious applications (we could speed up regular "readdir()", but we
don't have the d_offset thing, so..)

		Linus
