Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317896AbSGPRSe>; Tue, 16 Jul 2002 13:18:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317899AbSGPRSd>; Tue, 16 Jul 2002 13:18:33 -0400
Received: from air-2.osdl.org ([65.172.181.6]:63373 "EHLO geena.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S317896AbSGPRSc>;
	Tue, 16 Jul 2002 13:18:32 -0400
Date: Tue, 16 Jul 2002 10:19:57 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: <mochel@geena.pdx.osdl.net>
To: Oliver Neukum <oliver@neukum.name>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Driver reference counting and locking, again
In-Reply-To: <200207161138.44246.oliver@neukum.name>
Message-ID: <Pine.LNX.4.33.0207161017260.14360-100000@geena.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 16 Jul 2002, Oliver Neukum wrote:

> Am Dienstag, 16. Juli 2002 02:56 schrieb Patrick Mochel:
> > Ok, here is another stab at trying to get reference counting and locking
> > right for drivers.
> >
> > The short of it is that struct device_driver gets an owner field, which
> > should be initialized to THIS_MODULE in the driver.
> 
> In your implementation it would seem that get_driver can suceed while
> remove_driver is already running and the deletion from bus_list has
> already happened.

Yes, you're right. Relative patch appended. You can also pull from 
bk://ldm.bkbits.net/linux-2.5/

	-pat

ChangeSet@1.729, 2002-07-16 10:16:20-07:00, mochel@osdl.org
  driver refcounting:
  Remove driver from global list as early as possible in remove_driver

diffstat results: 
 drivers/base/driver.c |    8 ++++----
 1 files changed, 4 insertions, 4 deletions

diff -Nru a/drivers/base/driver.c b/drivers/base/driver.c
--- a/drivers/base/driver.c	Tue Jul 16 10:16:39 2002
+++ b/drivers/base/driver.c	Tue Jul 16 10:16:39 2002
@@ -86,6 +86,10 @@
 
 void remove_driver(struct device_driver * drv)
 {
+	down(&driver_sem);
+	list_del_init(&drv->g_list);
+	up(&driver_sem);
+
 	write_lock(&drv->bus->lock);
 	list_del_init(&drv->bus_list);
 	write_unlock(&drv->bus->lock);
@@ -93,10 +97,6 @@
 	pr_debug("Unregistering driver '%s' from bus '%s'\n",drv->name,drv->bus->name);
 	driver_detach(drv);
 	driverfs_remove_dir(&drv->dir);
-
-	down(&driver_sem);
-	list_del_init(&drv->g_list);
-	up(&driver_sem);
 
 	if (drv->release)
 		drv->release(drv);

