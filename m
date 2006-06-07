Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751410AbWFGAlf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751410AbWFGAlf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jun 2006 20:41:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751411AbWFGAlf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jun 2006 20:41:35 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:65171 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1751410AbWFGAle (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jun 2006 20:41:34 -0400
Date: Wed, 7 Jun 2006 02:41:23 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: john stultz <johnstul@us.ibm.com>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: clocksource
In-Reply-To: <1149622955.4266.84.camel@cog.beaverton.ibm.com>
Message-ID: <Pine.LNX.4.64.0606070005550.32445@scrub.home>
References: <20060604135011.decdc7c9.akpm@osdl.org> 
 <Pine.LNX.4.64.0606050141120.17704@scrub.home>  <1149538810.9226.29.camel@localhost.localdomain>
  <Pine.LNX.4.64.0606052226150.32445@scrub.home> <1149622955.4266.84.camel@cog.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 6 Jun 2006, john stultz wrote:

> > One "unified" version will only be worse. Keeping the new path separate 
> > from the old path will only make things clearer and more flexible.
> > Right now you have a mixture of old code, interpolator code and new 
> > timekeeping code, which makes it a big mess.
> 
> Eh? Are we looking at the same code? Right now there is *no* mixture of
> old code. The update_wall_time() function is the same for *all* arches,
> and jiffies is the common clocksource.

Why is this so important??? Please, John, you driving me crazy with this.
You can start with the jiffies clocksource everywhere else, why here?

> This allows us to use alternate
> clocksources to move to continuous timekeeping, while allowing the
> accumulation function to stay the same. I don't see what part of this
> you consider messy.

_Please_ look at the update functions in my patch and try to understand 
its design, read the design document. The core part is:

	while (cycle_offset >= cycle_update) {
		cycle_offset -= cycle_update;
		clocksource_update_tick();
	}
	clocksource_adjust(cycle_offset);

For tick based design I can easily change this to:

	clocksource_update_tick();
	clocksource_adjust(0);

I can also rather easily exchange parts of it with 32 bit based 
calculations (without losing resolution). I know how to optimize this, but 
with your version I can't do this.
John, I don't need a unified design, I want a _flexible_ design and your 
unified mess doesn't give me this. You're taking away any control over 
this, which would make my life easier from an arch perspective. As archs 
convert to the new timekeeping code they can easily switch to the new 
generic function or they can rather easily adapt it to their needs, you 
make this impossible.
Later we can still unify things, but without having the majority of archs 
converted, without having really the complete picture, we need foremost 
flexibility. Doing a preemptive unification only because we can is the 
worst thing we can do at this time.

> > With large clock offsets the lookahead doesn't work correctly, basically 
> > because it's already to late and it can cause overadjustment. Because of 
> > this I do an extra lookahead in clocksource_bigadjust().
> 
> Do you have a hard example for this with numbers? I don't mean to be a
> pain, but I don't see this right off.
> 
> With the current code in -mm I can run a test app that disables
> interrupts for 2 seconds at a time over and over and I'm still keeping
> synched w/ an NTP server within 30 microseconds.

You need a clock source which doesn't generate it's own interrupts, so 
interrupts and clock updates can run asynchron. The key part above is 
"large clock offsets". In my test program disable the extra lookahead and 
run it with large offsets.
This code gets only limited testing in -mm, it needs to run for weeks 
or months, which I don't expect from the average -mm kernel. This makes 
userspace simulations so damn important and if you don't do this, you're 
playing a very risky game with a kernel which is supposed to be stable.

> > I'd prefer you'd just take the update function from my patch, it's nicely 
> > optimized and I'll try to address any concern you have about it.
> 
> Even though as mentioned above I'm still in the dark on the need for it,
> I spent a few hours last trying to convert the make_ntp_adj() in -mm to
> use your bigadjust implementation. Unfortunately my attempts refuse to
> boot. I'm not sure if this is the same problem that was keeping your
> patchset from booting as well, or possibly just an implementation error
> on my part.

John, why don't you just take my function with as little modifications as 
possible? Please don't take it as offense, but as long as you only take 
small pieces of my code without understanding how it fits into the big 
picture, I'm not surprised about such problems and this will take another 
year before we get to something usable. In the meantime Andrew is 
threatening to merge this anyway, which I'm definitively wouldn't trust it 
with anything which needs a stable time source.
Please try to understand me, usually I can be quite patient and I know I 
have a hard time to make myself understandable at times, but I simply 
can't do this under such pressure...

> > For this I also I posted a userspace test program, so that I know how it 
> > behaves, do you have something similiar for yours?
> 
> At your prodding awhile back I wrote a userspace simulator, but you
> never commented on it.

It was very hard to get running at all and in the meantime you had updated 
patches and the whole thing didn't work anymore. Sorry, that I didn't 
comment on it more. Note that I have different test programs to test 
various aspects - the NTP part and the clock part. At that time you did 
still poke very deeply into the NTP guts, where now the clock parts are 
more important.
Anyway, I did all this testing already, why are you simply throwing this 
away?

> 1) You don't like the unified update_wall_time
> 2) Issue w/ the current make_ntp_adj and lost ticks.
> 3) NTP error may be limited to clock->shift resolution w/ the jiffies
> clocksource (other clocksources have finer resolution then NTP's).
> 
> 
> #1 I disagree with. I really think the unified approach is the way to
> go, but I do understand the need to be conservative. This has gotten a
> fair amount of testing in -mm with no issues reported. But its not too
> hard to re-add the old update_wall_time(), so I could be convinced to
> push the unification off w/ a second opinion. Again, this would be via
> an incremental patch.

It wouldn't be an incremental patch, if this gets merged as is, creating 
something actually flexible would come close to another rewrite with the 
update function as the key part. As we discussed previously there other 
parts I don't agree with, but these can be done in more incremental steps, 
but not what you've done with update_wall_time().

> So for #2 I'm working on trying to get your implementation functioning,
> but I still don't quite understand the reason. I think this can be
> worked out w/ an incremental patch.

Because it's not about lost ticks.

> I posted an incremental patch for #3 yesterday, but it needs more work,
> and changes in #2 could affect it, so I'm focusing on #2 at them moment.
> Even so, NTP's resolution is 0.2 picoseconds, and the jiffies
> clocksource keeps an error resolution of 4 picoseconds, so I'm not sure
> if that this is really a blocker.  Further if we do re-add the old
> update_wall_time for issue #1, this would keep the jiffies clocksource
> from being used commonly, so this wouldn't be an issue.

You can use the jiffies clocksource everywhere else, why do you have to 
start in the interrupt function? In general management code this is fine, 
but I don't see a compelling reason to start in the most sensitive part.

bye, Roman
