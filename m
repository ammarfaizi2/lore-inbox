Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266689AbUJAVrk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266689AbUJAVrk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Oct 2004 17:47:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266560AbUJAVPc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Oct 2004 17:15:32 -0400
Received: from fw.osdl.org ([65.172.181.6]:43186 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266674AbUJAUzf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Oct 2004 16:55:35 -0400
Date: Fri, 1 Oct 2004 13:59:27 -0700
From: Andrew Morton <akpm@osdl.org>
To: Hugh Dickins <hugh@veritas.com>
Cc: pbadari@us.ibm.com, linux-kernel@vger.kernel.org,
       Chris Mason <mason@suse.com>
Subject: Re: 2.6.9-rc2-mm4 ps hang ?
Message-Id: <20041001135927.11527420.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.44.0410012102510.9068-100000@localhost.localdomain>
References: <20041001120926.4d6f58d5.akpm@osdl.org>
	<Pine.LNX.4.44.0410012102510.9068-100000@localhost.localdomain>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hugh Dickins <hugh@veritas.com> wrote:
>
> lock_page inside mmap_sem a ranking bug?  Please recant!

generic_file_buffered_write() can take mmap_sem for reading while holding a
page lock.  In that rare case where the page gets unmapped even though we
manually faulted it in.

Now, that's lock_page->down_read versus down_read->lock_page which I
_think_ is safe, due to down_read semantics.  Even if a third thread is
waiting for a down_write.

Except filemap_nopage() does lock_page too, so we have

	lock_page->down_read->lock_page

as well.

All this does mean that down_write cannot nest either inside or outside
lock_page.

The bigger problem is ext3 and reiser3 transaction start/stop.  It is
equivalent to a down()/up() operation and we get the ranking for that
inconsistent too.  Both wrt lock_page and wrt, I think, down_read(mmap_sem).

generic_file_buffered_write() does, effectively

	lock_page
	->transaction_start
          ->fault
	  ->down_read(mmap_sem)
	    ->lock_page

and over in do_mmap_pgoff() we nest transaction start inside
down_write(mmap_sem):

	do_mmap_pgoff
	->down_write(mmap_sem)
	->generic_file_mmap
	  ->file_accessed
	    ->mark_inode_dirty
	      ->transaction start

It's all a bit of a mess.  Chris Mason and I have discussed it on and off. 
I think Chris has a workload which actually does trigger a deadlock.

Maybe dropping and retaking mmap_sem in generic_file_mmap would be a
sufficient stopgap.
