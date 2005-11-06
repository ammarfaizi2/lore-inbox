Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932149AbVKFRB4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932149AbVKFRB4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Nov 2005 12:01:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932155AbVKFRB4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Nov 2005 12:01:56 -0500
Received: from smtp.osdl.org ([65.172.181.4]:38111 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932149AbVKFRBz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Nov 2005 12:01:55 -0500
Date: Sun, 6 Nov 2005 09:00:42 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Kyle Moffett <mrmacman_g4@mac.com>
cc: Ingo Molnar <mingo@elte.hu>, Paul Jackson <pj@sgi.com>,
       andy@thermo.lanl.gov, mbligh@mbligh.org, akpm@osdl.org,
       arjan@infradead.org, arjanv@infradead.org, haveblue@us.ibm.com,
       kravetz@us.ibm.com, lhms-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org, mel@csn.ul.ie,
       nickpiggin@yahoo.com.au
Subject: Re: [Lhms-devel] [PATCH 0/7] Fragmentation Avoidance V19
In-Reply-To: <Pine.LNX.4.64.0511060756010.3316@g5.osdl.org>
Message-ID: <Pine.LNX.4.64.0511060848010.3316@g5.osdl.org>
References: <20051104010021.4180A184531@thermo.lanl.gov>
 <Pine.LNX.4.64.0511032105110.27915@g5.osdl.org> <20051103221037.33ae0f53.pj@sgi.com>
 <20051104063820.GA19505@elte.hu> <Pine.LNX.4.64.0511040725090.27915@g5.osdl.org>
 <796B585C-CB1C-4EBA-9EF4-C11996BC9C8B@mac.com> <Pine.LNX.4.64.0511060756010.3316@g5.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 6 Nov 2005, Linus Torvalds wrote:
> 
> And no standard hardware allows you to do that in hw, so we'd end up doing 
> a software page table walk for it (or, more likely, we'd have to make 
> "struct page" bigger).
> 
> You could do it today, although at a pretty high cost. And you'd have to 
> forget about supporting any hardware that really wants contiguous memory 
> for DMA (sound cards etc). It just isn't worth it.

Btw, in case it wasn't clear: the cost of these kinds of things in the 
kernel is usually not so much the actual "lookup" (whether with hw assist 
or with another field in the "struct page").

The biggest cost of almost everything in the kernel these days is the 
extra code-footprint of yet another abstraction, and the locking cost. 

For example, the real cost of the highmem mapping seems to be almost _all_ 
in the locking. It also makes some code-paths more complex, so it's yet 
another I$ fill for the kernel.

So a remappable kernel tends to be different from a remappable user 
application. A user application _only_ ever sees the actual cost of the 
TLB walk (which hardware can do quite efficiently and is very amenable 
indeed to a lot of optimization like OoO and speculative prefetching), but 
on the kernel level, the remapping itself is the cheapest part.

(Yes, user apps can see some of the costs indirectly: they can see the 
synchronization costs if they do lots of mmap/munmap's, especially if they 
are threaded. But they really have to work at it to see it, and I doubt 
the TLB synchronization issues tend to be even on the radar for any user 
space performance analysis).

You could probably do a remappable kernel (modulo the problems with 
specific devices that want bigger physically contiguous areas than one 
page) reasonably cheaply on UP. It gets more complex on SMP and with full 
device access.

In fact, I suspect you can ask any Xen developer what their performance 
problems and worries are. I suspect they much prefer UP clients over SMP 
ones, and _much_ prefer paravirtualization over running unmodified 
kernels.

So remappable kernels are certainly doable, they just have more 
fundamental problems than remappable user space _ever_ has. Both from a 
performance and from a complexity angle.

			Linus
