Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264048AbUEDUgr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264048AbUEDUgr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 May 2004 16:36:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264029AbUEDUgr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 May 2004 16:36:47 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:59125 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S264048AbUEDUgo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 May 2004 16:36:44 -0400
Message-ID: <4097FED8.3020003@mvista.com>
Date: Tue, 04 May 2004 13:36:40 -0700
From: Todd Poynor <tpoynor@mvista.com>
User-Agent: Mozilla Thunderbird 0.6 (X11/20040502)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Patrick Mochel <mochel@digitalimplant.org>
CC: linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Hotplug for device power state changes
References: <20040429202654.GA9971@dhcp193.mvista.com> <Pine.LNX.4.50.0405040819490.3562-100000@monsoon.he.net>
In-Reply-To: <Pine.LNX.4.50.0405040819490.3562-100000@monsoon.he.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patrick Mochel wrote:
>>A patch to call a hotplug device-power agent when the power state of a
>>device is modified at runtime (that is, individually via sysfs or by a
>>driver call, not as part of a system suspend/resume).  Allows a power
>>management application to be informed of changes in device power needs.
>>This can be useful on platforms with dependencies between system
>>clock/voltage settings and operation of certain devices (such as
>>PXA27x), or, for example, on a cell phone where voiceband or network
>>devices going inactive signals an opportunity to lower platform power
>>levels to conserve battery life.
> 
> 
> Why? If the device is powered down at runtime via sysfs, then the app that
> did that already exists in userspace, like the ones you're trying to
> notify via /sbin/hotplug. It would be much simpler for the first app to
> generate e.g. a d-bus message to notify other apps, rather than creating
> this conduit through the kernel.

The ability to do this was originally requested in the context of a 
driver managing the power state of its devices (according to some 
unspecified logic); agreed that state changes requested via sysfs are a 
less compelling usage scenario.  Small battery-powered gadgets often 
implement drivers that are more actively involved in managing power 
state than the desktop/notebook/server norm, invoking LDM suspend 
routines when an opportunity to power down arises.  But it is also 
common in wall-plug-wired systems to have a few power state transitions 
that result from things under kernel control, such as blanking a display 
device after a timer expires.

In many cases, the opportunity to move to a lower-power state may be 
triggered by userspace activity and would make a good candidate for a 
purely userspace notification method.  However, a kernel-to-userspace 
notification method is suggested for this to cover potential cases where 
a device power state change might not be directly caused by, or may be a 
non-obvious side effect of, an application action.  Display blanking is 
an example; other devices that can enter a low-power state due to 
inactivity or due to changes in power state of other upstream or 
downstream devices could also use this.  If anyone reading this has 
concrete examples that they would like to have considered then please do 
speak up.

It may be the case that most useful scenarios for userspace actions in 
response to device power state changes could be handled through a 
suitable implementation of D-BUS messages between applications, and I'd 
certainly support use of that model wherever possible.  Returning errors 
through the system call interface for an operation on a device file 
descriptor, as I believe you've suggested, may also help cover most 
useful cases.  I will continue to encourage the developers who have 
asked me for driver power state notifiers to chime in here with more 
details on their needs.

> Besides, if one process has a device open, then the driver should refuse
> any requests to power it down.

I'd suggest some latitude in driver handling of low-power device states 
wrt open file descriptors, such as for display blanking.  But yes, this 
is usually true (at least in the non-system-suspend case).


-- 
Todd Poynor
MontaVista Software

