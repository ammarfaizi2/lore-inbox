Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261471AbUJaCFk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261471AbUJaCFk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Oct 2004 22:05:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261470AbUJaCFM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Oct 2004 22:05:12 -0400
Received: from cantor.suse.de ([195.135.220.2]:14057 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261468AbUJaCEt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Oct 2004 22:04:49 -0400
Date: Sun, 31 Oct 2004 03:04:48 +0100
From: Andi Kleen <ak@suse.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andi Kleen <ak@suse.de>,
       Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
       linux-kernel@vger.kernel.org
Subject: Re: Semaphore assembly-code bug
Message-ID: <20041031020448.GG19396@wotan.suse.de>
References: <417550FB.8020404@drdos.com.suse.lists.linux.kernel> <Pine.LNX.4.58.0410291133220.28839@ppc970.osdl.org.suse.lists.linux.kernel> <p73sm7xymvd.fsf@verdi.suse.de> <200410301228.42561.vda@port.imtp.ilyichevsk.odessa.ua> <Pine.LNX.4.58.0410301040050.28839@ppc970.osdl.org> <20041031003934.GA19396@wotan.suse.de> <Pine.LNX.4.58.0410301831300.28839@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0410301831300.28839@ppc970.osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 30, 2004 at 06:43:21PM -0700, Linus Torvalds wrote:
> 
> 
> On Sun, 31 Oct 2004, Andi Kleen wrote:
> > 
> > Using the long stack setup code was found to be a significant
> > win when enough registers were saved (several percent in real benchmarks) 
> > on K8 gcc. 
> 
> For _what_?
> 
> Real applications, or SpecInt?

iirc gcc itself was faster (the modern one,  not the old version in SpecInt) 

KDE startup ended up being faster too, but that may have been due to other
improvements too.

This was all tested on CPUs with very large caches (1MB L2), you
can pack a lot of code into that.

Also when people benchmark -m64 code compared to -m32 they often
see large improvements on AMD64 (as long as the code isn't long or pointer
memory bound), and I suspect at least part of that can be explained
by the -m64 gcc defaulting to the long function prologues.

Another example of larger code usually being better is x87 vs SSE2 floating
point math. 

> The fact is, SpecInt is not very interesting, because it has almost _zero_
> icache footprint, and it has generally big repeat-rates, and to make

I don't think it's generally true. one counter example is the gcc subtest
in SpecInt. 


> >  It speed up all function calls considerably because it 
> > eliminates several stalls for each function entry/exit. 
> 
> .. it shaves off a few cycles in the cached case, yes.

I would expect it to help in the uncached case too because
the CPU does very aggressive prefetching of code. Once 
it gets started on a function it will fetch it very quickly.

> 
> > The popls will all depend on each other because of their implicied
> > reference to esp.
> 
> Which is only true on moderately stupid CPU's. Two pop's don't _really_ 

I don't see the K8 as a stupid CPU.

> depend on each other in any real sense, and there are CPU's that will 
> happily dual-issue them, or at least not stall in between (ie the pop's 
> will happily keep the memory unit 100% busy).

Yes, there are. And there are others that don't.

-Andi
