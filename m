Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262038AbUKBWRy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262038AbUKBWRy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Nov 2004 17:17:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262039AbUKBWRm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Nov 2004 17:17:42 -0500
Received: from gateway.penguincomputing.com ([64.243.132.186]:34446 "EHLO
	inside.penguincomputing.com") by vger.kernel.org with ESMTP
	id S262265AbUKBWQ0 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Nov 2004 17:16:26 -0500
X-Mda: Mail::Internet Mail::Sendmail Sendmail +mmhack 1.1 on Linux
Cc: Greg KH <greg@kroah.com>
User-Agent: Mutt/1.4.1i
Subject: Re: adm1026 driver port for kernel 2.6.X - [REVISED DRIVER]
In-Reply-To: <20041102203122.7e7a8366.khali@linux-fr.org>
Content-Disposition: inline
Date: Tue, 2 Nov 2004 14:17:45 -0800
Message-Id: <20041102221745.GB18020@penguincomputing.com>
References: <20041025210057.GB19053@penguincomputing.com>
 <GNXY8AG6.1098776962.4770080.khali@gcu.info>
 <20041029191229.GB803@penguincomputing.com>
 <20041102164642.GA16378@penguincomputing.com>
 <20041102203122.7e7a8366.khali@linux-fr.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: LM Sensors <sensors@stimpy.netroedge.com>,
       LKML <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 8BIT
From: Justin Thiessen <jthiessen@penguincomputing.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 02, 2004 at 08:31:22PM +0100, Jean Delvare wrote:
> Hi justin,

<snip>

> On a side note, MBM lists the ADM1026 as being used on only two
> motherboard models, one being yours. Considering this and the fact that
> nobody ever requested us to port the adm1026 driver to Linux 2.6, I
> would conclude that the motherboard you use is possibly the only one
> worth supporting. Do not bother with anything that you don't personally
> need. We can still add it later on request.

Ok.

> Hysteresis temperatures have to be absolute temperatures as per
> interface standard.

Ok.

> > temp[1-3]_auto_point2_temp        {temp[1-3]_auto_point1_temp + 20000}
> 
> I'm a bit surprised not to see temp[1-3]_auto_point[1-2]_pwm. Trip
> points are supposed to be (temp, pwm) pairs. Doesn't pwm1_auto_pwm_min
> above correspond to one or more of these?

Yes.  On its way.  I think it got lost somewhere in my reading of the 
discussion over auto-fan interface proposals.

> > Failsafe critical temperatures at which the fans go to maximum speed
> > are controled via:
> > 
> > temp_crit_enable       {0-1}  (off, on)
> > temp[1-3]_crit         {-128000 - 127000}
> 
> Granted it's not part of the standard yet, but you would have three
> files temp[1-3]_crit_enable if we stick to our chip-indenpendent
> interface logic. Either make 1 read-write and [2-3] read-only, or make
> all read-write and each one changes the three values.

Any reason not to simply provide 3 sysfs files pointing at the same variable/
register bit?  Maintaining separate variables for a single, uncomplicated 
value seems rather overkill.

> > These values override any values set for the pwm-mediated automatic
> > fan control.
> 
> Doesn't this mean that you could integrate these in the auto-pwm
> interface as point3?

No.  It is important for this to remain seperate from the auto-pwm interface.
It can be set to operate when PWM control is set to "manual", providing a
useful fail-safe mechanism, or when PWM control is set to "off"  (Although 
it should not be needed in the latter case, as in theory the fans are running 
at full speed when PWM control is disabled.)

Moreover, integrating it into the *auto_pointN_temp heirarchy would be
ugly, as there is really only one set of values (temp[1-3]_auto_point1_temp)
that can be independently changed by the end-user.  
temp[1-3]_auto_point1_temp_hyst and temp[1-3]_auto_point2_temp are fixed in 
hardware at positions relative to temp[1-3]_auto_point1_temp.  The function
of temp[1-3]_crit essentially overlaps that of temp[13]_auto_point2_temp
when both automatic PWM fan control and critical temperature monitoring
are enabled.  Both provide temperatures at which fan speeds are ramped up
to maximum.  This means integrating the temp[1-3]_crit function into the
*_auto_point?_temp heirarchy would result in 2 distinct sets of files that
determine when fan speeds are supposed to go to max.

A better way to think of it is that the temp[1-3]_crit files provide a 
method for the end-user to set absolute "holy-cow-my-system-is-glowing"
temperatures at which fans MUST ramp up to full speed.  It's a fail-safe
that will kick in to try and save the system's bacon in an emergency.  As
it operates with or without the PWM automatic fan control, it can be employed
whether or not the end-user wants to muck about with such.

I would agree that it is a bit confusing that there are essentially 2 
temperature-motivated mechanisms for forcing fan speeds to full (automatic
PWM fan control, and critical temperature monitoring), but I think that the
utility of providing a critical temperature fail-safe is worth the 
minor amount of confusion.

> > Thanks to all for the feedback.
> 
> You're welcome. Sorry to ask questions about the proposed interface
> again, I just want things to be as clean and logical as possible.

No problem.  Sorry that it's taking so much revision to get the kinks worked
out.  This will undoubtedly become less trouble as I get more familiar with
i2c/lm_sensors/kernel issues.

Justin Thiessen
---------------
jthiessen@penguincomputing.com

