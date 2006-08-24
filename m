Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030491AbWHXV5n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030491AbWHXV5n (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 17:57:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030492AbWHXV5n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 17:57:43 -0400
Received: from a222036.upc-a.chello.nl ([62.163.222.36]:58508 "EHLO
	laptopd505.fenrus.org") by vger.kernel.org with ESMTP
	id S1030491AbWHXV5l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 17:57:41 -0400
Subject: Re: [RFC] maximum latency tracking infrastructure
From: Arjan van de Ven <arjan@linux.intel.com>
To: dwalker@mvista.com
Cc: linux-kernel@vger.kernel.org, len.brown@intel.com
In-Reply-To: <1156456349.6951.10.camel@dwalker1.mvista.com>
References: <1156441295.3014.75.camel@laptopd505.fenrus.org>
	 <1156456349.6951.10.camel@dwalker1.mvista.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 24 Aug 2006 23:57:24 +0200
Message-Id: <1156456644.3014.95.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-08-24 at 14:52 -0700, Daniel Walker wrote:
> On Thu, 2006-08-24 at 19:41 +0200, Arjan van de Ven wrote:
> > Subject: [RFC] maximum latency tracking infrastructure
> > From: Arjan van de Ven <arjan@linux.intel.com>
> > 
> > The patch below adds infrastructure to track "maximum allowable latency" for power
> > saving policies.
> > 
> > The reason for adding this infrastructure is that power management in the
> > idle loop needs to make a tradeoff between latency and power savings (deeper
> > power save modes have a longer latency to running code again). 
> > The code that today makes this tradeoff just does a rather simple algorithm;
> 
> I was just thinking that it might be cleaner to register a structure
> instead of tracking identifiers to usecs. You might get a speed up on
> some of the operations, like unregister.

it makes things a lot more complex for both the user and the
infrastructure though, and I doubt it's going to be a performance gain;
you need to walk all registered items anyway to decide the new minimum
value if you unregister one for example.


> Another thing I was thinking about is that this seems somewhat contrary
> to the idea of using dynamic tick (assuming it was in mainline) to
> heuristically pick a power state. Do you have any thoughts on how you
> would combine the two?

Actually it's designed in part FOR this case!
So how that will work (thought experiment, I don't have the code yet)

In idle, determine the time the next scheduled event is.
Then given that time go over the C-states and pick the deepest C-state
that
1) satisfies the requested latency
2) has a latency that is a small enough fraction of the total time

(2 is needed to not pick a 1 msec-latency C state for a 1ms idle, that
won't save you power most likely, so you need to have enough time in
"real" idle)

so when you know your latency requirements, you now can pick a DEEPER
sleepstate than you could before (or at least the right one)... dynticks
needs this more than anything :)

