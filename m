Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261458AbVERMhA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261458AbVERMhA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 May 2005 08:37:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261509AbVERMhA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 May 2005 08:37:00 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:16274 "EHLO
	MTVMIME01.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S261458AbVERMfU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 May 2005 08:35:20 -0400
Date: Wed, 18 May 2005 13:34:25 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Andrew Morton <akpm@osdl.org>
cc: Andi Kleen <ak@suse.de>, luming.yu@intel.com, racing.guo@intel.com,
       davej@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -mm] x86 port lockless MCE quirky bank0
In-Reply-To: <20050517153941.7d99d1f6.akpm@osdl.org>
Message-ID: <Pine.LNX.4.61.0505181302410.4517@goblin.wat.veritas.com>
References: <Pine.LNX.4.61.0505172107490.5585@goblin.wat.veritas.com> 
    <20050517202428.GD307@wotan.suse.de> 
    <20050517153941.7d99d1f6.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
X-OriginalArrivalTime: 18 May 2005 12:33:56.0414 (UTC) 
    FILETIME=[DBBB3DE0:01C55BA5]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 May 2005, Andrew Morton wrote:
> 
> Yes.  I'll drop the following from -mm:
> 
> x86-port-lockless-mce-preparation.patch
> x86-port-lockless-mce-implementation.patch
> x86-port-lockless-mce-implementation-fix.patch
> x86-port-lockless-mce-implementation-fix-2.patch

The right decision for now, I think - thanks.

I presume they may return later on, so I'd better confess:
I lied when I said my patch fixed the P6 bank0 issue, I was confused
between rebuildings and rebootings.  It should have fixed the issue,
but the patch which actually fixed it was one earlier, which had an
off-by-one ("> quirky_bank0") which I'd corrected before posting.

The ">= quirky_bank0" patch was not enough to fix the issue because...
mce_cpu_quirks (and mce_init and mce_cpu_features) are never called at
startup (on Intel or Centaur), because the logic in machine_check_init
(see below) to call mcheck_init is broken.

Which explains why I got the freeze at resume not at startup,
and casts doubt on how much any of it has got tested so far.

Hugh

void __devinit machine_check_init(struct cpuinfo_x86 *c)
{
	if (mce_dont_init)
		return;

	switch (c->x86_vendor) {

		case X86_VENDOR_INTEL:
			if (c->x86==5)
				intel_p5_mcheck_init(c);
			break;

		case X86_VENDOR_CENTAUR:
			if (c->x86==5)
				winchip_mcheck_init(c);
			break;

		default:
			machine_check_vector = do_machine_check;
			wmb();
			mcheck_init(c);
			break;
	}
}
