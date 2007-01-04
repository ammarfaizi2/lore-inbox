Return-Path: <linux-kernel-owner+w=401wt.eu-S1750936AbXADRlT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750936AbXADRlT (ORCPT <rfc822;w@1wt.eu>);
	Thu, 4 Jan 2007 12:41:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750937AbXADRlT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Jan 2007 12:41:19 -0500
Received: from smtp.osdl.org ([65.172.181.24]:39142 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750933AbXADRlS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Jan 2007 12:41:18 -0500
Date: Thu, 4 Jan 2007 09:37:14 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Albert Cahalan <acahalan@gmail.com>
cc: Segher Boessenkool <segher@kernel.crashing.org>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, s0348365@sms.ed.ac.uk, bunk@stusta.de,
       mikpe@it.uu.se
Subject: Re: kernel + gcc 4.1 = several problems
In-Reply-To: <787b0d920701040904i553e521fsb290acf5059f0b62@mail.gmail.com>
Message-ID: <Pine.LNX.4.64.0701040921010.3661@woody.osdl.org>
References: <787b0d920701032311l2c37c248s3a97daf111fe88f3@mail.gmail.com> 
 <27e6f108b713bb175dd2e77156ef61d0@kernel.crashing.org>
 <787b0d920701040904i553e521fsb290acf5059f0b62@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 4 Jan 2007, Albert Cahalan wrote:

> On 1/4/07, Segher Boessenkool <segher@kernel.crashing.org> wrote:
> >
> > Lack of the flag does not break any valid C code, only code
> > making unwarranted assumptions (i.e., buggy code).
> 
> Right, if "C" means "strictly conforming ISO C" to you.
> (in which case, nearly all real-world code is broken)

Indeed. The gcc people seem to often think that "language lawyering" is a 
good idea, and totally overrides "real world". The whole flap about the 
completely idiotic things they do (or at least did) for alias analysis on 
the grounds that "they can" is an example of this.

> FYI, the kernel also assumes that a "char" is 8 bits.
> Maybe you should run away screaming.

Gcc people are quick to condemn others for assumptions that breaks 
standards, but it has tons of assumptions very deeply embedded itself. I 
don't think it could realistically work very well on setups where pointers 
aren't the same size as long, and it has various deep assumptions itself 
about what is "realistic".

The kernel does the same. Some of it intentional and by design, much of it 
probably totally unintentional, but the result of "it worked, and nobody 
even thought about anything else". 

With 7+ million lines of C code and headers, I'm not interested in 
compilers that read the letter of the law. We don't want some really 
clever code generation that gets us .5% on some unrealistic load. We want 
good _solid_ code generation that does the obvious thing.

Compiler writers seem to seldom even realize this. A lot of commercial 
code gets shipped with basically no optimizations at all (or with specific 
optimizations turned off), because people want to ship what they debug and 
work with.

I'll happily turn off compiler features that are "clever optimizations 
that never actually matter in practice, but are just likely to possible 
cause problems".

The sad part is that "straightforward optimizations" (as opposed to 
"really clever ones") often work better in practice too. At least with 
kernel code, which is not that high-level to begin with. 

> > to take is not to add the compiler flag, but to fix the code.
> 
> Nope, unless we decide that the performance advantages of
> a language change are worth the risk and pain.

Indeed. We'd happily fix the code if:
 (a) it's reasonably easy to find places that are buggy.
 (b) there are syntactically sane ways to fix it
 (c) the optimization actually makes sense and is worthwhile

An example of where _none_ of these things were true was the old gcc alias 
analysis. I think gcc eventually added a sane way to mark pointers as 
being possible aliases (ie case (b): give a syntactially acceptable way 
for code maintainability to actually fix things), but since neither (a) 
nor (b) are there, the _correct_ solution was just to tell the compiler to 
stop doing that.

With integer overflow optimizations, the same situation may be true. The 
kernel has never been "strict ANSI C". We've always used C extensions. The 
extension of "signed integer arithmetic follows 2's-complement-arithmetic" 
is a perfectly sane extension to the language, and quite possibly worth 
it.

And the fact that it's not "strict ANSI C" has absolutely _zero_ 
relevance.

		Linus
