Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261422AbVAGOGo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261422AbVAGOGo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 09:06:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261310AbVAGOGn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 09:06:43 -0500
Received: from [212.20.225.142] ([212.20.225.142]:4415 "EHLO
	orlando.wolfsonmicro.main") by vger.kernel.org with ESMTP
	id S261424AbVAGODE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 09:03:04 -0500
Subject: [PATCH 4/5] WM97xx touch driver AC97 plugin
From: Liam Girdwood <Liam.Girdwood@wolfsonmicro.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: lkml <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="=-8OZTdff8UnnnQ3BR6yJu"
Message-Id: <1105106583.9143.1007.camel@cearnarfon>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Fri, 07 Jan 2005 14:03:04 +0000
X-OriginalArrivalTime: 07 Jan 2005 14:03:03.0983 (UTC) FILETIME=[9B0443F0:01C4F4C1]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-8OZTdff8UnnnQ3BR6yJu
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

This patch contains documentation about the wm97xx plugin's module
parameters.

Signed-off-by: Liam Girdwood <liam.girdwood@wolfsonmicro.com>



--=-8OZTdff8UnnnQ3BR6yJu
Content-Disposition: attachment; filename=wm97xx-docs.diff
Content-Type: text/x-patch; name=wm97xx-docs.diff; charset=
Content-Transfer-Encoding: 7bit

--- a/Documentation/input/wm97xx.txt	2005-01-06 14:46:15.000000000 +0000
+++ b/Documentation/input/wm97xx.txt	2005-01-06 14:44:11.000000000 +0000
@@ -0,0 +1,178 @@
+
+Wolfson Microelectronics WM9705, WM9712 ane WM9713 Touchscreen Controllers
+==========================================================================
+
+The WM9705, WM9712 and WM9713 are high performance AC97 audio codecs with built
+in touchscreen controllers that are mainly found in portable devices.
+i.e. Dell Axim and Toshiba e740. 
+
+This driver uses the AC97 link controller for all communication with the 
+codec and can be either built into the kernel or built as a module. 
+
+Build Instructions
+==================
+
+The driver will be built into the kernel if "sound card support" = y and
+"wolfson AC97 touchscreen support" = y in the kernel sound configuration.
+
+To build as a module, "wolfson AC97 touchscreen support" = m
+in the kernel sound configuration.
+
+
+Driver Features
+===============
+
+ * supports WM9705, WM9712, WM9713
+ * polling mode
+ * coordinate polling
+ * adjustable rpu/dpp settings
+ * adjustable pressure current
+ * adjustable sample settle delay
+ * 4 and 5 wire touchscreens (5 wire is WM9712 only)
+ * pen down detection
+ * power management
+ * AUX ADC sampling
+ * codec GPIO
+ * continuous sampling (arch specific)
+
+
+Driver Usage
+============
+
+The touch driver uses the kernel input layer for communication with userspace.
+e.g. /dev/input/event
+
+Driver Parameters
+=================
+The driver can accept several parameters for fine tuning the touchscreen. 
+However, the syntax is different between module options and passing the 
+options in the kernel command line.
+
+e.g.
+
+rpu=1   (module)
+rpu:1   (kernel command line)
+
+
+1. Codec sample mode. (mode)
+ 
+   The driver can sample touchscreen data in 3 different operating
+   modes. i.e. polling, coordinate and continous.
+  
+   Polling:-     The driver polls the codec and issues 3 seperate commands
+                 over the AC97 link to read X,Y and pressure.
+   
+   Coordinate: - The driver polls the codec and only issues 1 command over
+                 the AC97 link to read X,Y and pressure. This mode has
+                 strict timing requirements and may drop samples if 
+                 interrupted. However, it is less demanding on the AC97
+                 link. Note: this mode requires a larger delay than polling
+                 mode.
+  
+   Continuous:-  The codec automatically samples X,Y and pressure and then
+                 sends the data over the AC97 link in slots. This is then
+                 same method used by the codec when recording audio. This
+                 mode is tighly coupled to the underlying hardware and requires
+                 an additional arch specific driver to be loaded.
+                 e.g. pxa-wm97xx-touch
+ 
+   Set mode = 0 for polling, 1 for coordinate. Continuous is selected automagically
+   by loading the continuous driver.
+             
+   Default mode = 0
+   
+   
+
+2. WM9712, WM9713 Internal pull up for pen detect. (rpu) 
+  
+   Pull up is in the range 1.02k (least sensitive) to 64k (most sensitive)
+   i.e. pull up resistance = 64k Ohms / rpu.
+   
+   Adjust this value if you are having problems with pen detect not 
+   detecting any down events.
+   
+   Set rpu = value
+
+   Default rpu = 1
+   
+   
+
+3. WM9705 Pen detect comparator threshold. (pdd) 
+   
+   0 to Vmid in 15 steps, 0 = use zero power comparator with Vmid threshold
+   i.e. 1 =  Vmid/15 threshold
+        15 =  Vmid/1 threshold
+   
+   Adjust this value if you are having problems with pen detect not 
+   detecting any down events.
+   
+   Set pdd = value
+
+   Default pdd = 0
+
+
+ 
+4. Set current used for pressure measurement. (pil)
+ 
+   Set pil = 2 to use 400uA 
+       pil = 1 to use 200uA and
+       pil = 0 to disable pressure measurement.
+  
+   This is used to increase the range of values returned by the adc
+   when measureing touchpanel pressure. 
+   
+   Default pil = 0
+  
+
+
+5. WM9712 Set 5 wire touchscreen mode. (five_wire)
+
+   Set five_wire = 1 to enable 5 wire mode on the WM9712.
+   
+   Default five_wire = 0
+   
+   NOTE: Five wire mode does not allow for readback of pressure.
+
+
+
+6. ADC sample delay. (delay)
+  
+   For accurate touchpanel measurements, some settling time may be
+   required between the switch matrix applying a voltage across the
+   touchpanel plate and the ADC sampling the signal.
+  
+   This delay can be set by setting delay = n, where n is the array
+   position of the delay in the array delay_table below.
+   Long delays > 1ms are supported for completeness, but are not
+   recommended.
+   
+   Default delay = 4
+ 
+    wm_delay     uS     AC97 link frames
+    ====================================
+       0	      21          1
+       1	      42          2
+       2          84          4
+       3         167          8
+       4         333         16
+       5         667         32
+       6        1000         48
+       7        1333         64
+       8        2000         96
+       9        2667        128
+      10        3333        160
+      11        4000        192
+      12        4667        224
+      13        5333        256
+      14        6000        288
+      15           0          0 (No delay, switch matrix always on)
+
+
+
+Contact
+=======
+
+Further information about the WM9705, WM9712 and WM9713 can be found on the 
+Wolfson Website. http://www.wolfsonmicro.com
+
+Please report bugs/issues/etc to liam.girdwood@wolfsonmicro.com

--=-8OZTdff8UnnnQ3BR6yJu--

