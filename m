Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261447AbTIKR1k (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Sep 2003 13:27:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261411AbTIKRYW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Sep 2003 13:24:22 -0400
Received: from d12lmsgate.de.ibm.com ([194.196.100.234]:43696 "EHLO
	d12lmsgate.de.ibm.com") by vger.kernel.org with ESMTP
	id S261445AbTIKRTL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Sep 2003 13:19:11 -0400
Date: Thu, 11 Sep 2003 19:18:29 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] s390 (7/7): docu.
Message-ID: <20030911171829.GH5637@mschwid3.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

s/390 documentation update.

diffstat:
 Documentation/s390/CommonIO         |   46 ++----------------------------------
 Documentation/s390/driver-model.txt |   21 ++++++++++------
 2 files changed, 16 insertions(+), 51 deletions(-)

diff -urN linux-2.6/Documentation/s390/CommonIO linux-2.6-s390/Documentation/s390/CommonIO
--- linux-2.6/Documentation/s390/CommonIO	Mon Sep  8 21:50:32 2003
+++ linux-2.6-s390/Documentation/s390/CommonIO	Thu Sep 11 19:21:28 2003
@@ -45,25 +45,6 @@
 /proc entries
 -------------
 
-* /proc/subchannels
-
-  This entry shows information on a per-subchannel basis.
-
-  The data is ordered in the following way:
-
-  - device number 
-  - subchannel number 
-  - device type/model (if applicable; if not, this is empty) and control unit 
-    type/model
-  - whether the device is in use (i. e. a device driver has requested ownership 
-    and registered an interrupt handler)
-  - path installed mask (PIM), as reflected by last store subchannel
-  - path available mask (PAM), as reflected by last store subchannel
-  - path operational mask (POM), as reflected by last store subchannel
-  - the channel path IDs (CHPIDs)
-
-  All fields are separated by spaces, the chpids are in blocks of four chpids.
-
 * /proc/cio_ignore
 
   Lists the ranges of device numbers which are ignored by common I/O.
@@ -116,27 +97,6 @@
   /proc/s390dbf/cio_*/level a number between 0 and 6; see the documentation on
   the S/390 debug feature (Documentation/s390/s390dbf.txt) for details.
 
-* /proc/irq_count
-
-  This entry counts how many times s390_process_IRQ has been called for each 
-  CPU. This info is in /proc/interrupts on other architectures.
-
-* /proc/chpids
-
-  This entry serves a dual purpose:
- 
-  - show which chpids are currently known to Linux and their status (online,
-    logically offline),
-
-  - toggling known chpids logically online/offline.
-
-  To toggle a known chpid logically offline, do an
-	echo off <chpid> > /proc/chpids
-  <chpid> is interpreted as hex, even if you omit the '0x'.
-  The chpid will be treated by Linux as if it were not online, which can mean 
-  some devices will become unavailable.
-
-  You can toggle a logically offline chpid online again by
-	echo on <chpid> > /proc/chpids
-  If devices became unavailable by toggling the chpid logically offline, they 
-  will become available again after you toggle the chpid online again.
+* For some of the information present in the /proc filesystem in 2.4 (namely,
+  /proc/subchannels and /proc/chpids), see driver-model.txt.
+  Information formerly in /proc/irq_count is now in /proc/interrupts.
diff -urN linux-2.6/Documentation/s390/driver-model.txt linux-2.6-s390/Documentation/s390/driver-model.txt
--- linux-2.6/Documentation/s390/driver-model.txt	Mon Sep  8 21:49:51 2003
+++ linux-2.6-s390/Documentation/s390/driver-model.txt	Thu Sep 11 19:21:28 2003
@@ -14,19 +14,18 @@
      - sys
      - legacy
      - css0/
-           - 0:0000/0:0815/
-	   - 0:0001/0:4711/
-	   - 0:0002/
+           - 0.0.0000/0.0.0815/
+	   - 0.0.0001/0.0.4711/
+	   - 0.0.0002/
 	   ...
 
 In this example, device 0815 is accessed via subchannel 0, device 4711 via 
 subchannel 1, and subchannel 2 is a non-I/O subchannel.
 
-You should address a ccw device via its bus id (e.g. 0:4711); the device can
+You should address a ccw device via its bus id (e.g. 0.0.4711); the device can
 be found under bus/ccw/devices/.
 
-All ccw devices export some data via sysfs additional to the standard 'name'
-and 'power' entries.
+All ccw devices export some data via sysfs.
 
 cutype:	    The control unit type / model.
 
@@ -177,6 +176,10 @@
 possible). This ccwgroup device can be set online or offline just like a normal
 ccw device.
 
+Each ccwgroup device also provides an 'ungroup' attribute to destroy the device
+again (only when offline). This is a generic ccwgroup mechanism (the driver does
+not need to implement anything beyond normal removal routines).
+
 To implement a ccwgroup driver, please refer to include/asm/ccwgroup.h. Keep in
 mind that most drivers will need to implement both a ccwgroup and a ccw driver
 (unless you have a meta ccw driver, like cu3088 for lcs and ctc).
@@ -186,7 +189,7 @@
 -----------------
 
 Channel paths show up, like subchannels, under the channel subsystem root (css0)
-and are called 'chp<chpid>'. They have no driver and do not belong to any bus.
+and are called 'chp0.<chpid>'. They have no driver and do not belong to any bus.
 
 status - Can be 'online', 'logically offline' or 'n/a'.
 	 Piping 'on' or 'off' sets the chpid logically online/offline.
@@ -215,7 +218,9 @@
 
 Netiucv connections show up under devices/iucv/ as "netiucv<ifnum>". The interface
 number is assigned sequentially to the connections defined via the 'connection'
-attribute. 'name' shows the connection partner.
+attribute.
+
+user			  - shows the connection partner.
 
 buffer			  - maximum buffer size.
 			    Pipe to it to change buffer size.
