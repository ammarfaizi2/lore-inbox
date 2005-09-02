Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030618AbVIBA6S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030618AbVIBA6S (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 20:58:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030620AbVIBA6S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 20:58:18 -0400
Received: from ylpvm12-ext.prodigy.net ([207.115.57.43]:60577 "EHLO
	ylpvm12.prodigy.net") by vger.kernel.org with ESMTP
	id S1030618AbVIBA6R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 20:58:17 -0400
X-ORBL: [69.107.75.50]
Date: Thu, 01 Sep 2005 17:58:09 -0700
From: David Brownell <david-b@pacbell.net>
To: tpoynor@mvista.com
Subject: Re: [linux-pm] PowerOP Take 2 1/3: ARM OMAP1 platform support
Cc: linux-pm@lists.osdl.org, linux-kernel@vger.kernel.org
References: <20050825025357.GB28662@slurryseal.ddns.mvista.com>
 <20050830203521.D39DDC10C1@adsl-69-107-32-110.dsl.pltn13.pacbell.net>
 <43166FDE.90708@mvista.com>
In-Reply-To: <43166FDE.90708@mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <20050902005809.D62E385EEC@adsl-69-107-32-110.dsl.pltn13.pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Date: Wed, 31 Aug 2005 20:05:02 -0700
> From: Todd Poynor <tpoynor@mvista.com>
>
> David Brownell wrote:
> > Interesting.  I start to like this shape better; it moves more of the
> > logic to operating point code, where it can make the sysfs interface
> > talk in terms of meaningful abstractions, not cryptic numeric offsets.
> > But it was odd to see the first patch be platform-specific support,
> > rather than be a neutral framework into which platform-aware code plugs
> > different kinds of things...
>
> Since it is at a low layer below a number of possible interfaces, and 
> since there is no generic processing performed at this low layer (it's 
> pretty much set or get an opaque structure), there isn't any 
> higher-layer framework to plug into at the moment.

You're presenting PowerOP as a multi-platform thing in its own right.
I think that's my missing "higher level framework".  Although given the
other two patches in this group, maybe it was the sysfs API?  :)


>	If something like 
> these abstractions of power parameters and operating points are felt to 
> be a good foundation for a runtime power management stack then turning 
> our attentions to the next layer up (perhaps cpufreq or a new 
> embedded-oriented stack) would create that generic structure.

Something like -- certainly.  I suspect what I'm thinking about as the
API-visible structure is what you might want to call a range of operating
points, not just a single one ... example, "any CPU rate, low voltage, with
audio and display off".

In that example, suppose there are five choices for the CPU clock setting.
One way defines a different point for each choice, leading to five times
as many states as the one that just says "doesn't matter".

Come to think of it, I'm not clear how you think device drivers (a common
generic structure!) would interact with changes to power constraints.
Would you see the display driver being responsible for turning its power on
and off?  Or would code that switches operating points handle that too?
Should drivers get "here's the next operating point" calls?


> > One part I don't like is that the platform would be limited to tweaking
> > a predefined set of fields in registers.  That seems insufficient for
> > subsystems that may not be present on all boards.  
>
> Yes, the code currently assumes it would be tweaked for different 
> variants of platforms, partly due to the difficulty of implementing a 
> lean and mean way of integrating the different pieces.

Surely at least drawing a line between the on-chip hardware and
the drivers for external stuff is simple enough, though.  This
current construction would make it hard to draw that line, since
there's no distinction between the SOC logic (potentially very
reusable) and the board specific details (often less so) including
discrete devices and their drivers.


>	It sounds like 
> registering multiple handlers for multiple sets of power parameters may 
> be in order, although a single opaque structure shared between upper 
> layers and the handlers probably won't be sufficient any more.

I'm not sure why you say either of those things.  Surely the point
of the "echo pointname >file" operation is to change several
power constraints at once?  And I don't think you've talked much
about the layers on either side of PowerOP ... except maybe to say
they should exist.  :)


>  > Plus, to borrow some
> > terms from cpufreq, it only facilitates "usermode" governor models, never
> > "ondemand" or any other efficient quick-response adaptive algorithms.
>
> The sysfs interface does not itself handle such schemes, but the PowerOP 
> layer is fine with inserting beneath in-kernel algorithms.  Low-latency, 
> very frequent adjustments to power parameters are very much in mind for 
> what I'm trying to do, assuming embedded hardware will increasingly be 
> able to take advantage of aggressive runtime power management for 
> battery savings.

So you see why I want the "thing" seen by userspace to cover a range
of power states:  otherwise those "very frequent" adjustments would
always involve userspace transition and scheduling delays.


> ...
> > Alternatively, the "thing" could implement some adaptive algorithm
> > using local measurements, predictions, and feedback to adjust any
> > platform power parameters dynamically.  Maybe it'd delegate management
> > of the ARM clock to "cpufreq", and focus on managing power for other
> > board components that might never get really reusable code.  Switching
> > between operating points wouldn't require userspace instruction;
> > call it a "dynamic operating point" selection model.
>
> Interesting, although such close coordination of changing various clocks 
> and voltages is required on some platforms that it would be hard to 
> distribute it much among kernel components.

Much less "usermode" ones.  ;)

There will certainly be globs of functionality on a given platform
that don't factor nicely, and demand more monolithic approaches.
Groups of interrelated clocks seem to give good examples.

Then there will be other globs that _do_ factor more politely.

- Dave

