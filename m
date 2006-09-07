Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751510AbWIGK6G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751510AbWIGK6G (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Sep 2006 06:58:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751524AbWIGK6F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Sep 2006 06:58:05 -0400
Received: from ns2.suse.de ([195.135.220.15]:18857 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751510AbWIGK6D (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Sep 2006 06:58:03 -0400
Date: Thu, 7 Sep 2006 12:58:01 +0200
From: Nick Piggin <npiggin@suse.de>
To: Christoph Lameter <clameter@sgi.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix longstanding load balancing bug in the scheduler.
Message-ID: <20060907105801.GC3077@wotan.suse.de>
References: <Pine.LNX.4.64.0609061634240.13322@schroedinger.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0609061634240.13322@schroedinger.engr.sgi.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 06, 2006 at 04:38:33PM -0700, Christoph Lameter wrote:
> The scheduler will stop load balancing if the most busy processor
> contains processes pinned via processor affinity.
> 
> The scheduler currently only does one search for busiest cpu. If it cannot
> pull any tasks away from the busiest cpu because they were pinned then the
> scheduler goes into a corner and sulks leaving the idle processors idle.
> 
> F.e. If one has processor 0 busy running four tasks pinned via
> taskset and there are none on processor 1. If one then starts 
> two processes on processor 2 then the scheduler will not move one of
> the two processes away from processor 2.
> 
> This patch fixes that issue by forcing the scheduler to come out of
> its corner and retrying the load balancing by considering other
> processors for load balancing. Instead of sulking the scheduler will 
> simply shun the run queue with the pinned unmovable threads.
> 
> This patch was originally developed by John Hawkes and discussed
> at http://marc.theaimsgroup.com/?l=linux-kernel&m=113901368523205&w=2.
> 
> I have removed extraneous material, simplified it and gone back to 
> equipping struct rq with the cpu the queue is associated with since this 
> makes the patch much easier and it is likely that others in the future 
> will have the same difficulty of figuring out which processor owns which 
> runqueue.
> 
> Signed-off-by: Christoph Lameter <clameter@sgi.com>

So what I worry about with this approach is that it can really blow
out the latency of a balancing operation. Say you have N-1 CPUs with
lots of stuff locked on their runqueues.

The solution I envisage is to do a "rotor" approach. For example
the last attempted CPU could be stored in the starving CPU's sd...
and it will subsequently try another one.

I've been hot and cold on such an implementation for a while: on one
hand it is a real problem we have; OTOH I was hoping that the domain
balancing might be better generalised. But I increasingly don't
think we should let perfect stand in the way of good... ;)

Would you be interested in testing a patch?
