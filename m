Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264734AbUGIJsY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264734AbUGIJsY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jul 2004 05:48:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264725AbUGIJsY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jul 2004 05:48:24 -0400
Received: from outmx010.isp.belgacom.be ([195.238.3.233]:45475 "EHLO
	outmx010.isp.belgacom.be") by vger.kernel.org with ESMTP
	id S264685AbUGIJsS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jul 2004 05:48:18 -0400
Subject: Re: Autoregulate swappiness & inactivation
From: FabF <fabian.frederick@skynet.be>
To: Con Kolivas <kernel@kolivas.org>
Cc: Andrew Morton <akpm@osdl.org>, nigelenki@comcast.net,
       linux-kernel@vger.kernel.org
In-Reply-To: <40EDEF68.2020503@kolivas.org>
References: <40EC13C5.2000101@kolivas.org> <40EC1930.7010805@comcast.net>
	 <40EC1B0A.8090802@kolivas.org> <20040707213822.2682790b.akpm@osdl.org>
	 <cone.1089268800.781084.4554.502@pc.kolivas.org>
	 <20040708001027.7fed0bc4.akpm@osdl.org>
	 <cone.1089273505.418287.4554.502@pc.kolivas.org>
	 <20040708010842.2064a706.akpm@osdl.org>
	 <cone.1089275229.304355.4554.502@pc.kolivas.org>
	 <1089284097.3691.52.camel@localhost.localdomain>
	 <40EDEF68.2020503@kolivas.org>
Content-Type: text/plain
Message-Id: <1089366486.3322.10.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Fri, 09 Jul 2004 11:48:07 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-07-09 at 03:05, Con Kolivas wrote:
> FabF wrote:
> > Con,
> > 	What's interesting is try_to_free_pages comment :
> > 
> > " the zone may be full of dirty or under-writeback pages, which this
> >  * caller can't do much about.  We kick pdflush and take explicit naps
> > in the
> >  * hope that some of these pages can be written.  But if the allocating
> > task..."
> > 
> > 	I mean do we have high activity profile of that side of the kernel when
> > bringing up some big application to life ?
> > 	Does work consist here in 50% out, 50% in (time) ? Your anticipation
> > algorithm can help the "in" side but maybe we can optimize yet the "out"
> > side.btw, I'm surprised to see autoswappiness so far in fx tree:
> > 
> > page_reclaim
> > 	try_to_free_pages
> > 		shrink_caches
> > 			shrink_zone
> > 				refill_inactive_zone
> > 					auto_swap calculation
> > 
> > 
> > IOW, does such parameter could not involve more decisions ?
> 
> If you put it that way, yes - it would classify as duct tape. However 
> the code already acted based upon mapped_ratio which is pretty much all 
> this patch does. Folded in in that sample patch I sent out earlier you 
> can see that all it does is acted on mapped_ratio in a different manner 
> so it's not really an extra layer at all.
> 
> -	swap_tendency = mapped_ratio / 2 + distress + vm_swappiness;
> +	vm_swappiness = mapped_ratio * 150 / 100;
> +	vm_swappiness = vm_swappiness * vm_swappiness / 150;
> +	swap_tendency = distress + vm_swappiness;

Here's an easy benchmark to demonstrate problem :
1.Run Mozilla
2.Minimize
3=>Mozilla Resident Size (mrs) : 24Mb
4.Run updatedb
5.=>mrs : 15Mb
6.updatedb ends up
7.mrs doesn't move at all (yes, it goes down as I'm typing this msg :)).

So my question is :
Don't we have a way to say "whose pages were reclaimed from and
 reattribute its" ? (having in mind memory status per se).
IOW flushing (I guess it's pdflush relevant ? ) do work for dead
processes but doesn't care about applications alive...

Regards,
FabF

> 
> Con
> 
> > Regards,
> > FabF

