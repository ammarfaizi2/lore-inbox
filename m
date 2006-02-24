Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932067AbWBXGul@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932067AbWBXGul (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Feb 2006 01:50:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750887AbWBXGul
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Feb 2006 01:50:41 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:35213 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1750805AbWBXGul (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Feb 2006 01:50:41 -0500
Date: Fri, 24 Feb 2006 07:49:12 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Andi Kleen <ak@suse.de>, Arjan van de Ven <arjan@intel.linux.com>,
       linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [Patch 3/3] prepopulate/cache cleared pages
Message-ID: <20060224064912.GB7243@elte.hu>
References: <1140686238.2972.30.camel@laptopd505.fenrus.org> <200602231041.00566.ak@suse.de> <20060223124152.GA4008@elte.hu> <200602231406.43899.ak@suse.de> <43FDB55E.7090607@yahoo.com.au> <20060223132954.GA16074@elte.hu> <43FEA97D.2000609@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43FEA97D.2000609@yahoo.com.au>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.3
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.3 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.6 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Nick Piggin <nickpiggin@yahoo.com.au> wrote:

> > couldnt the new pte be flipped in atomically via cmpxchg? That way 
> > we could do the page clearing close to where we are doing it now,
> > but without holding the mmap_sem.
> 
> We have nothing to pin the pte page with if we're not holding the 
> mmap_sem.

why does it have to be pinned? The page is mostly private to this thread 
until it manages to flip it into the pte. Since there's no pte presence, 
there's no swapout possible [here i'm assuming anonymous malloc() 
memory, which is the main focus of Arjan's patch]. Any parallel 
unmapping of that page will be caught and the installation of the page 
will be prevented by the 'bit-spin-lock' embedded in the pte.

> But even in that case, there is nothing in the mmu gather / tlb flush 
> interface that guarantees an architecture cannot free the page table 
> pages immediately (ie without waiting for the flush IPI). This would 
> make sense on architectures that don't walk the page tables in 
> hardware.

but the page wont be found by any other CPU, so it wont be freed! It is 
private to this CPU. The page has no pte presence. It will only be 
present and lookupable as a result of the cmpxchg() flipping the page 
into the pte.

	Ingo
