Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965076AbVHPDFO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965076AbVHPDFO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Aug 2005 23:05:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965075AbVHPDFO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Aug 2005 23:05:14 -0400
Received: from kent.litech.org ([72.9.242.215]:3602 "EHLO kent.litech.org")
	by vger.kernel.org with ESMTP id S965076AbVHPDFN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Aug 2005 23:05:13 -0400
Date: Mon, 15 Aug 2005 23:05:09 -0400
From: Nathan Lutchansky <lutchann@litech.org>
To: Jean Delvare <khali@linux-fr.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Greg KH <greg@kroah.com>
Subject: Re: [PATCH 0/5] improve i2c probing
Message-ID: <20050816030509.GG24959@litech.org>
References: <20050815175106.GA24959@litech.org> <20050815233958.1f170d15.khali@linux-fr.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050815233958.1f170d15.khali@linux-fr.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 15, 2005 at 11:39:58PM +0200, Jean Delvare wrote:
> > The second improvement (which is really the point of this patch set)
> > is to add the functions i2c_probe_device and i2c_remove_device for
> > directly creating and destroying i2c clients on a particular adapter:
> > 
> >     int i2c_probe_device(struct i2c_adapter *adapter, int driver_id,
> >                          int addr, int kind);
> >     int i2c_remove_device(struct i2c_adapter *adapter, int driver_id,
> >                           int addr);
> > 
> 
> I think I understand the point of i2c_probe_device(). However, it would
> help if you could additionally show how this is going to help the
> media/video drivers. Currently, all these drivers use the traditional
> probing mecanism, and have to jam "foreign" probes, right? I would hope
> that these two patches will make it possible to improve this. Can you
> provide a few  examples of use? We need to figure out how good this new
> interface/mechanism is, and this can only be done with concrete
> examples.

OK, so I realized a few hours ago that the i2c_probe_device and
i2c_remove_device interface is probably the wrong way to go about
things, and it's broken anyway because the instantiated devices don't
survive if the client driver module is unloaded and reloaded.

Here's what I'm after.  Devices like video capture cards often have
on-board i2c buses for controlling chips like the video decoder and TV
tuner.  The devices connected to these buses and their addresses can
almost always be determined by the PCI/USB ID of the card or by reading
an on-board EEPROM.  With these special-purpose i2c buses, there's
really no need to do any i2c probing, but we've always been forced to
use probing anyway because that's the only way to instantiate new i2c
clients.  With the i2c_probe_device function I was attempting to provide
a means for video capture card drivers to directly instantiate the i2c
clients it already knows exist without having to probe for them.  (The
i2c_remove_device function was only present for symmetry...)

My new (well, old) idea for explicitly instantiating i2c clients,
instead of i2c_probe_device, is to put a new field into the i2c_adapter
with a list of (driver id, address, kind) tuples that should be
force-detected by the i2c core.

 1. Video capture card driver discovers new capture card
 2. Driver creates new (unprobed) i2c adapter with this device list:
     {
         { I2C_DRIVERID_EEPROM, 0x50, 0 }
     }
 3. i2c core does no probing but force-detects an EEPROM at 0x50
 4. Driver reads EEPROM and updates the device list:
     {
         { I2C_DRIVERID_EEPROM, 0x50, 0 }
         { I2C_DRIVERID_SAA7115, 0x20, 0 }
         { I2C_DRIVERID_TUNER, 0x61, TUNER_PHILIPS_FM1236_MK3 }
     }
 5. Driver somehow notifies the i2c core that the device list changed
 6. i2c core force-detects the remaining two clients

I'd really like to model the known-device list after the PCI subsystem
and other buses that track what devices "should" be connected based on
configuration information from the bus's host adapter, but I haven't had
time to research it yet.

> I am not totally convinced by the reintroduction of the i2c_adapter
> flags. I hope we can do without it.
> 
> One possibility would be to have an additional class of client, say
> I2C_CLASS_MISC. This would cover all the chip drivers which do not have
> a well-defined class, so that every client would *have to* define a
> class (we could enforce that at core level - I think this was the
> planned ultimate goal of .class when it was first introduced.)

I'm not sure I like lumping all the "unclassified" clients together.
The class mechanism is used to limit probing of an adapter to client
drivers with similar functions, so putting a bunch of client drivers that
would never be on the same bus into the same class is kind of silly.
(You'd never expect to find a keyboard controller on the same bus
as an IR motion sensor, for example.)

> If I2C_CLASS_MISC doesn't please you, then we can simply keep the idea
> that i2c_adapters that do not want to be probed do not define a class.

I like this better.  :-)  This kind of implies, though, that i2c
adapters that define *any* class would be probed by drivers that had no
class defined.  This might be the correct way to go about it.  -Nathan
