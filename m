Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268404AbUIAEdt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268404AbUIAEdt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 00:33:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268381AbUIAEdt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 00:33:49 -0400
Received: from gate.crashing.org ([63.228.1.57]:47235 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S269001AbUIAEdf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 00:33:35 -0400
Subject: Re: page fault scalability patch final : i386 tested, x86_64
	support added
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Christoph Lameter <clameter@sgi.com>
Cc: Andrew Morton <akpm@osdl.org>, William Lee Irwin III <wli@holomorphy.com>,
       "David S. Miller" <davem@redhat.com>, raybry@sgi.com, ak@muc.de,
       manfred@colorfullife.com, linux-ia64@vger.kernel.org,
       Linux Kernel list <linux-kernel@vger.kernel.org>, vrajesh@umich.edu,
       hugh@veritas.com
In-Reply-To: <Pine.LNX.4.58.0408271616001.14712@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.58.0408150630560.324@schroedinger.engr.sgi.com>
	 <20040815130919.44769735.davem@redhat.com>
	 <Pine.LNX.4.58.0408151552280.3370@schroedinger.engr.sgi.com>
	 <20040815165827.0c0c8844.davem@redhat.com>
	 <Pine.LNX.4.58.0408151703580.3751@schroedinger.engr.sgi.com>
	 <20040815185644.24ecb247.davem@redhat.com>
	 <Pine.LNX.4.58.0408151924250.4480@schroedinger.engr.sgi.com>
	 <20040816143903.GY11200@holomorphy.com>
	 <B6E8046E1E28D34EB815A11AC8CA3129027B679F@mtv-atc-605e--n.corp.sgi.com>
	 <B6E8046E1E28D34EB815A11AC8CA3129027B67A9@mtv-atc-605e--n.corp.sgi.com>
	 <B6E8046E1E28D34EB815A11AC8CA3129027B67B4@mtv-atc-605e--n.corp.sgi.com>
	 <Pine.LNX.4.58.0408271616001.14712@schroedinger.engr.sgi.com>
Content-Type: text/plain
Message-Id: <1094012689.6538.330.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 01 Sep 2004 14:24:50 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-08-28 at 09:20, Christoph Lameter wrote:
> Signed-off-by: Christoph Lameter <clameter@sgi.com>
> 
> This is the fifth (and hopefully final) release of the page fault
> scalability patches. The scalability patches avoid locking during the
> creation of page table entries for anonymous memory in a threaded
> application. The performance increases significantly for more than 2
> threads running concurrently.

Sorry for "waking up" late on this one but we've been kept busy by
a lot of other things.

The removal of the page table lock has other more subtle side effects
on ppc64 (and ppc32 too) that aren't trivial to solve. Typically, due
to the way we use the hash table as a TLB cache.

For example, out ptep_test_and_clear will first clear the PTE and then
flush the hash table entry. If in the meantime another CPU gets in,
takes a fault, re-populates the PTE and fills the hash table via
update_mmu_cache, we may end up with 2 hash PTEs for the same linux
PTE at least for a short while. This is a potential cause of checkstop
on ppc CPUs.

There may be other subtle races of that sort I haven't encovered yet.

We need to spend more time on our (ppc/ppc64) side to figure out what
is the extent of the problem. We may have a cheap way to fix most of the
issues using the PAGE_BUSY bit we have in the PTEs as a lock, but we
don't have that facility on ppc32.

I think there wouldn't be a problem if we could guarantee exclusion
between page fault and clearing of a PTE (that is basically having the
swapper take the mm write sem) but I don't think that's realistic, oh
well, not that I understand anything about the swap code anyways...

Ben.


