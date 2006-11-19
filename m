Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932766AbWKSSWJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932766AbWKSSWJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Nov 2006 13:22:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932769AbWKSSWJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Nov 2006 13:22:09 -0500
Received: from smtp.osdl.org ([65.172.181.25]:61107 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932766AbWKSSWH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Nov 2006 13:22:07 -0500
Date: Sun, 19 Nov 2006 10:21:52 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
cc: Chuck Ebbert <76306.1226@compuserve.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [patch] PM: suspend/resume debugging should depend on 
 SOFTWARE_SUSPEND
In-Reply-To: <200611191844.14354.rjw@sisk.pl>
Message-ID: <Pine.LNX.4.64.0611191008310.3692@woody.osdl.org>
References: <200611190320_MC3-1-D21B-111C@compuserve.com>
 <Pine.LNX.4.64.0611190930370.3692@woody.osdl.org> <200611191844.14354.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 19 Nov 2006, Rafael J. Wysocki wrote:
>
> In fact that's up to 30 seconds on a modern box, usually less than that.

Right. If the machine boots quickly, it's fast. Of course, if the machine 
boots quickly, you might as well often just shut down and reboot.

> And suspend-to-ram doesn't work on quilte a lot of boxes right now.  Also, you
> can use the software suspend on boxes that don't support the suspend-to-ram
> at all.

One large reason STR often doesn't work is that people don't even test it, 
because people point to the suspend-to-disk instead.  suspend-to-disk is 
the problem, not the solution.

I've been working at making the machines I have able to STR, and almost 
always it's a driver that is buggy. Thank God for the suspend/resume 
debugging - the thing that Chuck tried to disable. That's often the _only_ 
way to debug these things, and it's actually pretty powerful (but 
time-consuming - having to insert TRACE_RESUME() markers into the device 
driver that doesn't resume and recompile and reboot).

Anyway, the way to debug this for people who are interested (have a 
machine that doesn't boot) is:

 - enable PM_DEBUG, and PM_TRACE

 - use a script like this:

	#!/bin/sh
	sync
	echo 1 > /sys/power/pm_trace
	echo mem > /sys/power/state

   to suspend

 - if it doesn't come back up (which is usually the problem), reboot by 
   holding the power button down, and look at the dmesg output for things 
   like

	Magic number: 4:156:725
	hash matches drivers/base/power/resume.c:28
	hash matches device 0000:01:00.0

   which means that the last trace event was just before trying to resume 
   device 0000:01:00.0. Then figure out what driver is controlling that 
   device (lspci and /sys/devices/pci* is your friend), and see if you can 
   fix it, disable it, or trace into its resume function.

For example, the above happens to be the VGA device on my EVO, which I 
used to run with "radeonfb" (it's an ATI Radeon mobility). It turns out 
that "radeonfb" simply cannot resume that device - it tries to set the 
PLL's, and it just _hangs_. Using the regular VGA console and letting X 
resume it instead works fine.

The point being that PM_TRACE is wonderful, and it's wonderful exactly for 
NOT using suspend-to-disk. The other point being that people have gotten 
lazy, and accept half a minute (minimum - usually it's longer) boot times, 
when STR is a lot more pleasant, but it does require some detective work 
when it doesn't boot.

I wish more people tried STR, instead of having the STD people tell them 
not to!

		Linus
