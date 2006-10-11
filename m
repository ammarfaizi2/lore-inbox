Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030452AbWJKOti@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030452AbWJKOti (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 10:49:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030451AbWJKOth
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 10:49:37 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:23998 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP
	id S1030452AbWJKOth (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 10:49:37 -0400
Date: Wed, 11 Oct 2006 10:49:36 -0400 (EDT)
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
In-Reply-To: <20061009131434.6e3ff0e2@gondolin.boeblingen.de.ibm.com>
Message-ID: <Pine.LNX.4.44L0.0610111036290.5690-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 9 Oct 2006, Cornelia Huck wrote:

> From: Cornelia Huck <cornelia.huck@de.ibm.com>
> 
> Check for return value of bus_attach_device() in device_add(). Add a
> function bus_delete_device() that undos the effects of bus_add_device().
> bus_remove_device() now undos the effects of bus_attach_device() only.
> device_del() now calls bus_remove_device(), kobject_uevent(),
> bus_delete_device() which makes it symmetric to the call sequence in
> device_add().

You know, I'm not so sure device registration should fail when 
bus_attach_device() returns an error.

After all, the device really is there even if it's not working properly.  
In the Windows device manager it would show up with a big red X through 
it, but it _would_ show up.

Furthermore there are subtle problems that can arise.  In effect, the
device is registered for a brief time (while the driver is probed) and
then unregistered without giving the bus subsystem a chance to prepare for
the removal.  With USB this can lead to problems; if the driver called
usb_set_interface() then child devices would be created below the one
being probed -- and they would never get removed.

Has this question been raised before?  Is there any reason not to 
register a device even when probing fails?

In fact, we might want to separate driver probing from device_add()  
entirely.  That is, make them available as two separate function calls.  
That way the subsystem driver will have a chance to create attribute files
before a uevent is generated and a driver is loaded.  (That should help
udev to work better.)  This would require a larger change, though --
probably requiring an alternate version of device_add().

Alan Stern


