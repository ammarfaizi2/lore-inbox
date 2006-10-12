Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161316AbWJLJab@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161316AbWJLJab (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Oct 2006 05:30:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161318AbWJLJaa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Oct 2006 05:30:30 -0400
Received: from mtagate4.de.ibm.com ([195.212.29.153]:12855 "EHLO
	mtagate4.de.ibm.com") by vger.kernel.org with ESMTP
	id S1161316AbWJLJa3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Oct 2006 05:30:29 -0400
Date: Thu, 12 Oct 2006 11:30:47 +0200
From: Cornelia Huck <cornelia.huck@de.ibm.com>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Jaroslav Kysela <perex@suse.cz>, Andrew Morton <akpm@osdl.org>,
       ALSA development <alsa-devel@alsa-project.org>,
       Takashi Iwai <tiwai@suse.de>, Greg KH <gregkh@suse.de>,
       LKML <linux-kernel@vger.kernel.org>, Jiri Kosina <jikos@jikos.cz>,
       Castet Matthieu <castet.matthieu@free.fr>,
       Akinobu Mita <akinobu.mita@gmail.com>
Subject: Re: [PATCH] Driver core: Don't ignore bus_attach_device() retval
Message-ID: <20061012113047.1df2a9c8@gondolin.boeblingen.de.ibm.com>
In-Reply-To: <Pine.LNX.4.44L0.0610111036290.5690-100000@iolanthe.rowland.org>
References: <20061009131434.6e3ff0e2@gondolin.boeblingen.de.ibm.com>
	<Pine.LNX.4.44L0.0610111036290.5690-100000@iolanthe.rowland.org>
X-Mailer: Sylpheed-Claws 2.5.3 (GTK+ 2.8.20; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Oct 2006 10:49:36 -0400 (EDT),
Alan Stern <stern@rowland.harvard.edu> wrote:

> You know, I'm not so sure device registration should fail when 
> bus_attach_device() returns an error.

Hm, let's see why bus_attach_device() might fail:

* device_bind_driver() failed to create some symlinks. We may
consider not to fail in this case, since sysfs_remove_link() is fine
even for non-existing links.

* probing failed for one possible driver with something other than
-ENODEV or -ENXIO. Not sure if we really should abort in this case.
We'd just end up with an unbound device, and a driver returning (for
example) -ENOMEM for probing may just be a really dumb driver trying to
allocate an insane amount of memory (and the next driver might just be
fine).

> Furthermore there are subtle problems that can arise.  In effect, the
> device is registered for a brief time (while the driver is probed) and
> then unregistered without giving the bus subsystem a chance to prepare for
> the removal.  With USB this can lead to problems; if the driver called
> usb_set_interface() then child devices would be created below the one
> being probed -- and they would never get removed.

One way to fix this would be to make device_bind_driver() always
succeed (even without symlinks), the other to call the ->remove
function if device_bind_driver() fails (assuming that the ->remove
method should undo the stuff done in ->probe).

> In fact, we might want to separate driver probing from device_add()  
> entirely.  That is, make them available as two separate function calls.  
> That way the subsystem driver will have a chance to create attribute files
> before a uevent is generated and a driver is loaded.  (That should help
> udev to work better.)  This would require a larger change, though --
> probably requiring an alternate version of device_add().

Shouldn't subsystems that need attributes early just use dev->groups,
class->dev_attrs or bus->dev_attrs? These attribute groups are added
before the uevent is generated.

-- 
Cornelia Huck
Linux for zSeries Developer
Tel.: +49-7031-16-4837, Mail: cornelia.huck@de.ibm.com
