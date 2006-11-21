Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030885AbWKULiJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030885AbWKULiJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Nov 2006 06:38:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030887AbWKULiJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Nov 2006 06:38:09 -0500
Received: from pfx2.jmh.fr ([194.153.89.55]:42713 "EHLO pfx2.jmh.fr")
	by vger.kernel.org with ESMTP id S1030885AbWKULiG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Nov 2006 06:38:06 -0500
From: Eric Dumazet <dada1@cosmosbay.com>
To: Andi Kleen <ak@suse.de>
Subject: Re: [PATCH] i386-pda UP optimization
Date: Tue, 21 Nov 2006 12:38:20 +0100
User-Agent: KMail/1.9.5
Cc: Ingo Molnar <mingo@elte.hu>, akpm@osdl.org,
       Arjan van de Ven <arjan@infradead.org>,
       Jeremy Fitzhardinge <jeremy@goop.org>, linux-kernel@vger.kernel.org
References: <1158046540.2992.5.camel@laptopd505.fenrus.org> <200611151824.36198.ak@suse.de> <200611151846.31109.dada1@cosmosbay.com>
In-Reply-To: <200611151846.31109.dada1@cosmosbay.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611211238.20419.dada1@cosmosbay.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 15 November 2006 18:46, Eric Dumazet wrote:
> On Wednesday 15 November 2006 18:24, Andi Kleen wrote:
> > On Wednesday 15 November 2006 18:20, Ingo Molnar wrote:
> > > * Andi Kleen <ak@suse.de> wrote:
> > > > On Wednesday 15 November 2006 12:27, Eric Dumazet wrote:
> > > > > Seeing %gs prefixes used now by i386 port, I recalled seeing
> > > > > strange oprofile results on Opteron machines.
> > > > >
> > > > > I really think %gs prefixes can be expensive in some (most ?)
> > > > > cases, even if the Intel/AMD docs say they are free.
> > > >
> > > > They aren't free, just very cheap.
> > >
> > > Eric's test shows a 5% slowdown. That's far from cheap.
> >
> > I have my doubts about the accuracy of his test results. That is why I
> > asked him to double check.
>
> Fair enough :)
>
> I plan doing *lot* of tests as soon as possible (not possible during
> daytime unfortunately, I miss a dev machine)
>

I did *lot* of reboots of my Dell D610 machine, with some trivial benchmarks 
using : pipe/write()/read, umask(), or getppid(), using or not oprofile.

I managed to avoid reloading %gs in sysenter_entry .
(avoiding the two instructions : movl $(__KERNEL_PDA), %edx; movl %edx, %gs

I could not avoid reloading %gs in system_call, I dont know why, but modern 
glibc use sysenter so I dont care :)

I confirm I got better results with my patched kernel in all tests I've done.

umask : 12.64 s instead of 12.90 s
getppid : 13.37 s instead of 13.72 s
pipe/read/write : 9.10 s instead of 9.52 s

(I got very different results in umask() bench, patching it not to use xchg(), 
since this instruction is expensive on x86 and really change oprofile 
results. I will submit a patch for this.

Eric
