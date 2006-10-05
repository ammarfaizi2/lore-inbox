Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751190AbWJESWn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751190AbWJESWn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 14:22:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751008AbWJESWn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 14:22:43 -0400
Received: from ext-103.mv.fabric7.com ([68.120.107.103]:7639 "EHLO
	corp.fabric7.com") by vger.kernel.org with ESMTP id S1750819AbWJESWm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 14:22:42 -0400
From: Misha Tomushev <misha@fabric7.com>
Reply-To: misha@fabric7.com
Organization: Fabric7 Systems
To: Jeff Garzik <jeff@garzik.org>
Subject: [PATCH 1/10] VIOC: New Network Device Driver
Date: Thu, 5 Oct 2006 10:52:46 -0700
User-Agent: KMail/1.5.1
Cc: KERNEL Linux <linux-kernel@vger.kernel.org>,
       NETDEV Linux <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610051052.46995.misha@fabric7.com>
X-OriginalArrivalTime: 05 Oct 2006 18:22:40.0812 (UTC) FILETIME=[3E40BEC0:01C6E8AB]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adding VIOC device driver, support files: Documenation, makefiles etc.

Signed-off-by: Misha Tomushev  <misha@fabric7.com>

diff -uprN linux-2.6.17/Documentation/networking/vioc.txt 
linux-2.6.17.vioc/Documentation/networking/vioc.txt
--- linux-2.6.17/Documentation/networking/vioc.txt	1969-12-31 
16:00:00.000000000 -0800
+++ linux-2.6.17.vioc/Documentation/networking/vioc.txt	2006-09-01 
10:09:49.000000000 -0700
@@ -0,0 +1,98 @@
+                VIOC Driver Release Notes (07/12/06)
+                ====================================
+                     driver-support@fabric7.com
+
+
+Overview
+========
+
+A Virtual Input-Output Controller (VIOC) is a PCI device that provides
+10Gbps of I/O bandwidth that can be shared by up to 16 virtual network
+interfaces (VNICs).  VIOC hardware supports several features such as
+large frames, checksum offload, gathered send, MSI/MSI-X, bandwidth
+control, interrupt mitigation, etc.
+
+VNICs are provisioned to a host partition via an out-of-band interface
+from the System Controller -- typically before the partition boots,
+although they can be dynamically added or removed from a running
+partition as well.
+
+Each provisioned VNIC appears as an Ethernet netdevice to the host OS,
+and maintains its own transmit ring in DMA memory.  VNICs are
+configured to share up to 4 of total 16 receive rings and 1 of total
+16 receive-completion rings in DMA memory.  VIOC hardware classifies
+packets into receive rings based on size, allowing more efficient use
+of DMA buffer memory.  The default, and recommended, configuration
+uses groups of 'receive sets' (rxsets), each with 3 receive rings, a
+receive completion ring, and a VIOC Rx interrupt.  The driver gives
+each rxset a NAPI poll handler associated with a phantom (invisible)
+netdevice, for concurrency.  VNICs are assigned to rxsets using a
+simple modulus.
+
+VIOC provides 4 interrupts in INTx mode: 2 for Rx, 1 for Tx, and 1 for
+out-of-band messages from the System Controller and errors.  VIOC also
+provides 19 MSI-X interrupts: 16 for Rx, 1 for Tx, 1 for out-of-band
+messages from the System Controller, and 1 for error signalling from
+the hardware.  The VIOC driver makes a determination whether MSI-X
+functionality is supported and initializes interrupts accordingly.
+[Note: The Linux kernel disables MSI-X for VIOCs on modules with AMD
+8131, even if the device is on the HT link.]
+
+
+Module loadable parameters
+==========================
+
+- poll_weight (default 8) - the number of received packets will be
+  processed during one call into the NAPI poll handler.
+
+- rx_intr_timeout (default 1) - hardware rx interrupt mitigation
+  timer, in units of 5us.
+
+- rx_intr_pkt_cnt (default 64) - hardware rx interrupt mitigation
+  counter, in units of packets.
+
+- tx_pkts_per_irq (default 64) - hardware tx interrupt mitigation
+  counter, in units of packets.
+
+- tx_pkts_per_bell (default 1) - the number of packets to enqueue on a
+  transmit ring before issuing a doorbell to hardware.
+
+Performance Tuning
+==================
+
+You may want to use the following sysctl settings to improve
+performance.  [NOTE: To be re-checked]
+
+# set in /etc/sysctl.conf
+
+net.ipv4.tcp_timestamps = 0
+net.ipv4.tcp_sack = 0
+net.ipv4.tcp_rmem = 10000000 10000000 10000000
+net.ipv4.tcp_wmem = 10000000 10000000 10000000
+net.ipv4.tcp_mem  = 10000000 10000000 10000000
+
+net.core.rmem_max = 5242879
+net.core.wmem_max = 5242879
+net.core.rmem_default = 5242879
+net.core.wmem_default = 5242879
+net.core.optmem_max = 5242879
+net.core.netdev_max_backlog = 100000
+
+Out-of-band Communications with System Controller
+=================================================
+
+System operators can use the out-of-band facility to allow for remote
+shutdown or reboot of the host partition.  Upon receiving such a
+command, the VIOC driver executes "/sbin/reboot" or "/sbin/shutdown"
+via the usermodehelper() call.
+
+This same communications facility is used for dynamic VNIC
+provisioning (plug in and out).
+
+The VIOC driver also registers a callback with
+register_reboot_notifier().  When the callback is executed, the driver
+records the shutdown event and reason in a VIOC register to notify the
+System Controller.
+
+
+
diff -uprN linux-2.6.17/MAINTAINERS linux-2.6.17.vioc/MAINTAINERS
--- linux-2.6.17/MAINTAINERS	2006-06-17 18:49:35.000000000 -0700
+++ linux-2.6.17.vioc/MAINTAINERS	2006-09-01 10:09:49.000000000 -0700
@@ -3106,6 +3106,11 @@ L:	rio500-users@lists.sourceforge.net
 W:	http://rio500.sourceforge.net
 S:	Maintained
 
+VIOC NETWORK DRIVER
+P:     support@fabric7.com
+L:     netdev@vger.kernel.org
+S:     Maintained
+
 VIDEO FOR LINUX
 P:	Mauro Carvalho Chehab
 M:	mchehab@infradead.org
diff -uprN linux-2.6.17/drivers/net/Kconfig 
linux-2.6.17.vioc/drivers/net/Kconfig
--- linux-2.6.17/drivers/net/Kconfig	2006-06-17 18:49:35.000000000 -0700
+++ linux-2.6.17.vioc/drivers/net/Kconfig	2006-09-01 10:19:35.000000000 -0700
@@ -1818,9 +1818,6 @@ config NE_H8300
 	  Say Y here if you want to use the NE2000 compatible
 	  controller on the Renesas H8/300 processor.
 
-source "drivers/net/fec_8xx/Kconfig"
-source "drivers/net/fs_enet/Kconfig"
-
 endmenu
 
 #
@@ -2228,6 +2225,15 @@ endmenu
 menu "Ethernet (10000 Mbit)"
 	depends on !UML
 
+config VIOC
+	tristate "Fabric7 VIOC support"
+	depends on PCI
+	help
+	 This driver supports the Virtual Input-Output Controller (VIOC) a
+	 single PCI device that provides 10Gbps of I/O bandwidth that can be
+	 shared by up to 16 virtual network interfaces (VNICs).
+	 See <file:Documentation/networking/vioc.txt> for more information
+
 config CHELSIO_T1
         tristate "Chelsio 10Gb Ethernet support"
         depends on PCI
@@ -2311,6 +2317,9 @@ config S2IO_NAPI
 
 	  If in doubt, say N.
 
+source "drivers/net/fec_8xx/Kconfig"
+source "drivers/net/fs_enet/Kconfig"
+
 endmenu
 
 source "drivers/net/tokenring/Kconfig"
diff -uprN linux-2.6.17/drivers/net/Makefile 
linux-2.6.17.vioc/drivers/net/Makefile
--- linux-2.6.17/drivers/net/Makefile	2006-06-17 18:49:35.000000000 -0700
+++ linux-2.6.17.vioc/drivers/net/Makefile	2006-09-01 10:09:49.000000000 -0700
@@ -10,6 +10,7 @@ obj-$(CONFIG_E1000) += e1000/
 obj-$(CONFIG_IBM_EMAC) += ibm_emac/
 obj-$(CONFIG_IXGB) += ixgb/
 obj-$(CONFIG_CHELSIO_T1) += chelsio/
+obj-$(CONFIG_VIOC) += vioc/
 obj-$(CONFIG_BONDING) += bonding/
 obj-$(CONFIG_GIANFAR) += gianfar_driver.o

diff -uprN linux-2.6.17/drivers/net/vioc/Makefile 
linux-2.6.17.vioc/drivers/net/vioc/Makefile
--- linux-2.6.17/drivers/net/vioc/Makefile	1969-12-31 16:00:00.000000000 -0800
+++ linux-2.6.17.vioc/drivers/net/vioc/Makefile	2006-10-04 13:32:21.000000000 
-0700
@@ -0,0 +1,34 @@
+################################################################################
+#
+#
+# Copyright(c) 2003-2006 Fabric7 Systems. All rights reserved.
+#
+# This program is free software; you can redistribute it and/or modify it
+# under the terms of the GNU General Public License as published by the Free
+# Software Foundation; either version 2 of the License, or (at your option)
+# any later version.
+#
+# This program is distributed in the hope that it will be useful, but WITHOUT
+# ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+# FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+# more details.
+#
+# You should have received a copy of the GNU General Public License along 
with
+# this program; if not, write to the Free Software Foundation, Inc., 59
+# Temple Place - Suite 330, Boston, MA  02111-1307, USA.
+#
+# The full GNU General Public License is included in this distribution in the
+# file called LICENSE.
+#
+# Contact Information:
+# <support@fabric7.com>
+# Fabric7 Systems, 1300 Crittenden Lane Suite 302 Mountain View, CA 94043
+#
+################################################################################
+
+obj-$(CONFIG_VIOC) += vioc.o
+
+vioc-objs := vioc_driver.o vioc_transmit.o vioc_receive.o vioc_api.o \
+            vioc_spp.o vioc_irq.o spp.o spp_vnic.o vioc_provision.o \
+            vioc_ethtool.o
+

-- 
Misha Tomushev
misha@fabric7.com


