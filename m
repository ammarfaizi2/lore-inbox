Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751593AbWIZFtE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751593AbWIZFtE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Sep 2006 01:49:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751132AbWIZFjO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Sep 2006 01:39:14 -0400
Received: from ns1.suse.de ([195.135.220.2]:55521 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751383AbWIZFjE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Sep 2006 01:39:04 -0400
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Cc: David Brownell <david-b@pacbell.net>,
       David Brownell <dbrownell@users.sourceforge.net>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 19/47] PM: update docs for writing .../power/state
Date: Mon, 25 Sep 2006 22:37:39 -0700
Message-Id: <11592491451786-git-send-email-greg@kroah.com>
X-Mailer: git-send-email 1.4.2.1
In-Reply-To: <1159249140339-git-send-email-greg@kroah.com>
References: <20060926053728.GA8970@kroah.com> <1159249087369-git-send-email-greg@kroah.com> <11592490903867-git-send-email-greg@kroah.com> <11592490933346-git-send-email-greg@kroah.com> <1159249096460-git-send-email-greg@kroah.com> <11592490993970-git-send-email-greg@kroah.com> <11592491023995-git-send-email-greg@kroah.com> <1159249104512-git-send-email-greg@kroah.com> <11592491082990-git-send-email-greg@kroah.com> <1159249111668-git-send-email-greg@kroah.com> <11592491152668-git-send-email-greg@kroah.com> <115924911859-git-send-email-greg@kroah.com> <11592491211162-git-send-email-greg@kroah.com> <1159249124371-git-send-email-greg@kroah.com> <11592491274168-git-send-email-greg@kroah.com> <11592491303012-git-send-email-greg@kroah.com> <11592491342421-git-send-email-greg@kroah.com> <11592491371254-git-send-email-greg@kroah.com> <1159249140339-git-send-email-greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Brownell <david-b@pacbell.net>

Updates to match current code:

 - Make writes to the /sys/devices/.../power/state files fail cleanly
   if the device requires the irqs-off call variants.

 - Fix comments describing the /sys/devices/.../power/state file writes
   to match the code; the last several releases have invalidated the
   previous text.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/base/power/sysfs.c |   29 +++++++++++++++++++----------
 1 files changed, 19 insertions(+), 10 deletions(-)

diff --git a/drivers/base/power/sysfs.c b/drivers/base/power/sysfs.c
index 40d7242..e55b3c2 100644
--- a/drivers/base/power/sysfs.c
+++ b/drivers/base/power/sysfs.c
@@ -11,18 +11,23 @@ #include "power.h"
  *	state - Control current power state of device
  *
  *	show() returns the current power state of the device. '0' indicates
- *	the device is on. Other values (1-3) indicate the device is in a low
+ *	the device is on. Other values (2) indicate the device is in some low
  *	power state.
  *
- *	store() sets the current power state, which is an integer value
- *	between 0-3. If the device is on ('0'), and the value written is
- *	greater than 0, then the device is placed directly into the low-power
- *	state (via its driver's ->suspend() method).
- *	If the device is currently in a low-power state, and the value is 0,
- *	the device is powered back on (via the ->resume() method).
- *	If the device is in a low-power state, and a different low-power state
- *	is requested, the device is first resumed, then suspended into the new
- *	low-power state.
+ *	store() sets the current power state, which is an integer valued
+ *	0, 2, or 3.  Devices with bus.suspend_late(), or bus.resume_early()
+ *	methods fail this operation; those methods couldn't be called.
+ *	Otherwise,
+ *
+ *	- If the recorded dev->power.power_state.event matches the
+ *	  target value, nothing is done.
+ *	- If the recorded event code is nonzero, the device is reactivated
+ *	  by calling bus.resume() and/or class.resume().
+ *	- If the target value is nonzero, the device is suspended by
+ *	  calling class.suspend() and/or bus.suspend() with event code
+ *	  PM_EVENT_SUSPEND.
+ *
+ *	This mechanism is DEPRECATED and should only be used for testing.
  */
 
 static ssize_t state_show(struct device * dev, struct device_attribute *attr, char * buf)
@@ -38,6 +43,10 @@ static ssize_t state_store(struct device
 	pm_message_t state;
 	int error = -EINVAL;
 
+	/* disallow incomplete suspend sequences */
+	if (dev->bus && (dev->bus->suspend_late || dev->bus->resume_early))
+		return error;
+
 	state.event = PM_EVENT_SUSPEND;
 	/* Older apps expected to write "3" here - confused with PCI D3 */
 	if ((n == 1) && !strcmp(buf, "3"))
-- 
1.4.2.1

