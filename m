Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136673AbRAJVrx>; Wed, 10 Jan 2001 16:47:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135711AbRAJVre>; Wed, 10 Jan 2001 16:47:34 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:58892 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S129610AbRAJVrS>; Wed, 10 Jan 2001 16:47:18 -0500
Date: Wed, 10 Jan 2001 17:56:09 -0200 (BRST)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Chris Mason <mason@suse.com>
cc: linux-kernel@vger.kernel.org
Subject: Possible deadlock with ->writepaged version of flush_dirty_buffers()
 and 2.4.0
Message-ID: <Pine.LNX.4.21.0101101742500.8441-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Chris,

It seems there is a possible deadlock condition with your patch which
changes flush_dirty_buffers() to use ->writepage (something which we
_definately_ want for 2.5). Take a look:


mark_buffer_dirty->balance_dirty->wakeup_bdflush->flush_dirty_buffers->
writepage->block_write_full_page->__block_write_full_page->get_block->
ext2_get_block->ext2_alloc_branch->

	ext2_alloc_block->ext2_new_block->lock_super
	or 
	getblk()->lock_super


I dont see any reason why this deadlock could'nt happen in practice now.

If I'm right, it will pretty nasty to fix this. One possible solution is
to _never_ call mark_buffer_dirty() with the superblock lock held (ext2
has a lot of places likes this right now)

Comments? 


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
