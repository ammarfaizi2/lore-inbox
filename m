Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265804AbTGIIbY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jul 2003 04:31:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265802AbTGIIbY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jul 2003 04:31:24 -0400
Received: from thebsh.namesys.com ([212.16.7.65]:50602 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP id S265804AbTGIIbF
	(ORCPT <rfc822;Linux-Kernel@Vger.Kernel.ORG>);
	Wed, 9 Jul 2003 04:31:05 -0400
From: Nikita Danilov <Nikita@Namesys.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16139.54835.839915.197750@laputa.namesys.com>
Date: Wed, 9 Jul 2003 12:45:39 +0400
To: Linux Kernel Mailing List <Linux-Kernel@Vger.Kernel.ORG>
Subject: [PATCH] 0/5 VM changes
X-Mailer: ed | telnet under Fuzzball OS, emulated on Emacs 21.5  (beta14) "cassava" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

a set of patches applicable to http://linux.bkbits.net/linux-2.5
modifying VM (mostly vmscan.c) is available at

http://www.namesys.com/patches/vm2.5/

----------------------------------------------------------------------
zone-pressure.patch

Add zone->pressure field. It estimates scanning intensity for this zone and
is calculated as exponentially decaying average of the scanning priority
required to free enough pages in this zone (mm/vmscan.c:zone_adj_pressure()).

zone->pressure is supposed to be used in stead of scanning priority by
vmscan.c. This is used by later patches in a series.

----------------------------------------------------------------------
skip-writepage.patch

Don't call ->writepage from VM scanner when page is met for the first time
during scan.

New page flag PG_skipped is used for this. This flag is TestSet-ed just
before calling ->writepage and is cleaned when page enters inactive
list.

One can see this as "second chance" algorithm for the dirty pages on the
inactive list.

BSD does the same: src/sys/vm/vm_pageout.c:vm_pageout_scan(),
PG_WINATCFLS flag.

Reason behind this is that ->writepages() will perform more efficient writeout
than ->writepage(). Skipping of page can be conditioned on zone->pressure.

On the other hand, avoiding ->writepage() increases amount of scanning
performed by kswapd.

----------------------------------------------------------------------
dont-rotate-active-list.patch

Currently, if zone is short on free pages, refill_inactive_zone() starts
moving pages from active_list to inactive_list, rotating active_list as it
goes. That is, pages from the tail of active_list are transferred to its head,
thus destroying lru ordering, exactly when we need it most --- when system is
low on free memory and page replacement has to be performed.

This patch modifies refill_inactive_zone() so that it scans active_list
without rotating it. To achieve this, special dummy page zone->scan_page
is maintained for each zone. This page marks a place in the active_list
reached during scanning.

As an additional bonus, if memory pressure is not so big as to start swapping
mapped pages (reclaim_mapped == 0 in refill_inactive_zone()), then not
referenced mapped pages can be left behind zone->scan_page instead of moving
them to the head of active_list. When reclaim_mapped mode is activated,
zone->scan_page is reset back to the tail of active_list so that these pages
can be re-scanned.

----------------------------------------------------------------------
zoneinfo.patch

Add /proc/zoneinfo file to display information about memory zones.
----------------------------------------------------------------------
reclaim_mapped-pressure.patch

Use zone->pressure (rathar than scanning priority) to determine when to start
reclaiming mapped pages in refill_inactive_zone(). When using priority every
call to try_to_free_pages() starts with scanning parts of active list and
skipping mapped pages (because reclaim_mapped evaluates to 0 on low
priorities) no matter how high memory pressure is.

----------------------------------------------------------------------
Benchmarking:

simple test was used that first copies 400M of data from ext2 to ramfs
and then replicates these data from ramfs 10 times onto new ext2 file
system. Test was ran 7 times and last 6 results averaged:

Without patchset:

                          REAL   SYST  USER
ext2->ram   time          98.143 4.651 0.527
            std. dev.      0.932 0.094 0.019

ram->ext2   time         236.680 42.234 5.386
            std. dev.      7.977  1.076 0.101


With all patches applied:

                          REAL   SYST  USER
ext2->ram   time          98.203 4.696 0.536
            std. dev.      1.274 0.039 0.025

ram->ext2   time         156.618 50.926 5.498
            std. dev.      4.994  0.487 0.087

Most of the effect (decrease of the elapsed time) is from skip-writepage
patch. It also significantly increases amount of CPU consumed by kswapd.

http://www.namesys.com/patches/vm2.5/ also contains
seeks.{patched,vanilla}.ps seek graphs, obtained by crudely inserting
printk into submit_bio(). If they show anything it is that vanilla
kernel seeks a lot from ->writepage() path.

Nikita.
