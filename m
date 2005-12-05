Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964774AbVLETuv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964774AbVLETuv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 14:50:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964777AbVLETuu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 14:50:50 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:44457 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S964774AbVLETuu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 14:50:50 -0500
Date: Mon, 5 Dec 2005 11:50:35 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
To: akpm@osdl.org
Cc: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>,
       lhms-devel@lists.sourceforge.net, Cliff Wickman <cpw@sgi.com>,
       Christoph Lameter <clameter@sgi.com>, linux-kernel@vger.kernel.org
Message-Id: <20051205195035.12388.68933.sendpatchset@schroedinger.engr.sgi.com>
Subject: [PATCH 0/5] Direct Migration V6: Overview
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Direct page migration allows to avoid using swap space for migration.
This patch makes sys_migrate_pages() finally work as intended but does not
do any significant modifications to APIs.

Benefits over swap migration:

1. It makes migrates_pages() actually migrate pages instead of just
   swapping pages from a set of nodes out. migrate_pages() has only
   very limited usefulness without direct migration.

2. Its faster because the page does not need to be written to swap space.

3. It does not use swap space and therefore there is no danger of running
   out of swap space.

4. The need to write back a dirty page before migration is avoided through
   a file system specific method making page migration even faster. We
   fall back to writeout if the filesystem does not have such a method
   defined.

5. Direct migration allows the preservation of the relative location of a page
   within a set of nodes. This means that special placement of pages
   for a performance critical application can be preserved when migrating.
   Swap migration will rearrange the pages as they are swapped in which
   may destroy the prior arrangement.

Many of the ideas for this code were originally developed in the memory
hotplug project and we hope that this code also will allow the hotplug
project to build on this patch in order to get to their goals. We also
would like to be able to move bad memory at SGI. IA64 arch specific code
to handle bad memory exists in 2.6.15 but that code is currently not able
to migrate pages.

The patchset consists of five patches (only the first two are necessary to
have basic direct migration support):

1. SwapCache patch

   SwapCache pages may have changed their type after lock_page() if the
   page was migrated. Check for this and retry lookup if the page is no
   longer a SwapCache page.

2. migrate_pages()

   Basic direct migration with fallback to swap if all other attempts
   fail.

3. remove_from_swap()

   Page migration installs swap ptes for anonymous pages in order to
   preserve the information contained in the page tables. This patch
   removes the swap ptes after migration and replaces them with regular
   ptes.

4. upgrade of MPOL_MF_MOVE and sys_migrate_pages()

   Add logic to mm/mempolicy.c to allow the policy layer to control
   direct page migration. Thanks to Paul Jackson for the interative
   logic to move between sets of nodes.

5. buffer_migrate_pages() patch

   Allow migration without writing back dirty pages. Add filesystem dependent
   migration support for ext2/ext3 and xfs. Use swapper space to setup a
   method to migrate anonymous pages without writeback.

Credits (also in mm/vmscan.c):

The idea for this scheme of page migration was first developed in the context
of the memory hotplug project. The main authors of the migration code from
the memory hotplug project are:

IWAMOTO Toshihiro <iwamoto@valinux.co.jp>
Hirokazu Takahashi <taka@valinux.co.jp>
Dave Hansen <haveblue@us.ibm.com>

Changes V6->V&:
- Patchset agsinst 2.6.15-rc5-mm1
- Fix one occurence of page->mapping in migrate_page_remove_references()
- Update description]

Changes V5->V6:
- Patchset against 2.6.15-rc3-mm1
- Remove checks for page count increases while migrating after Andrew assured
  me that this cannot happen. Revise documentation to reflect that. If this is
  the case then we will have no need to include the unwind code from the
  hotplug project in the future.
- Wrong reference while calling remove_from_swap to page instead of newpage
  fixed.

Changes V4->V5:
- Patchset against 2.6.15-rc2-mm1
- Update policy layer patch to use the generic check_range in 2.6.15-rc2-mm1.
- Remove try_to_unmap patch since VM_RESERVED vanished under us and therefore
  there is no point anymore to distinguish between permament and transitional
  failures.

Changes V3->V4:
- Patchset against 2.6.15-rc1-mm2 + two swap migration fixes posted today.
- Remove what is already in 2.6.14-rc1-mm2 which results in a significant
  cleanup of the code.

Changes V2->V3:
- Patchset against 2.6.14-mm2
- Fix single processor build and builds without CONFIG_MIGRATION
- export symbols for filesystems that are modules and for
  modules using migrate_pages().
- Paul Jackson's cpuset migration support is in 2.6.14-mm2 so
  this patchset can be easily applied to -mm2 to get from swap
  based to direct page migration.

Changes V1->V2:
- Call node_remap with the right parameters in do_migrate_pages().
- Take radix tree lock while examining page count to avoid races with
  find_get_page() and various *_get_pages based on it.
- Convert direct ptes to swap ptes before radix tree update to avoid
  more races.
- Fix problem if CONFIG_MIGRATION is off for buffer_migrate_page
- Add documentation about page migration
- Change migrate_pages() api so that the caller can decide what
  to do about the migrated pages (badmem handling and hotplug
  have to remove those pages for good).
- Drop config patch (already in mm)
- Add try_to_unmap patch
- Patchset now against 2.6.14-mm1 without requiring additional patches.


