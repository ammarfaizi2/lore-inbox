Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932545AbVJTW7w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932545AbVJTW7w (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Oct 2005 18:59:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932546AbVJTW7w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Oct 2005 18:59:52 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:22410 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S932545AbVJTW7w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Oct 2005 18:59:52 -0400
Date: Thu, 20 Oct 2005 15:59:35 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: akpm@osdl.org
Cc: Mike Kravetz <kravetz@us.ibm.com>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org, Christoph Lameter <clameter@sgi.com>,
       Magnus Damm <magnus.damm@gmail.com>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Message-Id: <20051020225935.19761.57434.sendpatchset@schroedinger.engr.sgi.com>
Subject: [PATCH 0/4] Swap migration V3: Overview
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

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

This patchset realizes swap based page migration. Another patchset will
follow soon (done by Mike Kravetz and me based on the hotplug direct page
migration code, draft exists) that implements direct page migration on top
of the framework established by the swap based page migration patchset.

The advantage of page based swapping is that the necessary changes to the kernel
are minimal. With a fully functional but minimal page migration capability we
will be able to enhance low level code and higher level APIs at the same time.
This will hopefully decrease the time needed to get the code for direct page
migration working and into the kernel trees. We hope that the swap based
page migration will be included in 2.6.15.

The patchset consists of two patches:

1. LRU operations

Add basic operations to remove pages from the LRU lists and return
them back to it.

2. Page eviction

Adds a function to mm/vmscan.c called swapout_pages that forces pages
out to swap.

3. MPOL_MF_MOVE flag for memory policies.

This implements MPOL_MF_MOVE in addition to MPOL_MF_STRICT. MPOL_MF_STRICT
allows the checking if all pages in a memory area obey the memory policies.
MPOL_MF_MOVE will evict all pages that do not conform to the memory policy.
The system will allocate pages conforming to the policy on swap in.

4. sys_migrate_pages system call and cpuset API

Adds a new function call

sys_migrate_pages(pid, maxnode, from_nodes, to_nodes)

to migrate pages of a process to a different node.

URLs referring to the discussion regarding the initial version of these
patches.

Page eviction: http://marc.theaimsgroup.com/?l=linux-mm&m=112922756730989&w=2
Numa policy  : http://marc.theaimsgroup.com/?l=linux-mm&m=112922756724715&w=2

Discussion of V2 of the patchset:
http://marc.theaimsgroup.com/?t=112959680300007&r=1&w=2

