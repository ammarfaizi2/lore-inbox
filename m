Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750991AbVHJAdr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750991AbVHJAdr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Aug 2005 20:33:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750997AbVHJAdq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Aug 2005 20:33:46 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:29938 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S1750991AbVHJAdq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Aug 2005 20:33:46 -0400
Message-ID: <42F94B68.6060107@mvista.com>
Date: Tue, 09 Aug 2005 17:33:44 -0700
From: Todd Poynor <tpoynor@mvista.com>
User-Agent: Mozilla Thunderbird 1.0+ (X11/20050531)
MIME-Version: 1.0
To: Geoff Levand <geoffrey.levand@am.sony.com>
CC: linux-kernel@vger.kernel.org, linux-pm@lists.osdl.org,
       cpufreq@lists.linux.org.uk
Subject: Re: [linux-pm] PowerOP 1/3: PowerOP core
References: <20050809025157.GB25064@slurryseal.ddns.mvista.com> <42F8D4C5.2090800@am.sony.com>
In-Reply-To: <42F8D4C5.2090800@am.sony.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Geoff Levand wrote:

> I'm wondering if anything could be gained by having the whole 
> struct powerop_point defined in asm/powerop.h, and treat it as an 
> opaque structure at this level.  That way, things other than just 
> ints could be passed between the policy manager and the backend, 
> although I guess that breaks the beauty of the simplicity and would 
> complicate the sys-fs interface, etc.  I'm interested to hear your 
> comments.

Making the "operating point" data structure entirely platform-specific 
should be OK.  There's a little value to having generic pieces handle 
some common chores (such as the sysfs interfaces), but even for integers 
decimal vs. hex formatting is nicer depending on the type of value. 
Since most values that have been managed using similar interfaces thus 
far have been flags, register values, voltages, etc. using integers has 
worked well and nicely simplified the platform backend, but if there's a 
need for other data types then should be doable.

> Another point is that a policy manager would need to poll the system 
> and/or get events and then act.  Your powerop work here only provides 
> a (one way) piece of the final action.  Any comments regarding a more 
> general interface?

What's discussed here is probably the bottommost layer of a power 
management software stack: to read and write the platform-specific 
system power parameters, optionally arranged into a mutually-consistent 
set called an "operating point".  Power policy management is a large, 
thorny topic that I wasn't trying to tackle now.

So far as kernel-to-userspace event notification goes (assuming the 
power policy manager is in userspace, which is certainly where I'd 
recommend), ACPI has a procfs-based communication channel but the 
kobject_uevent stuff looks like the way I'd go, and it's somewhere on my 
list to come up with a patch that does that as well.

If these general ideas of arbitrary platform power parameters and 
operating points are deemed worthy of continued consideration, I'll 
propose what I view is the next step: interfaces to create and activate 
operating points from userspace.

At that point it should be possible to write power policy management 
applications for systems that can benefit from this generalized notion 
of operating points: create the operating points that match the system 
usage models (in the case of many embedded systems, the system is some 
mode with different power/performance characteristics such as audio 
playback vs. mobile phone call in progress) and power needs (e.g., low 
battery strength vs. high strength) and activate operating points based 
on events received (new app running, low battery warning, etc.).

Any opinions on all that?  Thanks,

-- 
Todd
