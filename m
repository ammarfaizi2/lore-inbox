Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129825AbRAWTOx>; Tue, 23 Jan 2001 14:14:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130017AbRAWTOn>; Tue, 23 Jan 2001 14:14:43 -0500
Received: from slc952.modem.xmission.com ([166.70.6.190]:47119 "EHLO
	flinx.biederman.org") by vger.kernel.org with ESMTP
	id <S129825AbRAWTOb>; Tue, 23 Jan 2001 14:14:31 -0500
To: David Wragg <dpw@doc.ic.ac.uk>
Cc: linux-kernel@vger.kernel.org, <linux-mm@kvack.org>
Subject: Re: limit on number of kmapped pages
In-Reply-To: <y7rsnmav0cv.fsf@sytry.doc.ic.ac.uk>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 23 Jan 2001 11:23:46 -0700
In-Reply-To: David Wragg's message of "23 Jan 2001 13:56:00 +0000"
Message-ID: <m1r91udt59.fsf@frodo.biederman.org>
User-Agent: Gnus/5.0803 (Gnus v5.8.3) Emacs/20.5
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Wragg <dpw@doc.ic.ac.uk> writes:

> While testing some kernel code of mine on a machine with
> CONFIG_HIGHMEM enabled, I've run into the limit on the number of pages
> that can be kmapped at once.  I was surprised to find it was so low --
> only 2MB/4MB of address space for kmap (according to the value of
> LAST_PKMAP; vmalloc gets a much more generous 128MB!).

kmap is for quick transitory mappings.  kmap is not for permanent mappings.
At least that was my impression.  The persistence is intended to just
kill error prone cases.

> My code allocates a large number of pages (4MB-worth would be typical)
> to act as a buffer; interrupt handlers/BHs copy data into this buffer,
> then a kernel thread moves filled pages into the page cache and
> replaces them with newly allocated pages.  To avoid overhead on
> IRQs/BHs, all the pages in the buffer are kmapped.  But with
> CONFIG_HIGHMEM if I try to kmap 512 pages or more at once, the kernel
> locks up (fork() starts blocking inside kmap(), etc.).

This may be a reasonable use, I'm not certain.  It wasn't the application
kmap was designed to deal with though...
 
> There are ways I could work around this (either by using kmap_atomic,
> or by adding another kernel thread that maintains a window of kmapped
> pages within the buffer).  But I'd prefer not to have to add a lot of
> code specific to the CONFIG_HIGHMEM case.

Why do you need such a large buffer?  And why do the pages need to be kmapped?
If you are doing dma there is no such requirement...  And unless you are
running on something faster than a PCI bus I can't imagine why you need
a buffer that big.  My hunch is that it makes sense to do the kmap,
and the i/o in the bottom_half.  What is wrong with that?

kmap should be quick and fast because it is for transitory mappings.
It shouldn't be something whose overhead you are trying to avoid.
If kmap is that expensive then kmap needs to be fixed, instead
of your code working around a perceived problem.

At least that is what it looks like from here.

Eric
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
