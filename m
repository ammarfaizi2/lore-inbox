Return-Path: <linux-kernel-owner+willy=40w.ods.org-S271374AbUJVPms@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271374AbUJVPms (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 11:42:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271376AbUJVPms
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 11:42:48 -0400
Received: from holomorphy.com ([207.189.100.168]:61123 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S271374AbUJVPmm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 11:42:42 -0400
Date: Fri, 22 Oct 2004 08:42:19 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Christoph Lameter <clameter@sgi.com>
Cc: "Chen, Kenneth W" <kenneth.w.chen@intel.com>, raybry@sgi.com,
       linux-kernel@vger.kernel.org
Subject: Re: Hugepages demand paging V1 [2/4]: set_huge_pte() arch updates
Message-ID: <20041022154219.GY17038@holomorphy.com>
References: <B05667366EE6204181EABE9C1B1C0EB501F2ADFB@scsmsx401.amr.corp.intel.com> <Pine.LNX.4.58.0410212151310.3524@schroedinger.engr.sgi.com> <Pine.LNX.4.58.0410212156300.3524@schroedinger.engr.sgi.com> <20041022103708.GK17038@holomorphy.com> <Pine.LNX.4.58.0410220829200.7868@schroedinger.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0410220829200.7868@schroedinger.engr.sgi.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Oct 2004, William Lee Irwin III wrote:
>> What's described above is not what the patch implements. The patch is
>> calling update_mmu_cache() in a loop on all the virtual base pages of a
>> virtual hugepage, which won't help at all, as it doesn't understand how
>> to find the hugepages regardless of virtual address. AFAICT code to
>> actually do the equivalent of update_mmu_cache() on hugepages most
>> likely involves privileged instructions and perhaps digging around some
>> cpu-specific data structures (e.g. the natively architected pagetables
>> bearing no resemblance to Linux') for almost every non-x86 architecture.

On Fri, Oct 22, 2004 at 08:32:34AM -0700, Christoph Lameter wrote:
> The looping is architecture specific. But you are right for the
> architectures where I simply did the loop that is wrong. The address given
> needs to be correctly calculated which it is not.
> Again this is arch specific stuff and can be done as needed for any
> architecture. There is no intend to generalize this.

The "model", as it were, for pagetable updats, is a 3-stage model:
(1) prepare
(2) update
(3) commit

update_mmu_cache() is stage (3). Linux' software pagetable
modifications are step (2). Generally, architectures are trying to fold
stages (2) and (3) together in set_huge_pte(), so update_mmu_cache() is
not so much of an issue for them (and it's actually incorrect to do
this multiple times or without the architectures' awareness of hugepages
in update_mmu_cache() and so on). To completely regularize the hugetlb
case, merely move the commitment to cpu-native structures or other TLB
insertion done within set_huge_pte() to a new case in update_mmu_cache()
for large pages.

What is in fact far more pressing is flush_dcache_page(), without a
correct implementation of which for hugetlb, user-visible data
corruption follows.


-- wli
