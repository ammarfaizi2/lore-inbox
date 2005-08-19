Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965080AbVHSTfp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965080AbVHSTfp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Aug 2005 15:35:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965069AbVHSTfp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Aug 2005 15:35:45 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:34948 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S965057AbVHSTfo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Aug 2005 15:35:44 -0400
Date: Fri, 19 Aug 2005 20:38:34 +0100
From: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
To: Christoph Hellwig <hch@infradead.org>, Linus Torvalds <torvalds@osdl.org>,
       Anton Altaparmakov <aia21@cam.ac.uk>, vandrove@vc.cvut.cz,
       Andrew Morton <akpm@osdl.org>, linware@sh.cvut.cz,
       fsdevel <linux-fsdevel@vger.kernel.org>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: Kernel bug: Bad page state: related to generic symlink code and mmap
Message-ID: <20050819193834.GF29811@parcelfarce.linux.theplanet.co.uk>
References: <1124450088.2294.31.camel@imp.csi.cam.ac.uk> <20050819142025.GA29811@parcelfarce.linux.theplanet.co.uk> <1124466246.2294.65.camel@imp.csi.cam.ac.uk> <Pine.LNX.4.58.0508190855350.3412@g5.osdl.org> <Pine.LNX.4.58.0508190913570.3412@g5.osdl.org> <Pine.LNX.4.58.0508190934470.3412@g5.osdl.org> <20050819165332.GD29811@parcelfarce.linux.theplanet.co.uk> <20050819180218.GE29811@parcelfarce.linux.theplanet.co.uk> <20050819180037.GA5686@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050819180037.GA5686@infradead.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 19, 2005 at 07:00:38PM +0100, Christoph Hellwig wrote:
> On Fri, Aug 19, 2005 at 07:02:18PM +0100, Al Viro wrote:
> > On Fri, Aug 19, 2005 at 05:53:32PM +0100, Al Viro wrote:
> > > I'm taking NFS helpers to libfs.c and switching ncpfs to them.  IMO that's
> > > better than copying the damn thing and other network filesystems might have
> > > the same needs eventually...
> > 
> > [something like this - completely untested]
> > 
> > * stray_page_get_link(inode, filler) - returns ERR_PTR(error) or pointer
> > to symlink body.  Said symlink body sits in a page at offset equal to
> > offsetof(page, struct stray_page_link).  filler() is expected to put it
> > at such offset. Page is cached.
> > 
> > * stray_page_put_link() - ->put_link() suitable for links obtained from
> > stray_page_get_link().  Unlike the usual pagecache-based variants, this
> > sucker does _not_ rely on page staying cached.
> > 
> > * nfs and ncpfs switched to the helpers above.
> 
> Can you add some kerneldoc comments to describe them?  Especially as
> the name is not very descriptive.

Hey, if anybody has suggestions on names - they are very welcome ;-)

FWIW, I'd rather take page_symlink(), page_symlink_inode_operations,
page_put_link(), page_follow_link_light(), page_readlink(), page_getlink(),
generic_readlink() and vfs_readlink() to the same place where these guys
would live.  They all belong together and none of them has any business
in fs/namei.c.  Options: fs/libfs.c or separate library since fs/libfs.c
is getting crowded.  Linus, do you have any objections to that or suggestions
on filename here?
