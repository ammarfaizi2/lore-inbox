Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318138AbSHLPqx>; Mon, 12 Aug 2002 11:46:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318141AbSHLPqx>; Mon, 12 Aug 2002 11:46:53 -0400
Received: from surf.cadcamlab.org ([156.26.20.182]:60034 "EHLO
	surf.cadcamlab.org") by vger.kernel.org with ESMTP
	id <S318138AbSHLPqw>; Mon, 12 Aug 2002 11:46:52 -0400
Date: Mon, 12 Aug 2002 10:47:21 -0500
To: Greg Banks <gnb@alphalink.com.au>
Cc: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>,
       linux-kernel@vger.kernel.org, kbuild-devel@lists.sourceforge.net
Subject: Re: [patch] config language dep_* enhancements
Message-ID: <20020812154721.GA761@cadcamlab.org>
References: <20020808151432.GD380@cadcamlab.org> <Pine.LNX.4.44.0208081142390.23063-100000@chaos.physics.uiowa.edu> <20020808164742.GA5780@cadcamlab.org> <20020809041543.GA4818@cadcamlab.org> <3D53D50D.7FA48644@alphalink.com.au> <20020809161046.GB687@cadcamlab.org> <3D579629.32732A73@alphalink.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D579629.32732A73@alphalink.com.au>
User-Agent: Mutt/1.4i
From: Peter Samuelson <peter@cadcamlab.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  [I wrote]
> > This stuff is trivial enough, and easy enough to test, that I
> > think it could go in 2.4, yes.

[Greg Banks]
> I think you're underestimating the Gordian knot that is the CML1 corpus.

Yes, very possibly.

> To pick an example, in 2.5.29 drivers/ide/Config.in:17 is
> 
>    dep_tristate '    SCSI emulation support' CONFIG_BLK_DEV_IDESCSI $CONFIG_ATAPI $CONFIG_BLK_DEV_IDE $CONFIG_SCSI
> 
> But at this point in the menu tree for 14 of 17 architectures, CONFIG_SCSI has
> not yet been defined.  The result is that CONFIG_BLK_DEV_IDESCSI only works
> in "make config" and "make allyesconfig" precisely because of the semantic that
> you wish to change.

Thank you!  That's what I wanted to know.  I had no idea there existed
this class of bug (yes it's a bug).  I don't know why I should be
surprised, since the 17 architectures all have separately-maintained
config.in files, most of which were written by porting gurus, not
'make config' gurus.

That one example is more than enough to convince me *not* to try
changing the "ignore empty deps" rule for 2.4.  2.5 is a different
matter, though..

> In fact this is the first one gcml2 finds, I don't particularly feel
> like trawling through the other two hundred-odd.  Some of them are
> harmless, I don't know how many.

This is like the Stanford checker stuff.  These are bugs.  You have
the means to find them automatically, but not the time or desire to
fix them.  Post a list and perhaps others will pitch in.  Something
like

drivers/ide/Config.in:17: In dep_tristate CONFIG_BLK_DEV_IDESCSI:
drivers/ide/Config.in:17: CONFIG_SCSI not defined for i386, ppc, ...

In this case the fix would be to move CONFIG_BLK_DEV_IDESCSI to the
SCSI subsystem, where in my opinion it belonged anyway.

This would break down if there are any actual cycles - things which
can't logically be moved to a place after the definitions of the
facilities on which they depend.

That we have to worry about this at all is an artifact of using a
procedural langauge, rather than a declarative language like Prolog or
CML2.  I *really* don't want to go *there*, though. (:

> And "" != "n" in other contexts, like if [];then statements.

That is true.  But that should not affect the dep_* logic, should it?
The point here is that people who aren't hip-deep in config language
code don't think about them being separate.  Ergo bugs.

> If it's your intention to change the semantics of "", perhaps it
> would be better to add new statements which feature the new syntax
> and new semantics *only* and have no backwards compatibility
> baggage.  An example of this approach is the "nchoice" statement,
> which does the same thing as "choice" but with a more civilized
> syntax.

I've been thinking hard about a new sort of 'if' statement that
doesn't look like a test command.  (Yes, it's my mission to eventually
get rid of the '$'s in config language.  I think it can be done,
piecemeal, over a long period of time.  This is if we don't end up
adopting a whole new language like CML2 or Roman's stuff.)

Peter
