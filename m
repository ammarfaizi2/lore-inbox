Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1947254AbWKKOak@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1947254AbWKKOak (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Nov 2006 09:30:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1947255AbWKKOak
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Nov 2006 09:30:40 -0500
Received: from sd291.sivit.org ([194.146.225.122]:5895 "EHLO sd291.sivit.org")
	by vger.kernel.org with ESMTP id S1947254AbWKKOaj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Nov 2006 09:30:39 -0500
Subject: [PATCH] appletouch improvements for MacBook
From: Stelian Pop <stelian@popies.net>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Jason Parekh <jasonparekh@gmail.com>
Content-Type: text/plain
Date: Sat, 11 Nov 2006 15:30:33 +0100
Message-Id: <1163255433.4884.32.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The attached patch, originally from Jason Parekh, changes a bit the
finger detection method used by the appletouch driver.

The patch doesn't seem to affect the Powerbooks but does greatly improve
the touchpad behaviour on the MacBooks (no more "jumpiness").

Quoting Jason, for the description of the patch:
- The detection method for multiple fingers.  Previously, it
recognizes a new finger when a low sensor is followed by a high
sensor.  I changed it so it checks for 'humps' in the sensor readings,
so there doesn't necessarily have to be a low sensor between two high
sensors for two fingers to be triggered (I personally leave my two
fingers touching each other when two-finger scrolling, so this became
an issue for me).

- The absolute coordinate function.  Previously, it incorporates new
sensors into the function once the sensor passes the threshold.
However, as soon as a sensor passes the threshold, its full value
(usually the threshold value since it just passed it) is included in
the calculation.  This caused there to be some jumps in the cursor
when moving the mouse around.  What I do instead if subtract the
threshold from each sensor when calculating the absolute position.
This allows my cursor to be extremely smooth since a newly high sensor
that gets included in the absolute position calculation will only have
a value of 1 instead of the threshold value.

- The threshold value.  The default value remains at 10, but it is a
module option now.

Signed-off-by: Jason Parekh <jasonparekh@gmail.com>
Signed-off-by: Stelian Pop <stelian@popies.net>

---

 appletouch.c |   49 ++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 44 insertions(+), 5 deletions(-)

diff -r ce04cd6b09e6 drivers/usb/input/appletouch.c
--- a/drivers/usb/input/appletouch.c	Sat Oct 21 20:58:23 2006 +0200
+++ b/drivers/usb/input/appletouch.c	Sat Oct 21 21:25:01 2006 +0200
@@ -154,6 +154,13 @@ MODULE_DESCRIPTION("Apple PowerBooks USB
 MODULE_DESCRIPTION("Apple PowerBooks USB touchpad driver");
 MODULE_LICENSE("GPL");
 
+/*
+ * Make the threshold a module parameter
+ */
+static int threshold = ATP_THRESHOLD;
+module_param(threshold, int, 0644);
+MODULE_PARM_DESC(threshold, "Discards any change in data from a sensor (trackpad has hundreds of these sensors) less than this value");
+
 static int debug = 1;
 module_param(debug, int, 0644);
 MODULE_PARM_DESC(debug, "Activate debugging output");
@@ -183,16 +190,48 @@ static int atp_calculate_abs(int *xy_sen
 	int i;
 	/* values to calculate mean */
 	int pcum = 0, psum = 0;
-
+	int is_increasing = 0;
+	
 	*fingers = 0;
 
 	for (i = 0; i < nb_sensors; i++) {
-		if (xy_sensors[i] < ATP_THRESHOLD)
+		if (xy_sensors[i] < threshold) {
+			if (is_increasing)
+				is_increasing = 0;
+			
 			continue;
-		if ((i - 1 < 0) || (xy_sensors[i - 1] < ATP_THRESHOLD))
+		}
+		
+		/*
+ 		 * Makes the finger detection more versatile.  For example,
+ 		 * two fingers with no gap will be detected.  Also, my
+ 		 * tests show it less likely to have intermittent loss
+ 		 * of multiple finger readings while moving around (scrolling).
+ 		 *
+ 		 * Changes the multiple finger detection to counting humps on
+ 		 * sensors (transitions from nonincreasing to increasing)
+ 		 * instead of counting transitions from low sensors (no
+ 		 * finger reading) to high sensors (finger above
+ 		 * sensor)
+ 		 * 
+ 		 * - Jason Parekh <jasonparekh@gmail.com>
+ 		 */
+		if ((i < 1) || (!is_increasing && (xy_sensors[i-1] < xy_sensors[i]))) {
 			(*fingers)++;
-		pcum += xy_sensors[i] * i;
-		psum += xy_sensors[i];
+			is_increasing = 1;
+		} else if ((i > 0) && (xy_sensors[i-1] >= xy_sensors[i])) {
+			is_increasing = 0;
+		}
+		
+		/* 
+		 * Subtracts threshold so a high sensor that just passes the threshold
+ 		 * won't skew the calculated absolute coordinate.  Fixes an issue
+ 		 * where slowly moving the mouse would occassionaly jump a number of
+ 		 * pixels (let me restate--slowly moving the mouse makes this issue
+ 		 * most apparent).
+ 		 */
+		pcum += (xy_sensors[i]-threshold) * i;
+		psum += (xy_sensors[i]-threshold);
 	}
 
 	if (psum > 0) {

-- 
Stelian Pop <stelian@popies.net>

