Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932589AbWHFHde@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932589AbWHFHde (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Aug 2006 03:33:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932543AbWHFHd1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Aug 2006 03:33:27 -0400
Received: from mx-outbound.sourceforge.net ([66.35.250.223]:26789 "EHLO
	sc8-sf-sshgate.sourceforge.net") by vger.kernel.org with ESMTP
	id S932532AbWHFHcz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Aug 2006 03:32:55 -0400
From: Shem Multinymous <multinymous@gmail.com>
To: Robert Love <rlove@rlove.org>
Cc: Jean Delvare <khali@linux-fr.org>, Greg Kroah-Hartman <gregkh@suse.de>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
       hdaps-devel@lists.sourceforge.net
Subject: [PATCH 07/12] hdaps: delay calibration to first hardware query
Reply-To: Shem Multinymous <multinymous@gmail.com>
Date: Sun, 06 Aug 2006 10:26:52 +0300
Message-Id: <11548492753662-git-send-email-multinymous@gmail.com>
X-Mailer: git-send-email 1.4.1
In-Reply-To: <11548492171301-git-send-email-multinymous@gmail.com>
References: <11548492171301-git-send-email-multinymous@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The hdaps driver currently calibrates its rest position upon
initialization, which can take several seconds on first module load
(and delays the boot process accordingly). This patch delays 
calibration to the first successful hardware query, when the
information is available anyway. Writes to the "calibrate" sysfs
attribute are handled likewise.

Signed-off-by: Shem Multinymous <multinymous@gmail.com>
---
 hdaps.c |   14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff -up a/drivers/hwmon/hdaps.c a/drivers/hwmon/hdaps.c
--- a/drivers/hwmon/hdaps.c
+++ a/drivers/hwmon/hdaps.c
@@ -66,6 +66,7 @@ static struct timer_list hdaps_timer;
 static struct platform_device *pdev;
 static struct input_dev *hdaps_idev;
 static unsigned int hdaps_invert;
+static int needs_calibration = 0;
 
 /* Latest state readout: */
 static int pos_x, pos_y;      /* position */
@@ -125,6 +126,11 @@ static int __hdaps_update(int fast)
 	temperature = data.val[EC_ACCEL_IDX_TEMP1];
 
 	stale_readout = 0;
+	if (needs_calibration) {
+		rest_x = pos_x;
+		rest_y = pos_y;
+		needs_calibration = 0;
+	}
 
 	return 0;
 }
@@ -270,9 +276,9 @@ static struct platform_driver hdaps_driv
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
@@ -502,8 +508,8 @@ static int __init hdaps_init(void)
 		goto out_group;
 	}
 
-	/* initial calibrate for the input device */
-	hdaps_calibrate();
+	/* calibration for the input device (deferred to avoid delay) */
+	needs_calibration = 1;
 
 	/* initialize the input class */
 	hdaps_idev->name = "hdaps";
