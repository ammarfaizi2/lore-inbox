Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751182AbWITFE6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751182AbWITFE6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 01:04:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751189AbWITFE6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 01:04:58 -0400
Received: from gate.crashing.org ([63.228.1.57]:61145 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1751182AbWITFE5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 01:04:57 -0400
Subject: Re: [RFC] page fault retry with NOPAGE_RETRY
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Mike Waychison <mikew@google.com>, linux-mm@kvack.org,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <20060919200533.2874ce36.akpm@osdl.org>
References: <1158274508.14473.88.camel@localhost.localdomain>
	 <20060915001151.75f9a71b.akpm@osdl.org> <45107ECE.5040603@google.com>
	 <1158709835.6002.203.camel@localhost.localdomain>
	 <1158710712.6002.216.camel@localhost.localdomain>
	 <20060919172105.bad4a89e.akpm@osdl.org>
	 <1158717429.6002.231.camel@localhost.localdomain>
	 <20060919200533.2874ce36.akpm@osdl.org>
Content-Type: text/plain
Date: Wed, 20 Sep 2006 15:04:24 +1000
Message-Id: <1158728665.6002.262.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-09-19 at 20:05 -0700, Andrew Morton wrote:

> resides in a pagetable page.  Once we've dropped mmap_sem, that
> pagetable page might not be there any more: munmap() might have freed it. 
> We have to retake mmap_sem, do a find_vma() and a new pagetable walk.
> 
> There are some optimisations we could make to avoid all of that in the
> common case, but this is the conceptual behaviour.

It's a non-issue anyway the no_page handler in Mike's patch _does_
re-take mmap_sem before returning RETRY thus my whole idea still stands
perfectly fine unless I've missed something, which means we can make it
without changing no_page arguments. Let me re-describe it:

 - somebody->no_page() returns RETRY. It may have dropped the mmap sem,
but if it did, like in Mike's patch, it will have re-taken it before
returning.

 - upon return (in handle_pte_fault typically) if we get something else
than that retry, we return 
as usual.

 - if we got RETRY we do something like

	if (signal_pending(current) || need_resched() || pte_present(*pte))
		return VM_FAULT_MINOR;
	else
		return VM_FAULT_RETRY;

Thus we still have to change arch to test for VM_FAULT_RETRY and loop on
it (or return to userland if they want but that's less optimal) but we
don't have to carry around a "MAY_RETRY" thing nor change no_page()
arguments.

The idea is that we can't livelock since we'll always schedule and we
can take signals so the process can always be killed.

We'll also avoid the loop and coming back if the PTE has been filled up
in the meantime (just a cheap optimisation avoiding a new find_vma()
etc...).

And it's simpler :)

Now, I may have missed something of course, but I'd like to know what.
So far, I don't see what won't work with the above. 

Ben.



