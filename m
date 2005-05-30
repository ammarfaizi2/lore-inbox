Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261822AbVE3Xdh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261822AbVE3Xdh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 May 2005 19:33:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261821AbVE3Xdh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 May 2005 19:33:37 -0400
Received: from smtp.andrew.cmu.edu ([128.2.10.82]:65157 "EHLO
	smtp.andrew.cmu.edu") by vger.kernel.org with ESMTP id S261822AbVE3Xcp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 May 2005 19:32:45 -0400
Message-ID: <429BA27A.5010406@andrew.cmu.edu>
Date: Mon, 30 May 2005 19:32:10 -0400
From: James Bruce <bruce@andrew.cmu.edu>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050331)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Nick Piggin <nickpiggin@yahoo.com.au>
CC: "Bill Huey (hui)" <bhuey@lnxw.com>, Andi Kleen <ak@muc.de>,
       Sven-Thorsten Dietrich <sdietrich@mvista.com>,
       Ingo Molnar <mingo@elte.hu>, dwalker@mvista.com, hch@infradead.org,
       akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: RT patch acceptance
References: <m1br6zxm1b.fsf@muc.de> <1117044019.5840.32.camel@sdietrich-xp.vilm.net> <20050526193230.GY86087@muc.de> <1117138270.1583.44.camel@sdietrich-xp.vilm.net> <20050526202747.GB86087@muc.de> <4296ADE9.50805@yahoo.com.au> <20050527120812.GA375@nietzsche.lynx.com> <429715DE.6030008@yahoo.com.au> <20050527233645.GA2283@nietzsche.lynx.com> <4297EB57.5090902@yahoo.com.au> <20050528054503.GA2958@nietzsche.lynx.com> <42981467.6020409@yahoo.com.au> <4299A98D.1080805@andrew.cmu.edu> <429ADEDD.4020805@yahoo.com.au> <429B1898.8040805@andrew.cmu.edu> <429B2160.7010005@yahoo.com.au>
In-Reply-To: <429B2160.7010005@yahoo.com.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin wrote:
> Sorry James, we were talking about hard realtime. Read the thread.

hard realtime = mathematically provable maximum latency

Yes, you'll want a nanokernel for that, you're right.  That's because 
one has to analyze every line of code, and protect against introduced 
regressions, which is almost impossible given the pace that Linux-proper 
is developed.  Then there's the other 95% of applications, for which a 
"statistical RT" approach such as used in the RT patch suffice.  So 
arguing for a nanokernel for (provable) hard realtime is orthogonal to 
the discussion of this patch, and we apparently don't actually disagree.

If you look at your first two messages in this thread however, you seem 
to be offering a nanokernel approach (in particular RTAI as suggested by 
Cristoph) as an alternative to the RT-patch.  This is sort of confused 
by the fact that Ingo called it "hard realtime" because he measured a 
maximum latency during a stress test.  Unfortunately that's not really 
hard realtime if you are just measuring it; Rather its "really damn good 
soft realtime".  An analysis of code paths could be done to determine if 
something really does satisfy hard-RT constraints, but to my knowledge 
that's not on the table at this point.  So you're discussing soft 
realtime if you're dicussing the RT patch.

So its really just a misunderstanding; Nanokernels certainly still have 
a place for some applications even with the RT patches applied (Ingo has 
said as much).  However expecting audio applications such as Jack to 
have to use RTAI is kind of silly, and would end up annoying the authors 
of both (I'm sure the RTAI people have better things to do than support 
ALSA drivers in RT mode).

> What's more, I don't think you understand how a nanokernel solution
> would work, nor have much idea about the complexity of implementing
> it in Linux (although that could have been a result of your thinking
> that we weren't talking about hard-rt).

Nanokernels for RT aren't that difficult when compared with the RT 
patch, I agree with you on that.  An RT scheduler is also pretty damn 
easy to write (certainly easier than a general purpose one that can't 
arbitrarily starve low-prio tasks).  The complexity comes in when you 
have to fork drivers to make them RT-compatible, or upcall into existing 
ones in which case you're making the same modifications to code as in 
the RT patch.  Nanokernels work great for simpler hard realtime apps, 
but poorly for complex softer-realtime apps.  The RT patch addresses the 
latter quite well.

> And my questions for which I got no answer were things like
> "why is a single kernel superior to a nanokernel for hard-RT?",

It's not better; The two methods best serve different types of applications.

> "what deterministic services would a hard-RT Linux need to provide?"

To start out with, nothing; It's better to let such applications develop 
iteratively.  In developing things such as Jack or my robot code, we 
find out what things we can call without screwing up latency, and if we 
think something could be fixed, we might ask about it on LKML to see if 
someone will fix it.  This model works pretty well in open source.  You 
can see my question about the Linux serial driver a few years ago, or 
the many threads about Jack on this list.

I realize you don't like this approach, but that's pretty much how 
things have been working for a while.  The Jack people are using the RT 
patch now, and will come back when they find something that doesn't work 
as well as it seems it should.  They did the same with preempt and the 
lowlatency patches before it.  A fixed set of requirements would be 
nice, but these applications are evolving just as the kernel does.

> Err, your example was "reading a configuration file". Not exactly
> rocket science my good man.

For the third time: One model is easier to program for than the other, 
neither makes anything impossible.  Writing applications in assembler 
isn't rocket science either, but even for "hello world" I'd rather use a 
compiled language.

>> Please explain how a split-kernel method supports a continuous 
>> progression from soft-realtime to hard-realtime, where each set of API 
>> calls has associated latency effects that may or may not be tolerable 
>> for a given application. That's the problem space, and I can guarantee 
>> applications exist all along that progression, and many don't fall 
>> cleanly into one side or the other.
> 
> You say this like you have a confabulous solution ready to plonk
> into the Linux kernel.

I certainly don't, but I think someone else is on to a solution that can 
achieve this eventually.  When someone questioned "who really 
wants/needs this stuff", then I piped up, along with a few others.

Many of us "RT-people" would love to to see the ordinary kernel get as 
far as it can without a radical change in programming model.  That means 
we could write one Posix app that is realtime on Linux, and working but 
possibly not realtime on older Linux versions and other operating 
systems.  We could tell users "use Linux 2.6.14 if you don't want the 
system to hiccup".  That is preferable to writing a special version of 
the software for Linux just to get soft RT.  That said, there will 
always be a place for other approaches such as nanokernels for someone 
controlling the proverbial industrial saw.  For those applications you 
want proof of hard realtime performance, but at the same time they don't 
require streaming data off a disk or onto the network, nor using audio 
hardware or serial radios for output.

[snip part about bothering to understand RT approaches]

I really hope we understand each other now, but if not I guess it wasn't 
to be.  Hopefully someone got something out of reading this discussion, 
but I won't be posting on this branch of the thread anymore either.

  - Jim Bruce
