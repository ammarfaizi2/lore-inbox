Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752025AbWCNI27@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752025AbWCNI27 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 03:28:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751887AbWCNI26
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 03:28:58 -0500
Received: from mraos.ra.phy.cam.ac.uk ([131.111.48.8]:52120 "EHLO
	mraos.ra.phy.cam.ac.uk") by vger.kernel.org with ESMTP
	id S1750740AbWCNI25 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 03:28:57 -0500
To: "Yu, Luming" <luming.yu@intel.com>
cc: linux-kernel@vger.kernel.org, "Linus Torvalds" <torvalds@osdl.org>,
       "Andrew Morton" <akpm@osdl.org>, "Tom Seeley" <redhat@tomseeley.co.uk>,
       "Dave Jones" <davej@redhat.com>, "Jiri Slaby" <jirislaby@gmail.com>,
       michael@mihu.de, mchehab@infradead.org,
       "Brian Marete" <bgmarete@gmail.com>,
       "Ryan Phillips" <rphillips@gentoo.org>, gregkh@suse.de,
       "Brown, Len" <len.brown@intel.com>, linux-acpi@vger.kernel.org,
       "Mark Lord" <lkml@rtr.ca>, "Randy Dunlap" <rdunlap@xenotime.net>,
       jgarzik@pobox.com, "Duncan" <1i5t5.duncan@cox.net>,
       "Pavlik Vojtech" <vojtech@suse.cz>, "Meelis Roos" <mroos@linux.ee>
Subject: Re: 2.6.16-rc5: known regressions [TP 600X S3, vanilla DSDT] 
In-Reply-To: Your message of "Tue, 14 Mar 2006 09:48:36 +0800."
             <3ACA40606221794F80A5670F0AF15F840B2DB6BF@pdsmsx403> 
Date: Tue, 14 Mar 2006 08:28:52 +0000
From: Sanjoy Mahajan <sanjoy@mrao.cam.ac.uk>
Message-Id: <E1FJ4tg-0002yw-00@skye.ra.phy.cam.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[I've trimmed non-relevant lists (v4l-dvb-maintainer@linuxtv.org,
video4linux-list@redhat.com, linux-ide@vger.kernel.org,
linux-input@atrey.karlin.mff.cuni.cz,
linux-usb-devel@lists.sourceforge.net) from the CC.  Let me know if
anyone else wants to be trimmed.]

> Could you do bisection to find out which methods or which thermal
> zone cause trouble?  To do that, you have to hack thermal.c by
> commenting out some calls of evaluating methods below.  I hope it is
> easy for you!  :-)

I eventually muddled my way there.  The short story is that I can
reproduce the hang -- on the FIRST S3 cycle -- when the _TMP method is
called a few times, just for THM0.  The boot loads 'thermal' as usual
and produces the usual list of method calls.  The following snippet
are the commented dmesgs after the boot and until the hang, produced
by:

  echo 100 > /proc/acpi/thermal_zone/THM0/polling_frequency
  modprobe -rv thermal
  modprobe thermal zone_to_keep=0 bisect_get_info=1
  sleep.sh

# from "echo 100 > /proc/acpi/thermal_zone/THM0/polling_frequency"
Execute Method: [\_TZ_.THM0._TMP] (Node c157bf88)

# "modprobe -rv thermal" produces no output

# the next msgs are due to
#   modprobe thermal zone_to_keep=0 bisect_get_info=1
# (see below for details on the two new debugging params)
# 'thermal' loads 'processor', which produces the next two lines:
ACPI: CPU0 (power states: C1[C1] C2[C2] C3[C3])
ACPI: Processor [CPU0] (supports 8 throttling states)

# now loading 'thermal' with the params above
ACPI: thermal_add: THM0
Execute Method: [\_TZ_.THM0._TMP] (Node c157bf88)

# the bisect_get_info parameter value says how far
# to go into acpi_thermal_get_info() before exiting.
ACPI: thermal_get_info: got temperature, but bisect_get_info = 1 so exiting

# next line is probably from the acpi_thermal_check(tz) in acpi_thermal_add()
Execute Method: [\_TZ_.THM0._TMP] (Node c157bf88)

# next line means THM0 is sorted out
ACPI: Thermal Zone [THM0] (42 C)

# the other zones are ignored (set by the zone_to_keep=0)
ACPI: thermal_add: THM2
ACPI: thermal_add: ignoring THM2
ACPI: thermal_add: THM6
ACPI: thermal_add: ignoring THM6
ACPI: thermal_add: THM7
ACPI: thermal_add: ignoring THM7
ACPI: thermal_add: _TZ
ACPI: thermal_add: ignoring _TZ

# now 'thermal' has loaded but only with THM0
# now for the first "sleep.sh", which unloads a few drivers etc.:
Unloaded prism54 driver
@@@@ SLEEP

# and it hangs!  Without the  
#    echo 100 > /proc/acpi/thermal_zone/THM0/polling_frequency
# at the beginning, a second cycle is required to reproduce the hang.
# That requirement makes debugging tricky because the wakeup runs a
# bunch of thermal methods, plus the serial console doesn't work right
# away, so several lines of dmesgs get lost.

I've included the diff for the thermal.c changes.  I added two module
parameters:

  zone_to_keep=N 
  bisect_get_info=N

where the zone_to_keep says which of THM{0,2,4,7} to load --
acpi_thermal_add() just returns -EINVAL when it's asked to load one of
the others.  So if zone_to_keep=8 for example, then no thermal zones
will be loaded.

Other data:

1. As a control experiment, I loaded thermal with zone_to_keep=8 (so
   no thermal zones loaded or methods called).  Then I could S3 cycle
   many many times and never noticed a problem.

2. If I loaded thermal with zone_to_keep=1 bisect_get_info=1 (so as in
   the dmesgs above but without the "echo 100 >
   THM0/polling_frequency"), then the second S3 sleep invariably would
   hang.  Compared to the the dmesgs above (which have no wake), these
   dmesgs had extra lines .  On wakeup, a bunch of the other THM0
   methods would be executed:

   Execute Method: [\_SI_._SST] (Node c157a8c8)
   Execute Method: [\_WAK] (Node c157aac8)
   Execute Method: [\_TZ_.THM0._PSV] (Node c157be48)
   Execute Method: [\_TZ_.THM0._TC1] (Node c157bdc8)
   Execute Method: [\_TZ_.THM0._TC2] (Node c157bd88)
   Execute Method: [\_TZ_.THM0._TSP] (Node c157bd48)
   Execute Method: [\_TZ_.THM0._AC0] (Node c157bf48)
   Execute Method: [\_TZ_.THM0._TMP] (Node c157bf88)
   Execute Method: [\_SI_._SST] (Node c157a8c8)

   even though I had set bisect_get_info=1 to prevent those methods
   from being run.  Eventually I realized that on wakeup they were
   probably being called by someone else calling acpi_thermal_check()
   and I should have been more clever in how I did the bisect.

   After this wakeup, the second sleep would hang as usual.

I suppose my next step will be to make acpi_thermal_get_temperature()
return (set by a third module param) before it evaluates the _TMP
method and see whether the hang remains.  But hopefully the data above
is already useful for analysis while I collect more data.

Here is the diff for thermal.c

--- thermal.c.orig	2006-03-14 01:01:05.000000000 -0500
+++ thermal.c	2006-03-14 01:16:58.000000000 -0500
@@ -76,10 +76,13 @@
 MODULE_DESCRIPTION(ACPI_THERMAL_DRIVER_NAME);
 MODULE_LICENSE("GPL");
 
-static int tzp;
+static int tzp, zone_to_keep = -1, bisect_get_info;
 module_param(tzp, int, 0);
+module_param(zone_to_keep, int, 0);
+module_param(bisect_get_info, int, 0);
 MODULE_PARM_DESC(tzp, "Thermal zone polling frequency, in 1/10 seconds.\n");
 
+
 static int acpi_thermal_add(struct acpi_device *device);
 static int acpi_thermal_remove(struct acpi_device *device, int type);
 static int acpi_thermal_state_open_fs(struct inode *inode, struct file *file);
@@ -1268,13 +1271,29 @@
 	if (result)
 		return_VALUE(result);
 
+	if (bisect_get_info == 1) {
+	  printk (KERN_INFO PREFIX "thermal_get_info: got temperature, but bisect_get_info = %d so exiting\n", bisect_get_info);
+	  return_VALUE(0);
+	}
+
 	/* Get trip points [_CRT, _PSV, etc.] (required) */
 	result = acpi_thermal_get_trip_points(tz);
 	if (result)
 		return_VALUE(result);
 
+	if (bisect_get_info == 2) {
+	  printk (KERN_INFO PREFIX "thermal_get_info: got trip points, but bisect_get_info = %d so exiting\n", bisect_get_info);
+	  return_VALUE(0);
+	}
+
 	/* Set the cooling mode [_SCP] to active cooling (default) */
 	result = acpi_thermal_set_cooling_mode(tz, ACPI_THERMAL_MODE_ACTIVE);
+
+	if (bisect_get_info == 3) {
+	  printk (KERN_INFO PREFIX "thermal_get_info: set active cooling, but bisect_get_info = %d so exiting with %d\n", bisect_get_info, result);
+	  return_VALUE(result);
+	}
+
 	if (!result)
 		tz->flags.cooling_mode = 1;
 	else {
@@ -1306,6 +1325,11 @@
 	else
 		acpi_thermal_get_polling_frequency(tz);
 
+	if (bisect_get_info == 4) {
+	  printk (KERN_INFO PREFIX "thermal_get_info: got default polling frequency, but bisect_get_info = %d so exiting\n", bisect_get_info);
+	  return_VALUE(0);
+	}
+
 	/* Get devices in this thermal zone [_TZD] (optional) */
 	result = acpi_thermal_get_devices(tz);
 	if (!result)
@@ -1319,12 +1343,25 @@
 	int result = 0;
 	acpi_status status = AE_OK;
 	struct acpi_thermal *tz = NULL;
+	char zone_to_keep_str[10];
 
 	ACPI_FUNCTION_TRACE("acpi_thermal_add");
 
 	if (!device)
 		return_VALUE(-EINVAL);
 
+	/* debugging bugzilla.kernel.org #5989 (second S3 sleep hangs) */
+	printk(KERN_INFO PREFIX "thermal_add: %s\n", device->pnp.bus_id);
+	if (zone_to_keep >= 0) {
+	  snprintf (zone_to_keep_str, sizeof(zone_to_keep_str),
+		    "THM%d", zone_to_keep);
+	  if (strcmp(zone_to_keep_str, device->pnp.bus_id) != 0) {
+	    printk(KERN_INFO PREFIX "thermal_add: ignoring %s\n",
+		   device->pnp.bus_id);
+	    return_VALUE(-EINVAL);
+	  }
+	}
+
 	tz = kmalloc(sizeof(struct acpi_thermal), GFP_KERNEL);
 	if (!tz)
 		return_VALUE(-ENOMEM);
