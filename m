Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262821AbVFVFhs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262821AbVFVFhs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 01:37:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262747AbVFVFdv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 01:33:51 -0400
Received: from mail.kroah.org ([69.55.234.183]:39831 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262754AbVFVFMS convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 01:12:18 -0400
Cc: johnpol@2ka.mipt.ru
Subject: [PATCH] w1: Updates the w1 documentation (w1.generic)
In-Reply-To: <11194171272630@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Tue, 21 Jun 2005 22:12:08 -0700
Message-Id: <11194171281158@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org, sensors@Stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] w1: Updates the w1 documentation (w1.generic)

Updates the w1 documentation (w1.generic)

Signed-off-by: Ben Gardner <bgardner@wabtec.com>
Signed-off-by: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit 4754639d88e922af451b399af09ac1bb442c35e5
tree 6dbac4533761e2fa31f2eebc3193dbfff98e0497
parent 99c5bfe993af1af37ddd615e72207dc7220dc526
author Evgeniy Polyakov <johnpol@2ka.mipt.ru> Sat, 04 Jun 2005 01:31:47 +0400
committer Greg Kroah-Hartman <gregkh@suse.de> Tue, 21 Jun 2005 21:43:12 -0700

 Documentation/w1/w1.generic |  107 ++++++++++++++++++++++++++++++++++++-------
 1 files changed, 90 insertions(+), 17 deletions(-)

diff --git a/Documentation/w1/w1.generic b/Documentation/w1/w1.generic
--- a/Documentation/w1/w1.generic
+++ b/Documentation/w1/w1.generic
@@ -1,19 +1,92 @@
-Any w1 device must be connected to w1 bus master device - for example
-ds9490 usb device or w1-over-GPIO or RS232 converter.
-Driver for w1 bus master must provide several functions(you can find
-them in struct w1_bus_master definition in w1.h) which then will be
-called by w1 core to send various commands over w1 bus(by default it is
-reset and search commands). When some device is found on the bus, w1 core
-checks if driver for it's family is loaded.
-If driver is loaded w1 core creates new w1_slave object and registers it
-in the system(creates some generic sysfs files(struct w1_family_ops in
-w1_family.h), notifies any registered listener and so on...).
-It is device driver's business to provide any communication method
-upstream.
-For example w1_therm driver(ds18?20 thermal sensor family driver)
-provides temperature reading function which is bound to ->rbin() method
-of the above w1_family_ops structure.
-w1_smem - driver for simple 64bit memory cell provides ID reading
-method.
+The 1-wire (w1) subsystem
+------------------------------------------------------------------
+The 1-wire bus is a simple master-slave bus that communicates via a single
+signal wire (plus ground, so two wires).
+
+Devices communicate on the bus by pulling the signal to ground via an open
+drain output and by sampling the logic level of the signal line.
+
+The w1 subsystem provides the framework for managing w1 masters and
+communication with slaves.
+
+All w1 slave devices must be connected to a w1 bus master device.
+
+Example w1 master devices:
+    DS9490 usb device
+    W1-over-GPIO
+    DS2482 (i2c to w1 bridge)
+    Emulated devices, such as a RS232 converter, parallel port adapter, etc
+
+
+What does the w1 subsystem do?
+------------------------------------------------------------------
+When a w1 master driver registers with the w1 subsystem, the following occurs:
+
+ - sysfs entries for that w1 master are created
+ - the w1 bus is periodically searched for new slave devices
+
+When a device is found on the bus, w1 core checks if driver for it's family is
+loaded. If so, the family driver is attached to the slave.
+If there is no driver for the family, a simple sysfs entry is created
+for the slave device.
+
+
+W1 device families
+------------------------------------------------------------------
+Slave devices are handled by a driver written for a family of w1 devices.
+
+A family driver populates a struct w1_family_ops (see w1_family.h) and
+registers with the w1 subsystem.
+
+Current family drivers:
+w1_therm - (ds18?20 thermal sensor family driver)
+    provides temperature reading function which is bound to ->rbin() method
+    of the above w1_family_ops structure.
+
+w1_smem - driver for simple 64bit memory cell provides ID reading method.
 
 You can call above methods by reading appropriate sysfs files.
+
+
+What does a w1 master driver need to implement?
+------------------------------------------------------------------
+
+The driver for w1 bus master must provide at minimum two functions.
+
+Emulated devices must provide the ability to set the output signal level
+(write_bit) and sample the signal level (read_bit).
+
+Devices that support the 1-wire natively must provide the ability to write and
+sample a bit (touch_bit) and reset the bus (reset_bus).
+
+Most hardware provides higher-level functions that offload w1 handling.
+See struct w1_bus_master definition in w1.h for details.
+
+
+w1 master sysfs interface
+------------------------------------------------------------------
+<xx-xxxxxxxxxxxxx> - a directory for a found device. The format is family-serial
+bus                - (standard) symlink to the w1 bus
+driver             - (standard) symlink to the w1 driver
+w1_master_attempts - the number of times a search was attempted
+w1_master_max_slave_count
+                   - the maximum slaves that may be attached to a master
+w1_master_name     - the name of the device (w1_bus_masterX)
+w1_master_search   - the number of searches left to do, -1=continual (default)
+w1_master_slave_count
+                   - the number of slaves found
+w1_master_slaves   - the names of the slaves, one per line
+w1_master_timeout  - the delay in seconds between searches
+
+If you have a w1 bus that never changes (you don't add or remove devices),
+you can set w1_master_search to a positive value to disable searches.
+
+
+w1 slave sysfs interface
+------------------------------------------------------------------
+bus                - (standard) symlink to the w1 bus
+driver             - (standard) symlink to the w1 driver
+name               - the device name, usually the same as the directory name
+w1_slave           - (optional) a binary file whose meaning depends on the
+                     family driver
+

