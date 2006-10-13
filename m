Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750898AbWJMF31@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750898AbWJMF31 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Oct 2006 01:29:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750900AbWJMF31
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Oct 2006 01:29:27 -0400
Received: from rwcrmhc14.comcast.net ([216.148.227.154]:20626 "EHLO
	rwcrmhc14.comcast.net") by vger.kernel.org with ESMTP
	id S1750842AbWJMF31 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Oct 2006 01:29:27 -0400
Message-ID: <452F2433.2010307@comcast.net>
Date: Fri, 13 Oct 2006 01:29:23 -0400
From: John Richard Moser <nigelenki@comcast.net>
User-Agent: Thunderbird 1.5.0.7 (X11/20060918)
MIME-Version: 1.0
To: andrew.j.wade@gmail.com
CC: Phillip Susi <psusi@cfl.rr.com>, linux-kernel@vger.kernel.org
Subject: Re: Can context switches be faster?
References: <452E62F8.5010402@comcast.net> <452E876F.1000604@cfl.rr.com> <452E8980.5040504@comcast.net> <200610122254.10578.ajwade@cpe001346162bf9-cm0011ae8cd564.cpe.net.cable.rogers.com>
In-Reply-To: <200610122254.10578.ajwade@cpe001346162bf9-cm0011ae8cd564.cpe.net.cable.rogers.com>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1



Andrew James Wade wrote:
> On Thursday 12 October 2006 14:29, John Richard Moser wrote:
>> How does a page table switch work?  As I understand there are PTE chains
>> which are pretty much linked lists the MMU follows; I can't imagine this
>> being a harder problem than replacing the head.
> 
> Generally, the virtual memory mappings are stored as high-fanout trees
> rather than linked lists. (ia64 supports a hash table based scheme,
> but I don't know if Linux uses it.)  But the bulk of the mapping
> lookups will actually occur in a cache of the virtual memory mappings
> called the translation lookaside buffer (TLB). It is from the TLB and
> not the memory mapping trees that some of the performance problems
> with address space switches originate.
> 
> The kernel can tolerate some small inconsistencies between the TLB
> and the mapping tree (it can fix them in the page fault handler). But
> for the most part the TLB must be kept consistent with the current
> address space mappings for correct operation. Unfortunately, on some
> architectures the only practical way of doing this is to flush the TLB
> on address space switches. I do not know if the flush itself takes any
> appreciable time, but each of the subsequent TLB cache misses will
> necessitate walking the current mapping tree. Whether done by the MMU
> or by the kernel (implementations vary), these walks in the aggregate
> can be a performance issue.

True.  You can trick the MMU into faulting into the kernel (PaX does
this to apply non-executable pages-- pages, not halves of VM-- on x86),
but it's orders of magnitude slower as I understand and the petty gains
you can get over the hardware MMU doing it are not going to outweigh it.

> 
> On some architectures the L1 cache can also require attention from the
> kernel on address space switches for correct operation. Even when the
> L1 cache doesn't need flushing a change in address space will generally
> be accompanied by a change of working set, leading to a period of high
> cache misses for the L1/L2 caches. 

Yeah, only exception being if L1 and L2 are both physically addressed,
and thing like libc's .text are shared, leading to shared working sets
in I1 and L2.

> 
> Microbenchmarks can miss the cache miss costs associated with context
> switches. But I believe the costs of cache thrashing and flushing are

cachegrind is probably guilty but I haven't examined it.

> the reason that the time-sharing granularity is so coarse in Linux,
> rather than the time it takes the kernel to actually perform a context
> switch. (The default time-slice is 100 ms.) Still, the cache miss costs

I thought it was minimum 5mS... I don't know what default is.  Heh.

> are workload-dependent, and the actual time the kernel takes to context
> switch can be important as well.
> 
> Andrew Wade
> 

- --
    We will enslave their women, eat their children and rape their
    cattle!
                  -- Bosc, Evil alien overlord from the fifth dimension
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iQIVAwUBRS8kMQs1xW0HCTEFAQLS9w/+MAgrzYrZx1n59MgcfJTfp5eaD+tS5fJ7
qDd47qbycVR44sdj7kd89MNs7+oenm+511SRm1boQnT4mApqm/WXOXP3CnlFersS
f8TfS/HwMw79IBGDm9m0mIOZytaWDdDhoNyj3J993QUwfdjVbpOLhXXp+66ZqV7N
cHfVVX9MabJo5jwbzFWjvJMzoIfIQWGHHcqSqQ33sC3Kep+zbSs4yvoWGVE687eq
g9rxzT03z32a0oyUongqr6jV0X5v4w3u83sYlARgGGJcOcVFC3ulj05zz1w9GQHc
/SADT5Y3uFmHr11Rh2gJMnGEQoqu2a+dda5sLKD9R9Q0CtSKnNSV1g1HYDzwUyce
8f/xoFbP9yFjBynW2nZ8ZXNVQeiCy0M22Pq7K+VRwywE5U1ow6BEhNFLTXC0WPyQ
kl+EZZaXxhGa1m2EUvUeebchpx4uLyYPmHaOuSS6qiNxf5ct5TO2f94nwR5rwZLD
iKy2A7rkE6mM1z5WFTyO3QAlQg6vdObURHb38d/lp55iATg2z0FiUto2pzE9h61y
3Eax60EKDCtzCm69Sx2hnYaWr4Bj6NifZZbrYjZrjxb7feELFba2oZ6Y6ew0+v4d
Sp6V3dvRthpsNF+Mm0lR9KbC1QwHrnHQg3gvVC6N86XGCLiEaRkMtRNSV45pybYy
jdOycAlM9Hs=
=iUgf
-----END PGP SIGNATURE-----
