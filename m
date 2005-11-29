Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932294AbVK2C03@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932294AbVK2C03 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Nov 2005 21:26:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932333AbVK2C03
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Nov 2005 21:26:29 -0500
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:21478
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S932294AbVK2C03 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Nov 2005 21:26:29 -0500
From: Rob Landley <rob@landley.net>
Organization: Boundaries Unlimited
To: Roman Zippel <zippel@linux-m68k.org>
Subject: Re: [PATCH] make miniconfig (take 2)
Date: Mon, 28 Nov 2005 20:26:09 -0600
User-Agent: KMail/1.8
Cc: linux-kernel@vger.kernel.org, Sam Ravnborg <sam@ravnborg.org>
References: <200511170629.42389.rob@landley.net> <200511271859.20735.rob@landley.net> <Pine.LNX.4.61.0511290139150.1609@scrub.home>
In-Reply-To: <Pine.LNX.4.61.0511290139150.1609@scrub.home>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511282026.09511.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 28 November 2005 19:00, Roman Zippel wrote:

> > > I think it can even be done in a single pass over all the symbols,
> > > where boolean/tristate symbols are checked if they are already at the
> > > minimum value and string/hex/int values are compared with their default
> > > values.
> >
> > Minimum value?
>
> This is actually documented. :)
> n - 0, m - 1, y - 2

I understand that bit, but the problem with the single pass you suggested is 
that symbols can be set by dependencies (like the one afflicting CONFIG_PM), 
and those are neither off nor at their default, yet they're not actually 
required.

So a third criteria would be that this symbol's value is occluded by some 
other symbol.  (And "occluded" could either be "in a menu that's not open" or 
"set by somebody else's dependency".)

This starts sounding like a directed graph, and I am _not_ familiar enough 
with the kconfig structure to try to work it out yet.

I think, however, that "at default" (for allnoconfig's default, anyway) or 
"set by a dependency from another symbol" are the only two instances where we 
don't care about this value because it can be regenerated.  There's a corner 
case where the directed graph has cycles in it (two things that each switch 
the other on if they're enabled), but A) this is probably illegal already, B) 
we don't care which one we skip as long as there's no _redundant_ 
information.  Just be consistent (keep the first one).

How far off am I?

> > > Next step could be to add a variation of allnoconfig with better error
> > > checking (e.g. checking that all requested symbols have been set),
> >
> > Um, I thought my patch did that.  If any unrecognized symbols were
> > encountered, my miniconfig patch would report it and exit with an error
> > by the simple expedient of making the warning count a global and checking
> > it afterwards.  (I did a sort of -Werror for kconfig.)  If it attempts to
> > set an unrecognized symbol, it would already generate a warning, and if
> > the warning count is nonzero it bails out with an error at the end. 
> > Seemed to work quite well, for me anyway...
> >
> > What cases would that not catch?
>
> Symbols can be hidden by new dependencies.

Something gets enabled that then disables other things?  Hmmm...

I've been thinking of things in terms of visibility.  The menu this symbol 
lives in either is or isn't open, and I can't set the symbol unless its menu 
is open.  If two different symbols control visibility for the same menu, it's 
still really that the menu has one guard symbol and that dependencies of 
other things are messing with that guard symbol.  I think.

The way I've been thinking about miniconfigs is that each symbol in a 
miniconfig is an action changing the default state.  When you read in a 
miniconfig, you start with all symbols at default allnoconfig values, and 
then make this list of changes to that state (in order) letting the 
dependencies do their thing with each change.  (This maps to what a user 
would do in menuconfig, selecting X, Y, and Z in this order.  I could write 
it down on a piece of paper for the user, so why can't the machine do it for 
me?)

So really a miniconfig can't specify an inconsistent state, it can only be 
redundant.  (It can switch on things that later get switched off again by 
dependencies on later symbols.)  And all that means is the miniconfig is 
longer than it needs to be, which could easily be the case if a human made it 
by hand.  Perhaps some kind of warning would be a good idea ("symbol 
CONFIG_BLAH reverted by CONFIG_BLAH"), if it was easy to implement (perhaps 
by tagging the "manually" selected symbols, ones which the miniconfig had 
already explicitly specified a value for).  But not a show-stopper to me.

> > Good point, but the existing format is 90% of the gain for 10% of the
> > effort. Going from .config to miniconfig for my laptop's kernel, for
> > example, goes from 1370 lines to 138 lines, almost exactly a 10x
> > reduction.  And that can be done (admittedly badly) today, with the patch
> > I posted.
> >
> > Dropping that 138 down to 120, or even to 100, is a polishing step in
> > comparison.  Do you think there are another 30 lines that could be
> > trimmed out of that 138?  (Attached.)
>
> Yes, some symbols are hidden behind a lot of dependencies, if a user wants
> to enable a new option, he only adds one new option and kconfig can try to
> figure out the missing options.

You mean enabling a symbol in a closed menu would open the menu (but leave 
everything else in it disabled, rather than at default values)?  So 
miniconfig wouldn't have to specify guard symbols at all anymore?

That would be nice.  I suspect there are guard symbols that are also 
functional (CONFIG_SCSI comes to mind), so the rule would have to be 
something like guard symbols are only discardable when something in the menu 
they protect _is_ specified.

However, that could go in as a future enhancement, because it falls under 
"specifying redundant symbols".  A miniconfig that did switch on the menus 
(which would then be selected by a later dependency anyway, once the config 
reading logic was upgraded) would still work in to configure a newer kernel 
with a smarter configurator, wouldn't it?

> bye, Roman

Rob
-- 
Steve Ballmer: Innovation!  Inigo Montoya: You keep using that word.
I do not think it means what you think it means.
