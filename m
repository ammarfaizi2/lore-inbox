Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267851AbUIAXVx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267851AbUIAXVx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 19:21:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268086AbUIAXRt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 19:17:49 -0400
Received: from adsl-209-204-138-32.sonic.net ([209.204.138.32]:51928 "EHLO
	server.home") by vger.kernel.org with ESMTP id S268082AbUIAXQe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 19:16:34 -0400
Date: Wed, 1 Sep 2004 16:16:09 -0700 (PDT)
From: Christoph Lameter <christoph@lameter.com>
X-X-Sender: christoph@server.home
To: john stultz <johnstul@us.ibm.com>
cc: Tim Schmielau <tim@physik3.uni-rostock.de>,
       george anzinger <george@mvista.com>, Andrew Morton <akpm@osdl.org>,
       OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
       albert@users.sourceforge.net, lkml <linux-kernel@vger.kernel.org>,
       voland@dmz.com.pl, nicolas.george@ens.fr, kaukasoi@elektroni.ee.tut.fi,
       david+powerix@blue-labs.org
Subject: Re: [RFC] New timeofday implementation proposal
In-Reply-To: <1092773633.2429.176.camel@cog.beaverton.ibm.com>
Message-ID: <Pine.LNX.4.58.0409011601230.9794@server.home>
References: <1087948634.9831.1154.camel@cube>  <87smcf5zx7.fsf@devron.myhome.or.jp>
  <20040816124136.27646d14.akpm@osdl.org> 
 <Pine.LNX.4.53.0408170055180.14122@gockel.physik3.uni-rostock.de> 
 <412151CA.4060902@mvista.com>  <Pine.LNX.4.53.0408170851020.15157@gockel.physik3.uni-rostock.de>
  <1092773244.2429.170.camel@cog.beaverton.ibm.com>
 <1092773633.2429.176.camel@cog.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Score: -4.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Aug 2004, john stultz wrote:

> o Consolidates a large amount of code:
> 	Allows for shared times source implementations, such as: i386, x86-64
> and ia64 all use HPET, i386 and x86-64 both have ACPI PM timers, and
> i386 and ia64 both have cyclone counters. Time sources are just drivers!
> Also work for user space gettimeofday implementations will be able to be
> shared across all arches (assuming the hardware time source can be
> safely accessed from user space).

What about a hardware time source that can be safely accessed with a fast
system call (f.e. via epc on IA64)? My tests indicate that such an
implementation is comparable to a user space memory mapped solution. The
user space memory mapping might generate complexities. Especially since
the page mapped for a memory mapped timer may allow access to hardware
information that should not be exposed to user space.

The time interpolator patches that I posted a while back provide a
generic interface to timer registers / values which may be useful to what
you are trying to accomplish. The C code for that patch is platform
independent but there is also an asm fast path that is specific to IA64.
Other arches could develop similar fastpaths.

> o Uses nanoseconds as the kernel's base time unit.
> 	Rather then doing ugly manipulations to timevals or timespecs, this
> simplifies math, and gives us plenty of room to grow (64bits of
> nanoseconds ~= 584 years).

The nanoseconds patch that was accepted into 2.6.9-rc1 does do that
partially by providing a getnstimeofday and centralizing the instances
where microseconds are multiplied by 1000 get to nanoseconds.

> o Have to convert back to time_val for syscall interface

This is mostly covered by gettimeofday()

> o ntp_scale(ns):  scales ns by NTP scaling factor
> 	- costly, but correct.

May we would need 128bit arithmetic to increase the accurary of the
scaling?

> o Some arches (arm, for example) do not have high res  timing hardware
> 	- In this case we can have a "jiffies" timesource
> 		- cyc2ns(x) =  x*(NSEC_PER_SEC/HZ)
> 		- doesn't work for tickless systems

Most arches have already high res time sources. I think we just need to
make proper use of them.

> o suspend/resume
> 	- need to pause and restart the timesource reads
> 	- we don't want a gigantic or negative offset!

Some intelligent timer needs to survive the suspend. Timers may need an
attribute to show if they continue counting through suspense/resume etc
(various power conditions etc....)

Hope this helps ....
