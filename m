Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031190AbWI0Wyo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031190AbWI0Wyo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Sep 2006 18:54:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031194AbWI0Wyo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Sep 2006 18:54:44 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:30354
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1031190AbWI0Wyn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Sep 2006 18:54:43 -0400
Date: Wed, 27 Sep 2006 15:54:42 -0700 (PDT)
Message-Id: <20060927.155442.71092068.davem@davemloft.net>
To: suresh.b.siddha@intel.com
Cc: akpm@osdl.org, hugh@veritas.com, linux-kernel@vger.kernel.org,
       asit.k.mallick@intel.com
Subject: Re: [patch] mm: fix a race condition under SMC + COW
From: David Miller <davem@davemloft.net>
In-Reply-To: <20060927151507.A12423@unix-os.sc.intel.com>
References: <20060927151507.A12423@unix-os.sc.intel.com>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
Date: Wed, 27 Sep 2006 15:15:07 -0700

> From: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
> 
> Failing context is a multi threaded process context and the failing
> sequence is as follows.
> 
> One thread T0 doing self modifying code on page X on processor P0 and
> another thread T1 doing COW (breaking the COW setup as part of just happened
> fork() in another thread T2) on the same page X on processor P1. T0 doing SMC
> can endup modifying  the new page Y (allocated by the T1 doing COW on P1) but
> because of different I/D TLB's, P0 ITLB will not see the new mapping till
> the flush TLB IPI from  P1 is received. During this interval, if T0 executes
> the code created by SMC it can result in an app error (as ITLB still points to
> old page X and endup executing the content in page X rather than using
> the content in page Y).
> 
> Fix this issue by first clearing the PTE and flushing it, before updating it
> with new entry.
> 
> Signed-off-by: Suresh Siddha <suresh.b.siddha@intel.com>

You can't really do a set_pte_at() in this code path because
there isn't a subsequent flush_tlb_*().

This is needed because some architectures queue up all set_pte_at()
calls until the next flush_tlb_*() in order to batch TLB flushes.
PowerPC and Sparc64 both do this.

The pte_establish() in the existing code works fine because it takes
care of the set_pte_at() and flush_tlb_*() work internally when
necessary on a given platform.

