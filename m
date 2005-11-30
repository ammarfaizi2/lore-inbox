Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750799AbVK3CaG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750799AbVK3CaG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Nov 2005 21:30:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750794AbVK3CaG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Nov 2005 21:30:06 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:43208 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1750799AbVK3CaC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Nov 2005 21:30:02 -0500
Date: Wed, 30 Nov 2005 03:29:50 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Rob Landley <rob@landley.net>
cc: linux-kernel@vger.kernel.org, Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH] make miniconfig (take 2)
In-Reply-To: <200511282026.09511.rob@landley.net>
Message-ID: <Pine.LNX.4.61.0511291851290.1609@scrub.home>
References: <200511170629.42389.rob@landley.net> <200511271859.20735.rob@landley.net>
 <Pine.LNX.4.61.0511290139150.1609@scrub.home> <200511282026.09511.rob@landley.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 28 Nov 2005, Rob Landley wrote:

> I understand that bit, but the problem with the single pass you suggested is 
> that symbols can be set by dependencies (like the one afflicting CONFIG_PM), 
> and those are neither off nor at their default, yet they're not actually 
> required.

Setting everything to n can still be done in single pass, but that 
requires working around the normal API and setting the values directly, 
e.g.:

	for_all_symbols(i, sym) {
		if (!(sym->flags & SYMBOL_NEW))
			continue;
		switch (sym->type) {
		case S_BOOLEAN:
		case S_TRISTATE:
			sym->user.tri = no;
			sym->flags &= ~SYMBOL_NEW;
		}
	}

Now you only need to flush the old precomputed values 
(sym_clear_all_valid()) and you're done.

> This starts sounding like a directed graph, and I am _not_ familiar enough 
> with the kconfig structure to try to work it out yet.

The kconfig data is a directed acyclic graph, which allows to do most 
operation deterministically in a single pass.
The problem is to transform the data from a valid state to another valid 
state. The normal API allows only changes which keep the data in a valid 
state (e.g. you can't set a not visible symbol), but it's possible to 
bypass this and set multiple symbols, flush the old state and a new state 
will generated which is consistent with the Kconfig rules.
Currently only conf_read() does this, i.e. you can throw pretty much any 
.config at it and it will generate a valid (but not necessarily useful) 
config from it.

> > Symbols can be hidden by new dependencies.
> 
> Something gets enabled that then disables other things?  Hmmm...
> 
> I've been thinking of things in terms of visibility.  The menu this symbol 
> lives in either is or isn't open, and I can't set the symbol unless its menu 
> is open.  If two different symbols control visibility for the same menu, it's 
> still really that the menu has one guard symbol and that dependencies of 
> other things are messing with that guard symbol.  I think.
> 
> The way I've been thinking about miniconfigs is that each symbol in a 
> miniconfig is an action changing the default state.  When you read in a 
> miniconfig, you start with all symbols at default allnoconfig values, and 
> then make this list of changes to that state (in order) letting the 
> dependencies do their thing with each change.  (This maps to what a user 
> would do in menuconfig, selecting X, Y, and Z in this order.  I could write 
> it down on a piece of paper for the user, so why can't the machine do it for 
> me?)

This is not how it works (see above), reading the .config and user 
interface changes are two different things.
After the config has been read, the data is brought into a consistent 
state, which may mean the actual symbol value may be different, as they 
are limited by their dependencies.

> > Yes, some symbols are hidden behind a lot of dependencies, if a user wants
> > to enable a new option, he only adds one new option and kconfig can try to
> > figure out the missing options.
> 
> You mean enabling a symbol in a closed menu would open the menu (but leave 
> everything else in it disabled, rather than at default values)?  So 
> miniconfig wouldn't have to specify guard symbols at all anymore?
> 
> That would be nice.  I suspect there are guard symbols that are also 
> functional (CONFIG_SCSI comes to mind), so the rule would have to be 
> something like guard symbols are only discardable when something in the menu 
> they protect _is_ specified.

There are no special guard symbols, so if a SCSI driver is requested, this 
means CONFIG_SCSI needs to be set.

bye, Roman
