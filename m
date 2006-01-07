Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932723AbWAGMZi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932723AbWAGMZi (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jan 2006 07:25:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932724AbWAGMZi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jan 2006 07:25:38 -0500
Received: from mtagate1.de.ibm.com ([195.212.29.150]:33454 "EHLO
	mtagate1.de.ibm.com") by vger.kernel.org with ESMTP id S932723AbWAGMZh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jan 2006 07:25:37 -0500
Date: Sat, 7 Jan 2006 13:25:34 +0100
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Dave McCracken <dmccr@us.ibm.com>
Cc: Hugh Dickins <hugh@veritas.com>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Linux Memory Management <linux-mm@kvack.org>
Subject: Re: [PATCH/RFC] Shared page tables
Message-ID: <20060107122534.GA20442@osiris.boeblingen.de.ibm.com>
References: <A6D73CCDC544257F3D97F143@[10.1.1.4]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <A6D73CCDC544257F3D97F143@[10.1.1.4]>
User-Agent: mutt-ng/devel (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Here's a new version of my shared page tables patch.
> 
> The primary purpose of sharing page tables is improved performance for
> large applications that share big memory areas between multiple processes.
> It eliminates the redundant page tables and significantly reduces the
> number of minor page faults.  Tests show significant performance
> improvement for large database applications, including those using large
> pages.  There is no measurable performance degradation for small processes.

Tried to get this running with CONFIG_PTSHARE and CONFIG_PTSHARE_PTE on
s390x. Unfortunately it crashed on boot, because pt_share_pte
returned a broken pte pointer:

> +pte_t *pt_share_pte(struct vm_area_struct *vma, unsigned long address, pmd_t *pmd,
> + ...
> +	pmd_val(spmde) = 0;
> + ...
> +		if (pmd_present(spmde)) {

This is wrong. A pmd_val of 0 will make pmd_present return true on s390x
which is not what you want.
Should be pmd_clear(&spmde).

> +pmd_t *pt_share_pmd(struct vm_area_struct *vma, unsigned long address, pud_t *pud,
> + ...
> +	pud_val(spude) = 0;

Should be pud_clear, I guess :)

Thanks,
Heiko
