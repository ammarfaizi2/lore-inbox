Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750737AbWABOFh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750737AbWABOFh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jan 2006 09:05:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750736AbWABOFh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jan 2006 09:05:37 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:17325 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1750737AbWABOFg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jan 2006 09:05:36 -0500
Date: Mon, 2 Jan 2006 15:05:11 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Adrian Bunk <bunk@stusta.de>
Cc: Arjan van de Ven <arjan@infradead.org>,
       Tim Schmielau <tim@physik3.uni-rostock.de>,
       Linus Torvalds <torvalds@osdl.org>, Dave Jones <davej@redhat.com>,
       Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>,
       mpm@selenic.com
Subject: Re: [patch 00/2] improve .text size on gcc 4.0 and newer compilers
Message-ID: <20060102140511.GA2968@elte.hu>
References: <20051229224839.GA12247@elte.hu> <1135897092.2935.81.camel@laptopd505.fenrus.org> <Pine.LNX.4.63.0512300035550.2747@gockel.physik3.uni-rostock.de> <20051230074916.GC25637@elte.hu> <20051231143800.GJ3811@stusta.de> <20051231144534.GA5826@elte.hu> <20051231150831.GL3811@stusta.de> <20060102103721.GA8701@elte.hu> <1136198902.2936.20.camel@laptopd505.fenrus.org> <20060102134345.GD17398@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060102134345.GD17398@stusta.de>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -1.9
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-1.9 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.9 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Adrian Bunk <bunk@stusta.de> wrote:

> > > > Your uninline patch might be simple, but the safe way would be Arjan's 
> > > > approach to start removing all the buggy inline's from .c files.
> > > 
> > > sure, that's another thing to do, but it's also clear that there's no 
> > > reason to force inlines in the -Os case.
> > > 
> > > There are 22,000+ inline functions in the kernel right now (inlined 
> > > about a 100,000 times), and we'd have to change _thousands_ of them. 
> > > They are causing an unjustified code bloat of somewhere around 20-30%. 
> > > (some of them are very much justified, especially in core kernel code)
> > 
> > my patch attacks the top bloaters, and gains about 30k to 40k (depending
> > on compiler). Gaining the other 300k is going to be a LOT of churn, not
> > just in amount of work... so to some degree my patch shows that it's a
> > bit of a hopeless battle.
> 
> A quick grep shows at about 10.000 inline's in .c files, and nearly 
> all of them should be removed.
> 
> Yes this is a serious amount of work, but it's an ideal janitorial 
> task.

oh, it is certainly an insane amount of janitorial work - which is also 
precisely why this well-known and seemingly trivial problem has 
escallated so much!

the nontrivial thing is that the moment trivial things get widespread, 
_the mechanism_ needs a change. I.e. the 'widespread inlines' arent the 
big problem, the big problem is that the widespread inlines _got 
widespread_. I'm not sure whether i'm being clear enough: think of the 
22,000 inlines as a symptom of a deeper problem, not as the problem 
itself. That is i am trying to get through (to you and to others).

trying to attack a problem that has a number-of-changes size of 22,000 
is also trivially _futile_, we'll be quickly overwhelmed by the 
underlying problem again, if it's not addressed.

both Arjan and me are trying to attack the underlying problem, while 
also fixing all the results of that problem. But the main focus is on 
mapping and eliminating the _hidden_ problem, not on the very visible 
'symptoms'. The symptoms are easy to fix! I do think the underlying 
problem is fixable too, but i find it slightly frustrating that most 
people are focused on the symptoms, missing the bigger picture.

what is the 'deeper problem'? I believe it is a combination of two 
(well-known) things:

  1) people add 'inline' too easily
  2) we default to 'always inline'

problem #1 is very hard to influence, because it's a basic psychology 
issue. Pretty much the only approach to fix this is to educate people.  
But it is hard to change the ways people code, and it's a long-term 
thing with no reasonable expectation of success. So while we can and 
should improve education of this issue (this thread will certainly raise 
awareness of it), we cannot rely on it alone.

i think the only realistic approach is to attack component #2: do not 
default to 'always inline' but default to 'inline if the compiler agrees 
too'. I do think we should default to 'compiler decides' (when using a 
gcc4 compiler), as this also has some obvious advantages:

 - different inlining when compiler optimizes for size not for speed

changing this also means we need to map a few trivial cases where kernel 
code relies on inlining (or relies on non-inlining), but those are 
fortunately easy and mostly well-known.

taking Arjan's patch alone, or running a script to change all static 
inlines in .c files to non-inline, without doing some of the other 
changes i'm proposing has a number of disadvantages:

 - it leaves the defaults in place, and we'll again gain ~50-100 new 
   'incorrect' inlines per week as we did until today. Barring the 
   initial few weeks of enthusiasm, nobody will really address that in 
   the long run, and we'll be back to square one.

 - it likely destroys the inlines there _were_ put into .c files 
   judiciously and correctly. The keyword 'inline' is a hint for gcc 
   which increases the likelyhood it will be inlined. Removing them an 
   bloc is _wrong_ and punishes the 'good guys', while still allowing 
   the 'bad guys' to continue business as usual.

so all in one, unless we attack #1 or #2 _with a bigger effective effort 
than we spend on attacking the symptoms_, we will only achieve a 
temporary, short-term reprieve.

	Ingo
