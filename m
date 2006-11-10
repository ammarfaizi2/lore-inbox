Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424327AbWKJBG7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424327AbWKJBG7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Nov 2006 20:06:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424330AbWKJBG7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Nov 2006 20:06:59 -0500
Received: from gate.crashing.org ([63.228.1.57]:53121 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1424327AbWKJBG6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Nov 2006 20:06:58 -0500
Subject: Re: DMA APIs gumble grumble
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: David Miller <davem@davemloft.net>
Cc: linux-input@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org,
       paulus@samba.org, anton@samba.org, greg@kroah.com
In-Reply-To: <20061107.204653.44098205.davem@davemloft.net>
References: <1162950877.28571.623.camel@localhost.localdomain>
	 <20061107.204653.44098205.davem@davemloft.net>
Content-Type: text/plain
Date: Fri, 10 Nov 2006 12:02:04 +1100
Message-Id: <1163120524.4982.61.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> 
> Please just mirror what I did on sparc64 for sparc32, see changeset
> 42f142371e48fbc44956d57b4e506bb6ce673cd7, with followup bug fixes
> in 36321426e320c2c6bc2f8a1587d6f4d695fca84c and
> 7233589d77fdb593b482a8b7ee867e901f54b593.

Question about sparc. It's implementation of pci_alloc_consistent(),
unlike the other ones from before we had a GFP mask massed, does
GFP_KERNEL allocations and not GFP_ATOMIC. Thus it's never expected to
be called in atomic context. In fact, it does various other things like
calling allocate_resource which is not something you ever want to be
called from interrupt context.

I'm splitting it into a pci_do_alloc_consistent that takes a gfp arg,
and a pair of pci_alloc_consistent & dma_alloc_consistent wrappers.

Do you think I should have the former pass GFP_KERNEL like the current
implementation does or switch it to GFP_ATOMIC like everybody does ? In
this case, should I also change the kmalloc done in there to allocate a
struct resource to use the gfp argument ? (It's currently doing
GFP_KERNEL).

Cheers,
Ben.


