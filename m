Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932104AbVHMBGt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932104AbVHMBGt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Aug 2005 21:06:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932118AbVHMBGt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Aug 2005 21:06:49 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:10485 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S932104AbVHMBGt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Aug 2005 21:06:49 -0400
Message-ID: <42FD47A1.6070506@mvista.com>
Date: Fri, 12 Aug 2005 18:06:41 -0700
From: Todd Poynor <tpoynor@mvista.com>
User-Agent: Mozilla Thunderbird 1.0+ (X11/20050531)
MIME-Version: 1.0
To: david-b@pacbell.net
CC: geoffrey.levand@am.sony.com, linux-pm@lists.osdl.org,
       linux-kernel@vger.kernel.org, cpufreq@lists.linux.org.uk
Subject: Re: [linux-pm] PowerOP 1/3: PowerOP core
References: <20050809025157.GB25064@slurryseal.ddns.mvista.com> <42F8D4C5.2090800@am.sony.com> <42F94B68.6060107@mvista.com> <20050812162315.16671E2E9B@adsl-69-107-32-110.dsl.pltn13.pacbell.net>
In-Reply-To: <20050812162315.16671E2E9B@adsl-69-107-32-110.dsl.pltn13.pacbell.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

david-b@pacbell.net wrote:
> How well would _this_ notion of an operating point scale up?
> 
> I have this feeling that it's maybe better attuned to "scale down"
> sorts of problems (maybe cell phones) than to a big NUMA box.  I can
> see how a batch scheduled server might want to fire up only enough
> components to run the next simulation, but I wonder if maybe systems
> dynamically managing lots of resources might not be better off with
> some other model ... where userspace makes higher level decisions,
> and the kernel is adaptive within a potentially big solution space.
> (Likewise, maybe some of the smaller systems would too.)

If I understand correctly, that does seem to describe how such systems 
are used today: out of a potentially large number of choices (and some 
embedded SOCs do have a good variety of clocking, core voltage, and 
power domain choices), configure only those useful for the problem at 
hand into the kernel and then userspace gives marching orders to the 
kernel to activate whatever's appropriate according to system-specific 
logic in userspace.

>   - Why have any parsing at all?  It's opaque data; so insist that
>     the kernel just get raw bytes.  That's the traditional solution,
>     not having the kernel parse arrays of integers.
> 
>   - Why try to standardize a data-based abstraction at all?  Surely
>     it'd be easier to use modprobe, and have it register operating
>     points that include not just the data, but its interpretation.

Configuring the definitions of desired operating points (and updating 
these on-the-fly) from userspace has its advantages, but inserting into 
the kernel as a module should work fine and avoids some awkward 
userspace interfaces.  In the current code it is intended that both 
in-kernel interfaces (without parsing) and userspace interfaces are 
available, but I think non-diagnostic userspace interfaces could easily 
be dropped.  One of the nice things about having it done from userspace 
is that apps can be in charge of configuring operating points and 
activating those operating points in response to changes in system state 
(with reduced chance of mismatched app + module).  And since it can be 
done in userspace it's nice to simplify the kernel that way, which some 
folks feel strongly about.  But not a big deal to me.

Standard data structures have small benefits for implementing some code 
once instead of per-platform.  Another possibility in addition to the 
configuration or diagnostic interfaces is the concept of "constraints" 
on operating points according to device needs that you and others have 
alluded to: the constraints can be expressed in a form that can be 
checked by platform-independent code ("check the value at this power 
parameter index in the array for this range of integer values").  Also 
not a big deal.

All in all, it sounds like the next version of this should not have a 
userspace configuration interface and should not provide a 
platform-independent structure for the operating points.  The operating 
point get and set functions are in machine-specific code and take an 
operating point argument defined in header files shared between the 
machine-specific code and whatever kernel code is creating and 
activating operating points.  Any diagnostic interfaces need to be 
machine-dependent as well.

Now that the operating points are created without a generic layer or 
structure, if one wants a generic interface to set (activate) one of 
those operating points, probably identified by name, from userspace then 
a little extra is needed.  Can worry about that later.

>   - If those numbers are needed, having single-valued sysfs attributes
>     (maybe /sys/power/runstate/policy_name/XXX) would be preferable
>     to relying on getting position right within a multivalued input.

In case it helps, the code thus far and proposed interfaces use 
single-valued sysfs interfaces.  Since you also mentioned:

> It's easier for me to see how "echo policy_name > /sys/power/runtime"
> would scale up and down (given pluggable policy_name components!)
> than "echo 0 35 98 141 66 -3 0x7efc0 > /sys/power/foo" would.

and:

> That'd also be less error prone than "whoops,
> there wasn't supposed to be a space between 35 and 98" or "darn, I
> switched the 141 and 66 around again".

It may be worth pointing out that these interfaces wouldn't do that (a 
two level hierarchy of operating point name and single power parameter 
attribute would be used, and the ordering into the array is handled by 
the generic PowerOP core, which knows how to associate parameter names 
with array indices).  Older versions of DPM did use interfaces similar 
to what you describe, in case you've got that in mind.  They weren't 
intended to be used interactively.

Thanks,


-- 
Todd
