Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268737AbUJVFEK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268737AbUJVFEK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 01:04:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266786AbUJVFCW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 01:02:22 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:14739 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S268737AbUJVEze (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 00:55:34 -0400
Date: Thu, 21 Oct 2004 21:55:15 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
X-X-Sender: clameter@schroedinger.engr.sgi.com
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
cc: William Lee Irwin III <wli@holomorphy.com>, raybry@sgi.com,
       linux-kernel@vger.kernel.org
Subject: Hugepages demand paging V1 [0/4]: Discussion and overview
In-Reply-To: <B05667366EE6204181EABE9C1B1C0EB501F2ADFB@scsmsx401.amr.corp.intel.com>
Message-ID: <Pine.LNX.4.58.0410212151310.3524@schroedinger.engr.sgi.com>
References: <B05667366EE6204181EABE9C1B1C0EB501F2ADFB@scsmsx401.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a revised edition of the hugetlb demand page patches by
Kenneth Chen which were discussed in the following thread in August 2004

http://marc.theaimsgroup.com/?t=109171285000004&r=1&w=2

The initial post by Ken was in April in

http://marc.theaimsgroup.com/?l=linux-ia64&m=108189860401704&w=2

Hugetlb demand paging has been part of the production release of SuSE SLES
9 for awhile now (used by such products as Oracle) and this patchset is
intended to help hugetlb demand paging also get into the official Linux kernel.

This first version of the patchset is a collection of the patches from the
above mentioned thread in August. The key unresolved issue in that thread was
the necessity of using update_cache_mmu after setting up a huge pte.

update_cache_mmu is intended to update the mmu cache for a PAGESIZE page and
not for a huge page. The solution adopted here (as already suggested as
a possible solution in that thread) is to require an extension of
the semantics of set_huge_pte: set_huge_pte() must also do for huge pages
what update_cache_mmu does for PAGESIZE pages. For that purpose an additional
address parameter was added to set_huge_pte() which will conviently break
any old code. The patch included hopefully already fixes all occurrences
of set_huge_pte.

A linux-2.6.9-bk5 kernel with this patchset was build on IA64 and successfully
tested using a performance test program for hugetlb pages.

Note that this is the first patchset and is to be seen as discussion basis.
not as a final patchset. Please review these patches.

The patchset consists of 4 patches.

1/4 Demand Paging patch. This is the base and is mostly Ken's original work
	plus a fix that was posted later.

2/4 set_huge_pte update. This updates the set_huge_pte function for all
	architectures and insures that the arch specific action for
	update_mmu_cache is taken (which may be do nothing for some arches).
	Please verify that this really addresses the issues for each arch
	and that it is complete.

3/4 Overcommit patch: Mostly the original work by Ken plus a fix that he
	posted later.

4/4 Numa patch: Work by Raymund Bryant and myself at SGI to make
	the huge page allocator try to allocate local memory instead always
	starting at node zero. This definitely needs to be more sophisticated.

Patches 1 to 3 must be applied together. The Numa patch is optional.
