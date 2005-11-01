Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964951AbVKADNP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964951AbVKADNP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 22:13:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964950AbVKADNP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 22:13:15 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:941 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S932561AbVKADNO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 22:13:14 -0500
Date: Mon, 31 Oct 2005 19:12:39 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
To: torvalds@osdl.org
Cc: akpm@osdl.org, Mike Kravetz <kravetz@us.ibm.com>,
       Ray Bryant <raybry@mpdtxmail.amd.com>, linux-kernel@vger.kernel.org,
       Lee Schermerhorn <lee.schermerhorn@hp.com>,
       Dave Hansen <haveblue@us.ibm.com>, Christoph Lameter <clameter@sgi.com>,
       Magnus Damm <magnus.damm@gmail.com>, Paul Jackson <pj@sgi.com>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Message-Id: <20051101031239.12488.76816.sendpatchset@schroedinger.engr.sgi.com>
Subject: [PATCH 0/5] Swap Migration V5: Overview
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a patchset intended to introduce page migration into the kernel
through a simple implementation of swap based page migration.
The aim is to be minimally intrusive in order to have some hopes for inclusion
into 2.6.15. A separate direct page migration patch is being developed that
applies on top of this patch. The direct migration patch is being discussed on
<lhms-devel@lists.sourceforge.net>.

Much of the code is based on code that the memory hotplug project and Ray Bryant
have been working on for a long time. See http://sourceforge.net/projects/lhms/

Changes from V4 to V5:
- Use existing lru_add caches to return pages to the active and inactive lists.
- Some cleanup (const attribute for sys_migrate_pages etc)

Changes from V3 to V4:
- patch against 2.6.14-rc5-mm1.
- Correctly gather pages in migrate_add_page()
- Restructure swapout code for easy later application of the direct migration
  patches. Rename swapout() to migrate_pages().
- Add PF_SWAPWRITE support to allow write to swap from a process. Save
  and restore earlier state to allow nesting of the use of PF_SWAPWRITE.
- Fix sys_migrate_pages permission check (thanks Ray).

Changes from V2 to V3:
- Break out common code for page eviction (Thanks to a patch by Magnus Damm)
- Add check to avoid MPOL_MF_MOVE moving pages that are also accessed from
  another address space. Add support for MPOL_MF_MOVE_ALL to override this
  (requires superuser priviledges).
- Update overview regarding direct page migration patchset following soon and
  cut longwinded explanations.
- Add sys_migrate patchset
- Check cpuset restrictions on sys_migrate.

Changes from V1 to V2:
- Patch against 2.6.14-rc4-mm1
- Remove move_pages() function
- Code cleanup to make it less invasive.
- Fix missing lru_add_drain() invocation from isolate_lru_page()

In a NUMA system it is often beneficial to be able to move the memory
in use by a process to different nodes in order to enhance performance.
Currently Linux simply does not support this facility. This patchset
implements page migration via a new syscall sys_migrate_pages and via
the memory policy layer with the MPOL_MF_MOVE and MPOL_MF_MOVE_ALL
flags.

Page migration is also useful for other purposes:

1. Memory hotplug. Migrating processes off a memory node that is going
   to be disconnected.

2. Remapping of bad pages. These could be detected through soft ECC errors
   and other mechanisms.

migrate_pages() can only migrate pages under certain conditions. These other
uses may require additional measures to ensure that pages are migratable. The
hotplug project f.e. restricts allocations to removable memory.


The patchset consists of five patches:

1. LRU operations

Add basic operations to remove pages from the LRU lists and return
them back to it.

2. PF_WRITESWAP

Allow a process to set PF_WRITESWAP in its flags in order to be allowed
to write pages to swap space.

3. migrate_pages() implementation

Adds a function to mm/vmscan.c called migrate_pages(). The functionality
of that function is restricted to swapping out pages. An additional patch
is necessary for direct page migration.

4. MPOL_MF_MOVE flag for memory policies.

This implements MPOL_MF_MOVE in addition to MPOL_MF_STRICT. MPOL_MF_STRICT
allows the checking if all pages in a memory area obey the memory policies.
MPOL_MF_MOVE will migrate all pages that do not conform to the memory policy.
If pages are evicted then the system will allocate pages conforming to the
policy on swap in.

5. sys_migrate_pages system call and cpuset API

Adds a new function call

sys_migrate_pages(pid, maxnode, from_nodes, to_nodes)

to migrate pages of a process to a different node and also a function
for the use of the migration mechanism in cpusets

do_migrate_pages(struct mm_struct *, from_nodes, to_nodes, move_flags).

=====

URLs referring to the discussion regarding the initial version of these
patches.

Page eviction: http://marc.theaimsgroup.com/?l=linux-mm&m=112922756730989&w=2
Numa policy  : http://marc.theaimsgroup.com/?l=linux-mm&m=112922756724715&w=2

Discussion of V2 of the patchset:
http://marc.theaimsgroup.com/?t=112959680300007&r=1&w=2

Discussion of V3:
http://marc.theaimsgroup.com/?t=112984939600003&r=1&w=2
