Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1760299AbWLFIaq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760299AbWLFIaq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Dec 2006 03:30:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760300AbWLFIaq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Dec 2006 03:30:46 -0500
Received: from coyote.holtmann.net ([217.160.111.169]:54420 "EHLO
	mail.holtmann.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760299AbWLFIap (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Dec 2006 03:30:45 -0500
Subject: Re: [PATCH 32/36] driver core: Introduce device_move(): move a
	device to a new parent.
From: Marcel Holtmann <marcel@holtmann.org>
To: Greg KH <gregkh@suse.de>
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org,
       Cornelia Huck <cornelia.huck@de.ibm.com>
In-Reply-To: <20061206055843.GA12997@suse.de>
References: <11650154181661-git-send-email-greg@kroah.com>
	 <11650154221716-git-send-email-greg@kroah.com>
	 <11650154251022-git-send-email-greg@kroah.com>
	 <11650154282911-git-send-email-greg@kroah.com>
	 <11650154311175-git-send-email-greg@kroah.com>
	 <1165163163.19590.62.camel@localhost> <20061204195859.GB29637@kroah.com>
	 <1165266903.12640.35.camel@localhost> <20061204230511.GA9382@kroah.com>
	 <1165332371.2756.23.camel@localhost>  <20061206055843.GA12997@suse.de>
Content-Type: text/plain
Date: Wed, 06 Dec 2006 09:29:39 +0100
Message-Id: <1165393779.2756.38.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

> > > > > > > Provide a function device_move() to move a device to a new parent device. Add
> > > > > > > auxilliary functions kobject_move() and sysfs_move_dir().
> > > > > > > kobject_move() generates a new uevent of type KOBJ_MOVE, containing the
> > > > > > > previous path (DEVPATH_OLD) in addition to the usual values. For this, a new
> > > > > > > interface kobject_uevent_env() is created that allows to add further
> > > > > > > environmental data to the uevent at the kobject layer.
> > > > > > 
> > > > > > has this one been tested? I don't get it working. I always get an EINVAL
> > > > > > when trying to move the TTY device of a Bluetooth RFCOMM link around.
> > > > > 
> > > > > I relied on Cornelia to test this.  I think some s390 patches depend on
> > > > > this change, right?
> > > > 
> > > > my pre-condition is that the TTY device has no parent and then we move
> > > > it to a Bluetooth ACL link as child. This however is not working or the
> > > > TTY change to use device instead of class_device has broken something.
> > > 
> > > Hm, I don't think the class_device stuff has broken anything, but if you
> > > think so, please let me know.
> > 
> > I was checking why device_move() fails and it seems that the check for
> > is_registered is the problem here.
> > 
> >         if (!device_is_registered(dev)) {
> >                 error = -EINVAL;
> >                 goto out;
> >         }
> > 
> > The ACL link has been attached to the Bluetooth bus, but for some reason
> > it still thinks that it is unregistered. Is this check really needed. I
> > think it should be possible to also move devices that are not part of a
> > bus, yet. And removing that check makes it work for me.
> > 
> > And btw. I can't see any s390 patches that are using device_move() at
> > the moment.
> > 
> > > > > > And shouldn't device_move(dev, NULL) re-attach it to the virtual device
> > > > > > tree instead of failing?
> > > > > 
> > > > > Yes, that would be good to have.
> > > > 
> > > > Cornelia, please fix this, because otherwise we can't detach a device
> > > > from its parent. Storing the current virtual parent looks racy to me.
> > > 
> > > You can always restore the previous "virtual" parent from the
> > > information given to you in the device itself.  That is what the code
> > > does when it first registers the device.
> > > 
> > > And yes, I too think it should be fixed.
> > 
> > My knowledge of the driver model is still limited. Can you fix that
> > quickly. This is really needed.
> 
> As Cornelia wrote this portion of code, I will wait a bit to recieve a
> patch...

I have a patch ready for the Bluetooth subsystem that will make use of
this and move around RFCOMM TTY devices to their ACL links when the
connection has been established. So I can test this very easily.

Regards

Marcel


