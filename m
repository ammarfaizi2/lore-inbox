Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269265AbUIIDSQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269265AbUIIDSQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Sep 2004 23:18:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269262AbUIIDSP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Sep 2004 23:18:15 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:6869 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S269265AbUIIDRz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Sep 2004 23:17:55 -0400
Date: Wed, 8 Sep 2004 20:14:25 -0700 (PDT)
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
In-Reply-To: <1094691118.29408.102.camel@cog.beaverton.ibm.com>
Message-ID: <Pine.LNX.4.58.0409082005370.28366@schroedinger.engr.sgi.com>
References: <1094159238.14662.318.camel@cog.beaverton.ibm.com> 
 <1094159379.14662.322.camel@cog.beaverton.ibm.com>  <4137CB3E.4060205@mvista.com>
 <1094193731.434.7232.camel@cube>  <41381C2D.7080207@mvista.com> 
 <1094239673.14662.510.camel@cog.beaverton.ibm.com>  <4138EBE5.2080205@mvista.com>
  <1094254342.29408.64.camel@cog.beaverton.ibm.com>  <41390622.2010602@mvista.com>
  <1094666844.29408.67.camel@cog.beaverton.ibm.com>  <413F9F17.5010904@mvista.com>
 <1094691118.29408.102.camel@cog.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 Sep 2004, john stultz wrote:

> Why must we use jiffies to tell when a timer expires? Honestly I'd like
> to see xtime and jiffies both disappear, but I'm not very familiar w/
> the soft-timer code, so forgive me if I'm misunderstanding.
>
> So instead of calculating delta_jiffies, just mark the timer to expire
> at B. Then each interrupt, you use get_fast_timestamp() to decide if now
> is greater then B. If so, expire it.
>
> Then we can look at being able to program timer interrupts to occur as
> close as possible to the next soft-timer's expiration time.

Would it not be best to have some means to determine the time in
nanoseconds since the epoch and then use that for long waits? That cuts
out the timer dependencies. Could we have a generic interface for kernel
time that simply provides nanoseconds for everything and hides all the
details of time scaling?

Maybe as simple as

u64 now(void);

?

One can then calculate the wait time in nanoseconds which may then be
passed to another timer routine which may take the appropriate action
depending on the time frame involved. I.e. for a few hundred nsecs do busy
wait. If longer reschedule and if even longer queue the task on some
event queue that is handled by the timer tick or something else.

