Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264232AbTDJXGh (for <rfc822;willy@w.ods.org>); Thu, 10 Apr 2003 19:06:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264233AbTDJXGh (for <rfc822;linux-kernel-outgoing>);
	Thu, 10 Apr 2003 19:06:37 -0400
Received: from [12.47.58.73] ([12.47.58.73]:59472 "EHLO pao-ex01.pao.digeo.com")
	by vger.kernel.org with ESMTP id S264232AbTDJXGg (for <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Apr 2003 19:06:36 -0400
Date: Thu, 10 Apr 2003 16:18:26 -0700
From: Andrew Morton <akpm@digeo.com>
To: Thomas Schlichter <schlicht@uni-mannheim.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] first try for swap prefetch
Message-Id: <20030410161826.04332890.akpm@digeo.com>
In-Reply-To: <200304101948.12423.schlicht@uni-mannheim.de>
References: <200304101948.12423.schlicht@uni-mannheim.de>
X-Mailer: Sylpheed version 0.8.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 10 Apr 2003 23:18:13.0908 (UTC) FILETIME=[75BAF540:01C2FFB7]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Schlichter <schlicht@uni-mannheim.de> wrote:
>
> Hi,
> 
> as mentioned a few days ago I was going to try to implement a swap prefetch to 
> better utilize the free memory. Now here is my first try.

That's surprisingly cute.  Does it actually do anything noticeable?

+	swapped_entry = kmalloc(sizeof(*swapped_entry), GFP_ATOMIC);

These guys will need a slab cache (not SLAB_HW_CACHE_ALIGNED) to save space.

+	swapped_entry = radix_tree_lookup(&swapped_root.tree, entry.val);
+	if(swapped_entry) {
+		list_del(&swapped_entry->list);
+		radix_tree_delete(&swapped_root.tree, entry.val);

you can just do

	if (radix_tree_delete(...) != -ENOENT)
		list_del(...)

+		read_swap_cache_async(entry);

What you want here is a way of telling if the disk(s) which back the swap are
idle.  We used to have that, but Hugh deleted it.  It can be put back, but
it's probably better to put a `last_read_request_time' and
`last_write_request_time' into struct backing_dev_info.  If nobody has used
the disk in the past N milliseconds, then start the speculative swapin.

It might make sense to poke the speculative swapin code in the page-freeing
path too.

And to put the speculatively-swapped-in pages at the tail of the inactive
list (perhaps).

But first-up, some demonstrated goodness is needed...

