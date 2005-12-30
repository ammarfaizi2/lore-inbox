Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751229AbVL3J2r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751229AbVL3J2r (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Dec 2005 04:28:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751230AbVL3J2r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Dec 2005 04:28:47 -0500
Received: from ns2.suse.de ([195.135.220.15]:55522 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751229AbVL3J2r (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Dec 2005 04:28:47 -0500
To: Jakub Jelinek <jakub@redhat.com>
Cc: Arjan van de Ven <arjan@infradead.org>,
       Christoph Hellwig <hch@infradead.org>, Ingo Molnar <mingo@elte.hu>,
       Linus Torvalds <torvalds@osdl.org>, lkml <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Matt Mackall <mpm@selenic.com>
Subject: Re: [patch 00/2] improve .text size on gcc 4.0 and newer compilers
References: <20051228114637.GA3003@elte.hu>
	<Pine.LNX.4.64.0512281111080.14098@g5.osdl.org>
	<1135798495.2935.29.camel@laptopd505.fenrus.org>
	<Pine.LNX.4.64.0512281300220.14098@g5.osdl.org>
	<20051228212313.GA4388@elte.hu> <20051228214845.GA7859@elte.hu>
	<20051229143846.GA18833@infradead.org>
	<1135868049.2935.49.camel@laptopd505.fenrus.org>
	<20051229153529.GH3811@stusta.de>
	<20051229154241.GY22293@devserv.devel.redhat.com>
From: Andi Kleen <ak@suse.de>
Date: 30 Dec 2005 10:28:34 +0100
In-Reply-To: <20051229154241.GY22293@devserv.devel.redhat.com>
Message-ID: <p73oe2zexx9.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jakub Jelinek <jakub@redhat.com> writes:
> 
> Only for static functions (and in -funit-at-a-time mode).
> Anything else would require full IMA over the whole kernel and we aren't
> there yet.  So inline hints are useful.  But most of the inline keywords
> in the kernel really should be that, hints, because e.g. while it can be
> beneficial to inline something on one arch, it may be not beneficial on
> another arch, depending on cache sizes, number of general registers
> available to the compiler, register preassure, speed of the call/ret
> pair, calling convention and many other factors.

There are important exceptions like: 

- Code that really wants to do compile time constant resolution
(like the x86 copy_*_user)  and even throws linker errors when wrong.
- Anything in a include file (otherwise it gets duplicated for
every #include which can actually increase text size a lot) 
- There is some code which absolutely needs inline in the x86-64 
vsyscall code.

But arguably they should be force_inline.

I'm not quite sure I buy Ingo's original argument also.   If he's only
looking at text size then with the above fixed then he ideally
would like to not inline anything (because except these
exceptions above .text usually near always shrinks when 
not inlining). But that's not necessarily best for performance.

-Andi
