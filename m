Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265053AbUGMNM7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265053AbUGMNM7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jul 2004 09:12:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265060AbUGMNM7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jul 2004 09:12:59 -0400
Received: from outmx005.isp.belgacom.be ([195.238.2.102]:57024 "EHLO
	outmx005.isp.belgacom.be") by vger.kernel.org with ESMTP
	id S265053AbUGMNMz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jul 2004 09:12:55 -0400
Subject: Re: rss recovery
From: FabF <fabian.frederick@skynet.be>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <40EFDB18.404@yahoo.com.au>
References: <40EC13C5.2000101@kolivas.org> <40EC1930.7010805@comcast.net>
	 <40EC1B0A.8090802@kolivas.org> <20040707213822.2682790b.akpm@osdl.org>
	 <cone.1089268800.781084.4554.502@pc.kolivas.org>
	 <20040708001027.7fed0bc4.akpm@osdl.org>
	 <cone.1089273505.418287.4554.502@pc.kolivas.org>
	 <20040708010842.2064a706.akpm@osdl.org>
	 <cone.1089275229.304355.4554.502@pc.kolivas.org>
	 <1089284097.3691.52.camel@localhost.localdomain>
	 <40EDEF68.2020503@kolivas.org>
	 <1089366486.3322.10.camel@localhost.localdomain>
	 <40EE76CC.5070905@yahoo.com.au>
	 <1089371646.3322.38.camel@localhost.localdomain>
	 <40EE8075.6060700@yahoo.com.au>
	 <1089452697.3646.11.camel@localhost.localdomain>
	 <40EFC076.9050504@yahoo.com.au>
	 <1089457076.3646.33.camel@localhost.localdomain>
	 <40EFDB18.404@yahoo.com.au>
Content-Type: text/plain
Message-Id: <1089724364.3424.20.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Tue, 13 Jul 2004 15:12:44 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-07-10 at 14:03, Nick Piggin wrote:
> FabF wrote:
> > Nick,
> > 	Putting some more pressure I finally saw the awaited behaviour from np
> > : rss gaining 1MB (or at least 1 byte :) : top reports 10M -> 11M )
> > directly after make was done with 10 threads.
> > 
> > But I guess it can do much better than that (IOW recover original rss).
> > Where does re-attribution takes place in np ?
> > 
> 
> I don't do any sort of preemptive RSS recovery. The pagein mechanisms
> are unchanged with my patch. The point was that mozilla no longer got
> swapped out by updatedb, isn't that what you wanted?
> 
Nick,

Your patch is great as system delves for pages without eating too much
RSS around.

I just thought about some sort of combination :

	-On one side a swapout regulation
	-But also somekind of smooth swapin operation.

Reason for this being box freeze effect after some heavy load.

I made a slight patchset which tries to do the second path.It's being
called RGR for "RSS Gradual Recovery".It works with 2 sysctl parameters
for testing :

	-swapoff_max_swapout :  It proceeds when kswapd has not reported more
than this.
	-swapoff_smooth_range : Number of pages to swap in at once.

That process uses a try_to_unuse patched version to emerge some pages
when swapout is relaxed.That stuff is done in a swap device transparent
poll method and should result in GUI application foregrounding done
quickly even after some heavy-load storm; my problem being where this
one can be called from ? As an example, I put a swapoff_smooth in
do_anonymous_page but it's not the right location I guess :))) just
wanted some place frequently called to see effects.

Of course, your help would be appreciated ;)

patchset is available from:
http://fabian.unixtech.be/ff/linux-2.6.7-mm7-rgr1.diff

Regards,
FabF

