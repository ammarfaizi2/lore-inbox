Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270569AbTGNM1E (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jul 2003 08:27:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270607AbTGNM0z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jul 2003 08:26:55 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:41348
	"EHLO hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S270569AbTGNMJa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jul 2003 08:09:30 -0400
Date: Mon, 14 Jul 2003 13:23:29 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200307141223.h6ECNTw2030887@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, marcelo@conectiva.com
Subject: PATCH: config stuff for qdio/qeth
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.22-pre5/drivers/s390/Config.in linux.22-pre5-ac1/drivers/s390/Config.in
--- linux.22-pre5/drivers/s390/Config.in	2003-07-14 12:27:38.000000000 +0100
+++ linux.22-pre5-ac1/drivers/s390/Config.in	2003-07-07 16:03:56.000000000 +0100
@@ -88,6 +89,23 @@
 	define_bool CONFIG_HOTPLUG y
     fi
 
+    if [ "$CONFIG_QDIO" != "n" -a "$CONFIG_CHANDEV" = "y" -a "$CONFIG_IP_MULTICAST" = "y" ]; then
+      dep_tristate 'Support for Gigabit Ethernet' CONFIG_QETH $CONFIG_QDIO
+      if [ "$CONFIG_QETH" != "n" ]; then
+        comment 'Gigabit Ethernet default settings'
+	if [ "$CONFIG_IPV6" = "y" -o "$CONFIG_IPV6" = "$CONFIG_QETH" ]; then
+		bool '   IPv6 support for qeth' CONFIG_QETH_IPV6
+	else    
+		define_bool CONFIG_QETH_IPV6 n
+	fi
+	if [ "$CONFIG_VLAN_8021Q" = "y" -o "$CONFIG_VLAN_8021Q" = "$CONFIG_QETH" ]; then
+		bool '   VLAN support for qeth' CONFIG_QETH_VLAN
+	else    
+		define_bool CONFIG_QETH_VLAN n
+	fi
+        bool '   Performance statistics in /proc' CONFIG_QETH_PERF_STATS
+      fi
+    fi
     tristate 'CTC device support' CONFIG_CTC
     tristate 'IUCV device support (VM only)' CONFIG_IUCV
   fi
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.22-pre5/drivers/s390/Makefile linux.22-pre5-ac1/drivers/s390/Makefile
--- linux.22-pre5/drivers/s390/Makefile	2003-07-14 12:26:57.000000000 +0100
+++ linux.22-pre5-ac1/drivers/s390/Makefile	2003-07-07 16:05:42.000000000 +0100
@@ -9,6 +9,8 @@
 
 obj-y := s390io.o s390mach.o s390dyn.o ccwcache.o sysinfo.o
 export-objs += ccwcache.o s390dyn.o s390io.o
+obj-$(CONFIG_QDIO) += qdio.o
+export-objs += qdio.o
 
 obj-y += $(foreach dir,$(subdir-y),$(dir)/s390-$(dir).o)
 
