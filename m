Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932547AbVL1XOr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932547AbVL1XOr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Dec 2005 18:14:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932549AbVL1XOr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Dec 2005 18:14:47 -0500
Received: from gate.crashing.org ([63.228.1.57]:15592 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S932547AbVL1XOq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Dec 2005 18:14:46 -0500
Subject: Re: Suspend to {mem,disk} broken in 2.6.15-rc6/rc7 on my T42
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Dave Airlie <airlied@linux.ie>, Jules Villard <jvillard@ens-lyon.fr>
In-Reply-To: <Pine.LNX.4.64.0512281348220.14098@g5.osdl.org>
References: <20051226194527.GA3036@blatterie>
	 <Pine.LNX.4.64.0512261545460.14098@g5.osdl.org>
	 <1135641618.4780.3.camel@localhost.localdomain>
	 <20051227012053.GB9771@blatterie>
	 <1135646828.4780.10.camel@localhost.localdomain>
	 <20051227125504.GA11838@blatterie>
	 <1135750560.4635.3.camel@localhost.localdomain>
	 <Pine.LNX.4.64.0512281348220.14098@g5.osdl.org>
Content-Type: text/plain
Date: Thu, 29 Dec 2005 10:14:55 +1100
Message-Id: <1135811695.4635.30.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-12-28 at 13:49 -0800, Linus Torvalds wrote:
> 
> On Wed, 28 Dec 2005, Benjamin Herrenschmidt wrote:
> >
> > Linus, please back out those 2 DRM patches of me for 2.6.15. It seems
> > that they cause more problems than they solve due to bugs in the X
> > server. I need to rethink the solution.
> 
> Hmm.. How many other problem reports do we have? Jules reported that your 
> patch to use the max() of the aperture size and memsize fixed the problem 
> for him (and I merged it). Does it have other downsides?

It doesn't, but I've got one confirmed report of failure that isn't
fixed by the latest patch and 2 other ones still dubious.

I'm not entirely sure what's going on yet. On console switch (EnterVT()
in the X driver), it will restore the mode and set back the wrong value
in MC_AGP_LOCATION. It will then re-enable AGP and call the "resume"
ioctl to the DRM  which should then "fix" MC_AGP_LOCATION to the
"correct" value we calculated. However, it's possible that the chip
dislikes those constant changes of these memory controller settings
especially while it's currently pumping pixels out.

Also, if using dual head, it's possible that the X server radeon driver
goes back writing the wrong value _again_ after the first head has been
re-initialized, and while the engine is actively pumping command from
AGP, which would be deadly. The radeon driver in X is one of the worst
mess I've ever dealt with so far... 

So I think at this point, the best is that we keep the old bogus code
that at least is consistent with the bug in the server. I'm working on a
big patch to X that reworks the memory map stuff completely and fixes
those issues on the server side, I'll do a DRM patch matching this X fix
as well so that the memory map is only ever set in one place and with
what I hope is a correct algorithm...

Ben.

