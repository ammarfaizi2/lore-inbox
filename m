Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161132AbWHJJ4H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161132AbWHJJ4H (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 05:56:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161140AbWHJJyi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 05:54:38 -0400
Received: from mx-outbound.sourceforge.net ([66.35.250.223]:3740 "EHLO
	sc8-sf-sshgate.sourceforge.net") by vger.kernel.org with ESMTP
	id S1161138AbWHJJyg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 05:54:36 -0400
From: Shem Multinymous <multinymous@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Robert Love <rlove@rlove.org>, Pavel Machek <pavel@suse.cz>,
       Jean Delvare <khali@linux-fr.org>, Greg Kroah-Hartman <gregkh@suse.de>,
       Andrew Morton <akpm@osdl.org>, hdaps-devel@lists.sourceforge.net
Subject: [PATCH 07/12] hdaps: delay calibration to first hardware query
Reply-To: Shem Multinymous <multinymous@gmail.com>
Date: Thu, 10 Aug 2006 12:48:45 +0300
Message-Id: <11552033783354-git-send-email-multinymous@gmail.com>
X-Mailer: git-send-email 1.4.1
In-Reply-To: <1155203330179-git-send-email-multinymous@gmail.com>
References: <1155203330179-git-send-email-multinymous@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The hdaps driver currently calibrates its rest position upon
initialization, which can take several seconds on first module load
(and delays the boot process accordingly). This patch delays 
calibration to the first successful hardware query, when the
information is available anyway. Writes to the "calibrate" sysfs
attribute are handled likewise.

Signed-off-by: Shem Multinymous <multinymous@gmail.com>
Signed-off-by: Pavel Machek <pavel@suse.cz>
---
 drivers/hwmon/hdaps.c |   15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

--- a/drivers/hwmon/hdaps.c
+++ b/drivers/hwmon/hdaps.c
@@ -66,6 +66,7 @@ static struct timer_list hdaps_timer;
 static struct platform_device *pdev;
 static struct input_dev *hdaps_idev;
 static unsigned int hdaps_invert;
+static int needs_calibration;
 
 /* Latest state readout: */
 static int pos_x, pos_y;      /* position */
@@ -137,6 +138,12 @@ static int __hdaps_update(int fast)
 	temperature = data.val[EC_ACCEL_IDX_TEMP1];
 
 	stale_readout = 0;
+	if (needs_calibration) {
+		rest_x = pos_x;
+		rest_y = pos_y;
+		needs_calibration = 0;
+	}
+
 	return 0;
 }
 
@@ -288,9 +295,9 @@ static struct platform_driver hdaps_driv
  */
 static void hdaps_calibrate(void)
 {
+	needs_calibration = 1;
 	hdaps_update();
-	rest_x = pos_x;
-	rest_y = pos_y;
+	/* If that fails, the mousedev poll will take care of things later. */
 }
 
 /* Timer handler for updating the input device. Runs in softirq context,
@@ -520,8 +527,8 @@ static int __init hdaps_init(void)
 		goto out_group;
 	}
 
-	/* initial calibrate for the input device */
-	hdaps_calibrate();
+	/* calibration for the input device (deferred to avoid delay) */
+	needs_calibration = 1;
 
 	/* initialize the input class */
 	hdaps_idev->name = "hdaps";
