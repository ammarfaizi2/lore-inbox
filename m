Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161278AbWASQaV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161278AbWASQaV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 11:30:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161302AbWASQaU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 11:30:20 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:43537 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1161278AbWASQaS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 11:30:18 -0500
Date: Thu, 19 Jan 2006 17:30:17 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Greg KH <gregkh@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/base/: proper prototypes
Message-ID: <20060119163017.GQ19398@stusta.de>
References: <20060119013242.GX19398@stusta.de> <20060119025146.GA15257@suse.de> <20060119032808.GJ19398@stusta.de> <20060119033532.GA16518@suse.de> <20060119034011.GK19398@stusta.de> <20060119040711.GA17312@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060119040711.GA17312@suse.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 18, 2006 at 08:07:11PM -0800, Greg KH wrote:
> On Thu, Jan 19, 2006 at 04:40:11AM +0100, Adrian Bunk wrote:
> > 
> > drivers/base/sys.c doesn't (this is why I noticed it).
> 
> Then it would be easier to add it there, if needed, than adding it to
> base.h where it will tried to be included twice for all of the other
> driver core files :)
> 
> Care to redo it?

Updated patch below.

> thanks,
> 
> greg k-h

cu
Adrian


<--  snip  -->


This patch contains the following changes:
- move prototypes to base.h
- sys.c should #include "base.h" for getting the prototype of it's
  global function system_bus_init()

Note that hidden in this patch there's a bugfix:

Caller and callee disagreed regarding the return type of
sysdev_shutdown().


Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 drivers/base/base.h           |    4 ++++
 drivers/base/power/resume.c   |    3 +--
 drivers/base/power/shutdown.c |    2 +-
 drivers/base/power/suspend.c  |    3 +--
 drivers/base/sys.c            |    3 +++
 5 files changed, 10 insertions(+), 5 deletions(-)

--- linux-2.6.16-rc1-mm1-full/drivers/base/base.h.old	2006-01-18 23:17:52.000000000 +0100
+++ linux-2.6.16-rc1-mm1-full/drivers/base/base.h	2006-01-19 17:06:08.000000000 +0100
@@ -19,6 +19,10 @@
 extern void driver_detach(struct device_driver * drv);
 extern int driver_probe_device(struct device_driver *, struct device *);
 
+extern void sysdev_shutdown(void);
+extern int sysdev_suspend(pm_message_t state);
+extern int sysdev_resume(void);
+
 static inline struct class_device *to_class_dev(struct kobject *obj)
 {
 	return container_of(obj, struct class_device, kobj);
--- linux-2.6.16-rc1-mm1-full/drivers/base/sys.c.old	2006-01-18 23:18:38.000000000 +0100
+++ linux-2.6.16-rc1-mm1-full/drivers/base/sys.c	2006-01-19 17:06:46.000000000 +0100
@@ -21,8 +21,11 @@
 #include <linux/slab.h>
 #include <linux/string.h>
 #include <linux/pm.h>
+#include <linux/device.h>
 #include <asm/semaphore.h>
 
+#include "base.h"
+
 extern struct subsystem devices_subsys;
 
 #define to_sysdev(k) container_of(k, struct sys_device, kobj)
--- linux-2.6.16-rc1-mm1-full/drivers/base/power/shutdown.c.old	2006-01-18 23:18:56.000000000 +0100
+++ linux-2.6.16-rc1-mm1-full/drivers/base/power/shutdown.c	2006-01-18 23:43:45.000000000 +0100
@@ -12,6 +12,7 @@
 #include <linux/device.h>
 #include <asm/semaphore.h>
 
+#include "../base.h"
 #include "power.h"
 
 #define to_dev(node) container_of(node, struct device, kobj.entry)
@@ -28,7 +29,6 @@
  * they only get one called once when interrupts are disabled.
  */
 
-extern int sysdev_shutdown(void);
 
 /**
  * device_shutdown - call ->shutdown() on each device to shutdown.
--- linux-2.6.16-rc1-mm1-full/drivers/base/power/suspend.c.old	2006-01-18 23:20:16.000000000 +0100
+++ linux-2.6.16-rc1-mm1-full/drivers/base/power/suspend.c	2006-01-18 23:43:51.000000000 +0100
@@ -9,10 +9,9 @@
  */
 
 #include <linux/device.h>
+#include "../base.h"
 #include "power.h"
 
-extern int sysdev_suspend(pm_message_t state);
-
 /*
  * The entries in the dpm_active list are in a depth first order, simply
  * because children are guaranteed to be discovered after parents, and
--- linux-2.6.16-rc1-mm1-full/drivers/base/power/resume.c.old	2006-01-18 23:20:26.000000000 +0100
+++ linux-2.6.16-rc1-mm1-full/drivers/base/power/resume.c	2006-01-18 23:43:58.000000000 +0100
@@ -9,10 +9,9 @@
  */
 
 #include <linux/device.h>
+#include "../base.h"
 #include "power.h"
 
-extern int sysdev_resume(void);
-
 
 /**
  *	resume_device - Restore state for one device.

