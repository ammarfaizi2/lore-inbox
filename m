Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932118AbWESAJm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932118AbWESAJm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 May 2006 20:09:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932133AbWESAJm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 May 2006 20:09:42 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:55493 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S932118AbWESAJm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 May 2006 20:09:42 -0400
Date: Fri, 19 May 2006 02:09:29 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Tim Mann <mann@vmware.com>
cc: linux-kernel@vger.kernel.org, john stultz <johnstul@us.ibm.com>
Subject: Re: Fix time going backward with clock=pit [1/2]
In-Reply-To: <20060518115022.0561c24d@mann-lx.eng.vmware.com>
Message-ID: <Pine.LNX.4.64.0605190108010.32445@scrub.home>
References: <20060517160428.62022efd@mann-lx.eng.vmware.com>
 <Pine.LNX.4.64.0605181249020.17704@scrub.home> <20060518115022.0561c24d@mann-lx.eng.vmware.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 18 May 2006, Tim Mann wrote:

> > I think the whole think should look 
> > something like this:
> > 
> > 	if (jiffies_t == jiffies_p) {
> > 		if (count > count_p) {
> > 			underflow or crappy timer;
> 
> What should the code do in this case?

Basically the current do_timer_overflow().

> > 		}
> > 	} else {
> > 		jiffies_p = jiffies_t;
> > 		if (count > LATCH/2 && underflow)
> > 			count -= LATCH;
> 
> I think I see what you're aiming at here: in the case where we read
> count, then the counter wraps, then we read jiffies, you want to detect
> that and fix it.  Actually if you could detect that, the right way to
> fix it would be to set count = LATCH, since the old count is, well, old:
> the current time is right after the jiffy.

It's really "-= LATCH". :)

> However, we don't really have a way to detect that this case happened --
> the "&& underflow" in your code is a handwave.

Ok, I'm not that familiar with Intel hardware (it must be crappier than I 
thought). Is there really no way to detect the pending interrupt (e.g. 
what do_timer_overflow() does)? Without that information one can really 
only guess the time.
It's not that important if it's not completely correct for SMP systems, 
they usually have other sources, but for the few systems there this is the 
only time source, we should at least make an effort to avoid the read 
error.

bye, Roman
