Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265534AbUF3Coo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265534AbUF3Coo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jun 2004 22:44:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265874AbUF3Con
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jun 2004 22:44:43 -0400
Received: from mail.shareable.org ([81.29.64.88]:60844 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S265534AbUF3Col
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jun 2004 22:44:41 -0400
Date: Wed, 30 Jun 2004 03:44:34 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Ian Molton <spyro@f2s.com>, Russell King <rmk@arm.linux.org.uk>,
       linux-arm-kernel@lists.arm.linux.org.uk
Cc: linux-kernel@vger.kernel.org
Subject: A question about PROT_NONE on ARM and ARM26
Message-ID: <20040630024434.GA25064@mail.shareable.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,

I'm doing a survey of the different architectural implementations of
PROT_* flags for mmap() and mprotect().  I'm looking at linux-2.6.5.

The ARM and ARM26 implementations are very similar to plain x86: read
implies exec, exec implies read and write implies read.

But I see a potential bug with PROT_NONE.  I'm not sure if it's real,
so could you please confirm?

In include/asm-arm26/pgtable.h, I see this (reindented for mail):

#define PAGE_NONE \
       __pgprot(_PAGE_PRESENT | _PAGE_CLEAN | _PAGE_READONLY | _PAGE_NOT_USER)
#define PAGE_READONLY \
       __pgprot(_PAGE_PRESENT | _PAGE_CLEAN | _PAGE_READONLY                 )

In include/asm-arm/pgtable.h, I see this (reindented for mail):

#define _L_PTE_DEFAULT \
        L_PTE_PRESENT | L_PTE_YOUNG | L_PTE_CACHEABLE | L_PTE_BUFFERABLE
#define _L_PTE_READ \
        L_PTE_USER | L_PTE_EXEC
#define PAGE_NONE \
        __pgprot(_L_PTE_DEFAULT)
#define PAGE_READONLY
        __pgprot(_L_PTE_DEFAULT | _L_PTE_READ)

Apparently the difference between PAGE_NONE and PAGE_READONLY, in each
case, is that PAGE_NONE is not readable from userspace but _is_
readable from kernel space.

Therefore all user accesses to a PROT_NONE page will cause a fault.

My question is: if the _kernel_ reads a PROT_NONE page, will it fault?
It looks likely to me.

This means that calling write() with a PROT_NONE region would succeed,
wouldn't it?

If so, this is a bug.  A minor bug, perhaps, but nonetheless I wish to
document it.

I don't know if you would be able to rearrange the pte bits so that a
PROT_NONE page is not accessible to the kernel either.  E.g. on i386
this is done by making PROT_NONE not set the hardware's present bit
but a different bit, and "pte_present()" tests both of those bits to
test the virtual present bit.

Thanks,
-- Jamie
