Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267345AbUIEXlN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267345AbUIEXlN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Sep 2004 19:41:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267346AbUIEXlN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Sep 2004 19:41:13 -0400
Received: from holomorphy.com ([207.189.100.168]:62100 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S267345AbUIEXlL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Sep 2004 19:41:11 -0400
Date: Sun, 5 Sep 2004 16:41:01 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Hugh Dickins <hugh@veritas.com>
Cc: Andrew Morton <akpm@osdl.org>, Suparna Bhattacharya <suparan@in.ibm.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] lighten mmlist_lock
Message-ID: <20040905234101.GD3106@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Hugh Dickins <hugh@veritas.com>, Andrew Morton <akpm@osdl.org>,
	Suparna Bhattacharya <suparan@in.ibm.com>,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0409052344350.3218-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0409052344350.3218-100000@localhost.localdomain>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 05, 2004 at 11:47:11PM +0100, Hugh Dickins wrote:
> --- 2.6.9-rc1-bk12/arch/i386/mm/pgtable.c	2004-08-14 06:39:29.000000000 +0100
> +++ linux/arch/i386/mm/pgtable.c	2004-09-05 17:07:03.438766776 +0100
> @@ -165,10 +165,8 @@ void pmd_ctor(void *pmd, kmem_cache_t *c
>   * against pageattr.c; it is the unique case in which a valid change
>   * of kernel pagetables can't be lazily synchronized by vmalloc faults.
>   * vmalloc faults work because attached pagetables are never freed.
> - * If the locking proves to be non-performant, a ticketing scheme with
> - * checks at dup_mmap(), exec(), and other mmlist addition points
> - * could be used. The locking scheme was chosen on the basis of
> - * manfred's recommendations and having no core impact whatsoever.
> + * The locking scheme was chosen on the basis of manfred's
> + * recommendations and having no core impact whatsoever.
>   * -- wli
>   */
>  spinlock_t pgd_lock = SPIN_LOCK_UNLOCKED;

The ticketing scheme -based alternative only really has to involve a
pgd coming into active use, so s/mmlist addition points/pgd reuse points/
would be better here to retain instructions for anyone suffering from
contention on pgd_lock how to address the issue with the new mmlist
scheme. pgd_alloc() and pgd_free() actually appear to suffice, and it's
also worth mentioning the ticketing scheme's MMU context switch and
smp_call_function() requirements as well.

So I'll send an update to that comment a bit later on.


-- wli
