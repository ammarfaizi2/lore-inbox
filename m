Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313928AbSDJXdO>; Wed, 10 Apr 2002 19:33:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313929AbSDJXdN>; Wed, 10 Apr 2002 19:33:13 -0400
Received: from vasquez.zip.com.au ([203.12.97.41]:14863 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S313928AbSDJXdM>; Wed, 10 Apr 2002 19:33:12 -0400
Message-ID: <3CB4BD2F.B711556D@zip.com.au>
Date: Wed, 10 Apr 2002 15:31:11 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Anton Altaparmakov <aia21@cam.ac.uk>
CC: Jan Harkes <jaharkes@cs.cmu.edu>, linux-kernel@vger.kernel.org
Subject: Re: [prepatch] address_space-based writeback
In-Reply-To: <3CB4B248.2807558D@zip.com.au> <5.1.0.14.2.20020410235415.03d41d00@pop.cus.cam.ac.uk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anton Altaparmakov wrote:
> 
> At 22:44 10/04/02, Andrew Morton wrote:
> >When a page is marked dirty, the path which is followed
> >is page->mapping->host->i_sb.  So in this case the page will
> >be attached to its page->mapping.dirty_pages, and
> >page->mapping->host will be attached to page->mapping->host->i_sb.s_dirty
> >
> >This is as it always was - I didn't change any of this.
> 
> Um, NTFS uses address spaces for things where ->host is not an inode at all
> so doing host->i_sb will give you god knows what but certainly not a super
> block!

But it's a `struct inode *' :(

What happens when someone runs set_page_dirty against one of
the address_space's pages?  I guess that doesn't happen, because
it would explode.  Do these address_spaces not support writable
mappings?

I like to think in terms of "top down" and "bottom up".

set_page_dirty is the core "bottom up" function which propagates
dirtiness information from the bottom of the superblock/inode/page
tree up to the top.

writeback is top-down.  It goes from the superblock list down
to pages.

The assumption about page->mapping->host being an inode
only occurs in the bottom-up path, at set_page_dirty().

> As long as your patches don't break that is possible to have I am happy...
> But from what you are saying above I have a bad feeling you are somehow
> assuming that a mapping's host is an inode...

Well the default implementation of __set_page_dirty() will
make that assumption.  (It always has).

But the address_space may implement its own a_ops->set_page_dirty(page),
so you can do whatever you need to do there, yes?

I currently have:

static inline int set_page_dirty(struct page *page)
{
        if (page->mapping) {
                int (*spd)(struct page *, int reserve_page);

                spd = page->mapping->a_ops->set_page_dirty;
                if (spd)
                        return (*spd)(page, 1);
        }
        return __set_page_dirty_buffers(page, 1);
}

Where __set_page_dirty_buffers() will dirty the buffers if
they exist.  And non-buffer_head-backed filesystems which
use page->private MUST implement set_page_dirty().

The reserve_page stuff is for delayed-allocate, the priority
and timing of which has been pushed waaay back by this.  I'm
keeping the reserve_page infrastructure around at present
because of vague thoughts that it may be useful to fix the
data-loss bug which occurs when a shared mapping of a sparse
file has insufficient disk space to satisfy new page instantiations.
Dunno yet.

(Sometime I need to go through and spell out all the new a_ops
methods in all the filesystems, and take out the fall-through-
to-default-handler stuff here, and in do_flushpage() and
try_to_release_page() and others.  But not now).


-
