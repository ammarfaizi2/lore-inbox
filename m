Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965044AbVIADFS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965044AbVIADFS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Aug 2005 23:05:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965047AbVIADFS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Aug 2005 23:05:18 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:13562 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S965044AbVIADFQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Aug 2005 23:05:16 -0400
Message-ID: <43166FDE.90708@mvista.com>
Date: Wed, 31 Aug 2005 20:05:02 -0700
From: Todd Poynor <tpoynor@mvista.com>
User-Agent: Mozilla Thunderbird 1.0+ (X11/20050531)
MIME-Version: 1.0
To: David Brownell <david-b@pacbell.net>
CC: linux-pm@lists.osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [linux-pm] PowerOP Take 2 1/3: ARM OMAP1 platform support
References: <20050825025357.GB28662@slurryseal.ddns.mvista.com> <20050830203521.D39DDC10C1@adsl-69-107-32-110.dsl.pltn13.pacbell.net>
In-Reply-To: <20050830203521.D39DDC10C1@adsl-69-107-32-110.dsl.pltn13.pacbell.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Brownell wrote:
> Interesting.  I start to like this shape better; it moves more of the
> logic to operating point code, where it can make the sysfs interface
> talk in terms of meaningful abstractions, not cryptic numeric offsets.
> But it was odd to see the first patch be platform-specific support,
> rather than be a neutral framework into which platform-aware code plugs
> different kinds of things...

Since it is at a low layer below a number of possible interfaces, and 
since there is no generic processing performed at this low layer (it's 
pretty much set or get an opaque structure), there isn't any 
higher-layer framework to plug into at the moment.  If something like 
these abstractions of power parameters and operating points are felt to 
be a good foundation for a runtime power management stack then turning 
our attentions to the next layer up (perhaps cpufreq or a new 
embedded-oriented stack) would create that generic structure.

Its worth noting that newer embedded SOCs are coming up with such 
complicated clocking structures and rules for setting and switching 
operating points that some silicon vendors are starting to provide code 
at approximately the PowerOP level for their platforms, to plug into 
different upper-layer power management stacks (and possibly different 
open source OSes).  So there may be some value to settling on common 
interfaces for this.

> One part I don't like is that the platform would be limited to tweaking
> a predefined set of fields in registers.  That seems insufficient for
> subsystems that may not be present on all boards.  

Yes, the code currently assumes it would be tweaked for different 
variants of platforms, partly due to the difficulty of implementing a 
lean and mean way of integrating the different pieces.  It sounds like 
registering multiple handlers for multiple sets of power parameters may 
be in order, although a single opaque structure shared between upper 
layers and the handlers probably won't be sufficient any more.  If the 
operating point data structure basically goes away and sysfs becomes the 
preferred interface then it should be fairly straightforward to discover 
what PM capabilities are registered and to get/set the associated power 
param attributes.  Otherwise in-kernel interfaces might need some 
further thought to specify something that routes to the proper handler.

 > Plus, to borrow some
> terms from cpufreq, it only facilitates "usermode" governor models, never
> "ondemand" or any other efficient quick-response adaptive algorithms.

The sysfs interface does not itself handle such schemes, but the PowerOP 
layer is fine with inserting beneath in-kernel algorithms.  Low-latency, 
very frequent adjustments to power parameters are very much in mind for 
what I'm trying to do, assuming embedded hardware will increasingly be 
able to take advantage of aggressive runtime power management for 
battery savings.  (Much of this is driven by how embedded hardware can 
most aggressively but usefully be power managed, and it would be nice to 
get those folks more involved.)  What DPM does with approximately the 
same type of interface is setup some operating points and policies for 
which operating point is appropriate in which situations, and then kick 
off a kernel state machine that handles the transitions.

...
> Alternatively, the "thing" could implement some adaptive algorithm
> using local measurements, predictions, and feedback to adjust any
> platform power parameters dynamically.  Maybe it'd delegate management
> of the ARM clock to "cpufreq", and focus on managing power for other
> board components that might never get really reusable code.  Switching
> between operating points wouldn't require userspace instruction;
> call it a "dynamic operating point" selection model.

Interesting, although such close coordination of changing various clocks 
and voltages is required on some platforms that it would be hard to 
distribute it much among kernel components.  To some degree the above is 
how DPM functions: some policy instructions are sent to the kernel and 
the kernel switches operating points accordingly.  Something more 
flexible than operating points could be specified in the policy info, 
possibly even something as abstract as "battery low", pushing the 
interpretation of high-level power policy into kernel components instead 
of a userspace app giving the kernel low-level instructions.

> The DSP clock might benefit from some support though.  I've never
> much looked at this, beyond noting that SPUs on CELL should have
> similar issues.  Wouldn't it be nice to have "ondemand" style
> governors for DSPs or SPUs?  That's got to be easy. ;)

So far as I understand, Linux-coordinated power management of the DSP 
side of dual-core general-purpose + DSP platforms is often handled by a 
Linux driver that knows how to talk to whatever it is that runs on the 
DSP (such as via shared memory message libs from the silicon vendor). 
Soon the other core will be running Linux as well, and the two OSes will 
need to coordinate the system power management, which will be an 
interesting thing to tackle.

>>   lowpwr	1 = assert ULPD LOW_PWR, voltage scale low
> 
> 
> Could you describe the policy effect of this bit?  I suspect
> a good "PCs don't work like that!" example is lurking here.
> That interacts with some other bits, and code ... when would
> setting this be good, or bad?

This is how Dynamic Voltage Scaling is done on OMAP1 platforms. 
Assuming you've setup an operating point that is validated to work at 
the reduced voltage level on your hardware by TI (these are two voltage 
levels available), you can optionally specify to run at reduced voltage, 
possibly at an increased cost in latency of transitioning between 
operating points as voltage ramps up or down.  In the case of DPM 
running on an OMAP 1610 H2, you could tell the system to run at 1.5V 
when not idle and at 1.1V when idle, although depending on the ramp time 
(I can't recall for that board, but for some non-OMAPs this can be 
significant) and the realtime constraints of your app there could be 
missed deadlines under such a policy.  If the system isn't running 
anything with a tight deadline then it may be fine to stay at 1.1V or 
voltage scale between the two.

>>Other parameters such as DSPMMUDIV, LCDDIV, and ARM_PERDIV might also be
>>useful.
> 
> 
> Again, PERDIV changes would need to involve clock.c to cascade
> the changes through the clock tree.  Change PERDIV and you'll
> need to recalculate the peripheral clocks that derive from it...
> better not do it while an I/O operation is actively using it!

On some other platforms this actually becomes necessary, but for OMAP1's 
the trouble with doing so probably precludes anybody from using it.

> As with TCDIV, that makes a useful example of something that is
> clearly not within the "cpufreq" domain.  

I'll try to cook up an XScale PXA27x example, which adds multiple memory 
and system bus frequencies supported per CPU MHz, quick run vs.turbo 
mode switching of CPU MHz, and some other exotic features.  It has a 
very specific set of "product points" validated by Intel that correspond 
to the operating point abstraction.  If nothing else, it may be 
instructive to consider the variety of ways embedded platforms are being 
designed to be power managed.

-- 
Todd
