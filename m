Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270973AbUJUVh4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270973AbUJUVh4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 17:37:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270840AbUJUVhI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 17:37:08 -0400
Received: from fmr05.intel.com ([134.134.136.6]:43692 "EHLO
	hermes.jf.intel.com") by vger.kernel.org with ESMTP id S270983AbUJUVdS convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 17:33:18 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Subject: RE: gradual timeofday overhaul
Date: Thu, 21 Oct 2004 14:32:38 -0700
Message-ID: <F989B1573A3A644BAB3920FBECA4D25A011F96DC@orsmsx407>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: gradual timeofday overhaul
Thread-Index: AcS3s3IKJvkLbdVAQ2GwUWZ7o2QqfQAAMC4g
From: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
To: <george@mvista.com>
Cc: <root@chaos.analogic.com>, "Brown, Len" <len.brown@intel.com>,
       "Tim Schmielau" <tim@physik3.uni-rostock.de>,
       "john stultz" <johnstul@us.ibm.com>,
       "lkml" <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 21 Oct 2004 21:32:55.0681 (UTC) FILETIME=[871A0710:01C4B7B5]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: George Anzinger [mailto:george@mvista.com]
>
> Perez-Gonzalez, Inaky wrote:
> 
> > But you can also schedule, before switching to the new task,
> > a local interrupt on the running processor to mark the end
> > of the timeslice. When you enter the scheduler, you just need
> > to remove that; devil is in the details, but it should be possible
> > to do in a way that doesn't take too much overhead.
> 
> Well, that is part of the accounting overhead the increases with context switch
> rate.  You also need to include the time it takes to figure out which of the
> time limits is closes (run time limit, profile time, slice time, etc).  Then,

I know these are specific examples, but:

- profile time is a periodic thingie, so if you have it, forget about
  having a tickless system. Periodic interrupt for this guy, get it 
  out of the equation.

- slice time vs runtime limit. I don't remember what is the granularity of
  the runtime limit, but it could be expressed in slice terms. If not,
  we are talking (along with any other times) of min() operations, which
  are just a few cycles each [granted, they add up].

> you also need to remove the timer when switching away.  No, it is not a lot, but
> it is way more than the nothing we do when we can turn it all over to the
> periodic tick.  The choice is load sensitive overhead vs flat overhead.

This is just talking out of my ass, but I guess that for each invocation
they will have more or less the same overhead in execution time, let's
say T. For the periodic tick, the total overhead (in a second) is T*HZ;
with tickless, it'd be T*number_of_context_switches_per_second, right?

Now, the ugly case would be if number_of_context_swiches_per_second > HZ.
In HZ = 100, this could be happening, but in HZ=1000, in a single CPU
...well, that would be TOO weird [of course, a real-time app with a 
1ms period would do that, but it'd require at least an HZ of 10000 to
work more or less ok and we'd be below the watermark].

So in most cases, and given the assumptions, we'd end up winning,
beause number_of_context..., even if variable, is going to be bound
on the upper side by HZ.

Well, you know way more than I do about this, so here is the question:
what is the error in that line of reasoning? 

Iñaky Pérez-González -- Not speaking for Intel -- all opinions are my own (and my fault)
