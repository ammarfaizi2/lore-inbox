Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261838AbVANBNM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261838AbVANBNM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 20:13:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261837AbVANBKa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 20:10:30 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:48530 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S261752AbVANBJY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 20:09:24 -0500
Date: Thu, 13 Jan 2005 17:09:04 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
X-X-Sender: clameter@schroedinger.engr.sgi.com
To: Andi Kleen <ak@muc.de>
cc: Nick Piggin <nickpiggin@yahoo.com.au>, Andrew Morton <akpm@osdl.org>,
       torvalds@osdl.org, hugh@veritas.com, linux-mm@kvack.org,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
       benh@kernel.crashing.org
Subject: Re: page table lock patch V15 [0/7]: overview
In-Reply-To: <20050113180205.GA17600@muc.de>
Message-ID: <Pine.LNX.4.58.0501131701150.21743@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.58.0501120833060.10380@schroedinger.engr.sgi.com>
 <20050112104326.69b99298.akpm@osdl.org> <41E5AFE6.6000509@yahoo.com.au>
 <20050112153033.6e2e4c6e.akpm@osdl.org> <41E5B7AD.40304@yahoo.com.au>
 <Pine.LNX.4.58.0501121552170.12669@schroedinger.engr.sgi.com>
 <41E5BC60.3090309@yahoo.com.au> <Pine.LNX.4.58.0501121611590.12872@schroedinger.engr.sgi.com>
 <20050113031807.GA97340@muc.de> <Pine.LNX.4.58.0501130907050.18742@schroedinger.engr.sgi.com>
 <20050113180205.GA17600@muc.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Jan 2005, Andi Kleen wrote:

> On Thu, Jan 13, 2005 at 09:11:29AM -0800, Christoph Lameter wrote:
> > On Wed, 13 Jan 2005, Andi Kleen wrote:
> >
> > > Alternatively you can use a lazy load, checking for changes.
> > > (untested)
> > >
> > > pte_t read_pte(volatile pte_t *pte)
> > > {
> > > 	pte_t n;
> > > 	do {
> > > 		n.pte_low = pte->pte_low;
> > > 		rmb();
> > > 		n.pte_high = pte->pte_high;
> > > 		rmb();
> > > 	} while (n.pte_low != pte->pte_low);
> > > 	return pte;

I think this is not necessary. Most IA32 processors do 64
bit operations in an atomic way in the same way as IA64. We can cut out
all the stuff we put in to simulate 64 bit atomicity for i386 PAE mode if
we just use convince the compiler to use 64 bit fetches and stores. 486
cpus and earlier are the only ones unable to do 64 bit atomic ops but
those wont be able to use PAE mode anyhow.

Page 231 of Volume 3 of the Intel IA32 manual states regarding atomicity
of operations:

7.1.1. Guaranteed Atomic Operations

The Pentium 4, Intel Xeon, P6 family, Pentium, and Intel486 processors
guarantee that the following basic memory operations will always be
carried out atomically:

o reading or writing a byte
o reading or writing a word aligned on a 16-bit boundary
o reading or writing a doubleword aligned on a 32-bit boundary

The Pentium 4, Intel Xeon, and P6 family, and Pentium processors guarantee
that the following additional memory operations will always be carried out
atomically:

o reading or writing a quadword aligned on a 64-bit boundary
o 16-bit accesses to uncached memory locations that fit within a 32-bit data bus
o The P6 family processors guarantee that the following additional memory
operation will always be carried out atomically:
o unaligned 16-, 32-, and 64-bit accesses to cached memory that fit
within a 32-byte cache

.... off to look for 64bit store and load instructions in the intel
manuals. I feel much better about keeping the existing approach.
