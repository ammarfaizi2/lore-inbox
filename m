Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262093AbRETRQn>; Sun, 20 May 2001 13:16:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262101AbRETRQd>; Sun, 20 May 2001 13:16:33 -0400
Received: from snark.tuxedo.org ([207.106.50.26]:55822 "EHLO snark.thyrsus.com")
	by vger.kernel.org with ESMTP id <S262093AbRETRQX>;
	Sun, 20 May 2001 13:16:23 -0400
Date: Sun, 20 May 2001 13:14:57 -0400
From: "Eric S. Raymond" <esr@thyrsus.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Arjan van de Ven <arjanv@redhat.com>, linux-kernel@vger.kernel.org
Subject: Background to the argument about CML2 design philosophy
Message-ID: <20010520131457.A3769@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: "Eric S. Raymond" <esr@thyrsus.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Arjan van de Ven <arjanv@redhat.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20010518105353.A13684@thyrsus.com> <3B053B9B.23286E6C@redhat.com> <20010518112625.A14309@thyrsus.com> <20010518113726.A29617@devserv.devel.redhat.com> <20010518114922.C14309@thyrsus.com> <8485.990357599@redhat.com> <20010520111856.C3431@thyrsus.com> <15823.990372866@redhat.com> <20010520114411.A3600@thyrsus.com> <16267.990374170@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <16267.990374170@redhat.com>; from dwmw2@infradead.org on Sun, May 20, 2001 at 04:56:10PM +0100
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Those of you who have become confused about the current argument over CML2
should read this...

David Woodhouse <dwmw2@infradead.org>:
> After the discussion of MAC and SCSI config options many moons ago in this
> thread, I was left with the impression that the constraints which were 
> being objected to were not dependent upon a NOVICE mode, but were 
> unconditional.
> 
> Was this merely a mistake in the conversion of the ruleset? Do you have a 
> policy that the default behaviour should be similar to that of CML1, or at 
> least that such behaviour should be available through one of the 
> modes? If not, please consider doing so.

They were unconditional.  It looks like a recap of history is in order.

Until very recently, like ten days ago, I had a policy of altering the
CML1 behavior as little as possible while I got CML2 up and running.
Some change had been inevitable because of the move to a single-apex 
menu tree, but I tried to hold that to a minimum.

But I have reached a point where the configurator codebase is stable
and works as a drop-in install on top of a stock kernel tree.  I'm
not even getting requests for UI tweaks any more.  So the CML2 engine is
essentially done (modulo the occasional minor bugfix).  

This made it time to start thinking about tuning the rulesfile to make
configuration easier.  At the same time, I was dealing with another
problem; missing entries in Configure.help.  When I got handed the 
maintainer's baton, there were 547 of these.  I have written outright 
over 300 new ones; Steven Cole and I have collected another 50 or so.

To reduce the problem further, I looked for symbols with missing
entries that I could turn into derivations, eliminating their
questions and the requirement for a help entry.  (A CML2 derivation is
like a CML1 define; it's a formula that sets a symbol from the value
of other symbols without user input.)

The first candidates I found were questions associated with built-in
SCSI and Ethernet on Macintoshes, on the Sun 3 and Sun3x, and with
built-in facilities on the MVME147 single-board computer.  So I wrote
derivations that looked like this:

# These were separate questions in CML1.  They enable on-board peripheral
# controllers in single-board computers.
derive MVME147_NET from MVME147 & NET_ETHERNET
derive MVME147_SCC from MVME147 & SERIAL
derive MVME147_SCSI from MVME147 & SCSI
derive MVME16x_NET from MVME16x & NET_ETHERNET
derive MVME16x_SCC from MVME16x & SERIAL
derive MVME16x_SCSI from MVME16x & SCSI
derive BVME6000_NET from BVME6000 & NET_ETHERNET
derive BVME6000_SCC from BVME6000 & SERIAL
derive BVME6000_SCSI from BVME6000 & SCSI

# These were separate questions in CML1
derive MAC_SCC from MAC & SERIAL
derive MAC_SCSI from MAC & SCSI
derive SUN3_SCSI from (SUN3 | SUN3X) & SCSI

By doing this I killed two birds with one stone -- got rid of some holes
in Configure.help and (more importantly) moved the configuration experience
away from low-level, hardware-oriented questions towards where I think it
ought to be. That is, you specify a platform and the services you want and
the ruleset computes the low-level facilities to be linked in.

This represented a change in the design philosophy of the ruleset, not
something I wanted to do without input from the developers and port 
managers.  So I broadcast "CML2 design philosophy heads up".

After some back-and-forthing about the technical facts, several things
emerged:

1. The Mac derivations were half-right.  The MAC_SCC one is good but Macs 
can have either of two different SCSI controllers.  I fixed that with help
from Ray Knight, who maintains the 68K Mac port.

2. Nobody had a problem with the SUN3_SCSI derivation.

3. The MVME derivations are correct *if* (and only if) you agree to ignore
the possibility that somebody could want to ignore the onboard hardware,
plug outboard disk or Ethernet cards into the VME-bus connector, and
do something like running SCSI-over-ATAPI to the outboard device.
(I missed these possibilities when I wrote the derivations.)

I used case 3 to explore a touchy question about design philosophy, which
is really what caused all hell to break loose.  The question is this:
holding down configuration complexity is a good thing, but supporting
all hardware configurations that are conceivably possible is also a good 
thing.  How should we trade these good things off against one another?

The MVME situation is an almost perfect test case, because while
breaking the assumption behind that derivation is physically possible
it would be a rather perverse thing to do.  The VME147 is an old
design, dating from 1988; it's long since been superseded by MPCxxx
SBCs based on the PowerPC that have a better processor, lower power
consumption, and more on-board peripheral hardware.  IDE/ATAPI didn't
exist during most of its design lifetime, and the only way anyone is
ever going to hook an outboard device to one of these puppies again
is if some hacker pulls a dusty one off a shelf for some garage project.

So the real question here is whether it is ever acceptable to say that
a possible configuration is just silly and ruleset will ignore it, in
order to hold down ruleset complexity and simplify the user
experience.  The cost of deciding that the answer to that question is
"yes, sometimes" is that on rare occasions like this one you might
have to haul out a text editor to tweak something in your config.  But
the cost of deciding that the answer is "no" will be some pretty
serious complexity headaches both in the configuration user experience
and (down the road) in the maintainability of the ruleset.

So far, I have to say I'm disappointed in the quality of the debate.
Almoist nobody seems to want to think about this tradeoff globally, as a
systems design issue.  Instead, I'm hearing a lot of reflexive
chuntering that we have to do things a certain way because we've
always done them a certain way, and who am I to even dare *think*
about raising different possibilities?  
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

[The disarming of citizens] has a double effect, it palsies the hand
and brutalizes the mind: a habitual disuse of physical forces totally
destroys the moral [force]; and men lose at once the power of
protecting themselves, and of discerning the cause of their
oppression.
        -- Joel Barlow, "Advice to the Privileged Orders", 1792-93
