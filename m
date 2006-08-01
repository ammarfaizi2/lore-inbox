Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161028AbWHAOy3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161028AbWHAOy3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 10:54:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161024AbWHAOy3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 10:54:29 -0400
Received: from smtp.osdl.org ([65.172.181.4]:28891 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161028AbWHAOy2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 10:54:28 -0400
Date: Tue, 1 Aug 2006 07:54:22 -0700
From: Andrew Morton <akpm@osdl.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: vda.linux@googlemail.com, reiser@namesys.com, linux-kernel@vger.kernel.org
Subject: Re: reiser4: maybe just fix bugs?
Message-Id: <20060801075422.25304f69.akpm@osdl.org>
In-Reply-To: <44CF4063.9070003@yahoo.com.au>
References: <1158166a0607310226m5e134307o8c6bedd1f883479c@mail.gmail.com>
	<20060801013104.f7557fb1.akpm@osdl.org>
	<44CF4063.9070003@yahoo.com.au>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 01 Aug 2006 21:52:03 +1000
Nick Piggin <nickpiggin@yahoo.com.au> wrote:

> Andrew Morton wrote:
> > On Mon, 31 Jul 2006 10:26:55 +0100
> > "Denis Vlasenko" <vda.linux@googlemail.com> wrote:
> > 
> > 
> >>The reiser4 thread seem to be longer than usual.
> > 
> > 
> > Meanwhile here's poor old me trying to find another four hours to finish
> > reviewing the thing.
> > 
> > The writeout code is ugly, although that's largely due to a mismatch between
> > what reiser4 wants to do and what the VFS/MM expects it to do.  If it
> > works, we can live with it, although perhaps the VFS could be made smarter.
> > 
> > I'd say that resier4's major problem is the lack of xattrs, acls and
> > direct-io.  That's likely to significantly limit its vendor uptake.  (As
> > might the copyright assignment thing, but is that a kernel.org concern?)
> > 
> > The plugins appear to be wildly misnamed - they're just an internal
> > abstraction layer which permits later feature additions to be added in a
> > clean and safe manner.  Certainly not worth all this fuss.
> > 
> > Could I suggest that further technical critiques of reiser4 include a
> > file-and-line reference?  That should ease the load on vger.
> 
> I haven't really reviewed it, but when I grepped through it last, I
> found a few alarming things, like use of __put_page, trying to remove
> pages from pagecache (duplicating parts of vmscan.c, plus bugs), and
> taking tree_lock.

__put_page() has gone.

A lot of the VM duplication has gone.

tree_lock is still there a bit.  For two reasons:

a) A presently-unneeded duplication of the generic
   __set_page_dirty_nobuffers() and

b) Manipulation of the fake inode (I think).

   iirc the base problem here is that for whatever reason, the usual
   blockdev inode which filesystems use for metadata (ie: the pagecache
   which backs sb_bread(), etc) isn't suitable.  reiser4 wants to get a
   hold of its address_space ops, so it needs to create its own
   covers-all-the-partition, identify-mapped address_space.

> Mostly didn't look like big problems to fix, but should be fixed for
> mm/ maintainers' sanity. Maybe it's better now, though.

It's better.  More reviewing help is always appreciated ;)
