Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267180AbUIODgk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267180AbUIODgk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 23:36:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267184AbUIODgk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 23:36:40 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:20946 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S267180AbUIODgg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 23:36:36 -0400
Date: Tue, 14 Sep 2004 20:32:49 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
X-X-Sender: clameter@schroedinger.engr.sgi.com
To: George Anzinger <george@mvista.com>
cc: john stultz <johnstul@us.ibm.com>,
       Albert Cahalan <albert@users.sourceforge.net>,
       lkml <linux-kernel@vger.kernel.org>, tim@physik3.uni-rostock.de,
       Ulrich.Windl@rz.uni-regensburg.de, Len Brown <len.brown@intel.com>,
       linux@dominikbrodowski.de, David Mosberger <davidm@hpl.hp.com>,
       Andi Kleen <ak@suse.de>, paulus@samba.org, schwidefsky@de.ibm.com,
       jimix@us.ibm.com, keith maanthey <kmannth@us.ibm.com>,
       greg kh <greg@kroah.com>, Patricia Gaughen <gone@us.ibm.com>,
       Chris McDermott <lcm@us.ibm.com>
Subject: Re: [RFC][PATCH] new timeofday core subsystem (v.A0)
In-Reply-To: <41479369.6020506@mvista.com>
Message-ID: <Pine.LNX.4.58.0409142024270.10739@schroedinger.engr.sgi.com>
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
 <Pine.LNX.4.58.0409141045370.6963@schroedinger.engr.sgi.com>
 <41479369.6020506@mvista.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Sep 2004, George Anzinger wrote:

> > u64 time_source_to_ns(u64 x) {
> > 	return (((x-time_source_at_base) & time_source->mask)*time_source->multiply) >> time_source->shift;
> > }
>
> This seems to assume that the time souce is incrementing.  On some archs, I
> think, it decrements...

This could be handled by a function that transforms the value read from
the counter into an incrementing value. I.e.

u64 get_rev_timerval(void) {
	return  1<< 55 - readq(TIMER_PORT);
}

> So we would do "time_adjust_skip(0);" to update time_source_at_base?

There is no reason to update time_source_at_base unless adjustments need
to be done or a danger exists of the counter wrapping around (16 bit
counter?)

> If we do a "good" job of choosing <multiply> and <shift> this will be a "very"
> small change.  Might be better to pass in a "delta" to change it by.  Then you
> would only need one function.

These are the raw routines. Higher level function could translate a delta
into the appropriate adjustments.

> The mask and the shift value are not really related.  The mask is a function of
> the number of bits the hardware provides.  The shift is related to the value of
> freq.  Me thinks they should not be tied together here.

They are related because the maximum shift for a 64 bit value without
loosing bits is 64 - number of significant bits. This basically insures
maximum precision when scaling the counter.


> > /* Values in use in the kernel and how they may be derived from xtime */
> > #define jiffies (now()/1000000)
>
> This assumes HZ=1000.  (Assuming there is an HZ any more, that is.)  Not all
> archs will want this value.  Possibly:
> #define jiffies ((now() * HZ) / 1000000000)

Right. I just thought of the standard case HZ=1000.

> > u64 get_cpu_time_filtered() {
> > 	u64 x;
> > 	u64 l;
> This will need to be "static";

Nope. time_source_last is the global. l is just a copy of
time_source_last.

> Ok, so now lets hook this up with interval timers:
>
> #define ns_per_jiffie (NSEC_PER_SEC / HZ)
> #define jiffies_to_ns(jiff) (jiff * ns_per_jiffie)
>
> This function is a request to interrupt at the next jiffie after the passed
> reference jiffie.  If that time is passed return true, else false.

One could do this but we want to have a tickless system. The tick is only
necessary if the time needs to be adjusted.

But you are right there is the need for timer event scheduling that is
not included yet. This should be a method of the time source.

