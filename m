Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291717AbSCDF3O>; Mon, 4 Mar 2002 00:29:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291729AbSCDF3G>; Mon, 4 Mar 2002 00:29:06 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:16647 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S291717AbSCDF2r>;
	Mon, 4 Mar 2002 00:28:47 -0500
Message-ID: <3C830598.E2FB5E1A@zip.com.au>
Date: Sun, 03 Mar 2002 21:26:48 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Christoph Hellwig <hch@caldera.de>
CC: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] radix-tree pagecache for 2.4.19-pre2-ac2
In-Reply-To: <20020303210346.A8329@caldera.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig wrote:
> 
> I have uploaded an updated version of the radix-tree pagecache patch
> against 2.4.19-pre2-ac2.  News in this release:
> 
> * fix a deadlock when vmtruncate takes i_shared_lock twice by introducing
>   a new mapping->page_lock that mutexes mapping->page_tree. (akpm)
> * move setting of page->flags back out of move_to/from_swap_cache. (akpm)
> * put back lost page state settings in shmem_unuse_inode. (akpm)
> * get rid of remove_page_from_inode_queue - there was only one caller. (me)
> * replace add_page_to_inode_queue with ___add_to_page_cache. (me)
> 
> Please give it some serious beating while I try to get 2.5 working and
> port the patch over 8)

One of my reasons for absorbing ratcache into my current stuff is
just that - to give it a serious beating.  The fact that I found a
hitherto-undiscovered BUG() and a deadlock in the first 30 minutes
just shows what a mean beat I have :)

I haven't yet even looked at lib/rat.c, but based on testing, I
believe radix-tree pagecache is ready for 2.5.   It would be good
if the other Christoph could check over the shmem.c changes.

As far as I know, the sole remaining "issue" is that block_flushpage()
is being called under spinlock.  Well, there's nothing new here.
The kernel is *already* calling block_flushpage() under spinlock
it at least three places.  But it just so happens that there are
never (?) any locked buffers against the page from those call sites.

So I don't see the block_flushpage() thing as a blocker for this
patch - it's just general ickiness which needs sorting out separately.
I looked at block_flushpage() a month or so back.  I ended up 
concluding that we should just create block_flushpage_atomic() and
make it go BUG() if the page has locked buffers.  Then call the atomic
version from under spinlock, and leave it at that.

-
