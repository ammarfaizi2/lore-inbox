Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265335AbUATJty (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jan 2004 04:49:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265334AbUATJty
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jan 2004 04:49:54 -0500
Received: from kluizenaar.xs4all.nl ([213.84.184.247]:2899 "EHLO samwel.tk")
	by vger.kernel.org with ESMTP id S265335AbUATJsh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jan 2004 04:48:37 -0500
Message-ID: <400CF96B.8020109@samwel.tk>
Date: Tue, 20 Jan 2004 10:48:27 +0100
From: Bart Samwel <bart@samwel.tk>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031221 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Valdis.Kletnieks@vt.edu
CC: linux-kernel@vger.kernel.org
Subject: Re: Compiling C++ kernel module + Makefile
References: <20040116210924.61545.qmail@web12008.mail.yahoo.com> <Pine.LNX.4.53.0401161659470.31455@chaos> <200401171359.20381.bart@samwel.tk> <Pine.LNX.4.53.0401190839310.6496@chaos>            <400C1682.2090207@samwel.tk> <200401200529.i0K5T3oe005335@turing-police.cc.vt.edu>
In-Reply-To: <200401200529.i0K5T3oe005335@turing-police.cc.vt.edu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Valdis.Kletnieks@vt.edu wrote:
> On Mon, 19 Jan 2004 18:40:18 +0100, Bart Samwel said:
> 
>>Now, let me try to add a bit of nuance to your suggested solution. Try 
>>porting 100s of C++ files (yes, it's that large) making heavy use of 
>>inheritance etc. to C. Then try to make a bit of C code usable as extern 
>>"C" in C++. Extern "C" was actually meant to be able to grok most C 
>>code, while C++ wasn't meant to be easily portable to C. So, for any 
>>moderately large module that uses any C++ features at all, it's probably 
>>easier to make small syntactic changes to the kernel than to port the 
>>module to C (which would amount to a full rewrite).
> 
> That's one honking big module.

Yeah, I think they could definitely have split it up a bit more. The 
inner workings are very modular however (it's built up of lots of 
relatively small classes), so splitting it up shouldn't be too hard, 
except that that would probably require exporting C++ symbols over 
module boundaries -- which is something they probably tried to avoid. 
It's one thing to run compiled C++ code (which basically amounts to 
running binary code that complies with the module interface of the 
running kernel) as a module, it's a completely different (and much more 
problematic) thing to place C++ symbols in the kernel symbol space.

> Everybody please join me in a sigh of relief
> that the culprits didn't think Scheme was a suitable language.

Deep sigh! Luckily, Scheme didn't evolve from C, and it doesn't have a 
built-in compatibility layer that is specifically intended for C 
interoperability. If it did, there would probably be some idiot who 
would try it. :)

(OT anecdote: a guy I met at the university once had to do a programming 
assignment where he had to do a stochastic experiment and print a graph 
of the results. The assignment didn't specify which language, so he 
wrote it in PostScript. Yes, _PostScript_, a language which, as I 
understand it, is not unlike Forth. Every time you would print out his 
document there would be a different graph, with results of a fresh 
stochastic experiment. :) )

> Anybody who thinks that C++ should be anywhere on the kernel side of the kernel/
> user interface should understand why the kernel design doesn't even allow the
> use of *floating point* without much jumping through hoops.

I'm well aware of the technical difficulties and all the problems that 
appear when you're going to use C++. However, the kernel developers have 
even limited themselves (with good reasons) to even a subset of C: much 
of the C runtime library is not available in the kernel, and floating 
point math is also looked at with extreme caution. The C equivalent of 
C++'s exceptions (setjmp/longjmp) are not available in the kernel, even 
though they are a part of regular C. Is it not possible to conceive a 
subset of C++ (e.g., no exceptions, no floating point math) that could 
work, with only minimal hoops? All in all, if you take a restricted 
enough subset of C++, you basically get something that corresponds to 
the same subset of C that the kernel uses. The original C++ compiler 
(cfront) even compiles to C, IIRC. (I'm not saying that supporting such 
a subset of C++ would be a good thing, just trying to put this into 
perspective a bit. As you say, even floating point takes hoop-jumping. 
But that is not a "Forbidden!" or a "Allowed!", it's basically a shade 
of gray in-between. I'm just pondering the *possibility* that there's 
such a shade in-between for C++ as well, for those willing to jump 
through the necessary hoops.)

> They then should
> ponder the political climate that created EXPORT_SYMBOL_GPL, which is
> (basically) a "this is OUR kernel and if you don't want to play by our rules,
> we intend to make things difficult for you".

> The module authors should then ask themselves what they're bringing to the
> table that's worth the kernel developers changing the way they do things.
> Unless there's a demonstrable reason or advantage to changing, the idea to
> support C++ is probably as dead-on-arrival as the heavily lambasted proposal to
> have a stable API for modules a while back.

Fortunately, the people have never asked the kernel developers to 
change. They've simply taken a language with an excellent C 
interoperability layer, which can compile to object code that contains 
only exported symbols with C-linkage, and they have restricted 
themselves to a subset of that language that doesn't break the C code 
they're interoperating with. This has become possible only because of 
the freeness of the kernel (which is encoded in the license and further 
enforced by things like EXPORT_SYMBOL_GPL), which allowed them to modify 
the kernel headers in order to get it to compile in an extern "C" clause 
in C++. They've maintained this patch since 2.2, and I don't expect this 
to change. I've even heard I don't think _they_ expect this to change, 
as they probably know all too well about the political climate within 
the kernel developers' scene. However, as long as the kernel keeps using 
C as it's language, keeps being GPL'ed, and keeps exporting a module 
interface that is defined by some prototypes in some C include files, I 
don't see how this could lead to any trouble for them. They can always 
maintain and distribute their patch (because of the freeness), they can 
always link in their C++ code as a module (because of the module layer) 
and they can always use the kernel's header files to import the module 
ABI for the current kernel (because they are C files, and because C++'s 
extern "C" will always be able to parse them -- except for some small 
fragments maybe, which might require a patch).

So, the only trouble I can imagine them ever getting into is when the 
kernel developers *think* they are being asked to change their ways. 
That's bound to set them off into a frenzy of the-other-way-bashing, ad 
hominem attacks on the people who might even THINK about something like 
that etcetera. It's almost like it's a taboo. Well, in fact, it _is_ a 
taboo. :) Even if nobody has asked kernel developers to change their 
ways, even _mentioning_ something that is remotely related to this is 
immediately followed by an "allergic" reaction, like in this case. The 
only help Ashish wanted was with the build system, and the first 
response (Richard's) immediately attempted to figure out whether someone 
was serious about this or was only mistakenly trying to compile a 
userland program into the kernel. When it became clear that it was, in 
fact, serious, any further response had nothing to do with the build 
system (the original question) and everything with a gut reaction to the 
taboo being mentioned. I think that's a pity, as there was no reason for 
this kind of overreaction -- nobody outside the kernel developers group 
tried even remotely to change the kernel developers' ways, but the 
response from the kernel developers' group _was_ trying to change 
others' ways in response, and in a rather rude way too. I'm not trying 
to sway anyone either way here (as far as I'm concerned I'm not 
convinced either way, I'm not in a "camp"), I'm just opposed to the type 
of response this issue has brought up. The same could have been said in 
a polite, reasonable way with some reserves, and that would have saved 
us a lot of discussion and would have been much more productive as well.

-- Bart
