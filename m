Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261606AbUDCRGz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Apr 2004 12:06:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261551AbUDCRGy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Apr 2004 12:06:54 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:23129 "EHLO
	MTVMIME01.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S261606AbUDCRGu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Apr 2004 12:06:50 -0500
Date: Sat, 3 Apr 2004 18:06:49 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Andrea Arcangeli <andrea@suse.de>
cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       <linux-kernel@vger.kernel.org>
Subject: Re: anon-vma (and now filebacked-mappings too) mprotect vma merging
    [Re:    2.6.5-rc2-aa vma merging]
In-Reply-To: <20040403012612.GY21341@dualathlon.random>
Message-ID: <Pine.LNX.4.44.0404031727320.10197-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 3 Apr 2004, Andrea Arcangeli wrote:
> On Fri, Apr 02, 2004 at 12:34:29PM +0100, Hugh Dickins wrote:
> > Sorry to be boring, Andrea, but 2.6.5-rc3-aa2 is now out, and you
> > have still not fixed the vma merging issue: I don't believe you can.
> 
> here we go with the mprotect merging, try this on top of 2.6.5-rc3-aa2.

Thank you!  It works.  You've surprised me again.  Forgive me.

It's a bit erratic, test program below you'd expect to end up with one
vma of 4 pages at 0x80000000, whereas it ends up with one of 1 and one
of 3 (where mainline ends up with two of 2); but that's just an
implementation detail which obviously can be smoothed away later.
Presumably it should be looking to merge, or propagating anon_vma
to/from adjacent vma, somewhere else too.

It does look more complicated than I'd hoped, a lot of that coming from
the file-backed merging: which I like, but, we could have done it at
any point over the last couple of years if someone had a need for it.
Fair enough, you've discovered a need, at the same time that you have
to attend to vm_pgoff for anons, so it makes sense to do them together.

Do you realize that you could allocate just a single anon_vma to
the mm at fork time, for all the pure anon vmas created in it later?
And then no need for propagating anon_vma from adjacent vma, they'd
all have the right one already and be mergeable anyway.  But I think
you'll reject that on two grounds: you want to merge the file-backed
vmas as much as is reasonable, so you need the code anyway for them;
and you'd prefer your anon_vma lists to be as short as possible, to
minimize searching at page_referenced/try_to_unmap time.

Clearly there's a tension between keeping the anon_vma lists short,
and leaving the vmas mergable: it's natural that we should differ on
where to strike that balance, having come to it from opposite ends.

I still prefer my simpler anonmm solution (will post the prio tree
patch on top of it later this evening), but I don't see any good
reason now to oppose your anon_vma solution.  Let others decide.

Hugh

#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/mman.h>

#define PAGE_SIZE	4096
#define MAP_AREA	((void *) 0x80000000)

int main(int argc, char *argv[])
{
	unsigned long pageno = 0;
	unsigned long *ptr;
	char buf[40];

	ptr = mmap(MAP_AREA, 2*PAGE_SIZE, PROT_READ,
			MAP_PRIVATE|MAP_ANONYMOUS|MAP_FIXED, -1, 0);
	if (ptr == MAP_FAILED)
		exit(1);
	ptr = mmap(MAP_AREA + 2*PAGE_SIZE, 2*PAGE_SIZE, PROT_READ|PROT_WRITE,
			MAP_PRIVATE|MAP_ANONYMOUS|MAP_FIXED, -1, 0);
	if (ptr == MAP_FAILED)
		exit(1);
	ptr = MAP_AREA;
	while (pageno < 4) {
		if (mprotect(ptr, PAGE_SIZE, PROT_READ|PROT_WRITE) == -1)
			exit(1);
		*ptr = pageno++;
		if (mprotect(ptr, PAGE_SIZE, PROT_READ) == -1)
			exit(1);
		ptr += PAGE_SIZE / sizeof(unsigned long);
	}
	sprintf(buf, "cat /proc/%d/maps", getpid());
	system(buf);
	exit(0);
}

