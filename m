Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129927AbRAKPnp>; Thu, 11 Jan 2001 10:43:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130006AbRAKPnf>; Thu, 11 Jan 2001 10:43:35 -0500
Received: from roc-24-95-203-215.rochester.rr.com ([24.95.203.215]:44038 "EHLO
	d185fcbd7.rochester.rr.com") by vger.kernel.org with ESMTP
	id <S129927AbRAKPnZ>; Thu, 11 Jan 2001 10:43:25 -0500
Date: Thu, 11 Jan 2001 10:43:04 -0500
From: Chris Mason <mason@suse.com>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
cc: linux-kernel@vger.kernel.org
Subject: Re: Possible deadlock with ->writepaged version of
 flush_dirty_buffers() and 2.4.0
Message-ID: <517420000.979227784@tiny>
In-Reply-To: <Pine.LNX.4.21.0101101742500.8441-100000@freak.distro.conectiva>
X-Mailer: Mulberry/2.0.6b1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wednesday, January 10, 2001 05:56:09 PM -0200 Marcelo Tosatti
<marcelo@conectiva.com.br> wrote:

> 
> Hi Chris,
> 
> It seems there is a possible deadlock condition with your patch which
> changes flush_dirty_buffers() to use ->writepage (something which we
> _definately_ want for 2.5). Take a look:
> 
Yes, good catch.

> 
> mark_buffer_dirty->balance_dirty->wakeup_bdflush->flush_dirty_buffers->
> writepage->block_write_full_page->__block_write_full_page->get_block->
> ext2_get_block->ext2_alloc_branch->
> 
>	 ext2_alloc_block->ext2_new_block->lock_super
>	 or 
>	 getblk()->lock_super
> 
> 
> I dont see any reason why this deadlock could'nt happen in practice now.
> 
It won't happen until someone other than fs/buffer.c starts marking ext2
pages dirty.  The normal file write path will make sure that any dirty
buffers are mapped, so the ext2_get_block code is never run.

> If I'm right, it will pretty nasty to fix this. One possible solution is
> to _never_ call mark_buffer_dirty() with the superblock lock held (ext2
> has a lot of places likes this right now)
> 

This is probably the best solution, since it is a good idea regardless of
my patch.

-chris
 


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
