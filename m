Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265344AbUFXOsj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265344AbUFXOsj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jun 2004 10:48:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265348AbUFXOsh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jun 2004 10:48:37 -0400
Received: from [66.199.228.3] ([66.199.228.3]:54534 "EHLO xdr.com")
	by vger.kernel.org with ESMTP id S265344AbUFXOsW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jun 2004 10:48:22 -0400
Date: Thu, 24 Jun 2004 07:48:20 -0700
From: David Ashley <dash@xdr.com>
Message-Id: <200406241448.i5OEmK60025648@xdr.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Cached memory never gets released
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Doug McNaught wrote:

>Have you tried a kernel that's less than 8 months old? 2.4.26 is current.

Not so easy, we've got some custom modules and the kernel is modified a
little to suit our needs (not related to buffer caches though).

It seems the problem is *not* brought on by the kernel killing XFree86
like I had posted before. Just normal use of the system seems to cause the
Cached value in /proc/meminfo to go up, and it seems it can't go back down
as needed when memory runs low.

What would be helpful is any advice as to where to look in the kernel source
to try and track this down. I followed the path:
fs/proc/proc_misc.c handles /proc/meminfo, the cached value is based on
  page_cache_size
mm/swap.c is what changes page_cache_size in delta_nr_cache_pages() function
linux/swap.h has macros dec_nr_cache_pages inc_nr_cache_pages which call this
mm/filemap.c is the only place that calls dec_nr_cache_pages in function
  remove_page_from_hash_queue
mm/filemap.c function __remove_inode_page and remove_inode_page call that
mm/filemap.c function invalidate_inode_pages and truncate_complete_page
  call those
mm/filemap.c invalide_this_page2 and truncate_list_pages call
  truncate_complete_page
invalidate_inode_pages is called all over the place...

So we're snowballing but I don't know what mechanism is supposed to actually
free the cached pages when the system is low on memory. Any advice would
be welcome.

Thanks--
Dave
