Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751213AbWBWNbZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751213AbWBWNbZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 08:31:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751219AbWBWNbZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 08:31:25 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:41616 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751213AbWBWNbY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 08:31:24 -0500
Date: Thu, 23 Feb 2006 14:29:54 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Andi Kleen <ak@suse.de>, Arjan van de Ven <arjan@intel.linux.com>,
       linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [Patch 3/3] prepopulate/cache cleared pages
Message-ID: <20060223132954.GA16074@elte.hu>
References: <1140686238.2972.30.camel@laptopd505.fenrus.org> <200602231041.00566.ak@suse.de> <20060223124152.GA4008@elte.hu> <200602231406.43899.ak@suse.de> <43FDB55E.7090607@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43FDB55E.7090607@yahoo.com.au>
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

> I'm worried about the situation where we allocate but don't use the 
> new page: it blows quite a bit of cache. Then, when we do get around 
> to using it, it will be cold(er).

couldnt the new pte be flipped in atomically via cmpxchg? That way we 
could do the page clearing close to where we are doing it now, but 
without holding the mmap_sem.

to solve the pte races we could use a bit in the [otherwise empty] pte 
to signal "this pte can be flipped in from now on", which bit would 
automatically be cleared if mprotect() or munmap() is called over that 
range (without any extra changes to those codepaths). (in the rare case 
if the cmpxchg() fails, we go into a slowpath that drops the newly 
allocated page, re-lookups the vma and the pte, etc.)

	Ingo
