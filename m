Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262873AbUDDWLT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Apr 2004 18:11:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262872AbUDDWLT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Apr 2004 18:11:19 -0400
Received: from fw.osdl.org ([65.172.181.6]:56007 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262873AbUDDWLN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Apr 2004 18:11:13 -0400
Date: Sun, 4 Apr 2004 15:10:58 -0700
From: Andrew Morton <akpm@osdl.org>
To: hugh@veritas.com, andrea@suse.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.6.5-aa1 arch updates
Message-Id: <20040404151058.5ddc703e.akpm@osdl.org>
In-Reply-To: <20040404145126.03156a15.akpm@osdl.org>
References: <Pine.LNX.4.44.0404041446430.22502-100000@localhost.localdomain>
	<20040404145126.03156a15.akpm@osdl.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> wrote:
>
> Hugh Dickins <hugh@veritas.com> wrote:
>  >
>  > I notice that's a __GFP_REPEAT allocation, but even those fail when
>  >  OOM-killed - I find its alias __GFP_NOFAIL very misleading.
> 
>  #define __GFP_REPEAT	0x400	/* Retry the allocation.  Might fail */
>  #define __GFP_NOFAIL	0x800	/* Retry for ever.  Cannot fail */
> 
>  __GFP_REPEAT is mainly for higher-order allocations which would otherwise
>  have given up too early.

It all comes back to me now.  The reason there is a __GFP_REPEAT in the
pte_alloc_one() implementations is that lots of architectures used to do
stuff like this:

static inline pte_t *
pte_alloc_one_kernel(struct mm_struct *mm, unsigned long addr)
{
	int count = 0;
	pte_t *pte;

	do {
		pte = (pte_t *)__get_free_page(GFP_KERNEL);
		if (pte)
			clear_page(pte);
		else {
			current->state = TASK_UNINTERRUPTIBLE;
			schedule_timeout(HZ);
		}
	} while (!pte && (count++ < 10));

	return pte;
}

That was all removed and the __GFP_REPEAT flag was added instead, as a "try
really hard" hint to the page allocator.

