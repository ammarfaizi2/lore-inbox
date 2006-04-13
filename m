Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965054AbWDMXy6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965054AbWDMXy6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Apr 2006 19:54:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965058AbWDMXyg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Apr 2006 19:54:36 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:10883 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S965055AbWDMXyd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Apr 2006 19:54:33 -0400
Date: Thu, 13 Apr 2006 16:54:06 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: akpm@osdl.org
Cc: Hugh Dickins <hugh@veritas.com>, linux-kernel@vger.kernel.org,
       Lee Schermerhorn <lee.schermerhorn@hp.com>, linux-mm@kvack.org,
       Christoph Lameter <clameter@sgi.com>,
       Hirokazu Takahashi <taka@valinux.co.jp>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Message-Id: <20060413235406.15398.42233.sendpatchset@schroedinger.engr.sgi.com>
Subject: [PATCH 0/5] Swapless page migration V2: Overview
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Swapless Page migration V2

Currently page migration is depending on the ability to assign swap entries
to pages. However, those entries will only be to identify anonymous pages.
Page migration will not work without swap although swap space is never
really used.

This patchset removes that dependency by introducing a special type of
swap entry that encodes a pfn number of the page being migrated. If that
swap pte (a migration entry) is encountered then do_swap_page() will redo the
fault until the migration entry has been removed.

Migration entries have a very short lifetime and exist only while the page is
locked. Only a few supporting functions are needed.

To some extend this covers the same ground as Marcelo's migration
cache. However, I hope that this approach is simpler and less intrusive.

The migration functions will still be able to use swap entries if a page
is already on the swap cache. But migration functions will no longer assign
swap entries to pages or remove them. Maybe lazy migration can then manage
its own swap cache or migration cache if needed?

Efficiency of migration is increased by:

1. Avoiding useless retries
   The use of migration entries avoids raising the page count in do_swap_page().
   The existing approach can increase the page count between the unmapping
   of the ptes for a page and the page migration page count check resulting
   in having to retry migration although all accesses have been stopped.

2. Swap entries do not have to be assigned and removed from pages.

3. No swap space has to be setup for page migration. Page migration
   will never use swap.

The patchset will allow later patches to enable migration of VM_LOCKED vmas,
the ability to exempt vmas from page migration, and allow the implementation
of a another userland migration API for handling batches of pages.

This patchset was first discussed here:

http://marc.theaimsgroup.com/?l=linux-mm&m=114413402522102&w=2

Changes from V1->V2:
- Make this even lighter on the VM by moving the migration removal
  code into mm/migrate.c
- Do not increase pagecount in do_swap_page()
- Make this work and build correctly for non swap and non migration
  cases.
- Stress testing and work out (hopefully) all kinks.

The patchset consists of five patches:

1. try_to_unmap(): Rename ignrefs to "migration"

   We will be using that try_to_unmap flag in the next patch to
   mean that page migration has called try_to_unmap().

2. Add migration swap entries

   Add the SWP_TYPE_MIGRATION and a few necessary handlers for this
   type of entry. Also modify do_swap_page() to repeat fault if
   a migration entry is encountered.

3. try_to_unmap(): Create migration entries if migration calls
   try_to_unmap for pages without PageSwapCache() but with the
   migration flag set.

4. Rip out old swap migration code

   Remove all the old swap based code. Note that this also removes the fallback
   to swap if all other attempts to migrate fail and also the ability to
   migrate to swap (which was never used)

5. Revise main migration code

   Revise the migration logic to use the new migration entries. Add
   functions to convert migration entries to regular ptes.

