Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751242AbWF2SWt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751242AbWF2SWt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 14:22:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751247AbWF2SWt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 14:22:49 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:62684 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1751242AbWF2SWt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 14:22:49 -0400
Date: Thu, 29 Jun 2006 11:22:45 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: ZVC: Increase threshold for larger processor configurationss
In-Reply-To: <20060628154911.6e035153.akpm@osdl.org>
Message-ID: <Pine.LNX.4.64.0606291116500.27926@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.64.0606281038530.22262@schroedinger.engr.sgi.com>
 <20060628154911.6e035153.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Jun 2006, Andrew Morton wrote:

> An alternative would be to calculate stat_threshold at runtime, based on
> the cpu_possible count (I guess).  Or even:
> 
> static inline int stat_threshold(void)
> {
> #if NR_CPUS <= 32
> 	return 32;
> #else
> 	return dynamically_calculated_stat_threshold;
> #endif
> }

Thats one more memory reference. Hmmm... We could place the threshold in 
the same cacheline. That would also open up the possbiliity of dynamically 
calculating the threshold.

> Did you consider my earlier suggestion about these counters?  That, over the
> short-term, they tend to count in only one direction?  So we can do
> 
> 	if (x > STAT_THRESHOLD) {
> 		zone_page_state_add(x + STAT_THRESHOLD/2, zone, item);
> 		x = -STAT_THRESHOLD/2;
> 	} else if (x < -STAT_THRESHOLD) {
> 		zone_page_state_add(x - STAT_THRESHOLD/2, zone, item);
> 		x = STAT_THRESHOLD;
> 	}
> 
> that'll give an decrease in contention while not consuming any extra
> storage and while (I think) increasing accuracy.

Uhh... We are overcompensating right? Pretty funky idea that is new to me 
and that would require some thought.

This would basically increase the stepping by 50% if we are only going in 
one direction.

If we are doing a mixture of allocations and deallocations (or pages being 
marked dirty / undirty, mapping unmapping) then this may potentially
increase the number of updates and therefore the cacheline contentions.
