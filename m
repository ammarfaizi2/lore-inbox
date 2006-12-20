Return-Path: <linux-kernel-owner+w=401wt.eu-S964953AbWLTJdy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964953AbWLTJdy (ORCPT <rfc822;w@1wt.eu>);
	Wed, 20 Dec 2006 04:33:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964956AbWLTJdy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Dec 2006 04:33:54 -0500
Received: from amsfep20-int.chello.nl ([62.179.120.15]:36469 "EHLO
	amsfep20-int.chello.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964953AbWLTJdx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Dec 2006 04:33:53 -0500
Subject: Re: 2.6.19 file content corruption on ext3
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrei Popa <andrei.popa@i-neo.ro>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Hugh Dickins <hugh@veritas.com>, Florian Weimer <fw@deneb.enyo.de>,
       Marc Haber <mh+linux-kernel@zugschlus.de>,
       Martin Michlmayr <tbm@cyrius.com>
In-Reply-To: <Pine.LNX.4.64.0612191609410.6766@woody.osdl.org>
References: <1166314399.7018.6.camel@localhost>
	 <20061217040620.91dac272.akpm@osdl.org> <1166362772.8593.2.camel@localhost>
	 <20061217154026.219b294f.akpm@osdl.org> <1166460945.10372.84.camel@twins>
	 <Pine.LNX.4.64.0612180933560.3479@woody.osdl.org>
	 <1166466272.10372.96.camel@twins>
	 <Pine.LNX.4.64.0612181030330.3479@woody.osdl.org>
	 <1166468651.6983.6.camel@localhost>
	 <Pine.LNX.4.64.0612181114160.3479@woody.osdl.org>
	 <1166471069.6940.4.camel@localhost>
	 <Pine.LNX.4.64.0612181151010.3479@woody.osdl.org>
	 <1166571749.10372.178.camel@twins>
	 <Pine.LNX.4.64.0612191609410.6766@woody.osdl.org>
Content-Type: text/plain
Date: Wed, 20 Dec 2006 10:32:32 +0100
Message-Id: <1166607152.10372.199.camel@twins>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-12-19 at 16:23 -0800, Linus Torvalds wrote:

> Pls test.

Is good. Only s390 remains a question.

Another point, change_protection() also does a cache flush, should we
too?

> ----
> diff --git a/mm/rmap.c b/mm/rmap.c
> index d8a842a..eec8706 100644
> --- a/mm/rmap.c
> +++ b/mm/rmap.c
> @@ -448,9 +448,10 @@ static int page_mkclean_one(struct page *page, struct vm_area_struct *vma)
>  		goto unlock;
>  
>  	entry = ptep_get_and_clear(mm, address, pte);
          flush_cache_page(vma, address, pte_pfn(entry));
> +	flush_tlb_page(vma, address);
>  	entry = pte_mkclean(entry);
>  	entry = pte_wrprotect(entry);
> -	ptep_establish(vma, address, pte, entry);
> +	set_pte_at(mm, address, pte, entry);
>  	lazy_mmu_prot_update(entry);
>  	ret = 1;
>  
> 

