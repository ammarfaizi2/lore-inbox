Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261875AbUE1V2y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261875AbUE1V2y (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 May 2004 17:28:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261865AbUE1V2p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 May 2004 17:28:45 -0400
Received: from mail.kroah.org ([65.200.24.183]:21421 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262062AbUE1V0p convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 May 2004 17:26:45 -0400
X-Donotread: and you are reading this why?
Subject: Re: [PATCH] Driver Core fixes for 2.6.7-rc1
In-Reply-To: <10857795552945@kroah.com>
X-Patch: quite boring stuff, it's just source code...
Date: Fri, 28 May 2004 14:25:55 -0700
Message-Id: <10857795552653@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1717.7.5, 2004/05/28 10:04:44-07:00, tpoynor@mvista.com

[PATCH] Leave runtime suspended devices off at system resume

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

Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/base/power/resume.c  |    5 ++++-
 drivers/base/power/suspend.c |    2 +-
 2 files changed, 5 insertions(+), 2 deletions(-)


diff -Nru a/drivers/base/power/resume.c b/drivers/base/power/resume.c
--- a/drivers/base/power/resume.c	Fri May 28 14:18:10 2004
+++ b/drivers/base/power/resume.c	Fri May 28 14:18:10 2004
@@ -35,7 +35,10 @@
 		struct list_head * entry = dpm_off.next;
 		struct device * dev = to_device(entry);
 		list_del_init(entry);
-		resume_device(dev);
+
+		if (!dev->power.power_state)
+			resume_device(dev);
+
 		list_add_tail(entry,&dpm_active);
 	}
 }
diff -Nru a/drivers/base/power/suspend.c b/drivers/base/power/suspend.c
--- a/drivers/base/power/suspend.c	Fri May 28 14:18:10 2004
+++ b/drivers/base/power/suspend.c	Fri May 28 14:18:10 2004
@@ -39,7 +39,7 @@
 {
 	int error = 0;
 
-	if (dev->bus && dev->bus->suspend)
+	if (dev->bus && dev->bus->suspend && !dev->power.power_state)
 		error = dev->bus->suspend(dev,state);
 
 	return error;

