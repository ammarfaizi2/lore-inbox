Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751442AbWA0Kvy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751442AbWA0Kvy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jan 2006 05:51:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751443AbWA0Kvy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jan 2006 05:51:54 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:14483 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1751442AbWA0Kvx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jan 2006 05:51:53 -0500
Date: Fri, 27 Jan 2006 02:51:26 -0800
From: Paul Jackson <pj@sgi.com>
To: Matthew Dobson <colpatch@us.ibm.com>
Cc: clameter@engr.sgi.com, linux-kernel@vger.kernel.org, sri@us.ibm.com,
       andrea@suse.de, pavel@suse.cz, linux-mm@kvack.org
Subject: Re: [patch 3/9] mempool - Make mempools NUMA aware
Message-Id: <20060127025126.c95f8002.pj@sgi.com>
In-Reply-To: <43D96A93.9000600@us.ibm.com>
References: <20060125161321.647368000@localhost.localdomain>
	<1138233093.27293.1.camel@localhost.localdomain>
	<Pine.LNX.4.62.0601260953200.15128@schroedinger.engr.sgi.com>
	<43D953C4.5020205@us.ibm.com>
	<Pine.LNX.4.62.0601261511520.18716@schroedinger.engr.sgi.com>
	<43D95A2E.4020002@us.ibm.com>
	<Pine.LNX.4.62.0601261525570.18810@schroedinger.engr.sgi.com>
	<43D96633.4080900@us.ibm.com>
	<Pine.LNX.4.62.0601261619030.19029@schroedinger.engr.sgi.com>
	<43D96A93.9000600@us.ibm.com>
Organization: SGI
X-Mailer: Sylpheed version 2.1.7 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew wrote:
> I'm glad we're on the same page now. :)  And yes, adding four "duplicate"
> *_mempool allocators was not my first choice, but I couldn't easily see a
> better way.

I hope the following comments aren't too far off target.

I too am inclined to prefer the __GFP_CRITICAL approach over this.
That or Andrea's suggestion, which except for a free hook, was entirely
outside of the page_alloc.c code paths.  Or Alan's suggested revival
of the old code to drop non-critical network patches in duress.

I am tempted to think you've taken an approach that raised some
substantial looking issues:

 * how to tell the system when to use the emergency pool
 * this doesn't really solve the problem (network can still starve)
 * it wastes memory most of the time
 * it doesn't really improve on GFP_ATOMIC

and just added another substantial looking issue:

 * it entwines another thread of complexity and performance costs
   into the important memory allocation code path.

Progress in the wrong direction ;).

> With large machines, especially as
> those large machines' workloads are more and more likely to be partitioned
> with something like cpusets, you want to be able to specify where you want
> your reserve pool to come from.

Cpusets is about performance, not correctness.  Anytime I get cornered
in the cpuset code, I prefer violating the cpuset containment, over
serious system failure.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
