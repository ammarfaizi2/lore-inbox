Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965107AbVHZQxU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965107AbVHZQxU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Aug 2005 12:53:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965110AbVHZQxU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Aug 2005 12:53:20 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:4805 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S965107AbVHZQxT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Aug 2005 12:53:19 -0400
Date: Fri, 26 Aug 2005 09:48:29 -0700 (PDT)
From: Christoph Lameter <clameter@engr.sgi.com>
To: Alex Williamson <alex.williamson@hp.com>
cc: linux@horizon.com, linux-kernel@vger.kernel.org
Subject: Re: Need better is_better_time_interpolator() algorithm
In-Reply-To: <1125011270.5331.122.camel@tdi>
Message-ID: <Pine.LNX.4.62.0508260934050.14940@schroedinger.engr.sgi.com>
References: <20050825214029.21209.qmail@science.horizon.com>
 <1125011270.5331.122.camel@tdi>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 Aug 2005, Alex Williamson wrote:

>    I don't really know if this makes sense, but it seems to do what I
> think it should.  If I where to add another node to the system, I would
> more strongly favor the HPETs time, if I removed a node I would revert
> to the cycle counter.  Anyway, I think it might be a good starting point
> for further experimentation.  Patch below.


Adding a node to the time interpolator does not make much sense since time 
needs to be universally accessible in order to be comparable. Unless you 
want to use the time interpolator time source as an interrupt source
then you may want to change the node that the timer interrupt runs on.

Some time source like the Altix RTC are not bound to any node but are 
available with a node local mmio instruction. There is no way to assign a 
node number to it.

Moreover you may derive the node number from the mmio address if the need 
really arises.

Also the latency is only a minor criterion in the determination of the 
most suitable clock. More important are the clock characteristics like
consistency over multiple processors, or the distribution of the timer.

One does not want a clock that is not consistent over multiple processors 
regardless of the latency. A distributed timer wins over a low latency 
timer on a node in a NUMA system.

I think it would be best add some flags that describe

1. The consistency scope of the time source
   i.e. TIME_SOURCE_SYNC_PROCESSOR	
		Access to the time source yields a processor local
		result
	TIME_SOURCE_SYNC_NODE
		Access to the time source yields a result that is the same
		for all processors on the same node
	TIME_SOURCE_SYNC_GLOBAL
		Access to the time source yields a globally consistent
		result

2. The locality of the time source
   TIME_SOURCE_IN_PROCESSOR	->	Processor is the time source
   TIME_SOURCE_DISTRIBUTED	->	Distributed time source
   TIME_SOURCE_NODE		->	memory mapped time source on a 
node.

Then the ITC would be configured as
	TIME_SOURCE_SYNC_PROCESSOR | TIME_SOURCE_IN_PROCESSOR

If the ITC is syncd up per node
	TIME_SOURCE_SYNC_NODE | TIME_SOURCE_IN_PROCESSOR

If this is an SMP system then it may even be
	TIME_SOURCE_SYNC_GLOBAL | TIME_SOURCE_IN_PROCESSOR

For HPET this would be
	TIME_SOURCE_SYNC_GLOBAL | TIME_SOURCE_NODE

For Altix RTC
	TIME_SOURCE_SYNC_GLOBAL | TIME_SOURCE_DISTRIBUTED

Hope this makes sense.

