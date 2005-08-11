Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964884AbVHKAZX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964884AbVHKAZX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Aug 2005 20:25:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964948AbVHKAZX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Aug 2005 20:25:23 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:30970 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S964884AbVHKAZW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Aug 2005 20:25:22 -0400
Message-ID: <42FA9AE9.9020507@mvista.com>
Date: Wed, 10 Aug 2005 17:25:13 -0700
From: Todd Poynor <tpoynor@mvista.com>
User-Agent: Mozilla Thunderbird 1.0+ (X11/20050531)
MIME-Version: 1.0
To: Daniel Petrini <d.pensator@gmail.com>
CC: Geoff Levand <geoffrey.levand@am.sony.com>, cpufreq@lists.linux.org.uk,
       linux-pm@lists.osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [linux-pm] PowerOP 1/3: PowerOP core
References: <20050809025157.GB25064@slurryseal.ddns.mvista.com>	 <42F8D4C5.2090800@am.sony.com> <42F94B68.6060107@mvista.com> <9268368b05081006585ca7a415@mail.gmail.com>
In-Reply-To: <9268368b05081006585ca7a415@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Petrini wrote:

> I'd like to have an idea of how the powerop would evolve to address:
> 
> a) exporting all operating points to sysfs - that would be useful for
> a policy manager in user space, or the user policy will already be
> aware of the ops?

For different usage models I'd expect to see both situations.  In one 
situation (classic desktop/server), a canned set of operating points may 
bee preconfigured (for example, the cpufreq support for Centrino), and 
automated software or an interactive user knows how to select an 
appropriate point (like the existing cpufreq algorithms such as "choose 
the lowest (powersave) point").  In the other situation (classic 
embedded), a system designer has chosen a number of useful operating 
points and configures software to choose an appropriate point based on 
system state ("the MPEG4 video app is running"), and that software knows 
what points are available and in what situations the points should apply.

> b) Constraints: if I would like to change to a op and such a
> transition is not allowed in hardware, what part of the software will
> test it? The set/get powerop functions, the higher layers or even some
> lower layer (don't know if expected) ?

Any sort of policy on what operating points should be allowed is 
targeted for a higher layer than PowerOP.  As you mention, there are 
situations where device needs constrain the operating points that can be 
set (for example, a PXA27x has modes that disable PLLs and/or run clocks 
at low speeds such that certain devices, if powered on, will wedge). 
Intelligence on what to do about that situation, if anything, can be 
placed in the high-layer power policy management application (this is 
probably the best answer), and/or the mid-layer power management 
framework code can also attempt to enforce these rules.

Stepping up on my soapbox for a moment, it is always recommended to have 
the power policy management application be aware of what the constraints 
are on operating points and set an appropriate power policy based on 
that information.  This may entail sending event messages from the 
drivers to the power policy manager app, to coordinate changes in device 
state with changes in policy.  If the constraints change very rapidly 
then it may make sense to preconfigure the rules on which operating 
point to choose in the kernel to avoid userspace interactions (and this 
is what the DPM device constraints feature is intended to do).  Relying 
on the power management mid-layer to block attempts to set an 
incompatible operating point is not recommended, but can function 
reasonably well if the mid layer is smart enough to know what the next 
best choice is and set that operating point instead.

-- 
Todd
