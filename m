Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932755AbWCVV0P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932755AbWCVV0P (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 16:26:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932756AbWCVV0P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 16:26:15 -0500
Received: from zombie.ncsc.mil ([144.51.88.131]:47013 "EHLO jazzdrum.ncsc.mil")
	by vger.kernel.org with ESMTP id S932755AbWCVV0P (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 16:26:15 -0500
Subject: [PATCH] driver core: driver_bind attribute returns incorrect value
From: Ryan <hap9@epoch.ncsc.mil>
To: gregkh@suse.de
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Wed, 22 Mar 2006 16:26:25 -0500
Message-Id: <1143062785.22254.15.camel@moss-tarheels.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The manual driver <-> device binding attribute in sysfs doesn't return
the correct value on failure or success of driver_probe_device.
driver_probe_device returns 1 on success (the driver accepted the
device) or 0 on probe failure (when the driver didn't accept the
device but no real error occured). However, the attribute can't just
return 0 or 1, it must return the number of bytes consumed from buf
or an error value. Returning 0 indicates to userspace that nothing
was written (even though the kernel has tried to do the bind/probe and
failed). Returning 1 indicates that only one character was accepted in
which case userspace will re-try the write with a partial string.

A more correct version of driver_bind would return count (to indicate
the entire string was consumed) when driver_probe_device returns 1
and -ENODEV when driver_probe_device returns 0. This patch makes that
change.

Signed-off-by: Ryan Wilson <hap9@epoch.ncsc.mil>

---

 drivers/base/bus.c |    5 +++++
 1 files changed, 5 insertions(+)

--- linux-2.6.16-rc5/drivers/base/bus.c	2006-03-16 10:50:20.000000000 -0500
+++ linux-2.6.16-rc5/drivers/base/bus.c	2006-03-16 11:02:08.000000000 -0500
@@ -188,6 +188,11 @@ static ssize_t driver_bind(struct device
 		up(&dev->sem);
 		if (dev->parent)
 			up(&dev->parent->sem);
+
+		if (err > 0) 		/* success */
+			err = count;
+		else if (err == 0)	/* driver didn't accept device */
+			err = -ENODEV;
 	}
 	put_device(dev);
 	put_bus(bus);


