Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269971AbUICXUc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269971AbUICXUc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 19:20:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269973AbUICXUc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 19:20:32 -0400
Received: from hagen.doit.wisc.edu ([144.92.197.163]:56960 "EHLO
	smtp7.wiscmail.wisc.edu") by vger.kernel.org with ESMTP
	id S269971AbUICXU2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 19:20:28 -0400
Date: Fri, 03 Sep 2004 23:19:46 +0000
From: John Lenz <lenz@cs.wisc.edu>
Subject: Re: [PATCH 2.6.8.1 0/2] leds: new class for led devices
In-reply-to: <20040903232507.A8810@flint.arm.linux.org.uk>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: John Lenz <lenz@cs.wisc.edu>, Jan-Benedict Glaw <jbglaw@lug-owl.de>,
       linux-kernel@vger.kernel.org, Kalin KOZHUHAROV <kalin@thinrope.net>
Message-id: <1094253586l.7429l.4l@hydra>
MIME-version: 1.0
X-Mailer: Balsa 2.2.4
Content-type: text/plain; Format=Flowed; DelSp=Yes; charset=ISO-8859-1
Content-transfer-encoding: 7BIT
Content-disposition: inline
X-Spam-Score: 
X-Spam-Report: IsSpam=no, Probability=7%, Hits=__CD 0, __CT 0, __CTE 0,
 __CT_TEXT_PLAIN 0, __HAS_MSGID 0, __HAS_X_MAILER 0, __MIME_VERSION 0,
 __SANE_MSGID 0
X-Spam-PmxInfo: Server=avs-2, Version=4.7.0.111621, Antispam-Engine: 2.0.0.0,
 Antispam-Data: 2004.9.3.1, SenderIP=146.151.41.63
References: <1094157190l.4235l.2l@hydra> <ch8tdd$1uf$1@sea.gmane.org>
 <20040903120634.GK6985@lug-owl.de> <1094237243l.7429l.1l@hydra>
 <20040903232507.A8810@flint.arm.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/03/04 17:25:07, Russell King wrote:
> On Fri, Sep 03, 2004 at 06:47:23PM +0000, John Lenz wrote:
> > On 09/03/04 07:06:34, Jan-Benedict Glaw wrote:
> > > Is idle/timer/power hardware-controlled (eg. by a secondary  
> processor,
> > > direct chipset implementation) or is switching on/off controlled by
> > > kernel (eg. heartbeat, IO and ethernet for the LEDs you can find on
> some
> > > PA-RISC machines)?
> >
> > Right now the kernel is in sole control.  The device I am testing this
> on
> > is a Sharp Zaurus SL5500, which has two leds that by default are used  
> to
> 
> > light when new mail arrives and if the power is plugged in.
> 
> The kernel is NOT in sole control today on ARM platforms:
> 
> echo claim > /sys/devices/system/leds/leds0/event
> echo red on > /sys/devices/system/leds/leds0/event
> echo green on > /sys/devices/system/leds/leds0/event
> echo red off > /sys/devices/system/leds/leds0/event
> echo release > /sys/devices/system/leds/leds0/event
> 
> etc
> 
> Sure, we have a weird naming scheme (red, green, amber, blue) but
> that came around because that's what people were dealing with.
> There's nothing really stopping us from having any name for a LED
> in the existing scheme.

1) This is arm specific.  Do any other arches want to provide access to  
leds?  Why should they implement some different api?

2) What happens when you have more than four leds?  or 3 dual color leds?

3) no way to read the current status of the led. (could be added to read  
from /sys/devices/system/leds/leds0 or something)

4) really wierd in-kernel api...  The led is associated with a machine,  
when that sometimes doesn't make sense; code duplication for the same  
harware drivers.  As an example, the led device on the Sharp Zauruses are  
all the same... exact same code to control the led.  Except one model is  
sa1100 and two are pxa based, so leds-collie.c and leds-poodle.c are  
exactly the same, except to be registered in the associated leds.c for that  
mach.  This model, instead of associating leds with a specific machine make  
it a device/driver concept like every other device in the kernel.

We can easily provide backwards compatibility with the arm led code.  I  
have a semi-working driver to register with ledsbase.c and call the  
leds_event function.  As well, the old /sys/devices/system/leds/leds0/event  
thing can also be emulated.

> I just don't buy the "we must have one sysfs node for every LED"
> argument.

well, we could just create one attribute per led in /sys/devices/system/ 
leds/leds0/, but that breaks conceptally what sysfs is trying to provide...  
one device per attribute?  4 devices controlled by ONE attribute?

John


