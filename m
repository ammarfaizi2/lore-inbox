Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965175AbWD1FSi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965175AbWD1FSi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Apr 2006 01:18:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965177AbWD1FSi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Apr 2006 01:18:38 -0400
Received: from ns2.suse.de ([195.135.220.15]:46486 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S965175AbWD1FSi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Apr 2006 01:18:38 -0400
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: zach@vmware.com, torvalds@osdl.org
Subject: Re: [PATCH] x86/PAE: Fix pte_clear for the >4GB RAM case
References: <200604272001.k3RK1dmX007637@hera.kernel.org>
From: Andi Kleen <ak@suse.de>
Date: 28 Apr 2006 07:18:27 +0200
In-Reply-To: <200604272001.k3RK1dmX007637@hera.kernel.org>
Message-ID: <p73mze66zx8.fsf@bragg.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linux Kernel Mailing List <linux-kernel@vger.kernel.org> writes:
> +/*
> + * For PTEs and PDEs, we must clear the P-bit first when clearing a page table
> + * entry, so clear the bottom half first and enforce ordering with a compiler
> + * barrier.
> + */
> +static inline void pte_clear(struct mm_struct *mm, unsigned long addr, pte_t *ptep)
> +{
> +	ptep->pte_low = 0;
> +	smp_wmb();
> +	ptep->pte_high = 0;
> +}
> +
> +static inline void pmd_clear(pmd_t *pmd)
> +{
> +	u32 *tmp = (u32 *)pmd;
> +	*tmp = 0;
> +	smp_wmb();
> +	*(tmp + 1) = 0;
> +}

I think that's still wrong - it should be wmb() not smp_wmb because this
problem can happen on a UP kernel already.

-Andi

