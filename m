Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751006AbWABUJ7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751006AbWABUJ7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jan 2006 15:09:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751007AbWABUJ7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jan 2006 15:09:59 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:48551 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751004AbWABUJ6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jan 2006 15:09:58 -0500
Date: Mon, 2 Jan 2006 21:09:34 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: Krzysztof Halasa <khc@pm.waw.pl>, bunk@stusta.de, arjan@infradead.org,
       tim@physik3.uni-rostock.de, torvalds@osdl.org, davej@redhat.com,
       linux-kernel@vger.kernel.org, mpm@selenic.com
Subject: Re: [patch 00/2] improve .text size on gcc 4.0 and newer compilers
Message-ID: <20060102200934.GA30093@elte.hu>
References: <20051230074916.GC25637@elte.hu> <20051231143800.GJ3811@stusta.de> <20051231144534.GA5826@elte.hu> <20051231150831.GL3811@stusta.de> <20060102103721.GA8701@elte.hu> <1136198902.2936.20.camel@laptopd505.fenrus.org> <20060102134345.GD17398@stusta.de> <20060102140511.GA2968@elte.hu> <m3ek3qcvwt.fsf@defiant.localdomain> <20060102110341.03636720.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060102110341.03636720.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Andrew Morton <akpm@osdl.org> wrote:

> > > what is the 'deeper problem'? I believe it is a combination of two 
> > > (well-known) things:
> > >
> > >   1) people add 'inline' too easily
> > >   2) we default to 'always inline'
> > 
> > For example, I add "inline" for static functions which are only called
> > from one place.
> > 
> > If I'm able to say "this is static function which is called from one
> > place" I'd do so instead of saying "inline". But omitting the "inline"
> > with hope that some new gcc probably will inline it anyway (on some
> > platform?) doesn't seem like a best idea.
> > 
> > But what _is_ the best idea?
> 
> Just use `inline'.  With gcc-3 it'll be inlined.
> 
> With gcc-4 and Ingo's patch it _might_ be inlined.  And it _might_ be 
> uninlined by the compiler if someone adds a second callsite later on.  
> Maybe.  We just don't know.  That's a problem.  Use of __always_inline 
> will remove this uncertainty.

i agree with your later points, so this is only a minor nit: why is a 
dynamic decision done by the compiler a 'problem' in itself?

It _could_ _become_ a problem if the compiler does it incorrectly, but 
that's so true for just about any other dynamic gcc decision: what 
registers it opts to use in a hotpath, what amount of loop-unrolling it 
does, what machine-ops it choses, how it schedules them, how it reorders 
them, how it generates memory access patterns, etc., etc. Sure, the 
compiler can mess up in _any_ of these dynamic decisions, with possibly 
bad effects to performance, but that by itself doesnt create some magic 
'dynamic inlining is bad' axiom.

In fact, i believe the opposite is true: inlining is arguably best done 
dynamically. Whether gcc makes use of that theoretical opening is 
another question, but my measurements show that gcc4 does a quite good 
job of it. (It certainly does a better job than what we humans did over 
the last 5 years, creating 20,000+ inline markers.)

and even if we let gcc do the inlining, a global -finline-limit=0 
compile-time flag will essentially turn off all 'hinted' inlining done 
by gcc.

> So our options appear to be:
> 
> a) Go fix up stupid inlinings (again) or
> 
> b) Apply Ingo's patch, then go add __always_inline to places which we
>    care about.

note that one of the patches i did (a small one in fact) does exactly 
that, for x86: i marked all things __always_inline that allyesconfig 
needs inlined.

> Either way, we need to go all over the tree. In practice, we'll only 
> bother going over the bits which we most care about (core kernel, core 
> networking, a handful of net and block drivers).  I suspect many of 
> the bad inlining decisions are in poorly-maintained code - we've been 
> pretty careful about this for several years.

yes. And this pretty much supports my point: we should flip the meaning 
of 'inline' around, from 'always inline', to at least: 'inline only if 
gcc thinks so too, if we are optimizing for size'.

and i'd be equally happy with making the flip-around even more agressive 
than my first patch-queue did, to e.g. alias 'inline' to 'nothing':

	#define inline

and to then remove inline from all .c level files (and most .h level 
files) as well - albeit this would punish places that use inline 
judiciously.

Even in this case, it is very likely much easier to re-add inlines to 
the few places that really improve from them (even though they dont need 
it in the __always_inline sense like vsyscalls or kmalloc()), than to 
keep the current 'always inline' logic in place and to hope for a 
gradual reduction of the use of the inline keyword...

	Ingo
