Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266139AbUFWGpD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266139AbUFWGpD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jun 2004 02:45:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266147AbUFWGpD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jun 2004 02:45:03 -0400
Received: from mproxy.gmail.com ([216.239.56.250]:22562 "HELO mproxy.gmail.com")
	by vger.kernel.org with SMTP id S266139AbUFWGo1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jun 2004 02:44:27 -0400
Message-ID: <f952f0ea04062223443100e840@mail.gmail.com>
Date: Wed, 23 Jun 2004 12:14:24 +0530
From: Kishore A K <kishoreak@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: [Patch] [2.6.7] Bridge - Fix BPDU message_age
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes message_age field update in config BPDUs. Also checks whether the BPDU 
message age has exceeded bridge max age before transmitting config BPDUs.

Signed-off-by: Kishore A K <KishoreAK@myw.ltindia.com>

Index: linux-2.6.7/net/bridge/br_stp.c
=============================================================

--- linux-2.6.7/net/bridge/br_stp.c.orig    2004-06-17 20:17:27.000000000 +0530
+++ linux-2.6.7/net/bridge/br_stp.c    2004-06-22 19:32:49.015908632 +0530
@@ -161,20 +161,19 @@ void br_transmit_config(struct net_bridg
    if (!br_is_root_bridge(br)) {
        struct net_bridge_port *root
            = br_get_port(br, br->root_port);
-        bpdu.max_age = root->message_age_timer.expires - jiffies;
-
-        if (bpdu.max_age <= 0) bpdu.max_age = 1;
+        bpdu.message_age = br->max_age - 
+            (root->message_age_timer.expires - jiffies) + 1;
    }
    bpdu.max_age = br->max_age;
    bpdu.hello_time = br->hello_time;
    bpdu.forward_delay = br->forward_delay;

-    br_send_config_bpdu(p, &bpdu);
-
-    p->topology_change_ack = 0;
-    p->config_pending = 0;
-    
-    mod_timer(&p->hold_timer, jiffies + BR_HOLD_TIME);
+    if (bpdu.message_age < br->max_age) {
+        br_send_config_bpdu(p, &bpdu);
+        p->topology_change_ack = 0;
+        p->config_pending = 0;
+        mod_timer(&p->hold_timer, jiffies + BR_HOLD_TIME);
+    }
}

/* called under bridge lock */
