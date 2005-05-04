Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262060AbVEDHR2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262060AbVEDHR2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 May 2005 03:17:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262062AbVEDHQ1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 May 2005 03:16:27 -0400
Received: from mail.kroah.org ([69.55.234.183]:58601 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262060AbVEDHLm convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 May 2005 03:11:42 -0400
Cc: ecashin@coraid.com
Subject: [PATCH] aoe: improve allowed interfaces configuration
In-Reply-To: <20050504071023.GA18043@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Wed, 4 May 2005 00:11:35 -0700
Message-Id: <1115190695150@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] aoe: improve allowed interfaces configuration

improve allowed interfaces configuration

Signed-off-by: Ed L. Cashin <ecashin@coraid.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

diff -uprN a/Documentation/aoe/aoe.txt b/Documentation/aoe/aoe.txt

---
commit 03c41c434775c52092d17a5031ad8ebaaf555bc4
tree a2f4e5f5fef46fac69b1e47e31ccbcf7d950b016
parent 8800cea62025a5209d110c5fa5990429239d6eee
author Ed L Cashin <ecashin@coraid.com> 1114784643 -0400
committer Greg KH <gregkh@suse.de> 1115188493 -0700

Index: Documentation/aoe/aoe.txt
===================================================================
--- 2aa9e4732d7014dcda4c0e80d2e377f52e2262e9/Documentation/aoe/aoe.txt  (mode:100644 sha1:43e50108d0e21c56ec5bcd873916c9f547a765c8)
+++ a2f4e5f5fef46fac69b1e47e31ccbcf7d950b016/Documentation/aoe/aoe.txt  (mode:100644 sha1:1212987a30fa018c0e2d1f32e0baf29a6537d123)
@@ -33,6 +33,9 @@
   "cat /dev/etherd/err" blocks, waiting for error diagnostic output,
   like any retransmitted packets.
 
+  The /dev/etherd/interfaces special file is obsoleted by the
+  aoe_iflist boot option and module option (and its sysfs entry
+  described in the next section).
   "echo eth2 eth4 > /dev/etherd/interfaces" tells the aoe driver to
   limit ATA over Ethernet traffic to eth2 and eth4.  AoE traffic from
   untrusted networks should be ignored as a matter of security.
@@ -89,3 +92,23 @@
       e4.7            eth1              up
       e4.8            eth1              up
       e4.9            eth1              up
+
+  Use /sys/module/aoe/parameters/aoe_iflist (or better, the driver
+  option discussed below) instead of /dev/etherd/interfaces to limit
+  AoE traffic to the network interfaces in the given
+  whitespace-separated list.  Unlike the old character device, the
+  sysfs entry can be read from as well as written to.
+
+  It's helpful to trigger discovery after setting the list of allowed
+  interfaces.  If your distro provides an aoe-discover script, you can
+  use that.  Otherwise, you can directly use the /dev/etherd/discover
+  file described above.
+
+DRIVER OPTIONS
+
+  There is a boot option for the built-in aoe driver and a
+  corresponding module parameter, aoe_iflist.  Without this option,
+  all network interfaces may be used for ATA over Ethernet.  Here is a
+  usage example for the module parameter.
+
+    modprobe aoe_iflist="eth1 eth3"
Index: drivers/block/aoe/aoenet.c
===================================================================
--- 2aa9e4732d7014dcda4c0e80d2e377f52e2262e9/drivers/block/aoe/aoenet.c  (mode:100644 sha1:bc92aacb6dadad9f2bff4145d237acd35856526d)
+++ a2f4e5f5fef46fac69b1e47e31ccbcf7d950b016/drivers/block/aoe/aoenet.c  (mode:100644 sha1:9e6f51c528b094684c2b709c55be738c3d361225)
@@ -7,6 +7,7 @@
 #include <linux/hdreg.h>
 #include <linux/blkdev.h>
 #include <linux/netdevice.h>
+#include <linux/moduleparam.h>
 #include "aoe.h"
 
 #define NECODES 5
@@ -26,6 +27,19 @@
 };
 
 static char aoe_iflist[IFLISTSZ];
+module_param_string(aoe_iflist, aoe_iflist, IFLISTSZ, 0600);
+MODULE_PARM_DESC(aoe_iflist, "aoe_iflist=\"dev1 [dev2 ...]\"\n");
+
+#ifndef MODULE
+static int __init aoe_iflist_setup(char *str)
+{
+	strncpy(aoe_iflist, str, IFLISTSZ);
+	aoe_iflist[IFLISTSZ - 1] = '\0';
+	return 1;
+}
+
+__setup("aoe_iflist=", aoe_iflist_setup);
+#endif
 
 int
 is_aoe_netif(struct net_device *ifp)
@@ -36,7 +50,8 @@
 	if (aoe_iflist[0] == '\0')
 		return 1;
 
-	for (p = aoe_iflist; *p; p = q + strspn(q, WHITESPACE)) {
+	p = aoe_iflist + strspn(aoe_iflist, WHITESPACE);
+	for (; *p; p = q + strspn(q, WHITESPACE)) {
 		q = p + strcspn(p, WHITESPACE);
 		if (q != p)
 			len = q - p;

