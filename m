Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282843AbSAaTeX>; Thu, 31 Jan 2002 14:34:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284264AbSAaTeD>; Thu, 31 Jan 2002 14:34:03 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:37642 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S282843AbSAaTdx>;
	Thu, 31 Jan 2002 14:33:53 -0500
Message-ID: <3C599A6B.98724FD1@zip.com.au>
Date: Thu, 31 Jan 2002 11:26:37 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.18-pre7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Rik van Riel <riel@conectiva.com.br>, Andrea Arcangeli <andrea@suse.de>,
        Momchil Velikov <velco@fadata.bg>, John Stoffel <stoffel@casc.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Radix-tree pagecache for 2.5
In-Reply-To: <Pine.LNX.4.33L.0201311635290.32634-100000@imladris.surriel.com> <Pine.LNX.4.33.0201311047200.1682-100000@penguin.transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On Thu, 31 Jan 2002, Rik van Riel wrote:
> >
> > It's still a question whether we'll want to use 128 as
> > the branch factor or another number ... but I'm sure
> > somebody will figure that out (and it can be changed
> > later, it's just one define).
> 
> Actually, I think the big question is whether somebody is willing to clean
> up and fix the "move_from_swap_cache()" issue with block_flushpage.
> 

It appears that move_from_swap_cache() is in good company:

1: shmem_unuse_inode() calls delete_from_swap_cache under
   spinlock, but delete_from_swap_cache() calls block_flushpage(),
   which can sleep.

2: shmem_getpage_locked() calls delete_from_swap_cache() calls
   block_flushpage() under info->lock.

3: zap_pte_range holds mm->page_table_lock, and calls
   free_swap_and_cache() calls delete_from_swap_cache() calls
   block_flushpage().


block_flushpage() can only sleep in the lock_buffer() in
discard_buffer().   It so happens that all three callers
are always using block_flushpage() against a locked
swapcache page, and (correct me if I'm wrong), it's
not possible for those buffers to be locked.

So we got lucky.

A short-term fix is to put a BIG FAT COMMENT over block_flushpage.

-
