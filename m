Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313918AbSDJWql>; Wed, 10 Apr 2002 18:46:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313919AbSDJWqk>; Wed, 10 Apr 2002 18:46:40 -0400
Received: from vasquez.zip.com.au ([203.12.97.41]:65290 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S313918AbSDJWqj>; Wed, 10 Apr 2002 18:46:39 -0400
Message-ID: <3CB4B248.2807558D@zip.com.au>
Date: Wed, 10 Apr 2002 14:44:40 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Jan Harkes <jaharkes@cs.cmu.edu>
CC: linux-kernel@vger.kernel.org
Subject: Re: [prepatch] address_space-based writeback
In-Reply-To: <3CB4203D.C3BE7298@zip.com.au> <Pine.GSO.4.21.0204100725410.15110-100000@weyl.math.psu.edu> <3CB48F8A.DF534834@zip.com.au> <20020410221211.GA6076@ravel.coda.cs.cmu.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Harkes wrote:
> 
> On Wed, Apr 10, 2002 at 12:16:26PM -0700, Andrew Morton wrote:
> > I believe that the object relationship you're describing is
> > that the inode->i_mapping points to the main address_space,
> > and the `host' field of both the main and private address_spaces
> > both point at the same inode?  That the inode owns two
> > address_spaces?
> 
> Actually with Coda we've got 2 inodes that have an identical i_mapping.
> The Coda inode's i_mapping is set to point to the hosting inode's
> i_data.

I see.  So this is all your fault :)

> ...
> 
> But Coda has 2 inodes, which one are you connecting to whose superblock.
> My guess is that it would be correct to add inode->i_mapping->host to
> inode->i_mapping->host->i_sb, which will be the underlying inode in
> Coda's case, but host isn't guaranteed to be an inode, it just happens
> to be an inode in all existing situations.

When a page is marked dirty, the path which is followed
is page->mapping->host->i_sb.  So in this case the page will
be attached to its page->mapping.dirty_pages, and
page->mapping->host will be attached to page->mapping->host->i_sb.s_dirty

This is as it always was - I didn't change any of this.

> > > What's more, I wonder how well does your scheme work with ->i_mapping
> > > to a different inode's ->i_data (CODA et.al., file access to block devices).
> >
> > Presumably, those different inodes have a superblock?  In that
> > case set_page_dirty will mark that inode dirty wrt its own
> > superblock.  set_page_dirty() is currently an optional a_op,
> > but it's not obvious that there will be a need for that.
> 
> Coda's inodes don't have to get dirtied because we never write them out,
> although the associated dirty pages do need to hit the disk eventually :)
> 

Right.  Presumably, the pages hit the disk via the hosting inode's
filesystem's mechanics.

And it remains the case that Coda inodes will not be marked DIRTY_PAGES
because set_page_dirty()'s page->mapping->host walk will arrive at
the hosting inode.

-
