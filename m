Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264206AbUFEHxA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264206AbUFEHxA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Jun 2004 03:53:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263862AbUFEHxA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Jun 2004 03:53:00 -0400
Received: from smtp805.mail.sc5.yahoo.com ([66.163.168.184]:50087 "HELO
	smtp805.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S264551AbUFEHwr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Jun 2004 03:52:47 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 2.6] Mousedev - tapping support for touchpads in absolute mode (Synaptics)
Date: Sat, 5 Jun 2004 02:52:40 -0500
User-Agent: KMail/1.6.2
Cc: Andrew Morton <akpm@osdl.org>, Vojtech Pavlik <vojtech@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200406050252.45260.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The patch below implements tapping support for touchpads working in absolute
mode so Synaptics users do not need use psmouse.proto=imps to have tapping in
absence of native X driver/GPM support. The new kernel parameter
mousedev.tap_time=<msecs> controls the feature, use 0 to disable tapping.

The patch is on top of other mousedev patch I posted earlier.

-- 
Dmitry


===================================================================


ChangeSet@1.1829, 2004-06-05 02:10:49-05:00, dtor_core@ameritech.net
  Input: mousedev - implement tapping for touchpads working in absolute
         mode, such as Synaptics
  
  Signed-off-by: Dmitry Torokhov <dtor@mail.ru>


 Documentation/kernel-parameters.txt |    6 +++++
 drivers/input/mouse/Kconfig         |    2 -
 drivers/input/mousedev.c            |   38 +++++++++++++++++++++++++++++-------
 3 files changed, 37 insertions(+), 9 deletions(-)


===================================================================



diff -Nru a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
--- a/Documentation/kernel-parameters.txt	2004-06-05 02:12:15 -05:00
+++ b/Documentation/kernel-parameters.txt	2004-06-05 02:12:15 -05:00
@@ -654,6 +654,12 @@
 
 	mga=		[HW,DRM]
 
+	mousedev.tap_time=
+			[MOUSE] Maximum time between finger touching and
+			leaving touchpad surface for touch to be considered
+			a tap and be reported as a left button click (for
+			touchpads working in absolute mode only).
+			Format: <msecs>
 	mousedev.xres=	[MOUSE] Horizontal screen resolution, used for devices
 			reporting absolute coordinates, such as tablets
 	mousedev.yres=	[MOUSE] Vertical screen resolution, used for devices
diff -Nru a/drivers/input/mouse/Kconfig b/drivers/input/mouse/Kconfig
--- a/drivers/input/mouse/Kconfig	2004-06-05 02:12:15 -05:00
+++ b/drivers/input/mouse/Kconfig	2004-06-05 02:12:15 -05:00
@@ -30,8 +30,6 @@
 	  and a new verion of GPM at:
 		http://www.geocities.com/dt_or/gpm/gpm.html
 	  to take advantage of the advanced features of the touchpad.
-	  If you do not want install specialized drivers but want tapping
-	  working please use option psmouse.proto=imps.
 
 	  If unsure, say Y.
 
diff -Nru a/drivers/input/mousedev.c b/drivers/input/mousedev.c
--- a/drivers/input/mousedev.c	2004-06-05 02:12:15 -05:00
+++ b/drivers/input/mousedev.c	2004-06-05 02:12:15 -05:00
@@ -48,6 +48,10 @@
 module_param(yres, uint, 0);
 MODULE_PARM_DESC(yres, "Vertical screen resolution");
 
+static unsigned tap_time = 200;
+module_param(tap_time, uint, 0);
+MODULE_PARM_DESC(tap_time, "Tap time for touchpads in absolute mode (msecs)");
+
 struct mousedev_motion {
 	int dx, dy, dz;
 	unsigned long buttons;
@@ -65,7 +69,7 @@
 	struct mousedev_motion packet;
 	unsigned int pkt_count;
 	int old_x[4], old_y[4];
-	unsigned int touch;
+	unsigned long touch;
 };
 
 enum mousedev_emul {
@@ -216,6 +220,30 @@
 	wake_up_interruptible(&mousedev->wait);
 }
 
+static void mousedev_touchpad_touch(struct mousedev *mousedev, int value)
+{
+	if (!value) {
+		if (mousedev->touch &&
+		    !time_after(jiffies, mousedev->touch + msecs_to_jiffies(tap_time))) {
+			/*
+			 * Toggle left button to emulate tap.
+			 * We rely on the fact that mousedev_mix always has 0
+			 * motion packet so we won't mess current position.
+			 */
+			set_bit(0, &mousedev->packet.buttons);
+			set_bit(0, &mousedev_mix.packet.buttons);
+			mousedev_notify_readers(mousedev, &mousedev_mix.packet);
+			mousedev_notify_readers(&mousedev_mix, &mousedev_mix.packet);
+			clear_bit(0, &mousedev->packet.buttons);
+			clear_bit(0, &mousedev_mix.packet.buttons);
+		}
+		mousedev->touch = mousedev->pkt_count = 0;
+	}
+	else
+		if (!mousedev->touch)
+			mousedev->touch = jiffies;
+}
+
 static void mousedev_event(struct input_handle *handle, unsigned int type, unsigned int code, int value)
 {
 	struct mousedev *mousedev = handle->private;
@@ -239,12 +267,8 @@
 
 		case EV_KEY:
 			if (value != 2) {
-				if (code == BTN_TOUCH && test_bit(BTN_TOOL_FINGER, handle->dev->keybit)) {
-					/* Handle touchpad data */
-					mousedev->touch = value;
-					if (!mousedev->touch)
-						mousedev->pkt_count = 0;
-				}
+				if (code == BTN_TOUCH && test_bit(BTN_TOOL_FINGER, handle->dev->keybit))
+					mousedev_touchpad_touch(mousedev, value);
 				else
 					mousedev_key_event(mousedev, code, value);
 			}
