Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265648AbSJSS0T>; Sat, 19 Oct 2002 14:26:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265649AbSJSS0T>; Sat, 19 Oct 2002 14:26:19 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:811 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S265648AbSJSS0S>; Sat, 19 Oct 2002 14:26:18 -0400
To: Patrick Mochel <mochel@osdl.org>
Cc: "Adam J. Richter" <adam@yggdrasil.com>, <eblade@blackmagik.dynup.net>,
       <linux-kernel@vger.kernel.org>
Subject: Re: Patch: linux-2.5.42/kernel/sys.c - warm reboot should not suspend devices
References: <Pine.LNX.4.44.0210150928340.1038-100000@cherise.pdx.osdl.net>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 19 Oct 2002 12:30:38 -0600
In-Reply-To: <Pine.LNX.4.44.0210150928340.1038-100000@cherise.pdx.osdl.net>
Message-ID: <m1d6q6xovl.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patrick Mochel <mochel@osdl.org> writes:

> > 	device_shutdown and device_suspend are for power management.
> > It is important to turn the device off as soon as possible if a power
> > management routine has told you that the device is not going to be
> > used any more.
> 
> device_suspend() is for power management. device_shutdown() is for 
> quiescing devices before a system reboot or power off. 
> 
> It's true that the same function is called when the device is physically 
> removed from the system as when the system is shutting down, and that 
> might be kinda bad. If it gets to the point where it's really difficult to 
> deal with for drivers, we can create another callback: ->shutdown() for 
> struct device_driver. 

Obviously you have decided this was worth it.

My feedback.
* dev->shutdown is not called on module removal.
* dev->shutdown does not update dev->state to anything like
    DEVICE_SHUTDOWN, that could be used as a sanity check, to not
    use a device after it has been shut down.

* The semantics of dev->shutdown() and are not clear, in their
  interactions with other parts of the system.  Can the code from
  dev->remove() that shuts down a device be removed? 

I care because getting devices to properly shutdown on when
sys_kexec is what I need to do to get sys_kexec stable.

Would it be worth it for me to split out my fixes to smp shutdown,
and i8259 shutdown and to send them along to you?

The smp shutdown case on x86 probably cannot be handled by the device
model because it must be the very last code to run.  When you stop
interrupts from coming in several drivers get cranky and do not
shutdown cleanly.  

Hopefully I am not coming off harsh but I am a little cranky this
morning,  As before this change I thought things on the device side
were pretty much under control they just needed a little stabilization
and testing.  And now someone possibly me has to go through every
driver and write a shutdown method because someone figured calling
free was expensive.

That was the point of calling dev->shutdown instead of dev->remove()
wasn't it?  If there was a way to reawaken a device after calling
dev -> shutdown I might see it.  But to do that you still need to call
dev -> remove() followed by dev ->probe()

Eric
