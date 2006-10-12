Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422736AbWJLQAH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422736AbWJLQAH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Oct 2006 12:00:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422738AbWJLQAH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Oct 2006 12:00:07 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:27653 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP
	id S1422736AbWJLP75 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Oct 2006 11:59:57 -0400
Date: Thu, 12 Oct 2006 11:59:45 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Cornelia Huck <cornelia.huck@de.ibm.com>
cc: Jaroslav Kysela <perex@suse.cz>, Andrew Morton <akpm@osdl.org>,
       ALSA development <alsa-devel@alsa-project.org>,
       Takashi Iwai <tiwai@suse.de>, Greg KH <gregkh@suse.de>,
       LKML <linux-kernel@vger.kernel.org>, Jiri Kosina <jikos@jikos.cz>,
       Castet Matthieu <castet.matthieu@free.fr>,
       Akinobu Mita <akinobu.mita@gmail.com>
Subject: Re: [PATCH] Driver core: Don't ignore bus_attach_device() retval
In-Reply-To: <20061012113047.1df2a9c8@gondolin.boeblingen.de.ibm.com>
Message-ID: <Pine.LNX.4.44L0.0610121113140.6435-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Oct 2006, Cornelia Huck wrote:

> On Wed, 11 Oct 2006 10:49:36 -0400 (EDT),
> Alan Stern <stern@rowland.harvard.edu> wrote:
> 
> > You know, I'm not so sure device registration should fail when 
> > bus_attach_device() returns an error.
> 
> Hm, let's see why bus_attach_device() might fail:
> 
> * device_bind_driver() failed to create some symlinks. We may
> consider not to fail in this case, since sysfs_remove_link() is fine
> even for non-existing links.

It would be okay to fail in this case, because the driver would not have 
been probed at all.

> * probing failed for one possible driver with something other than
> -ENODEV or -ENXIO. Not sure if we really should abort in this case.
> We'd just end up with an unbound device, and a driver returning (for
> example) -ENOMEM for probing may just be a really dumb driver trying to
> allocate an insane amount of memory (and the next driver might just be
> fine).

Yes, this is exactly what I meant.  Having an unbound device is okay.

Note also that when multithreaded probing is used, there is no way for 
driver_probe_device() to return an error from really_probe().  We may as 
well act the same way when multithreaded probing isn't used.

I haven't looked at the driver core much since multithreaded probing was
added.  The multithreading part has a bad locking bug: the new thread
doesn't acquire the necessary semaphores.  Also it probes multiple drivers
for the same device in parallel, which seems wrong.  Since multiple probes 
can't run concurrently there's no reason to have a separate thread for 
each one.  There should be only one new thread per device.


> > Furthermore there are subtle problems that can arise.  In effect, the
> > device is registered for a brief time (while the driver is probed) and
> > then unregistered without giving the bus subsystem a chance to prepare for
> > the removal.  With USB this can lead to problems; if the driver called
> > usb_set_interface() then child devices would be created below the one
> > being probed -- and they would never get removed.
> 
> One way to fix this would be to make device_bind_driver() always
> succeed (even without symlinks),

Hmm... If device_bind_driver() fails -- because of the symlinks -- then
the device is still on the driver's klist, because the klist_add_tail() in
driver_bound() never gets undone.  Another bug.  Clearly
device_bind_driver() should call driver_sysfs_add() before driver_bound(),
not after.  Or else it should never fail.

>  the other to call the ->remove
> function if device_bind_driver() fails (assuming that the ->remove
> method should undo the stuff done in ->probe).

It's a lot safer and easier just to switch the order of the calls in 
device_bind_driver().

Note that it's also possible for device_attach() to fail through the 
__device_attach() -> driver_probe_device() -> really_probe() pathway.  I 
think in all cases, bus_attach_device() really should ignore the return 
code from device_attach().


> > In fact, we might want to separate driver probing from device_add()  
> > entirely.  That is, make them available as two separate function calls.  
> > That way the subsystem driver will have a chance to create attribute files
> > before a uevent is generated and a driver is loaded.  (That should help
> > udev to work better.)  This would require a larger change, though --
> > probably requiring an alternate version of device_add().
> 
> Shouldn't subsystems that need attributes early just use dev->groups,
> class->dev_attrs or bus->dev_attrs? These attribute groups are added
> before the uevent is generated.

Yes, you're right.  Forget about this part.

Alan Stern

