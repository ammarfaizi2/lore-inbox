Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750712AbWBRCEk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750712AbWBRCEk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Feb 2006 21:04:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750727AbWBRCEJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Feb 2006 21:04:09 -0500
Received: from digitalimplant.org ([64.62.235.95]:4292 "HELO
	digitalimplant.org") by vger.kernel.org with SMTP id S1750712AbWBRCDt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Feb 2006 21:03:49 -0500
Date: Fri, 17 Feb 2006 18:03:40 -0800 (PST)
From: Patrick Mochel <mochel@digitalimplant.org>
X-X-Sender: mochel@monsoon.he.net
To: greg@kroah.com, "" <torvalds@osdl.org>, "" <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org, "" <linux-pm@osdl.org>
Subject: [PATCH 3/5] [pm] Respect the actual device power states in sysfs
 interface
Message-ID: <Pine.LNX.4.50.0602171758160.30811-100000@monsoon.he.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Fix the per-device state file to respect the actual state that
is reported by the device, or written to the file.

Using the struct pm_message::state field:

On read, report the actual state the device is in by looking at the
struct pm_message::state field (instead of just "0" or "2"). If the
device is suspended, but the state is "0", then report PM_STATE_OFF
(defined as INT_MAX).

On write, assume that the value passed in is the state that the
user wants the device to enter. Set the struct pm_message::state
field to that value.
- When (state != 0), assume a suspend request, and always set the
  event field to PM_EVENT_SUSPEND
- When (state == 0), assume a resume request.

[ Previously, only values "0", "2", and "3" were accepted, and the
actual value passed was silently dropped. ]

Update the comments so they match the functionality.

Signed-off-by: Patrick Mochel <mochel@linux.intel.com>

---

 drivers/base/power/sysfs.c |   66 ++++++++++++++++++++++++++------------------
 1 files changed, 39 insertions(+), 27 deletions(-)

applies-to: c5da8670faf610adc21e38c9d2da5330e9232a37
0f3eb786f769badd9044117c2976f829d66dec73
diff --git a/drivers/base/power/sysfs.c b/drivers/base/power/sysfs.c
index 40d7242..308baff 100644
--- a/drivers/base/power/sysfs.c
+++ b/drivers/base/power/sysfs.c
@@ -7,50 +7,62 @@
 #include "power.h"


+#define PM_STATE_OFF	INT_MAX
+
 /**
  *	state - Control current power state of device
  *
  *	show() returns the current power state of the device. '0' indicates
  *	the device is on. Other values (1-3) indicate the device is in a low
  *	power state.
- *
- *	store() sets the current power state, which is an integer value
- *	between 0-3. If the device is on ('0'), and the value written is
- *	greater than 0, then the device is placed directly into the low-power
- *	state (via its driver's ->suspend() method).
- *	If the device is currently in a low-power state, and the value is 0,
- *	the device is powered back on (via the ->resume() method).
- *	If the device is in a low-power state, and a different low-power state
- *	is requested, the device is first resumed, then suspended into the new
- *	low-power state.
+ *	A value of INT_MAX (0x0fffffff) indicates that the device is off - it is
+ *	suspended, but the actual state is unknown (for devices and buses that only
+ *	support "on" and "off").
+ *
+ *	store() takes an integer value and changes the current power state of the
+ *	device. If this value is 0, the device is resumed - a PM message with event
+ *	type PM_EVENT_ON, and a state of 0 is passed to dpm_runtime_resume().
+ *	Otherwise, the device is suspended. A PM message with event type
+ *	PM_EVENT_SUSPEND is passed to the device, with the state being the value
+ *	written to this file.
+ *
+ *	The meaning of the integer value states are bus and/or device specific, with
+ *	the exception of 0 - that always means "on".
+ *	The core will not do any further interpretation of the values. It is up to
+ *	the bus and/or device drivers to both document and check the values that are
+ *	read and written from this file.
+ *	For buses and devices that only support "on" and "off", any non-zero number
+ *	can be used to indicate "off".
  */

 static ssize_t state_show(struct device * dev, struct device_attribute *attr, char * buf)
 {
-	if (dev->power.power_state.event)
-		return sprintf(buf, "2\n");
-	else
-		return sprintf(buf, "0\n");
+	u32 state = 0;
+
+	if (dev->power.power_state.event == PM_EVENT_SUSPEND) {
+		state = dev->power.power_state.state;
+		if (!state)
+			state = PM_STATE_OFF;
+	}
+	return sprintf(buf, "%x\n", dev->power.power_state.state);
 }

 static ssize_t state_store(struct device * dev, struct device_attribute *attr, const char * buf, size_t n)
 {
-	pm_message_t state;
-	int error = -EINVAL;
+	pm_message_t msg = {
+		.event = PM_EVENT_SUSPEND,
+	};
+	char * rest;
+	int error = 0;

-	state.event = PM_EVENT_SUSPEND;
-	/* Older apps expected to write "3" here - confused with PCI D3 */
-	if ((n == 1) && !strcmp(buf, "3"))
-		error = dpm_runtime_suspend(dev, state);
-
-	if ((n == 1) && !strcmp(buf, "2"))
-		error = dpm_runtime_suspend(dev, state);
+	msg.state = simple_strtoul(buf, &rest, 0);
+	if (*rest)
+		return -EINVAL;

-	if ((n == 1) && !strcmp(buf, "0")) {
+	if (msg.state)
+		error = dpm_runtime_suspend(dev, msg);
+	else
 		dpm_runtime_resume(dev);
-		error = 0;
-	}
-
 	return error ? error : n;
 }

---
0.99.9.GIT
