Return-Path: <linux-kernel-owner+w=401wt.eu-S1754437AbWLRTSf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754437AbWLRTSf (ORCPT <rfc822;w@1wt.eu>);
	Mon, 18 Dec 2006 14:18:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754438AbWLRTSf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Dec 2006 14:18:35 -0500
Received: from smtp.osdl.org ([65.172.181.25]:37853 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754436AbWLRTSe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Dec 2006 14:18:34 -0500
Date: Mon, 18 Dec 2006 11:18:13 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Andrei Popa <andrei.popa@i-neo.ro>
cc: Peter Zijlstra <a.p.zijlstra@chello.nl>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Hugh Dickins <hugh@veritas.com>, Florian Weimer <fw@deneb.enyo.de>,
       Marc Haber <mh+linux-kernel@zugschlus.de>,
       Martin Michlmayr <tbm@cyrius.com>
Subject: Re: 2.6.19 file content corruption on ext3
In-Reply-To: <1166468651.6983.6.camel@localhost>
Message-ID: <Pine.LNX.4.64.0612181114160.3479@woody.osdl.org>
References: <1166314399.7018.6.camel@localhost>  <20061217040620.91dac272.akpm@osdl.org>
 <1166362772.8593.2.camel@localhost>  <20061217154026.219b294f.akpm@osdl.org>
 <1166460945.10372.84.camel@twins>  <Pine.LNX.4.64.0612180933560.3479@woody.osdl.org>
  <1166466272.10372.96.camel@twins>  <Pine.LNX.4.64.0612181030330.3479@woody.osdl.org>
 <1166468651.6983.6.camel@localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 18 Dec 2006, Andrei Popa wrote:
> 
> I applied Linus patch, Andrew patch, Peter Zijlstra patches(the last
> two). All unified patch is attached. I tested and I have no corruption.

That wasn't very interesting, because you also had the patch that just 
disabled "page_mkclean_one()" entirely:

> diff --git a/mm/rmap.c b/mm/rmap.c
> index d8a842a..3f9061e 100644
> --- a/mm/rmap.c
> +++ b/mm/rmap.c
> @@ -448,7 +448,7 @@ static int page_mkclean_one(struct page 
>  		goto unlock;
>  
>  	entry = ptep_get_and_clear(mm, address, pte);
> -	entry = pte_mkclean(entry);
> +	/*entry = pte_mkclean(entry);*/
>  	entry = pte_wrprotect(entry);
>  	ptep_establish(vma, address, pte, entry);
>  	lazy_mmu_prot_update(entry);

The above patch is bad. It's always going to hide the bug, but it hides it 
by just not doing anything at all. So any patch combination that contains 
that patch will probably _always_ fix your problem, but it won't be an 
interesting patch..

So can you remove that small fragment? Also, it would be nice if you added 
the WARN_ON() to this sequence in mm/page-writeback.c:

+                       if (!must_clean_ptes && cleaned)
+                               set_page_dirty(page);

just make it do a WARN_ON() if this ever triggers.

Then, IF the corruption is gone, we'd love to see the WARN_ON results..

		Linus
