Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287021AbRL1U6A>; Fri, 28 Dec 2001 15:58:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287008AbRL1U5l>; Fri, 28 Dec 2001 15:57:41 -0500
Received: from d-dialin-2988.addcom.de ([213.61.82.108]:17137 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S284136AbRL1U5f>; Fri, 28 Dec 2001 15:57:35 -0500
Date: Fri, 28 Dec 2001 21:56:53 +0100 (CET)
From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
X-X-Sender: <kai@vaio>
To: Keith Owens <kaos@ocs.com.au>
cc: Larry McVoy <lm@bitmover.com>, "Eric S. Raymond" <esr@thyrsus.com>,
        Dave Jones <davej@suse.de>, Linus Torvalds <torvalds@transmeta.com>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        <linux-kernel@vger.kernel.org>, <kbuild-devel@lists.sourceforge.net>
Subject: Re: State of the new config & build system 
In-Reply-To: <18619.1009503350@ocs3.intra.ocs.com.au>
Message-ID: <Pine.LNX.4.33.0112282035020.2889-100000@vaio>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[So far, I've generally been trying to keep away from the hot topics, but
I guess it's about time to make that experience. Also, let me add that my
opinion here is of course influenced by the fact that things didn't go the
way I would have liked...]

On Fri, 28 Dec 2001, Keith Owens wrote:

> On Thu, 27 Dec 2001 17:15:45 -0800, 
> Larry McVoy <lm@bitmover.com> wrote:
> >[talking about kbuild 2.5 speed]
> >Then it does seem reasonable to ask that the new one is at least as fast
> >as the old one.
> 
> kbuild 2.4 is fast but inaccurate, kbuild 2.5 is slower but accurate.
> Pick one.

Most problems which exist within kbuild 2.4 are fixable without the 
elaborate rewrite Keith did. The single biggest problem the current system 
has is that modversions get screwed up, since dependencies are screwed up, 
and yes, that's not easily fixable. However, this problem isn't even 
attacked in kbuild 2.5 AFAIK (I think modversions are simply disabled 
there). 

A couple of months ago, I came up with an alternative to kbuild 2.5. It 
doesn't try to have all the features kbuild 2.5 has, but solves the major 
problems with kbuild 2.4. It definitely has things in common with kbuild 
2.5, it also uses the "non-recursive" approach, i.e. the top level 
Makefile includes all the others. It also doesn't have "make dep" but 
builds dependencies with "gcc -MD" plus postprocessing.

I'm not claiming it is complete, and it doesn't even try to add the 
multiple source tree etc. features. Others said one should use proper 
version management instead, and I agree with that, but that's not the 
point.

Non-complete list of pros/cons:
o gets dependencies right, i.e. a new make "whatever" will really rebuild
  everything which is needed. Even *with* CONFIG_MODVERSIONS turned on.
o uses standard tools. I believe people said that one of the advantages
  of UNIX is that you don't need specialized tools for everything, but 
  combine existing tools to reach your goals. The new kbuild has the 
  disadvantage that most is implemented from scratch, the meat is in C 
  programs which probably nobody apart from Keith is familiar with.
  My solution used the standard tool for building, i.e. make + standard
  utilities like sh, sed, grep and the like. I only have one non-standard
  tool, that postprocesses a dependency list: replace 
  include/linux/autoconf.h with the /include/linux/config/options - this
  is needed so that a .config change doesn't cause an entire rebuild
  every time.
o It's actually pretty fast. On my laptop, the time to read all the 
  dependencies when doing a "make bzImage modules" is was about 5 seconds 
  with hot caches. That means a make takes about 5 seconds when there's 
  nothing to do - that's good enough IMHO. When
  doing a full rebuild, the time spent within make is definitely down in 
  the noise, if only a few files get rebuild, it's noticable, but still 
  faster than what the current kbuild system gives.
o The Makefiles in the SUBDIRS look basically the same as currently, only
  a somewhat simpler (no special $(LD) rules for composite objects etc). 
  Keith  implemented a whole new language - I supoose most coders are 
  familiar with normal Makefiles, they have yet to learn the new commands in
  kbuild-2.5 (which, however, is easy, of course)
o It's not nearly as feature-rich as Keith's approach is.
o Behind the scenes, the code is not exactly clear. make is pretty 
  flexible, but it really needs some hacks to do what's needed. So
  if someone wants to understand the build system, it takes some effort -
  same situation as in kbuild-2.4 and -2.5, though.
o I had the major problems solved and things worked fine in my tree. 
  However, I discontinued to work on it months ago, as I saw no way this 
  work would ever be useful for other people - maintaining a build system 
  just for personal use is a bit too much effort.

I don't claim that my work is superior to kbuild-2.5 or anything. (I still
think it may be "good enough", i.e. does solve the current problems - it
doesn't add features, though). But I'm dissatified that there never ever
was even consideration. When I posted ideas/patches to kbuild-devel, I
usually got a response like "this work isn't needed, I developed
kbuild-2.5, which will be the solution to all problems in 2.5".  I also
submitted non-intrusive changes for 2.4, which fixed/simplified things
there without breaking anything, but the answer was about the same,
"kbuild-2.4 is obsolete, for 2.5 it's irrelevant". Well, 2.4 will be
around for some time I guess...

When I replied (with technical arguments), I never heard anything back - 
compare the current thread about just silently dropping mails/patches 
;-(

That's why I decided to drop out of the kbuild business again. (BTW: note 
that this was about kbuild-2.5 only - nothing to do with CML2)

--Kai

