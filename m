Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318919AbSHMDTB>; Mon, 12 Aug 2002 23:19:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318920AbSHMDTB>; Mon, 12 Aug 2002 23:19:01 -0400
Received: from zok.SGI.COM ([204.94.215.101]:6556 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id <S318919AbSHMDS7>;
	Mon, 12 Aug 2002 23:18:59 -0400
Message-ID: <3D587BA7.1D640926@alphalink.com.au>
Date: Tue, 13 Aug 2002 13:23:19 +1000
From: Greg Banks <gnb@alphalink.com.au>
Organization: Corpus Canem Pty Ltd.
X-Mailer: Mozilla 4.73 [en] (X11; I; Linux 2.2.15-4mdkfb i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Peter Samuelson <peter@cadcamlab.org>
CC: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>,
       linux-kernel@vger.kernel.org, kbuild-devel@lists.sourceforge.net
Subject: Re: [kbuild-devel] Re: [patch] config language dep_* enhancements
References: <20020808151432.GD380@cadcamlab.org> <Pine.LNX.4.44.0208081142390.23063-100000@chaos.physics.uiowa.edu> <20020808164742.GA5780@cadcamlab.org> <20020809041543.GA4818@cadcamlab.org> <3D53D50D.7FA48644@alphalink.com.au> <20020809161046.GB687@cadcamlab.org> <3D579629.32732A73@alphalink.com.au> <20020812154721.GA761@cadcamlab.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Samuelson wrote:
> 
> >
> >    [...]CONFIG_BLK_DEV_IDESCSI[...]
> >
> That one example is more than enough to convince me *not* to try
> changing the "ignore empty deps" rule for 2.4.  2.5 is a different
> matter, though..

Ah, good.

> This is like the Stanford checker stuff.  These are bugs.  You have
> the means to find them automatically, but not the time or desire to
> fix them.  

Actually I have got the desire to fix them, what I lack is the ability
to get patches into the kernel that are too non-trivial to go through Rusty.

> Post a list and perhaps others will pitch in.  Something
> like
> 
> drivers/ide/Config.in:17: In dep_tristate CONFIG_BLK_DEV_IDESCSI:
> drivers/ide/Config.in:17: CONFIG_SCSI not defined for i386, ppc, ...

Ok, but perhaps it's not clear how many problems there are.  The full
log file from a gcml2 run on 2.5.29 is 573 KiB.  Here's a summary:

977    missing-experimental-tag
113    spurious-experimental-tag
145    variant-experimental-tag
30     inconsistent-experimental-tag
13     missing-obsolete-tag
41     spurious-obsolete-tag
25     variant-obsolete-tag
5      spurious-dependencies
187    nonliteral-define
28     unset-statement		(ignore these)
25     different-banner
61     different-parent
36     overlapping-definitions
1      primitive-in-root
310    undeclared-symbol
73     forward-compared-to-n
287    forward-reference
1093   forward-dependancy
1      symbol-like-literal
103    constant-symbol-dependency
8      different-compound-type
3562   total

These numbers are aggregates over 17 arches, so you need to divide by
a number between 1 and 17.  Also some of these have been fixed in 2.5.30.
I can post the full list if people want, but it would be a bit overwhelming.

> In this case the fix would be to move CONFIG_BLK_DEV_IDESCSI to the
> SCSI subsystem, where in my opinion it belonged anyway.

Ok then.

> This would break down if there are any actual cycles - things which
> can't logically be moved to a place after the definitions of the
> facilities on which they depend.

I'm not able to detect anything like that.

> That we have to worry about this at all is an artifact of using a
> procedural langauge, rather than a declarative language like Prolog or
> CML2. 

Actually config language isn't really procedural, pseudo-procedural would
be more like it.

> I *really* don't want to go *there*, though. (:

Yep.

> > And "" != "n" in other contexts, like if [];then statements.
> 
> That is true.  But that should not affect the dep_* logic, should it?

Correct, I'm just pointing out that using orthogonality arguments with
the config language is not going to get you anywhere useful.

> The point here is that people who aren't hip-deep in config language
> code don't think about them being separate.  Ergo bugs.

Agreed.

> I've been thinking hard about a new sort of 'if' statement that
> doesn't look like a test command.  

Interesting, I'd like to hear more.

My favourite idea is a different form of choice which worked more
like a menu, so you could intersperse conditionals with the choice
items.  This would help with the several places in CML1 were the
same choice is mostly-duplicated in different conditionals, e.g.
'Kernel page size' in arch/ia64/config.in.  ESR worked out a sensible
set of semantics for how this should work.

> (Yes, it's my mission to eventually
> get rid of the '$'s in config language.  I think it can be done,
> piecemeal, over a long period of time.  

Sounds good to me.

> This is if we don't end up
> adopting a whole new language like CML2 or Roman's stuff.)

Or a new parser & frontends for the existing language.

I'm not convinced that a complete new language will ever succeed after
the CML2 debacle, machine translated or not.  This is why I gave up the
idea of automatically converting CML1 to CML2.

Greg.
-- 
the price of civilisation today is a courageous willingness to prevail,
with force, if necessary, against whatever vicious and uncomprehending
enemies try to strike it down.     - Roger Sandall, The Age, 28Sep2001.
