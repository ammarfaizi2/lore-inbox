Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262854AbTCSBAv>; Tue, 18 Mar 2003 20:00:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262856AbTCSBAv>; Tue, 18 Mar 2003 20:00:51 -0500
Received: from taka.swcp.com ([198.59.115.12]:63496 "EHLO taka.swcp.com")
	by vger.kernel.org with ESMTP id <S262854AbTCSBAu>;
	Tue, 18 Mar 2003 20:00:50 -0500
Date: Tue, 18 Mar 2003 18:11:17 -0700
From: Trammell Hudson <hudson@osresearch.net>
To: linux-kernel@vger.kernel.org
Subject: initramfs fails for medium sized cpio archives
Message-ID: <20030319011116.GK8263@osbox.osresearch.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[ Please cc me on any replies.  Thanks! ]

I'm trying to get 2.5.64 to load my initramfs cpio archive and
have run into a problem with memory allocation during the
unpacking.

It seems that page_writeback_init() does not get called before
populate_root(), so total_pages in mm/page-writeback.c is still
zero rather than being initialized to nr_free_pagecache_pages().

The symptom is that after about 300 kb of files, balance_dirty_pages()
is called.  This then calls get_dirty_limits() that computes

	unmapped_ratio = 100 - (ps->nr_mapped * 100) / total_pages;

I've added a sanity check in get_dirty_limits() that initialized
total_pages if it is still zero and things seem to work, but
should some of the memory management modules be initialized first?

The kernel is booting on an Athlon and compiled with gcc 3.2.2.
The cpio archive is uClibc based and is about 600 k in size.
I created it with the following command:

	find . \
		| cpio -H crc -ov \
		| gzip
		> ../linux-2.5.64/usr/initramfs_data.cpio.gz

Trammell
-- 
  -----|----- hudson@osresearch.net                   W 240-283-1700
*>=====[]L\   hudson@rotomotion.com                   M 505-463-1896
'     -'-`-   http://www.swcp.com/~hudson/                    KC5RNF

