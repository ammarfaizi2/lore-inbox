Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261626AbVGaFc0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261626AbVGaFc0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Jul 2005 01:32:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261719AbVGaFcZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Jul 2005 01:32:25 -0400
Received: from smtp.osdl.org ([65.172.181.4]:61127 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261626AbVGaFcR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Jul 2005 01:32:17 -0400
Date: Sat, 30 Jul 2005 22:31:37 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: "Brown, Len" <len.brown@intel.com>
cc: "Rafael J. Wysocki" <rjw@sisk.pl>, linux-kernel@vger.kernel.org,
       Russell King <rmk+lkml@arm.linux.org.uk>,
       Hugh Dickins <hugh@veritas.com>, Andrew Morton <akpm@osdl.org>,
       Dominik Brodowski <linux@dominikbrodowski.net>,
       Daniel Ritz <daniel.ritz@gmx.ch>
Subject: RE: revert yenta free_irq on suspend
In-Reply-To: <F7DC2337C7631D4386A2DF6E8FB22B3004311E37@hdsmsx401.amr.corp.intel.com>
Message-ID: <Pine.LNX.4.58.0507302216570.29650@g5.osdl.org>
References: <F7DC2337C7631D4386A2DF6E8FB22B3004311E37@hdsmsx401.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 31 Jul 2005, Brown, Len wrote:
> 
> If one believes that suspend/resume is working on a large number of
> systems -- working to a level that a distro can acutally support it,
> then restoring our temporary resume IRQ router hack to make many systems
> work is clearly the right thing to do.

I don't believe that it works on a huge number of devices as-is, no.

But I'm definitely even less likely to believe in this "two steps forward,
one step back" dance. Because as far as I can tell, it's equally often
"one step forward, two steps back", and nobody can tell when we go forware 
more than we go backwards.

So I'd rather have "one tenth of a step forward, but if we see even a 
_hint_ of a step back, we revert immediately".

I realize that sounds damn timid and boring, but the thing is:

 - even _if_ (and quite frankly, judging by the complaints, I find that 
   unlikely) we're doing more forward progress than backwards progress 
   ("backwards progress? you moron!"), the "one step back" thing is really 
   doing a _huge_ amount of psychological damage to the whole thing.

   The thing is, we're better off making very very slow progress that is 
   _steady_, than having people who _used_ to have things work for them 
   suddenly break.

   So I believe that if we fix two machines and break one machine, we've 
   actually regressed. It doesn't matter that we fixed more than we broke: 
   we _still_ regressed. Because it means that people can't trust the 
   progress we make!

So this is why I'm a very strong proponent of the fact that if we _ever_
have anybody complain that a patch broke things, we should immediately
revert it, unless we can fix it asap.

Btw, this argument is much less true in areas where we can "think" about
the problems. In non-driver/non-firmware cases.

When we can logically argue from a purely theoretical standpoint for a
"known correct solution", and expect the theoretical argument to actually
be reflected in practice, I'm much more open to an argument of "ok, we
know where we are going, and we'll have to break a few eggs just because
the changes are extensive".

But when it comes to device drivers and badly documented stuff that
developers can usually not even reproduce, our #1 strength is the people
for whom it works, and when something breaks, that's a huge big red flag,
and then I really think that "revert or fix immediately" is the only
reasonable alternative. Otherwise we'll just oscillate about a point that
we don't even know where it is, and have no way to judge if the
oscillations are getting more violent or are dampening out - we don't have
a reference point.

But as with everything, there is no total black-and-white case. Things 
_do_ break occasionally, and clearly we can't guarantee nonbreakage or 
we'll end up being static.

But this particular thing has clearly caused a _lot_ of noise, with
second-order breakage from fixes from the first order one. At the very 
least alternatives should be tried, and I think there _are_ much less 
intrusive alternatives that are _much_ less likely to have these kinds of 
negative side effects.

		Linus
