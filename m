Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265978AbUF3DFi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265978AbUF3DFi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jun 2004 23:05:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265958AbUF3DFi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jun 2004 23:05:38 -0400
Received: from mail.shareable.org ([81.29.64.88]:62636 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S265939AbUF3DFU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jun 2004 23:05:20 -0400
Date: Wed, 30 Jun 2004 04:05:03 +0100
From: Jamie Lokier <jamie@shareable.org>
To: "Keith M. Wesolowski" <wesolows@foobazco.org>, sparclinux@vger.kernel.org,
       "David S. Miller" <davem@redhat.com>, ultralinux@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: A question about PROT_NONE on Sparc and Sparc64
Message-ID: <20040630030503.GA25149@mail.shareable.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,

I'm doing a survey of the different architectural implementations of
PROT_* flags for mmap() and mprotect().  I'm looking at linux-2.6.5.

The Sparc and Sparc64 implementations are very similar to plain x86:
read implies exec, exec implies read and write implies read.

(Aside: A comment in include/asm-sparc/pgtsrmmu.h says that finer-grained
access is possible.  Quite a few other architectures do implement
finer-grained access, and even x86 is getting it now, so you may want
to revisit that.  The code is already available, and tested, if you
cut that part out of the PaX security patch).

I see a potential bug with PROT_NONE.  I'm not sure if it's real, so
could you please confirm?  I don't know the Sparc well enough to tell.

In include/asm-sparc64/pgtable.h, there's:

#define __ACCESS_BITS   (_PAGE_ACCESSED | _PAGE_READ | _PAGE_R)
#define PAGE_NONE       __pgprot (_PAGE_PRESENT | _PAGE_ACCESSED | _PAGE_CACHE)
#define PAGE_READONLY   __pgprot (_PAGE_PRESENT | _PAGE_VALID | _PAGE_CACHE | \
                                  __ACCESS_BITS)

PAGE_NONE has the hardware _PAGE_PRESENT bit set.  However unlike
PAGE_READONLY, it doesn't have the hardware _PAGE_R and software
_PAGE_READ bits.

I guess that means that PAGE_NONE pages aren't readable from
userspace.  Presumably the TLB handler takes care of it.
Does it prevent reads from kernel space as well?

I.e. can you confirm that write() won't succeed in reading the data
from a PROT_NONE page on Sparc64?  I think that's probably the case.
You'll see why I ask, from the next one:

In include/asm-sparc/pgtsrmmu.h, there's:

#define SRMMU_PAGE_NONE    __pgprot(SRMMU_VALID | SRMMU_CACHE | \
				    SRMMU_PRIV | SRMMU_REF)
#define SRMMU_PAGE_RDONLY  __pgprot(SRMMU_VALID | SRMMU_CACHE | \
				    SRMMU_EXEC | SRMMU_REF)

This one bothers me.  The difference is that PROT_NONE pages are not
accessible to userspace, and not executable.

So userspace will get a fault if it tries to read a PROT_NONE page.

But what happens when the kernel reads one?  Don't those bits mean
that the read will succeed?  I.e. write() on a PROT_NONE page will
succeed, instead of returning EFAULT?

If so, this is a bug.  A minor bug, perhaps, but nonetheless I wish to
document it.

I don't know if you would be able to rearrange the pte bits so that a
PROT_NONE page is not accessible to the kernel either.  E.g. on i386
this is done by making PROT_NONE not set the "physical" present bit
but a different bit, and "pte_present()" tests both of those bits to
test the virtual present bit.

Alternatively, perhaps in this case simply omitting the SRMMU_REF bit
would be enough?  Would that cause the TLB handler to be entered, and
the TLB handler could then refuse access?  Again, I don't know enough
about Sparc to say more.

Looking at pgtsun4.h and pgtsun4c.h, I'm not sure about those either.

Thanks,
-- Jamie
