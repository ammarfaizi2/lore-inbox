Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964845AbVIFNtt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964845AbVIFNtt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Sep 2005 09:49:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964848AbVIFNtt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Sep 2005 09:49:49 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:45226 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S964845AbVIFNts
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Sep 2005 09:49:48 -0400
Date: Tue, 6 Sep 2005 14:49:44 +0100
From: viro@ZenIV.linux.org.uk
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Kconfig fix (BLK_DEV_FD dependencies)
Message-ID: <20050906134944.GV5155@ZenIV.linux.org.uk>
References: <20050906004842.GP5155@ZenIV.linux.org.uk> <Pine.LNX.4.61.0509061205510.3743@scrub.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0509061205510.3743@scrub.home>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 06, 2005 at 12:52:34PM +0200, Roman Zippel wrote:
> I'm not really a big fan of such dummy symbols, those whole point is to 
> only enable dependencies, but are otherwise unsused.
> The basic problem is similiar to selects, that one has to grep the whole 
> Kconfig to find out what modifies the dependencies of a symbol.
> 
> If we really want to describe dependencies like this, I'd prefer to extend 
> the Kconfig syntax for this:
> 
> config FOO
> 	allow BAR
> 
> config BAR
> 	option hidden
> 
> The hidden option would explicitly hide the symbol, unless otherwise 
> allowed.

I doubt that we really need that - there are, fortunately, very few drivers
that need either form.

Note that what happens here is very unusual:
	* driver is for hardware shared by quite a few (sub)architectures
	* it requires different (and irregular) glue for all of them
	* it doesn't exist for more and more new architectures and never
existed for many old ones
	* the same is true for subarchitectures of arm/mips/ppc - hell, even
for m68k, except that there we don't get new ones.
	* it's not tied to any bus

Keeping a list of targets that must be excluded is obviously losing variant -
there will be more and more of those.  Flipping to "it's allowed on <list>"
generates a big mess; yeah, you get a long expression that tells you where
is that sucker defined.  And it turns into a convoluted way to say "many
platforms have that, many do not, it's really up to platform, no general
rules here".  Which is exactly what
	depends on ARCH_MAY_HAVE_PC_FDC
is saying in far more readable way.

We could go for your "allow" form, but what else would need it?  USB gadget
stuff with its "must have at most one low-level driver, high-level drivers
should be allowed only if a low-level one is present"?  RTC mess is better
solved in other ways, PARPORT_PC is mostly solved by now, what's left?
VGA_CONSOLE?  I really don't see enough uses for such construct...
