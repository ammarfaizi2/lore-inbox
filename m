Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266294AbUF3DTm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266294AbUF3DTm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jun 2004 23:19:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266292AbUF3DTl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jun 2004 23:19:41 -0400
Received: from mail.shareable.org ([81.29.64.88]:64172 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S266277AbUF3DTK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jun 2004 23:19:10 -0400
Date: Wed, 30 Jun 2004 04:18:22 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       linuxppc-dev@lists.linuxppc.org, Anton Blanchard <anton@au.ibm.com>,
       linuxppc64-dev@lists.linuxppc.org
Cc: linux-kernel@vger.kernel.org
Subject: A question about PROT_NONE on PPC and PPC64
Message-ID: <20040630031821.GB25149@mail.shareable.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,

I'm doing a survey of the different architectural implementations of
PROT_* flags for mmap() and mprotect().  I'm looking at linux-2.6.5.

The PPC and PPC64 implementations are very similar to plain x86:
read implies exec, exec implies read and write implies read.

(Aside: Is the patch for making exec permission separate on its way
into the tree?)

I see a potential bug with PROT_NONE.  I'm not sure if it's real, so
could you please confirm?

PPC32
=====

In include/asm-ppc/pgtable.h, there's:

#define PAGE_NONE	__pgprot(_PAGE_BASE)
#define PAGE_READONLY	__pgprot(_PAGE_BASE | _PAGE_USER)

It appears the only difference betwen PROT_READ and PROT_NONE is
whether _PAGE_USER is set.

Thus PROT_NONE pages aren't readable from userspace, but it appears
they _are_ readable from kernel space.  Is this correct?

This means that calling write() with a PROT_NONE region would succeed,
instead of returning EFAULT as it should, wouldn't it?

If so, this is a bug.  A minor bug, perhaps, but nonetheless I wish to
document it.

I don't know if you would be able to rearrange the pte bits so that a
PROT_NONE page is not accessible to the kernel either.  E.g. on i386
this is done by making PROT_NONE not set the hardware's present bit
but a different bit, and "pte_present()" tests both of those bits to
test the virtual present bit.

PPC64
=====

In include/asm-ppc64/pgtable.h, there's:

#define _PAGE_BASE	(_PAGE_PRESENT | _PAGE_ACCESSED | _PAGE_COHERENT)
#define PAGE_NONE	__pgprot(_PAGE_PRESENT | _PAGE_ACCESSED)
#define PAGE_READONLY	__pgprot(_PAGE_BASE | _PAGE_USER)

This looks very similar to PPC32: the main difference between
PROT_NONE and PROT_READ appears to be the _PAGE_USER flag.

So does this mean that PROT_NONE pages, although they aren't readable
from userspace, are readable from kernel space?  I.e. that write()
with a PROT_NONE region would succeed, instead of returning EFAULT as
it should?

I don't know whether the _PAGE_COHERENT flag is significant here.
Perhaps you use it in some clever way in the TLB handler to prevent
these pages from being present in the TLB?

Thanks,
-- Jamie
