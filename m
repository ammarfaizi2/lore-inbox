Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264479AbUGHKzd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264479AbUGHKzd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jul 2004 06:55:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265920AbUGHKzd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jul 2004 06:55:33 -0400
Received: from outmx022.isp.belgacom.be ([195.238.2.203]:48077 "EHLO
	outmx022.isp.belgacom.be") by vger.kernel.org with ESMTP
	id S264479AbUGHKzO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jul 2004 06:55:14 -0400
Subject: Re: Autoregulate swappiness & inactivation
From: FabF <fabian.frederick@skynet.be>
To: Con Kolivas <kernel@kolivas.org>
Cc: Andrew Morton <akpm@osdl.org>, nigelenki@comcast.net,
       linux-kernel@vger.kernel.org
In-Reply-To: <cone.1089275229.304355.4554.502@pc.kolivas.org>
References: <40EC13C5.2000101@kolivas.org> <40EC1930.7010805@comcast.net>
	 <40EC1B0A.8090802@kolivas.org> <20040707213822.2682790b.akpm@osdl.org>
	 <cone.1089268800.781084.4554.502@pc.kolivas.org>
	 <20040708001027.7fed0bc4.akpm@osdl.org>
	 <cone.1089273505.418287.4554.502@pc.kolivas.org>
	 <20040708010842.2064a706.akpm@osdl.org>
	 <cone.1089275229.304355.4554.502@pc.kolivas.org>
Content-Type: text/plain
Message-Id: <1089284097.3691.52.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 08 Jul 2004 12:54:57 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-07-08 at 10:27, Con Kolivas wrote:
> Andrew Morton writes:
> 
> > Con Kolivas <kernel@kolivas.org> wrote:
> >>
> >> Andrew Morton writes:
> >> 
> >> > Con Kolivas <kernel@kolivas.org> wrote:
> >> >>
> >> >>  Ah what the heck. They can only be knocked back to where they already are.
> >> > 
> >> > hm.  You get an eGrump for sending two patchs in one email.  Surprisingly
> >> > nice numbers though.
> >> > 
> >> > How come vm_swappiness gets squared?  That's the mysterious "bias
> >> > downwards", yes?  What's the theory there?
> >> 
> >> No real world feedback mechanism is linear. As the pressure grows the 
> >> positive/negative feedback grows exponentially.
> > 
> > That takes me back.  The classic control system is PID:
> > Proportional/Integral/Derivative - they refer to the way in which the error
> > term (output-desired output) is fed back to the input:
> > 
> > Proportional: the bigger the error, the more input drive
> > 
> > Integral: feeding back a bit of the integral of the error prevents
> > permanent output skew due to non-infinite forward gain.
> > 
> > Derivative: feeding back -(rate of change) provides damping.
> > 
> > You can live without I and D - the main thing is to feed back the -error.
> > 
> > IOW: linear works just fine :)
> 
> /me hides
> 
> Umm sorry the control systems I look at are physiological and tend to be 
> exponential, so ignore me.
> 
> > Your answer didn't help me understand the design though.
> 
> Ok I'll just describe it. I should have just said that when mapped pages are 
> low the best seems to be a very low swappiness, but not zero as zero seems 
> to get bogged down easily (kswapd gets busy and basic things take longer) as 
> occasionally slipping some pages onto swap helps. Generally it's when what I 
> called the application pages (blush) get to around 75% that allowing things 
> to swap at the rate equivalent to swappiness==60 is helpful. Once the mapped 
> pages went greater than 75% the machine would start bogging down again if 
> the swappiness remained at 60. I guess I made up the maths to fill the way 
> the design worked best. Linear brought up the swappiness too easily and 
> under swap thrash made things worse. It looked nicer but didn't really 
> behave well.
> 
> >> > Please define this new term "application pages"?
> >> 
> >> errm it's fuzzy to say the least. It's the closest I can come to 
> >> representing what end users understand as "non-cached" pages.
> > 
> > Isn't that mapped pages?
> 
> I'm all ears.
> 
> >> > Those si_swapinfo() and si_meminfo() calls need to come out of there.
> >> 
> >> I'm game. I had the idea but not the skill. Anyone wanna help me with that?
> > 
> > Need to work out what cen be removed first.  The freeswap/totalswap can go.
> >  That leaves us needing what?  totalram and freeram.  If the algorithm can
> > be flipped over to use nr_mapped, we'd be looking good.
> 
> Ok. I need some time to clean up this mess and try and figure out what to do 
> then.
Con,
	What's interesting is try_to_free_pages comment :

" the zone may be full of dirty or under-writeback pages, which this
 * caller can't do much about.  We kick pdflush and take explicit naps
in the
 * hope that some of these pages can be written.  But if the allocating
task..."

	I mean do we have high activity profile of that side of the kernel when
bringing up some big application to life ?
	Does work consist here in 50% out, 50% in (time) ? Your anticipation
algorithm can help the "in" side but maybe we can optimize yet the "out"
side.btw, I'm surprised to see autoswappiness so far in fx tree:

page_reclaim
	try_to_free_pages
		shrink_caches
			shrink_zone
				refill_inactive_zone
					auto_swap calculation


IOW, does such parameter could not involve more decisions ?

Regards,
FabF

> 
> Con
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

