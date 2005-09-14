Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932750AbVINS0Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932750AbVINS0Z (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 14:26:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932751AbVINS0Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 14:26:24 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.144]:39635 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932750AbVINS0Y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 14:26:24 -0400
Subject: Re: [RFC][PATCH] NTP shift_right cleanup (v. A1)
From: john stultz <johnstul@us.ibm.com>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: lkml <linux-kernel@vger.kernel.org>, yoshfuji@linux-ipv6.org,
       Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>,
       George Anzinger <george@mvista.com>, joe-lkml@rameria.de
In-Reply-To: <Pine.LNX.4.61.0509142010030.3728@scrub.home>
References: <1126720091.3455.56.camel@cog.beaverton.ibm.com>
	 <Pine.LNX.4.61.0509142010030.3728@scrub.home>
Content-Type: text/plain
Date: Wed, 14 Sep 2005 11:25:03 -0700
Message-Id: <1126722303.3455.61.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-09-14 at 20:13 +0200, Roman Zippel wrote:
> > @@ -792,13 +769,8 @@ static void update_wall_time_one_tick(vo
> >  	 * advance the tick more.
> >  	 */
> >  	time_phase += time_adj;
> > -	if (time_phase <= -FINENSEC) {
> > -		long ltemp = -time_phase >> (SHIFT_SCALE - 10);
> > -		time_phase += ltemp << (SHIFT_SCALE - 10);
> > -		delta_nsec -= ltemp;
> > -	}
> > -	else if (time_phase >= FINENSEC) {
> > -		long ltemp = time_phase >> (SHIFT_SCALE - 10);
> > +	if (abs(time_phase) >= FINENSEC) {
> > +		long ltemp = shift_right(time_phase, (SHIFT_SCALE - 10));
> >  		time_phase -= ltemp << (SHIFT_SCALE - 10);
> >  		delta_nsec += ltemp;
> >  	}
> 
> I checked and this actually generates worse code.

Well, if I drop the abs() and use:
	if ((time_phase >= FINENSEC) || (time_phase <= -FINENSEC))

It looks pretty close in my test. Is that cool with you?

thanks
-john


