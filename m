Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261598AbTDOOqa (for <rfc822;willy@w.ods.org>); Tue, 15 Apr 2003 10:46:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261620AbTDOOqa 
	(for <rfc822;linux-kernel-outgoing>);
	Tue, 15 Apr 2003 10:46:30 -0400
Received: from 217-125-129-224.uc.nombres.ttd.es ([217.125.129.224]:14321 "HELO
	cocodriloo.com") by vger.kernel.org with SMTP id S261598AbTDOOq3 
	(for <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Apr 2003 10:46:29 -0400
Date: Tue, 15 Apr 2003 17:09:31 +0200
From: Antonio Vargas <wind@cocodriloo.com>
To: William Lee Irwin III <wli@holomorphy.com>,
       Antonio Vargas <wind@cocodriloo.com>, Andrew Morton <akpm@digeo.com>,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org, mbligh@aracnet.com
Subject: Re: 2.5.67-mm3
Message-ID: <20030415150931.GK14552@wind.cocodriloo.com>
References: <20030414015313.4f6333ad.akpm@digeo.com> <20030415020057.GC706@holomorphy.com> <20030415041759.GA12487@holomorphy.com> <20030415055229.GJ14552@wind.cocodriloo.com> <20030415055256.GF706@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030415055256.GF706@holomorphy.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 14, 2003 at 10:52:56PM -0700, William Lee Irwin III wrote:
> On Mon, Apr 14, 2003 at 09:17:59PM -0700, William Lee Irwin III wrote:
> >> It's a bit of an open question as to how much of a difference this one
> >> makes now, but it says "FIXME". fault_in_pages_writeable() and 
> >> fault_in_pages_readable() have a limited "range" with respect to the
> >> size of the region they can prefault; as they are now, they are only
> >> meant to handle spanning a page boundary. This converts them to iterate
> >> over the virtual address range specified and so touch each virtual page
> >> within it once as specified. As per the comment within the "FIXME",
> >> this is only an issue if PAGE_SIZE < PAGE_CACHE_SIZE.
> >> [patch snip]
> 
> On Tue, Apr 15, 2003 at 07:52:29AM +0200, Antonio Vargas wrote:
> > Page clustering? I did a simple patch yesterday called "cow-ahead", which
> > may be related: on a write to a COW page, it breaks the COW from several pages
> > at the same time. The implementation survived a complete debian 2.2 boot
> > and a fork bomb. Please have a look. The idea came from a discussion with
> > Martin J. Bligh... we liked the name too much not to implement it.
> 
> I apologize if the name is deceiving, but it's conventional. I saw your
> patch and it could very well be valuable, but it would be called
> "prefaulting" or "faultahead". Page clustering is divorcing the TLB
> mapping unit from the kernel's internal allocation unit, specifically,
> enlarging the kernel's allocation unit for reductions in the size of
> certain data structures (for PAE, the most important of these is the
> mem_map[] array but the pagecache radix trees also see good reductions),
> and for physical contiguity benefits in things like io as they are
> applicable (it is not applicable to workloads with many small files or
> for workloads with predominantly small io sizes).
> 
> The article on kerneltrap.org on the subject should have more pointers
> to explanatory posts etc. to get a better idea of what's going on.
> 
> Also important is to properly credit Hugh Dickins with the original
> 2.4 implementation of page clustering, which for optimality and
> correctness and cleanliness is superior to the current state of my own
> for 2.5, and is the source base from which my implementation is derived.
> 
> 
> -- wli

I mentioned page clustering instead of page-fault clustering, so it
was my confusion. I recall seeing lkml posts which talked about
"the pgcl patch" and wondered what it was about until I saw
the kerneltrap article. Looks like a nice way to speed up
the system :)

My trusty m68030@50 AmigaOS machine was faster with 32kb blocksize
on the fs for some tasks, dunno about Linux with the much more advanced
memory and file manager with readahead and related improvements.

My patch booted fine on UML, I'll try to boot a physical machine with it
and try to time a kernel compile.

Besides, if you look closer at the patch, you can see it's doing
the "faultahead" only for cow pages, thus giving it the name "cowahead".

Since taking a page fault has to be very expensive on today's machines
due to deep pipelines, I wonder if we should keep a record of where each
vma has last cow-faulted and dinamically adjust the cowahead window
just like the file access manages his readahead window.

Greets, Antonio.
