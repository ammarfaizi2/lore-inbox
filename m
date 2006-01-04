Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751812AbWADWCE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751812AbWADWCE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 17:02:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932261AbWADWBx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 17:01:53 -0500
Received: from a34-mta01.direcpc.com ([66.82.4.90]:13046 "EHLO
	a34-mta01.direcway.com") by vger.kernel.org with ESMTP
	id S932144AbWADWBc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 17:01:32 -0500
Date: Wed, 04 Jan 2006 17:01:10 -0500
From: Ben Collins <bcollins@ubuntu.com>
Subject: [PATCH 11/15] therm_adt746x: Quiet fan speed change messages
To: linux-kernel@vger.kernel.org
Message-id: <0ISL001UT96EWW@a34-mta01.direcway.com>
Content-transfer-encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Only output the messages about fan speed changes with a verbose=1 module
param.

Signed-off-by: Fabio M. Di Nitto <fabbione@ubuntu.com>
Signed-off-by: Ben Collins <bcollins@ubuntu.com>

---

 drivers/macintosh/therm_adt746x.c |   39 +++++++++++++++++++++++--------------
 1 files changed, 24 insertions(+), 15 deletions(-)

b0641454dfe898af0e6901ecd6eef349c5239e31
diff --git a/drivers/macintosh/therm_adt746x.c b/drivers/macintosh/therm_adt746x.c
index f386966..5e1f5e9 100644
--- a/drivers/macintosh/therm_adt746x.c
+++ b/drivers/macintosh/therm_adt746x.c
@@ -52,6 +52,7 @@ static char *sensor_location[3] = {NULL,
 
 static int limit_adjust = 0;
 static int fan_speed = -1;
+static int verbose = 0;
 
 MODULE_AUTHOR("Colin Leroy <colin@colino.net>");
 MODULE_DESCRIPTION("Driver for ADT746x thermostat in iBook G4 and "
@@ -66,6 +67,10 @@ module_param(fan_speed, int, 0644);
 MODULE_PARM_DESC(fan_speed,"Specify starting fan speed (0-255) "
 		 "(default 64)");
 
+module_param(verbose, bool, 0);
+MODULE_PARM_DESC(verbose,"Verbose log operations "
+		 "(default 0)");
+
 struct thermostat {
 	struct i2c_client	clt;
 	u8			temps[3];
@@ -149,13 +154,13 @@ detach_thermostat(struct i2c_adapter *ad
 	if (thread_therm != NULL) {
 		kthread_stop(thread_therm);
 	}
-		
+
 	printk(KERN_INFO "adt746x: Putting max temperatures back from "
 			 "%d, %d, %d to %d, %d, %d\n",
 		th->limits[0], th->limits[1], th->limits[2],
 		th->initial_limits[0], th->initial_limits[1],
 		th->initial_limits[2]);
-	
+
 	for (i = 0; i < 3; i++)
 		write_reg(th, LIMIT_REG[i], th->initial_limits[i]);
 
@@ -212,12 +217,14 @@ static void write_fan_speed(struct therm
 		return;
 	
 	if (th->last_speed[fan] != speed) {
-		if (speed == -1)
-			printk(KERN_DEBUG "adt746x: Setting speed to automatic "
-				"for %s fan.\n", sensor_location[fan+1]);
-		else
-			printk(KERN_DEBUG "adt746x: Setting speed to %d "
-				"for %s fan.\n", speed, sensor_location[fan+1]);
+		if (verbose) {
+			if (speed == -1)
+				printk(KERN_DEBUG "adt746x: Setting speed to automatic "
+					"for %s fan.\n", sensor_location[fan+1]);
+			else
+				printk(KERN_DEBUG "adt746x: Setting speed to %d "
+					"for %s fan.\n", speed, sensor_location[fan+1]);
+		}
 	} else
 		return;
 	
@@ -298,10 +305,11 @@ static void update_fans_speed (struct th
 			if (new_speed > 255)
 				new_speed = 255;
 
-			printk(KERN_DEBUG "adt746x: setting fans speed to %d "
-					 "(limit exceeded by %d on %s) \n",
-					new_speed, var,
-					sensor_location[fan_number+1]);
+			if (verbose)
+				printk(KERN_DEBUG "adt746x: Setting fans speed to %d "
+						 "(limit exceeded by %d on %s) \n",
+						new_speed, var,
+						sensor_location[fan_number+1]);
 			write_both_fan_speed(th, new_speed);
 			th->last_var[fan_number] = var;
 		} else if (var < -2) {
@@ -309,8 +317,9 @@ static void update_fans_speed (struct th
 			 * so cold (lastvar >= -1) */
 			if (i == 2 && lastvar < -1) {
 				if (th->last_speed[fan_number] != 0)
-					printk(KERN_DEBUG "adt746x: Stopping "
-						"fans.\n");
+					if (verbose)
+						printk(KERN_DEBUG "adt746x: Stopping "
+							"fans.\n");
 				write_both_fan_speed(th, 0);
 			}
 		}
@@ -406,7 +415,7 @@ static int attach_one_thermostat(struct 
 		th->initial_limits[i] = read_reg(th, LIMIT_REG[i]);
 		set_limit(th, i);
 	}
-	
+
 	printk(KERN_INFO "adt746x: Lowering max temperatures from %d, %d, %d"
 			 " to %d, %d, %d\n",
 			 th->initial_limits[0], th->initial_limits[1],
-- 
1.0.5
