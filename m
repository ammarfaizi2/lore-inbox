Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261559AbSKTRmt>; Wed, 20 Nov 2002 12:42:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261561AbSKTRmt>; Wed, 20 Nov 2002 12:42:49 -0500
Received: from e34.co.us.ibm.com ([32.97.110.132]:45292 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S261559AbSKTRms>; Wed, 20 Nov 2002 12:42:48 -0500
Date: Wed, 20 Nov 2002 09:51:27 -0800
From: Mike Anderson <andmike@us.ibm.com>
To: Rick Lindsley <ricklind@us.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [BUG] 2.5.47: sysfs hierarchy can begin to disintegrate
Message-ID: <20021120175127.GC1366@beaverton.ibm.com>
Mail-Followup-To: Rick Lindsley <ricklind@us.ibm.com>,
	linux-kernel@vger.kernel.org
References: <200211200925.gAK9Pl002345@owlet.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200211200925.gAK9Pl002345@owlet.beaverton.ibm.com>
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.0.32 on an i486
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rick Lindsley [ricklind@us.ibm.com] wrote:
> 2.5.47 (top of bk tree on 11/14, to be precise)
> 
> /sys has a sysfs file system on it.  I'd expect /sys/block to contain
> hd[abc], an assortment of ram disks, and perhaps some SCSI disks.
> However, these all appear under /sys instead of /sys/block.  /sys/block
> exists but is empty.
> 
> Interesting observation: the megaraid controller has some problem right
> now (suspected to be hardware) wherein its scsi disks appear at boot
> time but then cannot be accessed later and are subsequently detached.
> Since this could well be a little-used and little-tested path, my
> suspicion is that either the megaraid, scsi, or sysfs code has a bug when
> disks are detached.  So far, I've not been able to find one, however, so
> I thought I'd report this in case others might know just where to peek.
> Could it be that removing entries from sysfs is done incorrectly in
> some cases?

Rick,
	There are cleanup issues in sysfs previous reported by others.
	The patch below previously sent to the list by patmans and
	myself helps in repeated insmod / rmmod / shutdown testing of
	scsi modules for us. We have not seen the null parent pointer
	problem you are seeing which causes your objects to show up
	under /sys/ (YMMV).

-andmike
--
Michael Anderson
andmike@us.ibm.com

 bus.c    |    4 +++-
 core.c   |    2 --
 driver.c |    2 ++
 3 files changed, 5 insertions(+), 3 deletions(-)
 ------

===== drivers/base/bus.c 1.22 vs edited =====
--- 1.22/drivers/base/bus.c	Thu Oct 31 08:20:23 2002
+++ edited/drivers/base/bus.c	Wed Nov  6 22:06:39 2002
@@ -209,8 +209,10 @@
 				attach(dev);
 			else
 				dev->driver = NULL;
-		} else 
+		} else  {
 			attach(dev);
+			error = 0;
+		}
 	}
 	return error;
 }
===== drivers/base/core.c 1.50 vs edited =====
--- 1.50/drivers/base/core.c	Thu Oct 31 08:20:23 2002
+++ edited/drivers/base/core.c	Wed Nov  6 13:07:47 2002
@@ -173,8 +173,6 @@
 		return -EINVAL;
 
 	device_initialize(dev);
-	if (dev->parent)
-		get_device(dev->parent);
 	error = device_add(dev);
 	if (error && dev->parent)
 		put_device(dev->parent);
===== drivers/base/driver.c 1.14 vs edited =====
--- 1.14/drivers/base/driver.c	Wed Oct 30 16:35:48 2002
+++ edited/drivers/base/driver.c	Wed Nov  6 21:41:48 2002
@@ -127,6 +127,8 @@
 	drv->present = 0;
 	spin_unlock(&device_lock);
 	pr_debug("driver %s:%s: unregistering\n",drv->bus->name,drv->name);
+	bus_remove_driver(drv);
+	kobject_unregister(&drv->kobj);
 	put_driver(drv);
 }
 
