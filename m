Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261643AbSJYWt7>; Fri, 25 Oct 2002 18:49:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261677AbSJYWt7>; Fri, 25 Oct 2002 18:49:59 -0400
Received: from inet-mail1.oracle.com ([148.87.2.201]:9117 "EHLO
	inet-mail1.oracle.com") by vger.kernel.org with ESMTP
	id <S261669AbSJYWtz>; Fri, 25 Oct 2002 18:49:55 -0400
Message-ID: <4926325.1035586342865.JavaMail.nobody@web11.us.oracle.com>
Date: Fri, 25 Oct 2002 14:52:22 -0800 (GMT-08:00)
From: Bert Barbe <BERT.BARBE@oracle.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH][RFC] 2.4.20-pre11 bonding patch for multiple arp_ip_targets
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-Mailer: Oracle Webmail Client
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Below you find a simple patch for the bonding module that allows multiple arp_ip_targets .
Having just one arp_ip_target would leave room for confusion when the reference
node goes down leaving other nodes to think their interface is malfunctioning.

This patch is based on 2.4.20-pre11. This and the same patch for 2.4.18 and 2.4.19
can be found on http://www.enterprise.be/

Regards,
Bert

----------------cut-here-------BEGIN-----------------------------------------------
--- drivers/net/bonding.c-orig	2002-10-25 23:38:55.000000000 +0200
+++ drivers/net/bonding.c	2002-10-26 00:06:12.000000000 +0200
@@ -191,6 +191,9 @@
  *     - Fixed up bond_check_dev_link() (and callers): removed some magic
  *	 numbers, banished local MII_ defines, wrapped ioctl calls to
  *	 prevent EFAULT errors
+ *
+ * 2002/10/22 - Bert Barbe <bert.barbe at oracle dot com>
+ *     - Add support for multiple arp_ip_target
  */
 
 #include <linux/config.h>
@@ -238,9 +241,10 @@
 #define BOND_LINK_ARP_INTERV	0
 #endif
 
+#define MAX_ARP_IP_TARGETS 16
 static int arp_interval = BOND_LINK_ARP_INTERV;
-static char *arp_ip_target = NULL;
-static unsigned long arp_target = 0;
+static char *arp_ip_target[MAX_ARP_IP_TARGETS] = { NULL, };
+static unsigned long arp_target[MAX_ARP_IP_TARGETS] = { 0, } ;
 static u32 my_ip = 0;
 char *arp_target_hw_addr = NULL;
 
@@ -262,8 +266,8 @@
 MODULE_PARM(mode, "i");
 MODULE_PARM(arp_interval, "i");
 MODULE_PARM_DESC(arp_interval, "arp interval in milliseconds");
-MODULE_PARM(arp_ip_target, "s");
-MODULE_PARM_DESC(arp_ip_target, "arp target in n.n.n.n form");
+MODULE_PARM(arp_ip_target, "1-" __MODULE_STRING(MAX_ARP_IP_TARGETS) "s");
+MODULE_PARM_DESC(arp_ip_target, "arp target(s) in n.n.n.n form");
 MODULE_PARM_DESC(mode, "Mode of operation : 0 for round robin, 1 for active-backup, 2 for xor");
 MODULE_PARM(updelay, "i");
 MODULE_PARM_DESC(updelay, "Delay before considering link up, in milliseconds");
@@ -1489,11 +1493,17 @@
 			} else {
 				if ((jiffies - slave->dev->last_rx) <= 
 						the_delta_in_ticks)  {
-					arp_send(ARPOP_REQUEST, ETH_P_ARP, 
-						arp_target, slave->dev, 
-						my_ip, arp_target_hw_addr, 
-						slave->dev->dev_addr, 
-		  				arp_target_hw_addr); 
+                                        int i;
+                                        for ( i=0;
+                                             (i<MAX_ARP_IP_TARGETS) && arp_target[i];
+                                             i++) {
+                                            arp_send(ARPOP_REQUEST, ETH_P_ARP,
+                                                arp_target[i], slave->dev,
+                                                my_ip, arp_target_hw_addr,
+                                                slave->dev->dev_addr,
+                                                arp_target_hw_addr);
+                                        }
+
 				}
 			}
 		} else 
@@ -1545,11 +1555,17 @@
 			       the_delta_in_ticks) || 
 			     ((jiffies - slave->dev->last_rx) >= 
 			       the_delta_in_ticks) ) {
-				arp_send(ARPOP_REQUEST, ETH_P_ARP, 
-					 arp_target, slave->dev,
-					 my_ip, arp_target_hw_addr, 
-					 slave->dev->dev_addr, 
-					 arp_target_hw_addr); 
+                                int i;
+                                for ( i=0;
+                                      (i<MAX_ARP_IP_TARGETS) && arp_target[i];
+                                      i++) {
+                                        arp_send(ARPOP_REQUEST, ETH_P_ARP,
+                                                 arp_target[i], slave->dev,
+                                                 my_ip, arp_target_hw_addr,
+                                                 slave->dev->dev_addr,
+                                                 arp_target_hw_addr);
+                                }
+
 			}
 		} 
 
@@ -1564,9 +1580,15 @@
 		read_unlock(&bond->ptrlock);
 		slave = (slave_t *)bond;
 		while ((slave = slave->prev) != (slave_t *)bond)   {
-			arp_send(ARPOP_REQUEST, ETH_P_ARP, arp_target, 
-				 slave->dev, my_ip, arp_target_hw_addr, 
-				 slave->dev->dev_addr, arp_target_hw_addr); 
+                        int i;
+                        for ( i=0;
+                              (i<MAX_ARP_IP_TARGETS) && arp_target[i];
+                              i++) {
+                           arp_send(ARPOP_REQUEST, ETH_P_ARP, arp_target[i],
+                                    slave->dev, my_ip, arp_target_hw_addr,
+                                    slave->dev->dev_addr, arp_target_hw_addr);
+                        }
+
 		}
 	}
 	else {
@@ -1980,6 +2002,7 @@
 		memcpy(&my_ip, the_ip, 4);
 	}
 
+#if 0 /* no hw adresses should be cached permanently ! */
 	/* if we are sending arp packets and don't know 
 	   the target hw address, save it so we don't need 
 	   to use a broadcast address */
@@ -1990,6 +2013,7 @@
 		arp_target_hw_addr = kmalloc(ETH_ALEN, GFP_KERNEL);
 		memcpy(arp_target_hw_addr, eth_hdr->h_dest, ETH_ALEN);
 	}
+#endif
 
 	read_lock_irqsave(&bond->lock, flags);
 
@@ -2328,6 +2352,7 @@
 {
 	int no;
 	int err;
+	int i;
 
 	/* Find a name for this unit */
 	static struct net_device *dev_bond = NULL;
@@ -2370,12 +2395,17 @@
 		arp_interval = BOND_LINK_ARP_INTERV;
 	}
 
-	if (arp_ip_target) {
+        for (i=0 ; (i < MAX_ARP_IP_TARGETS) && arp_ip_target[i] ; i++ ) {
 		/* TODO: check and log bad ip address */
-		if (my_inet_aton(arp_ip_target, &arp_target) == 0)  {
+                if (my_inet_aton(arp_ip_target[i], &arp_target[i]) == 0) 
 			arp_interval = 0;
-		}
-	}
+                else {
+                        printk (KERN_INFO
+                                "bonding: arp_ip_target[%d]=%s.\n",
+                                 i,arp_ip_target[i]);
+                }
+        }
+
 
 	for (no = 0; no < max_bonds; no++) {
 		dev_bond->init = bond_init;
----------------cut-here--END------------------------------------------------------


