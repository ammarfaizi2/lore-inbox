Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261894AbVBDBzp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261894AbVBDBzp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Feb 2005 20:55:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261882AbVBDBzn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Feb 2005 20:55:43 -0500
Received: from agminet02.oracle.com ([141.146.126.229]:49612 "EHLO
	agminet02.oracle.com") by vger.kernel.org with ESMTP
	id S263344AbVBDBwn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Feb 2005 20:52:43 -0500
Message-ID: <4202D55E.5030900@oracle.com>
Date: Thu, 03 Feb 2005 17:52:30 -0800
From: Zach Brown <zach.brown@oracle.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: [Patch] invalidate range of pages after direct IO write
References: <20050129011906.29569.18736.24335@volauvent.pdx.zabbo.net> <20050203161927.0090655c.akpm@osdl.org>
In-Reply-To: <20050203161927.0090655c.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

> Note that the same optimisation should be made in the call to
> unmap_mapping_range() in generic_file_direct_IO().  Currently we try and
> unmap the whole file, even if we're only writing a single byte.  Given that
> you're now calculating iov_length() in there we might as well use that
> number a few lines further up in that function.

Indeed.  I can throw that together.  I also have a patch that introduces
 filemap_write_and_wait_range() and calls it from the read bit of
__blockdev_direct_IO().  It didn't change the cheesy fsx load I was
using and then I got distracted.  I can try harder.

> Reading the code, I'm unable to convince myself that it won't go into an
> infinite loop if it finds a page at page->index = -1.  But I didn't try
> very hard ;)

I'm unconvinced as well. I got the pattern from
truncate_inode_pages_range() and it seems to have a related problem when
end is something that page_index can never be greater than.  It just
starts over.

I wonder if we should add some mapping_for_each_range() (less ridiculous
names welcome :)) macro that handles this crap for the caller who just
works with page pointers.  We could introduce some iterator struct that
the caller would put on the stack and pass in to hold state, something
like the 'n' in list_for_each_safe().  It looks like a few
pagevec_lookup() callers could use this.

> Minor note on this:
> 
> 	return invalidate_inode_pages2_range(mapping, 0, ~0UL);
> 
> I just use `-1' there.

Roger.  I was just mimicking invalidate_inode_pages().

> I'll make that change and plop the patch into -mm, but we need to think
> about the infinite-loop problem..

I can try hacking together that macro and auditing pagevec_lookup()
callers..

- z
