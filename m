Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261701AbVDTRcY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261701AbVDTRcY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Apr 2005 13:32:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261697AbVDTRcY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Apr 2005 13:32:24 -0400
Received: from ns1.coraid.com ([65.14.39.133]:31656 "EHLO coraid.com")
	by vger.kernel.org with ESMTP id S261770AbVDTRbC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Apr 2005 13:31:02 -0400
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: linux-kernel@vger.kernel.org, greg@kroah.com
Subject: Re: [PATCH 2.6.12-rc2] aoe [1/6]: improve allowed interfaces
 configuration
References: <874qe1pejv.fsf@coraid.com>
	<20050420101644.3d475ff5.rddunlap@osdl.org>
From: Ed L Cashin <ecashin@coraid.com>
Date: Wed, 20 Apr 2005 13:27:20 -0400
In-Reply-To: <20050420101644.3d475ff5.rddunlap@osdl.org> (Randy Dunlap's
 message of "Wed, 20 Apr 2005 10:16:44 -0700")
Message-ID: <87pswpmk93.fsf@coraid.com>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=

"Randy.Dunlap" <rddunlap@osdl.org> writes:

> On Wed, 20 Apr 2005 13:02:12 -0400 Ed L Cashin wrote:
>
> Just a nit/typo:
>
> | +    modprobe aoe_iflist="eth1 eth3"
>
> |  static char aoe_iflist[IFLISTSZ];
> | +module_param_string(aoe_iflist, aoe_iflist, IFLISTSZ, 0600);
> | +MODULE_PARM_DESC(aoe_iflist, " aoe_iflist=\"dev1 [dev2 ...]\n");
>
> No leading space (" aoe_iflist=") and put a trailing \" in it:
>
>   +MODULE_PARM_DESC(aoe_iflist, "aoe_iflist=\"dev1 [dev2 ...]\"\n");

Thanks for catching that.


improve allowed interfaces configuration

Signed-off-by: Ed L. Cashin <ecashin@coraid.com>


--=-=-=
Content-Disposition: inline; filename=patch-124.rediff

diff -uprN a/Documentation/aoe/aoe.txt b/Documentation/aoe/aoe.txt
--- a/Documentation/aoe/aoe.txt	2005-04-20 11:40:55.000000000 -0400
+++ b/Documentation/aoe/aoe.txt	2005-04-20 11:42:20.000000000 -0400
@@ -33,6 +33,9 @@ USING DEVICE NODES
   "cat /dev/etherd/err" blocks, waiting for error diagnostic output,
   like any retransmitted packets.
 
+  The /dev/etherd/interfaces special file is obsoleted by the
+  aoe_iflist boot option and module option (and its sysfs entry
+  described in the next section).
   "echo eth2 eth4 > /dev/etherd/interfaces" tells the aoe driver to
   limit ATA over Ethernet traffic to eth2 and eth4.  AoE traffic from
   untrusted networks should be ignored as a matter of security.
@@ -89,3 +92,24 @@ USING SYSFS
       e4.7            eth1              up
       e4.8            eth1              up
       e4.9            eth1              up
+
+  When the aoe driver is a module, use
+  /sys/module/aoe/parameters/aoe_iflist instead of
+  /dev/etherd/interfaces to limit AoE traffic to the network
+  interfaces in the given whitespace-separated list.  Unlike the old
+  character device, the sysfs entry can be read from as well as
+  written to.
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
diff -uprN a/drivers/block/aoe/aoenet.c b/drivers/block/aoe/aoenet.c
--- a/drivers/block/aoe/aoenet.c	2005-04-20 11:41:18.000000000 -0400
+++ b/drivers/block/aoe/aoenet.c	2005-04-20 11:42:20.000000000 -0400
@@ -7,6 +7,7 @@
 #include <linux/hdreg.h>
 #include <linux/blkdev.h>
 #include <linux/netdevice.h>
+#include <linux/moduleparam.h>
 #include "aoe.h"
 
 #define NECODES 5
@@ -26,6 +27,19 @@ enum {
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
@@ -36,7 +50,8 @@ is_aoe_netif(struct net_device *ifp)
 	if (aoe_iflist[0] == '\0')
 		return 1;
 
-	for (p = aoe_iflist; *p; p = q + strspn(q, WHITESPACE)) {
+	p = aoe_iflist + strspn(aoe_iflist, WHITESPACE);
+	for (; *p; p = q + strspn(q, WHITESPACE)) {
 		q = p + strcspn(p, WHITESPACE);
 		if (q != p)
 			len = q - p;

--=-=-=



-- 
  Ed L Cashin <ecashin@coraid.com>

--=-=-=--

