Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264995AbUD2XMf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264995AbUD2XMf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Apr 2004 19:12:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265028AbUD2XMf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Apr 2004 19:12:35 -0400
Received: from radius8.csd.net ([204.151.43.208]:11156 "EHLO
	bastille.tuells.org") by vger.kernel.org with ESMTP id S264995AbUD2XMc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Apr 2004 19:12:32 -0400
Date: Thu, 29 Apr 2004 17:12:43 -0600
From: marcus hall <marcus@tuells.org>
To: linux-kernel@vger.kernel.org
Subject: mmap returns incorrect data
Message-ID: <20040429231243.GA8216@bastille.tuells.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a system based on 2.5.59 kernel for arm.  This system was previously
running OK with all filesystems on a stratoflash chip, but I have recently
moved the filesystems to a compact flash chip.  Some filesystems are
cramfs, and some have changed from jffs2 to ext3 along with the move.

I am having trouble with ldconfig not recognizing some files as being valid.
The files that cause the problem are files that are on an ext3 filesystem
on the CF.  Other files on a cramfs filesystem seem to work reliably.
It seems that ldconfig mmap()s the file into its address space, and what
it sees doesn't match what is in the file.  If I pre-read the file before
running ldconfig, so that the contents get into the cache, then ldconfig
proceeds normally.

Working through various layers, I see that the generic_file_mmap() gets
called and sets things up OK, then when ldconfig references the file, the
page fault correctly invokes filemap_nopage(), which calls
page_cache_readaround().  By the time page_cache_readaround() returns,
the page has been added to mapping->page_tree, and the page is added to
ldconfig's address space.

I can see where page_cache_readaround() gets to ext3_readpages() and then
to ext3_get_block() to put the requests (page_cache_readahead() asks for
16 pages) onto the queue, then __do_page_cache_readahead() calls
blk_run_queues() to unplug the queues, but it isn't clear (yet!) where
we wait until the blocks are read in before returning from
page_cache_readaround().

The CF interface has a real delay between starting a request and getting
an interrupt when the card is ready, which the mtd driver I was using before
doesn't do, so I am guessing that this may be the source of my problems.
But it isn't clear why the cramfs files don't suffer from this problem (since
they are also on the CF).

Is there any known issue in this area?  Where should I be focusing my
attention?

Thanks for any suggestions!

Marcus Hall
marcus@tuells.org


