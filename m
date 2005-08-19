Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932747AbVHSXMw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932747AbVHSXMw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Aug 2005 19:12:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932749AbVHSXMu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Aug 2005 19:12:50 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:20903 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S932746AbVHSXMp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Aug 2005 19:12:45 -0400
Date: Sat, 20 Aug 2005 00:15:42 +0100
From: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Anton Altaparmakov <aia21@cam.ac.uk>, vandrove@vc.cvut.cz,
       Andrew Morton <akpm@osdl.org>, linware@sh.cvut.cz,
       fsdevel <linux-fsdevel@vger.kernel.org>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: Kernel bug: Bad page state: related to generic symlink code and mmap
Message-ID: <20050819231542.GJ29811@parcelfarce.linux.theplanet.co.uk>
References: <1124450088.2294.31.camel@imp.csi.cam.ac.uk> <20050819142025.GA29811@parcelfarce.linux.theplanet.co.uk> <1124466246.2294.65.camel@imp.csi.cam.ac.uk> <Pine.LNX.4.58.0508190855350.3412@g5.osdl.org> <Pine.LNX.4.58.0508190913570.3412@g5.osdl.org> <Pine.LNX.4.58.0508190934470.3412@g5.osdl.org> <Pine.LNX.4.60.0508192144590.7312@hermes-1.csi.cam.ac.uk> <Pine.LNX.4.58.0508191352540.3412@g5.osdl.org> <Pine.LNX.4.60.0508192220440.7312@hermes-1.csi.cam.ac.uk> <Pine.LNX.4.58.0508191502050.3412@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0508191502050.3412@g5.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 19, 2005 at 03:04:52PM -0700, Linus Torvalds wrote:
> 
> 
> On Fri, 19 Aug 2005, Anton Altaparmakov wrote:
> > 
> > Yes, sure.  I have applied your patch to our 2.6.11.4 tree (with the one 
> > liner change I emailed you just now) and have kicked off a compile.
> 
> Actually, hold on. The original patch had another problem: it returned an
> uninitialized "page" pointer when page_getlink() failed.
> 
> This one should have that fixed, and has converted a few other 
> filesystems. Most of them trivially, but I took the opportunity to just 
> simplify NFS while I was at it, since it now has no reason to need to save 
> off the "struct page *" any more.
> 
> It's still not tested, but at least I've looked at it a bit more ;)

That looks OK except for
	* jffs2 is b0rken (see patch in another mail)
	* afs, autofs4, befs, devfs, freevxfs, jffs2, jfs, ncpfs, procfs,
smbfs, sysvfs, ufs, xfs - prototype change for ->follow_link()
	* befs, smbfs, xfs - same for ->put_link()
	* ncpfs fix is actually missing here

Prototype changes are covered by patch below (incremental on top of your +
jffs2 fix upthread).  No ncpfs changes - these will go separately, assuming
you haven't done them yet; just a plain janitor stuff.
