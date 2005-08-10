Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964876AbVHJCSy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964876AbVHJCSy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Aug 2005 22:18:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964884AbVHJCSx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Aug 2005 22:18:53 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:39158 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S964876AbVHJCSx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Aug 2005 22:18:53 -0400
Message-ID: <42F963F6.60209@mvista.com>
Date: Tue, 09 Aug 2005 19:18:30 -0700
From: Todd Poynor <tpoynor@mvista.com>
User-Agent: Mozilla Thunderbird 1.0+ (X11/20050531)
MIME-Version: 1.0
To: Patrick Mochel <mochel@digitalimplant.org>
CC: linux-kernel@vger.kernel.org, linux-pm@lists.osdl.org,
       cpufreq@lists.linux.org.uk
Subject: Re: [linux-pm] PowerOP 0/3: System power operating point management
 API
References: <20050809024907.GA25064@slurryseal.ddns.mvista.com> <Pine.LNX.4.50.0508091110430.19925-100000@monsoon.he.net>
In-Reply-To: <Pine.LNX.4.50.0508091110430.19925-100000@monsoon.he.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patrick Mochel wrote:
> On Mon, 8 Aug 2005, Todd Poynor wrote:
(apologies for use of obsolete cpufreq mailing list address in my 
initial message.)
...
>>PowerOP is intended to leave all power
>>policy decisions to higher layers.
> 
> What do those higher layers look like? Do you have a userspace component
> that uses this interface?

cpufreq is one example, it manages an abstraction of system 
power/performance levels based on cpu speed, which maps onto the 
PowerOP-level hardware capabilities in some fashion, and has both kernel 
and userspace components to manage the desired policy associated with 
this.  Regardless of whether this notion of configurable operating 
points would remain a separate layer from cpufreq or was more tightly 
integrated, the code to set these operating points can handle things 
such as setting validated voltage levels to match cpu speeds, etc.

For embedded systems, I am aware only of the Dynamic Power Management 
project, which you also mention and does indeed manage power policy 
based on the notions of power parameters and operating points.  The 
settings of these are configured entirely from userspace via sysfs, 
using shell scripts or convenience libraries that access the sysfs 
attributes.  A system designer chooses the operating points to be 
employed in the system based on the information from the processor or 
board vendor that describes validated, supported operating points and 
based on the characteristics of the system (how fast it needs to run 
while in use for different purposes and how much battery power can be 
spent for those purposes).

For example, a designer implementing a system based on an Intel XScale 
PXA27x processor can choose from among about 16 validated operating 
points listed in the most recent specification update.  Those operating 
points are comprised of register settings with inscrutable names such as 
CCCR[L], CCCR[2N], CLKCFG[T], CCCR[A], and two or three others.  A few 
of those operating points run the CPU at identical frequencies, but have 
other changes in memory clocking, system bus clocking, and the ability 
to quickly switch between certain cpu frequencies based on other 
properties of the platform (so-called "Turbo-mode" frequency scaling). 
A DPM- or PowerOP-based system can be configured with the subset of 
desired operating points and a particular operating point activated as 
needed.  The policy decision as to what operating point is appropriate 
to activate is a matter for custom code provided by the designer, 
tailored to their system.  It is also possible to write automated 
operating point selection algorithms based on such criteria as system 
busyness.

> Who is using this code? Are there vendors that are already shipping
> systems with this enabled?
> 
> Is this part of the DPM project? If so, what other components are left in
> DPM?

The concepts and general Linux implementation of power parameters and 
operating points stems from the power-aware computing work done by 
Bishop Brock and Karthick Rajamani of IBM Research, and a somewhat 
different implementation is a part of the DPM project, which MontaVista 
(and reportedly others in the near future) does ship.  So far as I 
understand there are or soon will be mobile phones that use that code as 
the low- to mid-layers of the power management stack (the high-layer 
policy management is performed by a custom application of which I have 
no knowledge).

I mentioned in a previous email the next step of creating and activating 
operating points from userspace.  If that were in place, DPM would 
additionally consist primarily of:

1. Machine-specific backends to set operating points for the systems 
that DPM has been ported to.  If something like PowerOP is accepted into 
a broader community then that code would come along for the ride. 
XScale PXA27x and various ARM OMAPs are among the systems supported, as 
well as potentially others not yet making an appearance in open source.

2. DPM has further concepts of "operating state" (generally, whether the 
system is idle, processing interrupts, running a normal-power-usage 
task, running a background task without deadlines that can be assigned a 
low power/performance level, etc.) and the unfortunately-named "policy" 
that maps each operating state to an operating point, along with the 
code to switch in different operating points as the system switches 
operating states.  The "policy" is a bit of a misnomer; a system 
designer must create the desired operating points and decide upon the 
state -> point mappings appropriate, as well as make decisions on when 
to update the mappings based on external events, changing workloads, 
etc.  There are a few extra ramifications of modifying operating points 
in this fashion, including the need to handle such transitions while in 
interrupt context or in the idle loop, as well as a general concern for 
low overhead since switching may occur very frequently (such as at every 
entry and exit from idle).

3. Kernel-to-userspace power event notification is temporarily based on 
executing hotplug scripts.  This is outside the true domain of DPM, but 
in the absence of an acpid-like de facto standard for communicating 
power events it seemed best to provide some sort of mechanism.  kobject 
uevents are now the proper choice, and I'd propose use of that, as a 
separate matter from what I'm hoping to accomplish with PowerOP or the 
rest of DPM.

All of these are GPL software available on the project site.

> What are your plans to integrate this more with the cpufreq code?

At this point it's a proposed layer that does not disturb existing 
cpufreq code much, but if the cpufreq folks are receptive to these ideas 
I'd be all for a tighter integration.  Others have already asked for the 
ability to manage voltages along with cpu speed, so in one way or 
another it seems likely that an expanded set of power parameters may be 
provided in the future.  But I don't have any insight into the wishes or 
goals of the project.  Thanks,

-- 
Todd
