Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030552AbVKDBsP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030552AbVKDBsP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 20:48:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030570AbVKDBsP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 20:48:15 -0500
Received: from holly.csn.ul.ie ([136.201.105.4]:63153 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S1030552AbVKDBsO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 20:48:14 -0500
Date: Fri, 4 Nov 2005 01:48:11 +0000 (GMT)
From: Mel Gorman <mel@csn.ul.ie>
X-X-Sender: mel@skynet
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Linus Torvalds <torvalds@osdl.org>, "Martin J. Bligh" <mbligh@mbligh.org>,
       Arjan van de Ven <arjan@infradead.org>,
       Dave Hansen <haveblue@us.ibm.com>, Ingo Molnar <mingo@elte.hu>,
       Andrew Morton <akpm@osdl.org>, kravetz@us.ibm.com,
       linux-mm <linux-mm@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       lhms <lhms-devel@lists.sourceforge.net>,
       Arjan van de Ven <arjanv@infradead.org>
Subject: Re: [Lhms-devel] [PATCH 0/7] Fragmentation Avoidance V19
In-Reply-To: <436AB7CA.6060603@yahoo.com.au>
Message-ID: <Pine.LNX.4.58.0511040134460.9172@skynet>
References: <4366C559.5090504@yahoo.com.au>
 <1130856555.14475.77.camel@localhost><20051101150142.GA10636@elte.hu>
 <1130858580.14475.98.camel@localhost><20051102084946.GA3930@elte.hu>
 <436880B8.1050207@yahoo.com.au><1130923969.15627.11.camel@localhost>
 <43688B74.20002@yahoo.com.au><255360000.1130943722@[10.10.2.4]>
 <4369824E.2020407@yahoo.com.au> <306020000.1131032193@[10.10.2.4]>
 <1131032422.2839.8.camel@laptopd505.fenrus.org>  <Pine.LNX.4.64.0511030747450.27915@g5.osdl.org>
 <Pine.LNX.4.58.0511031613560.3571@skynet>  <Pine.LNX.4.64.0511030842050.27915@g5.osdl.org>
 <309420000.1131036740@[10.10.2.4]>  <Pine.LNX.4.64.0511030918110.27915@g5.osdl.org>
 <311050000.1131040276@[10.10.2.4]> <1131040786.2839.18.camel@laptopd505.fenrus.org>
 <Pine.LNX.4.64.0511031006550.27915@g5.osdl.org> <312300000.1131041824@[10.1!
 0.2.4]> <436AB241.2030403@yahoo.com.au> <Pine.LNX.4.64.0511031704590.27915@g5.osdl.org>
 <436AB7CA.6060603@yahoo.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Nov 2005, Nick Piggin wrote:

> Linus Torvalds wrote:
> >
> > On Fri, 4 Nov 2005, Nick Piggin wrote:
> >
> > > Looks like ppc64 is getting 64K page support, at which point higher
> > > order allocations (eg. for stacks) basically disappear don't they?
> >
> >
> > Yes and no, HOWEVER, nobody sane will ever use 64kB pages on a
> > general-purpose machine.
> >
> > 64kB pages are _only_ usable for databases, nothing else.
> >
> > Why? Do the math. Try to cache the whole kernel source tree in 4kB pages vs
> > 64kB pages. See how the memory usage goes up by a factor of _four_.
> >
>
> Yeah that's true. But Martin's worried about future machines
> with massive memories - so maybe it is safe to assume those will
> be using big pages, I don't know.
>

Todays massive machines are tomorrows desktop. Weak comment, I know, but
it's happened before.

> Maybe the solution is to bloat the kernel sources enough to make
> 64KB pages worthwhile?
>

root@monocle:/boot# ls -l vmlinuz-2.6.14-rc5-mm1-clean
-rw-r--r--  1 root root 1718063 2005-11-01 16:17
vmlinuz-2.6.14-rc5-mm1-clean
root@monocle:/boot# ls -l vmlinuz-2.6.14-rc5-mm1-mbuddy-v19
-rw-r--r--  1 root root 1722102 2005-11-02 14:56
vmlinuz-2.6.14-rc5-mm1-mbuddy-v19
root@monocle:/boot# dc
1722102
1718063
- p
4039

root@monocle:/boot# ls -l vmlinux-2.6.14-rc5-mm1-clean
-rwxr-xr-x  1 root root 31518866 2005-11-01 16:17
vmlinux-2.6.14-rc5-mm1-clean
root@monocle:/boot# ls -l vmlinux-2.6.14-rc5-mm1-mbuddy-v19
-rwxr-xr-x  1 root root 31585714 2005-11-02 14:56
vmlinux-2.6.14-rc5-mm1-mbuddy-v19

mel@joshua:/usr/src/patchset-0.5/kernels/linux-2.6.14-rc5-mm1-nooom$ wc -l mm/page_alloc.c
2689 mm/page_alloc.c
mel@joshua:/usr/src/patchset-0.5/kernels/linux-2.6.14-rc5-mm1-mbuddy-v19-withdefrag$  wc -l mm/page_alloc.c
3188 mm/page_alloc.c

0.23% increase in size of bzImage, 0.21% increase in the size of vmlinux
and the major increase in code size is in one file, *one* file, all of
which does it's best to impact the flow of the well-understood code. We're
seeing bigger differences in performance than we are in the size of the
kernel. I'd understand if I was the first person to ever introduce
complexity to the VM.

If the size of the image for really small systems is the issue, what if I
say I'll add in another patch that optionally compiles away as much of
anti-defrag as possible without making the code a mess of #defines .  Are
we still going to hear "no, I don't like looking at this". The current
patch to compile it away deliberately choose the smallest part to take
away to restore the allocator to todays behavior.

-- 
Mel Gorman
Part-time Phd Student                          Java Applications Developer
University of Limerick                         IBM Dublin Software Lab
