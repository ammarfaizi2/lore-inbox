Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265307AbUEZEPw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265307AbUEZEPw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 May 2004 00:15:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265306AbUEZEPw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 May 2004 00:15:52 -0400
Received: from gate.crashing.org ([63.228.1.57]:15240 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S265304AbUEZEPq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 May 2004 00:15:46 -0400
Subject: Re: [PATCH] ppc64: Fix possible race with set_pte on a present PTE
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: "David S. Miller" <davem@redhat.com>, wesolows@foobazco.org,
       willy@debian.org, Andrea Arcangeli <andrea@suse.de>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>, mingo@elte.hu,
       bcrl@kvack.org, linux-mm@kvack.org,
       Linux Arch list <linux-arch@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0405252031270.15534@ppc970.osdl.org>
References: <1085369393.15315.28.camel@gaston>
	 <Pine.LNX.4.58.0405232046210.25502@ppc970.osdl.org>
	 <1085371988.15281.38.camel@gaston>
	 <Pine.LNX.4.58.0405232134480.25502@ppc970.osdl.org>
	 <1085373839.14969.42.camel@gaston>
	 <Pine.LNX.4.58.0405232149380.25502@ppc970.osdl.org>
	 <20040525034326.GT29378@dualathlon.random>
	 <Pine.LNX.4.58.0405242051460.32189@ppc970.osdl.org>
	 <20040525114437.GC29154@parcelfarce.linux.theplanet.co.uk>
	 <Pine.LNX.4.58.0405250726000.9951@ppc970.osdl.org>
	 <20040525153501.GA19465@foobazco.org>
	 <Pine.LNX.4.58.0405250841280.9951@ppc970.osdl.org>
	 <20040525102547.35207879.davem@redhat.com>
	 <Pine.LNX.4.58.0405251034040.9951@ppc970.osdl.org>
	 <20040525105442.2ebdc355.davem@redhat.com>
	 <Pine.LNX.4.58.0405251056520.9951@ppc970.osdl.org>
	 <1085521251.24948.127.camel@gaston>
	 <Pine.LNX.4.58.0405251452590.9951@ppc970.osdl.org>
	 <Pine.LNX.4.58.0405251455320.9951@ppc970.osdl.org>
	 <1085522860.15315.133.camel@gaston>
	 <Pine.LNX.4.58.0405251514200.9951@ppc970.osdl.org>
	 <1085530867.14969.143.camel@gaston>
	 <Pine.LNX.4.58.0405251749500.9951@ppc970.osdl.org>
	 <1085541906.14969.412.camel@gaston>
	 <Pine.LNX.4.58.0405252031270.15534@ppc970.osdl.org>
Content-Type: text/plain
Message-Id: <1085544720.5580.9.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 26 May 2004 14:12:02 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-05-26 at 14:08, Linus Torvalds wrote:

> You're right. We do use it on the do_wp_page() path, and there we actually 
> use a whole new page in the "break_cow()" case. That case is in fact 
> fundamentally different from the other ones.
> 
> So we should probably break up the "ptep_establish()" into its two pieces,
> since the callers don't actually want to do the same thing. One really
> wants to do a "clear old one, set a totally new one", and the two other
> places want to actually update just the dirty and accessed bits.

The first one could still be called "pte_establish" ... I mean, it makes
little sense to continue calling "pte_establish" something  that just
does set one of those 2 bits... And the flush done by pte_establish in
this case is useless on ppc... so I'd rather kill pte_establish
completely instead and define it's arch (or generic) impl. of
ptep_set_dirty_accessed() responsibility to do the TLB flush if
necessary, no ? (well, a call to it on ppc isn't expensive if we didn't
add anything to the batch anyway...)

> In fact, the only non-generic user of "ptep_establish()" (s390) didn't 
> want to use the generic version exactly because of this very conceptual 
> bug. It uses "ptep_clear_flush()" for the replacement case, which actually 
> makes sense.
> 
> So does it work if you do this appended patch first? This is a real 
> cleanup, and I think it will allow us to get rid of the s390-specific code 
> in ptep_establish(). Along with hopefully fixing your problem too.
> 
> After this, we should be able to have a BUG() in "set_pte()" if the entry 
> wasn't clear before (assuming the arch doesn't use set_pte() for the dirty 
> updates etc).

Ok, I'll give it a spin.

> 		Linus
> 
> ---
> ===== mm/memory.c 1.177 vs edited =====
> --- 1.177/mm/memory.c	Tue May 25 12:37:09 2004
> +++ edited/mm/memory.c	Tue May 25 21:04:49 2004
> @@ -1004,7 +1004,10 @@
>  	flush_cache_page(vma, address);
>  	entry = maybe_mkwrite(pte_mkdirty(mk_pte(new_page, vma->vm_page_prot)),
>  			      vma);
> -	ptep_establish(vma, address, page_table, entry, 1);
> +
> +	/* Get rid of the old entry, replace with new */
> +	ptep_clear_flush(vma, address, page_table);
> +	set_pte(page_table, entry);
>  	update_mmu_cache(vma, address, entry);
>  }
>  
-- 
Benjamin Herrenschmidt <benh@kernel.crashing.org>

