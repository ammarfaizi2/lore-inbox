Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264238AbUHCIDM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264238AbUHCIDM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Aug 2004 04:03:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264512AbUHCIDM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Aug 2004 04:03:12 -0400
Received: from gate.crashing.org ([63.228.1.57]:27548 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S264238AbUHCIC6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Aug 2004 04:02:58 -0400
Subject: [PATCH] ppc64: Start the FCU in therm_pm72.c
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1091519944.7394.153.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 03 Aug 2004 17:59:04 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Some G5 recent powermacs start with the fan control unit (FCU) disabled,
by the firmware, causing the thermal control driver to break. We have to
enable it before starting the feedback loops that set the fan speeds. 
This patch adds the code to start the FCU.

Signed-off-by: Paul Mackerras <paulus@samba.org>
Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

diff -urN linux-2.5/drivers/macintosh/therm_pm72.c ppc64/drivers/macintosh/therm_pm72.c
--- linux-2.5/drivers/macintosh/therm_pm72.c	2004-05-20 08:06:38.000000000 +1000
+++ ppc64/drivers/macintosh/therm_pm72.c	2004-08-03 16:28:50.005908096 +1000
@@ -317,6 +317,20 @@
 	return nw;
 }
 
+static int start_fcu(void)
+{
+	unsigned char buf = 0xff;
+	int rc;
+
+	rc = fan_write_reg(0xe, &buf, 1);
+	if (rc < 0)
+		return -EIO;
+	rc = fan_write_reg(0x2e, &buf, 1);
+	if (rc < 0)
+		return -EIO;
+	return 0;
+}
+
 static int set_rpm_fan(int fan, int rpm)
 {
 	unsigned char buf[2];
@@ -1011,6 +1025,12 @@
 
 	down(&driver_lock);
 
+	if (start_fcu() < 0) {
+		printk(KERN_ERR "kfand: failed to start FCU\n");
+		up(&driver_lock);
+		goto out;
+	}
+
 	/* Set the PCI fan once for now */
 	set_pwm_fan(SLOTS_FAN_PWM_ID, SLOTS_FAN_DEFAULT_PWM);
 
@@ -1057,6 +1077,7 @@
 			schedule_timeout(HZ - elapsed);
 	}
 
+ out:
 	DBG("main_control_loop ended\n");
 
 	ctrl_task = 0;
-- 
Benjamin Herrenschmidt <benh@kernel.crashing.org>

