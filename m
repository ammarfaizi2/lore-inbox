Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261712AbTCLAIF>; Tue, 11 Mar 2003 19:08:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261681AbTCLAHZ>; Tue, 11 Mar 2003 19:07:25 -0500
Received: from air-2.osdl.org ([65.172.181.6]:16266 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S261691AbTCLAEF>;
	Tue, 11 Mar 2003 19:04:05 -0500
Subject: [PATCH] (3/8) Eliminate brlock from vlan
From: Stephen Hemminger <shemminger@osdl.org>
To: Linus Torvalds <torvalds@transmeta.com>, David Miller <davem@redhat.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-net@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0303091831560.2129-100000@home.transmeta.com>
References: <Pine.LNX.4.44.0303091831560.2129-100000@home.transmeta.com>
Content-Type: text/plain
Organization: Open Source Devlopment Lab
Message-Id: <1047428085.15869.101.camel@dell_ss3.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 11 Mar 2003 16:14:45 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eliminate brlock from vlan

diff -urN -X dontdiff linux-2.5.64/net/8021q/vlan.c linux-2.5-nobrlock/net/8021q/vlan.c
--- linux-2.5.64/net/8021q/vlan.c	2003-03-11 09:08:01.000000000 -0800
+++ linux-2.5-nobrlock/net/8021q/vlan.c	2003-03-11 14:31:28.000000000 -0800
@@ -29,7 +29,6 @@
 #include <net/p8022.h>
 #include <net/arp.h>
 #include <linux/rtnetlink.h>
-#include <linux/brlock.h>
 #include <linux/notifier.h>
 
 #include <linux/if_vlan.h>
@@ -68,7 +67,6 @@
 	.dev =NULL,
 	.func = vlan_skb_recv, /* VLAN receive method */
 	.data = (void *)(-1),  /* Set here '(void *)1' when this code can SHARE SKBs */
-	.next = NULL
 };
 
 /* End of global variables definitions. */
@@ -231,9 +229,10 @@
 				real_dev->vlan_rx_kill_vid(real_dev, vlan_id);
 			}
 
-			br_write_lock(BR_NETPROTO_LOCK);
 			grp->vlan_devices[vlan_id] = NULL;
-			br_write_unlock(BR_NETPROTO_LOCK);
+
+			/* wait for RCU in network receive */
+			synchronize_kernel();
 
 
 			/* Caller unregisters (and if necessary, puts)
diff -urN -X dontdiff linux-2.5.64/net/8021q/vlan_dev.c linux-2.5-nobrlock/net/8021q/vlan_dev.c
--- linux-2.5.64/net/8021q/vlan_dev.c	2003-03-11 09:08:01.000000000 -0800
+++ linux-2.5-nobrlock/net/8021q/vlan_dev.c	2003-03-10 15:49:52.000000000 -0800
@@ -31,7 +31,6 @@
 #include <net/datalink.h>
 #include <net/p8022.h>
 #include <net/arp.h>
-#include <linux/brlock.h>
 
 #include "vlan.h"
 #include "vlanproc.h"



