Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261448AbUJaAkP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261448AbUJaAkP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Oct 2004 20:40:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261450AbUJaAkP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Oct 2004 20:40:15 -0400
Received: from cantor.suse.de ([195.135.220.2]:20915 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261448AbUJaAkI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Oct 2004 20:40:08 -0400
Date: Sun, 31 Oct 2004 02:39:34 +0200
From: Andi Kleen <ak@suse.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
       Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: Semaphore assembly-code bug
Message-ID: <20041031003934.GA19396@wotan.suse.de>
References: <417550FB.8020404@drdos.com.suse.lists.linux.kernel> <Pine.LNX.4.58.0410291133220.28839@ppc970.osdl.org.suse.lists.linux.kernel> <p73sm7xymvd.fsf@verdi.suse.de> <200410301228.42561.vda@port.imtp.ilyichevsk.odessa.ua> <Pine.LNX.4.58.0410301040050.28839@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0410301040050.28839@ppc970.osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I personally am a _huge_ believer in small code. 
> 
> The sequence
> 
> 	popl %eax
> 	popl %ecx
> 	popl %edx
> 	popl %eax
> 
> is four bytes. In contrast, the three moves and an add is 15 bytes. That's 
> almost 4 times as big.

Using the long stack setup code was found to be a significant
win when enough registers were saved (several percent in real benchmarks) 
on K8 gcc. It speed up all function calls considerably because it 
eliminates several stalls for each function entry/exit.  The popls
will all depend on each other because of their implicied reference
to esp.  

Yes, it bloats the code, but function calls happen so often that having them
faster is really noticeable. 

The K8 has quite big caches and is not decoding limited, so it 
wasn't a too bad tradeoff there.

Ideally you would want to only do it on hot functions and optimize
rarely called functions for code size, but that would require profile 
feedback which is often not feasible (JITs have an advantage here) 

Unfortunately I don't think it is practically feasible for the kernel because
we rely on to be able to recreate the same vmlinuxs for debugging.
[It's a pity actually because modern compilers do a lot better
with profile feedback] 

On P4 on the other hand it doesn't help at all and only makes
the code bigger. I did it from hand in the x86-64 syscall
code too (that was before there was EM64T, but I still think it was a 
good idea). Perhaps AMD adds special hardware in some future CPU that
also makes it unnecessary, but currently it's like this and it helps.

-Andi

