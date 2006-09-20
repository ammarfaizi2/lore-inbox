Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751203AbWITF1H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751203AbWITF1H (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 01:27:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751205AbWITF1G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 01:27:06 -0400
Received: from smtp.osdl.org ([65.172.181.4]:4569 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751203AbWITF1F (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 01:27:05 -0400
Date: Tue, 19 Sep 2006 22:26:56 -0700
From: Andrew Morton <akpm@osdl.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Mike Waychison <mikew@google.com>, linux-mm@kvack.org,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: [RFC] page fault retry with NOPAGE_RETRY
Message-Id: <20060919222656.52fadf3c.akpm@osdl.org>
In-Reply-To: <1158728665.6002.262.camel@localhost.localdomain>
References: <1158274508.14473.88.camel@localhost.localdomain>
	<20060915001151.75f9a71b.akpm@osdl.org>
	<45107ECE.5040603@google.com>
	<1158709835.6002.203.camel@localhost.localdomain>
	<1158710712.6002.216.camel@localhost.localdomain>
	<20060919172105.bad4a89e.akpm@osdl.org>
	<1158717429.6002.231.camel@localhost.localdomain>
	<20060919200533.2874ce36.akpm@osdl.org>
	<1158728665.6002.262.camel@localhost.localdomain>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Sep 2006 15:04:24 +1000
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> On Tue, 2006-09-19 at 20:05 -0700, Andrew Morton wrote:
> 
> > resides in a pagetable page.  Once we've dropped mmap_sem, that
> > pagetable page might not be there any more: munmap() might have freed it. 
> > We have to retake mmap_sem, do a find_vma() and a new pagetable walk.
> > 
> > There are some optimisations we could make to avoid all of that in the
> > common case, but this is the conceptual behaviour.
> 
> It's a non-issue anyway the no_page handler in Mike's patch _does_
> re-take mmap_sem before returning RETRY thus my whole idea still stands
> perfectly fine unless I've missed something, which means we can make it
> without changing no_page arguments. Let me re-describe it:
> 
>  - somebody->no_page() returns RETRY. It may have dropped the mmap sem,
> but if it did, like in Mike's patch, it will have re-taken it before
> returning.
> 
>  - upon return (in handle_pte_fault typically) if we get something else
> than that retry, we return 
> as usual.
> 
>  - if we got RETRY we do something like
> 
> 	if (signal_pending(current) || need_resched() || pte_present(*pte))
> 		return VM_FAULT_MINOR;
> 	else
> 		return VM_FAULT_RETRY;
> 
> Thus we still have to change arch to test for VM_FAULT_RETRY and loop on
> it (or return to userland if they want but that's less optimal) but we
> don't have to carry around a "MAY_RETRY" thing nor change no_page()
> arguments.
> 
> The idea is that we can't livelock since we'll always schedule and we
> can take signals so the process can always be killed.
> 
> We'll also avoid the loop and coming back if the PTE has been filled up
> in the meantime (just a cheap optimisation avoiding a new find_vma()
> etc...).
> 
> And it's simpler :)
> 
> Now, I may have missed something of course, but I'd like to know what.
> So far, I don't see what won't work with the above. 
> 

It's a choice between two behaviours:

a) get stuck in the kernel until someone kills you and

b) fault the page in and proceed as expected.

Option b) is better, no?
