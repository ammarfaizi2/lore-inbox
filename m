Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265058AbTBCTwh>; Mon, 3 Feb 2003 14:52:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266991AbTBCTwh>; Mon, 3 Feb 2003 14:52:37 -0500
Received: from d12lmsgate-3.de.ibm.com ([194.196.100.236]:61897 "EHLO
	d12lmsgate-3.de.ibm.com") by vger.kernel.org with ESMTP
	id <S265058AbTBCTwf> convert rfc822-to-8bit; Mon, 3 Feb 2003 14:52:35 -0500
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Organization: IBM Deutschland GmbH, =?iso-8859-1?q?B=F6blingen?=
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: [PATCH] s390 fixes (4/12).
Date: Mon, 3 Feb 2003 20:46:16 +0100
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200302032046.16737.schwidefsky@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

minor changes to s390 documentation
diff -urN linux-2.5.59/Documentation/s390/driver-model.txt linux-2.5.59-s390/Documentation/s390/driver-model.txt
--- linux-2.5.59/Documentation/s390/driver-model.txt	Fri Jan 17 03:21:34 2003
+++ linux-2.5.59-s390/Documentation/s390/driver-model.txt	Mon Feb  3 20:49:27 2003
@@ -51,13 +51,10 @@
 
 This is done in several steps.
 
-a. Some drivers need several ccw devices to make up one device. This drivers
-   provide a 'chaining' interface (driver dependend) which allows to specify
-   which ccw devices form a device.
-b. Each driver provides one or more parameter interfaces where parameters can
+a. Each driver can provide one or more parameter interfaces where parameters can
    be specified. These interfaces are also in the driver's responsibility.
-c. After a. and b. have been performed, if neccessary, the device is finally
-   brought up via the 'online' interface.
+b. After a. has been performed, if neccessary, the device is finally brought up
+   via the 'online' interface.
 
 
 1.2 Writing a driver for ccw devices
@@ -84,7 +81,6 @@
 	struct ccw_device_id *ids;	
 	int (*probe) (struct ccw_device *); 
 	int (*remove) (struct ccw_device *);
-	void (*release) (struct ccw_driver *); 
 	int (*set_online) (struct ccw_device *);
 	int (*set_offline) (struct ccw_device *);
 	struct device_driver driver;
@@ -170,6 +166,22 @@
 information about the interrupt from the irb parameter.
 
 
+1.3 ccwgroup devices
+--------------------
+
+The ccwgroup mechanism is designed to handle devices consisting of multiple ccw
+devices, like lcs or ctc.
+
+The ccw driver provides a 'group' attribute. Piping bus ids of ccw devices to
+this attributes creates a ccwgroup device consisting of these ccw devices (if
+possible). This ccwgroup device can be set online or offline just like a normal
+ccw device.
+
+To implement a ccwgroup driver, please refer to include/asm/ccwgroup.h. Keep in
+mind that most drivers will need to implement both a ccwgroup and a ccw driver
+(unless you have a meta ccw driver, like cu3088 for lcs and ctc).
+
+
 2. System devices
 -----------------
 
@@ -189,19 +201,19 @@
 xpram shows up under sys/ as 'xpram'.
 
 
-3. 'Legacy' devices
--------------------
-
-The 'legacy' bus is for devices not detected, but specified by the user.
-
+3. Other devices
+----------------
 
 3.1 Netiucv
 -----------
 
-Netiucv connections show up under legacy/ as "netiucv<ifnum>". The interface
-number is assigned sequentially at module load.
-
-user			  - the user the connection goes to.
+The netiucv driver creates an attribute 'connection' under
+bus/iucv/drivers/NETIUCV. Piping to this attibute creates a new netiucv
+connection to the specified host.
+
+Netiucv connections show up under devices/iucv/ as "netiucv<ifnum>". The interface
+number is assigned sequentially to the connections defined via the 'connection'
+attribute. 'name' shows the connection partner.
 
 buffer			  - maximum buffer size.
 			    Pipe to it to change buffer size.

