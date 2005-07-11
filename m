Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261738AbVGKOOU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261738AbVGKOOU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Jul 2005 10:14:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261715AbVGKOMZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Jul 2005 10:12:25 -0400
Received: from mailgw.voltaire.com ([212.143.27.70]:3782 "EHLO
	mailgw.voltaire.com") by vger.kernel.org with ESMTP id S261738AbVGKOMJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Jul 2005 10:12:09 -0400
Subject: [PATCH 8/27] Minor cleanup during MAD startup and shutdown
From: Hal Rosenstock <halr@voltaire.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Content-Type: text/plain
Organization: 
Message-Id: <1121089102.4389.4521.camel@hal.voltaire.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 11 Jul 2005 10:04:31 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Minor cleanup during startup and shutdown

Signed-off-by: Hal Rosenstock <halr@voltaire.com>

This patch depends on patch 7/27.

-- 
 mad.c |   44 +++++++++--
 1 files changed, 9 insertions(+), 35 deletions(-)
diff -uprN linux-2.6.13-rc2-mm1/drivers/infiniband7/core/mad.c linux-2.6.13-rc2-mm1/drivers/infiniband8/core/mad.c
-- linux-2.6.13-rc2-mm1/drivers/infiniband7/core/mad.c	2005-07-09 16:48:45.000000000 -0400
+++ linux-2.6.13-rc2-mm1/drivers/infiniband8/core/mad.c	2005-07-09 16:51:21.000000000 -0400
@@ -2487,14 +2487,6 @@ static int ib_mad_port_open(struct ib_de
 	unsigned long flags;
 	char name[sizeof "ib_mad123"];
 
-	/* First, check if port already open at MAD layer */
-	port_priv = ib_get_mad_port(device, port_num);
-	if (port_priv) {
-		printk(KERN_DEBUG PFX "%s port %d already open\n",
-		       device->name, port_num);
-		return 0;
-	}
-
 	/* Create new device info */
 	port_priv = kmalloc(sizeof *port_priv, GFP_KERNEL);
 	if (!port_priv) {
@@ -2619,7 +2611,7 @@ static int ib_mad_port_close(struct ib_d
 
 static void ib_mad_init_device(struct ib_device *device)
 {
-	int ret, num_ports, cur_port, i, ret2;
+	int num_ports, cur_port, i;
 
 	if (device->node_type == IB_NODE_SWITCH) {
 		num_ports = 1;
@@ -2629,47 +2621,37 @@ static void ib_mad_init_device(struct ib
 		cur_port = 1;
 	}
 	for (i = 0; i < num_ports; i++, cur_port++) {
-		ret = ib_mad_port_open(device, cur_port);
-		if (ret) {
+		if (ib_mad_port_open(device, cur_port)) {
 			printk(KERN_ERR PFX "Couldn't open %s port %d\n",
 			       device->name, cur_port);
 			goto error_device_open;
 		}
-		ret = ib_agent_port_open(device, cur_port);
-		if (ret) {
+		if (ib_agent_port_open(device, cur_port)) {
 			printk(KERN_ERR PFX "Couldn't open %s port %d "
 			       "for agents\n",
 			       device->name, cur_port);
 			goto error_device_open;
 		}
 	}
-
-	goto error_device_query;
+	return;
 
 error_device_open:
 	while (i > 0) {
 		cur_port--;
-		ret2 = ib_agent_port_close(device, cur_port);
-		if (ret2) {
+		if (ib_agent_port_close(device, cur_port))
 			printk(KERN_ERR PFX "Couldn't close %s port %d "
 			       "for agents\n",
 			       device->name, cur_port);
-		}
-		ret2 = ib_mad_port_close(device, cur_port);
-		if (ret2) {
+		if (ib_mad_port_close(device, cur_port))
 			printk(KERN_ERR PFX "Couldn't close %s port %d\n",
 			       device->name, cur_port);
-		}
 		i--;
 	}
-
-error_device_query:
-	return;
 }
 
 static void ib_mad_remove_device(struct ib_device *device)
 {
-	int ret = 0, i, num_ports, cur_port, ret2;
+	int i, num_ports, cur_port;
 
 	if (device->node_type == IB_NODE_SWITCH) {
 		num_ports = 1;
@@ -2679,21 +2661,13 @@ static void ib_mad_remove_device(struct 
 		cur_port = 1;
 	}
 	for (i = 0; i < num_ports; i++, cur_port++) {
-		ret2 = ib_agent_port_close(device, cur_port);
-		if (ret2) {
+		if (ib_agent_port_close(device, cur_port))
 			printk(KERN_ERR PFX "Couldn't close %s port %d "
 			       "for agents\n",
 			       device->name, cur_port);
-			if (!ret)
-				ret = ret2;
-		}
-		ret2 = ib_mad_port_close(device, cur_port);
-		if (ret2) {
+		if (ib_mad_port_close(device, cur_port))
 			printk(KERN_ERR PFX "Couldn't close %s port %d\n",
 			       device->name, cur_port);
-			if (!ret)
-				ret = ret2;
-		}
 	}
 }
 


