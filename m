Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269777AbUICTMS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269777AbUICTMS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 15:12:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269775AbUICTMJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 15:12:09 -0400
Received: from hagen.doit.wisc.edu ([144.92.197.163]:14271 "EHLO
	smtp7.wiscmail.wisc.edu") by vger.kernel.org with ESMTP
	id S269745AbUICTKX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 15:10:23 -0400
Date: Fri, 03 Sep 2004 19:09:59 +0000
From: John Lenz <lenz@cs.wisc.edu>
Subject: Re: [PATCH 2.6.8.1 0/2] leds: new class for led devices
In-reply-to: <20040903195555.D15620@flint.arm.linux.org.uk>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org
Message-id: <1094238599l.7429l.2l@hydra>
MIME-version: 1.0
X-Mailer: Balsa 2.2.4
Content-type: text/plain; Format=Flowed; DelSp=Yes; charset=ISO-8859-1
Content-transfer-encoding: 7BIT
Content-disposition: inline
X-Spam-Score: 
X-Spam-Report: IsSpam=no, Probability=7%, Hits=__CD 0, __CT 0, __CTE 0,
 __CT_TEXT_PLAIN 0, __HAS_MSGID 0, __HAS_X_MAILER 0, __MIME_VERSION 0,
 __SANE_MSGID 0
X-Spam-PmxInfo: Server=avs-8, Version=4.7.0.111621, Antispam-Engine: 2.0.0.0,
 Antispam-Data: 2004.9.3.0, SenderIP=146.151.41.63
References: <1094157190l.4235l.2l@hydra> <20040903135103.GA982@elf.ucw.cz>
 <1094236686l.7429l.0l@hydra> <20040903195555.D15620@flint.arm.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/03/04 13:55:55, Russell King wrote:
> On Fri, Sep 03, 2004 at 06:38:06PM +0000, John Lenz wrote:
> > On 09/03/04 08:51:03, Pavel Machek wrote:
> > > > function : a read/write attribute that sets the current function of
> > > > this led.  The available options are
> > > >
> > > >  timer : the led blinks on and off on a timer
> > > >  idle : the led turns off when the system is idle and on when not
> idle
> > > >  power : the led represents the current power state
> > > >  user : the led is controlled by user space
> > >
> > > I'm afraid this is really good idea. It seems quite overengineered to
> > > me (and I'd be afraid that idle part slows machine). Perhaps having
> > > only "user" mode is better idea?
> >
> > I was only mimicing the support currently in the arm led code.
> > After thinking about it from a broader perspective of including GPIOs,
> > we should probably get rid of this function thing entirely.  Just let
> user
> > space do everything... userspace can monitor sysfs and hotplug and have
> the
> > led represent power or idle or whatever.
> 
> Bear in mind that my _original_ reason for implementing some of this
> was to tell what's going on with the kernel on my machines.  I'm fairly
> opposed to shifting it to userspace just because someone wants a bloated
> sysfs interface to drive some tiddly little LEDs and then having to
> losing the benefits of the existing implementation.

Yea, but there are other uses than developing and debugging.  For example,  
handheld environments use the leds to display when new mail comes, could  
also turn on the led based on an entry in the calandar to notify the user  
that some event is coming up, etc.

It's not really intended for debugging, because you can't control the leds  
until after module_init/device_initcall.

> 
> > The led class does not really inforce any policy, it just passes this
> > number along to the actual driver that is registered.  So say you had
> > a led that could be red, green, or both red and green at the same time
> > (not sure how that would work hardware wise, but ok).
> 
> See Netwinders.  They have a bi-colour LED which has independent red
> and green LEDs in the same package.  When they're both on it's yellow.
> 
> It's _VERY_ useful to see the green LED flashing and know that the
> headless machine is running, or that the red LED being on means that
> either it hasn't booted a kernel yet or the system has successfully
> shut down.
> 
> It means I don't have to fsck around with monitor cables before pulling
> the power.
> 
> And no, doing that from userspace won't work because userspace is dead
> _before_ the system has finished shutting down (see drive cache
> flushing on shutdown.)
> 
> It's also _VERY_ useful to know whether the kernel has managed to get
> far enough through the boot that the heartbeat LED is flashing but
> maybe not sufficiently to bring up the serial console as well -
> again another thing that a userspace implementation will never be
> able to support.

Hey I agree!  I use the led as a debugging tool on the Sharp Zaurus.   
Before I had the framebuffer or the serial port working, being able to see  
the led told me something was working :)  This patch isn't really intended  
for debugging support, so perhaps some other interface could be added.

On the other hand, perhaps we can just do a #ifdef LEDS_DEBUGGING that  
would toggle the led on a timer.

John


