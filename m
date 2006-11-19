Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932857AbWKSS7I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932857AbWKSS7I (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Nov 2006 13:59:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932887AbWKSS7I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Nov 2006 13:59:08 -0500
Received: from ogre.sisk.pl ([217.79.144.158]:28599 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S932857AbWKSS7H (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Nov 2006 13:59:07 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [patch] PM: suspend/resume debugging should depend on  SOFTWARE_SUSPEND
Date: Sun, 19 Nov 2006 19:55:23 +0100
User-Agent: KMail/1.9.1
Cc: Chuck Ebbert <76306.1226@compuserve.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
References: <200611190320_MC3-1-D21B-111C@compuserve.com> <200611191844.14354.rjw@sisk.pl> <Pine.LNX.4.64.0611191008310.3692@woody.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0611191008310.3692@woody.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611191955.23782.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday, 19 November 2006 19:21, Linus Torvalds wrote:
> 
> On Sun, 19 Nov 2006, Rafael J. Wysocki wrote:
> >
> > In fact that's up to 30 seconds on a modern box, usually less than that.
> 
> Right. If the machine boots quickly, it's fast. Of course, if the machine 
> boots quickly, you might as well often just shut down and reboot.

Yes, if the only thing you want to run is the kernel.  The applications aren't
going to start so quickly, you know. ;-)

> > And suspend-to-ram doesn't work on quilte a lot of boxes right now.  Also, you
> > can use the software suspend on boxes that don't support the suspend-to-ram
> > at all.
> 
> One large reason STR often doesn't work is that people don't even test it,

Well, the majority of bugzilla reports I'm tracking are STR-related, so people
_do_ test it, really.

> because people point to the suspend-to-disk instead.

Who they?

> suspend-to-disk is the problem, not the solution.

If given machine doesn't support the STR or has a broken BIOS (which means
pretty much the same), the suspend-to-disk is the _only_ way in which you can
suspend it.

I guess you're referring to using the suspend-to-disk instead of the STR which
wouldn't be very reasonable indeed, but still I don't know why you consider
it as a problem.

> I've been working at making the machines I have able to STR, and almost 
> always it's a driver that is buggy. Thank God for the suspend/resume 
> debugging - the thing that Chuck tried to disable. That's often the _only_ 
> way to debug these things, and it's actually pretty powerful (but 
> time-consuming - having to insert TRACE_RESUME() markers into the device 
> driver that doesn't resume and recompile and reboot).
> 
> Anyway, the way to debug this for people who are interested (have a 
> machine that doesn't boot) is:
> 
>  - enable PM_DEBUG, and PM_TRACE

This only works on i386, no?

>  - use a script like this:
> 
> 	#!/bin/sh
> 	sync
> 	echo 1 > /sys/power/pm_trace
> 	echo mem > /sys/power/state
> 
>    to suspend
> 
>  - if it doesn't come back up (which is usually the problem), reboot by 
>    holding the power button down, and look at the dmesg output for things 
>    like
> 
> 	Magic number: 4:156:725
> 	hash matches drivers/base/power/resume.c:28
> 	hash matches device 0000:01:00.0
> 
>    which means that the last trace event was just before trying to resume 
>    device 0000:01:00.0. Then figure out what driver is controlling that 
>    device (lspci and /sys/devices/pci* is your friend), and see if you can 
>    fix it, disable it, or trace into its resume function.
> 
> For example, the above happens to be the VGA device on my EVO, which I 
> used to run with "radeonfb" (it's an ATI Radeon mobility). It turns out 
> that "radeonfb" simply cannot resume that device - it tries to set the 
> PLL's, and it just _hangs_. Using the regular VGA console and letting X 
> resume it instead works fine.
> 
> The point being that PM_TRACE is wonderful, and it's wonderful exactly for 
> NOT using suspend-to-disk. The other point being that people have gotten 
> lazy, and accept half a minute (minimum - usually it's longer) boot times, 
> when STR is a lot more pleasant, but it does require some detective work 
> when it doesn't boot.
> 
> I wish more people tried STR, instead of having the STD people tell them 
> not to!

I don't know of anyone who's doing that.

Yes, we often ask people to try the STD when they report a problem with the
STR to get one more data point, but that doesn't mean we tell them not to try
the STR any more.  Bug reports regarding the STR are accepted and welcome.

Greetings,
Rafael


-- 
You never change things by fighting the existing reality.
		R. Buckminster Fuller
