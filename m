Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1757241AbWKWAlk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757241AbWKWAlk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Nov 2006 19:41:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757243AbWKWAlk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Nov 2006 19:41:40 -0500
Received: from smtp111.sbc.mail.mud.yahoo.com ([68.142.198.210]:32851 "HELO
	smtp111.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1757241AbWKWAlQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Nov 2006 19:41:16 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=pacbell.net;
  h=Received:X-YMail-OSG:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Disposition:Message-Id:Content-Type:Content-Transfer-Encoding;
  b=LPKHgab9yWmm0ym/AioR+Rl2Gh0fq+Hhz6EAM9f91JTXQs4Ta7Eg6FQvCIG9E7lgg6fBmbR/5oYgKy6DRA75dUd33MP826r4/pzKK29vwxtTH+fMQIeuJIhsOEvbG1Htr1qXwNnh9JZbBCRE5mOmOBIjAvdQXNwPa+jYycRCQE0=  ;
X-YMail-OSG: MUblsaUVM1lbHa2gM8a1H5lD8fuEsvNJcE3ggOilN7nDsADp4PTNM5p5VTXrv.N0m52PLp_m63Rk_3dT6Vh.ue_w88UhG53VmPqtPI.RJK6npmLKpK6JwA--
From: David Brownell <david-b@pacbell.net>
To: Bill Gatliff <bgat@billgatliff.com>
Subject: Re: [patch/rfc 2.6.19-rc5] arch-neutral GPIO calls
Date: Wed, 22 Nov 2006 16:40:54 -0800
User-Agent: KMail/1.7.1
Cc: Paul Mundt <lethal@linux-sh.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Andrew Victor <andrew@sanpeople.com>,
       Haavard Skinnemoen <hskinnemoen@atmel.com>, jamey.hicks@hp.com,
       Kevin Hilman <khilman@mvista.com>, Nicolas Pitre <nico@cam.org>,
       Russell King <rmk@arm.linux.org.uk>, Tony Lindgren <tony@atomide.com>
References: <200611111541.34699.david-b@pacbell.net> <200611202135.39970.david-b@pacbell.net> <456321E9.2030308@billgatliff.com>
In-Reply-To: <456321E9.2030308@billgatliff.com>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200611221640.55574.david-b@pacbell.net>
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 21 November 2006 7:57 am, Bill Gatliff wrote:

> Once you're hiding the GPIO number behind an enumeration, you can create 
> a bitmap with more information than a single integer.  That extra 
> information could be used--- in my implementations, if any ever come 
> about--- to store routing information.

But none of the existing GPIO users do that.  The goal wasn't to define
a new notion of GPIO; it was collecting the existing ones under a single
arch-neutral umbrella.


> >It'd also be a big (and needless) disruption to code that's been working
> >fine for several years now ... 
> 
> ... all of which is using the current GPIO API, you mean?  :)

Effectively, yes.  I counted quite a few implementations in the current
tree which can trivially (#defines) map to that API.


> >Maybe if it were being done over from scratch, that'd be workable.
> >But at this point I have a hard time seeing anyone want to change,
> >even if there were a better argument.
> 
> Waitaminit.  I thought this arch-neutral GPIO API *was* a from-scratch!  
> Did I miss something?

The numerous implementations, e.g. on ARM, that effectively are
already using this same API, I'd guess.  The ones that uniformly
reference GPIOs by an integer.


> There's a ton of code in the AT91 tree that sets up pin routing on 
> behalf of peripheral drivers like MMC, etc.  MMC also uses GPIO. 

I just checked RC6, and see that at91_mmc doesn't set up routing.
Which is as it should be ... routing is part of board setup, saying
"these pins go to the MMC card".  Pretty much the same with all
other peripherals.  They do have calls to read GPIO values, or in
some cases set them.  But ** NOT ** to route them.


> Arabella's PPC Linux kernels (which I'm working with at the moment) have 
> a resource manager not unlike what we're discussing here.

Well, like _you_ are discussing.  I'm mostly pointing out that
pin muxing and configuration is a clearly distinct problem,
with very chip-specific nuances.


> It's very,  
> very heavy and unpleasant in spots, so I won't offer code or examples, 
> but it is pretty adept at getting pin routing right when a driver 
> initializes.  And it can also prevent pin assignment conflicts--- which 
> have saved me in a few situations, and made debugging easier in others.  
> I don't like their implementation, but the functionality is much-needed.

Most highly integrated chips nowadays need such functionality.  If you're
keen on it, you could try to abstract a dozen pin mux/setup implementations
and propose an API ... in the same way I did for GPIOs.  :)


> None of what I'm suggesting affects the signatures of the functions 
> specified by your API at all.  I'm just hiding more information behind 
> the notion of "gpio number", in a way that lets the implementors also 
> incorporate routing (both detection and assignment) into them.

And as I've defined those numbers, that's certainly allowed.  But not
required.  I'm just pushing back on the notion that it be required,
since adding such heavy requirements would prevent quick API support
for GPIOs.

- Dave
