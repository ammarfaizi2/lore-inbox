Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269015AbUIMWhI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269015AbUIMWhI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Sep 2004 18:37:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269000AbUIMWhH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Sep 2004 18:37:07 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:13481 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S269018AbUIMW3W
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Sep 2004 18:29:22 -0400
Subject: Re: [RFC][PATCH] new timeofday core subsystem (v.A0)
From: john stultz <johnstul@us.ibm.com>
To: Christoph Lameter <clameter@sgi.com>
Cc: george anzinger <george@mvista.com>,
       Albert Cahalan <albert@users.sourceforge.net>,
       lkml <linux-kernel@vger.kernel.org>, tim@physik3.uni-rostock.de,
       Ulrich.Windl@rz.uni-regensburg.de, Len Brown <len.brown@intel.com>,
       linux@dominikbrodowski.de, David Mosberger <davidm@hpl.hp.com>,
       Andi Kleen <ak@suse.de>, paulus@samba.org, schwidefsky@de.ibm.com,
       jimix@us.ibm.com, keith maanthey <kmannth@us.ibm.com>,
       greg kh <greg@kroah.com>, Patricia Gaughen <gone@us.ibm.com>,
       Chris McDermott <lcm@us.ibm.com>
In-Reply-To: <Pine.LNX.4.58.0409131420500.490@schroedinger.engr.sgi.com>
References: <1094159238.14662.318.camel@cog.beaverton.ibm.com>
	 <1094159379.14662.322.camel@cog.beaverton.ibm.com>
	 <4137CB3E.4060205@mvista.com> <1094193731.434.7232.camel@cube>
	 <41381C2D.7080207@mvista.com>
	 <1094239673.14662.510.camel@cog.beaverton.ibm.com>
	 <4138EBE5.2080205@mvista.com>
	 <1094254342.29408.64.camel@cog.beaverton.ibm.com>
	 <41390622.2010602@mvista.com>
	 <1094666844.29408.67.camel@cog.beaverton.ibm.com>
	 <413F9F17.5010904@mvista.com>
	 <1094691118.29408.102.camel@cog.beaverton.ibm.com>
	 <Pine.LNX.4.58.0409082005370.28366@schroedinger.engr.sgi.com>
	 <1094700768.29408.124.camel@cog.beaverton.ibm.com>
	 <413FDC9F.1030409@mvista.com>
	 <1094756870.29408.157.camel@cog.beaverton.ibm.com>
	 <4140C1ED.4040505@mvista.com>
	 <Pine.LNX.4.58.0409131420500.490@schroedinger.engr.sgi.com>
Content-Type: text/plain
Message-Id: <1095114307.29408.285.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Mon, 13 Sep 2004 15:25:09 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-09-13 at 14:29, Christoph Lameter wrote:
> Hmm... I am still thinking that making xtime an u64 could help simplify a
> lot of things. Together with some other parameters it would allow a
> tickless system where there is no need to update xtime regularly. It would
> also simplify gettimeofday and jiffies calculation.

Looks interesting! Regardless of our earlier butting heads, both this
and my earlier proposal are indeed very similar. 

My first pass comments:
o How would settimeofday work? Would it be forced to use
time_adjust_XYZ? Do we still need the wall_to_monotonic uglyness to
manage posix CLOCK_MONOTONIC timers? 

My suggestion: split xtime into two values (system_time,
wall_time_offset) like in my proposal. This allows you to keep a true
monotonically increasing time base (system_time) and wall_time_offset
can then be used to adjust to wall time. settimeofday() would only
change wall_time_offset. 

o time_source_to_ns() needs some method of masking the subtraction in
order to handle timesources that overflow under 64 bits. 

o How would your time_adjust_XYZ interfaces merge w/ adjtimex and the
NTP wall_time_update()/second_overflow() code? I spent quite a bit of
time on my ntp.c implementation and I'm not 100% confident in it. Could
you explain in further detail how yours would work?

o My only other nit is that you use a different name then xtime. If
you're changing the type, you might as well use a meaningful name.

Unfortunately I'm off working on other things for the next two weeks,
but once that is over I look forward to trying to integrate some of your
design ideas into my own.  Keeping my timeofday and ntp core code, but
using your timesource interface looks to be quite promising. 

thanks
-john

