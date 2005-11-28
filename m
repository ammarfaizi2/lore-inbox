Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932260AbVK1UoR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932260AbVK1UoR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Nov 2005 15:44:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932248AbVK1UoE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Nov 2005 15:44:04 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:6873 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S932243AbVK1Unm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Nov 2005 15:43:42 -0500
Date: Mon, 28 Nov 2005 12:42:44 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
To: akpm@osdl.org
Cc: lhms-devel@lists.sourceforge.net, Cliff Wickman <cpw@sgi.com>,
       Christoph Lameter <clameter@sgi.com>, linux-kernel@vger.kernel.org
Message-Id: <20051128204244.10037.43868.sendpatchset@schroedinger.engr.sgi.com>
Subject: [PATCH 0/7] Direct Migration V5: Overview
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

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

Note that the page migration here is different from the one of the memory
hotplug project. Pages are migrated in order to improve performance.
A best effort is made to migrate all pages that are in use by user space
and that are swappable. If a couple of pages are not moved then the
performance of a process will not increase as much as wanted but the
application will continue to function properly.

Much of the ideas for this code were originally developed in the memory
hotplug project and we hope that this code also will allow the hotplug
project to build on this patch in order to get to their goals. We also
would like to be able to move bad memory at SGI which is likely something
that will also be based on this patchset.

I am very thankful for the support of the hotplug developers for bringing
this patchset about. The migration of kernel pages, slab pages and
other unswappable pages that is also needed by the hotplug project
and for the remapping of bad memory is likely to require a significant
amount of additional changes to the Linux kernel beyond the scope of
this page migration endeavor.

Page migration can be triggered via:

A. Specifying MPOL_MF_MOVE(_ALL) when setting a new policy
   for a range of addresses of a process.

B. Calling sys_migrate_pages() to control the location of the pages of
   another process. Pages may migrate back through swapping if memory
   policies, cpuset nodes and the node on which the process is executing
   are not changed by other means.
   sys_migrate_pages() may be particularly useful to move the pages of
   a process if the scheduler has shifted the execution of a process
   to a different node.

C. Changing the cpuset of a task (moving tasks to another cpuset or modifying
   its set of allowed nodes) if a special option is set in the cpuset. The
   cpuset code will call into the page migration layer in order to move the
   process to its new environment. This is the preferred and easiest method
   to use page migration. Thanks to Paul Jackson for realizing this
   functionality.

The patchset consists of seven patches (only the first four are necessary to
have basic direct migration support):

1. Fix double unlock page
   The cleanup patches introduced a bug. Fix that

2. Consolidate successful migration handling.
   Code to handle successful migration occurred two times.

3. SwapCache patch

   SwapCache pages may have changed their type after lock_page().
   Check for this and retry lookup if the page is no longer a SwapCache
   page.

4. migrate_pages()

   Basic direct migration with fallback to swap if all other attempts
   fail.

5. remove_from_swap()

   Page migration installs swap ptes for anonymous pages in order to
   preserve the information contained in the page tables. This patch
   removes the swap ptes and replaces them with real ones after migration.

6. upgrade of MPOL_MF_MOVE and sys_migrate_pages()

   Add logic to mm/mempolicy.c to allow the policy layer to control
   direct page migration. Thanks to Paul Jackson for the interative
   logic to move between sets of nodes.


7. buffer_migrate_pages() patch

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

