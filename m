Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262603AbVDAAZP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262603AbVDAAZP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Mar 2005 19:25:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262062AbVCaXev
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Mar 2005 18:34:51 -0500
Received: from mail.kroah.org ([69.55.234.183]:28384 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262073AbVCaXYG convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Mar 2005 18:24:06 -0500
Cc: R.Marek@sh.cvut.cz
Subject: [PATCH] I2C: busses documentation update 1 of 2
In-Reply-To: <1112311393634@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Thu, 31 Mar 2005 15:23:13 -0800
Message-Id: <1112311393548@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org, sensors@Stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.2340, 2005/03/31 14:29:46-08:00, R.Marek@sh.cvut.cz

[PATCH] I2C: busses documentation update 1 of 2

This patch just moves i2c-parport file to busses directory.
Patch for other busses documentation will follow.

Signed-off-by: Rudolf Marek <r.marek@sh.cvut.cz>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>


 Documentation/i2c/i2c-parport        |  156 -----------------------------------
 Documentation/i2c/busses/i2c-parport |  156 +++++++++++++++++++++++++++++++++++
 2 files changed, 156 insertions(+), 156 deletions(-)


diff -Nru a/Documentation/i2c/busses/i2c-parport b/Documentation/i2c/busses/i2c-parport
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/Documentation/i2c/busses/i2c-parport	2005-03-31 15:17:11 -08:00
@@ -0,0 +1,156 @@
+==================
+i2c-parport driver
+==================
+
+2004-07-06, Jean Delvare
+
+This is a unified driver for several i2c-over-parallel-port adapters,
+such as the ones made by Philips, Velleman or ELV. This driver is
+meant as a replacement for the older, individual drivers:
+ * i2c-philips-par
+ * i2c-elv
+ * i2c-velleman
+ * video/i2c-parport (NOT the same as this one, dedicated to home brew
+                      teletext adapters)
+
+It currently supports the following devices:
+ * Philips adapter
+ * home brew teletext adapter
+ * Velleman K8000 adapter
+ * ELV adapter
+ * Analog Devices evaluation boards (ADM1025, ADM1030, ADM1031, ADM1032)
+
+These devices use different pinout configurations, so you have to tell
+the driver what you have, using the type module parameter. There is no
+way to autodetect the devices. Support for different pinout configurations
+can be easily added when needed.
+
+
+Building your own adapter
+-------------------------
+
+If you want to build you own i2c-over-parallel-port adapter, here is
+a sample electronics schema (credits go to Sylvain Munaut):
+
+Device                                                      PC
+Side          ___________________Vdd (+)                    Side
+               |    |         |
+              ---  ---       ---
+              | |  | |       | |
+              |R|  |R|       |R|
+              | |  | |       | |
+              ---  ---       ---
+               |    |         |
+               |    |    /|   |
+SCL  ----------x--------o |-----------x-------------------  pin 2
+                    |    \|   |       |
+                    |         |       |
+                    |   |\    |       |
+SDA  ----------x----x---| o---x---------------------------  pin 13
+               |        |/            |
+               |                      |
+               |         /|           |
+               ---------o |----------------x--------------  pin 3
+                         \|           |    |
+                                      |    |
+                                     ---  ---
+                                     | |  | |
+                                     |R|  |R|
+                                     | |  | |
+                                     ---  ---
+                                      |    | 
+                                     ###  ###
+                                     GND  GND
+        
+Remarks:
+ - This is the exact pinout and electronics used on the Analog Devices
+   evaluation boards.
+                   /|
+ - All inverters -o |- must be 74HC05, they must be open collector output.
+                   \|
+ - All resitors are 10k.
+ - Pins 18-25 of the parallel port connected to GND.
+ - Pins 4-9 (D2-D7) could be used as VDD is the driver drives them high.
+   The ADM1032 evaluation board uses D4-D7. Beware that the amount of
+   current you can draw from the parallel port is limited. Also note that
+   all connected lines MUST BE driven at the same state, else you'll short
+   circuit the output buffers! So plugging the I2C adapter after loading
+   the i2c-parport module might be a good safety since data line state
+   prior to init may be unknown. 
+ - This is 5V!
+ - Obviously you cannot read SCL (so it's not really standard-compliant).
+   Pretty easy to add, just copy the SDA part and use another input pin.
+   That would give (ELV compatible pinout):
+
+
+Device                                                      PC
+Side          ______________________________Vdd (+)         Side
+               |    |            |    |
+              ---  ---          ---  ---
+              | |  | |          | |  | |
+              |R|  |R|          |R|  |R|
+              | |  | |          | |  | |
+              ---  ---          ---  ---
+               |    |            |    |
+               |    |      |\    |    |
+SCL  ----------x--------x--| o---x------------------------  pin 15
+                    |   |  |/         | 
+                    |   |             |
+                    |   |   /|        |
+                    |   ---o |-------------x--------------  pin 2
+                    |       \|        |    |
+                    |                 |    |
+                    |                 |    |
+                    |      |\         |    |
+SDA  ---------------x---x--| o--------x-------------------  pin 10
+                        |  |/              |
+                        |                  |
+                        |   /|             |
+                        ---o |------------------x---------  pin 3
+                            \|             |    |
+                                           |    |
+                                          ---  ---
+                                          | |  | |
+                                          |R|  |R|
+                                          | |  | |
+                                          ---  ---
+                                           |    | 
+                                          ###  ###
+                                          GND  GND
+
+
+If possible, you should use the same pinout configuration as existing
+adapters do, so you won't even have to change the code.
+
+
+Similar (but different) drivers
+-------------------------------
+
+This driver is NOT the same as the i2c-pport driver found in the i2c package.
+The i2c-pport driver makes use of modern parallel port features so that
+you don't need additional electronics. It has other restrictions however, and
+was not ported to Linux 2.6 (yet).
+
+This driver is also NOT the same as the i2c-pcf-epp driver found in the
+lm_sensors package. The i2c-pcf-epp driver doesn't use the parallel port
+as an I2C bus directly. Instead, it uses it to control an external I2C bus
+master. That driver was not ported to Linux 2.6 (yet) either.
+
+
+Legacy documentation for Velleman adapter
+-----------------------------------------
+
+Useful links:
+Velleman                http://www.velleman.be/
+Velleman K8000 Howto    http://howto.htlw16.ac.at/k8000-howto.html
+
+The project has lead to new libs for the Velleman K8000 and K8005:
+  LIBK8000 v1.99.1 and LIBK8005 v0.21
+With these libs, you can control the K8000 interface card and the K8005
+stepper motor card with the simple commands which are in the original
+Velleman software, like SetIOchannel, ReadADchannel, SendStepCCWFull and
+many more, using /dev/velleman.
+  http://home.wanadoo.nl/hihihi/libk8000.htm
+  http://home.wanadoo.nl/hihihi/libk8005.htm
+  http://struyve.mine.nu:8080/index.php?block=k8000
+  http://sourceforge.net/projects/libk8005/
diff -Nru a/Documentation/i2c/i2c-parport b/Documentation/i2c/i2c-parport
--- a/Documentation/i2c/i2c-parport	2005-03-31 15:17:11 -08:00
+++ /dev/null	Wed Dec 31 16:00:00 196900
@@ -1,156 +0,0 @@
-==================
-i2c-parport driver
-==================
-
-2004-07-06, Jean Delvare
-
-This is a unified driver for several i2c-over-parallel-port adapters,
-such as the ones made by Philips, Velleman or ELV. This driver is
-meant as a replacement for the older, individual drivers:
- * i2c-philips-par
- * i2c-elv
- * i2c-velleman
- * video/i2c-parport (NOT the same as this one, dedicated to home brew
-                      teletext adapters)
-
-It currently supports the following devices:
- * Philips adapter
- * home brew teletext adapter
- * Velleman K8000 adapter
- * ELV adapter
- * Analog Devices evaluation boards (ADM1025, ADM1030, ADM1031, ADM1032)
-
-These devices use different pinout configurations, so you have to tell
-the driver what you have, using the type module parameter. There is no
-way to autodetect the devices. Support for different pinout configurations
-can be easily added when needed.
-
-
-Building your own adapter
--------------------------
-
-If you want to build you own i2c-over-parallel-port adapter, here is
-a sample electronics schema (credits go to Sylvain Munaut):
-
-Device                                                      PC
-Side          ___________________Vdd (+)                    Side
-               |    |         |
-              ---  ---       ---
-              | |  | |       | |
-              |R|  |R|       |R|
-              | |  | |       | |
-              ---  ---       ---
-               |    |         |
-               |    |    /|   |
-SCL  ----------x--------o |-----------x-------------------  pin 2
-                    |    \|   |       |
-                    |         |       |
-                    |   |\    |       |
-SDA  ----------x----x---| o---x---------------------------  pin 13
-               |        |/            |
-               |                      |
-               |         /|           |
-               ---------o |----------------x--------------  pin 3
-                         \|           |    |
-                                      |    |
-                                     ---  ---
-                                     | |  | |
-                                     |R|  |R|
-                                     | |  | |
-                                     ---  ---
-                                      |    | 
-                                     ###  ###
-                                     GND  GND
-        
-Remarks:
- - This is the exact pinout and electronics used on the Analog Devices
-   evaluation boards.
-                   /|
- - All inverters -o |- must be 74HC05, they must be open collector output.
-                   \|
- - All resitors are 10k.
- - Pins 18-25 of the parallel port connected to GND.
- - Pins 4-9 (D2-D7) could be used as VDD is the driver drives them high.
-   The ADM1032 evaluation board uses D4-D7. Beware that the amount of
-   current you can draw from the parallel port is limited. Also note that
-   all connected lines MUST BE driven at the same state, else you'll short
-   circuit the output buffers! So plugging the I2C adapter after loading
-   the i2c-parport module might be a good safety since data line state
-   prior to init may be unknown. 
- - This is 5V!
- - Obviously you cannot read SCL (so it's not really standard-compliant).
-   Pretty easy to add, just copy the SDA part and use another input pin.
-   That would give (ELV compatible pinout):
-
-
-Device                                                      PC
-Side          ______________________________Vdd (+)         Side
-               |    |            |    |
-              ---  ---          ---  ---
-              | |  | |          | |  | |
-              |R|  |R|          |R|  |R|
-              | |  | |          | |  | |
-              ---  ---          ---  ---
-               |    |            |    |
-               |    |      |\    |    |
-SCL  ----------x--------x--| o---x------------------------  pin 15
-                    |   |  |/         | 
-                    |   |             |
-                    |   |   /|        |
-                    |   ---o |-------------x--------------  pin 2
-                    |       \|        |    |
-                    |                 |    |
-                    |                 |    |
-                    |      |\         |    |
-SDA  ---------------x---x--| o--------x-------------------  pin 10
-                        |  |/              |
-                        |                  |
-                        |   /|             |
-                        ---o |------------------x---------  pin 3
-                            \|             |    |
-                                           |    |
-                                          ---  ---
-                                          | |  | |
-                                          |R|  |R|
-                                          | |  | |
-                                          ---  ---
-                                           |    | 
-                                          ###  ###
-                                          GND  GND
-
-
-If possible, you should use the same pinout configuration as existing
-adapters do, so you won't even have to change the code.
-
-
-Similar (but different) drivers
--------------------------------
-
-This driver is NOT the same as the i2c-pport driver found in the i2c package.
-The i2c-pport driver makes use of modern parallel port features so that
-you don't need additional electronics. It has other restrictions however, and
-was not ported to Linux 2.6 (yet).
-
-This driver is also NOT the same as the i2c-pcf-epp driver found in the
-lm_sensors package. The i2c-pcf-epp driver doesn't use the parallel port
-as an I2C bus directly. Instead, it uses it to control an external I2C bus
-master. That driver was not ported to Linux 2.6 (yet) either.
-
-
-Legacy documentation for Velleman adapter
------------------------------------------
-
-Useful links:
-Velleman                http://www.velleman.be/
-Velleman K8000 Howto    http://howto.htlw16.ac.at/k8000-howto.html
-
-The project has lead to new libs for the Velleman K8000 and K8005:
-  LIBK8000 v1.99.1 and LIBK8005 v0.21
-With these libs, you can control the K8000 interface card and the K8005
-stepper motor card with the simple commands which are in the original
-Velleman software, like SetIOchannel, ReadADchannel, SendStepCCWFull and
-many more, using /dev/velleman.
-  http://home.wanadoo.nl/hihihi/libk8000.htm
-  http://home.wanadoo.nl/hihihi/libk8005.htm
-  http://struyve.mine.nu:8080/index.php?block=k8000
-  http://sourceforge.net/projects/libk8005/

