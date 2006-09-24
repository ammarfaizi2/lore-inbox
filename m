Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751842AbWIXJUX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751842AbWIXJUX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Sep 2006 05:20:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751864AbWIXJUX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Sep 2006 05:20:23 -0400
Received: from caramon.arm.linux.org.uk ([217.147.92.249]:44304 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1751842AbWIXJUW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Sep 2006 05:20:22 -0400
Date: Sun, 24 Sep 2006 10:20:10 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Lennert Buytenhek <buytenh@wantstofly.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Dave Jones <davej@redhat.com>,
       David Miller <davem@davemloft.net>, jeff@garzik.org, davidsen@tmr.com,
       alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: Re: 2.6.19 -mm merge plans
Message-ID: <20060924092010.GC17639@flint.arm.linux.org.uk>
Mail-Followup-To: Lennert Buytenhek <buytenh@wantstofly.org>,
	Linus Torvalds <torvalds@osdl.org>, Dave Jones <davej@redhat.com>,
	David Miller <davem@davemloft.net>, jeff@garzik.org,
	davidsen@tmr.com, alan@lxorguk.ukuu.org.uk,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.64.0609211106391.4388@g5.osdl.org> <45130533.2010209@tmr.com> <45130527.1000302@garzik.org> <20060921.145208.26283973.davem@davemloft.net> <20060921220539.GL26683@redhat.com> <20060922083542.GA4246@flint.arm.linux.org.uk> <20060922154816.GA15032@redhat.com> <Pine.LNX.4.64.0609220901040.4388@g5.osdl.org> <20060924074837.GB13487@xi.wantstofly.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060924074837.GB13487@xi.wantstofly.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 24, 2006 at 09:48:37AM +0200, Lennert Buytenhek wrote:
> On Fri, Sep 22, 2006 at 09:21:32AM -0700, Linus Torvalds wrote:
> > I personally prefer to not see _too_ many pull requests, since that
> > to me indicates that people don't take advantage of the distributed
> > nature of git, and don't let things "simmer" in their own tree for
> > a while.
> 
> Changes that span sub-architectures (such as genirq) are usually
> discussed on the mailing list first, and tested before they get
> committed to any tree.  I.e. on the few occasions that we do need
> to test ARM-wide changes, we just email patches around rather than
> asking folks "whether 2.6.30-rmk42 works."

Let's look at how two scenarios work for the case of the genirq patches.

1. genirq remains as patches until it's ready (iow, what actually happened)
   - patches as a series were posted to the mailing list with a request
     to test.
   - feedback came, the patches were improved, and this repeated several
     times
   - eventually, people are happy
   - in parallel, because these patches affect other architectures, they
     were also submitted to -mm.
   - the generic parts of genirq were submitted to Linus.
   - once the generic parts of genirq are in mainline, the ARM specific
     parts can then be applied to my git tree, and be sent to Linus.

2. genirq patches in ARM git tree.
   - the initial entire patches get applied to the ARM tree on a
     separate branch.
   - the patches get mailed to the ARM mailing list as one large patch.
   - feedback comes to me/mailing list rather than CC:'d to the genirq
     people.
   - maybe the genirq people send updates to me, which then need to be
     applied to the ARM tree, and the result needs to be re-published.
   - we go around the loop several times, maybe merging in later mainline
     versions.
   - in parallel with this, the non-ARM parts of genirq are submitted to
     -mm.
   - when the patches are ready, the generic parts are submitted to
     Linus.
   - rmk then faces a _big_ problem in resolving lots of conflicts in
     his tree, because the generic parts submitted to Linus are different
     from the initial generic parts committed to the ARM git tree.
   - the ARM git tree for genirq probably has to be rebuilt from scratch.

Sure, someone else _could_ maintain genirq in their own git tree, so
replace "rmk" above with "tglx".  The overall problem remains though -
at the end of it you can't push that git tree with all that history,
and the whole thing can't go via just one person.  This in turn means
that there's a chunk of additional work to rework the changes (which
may introduce bugs) and then an additional round of re-testing to make
sure nothing broke.

The point I'm making is that for some things, keeping the changes as
patches until they're ready is far easier, more worthwhile and flexible
than having them simmering in some git tree somewhere.

> For example, a driver for the ethernet MAC in the ARM cpu that I have
> here was recently applied by jgarzik, but I cannot submit the arch/arm
> hooks to make use of this driver until jgarzik's tree is merged upstream
> _and_ rmk rebases the half a megabyte of pending ARM changes on this
> tree.  If I submit the hooks to rmk when the driver goes upstream, rmk's
> private tree (probably still based on 2.6.18 when that happens, so won't
> have the relevant netdev changes) will break.
> 
> To make making these kinds of changes easier without sending stuff
> upstream so regularly, rmk would have to either pull from upstream
> regularly or rebase his tree on upstream regularly, both of which
> don't seem like desirable options.

I believe that Linus has complained to tree maintainers when they've
done this because it complicates the history far too much.

Consider the effect on the history if I were to pull Linus' tree daily
into my trees, and I was committing about one change per day.  You'd
have:

linus---othercommits--------othercommits---------othercommits-------merge
  \           \                    \                    \          /
 commit --- merge --- commit --- merge --- commit --- merge --- commit

The other solution is that I somehow start reviewing drivers for any
part of the kernel and accepting them.  However, as we've seen already
on lkml, if anyone who isn't jgarzik accepts a change to a network
device driver and passes it to Linus, they get a roasting from Jeff
(see Dominic's incident when adding some additional PCMCIA IDs to PCMCIA
network device drivers.)


>From the point of view of keeping an ARM tree, I've been in that situation
before - from the beginnings of ARM support on Linux until the advent of
bitkeeper.  This was when I had my own tree which was published regularly.
The problem that posed is that the tree was seen as "the ARM tree" where
_everything_ to do with ARM (be it device drivers) was _dumped_.  Once it
was in there, the original authors decided that their job was done and
walked away.

The result was that I accumulated almost 1MB of compressed patch, and
we _never_ got to the situation where the merged ARM mainline was in
a buildable state despite _years_ of work to try to get it there.  The
closest we got was one of the 2.4-ac trees, just before Alan quit doing
them (which might have been a contributary reason.)

To date, none of the 2.4 trees is buildable for ARM.

The biggest problem with it is synchronising changes with other trees,
and persuading other people to submit things to the relevant people.
Either such a tree accepts the ARM specific bits along side the device
drivers (and then ends up with a review and bypassing other maintainers
problem, resulting in the tree owner getting regularly roasted) or
they get moaned at for not accepting device driver patches which are
dependent on other changes in that tree.

Since then, I've vowed to _never_ maintain such a "community" tree ever
again.  I credit 2.6 being buildable for ARM entirely on the choice to
get rid of this tree.

-- 
Russell King
 2.6 ARM Linux   - http://www.arm.linux.org.uk/

