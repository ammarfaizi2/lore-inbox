Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129444AbRAYKti>; Thu, 25 Jan 2001 05:49:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129511AbRAYKt2>; Thu, 25 Jan 2001 05:49:28 -0500
Received: from bacchus.veritas.com ([204.177.156.37]:28622 "EHLO
	bacchus-int.veritas.com") by vger.kernel.org with ESMTP
	id <S129444AbRAYKtL>; Thu, 25 Jan 2001 05:49:11 -0500
Date: Thu, 25 Jan 2001 16:17:30 +0530 (IST)
From: V Ganesh <ganesh@veritas.com>
Message-Id: <200101251047.QAA16434@vxindia.veritas.com>
To: linux-kernel@vger.kernel.org, marcelo@conectiva.com.br, sct@redhat.com
Subject: Re: inode->i_dirty_buffers redundant ?
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen C. Tweedie <sct@redhat.com> wrote:
: Hi,

: On Wed, Jan 24, 2001 at 03:25:16PM +0530, V Ganesh wrote:
:> now that we have inode->i_mapping->dirty_pages, what do we need
:> inode->i_dirty_buffers for ?

: Metadata.  Specifically, directory contents and indirection blocks.

: --Stephen

ah, mark_buffer_dirty_inode(). thanks.
so if I understand it,
1. read() and mmap read faults will put the page in i_mapping->clean_pages
2. mmaped writes will (eventually, from msync or unmap or swapout) put the
   page in i_mapping->dirty_pages
3. write() will put pages into i_dirty_buffers (__block_commit_write() calls
   buffer_insert_inode_queue()).

so i_dirty_buffers contains buffer_heads of pages coming from write() as
well as metadata buffers from mark_buffer_dirty_inode(). a dirty MAP_SHARED
page which has been write()n to will potentially exist in both lists.
won't doing a set_dirty_page() instead of buffer_insert_inode_queue() in
__block_commit_write() make things much simpler ? then we'd have i_dirty_buffers
having _only_ metadata, and all data pages in the i_mapping->*_pages lists.

ganesh
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
