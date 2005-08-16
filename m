Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932706AbVHPU3o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932706AbVHPU3o (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Aug 2005 16:29:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932705AbVHPU3o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Aug 2005 16:29:44 -0400
Received: from smtp-102-tuesday.noc.nerim.net ([62.4.17.102]:36105 "EHLO
	mallaury.nerim.net") by vger.kernel.org with ESMTP id S932703AbVHPU3n
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Aug 2005 16:29:43 -0400
Date: Tue, 16 Aug 2005 22:30:23 +0200
From: Jean Delvare <khali@linux-fr.org>
To: Nathan Lutchansky <lutchann@litech.org>, Greg KH <greg@kroah.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
       LM Sensors <lm-sensors@lm-sensors.org>
Subject: Re: [PATCH 0/5] improve i2c probing
Message-Id: <20050816223023.0a1852d0.khali@linux-fr.org>
In-Reply-To: <20050816030509.GG24959@litech.org>
References: <20050815175106.GA24959@litech.org>
	<20050815233958.1f170d15.khali@linux-fr.org>
	<20050816030509.GG24959@litech.org>
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nathan,

> OK, so I realized a few hours ago that the i2c_probe_device and
> i2c_remove_device interface is probably the wrong way to go about
> things, and it's broken anyway because the instantiated devices don't
> survive if the client driver module is unloaded and reloaded.

There is no way a client would survive a driver module cycling. This is
the whole point of module cycling :) Clients have to be destroyed at the
time the driver module is unloaded, as the driver holds all the client
code. This will happen whatever the implementation, so I don't see what
you think is wrong here.

>                     (...)  With the i2c_probe_device function I was
> attempting to provide a means for video capture card drivers to
> directly instantiate the i2c clients it already knows exist without
> having to probe for them.

You don't need to convince me that i2c_probe_device() or something
similar is a good idea :) Media/video and RTC driver authors have been
complaining for quite some time about the lack of such a mechanism.

> (The i2c_remove_device function was only present for symmetry...)

Symmetry is not needed. If you look at the current code, you'll see that
loading a client driver and unloading it are not similar operations.

> My new (well, old) idea for explicitly instantiating i2c clients,
> instead of i2c_probe_device, is to put a new field into the
> i2c_adapter with a list of (driver id, address, kind) tuples that
> should be force-detected by the i2c core.
> 
>  1. Video capture card driver discovers new capture card
>  2. Driver creates new (unprobed) i2c adapter with this device list:
>      {
>          { I2C_DRIVERID_EEPROM, 0x50, 0 }
>      }
>  3. i2c core does no probing but force-detects an EEPROM at 0x50
>  4. Driver reads EEPROM and updates the device list:
>      {
>          { I2C_DRIVERID_EEPROM, 0x50, 0 }
>          { I2C_DRIVERID_SAA7115, 0x20, 0 }
>          { I2C_DRIVERID_TUNER, 0x61, TUNER_PHILIPS_FM1236_MK3 }
>      }
>  5. Driver somehow notifies the i2c core that the device list changed
>  6. i2c core force-detects the remaining two clients

I don't much like it. You are trying to add to i2c_adapter something
that doesn't belong to it IMHO. Why not simply pass the client force
information to the probe function explicitely, like you originally
planned? Sounds much more modular to me. I really don't get what problem
you are trying to solve with this new proposal.

We most certainly won't get much further without real patches to
illustrate the possibilities anyway.

> > One possibility would be to have an additional class of client, say
> > I2C_CLASS_MISC. This would cover all the chip drivers which do not
> > have a well-defined class, so that every client would *have to*
> > define a class (we could enforce that at core level - I think this
> > was the planned ultimate goal of .class when it was first
> > introduced.)
> 
> I'm not sure I like lumping all the "unclassified" clients together.
> The class mechanism is used to limit probing of an adapter to client
> drivers with similar functions, so putting a bunch of client drivers
> that would never be on the same bus into the same class is kind of
> silly. (You'd never expect to find a keyboard controller on the same
> bus as an IR motion sensor, for example.)

This definitely wouldn't be worse than the current state where these
drivers will probe for clients on all adapters ;)

However, you are right that I2C_CLASS_MISC is a bad idea. We can use
I2C_CLASS_ALL for the exact same purpose, as described below.

Can we establish a list of these unclassified clients, and determine
their needs? I do believe that for example RTC drivers do know exactly
where their clients are, and would be fine with not probing for them,
just like is the case of the media/video drivers. So far, we have been
discussing about adapters that didn't want to be probed, but I now tend
to think that this applies to client drivers as well. In other words, a
client driver not defining a class would mean "never probe" rather than
"probe all busses". This brings back some symmetry into the problem.

The benefit here would be that the class matching code would be reduced
to its most simple expression, with no exceptions. Adapters and client
drivers which are fine with the automatic probing mechanism would *have
to* define their classes. Adapters and client drivers which do not want
the i2c-core to handle client registrations for them simply do not
define their class, and handle everything on their own (through
attach_adapter().)

It is probably worth reminding the semantics for the i2c_adapter class.
It doesn't define the kind of devices that can be found on this bus, but
instead the kind of client devices the i2c-core is *allowed to probe
for* on this bus. I hope that we agree on this. Likewise, the i2c_driver
class is not about the kind of chip the driver is for, but about which
busses this client driver wants to attach to in a probed, automated way.

> > If I2C_CLASS_MISC doesn't please you, then we can simply keep the
> > idea that i2c_adapters that do not want to be probed do not define a
> > class.
> 
> I like this better.  :-)  This kind of implies, though, that i2c
> adapters that define *any* class would be probed by drivers that had
> no class defined.  This might be the correct way to go about it. 

On second thought, I don't think so. The fact that adding a given class
to an adapter would allow client drivers that do *not* define this class
to probe the bus is a weird side effect, and hard to justify. But
fortunately my new proposal doesn't suffer from this problem.

I propose that we go for the most simple and symmetrical model.
i2c_add_driver and i2c_add_adapter call driver->attach_adapter() if it
is defined, then call i2c_probe() if everything needed is defined and if
(and only if) driver->class & adap->class is non-zero. Adapter or client
drivers that really want to accept all clients or to connect to all
adapters, resepectively, can use I2C_CLASS_ALL, although I wouldn't
expect many to do. Note that this is only the expression of an
acceptance, a client driver with I2C_CLASS_ALL will still not connect to
an adapter with no class defined (and that's exactly what we want, isn't
it?)

I don't think we need anything more complex than that, unless someone
can point out a need that my proposal doesn't fulfill.

Of course, we will need your i2c_probe_device() function (or anything
equivalent, but it looked just fine to me) for the non-probed client
registrations.

Thanks,
-- 
Jean Delvare
