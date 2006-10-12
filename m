Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750968AbWJLRRB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750968AbWJLRRB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Oct 2006 13:17:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751423AbWJLRRA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Oct 2006 13:17:00 -0400
Received: from mtagate3.de.ibm.com ([195.212.29.152]:16606 "EHLO
	mtagate3.de.ibm.com") by vger.kernel.org with ESMTP
	id S1750968AbWJLRQ7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Oct 2006 13:16:59 -0400
Date: Thu, 12 Oct 2006 19:17:30 +0200
From: Cornelia Huck <cornelia.huck@de.ibm.com>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Jaroslav Kysela <perex@suse.cz>, Andrew Morton <akpm@osdl.org>,
       ALSA development <alsa-devel@alsa-project.org>,
       Takashi Iwai <tiwai@suse.de>, Greg KH <gregkh@suse.de>,
       LKML <linux-kernel@vger.kernel.org>, Jiri Kosina <jikos@jikos.cz>,
       Castet Matthieu <castet.matthieu@free.fr>,
       Akinobu Mita <akinobu.mita@gmail.com>
Subject: Re: [PATCH] Driver core: Don't ignore bus_attach_device() retval
Message-ID: <20061012191730.395bc538@gondolin.boeblingen.de.ibm.com>
In-Reply-To: <Pine.LNX.4.44L0.0610121113140.6435-100000@iolanthe.rowland.org>
References: <20061012113047.1df2a9c8@gondolin.boeblingen.de.ibm.com>
	<Pine.LNX.4.44L0.0610121113140.6435-100000@iolanthe.rowland.org>
X-Mailer: Sylpheed-Claws 2.5.3 (GTK+ 2.8.20; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Oct 2006 11:59:45 -0400 (EDT),
Alan Stern <stern@rowland.harvard.edu> wrote:

> > * device_bind_driver() failed to create some symlinks. We may
> > consider not to fail in this case, since sysfs_remove_link() is fine
> > even for non-existing links.
> 
> It would be okay to fail in this case, because the driver would not have 
> been probed at all.

In really_probe(), it is called after ->probe has been called (though
the code does nothing but complain in the failure case).

> > * probing failed for one possible driver with something other than
> > -ENODEV or -ENXIO. Not sure if we really should abort in this case.
> > We'd just end up with an unbound device, and a driver returning (for
> > example) -ENOMEM for probing may just be a really dumb driver trying to
> > allocate an insane amount of memory (and the next driver might just be
> > fine).
> 
> Yes, this is exactly what I meant.  Having an unbound device is okay.

Maybe ignoring all probe errors would be best here? (Calling
device_bind_driver() only on success, of course.)

> I haven't looked at the driver core much since multithreaded probing was
> added.  The multithreading part has a bad locking bug: the new thread
> doesn't acquire the necessary semaphores.  Also it probes multiple drivers
> for the same device in parallel, which seems wrong.  Since multiple probes 
> can't run concurrently there's no reason to have a separate thread for 
> each one.  There should be only one new thread per device.

Currently, it is the device driver which specifies whether multithreaded
probe should be done. Maybe this should rather be specified per
subsystem? Having several bus_for_each_drv(..., dev, __device_attach)
run in parallel makes more sense to me than the current approach.

> > One way to fix this would be to make device_bind_driver() always
> > succeed (even without symlinks),
> 
> Hmm... If device_bind_driver() fails -- because of the symlinks -- then
> the device is still on the driver's klist, because the klist_add_tail() in
> driver_bound() never gets undone.  Another bug.

There's already been a fix:
http://marc.theaimsgroup.com/?l=linux-kernel&m=116062971226779&w=2

> Clearly
> device_bind_driver() should call driver_sysfs_add() before driver_bound(),
> not after.  Or else it should never fail.

Or that. I'm currently a bit in favour of ignoring symlink errors.

> It's a lot safer and easier just to switch the order of the calls in 
> device_bind_driver().

?? Did you mean really_probe() here?

>  I 
> think in all cases, bus_attach_device() really should ignore the return 
> code from device_attach().

This would be the only sensible approach if we had one probing thread
per device. And device_bind_driver() should probably always succeed.

-- 
Cornelia Huck
Linux for zSeries Developer
Tel.: +49-7031-16-4837, Mail: cornelia.huck@de.ibm.com
