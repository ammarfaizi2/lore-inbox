Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750786AbVHQBkF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750786AbVHQBkF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Aug 2005 21:40:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750787AbVHQBkE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Aug 2005 21:40:04 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:33779 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S1750786AbVHQBkC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Aug 2005 21:40:02 -0400
Message-ID: <4302955F.10007@mvista.com>
Date: Tue, 16 Aug 2005 18:39:43 -0700
From: Todd Poynor <tpoynor@mvista.com>
User-Agent: Mozilla Thunderbird 1.0+ (X11/20050531)
MIME-Version: 1.0
To: Dominik Brodowski <linux@dominikbrodowski.net>,
       Todd Poynor <tpoynor@mvista.com>, cpufreq@lists.linux.org.uk,
       Patrick Mochel <mochel@digitalimplant.org>, linux-pm@lists.osdl.org,
       linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>
Subject: Re: PowerOP 0/3: System power operating point management API
References: <20050809024907.GA25064@slurryseal.ddns.mvista.com> <20050810100718.GC1945@elf.ucw.cz> <42FA796A.4080205@mvista.com> <20050809024907.GA25064@slurryseal.ddns.mvista.com> <Pine.LNX.4.50.0508091110430.19925-100000@monsoon.he.net> <42F963F6.60209@mvista.com> <20050809030000.GA25112@slurryseal.ddns.mvista.com> <20050816085345.GJ9150@dominikbrodowski.de>
In-Reply-To: <20050816085345.GJ9150@dominikbrodowski.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dominik Brodowski wrote:

> First, the table interface you suggest is ugly. If there's indeed the need for
> such an abstraction, I'd favour something like

I'm planning to adopt the previous suggestions of an opaque data 
structure and stop trying to have any generic structure to it.  I'll try 
to leave dependency checking etc. to the upper layers as much as 
possible, since platforms vary greatly in this and so do the needs of 
different PM s/w stacks.

> Secondly, you do not adress the cross-relationships between operation points
> correctly. If you change the CPU frequency, you may have to switch other
> (memory, video) settings; you might even have to validate the frequency
> settings for these or even additional reasons (thermal and battery reasons -
> ACPI _PPC).

This lowest layer basically assumes that upper-layer software has 
created an appropriate operating point (for example, in DPM we pretty 
much require a system designer to create operating points that match the 
h/w specs and don't go to great lengths to encode rules about this), 
and/or will call driver notifiers etc. as needed to adapt to the 
changes.  Although there may be some sanity checking appropriate at the 
PowerOP level, cpufreq, DPM, etc. can for the most part continue to 
handle the larger issues of how valid operating points are constructed, 
driver callbacks, etc.  If you do want to handle various dependencies at 
the PowerOP layer then there's nothing that prevents that, but PM 
frameworks tend to embody assumptions about how frequently operating 
points will change and in what contexts (interrupt, idle...), and this 
can influence the code for such things.

> Thirdly, who is to decide on the power management settings? The first and
> intuitive answer is the kernel. Therefore, kernel-space cpufreq governors
> exist. Only under rare circumstances, you want full userspace control --
> that's what the userspace cpufreq governor is for.

Also something left to the existing upper layers; PowerOP isn't intended 
to handle any of that.  In the embedded space we usually let the system 
designer choose operating points supported by their h/w vendor and that 
match their particular system states (hardware enabled at any point in 
time, type and power/performance needs of software currently running). 
We do recommend that a userspace power policy manager be the component 
in charge of PM settings, based on messages from drivers and other apps 
on the state of the system.  And so that userspace component activates 
the operating point (or set of operating points in the case of DPM) 
appropriate for current state.

> Foruthly, the code duplication which your implementation leads to is obvious
> for the speedstep-centrino case. 

We could move the tables of valid cpu speeds and corresponding voltages 
down to the PowerOP level, and there would probably be little 
duplication at that point (in fact, with the current patch there's not a 
lot of duplication since the actual MSR access was moved to PowerOP and 
PowerOP contains little else, but both levels know how to understand the 
MSR format, and a more aggressive port to PowerOP could do away with that).

Your suggestions of changes to cpufreq governors and policies to handle 
governance of non-cpu-speed parameters sound interesting, and I'd be 
happy to help figure out what to do about those vs. the lower machine 
access layer I've discussed up until now.  I'll think more about this 
real soon now.  Thanks,

-- 
Todd
