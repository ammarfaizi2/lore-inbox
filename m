Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261404AbVALUPI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261404AbVALUPI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jan 2005 15:15:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261394AbVALUMW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jan 2005 15:12:22 -0500
Received: from fw.osdl.org ([65.172.181.6]:46217 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261362AbVALULL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jan 2005 15:11:11 -0500
Date: Wed, 12 Jan 2005 12:10:59 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Davide Libenzi <davidel@xmailserver.org>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Hugh Dickins <hugh@veritas.com>
Subject: Re: Make pipe data structure be a circular list of pages, rather
 than
In-Reply-To: <Pine.LNX.4.58.0501121148330.28987@bigblue.dev.mdolabs.com>
Message-ID: <Pine.LNX.4.58.0501121201140.2310@ppc970.osdl.org>
References: <Pine.LNX.4.44.0501091946020.3620-100000@localhost.localdomain>
 <Pine.LNX.4.58.0501091713300.2373@ppc970.osdl.org>
 <Pine.LNX.4.58.0501091830120.2373@ppc970.osdl.org>
 <Pine.LNX.4.58.0501121148330.28987@bigblue.dev.mdolabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 12 Jan 2005, Davide Libenzi wrote:

> On Sun, 9 Jan 2005, Linus Torvalds wrote:
> 
> > On Sun, 9 Jan 2005, Linus Torvalds wrote:
> > > 
> > > Since you guys stupidly showed interest, here's a very first-order
> > > approximation of filling the pipe from some other source.
> > 
> > Here's a somewhat fixed and tested version, which actually does something 
> > on x86.
> 
> Question. How do you think to splice() skb pages, or any other non page-based
> format?

That's why there's an "offset/length" pair. Right now the only limitation 
is actually
 - that at least the start of the area can be described as a "struct page
   *" (this means that things like a PCI MMIO mapping cannot be spliced -
   but that's true for other reasons anyway, since a "memcpy()" doesn't
   even work on such things on most architectures)
 - that it be mappable with kmap() (this means that if it's a multi-page 
   thing, it needs to be in low memory currently).

The second thing would actually going away in a full implementation
anyway, to be replaced by "map this page in" and "unmap this page" buffer
operations. We need those "map" operations in order to handle other
"prepare for copy" situations, notably waiting for disk IO to be finished
(ie I want to be able to splice pages to the pipe without having to wait
for them - you'd wait for the contents only when the data itself is
needed).

My example patch (which I didn't post publicly because it's a
work-in-progress) already made offset/length be "unsigned int", exactly
because I foresee the "page" possibly being part of a hugetlb page, or at
least a bigger multi-page allocation.

[ Side note: even the first issue - PCI MMIO or other descriptor that 
  doesn't normally have a "struct page *" associated with it - could 
  in theory be handled by just creating a fake "struct page", and hiding 
  the information into it. Then the map/unmap functions would just have to 
  return the virtual address that is usable for a memcpy - since on _some_ 
  architectures you can actually do a memcpy on IO space too. That might 
  be useful for things like AGP or similar that depend on architecture- 
  specific issues anyway ]

		Linus
