Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261228AbUJ3RxR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261228AbUJ3RxR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Oct 2004 13:53:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261231AbUJ3RxQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Oct 2004 13:53:16 -0400
Received: from fw.osdl.org ([65.172.181.6]:37794 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261228AbUJ3RxI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Oct 2004 13:53:08 -0400
Date: Sat, 30 Oct 2004 10:53:01 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: Semaphore assembly-code bug
In-Reply-To: <200410301228.42561.vda@port.imtp.ilyichevsk.odessa.ua>
Message-ID: <Pine.LNX.4.58.0410301040050.28839@ppc970.osdl.org>
References: <417550FB.8020404@drdos.com.suse.lists.linux.kernel>
 <Pine.LNX.4.58.0410291133220.28839@ppc970.osdl.org.suse.lists.linux.kernel>
 <p73sm7xymvd.fsf@verdi.suse.de> <200410301228.42561.vda@port.imtp.ilyichevsk.odessa.ua>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 30 Oct 2004, Denis Vlasenko wrote:
>
> On Saturday 30 October 2004 05:13, Andi Kleen wrote:
> > Linus Torvalds <torvalds@osdl.org> writes:
> > 
> > > Anyway, it's quite likely that for several CPU's the fastest sequence ends 
> > > up actually being 
> > > 
> > > 	movl 4(%esp),%ecx
> > > 	movl 8(%esp),%edx
> > > 	movl 12(%esp),%eax
> > > 	addl $16,%esp
> > > 
> > > which is also one of the biggest alternatives.
> > 
> > For K8 it should be the fastest way. K7 probably too.
> 
> Pity. I always loved 1 byte insns :)

I personally am a _huge_ believer in small code. 

The sequence

	popl %eax
	popl %ecx
	popl %edx
	popl %eax

is four bytes. In contrast, the three moves and an add is 15 bytes. That's 
almost 4 times as big.

And size _does_ matter. The extra 11 bytes means that if you have six of
these sequences in your program, you are pretty much _guaranteed_ one more
icache miss from memory. That's a few hundred cycles these days.  
Considering that you _maybe_ won a cycle or two each time it was executed,
it's not at all clear that it's a win, except in benchmarks that have huge
repeat-rates. Real life doesn't usually have that. In many real-life
schenarios, repeat rates are in the tens of hundreds for most code...

And that's ignoring things like disk load times etc.

Sadly, the situation is often one where when you actually do all the 
performance testing, you artificially increase the repeat-rates hugely: 
you run the same program a thousand times in order to get a good profile, 
and you keep in the the cache all the time. So performance analysis often 
doesn't actually _see_ the downsides.

			Linus
