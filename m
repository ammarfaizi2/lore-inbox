Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262359AbSI2AxP>; Sat, 28 Sep 2002 20:53:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262361AbSI2AxP>; Sat, 28 Sep 2002 20:53:15 -0400
Received: from bitchcake.off.net ([216.138.242.5]:25254 "EHLO mail.off.net")
	by vger.kernel.org with ESMTP id <S262359AbSI2AxO>;
	Sat, 28 Sep 2002 20:53:14 -0400
Date: Sat, 28 Sep 2002 20:58:36 -0400
From: Zach Brown <zab@zabbo.net>
To: lkml <linux-kernel@vger.kernel.org>
Cc: linux-mm@kvack.org
Subject: suspect list_empty( {NULL, NULL} )
Message-ID: <20020928205836.C13817@bitchcake.off.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A cute list_head debugging patch seems to have found strange list_entry
use in vmscan.c in stock 2.5.39.

page_mapping_inuse:

	if (!list_empty(&mapping->i_mmap) || !list_empty(&mapping->i_mmap_shared))

is being called for for a mapping in which:

 i_mmap = {next = 0x0, prev = 0x0}, i_mmap_shared = { next = 0x0, prev = 0x0}

this surely can't be intended.. list_empty will fail, but it isn't on
any lists.

I can reproduce this at will by cating a filesystem to /dev/null after
booting.  

too many details:

(gdb) bt
#0  0xc0138603 in shrink_list (page_list=0xc1b2fe94, nr_pages=-9, 
    gfp_mask=464, max_scan=0xc1b2ff0c, nr_mapped=0xc1b2ff44)
    at /var/tmp/zab/kernel/linux-2.5.39/include/linux/list.h:40
#1  0xc0138ff8 in shrink_cache (nr_pages=1, zone=0xc03b7000, gfp_mask=464, 
    max_scan=-31, nr_mapped=0xc1b2ff44) at vmscan.c:382
#2  0xc013a196 in shrink_zone (zone=0xc03b7000, max_scan=2, gfp_mask=464, 
    nr_pages=1, nr_mapped=0xc1b2ff44) at vmscan.c:555
#3  0xc013a20c in shrink_caches (classzone=0xc03b70dc, priority=12, 
    total_scanned=0xc1b2ff70, gfp_mask=464, nr_pages=0) at vmscan.c:593
#4  0xc013a296 in try_to_free_pages (classzone=0xc03b70dc, gfp_mask=464, 
    order=0) at vmscan.c:647
#5  0xc013a38f in kswapd_balance_pgdat (pgdat=0xc03b7000) at vmscan.c:695
#6  0xc013a406 in kswapd_balance () at vmscan.c:719
#7  0xc013a54c in kswapd (unused=0x0) at vmscan.c:810

 ( ftso inlines, damn right. )

(gdb) print *page
$21 = {flags = 9, count = {counter = 2}, list = {next = 0xc03b6f54, 
    prev = 0xc101b448}, mapping = 0xc03b6f40, index = 31, lru = {next = 0x0, 
    prev = 0x0}, pte = {chain = 0x0, direct = 0x0}, private = 0}

(gdb) print *mapping
$22 = {host = 0xc03b6e00, page_tree = {height = 1, gfp_mask = 32, 
    rnode = 0xc0775600}, page_lock = {gcc_is_buggy = 0}, clean_pages = {
    next = 0xc101b448, prev = 0xc100dd48}, dirty_pages = {next = 0xc03b6f5c, 
    prev = 0xc03b6f5c}, locked_pages = {next = 0xc1885e58, prev = 0xc1895790}, 
  io_pages = {next = 0xc03b6f6c, prev = 0xc03b6f6c}, nrpages = 32, 
  a_ops = 0xc03b6da0, i_mmap = {next = 0x0, prev = 0x0}, i_mmap_shared = {
    next = 0x0, prev = 0x0}, i_shared_lock = {gcc_is_buggy = 0}, 
  dirtied_when = 0, gfp_mask = 0, backing_dev_info = 0xc03b6f30, 
  private_lock = {gcc_is_buggy = 0}, private_list = {next = 0xc03b6fa0, 
    prev = 0xc03b6fa0}, assoc_mapping = 0x0}

(gdb) print page->mapping
$24 = (struct address_space *) 0xc03b6f40
(gdb) print &swapper_space
$25 = (struct address_space *) 0xc03b6f40

I am as about as ignorant about the VM as one can be.  I'm happy to
provide more info or act as a kgdb operator if this is actually
something that needs looking into..

- z
