Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932495AbVJSJSB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932495AbVJSJSB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Oct 2005 05:18:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932491AbVJSJRj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Oct 2005 05:17:39 -0400
Received: from sccrmhc14.comcast.net ([204.127.202.59]:38335 "EHLO
	sccrmhc14.comcast.net") by vger.kernel.org with ESMTP
	id S932488AbVJSJRT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Oct 2005 05:17:19 -0400
Message-Id: <20051019081906.615365000@omelas>
Date: Wed, 19 Oct 2005 01:19:06 -0700
From: dsaxena@plexity.net
To: linux-kernel@vger.kernel.org
Cc: jgarzik@pobox.net, akpm@osdl.org, tony@atomide.com
Subject: [patch 0/5] RNG cleanup & new drivers attempt #1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set is my first pass at adding support for some more
RNG drivers to the kernel. My basic goal was to keep the same
user space interface as exists, but not have to reproduce all
the same 100 lines of user space interface code across every new
driver (as we currently do with watchdogs...)

The new code separate the HW specifc driver from the user 
interface code and just adds a few function pointers so that
the two can talk to each other. I opted out of using a sysfs
class and all that complication b/c there will be one and only
one RNG device at a time from all the HW I can see.

I've added drivers for Intels' IXP4xx and for the TI OMAP,
though the later has not been tested (it builds) as I don't 
have the hardware. Same goes for x86...builds but no HW for 
me to test locally. Freescale MPC8xxx is next but that requires 
a bit more work.

As for the discussion on moving the implementation completely
out of the kernel, it is not completely doable. While we
can do it for simple HW such as the IXP and X86, there are
some cases that basically require us to have kernel code:

- On systems like OMAP, we want to be able to suspend/resume
  the RNG device and the device clocks and that needs to be done
  from kernel space as part of the PM path.

- On the MPC8xxx, the RNG is just part of a large crypto unit
  that also does SHA-1 and MD5 along with some other operations
  for which I'd like to see (and will probably write) a driver. The 
  RNG commands are queued in a chain along with the other units and 
  trying to get user space to share that queue will just be a mess.

So..we might as well keep them all in the kernel instead of having 
to know about some HW and not know about others.

Some of the things on my TODO list:

- Allow a fastpath where we don't even have the user space portion
  and the HW drivers just feed the entropy pool directly. While
  this bypasses the FIPS tests and such, there are some applications
  where this is OK or where we really don't want the extra proccess 
  context switching. This is specially true on ARM. I'll have to add 
  IRQ driven support to the drivers to that, but that's trivial. There 
  is also some HW (MPC8xxx for example) that does periodic self-tests 
  in HW and lists itself as "FIPs-compliant" and will trigger an error if 
  data should no longer be trusted and in that case doing a software
  test might also be undesirable. But...we should let the user decide
  at build time (or runtime?).

- Since I'm adding IRQ support, go ahead and add poll(2) support so
  that when we do have a user space daemon, it's not constantly
  poking at us.

~Deepak

(This is my first time using the magical quilt mail scripts so apologies
 in advance if anything breaks)

--
Deepak Saxena - dsaxena@plexity.net - http://www.plexity.net

Even a stopped clock gives the right time twice a day.
