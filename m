Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265820AbUEZVn1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265820AbUEZVn1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 May 2004 17:43:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265822AbUEZVn1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 May 2004 17:43:27 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:42992 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S265820AbUEZVnW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 May 2004 17:43:22 -0400
Date: Wed, 26 May 2004 14:43:19 -0700
From: Todd Poynor <tpoynor@mvista.com>
To: greg@kroah.com, mochel@digitalimplant.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Leave runtime suspended devices off at system resume
Message-ID: <20040526214319.GB7176@slurryseal.ddns.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Currently all devices are resumed at system resume time, including any
that were individually powered off ("at runtime") prior to the system
suspend.  In certain cases it can be nice to force back on individually
suspended devices, such as the display, but hopefully this policy can be
left up to userspace power managers; the kernel should probably honor
the settings previously made by userspace/drivers.  This seems
preferable to requiring a power-conscious system to re-suspend devices
after a system resume; furthermore, for certain platforms (such as
XScale PXA27X) there can be disastrous consequences of powering up
devices when the system is in a state incompatible with operation of the
device.

Suggested patch does this:

(1) At system resume, checks power_state to see if the device was
suspended prior to system suspend, and skips powering on the device if
so.

(2) Does not re-suspend an already-suspended device at system suspend
(using a different method than is currently employed, which reorders the
list, see #3).

(3) Preserves the active/off device list order despite the above changes
to suspend/resume behavior, to avoid dependency problems that tend to
occur when the list is reordered.

--- linux-2.6.6-orig/drivers/base/power/suspend.c	2004-05-10 11:22:58.000000000 -0700
+++ linux-2.6.6-prevstate/drivers/base/power/suspend.c	2004-05-25 19:00:20.803379624 -0700
@@ -39,7 +39,7 @@
 {
 	int error = 0;
 
-	if (dev->bus && dev->bus->suspend)
+	if (dev->bus && dev->bus->suspend && ! dev->power.power_state)
 		error = dev->bus->suspend(dev,state);
 
 	if (!error) {
--- linux-2.6.6-orig/drivers/base/power/resume.c	2004-05-10 11:22:58.000000000 -0700
+++ linux-2.6.6-prevstate/drivers/base/power/resume.c	2004-05-25 18:07:30.978266288 -0700
@@ -35,7 +35,10 @@
 		struct list_head * entry = dpm_off.next;
 		struct device * dev = to_device(entry);
 		list_del_init(entry);
-		resume_device(dev);
+
+		if (! dev->power.power_state)
+			resume_device(dev);
+
 		list_add_tail(entry,&dpm_active);
 	}
 }



-- 
Todd
