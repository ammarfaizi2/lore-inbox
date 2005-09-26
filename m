Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750710AbVIZHlb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750710AbVIZHlb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Sep 2005 03:41:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750741AbVIZHlb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Sep 2005 03:41:31 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:61146
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1750710AbVIZHlb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Sep 2005 03:41:31 -0400
Date: Mon, 26 Sep 2005 00:41:23 -0700 (PDT)
Message-Id: <20050926.004123.47346085.davem@davemloft.net>
To: benh@kernel.crashing.org
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: update_mmu_cache(): fault or not fault ?
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <1127715725.15882.43.camel@gaston>
References: <1127715725.15882.43.camel@gaston>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Mon, 26 Sep 2005 16:22:05 +1000

> The problem is that want to only ever do that kind of hw TLB pre-fill
> when update_mmu_cache() is called as the result an actual fault.
> However, for some reasons that I'm not 100% sure about (*)
> update_mmu_cache() is called from other places, typically in mm/fremap.c
> which aren't directly results of faults.
> 
> So I suggest adding an argument to it "int is_fault", that would
> basically be '1' on all the call sites in mm/memory.c and '0' in all the
> call sites in mm/fremap.c.

You can track this in your port specific code.  That's what I do on
sparc64 to deal with this case.  I record the TLB miss type (D or I
tlb), and also whether a write occurred, in a bitmask.  Then I check
this in update_mmu_cache() to decide whether to prefill.

I store it in current_thread_info() and clear it at the end of fault
processing.

Just grep for "FAULT_CODE_*" in the sparc64 code to see how this
works.

Although, I'm ambivalent as to whether prefilling helps at all.
