Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261327AbVHAXDI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261327AbVHAXDI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Aug 2005 19:03:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261313AbVHAXDC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Aug 2005 19:03:02 -0400
Received: from tim.rpsys.net ([194.106.48.114]:34208 "EHLO tim.rpsys.net")
	by vger.kernel.org with ESMTP id S261273AbVHAXBN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Aug 2005 19:01:13 -0400
Subject: Re: 2.6.13-rc3-mm3
From: Richard Purdie <rpurdie@rpsys.net>
To: Christoph Lameter <christoph@lameter.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.62.0508011517300.8498@graphe.net>
References: <20050728025840.0596b9cb.akpm@osdl.org>
	 <1122860603.7626.32.camel@localhost.localdomain>
	 <Pine.LNX.4.62.0508010908530.3546@graphe.net>
	 <1122926537.7648.105.camel@localhost.localdomain>
	 <Pine.LNX.4.62.0508011335090.7011@graphe.net>
	 <1122930474.7648.119.camel@localhost.localdomain>
	 <Pine.LNX.4.62.0508011414480.7574@graphe.net>
	 <1122931637.7648.125.camel@localhost.localdomain>
	 <Pine.LNX.4.62.0508011438010.7888@graphe.net>
	 <1122933133.7648.141.camel@localhost.localdomain>
	 <Pine.LNX.4.62.0508011517300.8498@graphe.net>
Content-Type: text/plain
Date: Tue, 02 Aug 2005 00:01:01 +0100
Message-Id: <1122937261.7648.151.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-08-01 at 15:19 -0700, Christoph Lameter wrote:
> On Mon, 1 Aug 2005, Richard Purdie wrote:
> > That number rapidly increases and so it looks like something is failing
> > and looping...
> 
> Maybe we better restore the pte flags changes the way they were if 
> CONFIG_ATOMIC_TABLE_OPS is not defined. Try this instead. If this works 
> then we need two different handle_pte_fault functions to get rid of the 
> macro mess:
>
> +#ifdef CONFIG_ATOMIC_TABLE_OPS
>  	/*
>  	 * If the cmpxchg fails then another processor may have done
>  	 * the changes for us. If not then another fault will bring
> @@ -2106,6 +2107,11 @@
>  	} else {
>  		inc_page_state(cmpxchg_fail_flag_update);
>  	}
> +#else
> +	ptep_set_access_flags(vma, address, pte, entry, write_access);
> +	update_mmu_cache(vma, address, entry);
> +	lazy_mmu_prot_update(entry);
> +#endif

This locks the system up after the "INIT: version 2.86 booting" message.
SysRq still responds but that's about it.

The system also feels/looks extremely sluggish after this change (more
looping?).

With your previously suggested change:

        } else {
                inc_page_state(cmpxchg_fail_flag_update);
+               set_pte_at(mm, address, pte, new_entry);
        }
 
the system proceeds past INIT and boots normally but X still locks up...

Richard

