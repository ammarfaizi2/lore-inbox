Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266768AbUI0Qog@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266768AbUI0Qog (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Sep 2004 12:44:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266753AbUI0Qog
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Sep 2004 12:44:36 -0400
Received: from mail-relay-2.tiscali.it ([213.205.33.42]:36277 "EHLO
	mail-relay-2.tiscali.it") by vger.kernel.org with ESMTP
	id S266798AbUI0Qn5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Sep 2004 12:43:57 -0400
Date: Mon, 27 Sep 2004 18:41:54 +0200
From: Andrea Arcangeli <andrea@novell.com>
To: Paul Mackerras <paulus@samba.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Rik van Riel <riel@redhat.com>, "Martin J. Bligh" <mbligh@aracnet.com>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: ptep_establish/establish_pte needs set_pte_atomic and all set_pte must be written in asm
Message-ID: <20040927164154.GM28865@dualathlon.random>
References: <20040926002037.GP3309@dualathlon.random> <Pine.LNX.4.44.0409252030260.28582-100000@chimarrao.boston.redhat.com> <20040926004608.GS3309@dualathlon.random> <1096160383.18233.67.camel@gaston> <16727.9953.113125.387097@cargo.ozlabs.ibm.com> <20040926203640.GR2499@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040926203640.GR2499@dualathlon.random>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 26, 2004 at 10:36:40PM +0200, Andrea Arcangeli wrote:
> On Mon, Sep 27, 2004 at 06:30:25AM +1000, Paul Mackerras wrote:
> > FWIW, we also rely on several other things that are not guaranteed by
> > the C standard, for instance that integer arithmetic is 2's
> > complement, that bytes are individually addressable, and that pointers
> > are represented by an address that is no bigger than a long.
> 
> I wouldn't compare these with atomic writes on non volatile variables. I
> mean, sizeof(char *) being different than sizeof(long) is something I'm
> very confortable will not break anytime. If you want to add up to the
> list, even the gcc inline assembly itself isn't part of the language...
> (infact that was the major trouble for icc to add it AFIK)

Just to make an example of why you definitely cannot compare the
assumption of sizeof(char *) == sizeof(long), and complement 2
aritmetic, is that gcc is allowed to implement something like this:

	*64bit_ptr = 32bit_integer_var << 32;

as two instructions: xorl and a movl, that is likely to be faster than a
shiftleft + movq. Or maybe it's not faster on the x86-64 and gcc may
prefer to use shiftleft + movq, but you get the idea of what I'm talking
about, maybe for other archs the performance point is different etc...
(by instinct I believe it'd be faster even on x86, especially on the
nocona based on p4 core)

with the ptes on x86 the shiftleft of 12 probably avoid screwups but
that's just because we're lucky and I don't want to think what else gcc
could optimize by evaluating constants...
