Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265345AbUATKqz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jan 2004 05:46:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265351AbUATKqz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jan 2004 05:46:55 -0500
Received: from kluizenaar.xs4all.nl ([213.84.184.247]:13395 "EHLO samwel.tk")
	by vger.kernel.org with ESMTP id S265345AbUATKqw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jan 2004 05:46:52 -0500
Message-ID: <400D070B.2070407@samwel.tk>
Date: Tue, 20 Jan 2004 11:46:35 +0100
From: Bart Samwel <bart@samwel.tk>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031221 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Robin Rosenberg <robin.rosenberg.lists@dewire.com>,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Compiling C++ kernel module + Makefile
References: <20040116210924.61545.qmail@web12008.mail.yahoo.com> <400C37E3.5020802@samwel.tk> <Pine.LNX.4.53.0401191521400.8389@chaos> <200401200159.22693.robin.rosenberg.lists@dewire.com> <Pine.LNX.4.58.0401192241080.2311@home.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0401192241080.2311@home.osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> The fact is, C++ compilers are not trustworthy. They were even worse in 
> 1992, but some fundamental facts haven't changed:
> 
>  - the whole C++ exception handling thing is fundamentally broken. It's 
>    _especially_ broken for kernels.

I second that. The basic reason the C++ exception handling mechanism is 
broken is because of what happens when an exception is thrown from a 
destructor, during a stack unwind caused by an exception. There are 
paths of exception/destructor combinations that you just cannot get out 
of correctly. This is perfectly OK for most userland apps, but for 
kernels it's definitely not OK.

>  - any compiler or language that likes to hide things like memory
>    allocations behind your back just isn't a good choice for a kernel.

True, when you're doing code that requires locking etc. you don't want a 
destructor coming in and deallocating something that you haven't locked. 
I don't see when C++ can hide memory *allocations* though, any more than 
C can hide them behind trees of function calls.

>  - you can write object-oriented code (useful for filesystems etc) in C, 
>    _without_ the crap that is C++.

True, C++ _is_ full of crap -- that's what C++ lovers refer to as 
"power". For work, I program in C++, and I love it because of the power 
of expression. I hate it because of the amount of rope it gives me to 
hang myself with. And because most C++ compilers are _so_ immature. 
Still, OO can be written in C (cfront does it :) ) but it's not always 
convenient. Especially when you're doing inheritance-like things, your C 
code will be sprinkled with casts (neatly hidden in macros, probably), 
and no C compiler will typecheck that. More static checking is good, I'd 
say, so there might be reasons to do C++ if you might otherwise get 
bogged down in a sea of casts.

> In general, I'd say that anybody who designs his kernel modules for C++ is 
> either 
>  (a) looking for problems

Mostly true, I guess. But sometimes, if you stick to a wisely chosen 
subset, it can work out OK. For instance, exceptions should not be used. 
Destructors become much less of a problem when you rule out exceptions, 
and especially when combined it with lock objects for the locks. And it 
is very well possible to write C++ that is low on allocations, like 
kernel code should be. I think writing kernel code in C is also looking 
for problems, unless you know exactly what you're doing -- in that 
respect, it's pretty much the same.

>  (b) a C++ bigot that can't see what he is writing is really just C anyway

This argument can, of course, be made for any language. In that case, 
the kernel developers' community can be said to be made up from C bigots 
that can't see that what they are writing is really just asm anyway. :)

Anyway, I can definitely see your point if you think of people who use 
C++ as an "improved C", without much use of OO and templates etc. There 
are lots of people out there who do that, and transferring that mode of 
usage to the kernel is simply not a good idea. C++ should only be the 
language of choice when you need the things where it shines: inheritance 
hierarchies, templates, object finalization.


My opinion is that if people want to use C++ in a module, they must do so:
1. Only if they _really_ need all that crap.
2. Only if they _really_ know what they're doing.
3. Only if they use a proper subset that cooperates correctly with the 
kernel.
4. Only if it's worth the extra effort that's needed to use C++ in a 
kernel module.

Basically, I think that if you know the problems, and know them well, 
you don't need to go looking for them anymore, you might be able to just 
walk around them. Let's get back to the situation that started this 
discussion: the Click people have shown that they can walk around the 
problems (point 2), their code is true C++ (they seem to need all that 
crap, point 1) and it works fine inside it's own kernel module (point 
3). Who are we to judge them, if it works for them? They don't really 
bother us with it -- we only bother ourselves with it *a lot* as soon as 
their existence is brought to our attention. :) And I think the only 
ones who can tell if it was worth the extra effort (point 4) are they 
themselves.

-- Bart
