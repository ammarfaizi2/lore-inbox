Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965978AbWKJCu2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965978AbWKJCu2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Nov 2006 21:50:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965984AbWKJCu2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Nov 2006 21:50:28 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:3481
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S965978AbWKJCu2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Nov 2006 21:50:28 -0500
Date: Thu, 09 Nov 2006 18:50:26 -0800 (PST)
Message-Id: <20061109.185026.07639529.davem@davemloft.net>
To: benh@kernel.crashing.org
Cc: linux-input@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org,
       paulus@samba.org, anton@samba.org, greg@kroah.com
Subject: Re: DMA APIs gumble grumble
From: David Miller <davem@davemloft.net>
In-Reply-To: <1163120524.4982.61.camel@localhost.localdomain>
References: <1162950877.28571.623.camel@localhost.localdomain>
	<20061107.204653.44098205.davem@davemloft.net>
	<1163120524.4982.61.camel@localhost.localdomain>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Fri, 10 Nov 2006 12:02:04 +1100

> > Please just mirror what I did on sparc64 for sparc32, see changeset
> > 42f142371e48fbc44956d57b4e506bb6ce673cd7, with followup bug fixes
> > in 36321426e320c2c6bc2f8a1587d6f4d695fca84c and
> > 7233589d77fdb593b482a8b7ee867e901f54b593.
> 
> Question about sparc. It's implementation of pci_alloc_consistent(),
> unlike the other ones from before we had a GFP mask massed, does
> GFP_KERNEL allocations and not GFP_ATOMIC. Thus it's never expected to
> be called in atomic context. In fact, it does various other things like
> calling allocate_resource which is not something you ever want to be
> called from interrupt context.

pci_alloc_consistent() is not allowed from atomic contexts.

> I'm splitting it into a pci_do_alloc_consistent that takes a gfp arg,
> and a pair of pci_alloc_consistent & dma_alloc_consistent wrappers.
> 
> Do you think I should have the former pass GFP_KERNEL like the current
> implementation does or switch it to GFP_ATOMIC like everybody does ? In
> this case, should I also change the kmalloc done in there to allocate a
> struct resource to use the gfp argument ? (It's currently doing
> GFP_KERNEL).

pci_alloc_consistent() really cannot be allowed to use GFP_ATOMIC.
