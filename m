Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261713AbVAYB4C@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261713AbVAYB4C (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 20:56:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261708AbVAYB4C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 20:56:02 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:24213 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S261713AbVAYBzl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 20:55:41 -0500
Date: Mon, 24 Jan 2005 17:54:35 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
X-X-Sender: clameter@schroedinger.engr.sgi.com
To: john stultz <johnstul@us.ibm.com>
cc: lkml <linux-kernel@vger.kernel.org>,
       Tim Schmielau <tim@physik3.uni-rostock.de>,
       George Anzinger <george@mvista.com>, albert@users.sourceforge.net,
       Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>,
       Dominik Brodowski <linux@dominikbrodowski.de>,
       David Mosberger <davidm@hpl.hp.com>, Andi Kleen <ak@suse.de>,
       paulus@samba.org, schwidefsky@de.ibm.com,
       keith maanthey <kmannth@us.ibm.com>, Patricia Gaughen <gone@us.ibm.com>,
       Chris McDermott <lcm@us.ibm.com>, Max Asbock <amax@us.ibm.com>,
       mahuja@us.ibm.com, Nishanth Aravamudan <nacc@us.ibm.com>,
       Darren Hart <darren@dvhart.com>, "Darrick J. Wong" <djwong@us.ibm.com>,
       Anton Blanchard <anton@samba.org>
Subject: Re: [RFC][PATCH] new timeofday core subsystem (v. A2)
In-Reply-To: <1106613222.30884.34.camel@cog.beaverton.ibm.com>
Message-ID: <Pine.LNX.4.58.0501241748090.18859@schroedinger.engr.sgi.com>
References: <1106607089.30884.10.camel@cog.beaverton.ibm.com> 
 <Pine.LNX.4.58.0501241513470.17986@schroedinger.engr.sgi.com> 
 <1106611416.30884.22.camel@cog.beaverton.ibm.com> 
 <Pine.LNX.4.58.0501241606240.17986@schroedinger.engr.sgi.com>
 <1106613222.30884.34.camel@cog.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Jan 2005, john stultz wrote:

> We talked about this last time. I do intend to re-work ntp_scale() so
> its not a function call, much as you describe above.
>
> hopelessly endeavoring,

hehe.... But seriously: The easiest approach may be to modify the time
sources to allow a fine tuning of the scaling factor. That way ntp_scale
may be moved into tick processing where it would adjust the scaling of the
time sources up or downward. Thus no ntp_scale in the monotonic clock
processing anymore.

Monotonic clocks could be calculated

monotime = ns_at_last_tick + (time_source_cycles_since_tick *
current_scaling_factor) >> shift_factor.

This would also be easy to implement in asm if necessary.

tick processing could then increment or decrement the current scaling
factor to minimize the error between ticks. It could also add
nanoseconds to ns_at_last_tick to correct the clock forward.

With the appropiate shift_factor one should be able to fine tune time much
more accurately than ntp_scale would do. Over time the necessary
corrections could be minimized to just adding a few ns once in a while.

