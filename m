Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269046AbUIMWwN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269046AbUIMWwN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Sep 2004 18:52:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269026AbUIMWuM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Sep 2004 18:50:12 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:40903 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S269034AbUIMWsy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Sep 2004 18:48:54 -0400
Date: Mon, 13 Sep 2004 15:45:24 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
X-X-Sender: clameter@schroedinger.engr.sgi.com
To: john stultz <johnstul@us.ibm.com>
cc: george anzinger <george@mvista.com>,
       Albert Cahalan <albert@users.sourceforge.net>,
       lkml <linux-kernel@vger.kernel.org>, tim@physik3.uni-rostock.de,
       Ulrich.Windl@rz.uni-regensburg.de, Len Brown <len.brown@intel.com>,
       linux@dominikbrodowski.de, David Mosberger <davidm@hpl.hp.com>,
       Andi Kleen <ak@suse.de>, paulus@samba.org, schwidefsky@de.ibm.com,
       jimix@us.ibm.com, keith maanthey <kmannth@us.ibm.com>,
       greg kh <greg@kroah.com>, Patricia Gaughen <gone@us.ibm.com>,
       Chris McDermott <lcm@us.ibm.com>
Subject: Re: [RFC][PATCH] new timeofday core subsystem (v.A0)
In-Reply-To: <1095114307.29408.285.camel@cog.beaverton.ibm.com>
Message-ID: <Pine.LNX.4.58.0409131534320.616@schroedinger.engr.sgi.com>
References: <1094159238.14662.318.camel@cog.beaverton.ibm.com> 
 <1094159379.14662.322.camel@cog.beaverton.ibm.com>  <4137CB3E.4060205@mvista.com>
 <1094193731.434.7232.camel@cube>  <41381C2D.7080207@mvista.com> 
 <1094239673.14662.510.camel@cog.beaverton.ibm.com>  <4138EBE5.2080205@mvista.com>
  <1094254342.29408.64.camel@cog.beaverton.ibm.com>  <41390622.2010602@mvista.com>
  <1094666844.29408.67.camel@cog.beaverton.ibm.com>  <413F9F17.5010904@mvista.com>
  <1094691118.29408.102.camel@cog.beaverton.ibm.com> 
 <Pine.LNX.4.58.0409082005370.28366@schroedinger.engr.sgi.com> 
 <1094700768.29408.124.camel@cog.beaverton.ibm.com>  <413FDC9F.1030409@mvista.com>
  <1094756870.29408.157.camel@cog.beaverton.ibm.com>  <4140C1ED.4040505@mvista.com>
  <Pine.LNX.4.58.0409131420500.490@schroedinger.engr.sgi.com>
 <1095114307.29408.285.camel@cog.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Sep 2004, john stultz wrote:
> My first pass comments:
> o How would settimeofday work? Would it be forced to use
> time_adjust_XYZ? Do we still need the wall_to_monotonic uglyness to
> manage posix CLOCK_MONOTONIC timers?

You could simply set xtime and time_source_last = time_source_get(time_source);

I think the existing wall_to_monotonic stuff is okay. Monotonic time is
rarely used and thus its best to keep xtime on CLOCK_REALTIME to simplify
things for general time access.

> My suggestion: split xtime into two values (system_time,
> wall_time_offset) like in my proposal. This allows you to keep a true
> monotonically increasing time base (system_time) and wall_time_offset
> can then be used to adjust to wall time. settimeofday() would only
> change wall_time_offset.

xtime is also truly monotonic increasing in my proposal. Setting the time
is an extraordinary event which I would not count against monotoneity. The
clock corrections that I proposed all preserve the monotoneity of xtime.

> o time_source_to_ns() needs some method of masking the subtraction in
> order to handle timesources that overflow under 64 bits.

Yes. My interpolator logic limits begin to show....

> o How would your time_adjust_XYZ interfaces merge w/ adjtimex and the
> NTP wall_time_update()/second_overflow() code? I spent quite a bit of
> time on my ntp.c implementation and I'm not 100% confident in it. Could
> you explain in further detail how yours would work?

I have no idea how adjtimex works. Would have to look at that in detail
first. The timer interpolator stuff also does time adjustments and I am
sure that something like that is in my mind. The time interpolator only
ever corrects the clock forward. Otherwise it adjusts the scaling if the
clock is running too fast. Thats also what I provided in the proposal.

> o My only other nit is that you use a different name then xtime. If
> you're changing the type, you might as well use a meaningful name.

xtime is the traditional name. Maybe renaming it to intentionally break
old code would be good but I thought it would be good to understand
the approach.

> Unfortunately I'm off working on other things for the next two weeks,
> but once that is over I look forward to trying to integrate some of your
> design ideas into my own.  Keeping my timeofday and ntp core code, but
> using your timesource interface looks to be quite promising.

That sounds very promising. I may also have to make time for
different projects but I will try to do as much as I can.
