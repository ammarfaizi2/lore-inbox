Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129610AbRAWN4a>; Tue, 23 Jan 2001 08:56:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130759AbRAWN4U>; Tue, 23 Jan 2001 08:56:20 -0500
Received: from duck.doc.ic.ac.uk ([146.169.1.46]:41232 "EHLO duck.doc.ic.ac.uk")
	by vger.kernel.org with ESMTP id <S129610AbRAWN4E>;
	Tue, 23 Jan 2001 08:56:04 -0500
To: linux-kernel@vger.kernel.org
Subject: limit on number of kmapped pages
From: David Wragg <dpw@doc.ic.ac.uk>
Date: 23 Jan 2001 13:56:00 +0000
Message-ID: <y7rsnmav0cv.fsf@sytry.doc.ic.ac.uk>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.1 (Bryce Canyon)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

While testing some kernel code of mine on a machine with
CONFIG_HIGHMEM enabled, I've run into the limit on the number of pages
that can be kmapped at once.  I was surprised to find it was so low --
only 2MB/4MB of address space for kmap (according to the value of
LAST_PKMAP; vmalloc gets a much more generous 128MB!).

My code allocates a large number of pages (4MB-worth would be typical)
to act as a buffer; interrupt handlers/BHs copy data into this buffer,
then a kernel thread moves filled pages into the page cache and
replaces them with newly allocated pages.  To avoid overhead on
IRQs/BHs, all the pages in the buffer are kmapped.  But with
CONFIG_HIGHMEM if I try to kmap 512 pages or more at once, the kernel
locks up (fork() starts blocking inside kmap(), etc.).

There are ways I could work around this (either by using kmap_atomic,
or by adding another kernel thread that maintains a window of kmapped
pages within the buffer).  But I'd prefer not to have to add a lot of
code specific to the CONFIG_HIGHMEM case.

So why is LAST_PKMAP so low, and what would the consequences of
raising it be?

(I don't think kernel address space is that scarce in the
CONFIG_HIGHMEM case, so I suspect that the main reason is to limit the
amount of searching needed for kmap to find a free slot.  Is this
right?)


David Wragg
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
