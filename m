Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269488AbUJLGdf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269488AbUJLGdf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Oct 2004 02:33:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269494AbUJLGdf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Oct 2004 02:33:35 -0400
Received: from smtp813.mail.sc5.yahoo.com ([66.163.170.83]:39579 "HELO
	smtp813.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S269488AbUJLGda (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Oct 2004 02:33:30 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Greg KH <greg@kroah.com>
Subject: Re: Driver core change request
Date: Tue, 12 Oct 2004 01:29:59 -0500
User-Agent: KMail/1.6.2
Cc: LKML <linux-kernel@vger.kernel.org>, Patrick Mochel <mochel@osdl.org>
References: <200410062354.18885.dtor_core@ameritech.net> <200410072159.11578.dtor_core@ameritech.net> <20041008214820.GA1096@kroah.com>
In-Reply-To: <20041008214820.GA1096@kroah.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200410120129.59221.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 08 October 2004 04:48 pm, Greg KH wrote:
> On Thu, Oct 07, 2004 at 09:59:10PM -0500, Dmitry Torokhov wrote:
> > On Thursday 07 October 2004 04:40 pm, Greg KH wrote:
> > > On Wed, Oct 06, 2004 at 11:54:18PM -0500, Dmitry Torokhov wrote:
> > > > Hi,
> > > > 
> > > > I am reworking my sysfs serio patches (trying to get dynamic psmouse
> > > > protocol switching) and I am wondering if we could export device_attach
> > > > function. Serio system allows user to request device rescan - force current
> > > > driver to let go off the device and find another suitable driver. Also user
> > > > can manually request device to be disconnected/connected to a driver. By
> > > > having device_attach exported I could get rid of some duplicated code.
> > > 
> > > driver_attach() is global, so I don't have a problem with making
> > > device_attach() global either.  Just send me a patch :)
> > > 
> > 
> > OK. BTW, while driver_attach is global it is not exported. Should I mark both
> > of them EXPORT_GPL_ONLY? 
> 
> No, pci can not be a module.  Can your serio core be a module?  If not,
> just make it global.  But if so, yes, EXPORT_SYMBOL_GPL() is the proper
> marking.
> 

Yes serio and gameport (which I am planning to convert to driver model as well)
can be built as modules.

> > > > I.e driver_probe_device is exported. Does it have a chance to be accepted?
> > > 
> > > What's wrong with doing what the pci core does in this situation and
> > > call driver_attach()?
> > > 
> > 
> > Well, I need to be able to work with a specific port so when I am doing
> > 
> > 	echo -n "serio_raw" > /sys/bus/serio/devices/serio1/driver
> > 
> > I want only serio1 be affected, not every disconnected port that can work
> > with serio_raw. driver_attach() will claim all of them. 
> > 
> > The difference is that serio system allows you to have several drivers
> > that can drive the same hardware and user gets to chose which driver gets
> > the honors. I.e given 4 PS/2 ports in the system user might want to have
> > raw access to port #2 (via serio_raw) while using standard psmouse driver
> > for the rest of them. With PCI if you have 2 drivers and 2 exactly same
> > cards you do not have ability to bind first driver to one of the cards and
> > second driver to the other.
> 
> Nice.  We want to make this kind of functionality avaiable to all
> busses, and not have it be a bus only type feature.  So if you can see
> any way it could be moved into the core, I'd be all for it.
> 

I have been looking at it entire weekend and I do not presently see a way to
make this facility truly generic. That is because pretty much all buses
perform additional steps besides code in driver->remove() which driver core
does is not aware of. What is needed it bus->device_disconnect function that
would disconnect device and probably destroy all children.

For now I added:

- "driver" default device attribute that produces name of currently bound
  driver uppon read.
- bus->rebind_handler method that is called when someone writes to "driver"
  attribute and allows to perform bunctions like disconnecting device or
  rebinding it to alternative driver in bus-specific way.
- "bind_mode" default device and driver attributes that can be "auto" or
  "manual". When device or driver marked as manual bind device_attach()
  and driver_attach() will ignore them. They are expected to be bound by
  bus->rebind_handler (via driver_probe_device()).

I also renamed bus_match to driver_probe_device() and exported it, along
with device_attach and driver_attach.

Please let me know if its acceptable.

The patches are suitable for importing with bkimport utility (by Bjorn
Helgaas?) that allows preserve per-file comments.

	http://www.geocities.com/dt_or/misc/

-- 
Dmitry
