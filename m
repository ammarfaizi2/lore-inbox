Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131546AbQLVCnm>; Thu, 21 Dec 2000 21:43:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131612AbQLVCnc>; Thu, 21 Dec 2000 21:43:32 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:37644 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S131546AbQLVCnS>; Thu, 21 Dec 2000 21:43:18 -0500
Date: Thu, 21 Dec 2000 22:19:20 -0200 (BRST)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Chris Mason <mason@suse.com>
cc: "Stephen C. Tweedie" <sct@redhat.com>, Alexander Viro <viro@math.psu.edu>,
        Linus Torvalds <torvalds@transmeta.com>,
        Russell Cattelan <cattelan@thebarn.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] changes to buffer.c (was Test12 ll_rw_block error)
In-Reply-To: <86820000.977441131@coffee>
Message-ID: <Pine.LNX.4.21.0012212133380.2533-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 21 Dec 2000, Chris Mason wrote:

> Ok guys, I think I've taken Linus' suggestion to have buffer.c use its
> own writepage a bit too far.  This patch marks pages dirty when the 
> buffer head is marked dirty, and changes flush_dirty_buffers and 
> sync_buffers to use writepage instead of ll_rw_block.  The idea is 
> to allow filesystems to use the buffer lists and provide their own 
> i/o mechanism.
> 
> The result is a serious semantics change for writepage, which now is 
> expected to do partial page writes when the page isn't up to date and 
> there are dirty buffers inside.  For all the obvious reasons, this isn't 
> fit for 2.4.0, and if you all feel it is a 2.5. thing I'll send along 
> the  shorter  patch Linus originally suggested.  But, I think it would 
> be  pretty useful for the new filesystems (once I also fix 
> fsync_inode_buffers and sync_page_buffers).

It is very powerful.

With this on place, the filesystem is able to do write clustering at its
writepage() function by checking if the on-disk physically nearby pages
are dirty.
  
> Other changes:  submit_bh now cleans the buffers.  I don't see how 
> they were getting cleaned before, it must have been try_to_free_buffers 
> sending the page through sync_page_buffers, meaning they were probably 
> getting written twice.  Unless someone throws a clue my way, I'll send 
> this out as a separate diff.

Ouch.

> page_launder doesn't fiddle with the buffermem_pages counter, it is done 
> in try_to_free_buffers instead.
>
> Obvious bug, block_write_full_page zeros out the bits past the end of 
> file every time.  This should not be needed for normal file writes.
> 
> Most testing was on ext2, who actually calls mark_buffer_dirty, and 
> supports blocksizes < intel page size.  More tests are running 
> overnight.

It seems your code has a problem with bh flush time.

In flush_dirty_buffers(), a buffer may (if being called from kupdate) only
be written in case its old enough. (bh->b_flushtime)

If the flush happens for an anonymous buffer, you'll end up writing all
buffers which are sitting on the same page (with block_write_anon_page),
but these other buffers are not necessarily old enough to be flushed.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
