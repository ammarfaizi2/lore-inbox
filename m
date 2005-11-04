Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751115AbVKDXix@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751115AbVKDXix (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Nov 2005 18:38:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751141AbVKDXiS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Nov 2005 18:38:18 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:40631 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S1751115AbVKDXhs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Nov 2005 18:37:48 -0500
Date: Fri, 4 Nov 2005 15:37:12 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
To: akpm@osdl.org
Cc: Hugh Dickins <hugh@veritas.com>, Mike Kravetz <kravetz@us.ibm.com>,
       linux-kernel@vger.kernel.org, Dave Hansen <haveblue@us.ibm.com>,
       linux-mm@kvack.org, torvalds@osdl.org,
       Christoph Lameter <clameter@sgi.com>,
       Hirokazu Takahashi <taka@valinux.co.jp>,
       Magnus Damm <magnus.damm@gmail.com>, Paul Jackson <pj@sgi.com>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Message-Id: <20051104233712.5459.94627.sendpatchset@schroedinger.engr.sgi.com>
Subject: [PATCH 0/7] Direct Migration V1: Overview
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Direct Page Migration

This patchset applies on top of the swap based page migration patchset
V5 and implements direct page migration.

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

Requirements to apply this patch:
- 2.6.14-rc5-mm1
- swap migration patchset V5
- Paul Jackson's newest cpuset patches.

The patchset consists of seven patches (only the first three are necessary to
have basic direct migration support):

1. CONFIG_MIGRATION patch

   Make page migration configurable and insures that the page migration code
   is not included in a simple memory configurations.

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

Credits (also in mm/vsmscan.c):

The idea for this scheme of page migration was first developed in the context
of the memory hotplug project. The main authors of the migration code from
the memory hotplug project are:

IWAMOTO Toshihiro <iwamoto@valinux.co.jp>
Hirokazu Takahashi <taka@valinux.co.jp>
Dave Hansen <haveblue@us.ibm.com>

