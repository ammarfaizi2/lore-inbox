Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261853AbVAYHdr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261853AbVAYHdr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 02:33:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261854AbVAYHdq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 02:33:46 -0500
Received: from brmea-mail-4.Sun.COM ([192.18.98.36]:64212 "EHLO
	brmea-mail-4.sun.com") by vger.kernel.org with ESMTP
	id S261853AbVAYHdU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 02:33:20 -0500
Date: Tue, 25 Jan 2005 02:32:51 -0500
From: Mike Waychison <Michael.Waychison@Sun.COM>
Subject: Re: [PATCH] fix bad locking in drivers/base/driver.c
In-reply-to: <20050125055651.GA1987@kroah.com>
To: Greg KH <greg@kroah.com>
Cc: Jirka Kosina <jikos@jikos.cz>, Patrick Mochel <mochel@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
Message-id: <41F5F623.5090903@sun.com>
MIME-version: 1.0
Content-type: multipart/mixed; boundary="Boundary_(ID_D+YHYb4SIh7zhNrkMoeM8Q)"
X-Accept-Language: en-us, en
User-Agent: Debian Thunderbird 1.0 (X11/20050116)
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
References: <Pine.LNX.4.58.0501241921310.5857@twin.jikos.cz>
 <20050125055651.GA1987@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

--Boundary_(ID_D+YHYb4SIh7zhNrkMoeM8Q)
Content-type: text/plain; charset=ISO-8859-1
Content-transfer-encoding: 7BIT

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Greg KH wrote:
> On Mon, Jan 24, 2005 at 07:25:19PM +0100, Jirka Kosina wrote:
> 
>>Hi,
>>
>>there has been (for quite some time) a bug in function driver_unregister() 
>>- the lock/unlock sequence is protecting nothing and the actual 
>>bus_remove_driver() is called outside critical section.
>>
>>Please apply.
> 
> 
> No, please read the comment in the code about why this is the way it is.
> The code is correct as is.
> 

Why don't we clean this up as in the proposed attached patch (against
2.6.10).  Compile-tested only.

- --
Mike Waychison
Sun Microsystems, Inc.
1 (650) 352-5299 voice
1 (416) 202-8336 voice

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
NOTICE:  The opinions expressed in this email are held by me,
and may not represent the views of Sun Microsystems, Inc.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFB9fYjdQs4kOxk3/MRAgzrAJ96+aEawx/A0Sf0d5HqArsasgYrqQCZAVzp
wuGctEJpxqtxezPD7LNGS+U=
=77WW
-----END PGP SIGNATURE-----

--Boundary_(ID_D+YHYb4SIh7zhNrkMoeM8Q)
Content-type: text/x-patch; name=convert_unload_sem_to_completion.patch
Content-transfer-encoding: 7BIT
Content-disposition: inline; filename=convert_unload_sem_to_completion.patch

Get rid of semaphore abuse by converting device_driver->unload_sem semaphore to device_driver->unloaded completion.

This should get rid of any confusion as well as save a few bytes in the
process.

Signed-off-by: Mike Waychison <michael.waychison@sun.com>
---

 drivers/base/bus.c     |    2 +-
 drivers/base/driver.c  |   13 ++++++-------
 include/linux/device.h |    2 +-
 3 files changed, 8 insertions(+), 9 deletions(-)

Index: linux-2.6.10/drivers/base/bus.c
===================================================================
--- linux-2.6.10.orig/drivers/base/bus.c	2004-12-24 16:34:26.000000000 -0500
+++ linux-2.6.10/drivers/base/bus.c	2005-01-25 02:14:10.000000000 -0500
@@ -65,7 +65,7 @@ static struct sysfs_ops driver_sysfs_ops
 static void driver_release(struct kobject * kobj)
 {
 	struct device_driver * drv = to_driver(kobj);
-	up(&drv->unload_sem);
+	complete(&drv->unloaded);
 }
 
 static struct kobj_type ktype_driver = {
Index: linux-2.6.10/drivers/base/driver.c
===================================================================
--- linux-2.6.10.orig/drivers/base/driver.c	2004-12-24 16:35:25.000000000 -0500
+++ linux-2.6.10/drivers/base/driver.c	2005-01-25 02:16:31.000000000 -0500
@@ -79,14 +79,14 @@ void put_driver(struct device_driver * d
  *	since most of the things we have to do deal with the bus
  *	structures.
  *
- *	The one interesting aspect is that we initialize @drv->unload_sem
- *	to a locked state here. It will be unlocked when the driver
- *	reference count reaches 0.
+ *	The one interesting aspect is that we setup @drv->unloaded
+ *	as a completion that gets complete when the driver reference 
+ *	count reaches 0.
  */
 int driver_register(struct device_driver * drv)
 {
 	INIT_LIST_HEAD(&drv->devices);
-	init_MUTEX_LOCKED(&drv->unload_sem);
+	init_completion(&drv->unloaded);
 	return bus_add_driver(drv);
 }
 
@@ -97,7 +97,7 @@ int driver_register(struct device_driver
  *
  *	Again, we pass off most of the work to the bus-level call.
  *
- *	Though, once that is done, we attempt to take @drv->unload_sem.
+ *	Though, once that is done, we wait until @drv->unloaded is copmleted.
  *	This will block until the driver refcount reaches 0, and it is
  *	released. Only modular drivers will call this function, and we
  *	have to guarantee that it won't complete, letting the driver
@@ -107,8 +107,7 @@ int driver_register(struct device_driver
 void driver_unregister(struct device_driver * drv)
 {
 	bus_remove_driver(drv);
-	down(&drv->unload_sem);
-	up(&drv->unload_sem);
+	wait_for_completion(&drv->unloaded);
 }
 
 /**
Index: linux-2.6.10/include/linux/device.h
===================================================================
--- linux-2.6.10.orig/include/linux/device.h	2004-12-24 16:35:28.000000000 -0500
+++ linux-2.6.10/include/linux/device.h	2005-01-25 02:13:13.716384240 -0500
@@ -102,7 +102,7 @@ struct device_driver {
 	char			* name;
 	struct bus_type		* bus;
 
-	struct semaphore	unload_sem;
+	struct completion	unloaded;
 	struct kobject		kobj;
 	struct list_head	devices;
 

--Boundary_(ID_D+YHYb4SIh7zhNrkMoeM8Q)--
