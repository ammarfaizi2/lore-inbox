Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131455AbRAYQst>; Thu, 25 Jan 2001 11:48:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132264AbRAYQsj>; Thu, 25 Jan 2001 11:48:39 -0500
Received: from zeus.kernel.org ([209.10.41.242]:10947 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S131455AbRAYQsa>;
	Thu, 25 Jan 2001 11:48:30 -0500
Date: Thu, 25 Jan 2001 16:44:32 +0000
From: "Stephen C. Tweedie" <sct@redhat.com>
To: V Ganesh <ganesh@veritas.com>
Cc: linux-kernel@vger.kernel.org, marcelo@conectiva.com.br, sct@redhat.com
Subject: Re: inode->i_dirty_buffers redundant ?
Message-ID: <20010125164432.A12984@redhat.com>
In-Reply-To: <200101251047.QAA16434@vxindia.veritas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200101251047.QAA16434@vxindia.veritas.com>; from ganesh@veritas.com on Thu, Jan 25, 2001 at 04:17:30PM +0530
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Jan 25, 2001 at 04:17:30PM +0530, V Ganesh wrote:

> so i_dirty_buffers contains buffer_heads of pages coming from write() as
> well as metadata buffers from mark_buffer_dirty_inode(). a dirty MAP_SHARED
> page which has been write()n to will potentially exist in both lists.
> won't doing a set_dirty_page() instead of buffer_insert_inode_queue() in
> __block_commit_write() make things much simpler ? then we'd have i_dirty_buffers
> having _only_ metadata, and all data pages in the i_mapping->*_pages lists.

That would only complicate things: it would mean we'd have to scan
both lists on fsync instead of just the one, for example.  There are a
number of places where we need buffer lists for dirty data anyway,
such as for bdflush's background sync to disk.  We also maintain the
per-page buffer lists as caches of the virtual-to-physical mapping to
avoid redundant bmap()ping.  So, removing the buffer_heads which alias
the page cache data isn't an option.  Given that, it's as well to keep
all the inode's dirty buffers in the one place.

Cheers,
 Stephen
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
