Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751575AbWJMCyU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751575AbWJMCyU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Oct 2006 22:54:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751576AbWJMCyU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Oct 2006 22:54:20 -0400
Received: from nz-out-0102.google.com ([64.233.162.202]:21068 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751574AbWJMCyU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Oct 2006 22:54:20 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:reply-to:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id:from;
        b=A13rtbjhDB05msJX9FMFzl8fePW156jQsyiuFO92UHtqQ2D4EJLhKX7yimEJZJjN04EgMsUtXlqA5PArJB0F0fPdPSL8RGC+MR8nXl6ziaeqQ7CqQ5ZJ6nLcuFPx4fakiY5p0H20KlPr9Ee/M07ymLQ/DeWj1YQsWBkDyIBbtpU=
Reply-To: andrew.j.wade@gmail.com
To: John Richard Moser <nigelenki@comcast.net>
Subject: Re: Can context switches be faster?
Date: Thu, 12 Oct 2006 22:53:01 -0400
User-Agent: KMail/1.9.1
Cc: Phillip Susi <psusi@cfl.rr.com>, linux-kernel@vger.kernel.org
References: <452E62F8.5010402@comcast.net> <452E876F.1000604@cfl.rr.com> <452E8980.5040504@comcast.net>
In-Reply-To: <452E8980.5040504@comcast.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610122254.10578.ajwade@cpe001346162bf9-cm0011ae8cd564.cpe.net.cable.rogers.com>
From: Andrew James Wade <andrew.j.wade@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 12 October 2006 14:29, John Richard Moser wrote:
> How does a page table switch work?  As I understand there are PTE chains
> which are pretty much linked lists the MMU follows; I can't imagine this
> being a harder problem than replacing the head.

Generally, the virtual memory mappings are stored as high-fanout trees
rather than linked lists. (ia64 supports a hash table based scheme,
but I don't know if Linux uses it.)  But the bulk of the mapping
lookups will actually occur in a cache of the virtual memory mappings
called the translation lookaside buffer (TLB). It is from the TLB and
not the memory mapping trees that some of the performance problems
with address space switches originate.

The kernel can tolerate some small inconsistencies between the TLB
and the mapping tree (it can fix them in the page fault handler). But
for the most part the TLB must be kept consistent with the current
address space mappings for correct operation. Unfortunately, on some
architectures the only practical way of doing this is to flush the TLB
on address space switches. I do not know if the flush itself takes any
appreciable time, but each of the subsequent TLB cache misses will
necessitate walking the current mapping tree. Whether done by the MMU
or by the kernel (implementations vary), these walks in the aggregate
can be a performance issue.

On some architectures the L1 cache can also require attention from the
kernel on address space switches for correct operation. Even when the
L1 cache doesn't need flushing a change in address space will generally
be accompanied by a change of working set, leading to a period of high
cache misses for the L1/L2 caches. 

Microbenchmarks can miss the cache miss costs associated with context
switches. But I believe the costs of cache thrashing and flushing are
the reason that the time-sharing granularity is so coarse in Linux,
rather than the time it takes the kernel to actually perform a context
switch. (The default time-slice is 100 ms.) Still, the cache miss costs
are workload-dependent, and the actual time the kernel takes to context
switch can be important as well.

Andrew Wade
