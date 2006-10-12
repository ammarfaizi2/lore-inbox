Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750884AbWJLVlu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750884AbWJLVlu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Oct 2006 17:41:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751082AbWJLVlu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Oct 2006 17:41:50 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:24337 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP
	id S1750884AbWJLVlt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Oct 2006 17:41:49 -0400
Date: Thu, 12 Oct 2006 17:41:46 -0400 (EDT)
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
In-Reply-To: <20061012191730.395bc538@gondolin.boeblingen.de.ibm.com>
Message-ID: <Pine.LNX.4.44L0.0610121718110.8064-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Oct 2006, Cornelia Huck wrote:

> On Thu, 12 Oct 2006 11:59:45 -0400 (EDT),
> Alan Stern <stern@rowland.harvard.edu> wrote:
> 
> > > * device_bind_driver() failed to create some symlinks. We may
> > > consider not to fail in this case, since sysfs_remove_link() is fine
> > > even for non-existing links.
> > 
> > It would be okay to fail in this case, because the driver would not have 
> > been probed at all.
> 
> In really_probe(), it is called after ->probe has been called (though
> the code does nothing but complain in the failure case).

??  In really_probe(), driver_sysfs_add() is called _before_ ->probe.  So
it's okay to fail there.  And in device_bind_driver(), which is what you
were talking about above, ->probe doesn't get called anywhere.

At least, in my copy of Greg KH's development tree that's what happens.


> > > * probing failed for one possible driver with something other than
> > > -ENODEV or -ENXIO. Not sure if we really should abort in this case.
> > > We'd just end up with an unbound device, and a driver returning (for
> > > example) -ENOMEM for probing may just be a really dumb driver trying to
> > > allocate an insane amount of memory (and the next driver might just be
> > > fine).
> > 
> > Yes, this is exactly what I meant.  Having an unbound device is okay.
> 
> Maybe ignoring all probe errors would be best here? (Calling
> device_bind_driver() only on success, of course.)

I agree.


> > I haven't looked at the driver core much since multithreaded probing was
> > added.  The multithreading part has a bad locking bug: the new thread
> > doesn't acquire the necessary semaphores.  Also it probes multiple drivers
> > for the same device in parallel, which seems wrong.  Since multiple probes 
> > can't run concurrently there's no reason to have a separate thread for 
> > each one.  There should be only one new thread per device.
> 
> Currently, it is the device driver which specifies whether multithreaded
> probe should be done. Maybe this should rather be specified per
> subsystem? Having several bus_for_each_drv(..., dev, __device_attach)
> run in parallel makes more sense to me than the current approach.

Doing it per subsystem sounds right.  It looks like the multithread
probing code was added without sufficient thought beforehand.


> > > One way to fix this would be to make device_bind_driver() always
> > > succeed (even without symlinks),
> > 
> > Hmm... If device_bind_driver() fails -- because of the symlinks -- then
> > the device is still on the driver's klist, because the klist_add_tail() in
> > driver_bound() never gets undone.  Another bug.
> 
> There's already been a fix:
> http://marc.theaimsgroup.com/?l=linux-kernel&m=116062971226779&w=2

Oh, okay. (Hmmm, that message was posted earlier today...)

> > Clearly
> > device_bind_driver() should call driver_sysfs_add() before driver_bound(),
> > not after.  Or else it should never fail.
> 
> Or that. I'm currently a bit in favour of ignoring symlink errors.

I don't care too much one way or another.  Although missing symlinks might 
cause problems for certain user programs.

> > It's a lot safer and easier just to switch the order of the calls in 
> > device_bind_driver().
> 
> ?? Did you mean really_probe() here?

No, I meant device_bind_driver().  Try to create the symlinks first, and 
if that succeeds (or if you don't care when it fails) then call 
driver_bound().  This confusion may be a result of looking at different 
source trees.

> >  I 
> > think in all cases, bus_attach_device() really should ignore the return 
> > code from device_attach().
> 
> This would be the only sensible approach if we had one probing thread
> per device. And device_bind_driver() should probably always succeed.

Other people may disagree about device_bind_driver().  Best to let it fail 
for now and fix these other problems first.  It can always be changed 
later.

Do you want to write another patch?

Alan Stern

