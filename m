Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269471AbUIZAtz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269471AbUIZAtz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Sep 2004 20:49:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269462AbUIZArw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Sep 2004 20:47:52 -0400
Received: from mail-relay-3.tiscali.it ([213.205.33.43]:45768 "EHLO
	mail-relay-3.tiscali.it") by vger.kernel.org with ESMTP
	id S269467AbUIZArc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Sep 2004 20:47:32 -0400
Date: Sun, 26 Sep 2004 02:46:08 +0200
From: Andrea Arcangeli <andrea@novell.com>
To: Rik van Riel <riel@redhat.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       "Martin J. Bligh" <mbligh@aracnet.com>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: ptep_establish/establish_pte needs set_pte_atomic and all set_pte must be written in asm
Message-ID: <20040926004608.GS3309@dualathlon.random>
References: <20040926002037.GP3309@dualathlon.random> <Pine.LNX.4.44.0409252030260.28582-100000@chimarrao.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0409252030260.28582-100000@chimarrao.boston.redhat.com>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 25, 2004 at 08:31:13PM -0400, Rik van Riel wrote:
> On Sun, 26 Sep 2004, Andrea Arcangeli wrote:
> 
> > But even ppc64 is wrong as far as C is concerned,
> 
> Looks fine to me.  From include/asm-ppc64/pgtable.h
> 
> static inline void set_pte(pte_t *ptep, pte_t pte)
> {
>         if (pte_present(*ptep)) {
>                 pte_clear(ptep);
>                 flush_tlb_pending();
>         }
>         *ptep = __pte(pte_val(pte)) & ~_PAGE_HPTEFLAGS;
> }

As far as the C language is concerned that *ptep = something can be
implemented with 8 writes of 1 byte each (or alternatively with an
assembler instruction that may make the written data visible not
atomically to other cpus, despite it was written with a single opcode,
similarly to what happens if you use incl without the lock prefix). I'm
not saying such instruction exists in ppc64, but the compiler is
definitely allowed to break the above. You can blame on the compiler to
be inefficient, but you can't blame on the compiler for the security
hazard it would generate. Only the kernel would be to blame if for
whatever reason a gcc version would be underoptimized.

I perfectly know in practice the above is "almost guaranteed" to work,
it's just the "almost" that's not good enough for me ;)

anyways this is just a corollary to the x86 true bug, where a smp_wmb()
sits in between the two separate writes, which makes the x86 set_pte
obviously not atomic even in practice (not just in theory like for
ppc64 and all other archs). I thought it was better to fix the
theoretical bugs too, and they are true bugs as far as the C language is
concerned, even if they're not triggering with the current gcc
implementation of the language (and with any other decent compiler ;).
