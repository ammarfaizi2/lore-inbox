Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269474AbUIZBh1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269474AbUIZBh1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Sep 2004 21:37:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269477AbUIZBh1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Sep 2004 21:37:27 -0400
Received: from mail-relay-1.tiscali.it ([213.205.33.41]:12256 "EHLO
	mail-relay-1.tiscali.it") by vger.kernel.org with ESMTP
	id S269474AbUIZBhG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Sep 2004 21:37:06 -0400
Date: Sun, 26 Sep 2004 03:36:37 +0200
From: Andrea Arcangeli <andrea@novell.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Rik van Riel <riel@redhat.com>, "Martin J. Bligh" <mbligh@aracnet.com>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: ptep_establish/establish_pte needs set_pte_atomic and all set_pte must be written in asm
Message-ID: <20040926013637.GU3309@dualathlon.random>
References: <20040926002037.GP3309@dualathlon.random> <Pine.LNX.4.44.0409252030260.28582-100000@chimarrao.boston.redhat.com> <20040926004608.GS3309@dualathlon.random> <1096160383.18233.67.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1096160383.18233.67.camel@gaston>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 26, 2004 at 10:59:43AM +1000, Benjamin Herrenschmidt wrote:
> On Sun, 2004-09-26 at 10:46, Andrea Arcangeli wrote:
> 
> > As far as the C language is concerned that *ptep = something can be
> > implemented with 8 writes of 1 byte each (or alternatively with an
> > assembler instruction that may make the written data visible not
> > atomically to other cpus, despite it was written with a single opcode,
> > similarly to what happens if you use incl without the lock prefix). I'm
> > not saying such instruction exists in ppc64, but the compiler is
> > definitely allowed to break the above. You can blame on the compiler to
> > be inefficient, but you can't blame on the compiler for the security
> > hazard it would generate. Only the kernel would be to blame if for
> > whatever reason a gcc version would be underoptimized.
> 
> BTW, for your reading pleasure :)
> 
> #define atomic_set(v,i)		(((v)->counter) = (i))
> 
> (asm-i386/atomic.h)

and then check this:

typedef struct { volatile int counter; } atomic_t;
		 ^^^^^^^^

if the pte was at least volatile it would be a lot safer. C knows it
must not mess with volatile.

> And that's really far from beeing the 2 only cases where the kernel _relies_
> on a write of a simple type like int or long to an aligned location to be
> atomic. Almost all drivers manipulating DMA descriptors do that, jiffies
> is a good example too afaik, and more and more and more ... so if the

jiffies, writel/readl all volatile incidentally.

> compiler is breaking that up, I think the set_pte race is the least of
> our problems :)

the only one not volatile, or can you find more?
