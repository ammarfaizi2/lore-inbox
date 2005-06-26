Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261672AbVF0A2R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261672AbVF0A2R (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Jun 2005 20:28:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261677AbVF0A2Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Jun 2005 20:28:16 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:25310 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261672AbVF0A14 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Jun 2005 20:27:56 -0400
Date: Sun, 26 Jun 2005 15:52:10 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, bcrl@kvack.org
Subject: Re: increased translation cache footprint in v2.6
Message-ID: <20050626185210.GB6091@logos.cnet>
References: <20050626172334.GA5786@logos.cnet> <20050626164939.2f457bf6.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050626164939.2f457bf6.akpm@osdl.org>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 26, 2005 at 04:49:39PM -0700, Andrew Morton wrote:
> Marcelo Tosatti <marcelo.tosatti@cyclades.com> wrote:
> >
> > As can be seen the number of entries is more than twice (dominated by kernel addresses).
> 
> But doesn't this:
> 
> I-TLB userspace misses: 142369  I-TLB userspace misses: 2179    ITLB u: 139190
> I-TLB kernel misses: 118288    	I-TLB kernel misses: 1369	ITLB k: 116319
> D-TLB userspace misses: 222916 	D-TLB userspace misses: 180249	DTLB u: 38667
> D-TLB kernel misses: 207773    	D-TLB kernel misses: 167236	DTLB k: 38273
> 
> mean that we're mainly missing on data accesses?

The input files where "diff -u" works are listing only entries from the 
instruction cache. 

I say that because I suppose that you thought that the files "diff -u" 
works on could have mixed i/d cache entries.

Yes, the ratio between instruction/data misses is about 1/2, but the amount 
of data misses is about the same between v2.4 and v2.6.

> >  Sorry, I've got no list of functions for these addresses, but it was pretty obvious at the time 
> >  looking at the sys_read() codepath and respective virtual addresses.
> > 
> >  Manual reorganization of the functions sounded too messy, although BenL mentions something about
> >  fget_light() can and should be optimized.
> 
> The workload you're using also does write(), and the write() paths got
> significantly deeper.

What can be done to bring those functions which compose the paths into the 
smaller amounts of pages as possible? 

> Stack misses, perhaps. 

Can you elaborate? The deltas of data cache misses are about the same.

>  But a tlb entry caches the translation for a single
> page, yes?

Well, a TLB entry might cache different sized pages. The platform support 4kb, 
16kb and 8Mb (IIRC, maybe some other size also).

The bigger pages (8Mb) are only used to map 8Mbytes of instruction at KERNELBASE,
24Mbytes of data (3 8Mbyte entries) also at KERNELBASE and another 8Mbytes of the
configuration registers memory space, which lives outside RAM space.

There was a bug causing the first 8Mbyte entry to be invalidated, which led the 
system to use translations from the 4kB pagetables at KERNELBASE. 

So, the issue has been "solved" for this particular machine, but its still there
(and potentially affects platforms I wonder).
