Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030358AbVKHVFv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030358AbVKHVFv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 16:05:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030355AbVKHVFh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 16:05:37 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:10665 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S1030358AbVKHVFa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 16:05:30 -0500
Date: Tue, 8 Nov 2005 13:02:56 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
To: akpm@osdl.org
Cc: Mike Kravetz <kravetz@us.ibm.com>, linux-kernel@vger.kernel.org,
       Dave Hansen <haveblue@us.ibm.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>, linux-mm@kvack.org,
       torvalds@osdl.org, Christoph Lameter <clameter@sgi.com>,
       Hirokazu Takahashi <taka@valinux.co.jp>,
       Magnus Damm <magnus.damm@gmail.com>,
       KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>,
       Paul Jackson <pj@sgi.com>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>, Andi Kleen <ak@suse.de>
Message-Id: <20051108210246.31330.61756.sendpatchset@schroedinger.engr.sgi.com>
Subject: [PATCH 0/8] Direct Migration V2: Overview
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

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
   functionality [The additional cpuset functions are not in Andrew's tree yet].

The patchset consists of eight patches (only the first three are necessary to
have basic direct migration support):

1. Swap migration V5 fixes.

   Some small fixes that may already be in Andrew's tree.

2. SwapCache patch

   SwapCache pages may have changed their type after lock_page().
   Check for this and retry lookup if the page is no longer a SwapCache
   page.

3. migrate_pages()

   Basic direct migration with fallback to swap if all other attempts
   fail.

4. remove_from_swap()

   Page migration installs swap ptes for anonymous pages in order to
   preserve the information contained in the page tables. This patch
   removes the swap ptes and replaces them with real ones after migration.

5. upgrade of MPOL_MF_MOVE and sys_migrate_pages()

   Add logic to mm/mempolicy.c to allow the policy layer to control
   direct page migration. Thanks to Paul Jackson for the interative
   logic to move between sets of nodes.


6. buffer_migrate_pages() patch

   Allow migration without writing back dirty pages. Add filesystem dependent
   migration support for ext2/ext3 and xfs. Use swapper space to define a special
   method to migrate anonymous pages without writeback.

7. add_to_swap with gfp mask

   The default of add_to_swap is to use GFP_ATOMIC for necessary allocations.
   This may cause out of memory situations during page migration. This patch
   adds an additional parameter to add_to_swap to allow GFP_KERNEL allocations.

8. try_unmap patch

   Allows to distinguish between permanent failure conditions and transient
   conditions that may go away after a retry.

Credits (also in mm/vsmscan.c):

The idea for this scheme of page migration was first developed in the context
of the memory hotplug project. The main authors of the migration code from
the memory hotplug project are:

IWAMOTO Toshihiro <iwamoto@valinux.co.jp>
Hirokazu Takahashi <taka@valinux.co.jp>
Dave Hansen <haveblue@us.ibm.com>

