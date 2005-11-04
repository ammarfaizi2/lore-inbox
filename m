Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751532AbVKDPju@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751532AbVKDPju (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Nov 2005 10:39:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751515AbVKDPju
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Nov 2005 10:39:50 -0500
Received: from dvhart.com ([64.146.134.43]:44978 "EHLO localhost.localdomain")
	by vger.kernel.org with ESMTP id S1751532AbVKDPjc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Nov 2005 10:39:32 -0500
Date: Fri, 04 Nov 2005 07:39:33 -0800
From: "Martin J. Bligh" <mbligh@mbligh.org>
Reply-To: "Martin J. Bligh" <mbligh@mbligh.org>
To: Linus Torvalds <torvalds@osdl.org>, Ingo Molnar <mingo@elte.hu>
Cc: Paul Jackson <pj@sgi.com>, andy@thermo.lanl.gov, akpm@osdl.org,
       arjan@infradead.org, arjanv@infradead.org, haveblue@us.ibm.com,
       kravetz@us.ibm.com, lhms-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org, mel@csn.ul.ie,
       nickpiggin@yahoo.com.au
Subject: Re: [Lhms-devel] [PATCH 0/7] Fragmentation Avoidance V19
Message-ID: <328940000.1131118773@[10.10.2.4]>
In-Reply-To: <Pine.LNX.4.64.0511040725090.27915@g5.osdl.org>
References: <20051104010021.4180A184531@thermo.lanl.gov><Pine.LNX.4.64.0511032105110.27915@g5.osdl.org> <20051103221037.33ae0f53.pj@sgi.com><20051104063820.GA19505@elte.hu> <Pine.LNX.4.64.0511040725090.27915@g5.osdl.org>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> just to make sure i didnt get it wrong, wouldnt we get most of the 
>> benefits Andy is seeking by having a: boot-time option which sets aside 
>> a "hugetlb zone", with an additional sysctl to grow (or shrink) the pool 
>> - with the growing happening on a best-effort basis, without guarantees?
> 
> Boot-time option to set the hugetlb zone, yes.
> 
> Grow-or-shrink, probably not. Not in practice after bootup on any machine 
> that is less than idle.
> 
> The zones have to be pretty big to make any sense. You don't just grow 
> them or shrink them - they'd be on the order of tens of megabytes to 
> gigabytes. In other words, sized big enough that you will _not_ be able to 
> create them on demand, except perhaps right after boot.
> 
> Growing these things later simply isn't reasonable. I can pretty much 
> guarantee that any kernel I maintain will never have dynamic kernel 
> pointers: when some memory has been allocated with kmalloc() (or 
> equivalent routines - pretty much _any_ kernel allocation), it stays put. 
> Which means that if there is a _single_ kernel alloc in such a zone, it 
> won't ever be then usable for hugetlb stuff.
> 
> And I don't want excessive complexity. We can have things like "turn off 
> kernel allocations from this zone", and then wait a day or two, and hope 
> that there aren't long-term allocs. It might even work occasionally. But 
> the fact is, a number of kernel allocations _are_ long-term (superblocks, 
> root dentries, "struct thread_struct" for long-running user daemons), and 
> it's simply not going to work well in practice unless you have set aside 
> the "no kernel alloc" zone pretty early on.

Exactly. But that's what all the anti-fragmentation stuff was about - trying
to pack unfreeable stuff together. 

I don't think anyone is proposing dynamic kernel pointers inside Linux,
except in that we could possibly change the P-V mapping underneath from
the hypervisor, so that the phys address would change, but you wouldn't
see it. Trouble is, that's mostly done on a larger-than-page size
granularity, so we need SOME larger chunk to switch out (preferably at
least a large-paged size, so we can continue to use large TLB entries for
the kernel mapping).

However, the statically sized option is hugely problematic too.

M.
