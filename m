Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262352AbVCVFgu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262352AbVCVFgu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 00:36:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262396AbVCVFdx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 00:33:53 -0500
Received: from dsl027-180-174.sfo1.dsl.speakeasy.net ([216.27.180.174]:21889
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S262472AbVCVFbV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 00:31:21 -0500
Date: Mon, 21 Mar 2005 21:29:55 -0800
From: "David S. Miller" <davem@davemloft.net>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: tony.luck@intel.com, hugh@veritas.com, akpm@osdl.org,
       benh@kernel.crashing.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] freepgt: free_pgtables use vma list
Message-Id: <20050321212955.6a0f2b61.davem@davemloft.net>
In-Reply-To: <1111464894.5125.34.camel@npiggin-nld.site>
References: <B8E391BBE9FE384DAA4C5C003888BE6F03210DD4@scsmsx401.amr.corp.intel.com>
	<20050321150205.4af39064.davem@davemloft.net>
	<1111464894.5125.34.camel@npiggin-nld.site>
X-Mailer: Sylpheed version 1.0.1 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Mar 2005 15:14:54 +1100
Nick Piggin <nickpiggin@yahoo.com.au> wrote:

> Question, Dave: flush_tlb_pgtables after Hugh's patch is also
> possibly not being called with enough range to cover all page
> tables that have been freed.
> 
> For example, you may have a single page (start,end) address range
> to free, but if this is enclosed by a large enough (floor,ceiling)
> then it may free an entire pgd entry.
> 
> I assume the intention of the API would be to provide the full
> pgd width in that case?

It just wants the range of page tables liberated.  I guess
essentially PMD_SIZE is the granularity.

Anyways, for the record I made it only call flush_tlb_pgtables()
when end > start, but instead of that BUG() I now get the BUG()
on mm->nr_ptes being non-zero at the end of exit_mmap().

Something is up with the floor/ceiling stuff methinks.

It's funny since this code aparently works fine on ia64 which
is fully 3-level too.  Hmm...
