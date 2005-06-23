Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262251AbVFWLgl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262251AbVFWLgl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Jun 2005 07:36:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262095AbVFWLgk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Jun 2005 07:36:40 -0400
Received: from wproxy.gmail.com ([64.233.184.206]:42526 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262251AbVFWLfA convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Jun 2005 07:35:00 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=i57R5Fs4W4jMVO1Lj4hToOm5HAZsHV29IUwDE9IgQ136KCAAOPeUi62q6bLhmFQH8Mn0ygUxgJ3ulINRxQNsRCLn5IFqv/FQ1Xa6n2JNh+g1eZJnjUvhZR2rlDvlNv9F0siWicoJGPVLCNns4EQ+UlUnrS5XusD9XHl4oq/h2XA=
Message-ID: <d4cc500a05062304344ebb57d7@mail.gmail.com>
Date: Thu, 23 Jun 2005 14:34:59 +0300
From: Garik E <kiragon@gmail.com>
Reply-To: Garik E <kiragon@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.6.12 Ethernet bridge over bonding interfaces
In-Reply-To: <200506230742.49926.kiragon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200506230742.49926.kiragon@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ethernet bridge configured over bonding interfaces dead loops and
multiplies ethernet broadcast packets (ARP requests)
The following patch solves this problem.

Signed-off-by: Garik E. <kiragon@gmail.com>


diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -605,6 +605,7 @@ static struct bond_parm_tbl bond_mode_tb
 { "802.3ad",  BOND_MODE_8023AD},
 { "balance-tlb",  BOND_MODE_TLB},
 { "balance-alb",  BOND_MODE_ALB},
+{ "bridge-active-backup", BOND_MODE_BRACBP},
 { NULL,   -1},
 };

@@ -631,6 +632,8 @@ static const char *bond_mode_name(int mo
   return "transmit load balancing";
  case BOND_MODE_ALB:
   return "adaptive load balancing";
+ case BOND_MODE_BRACBP:
+  return "bridge fault-tolerance (active-backup)";
  default:
   return "unknown";
  }
@@ -4203,6 +4206,36 @@ out:
  return 0;
 }

+static int bond_xmit_bridge(struct sk_buff *skb, struct net_device *bond_dev)
+{
+ struct bonding *bond = bond_dev->priv;
+ int res = 1;
+
+ read_lock(&bond->lock);
+
+ if (!BOND_IS_OK(bond)) {
+  goto out;
+ }
+
+ if (bond->params.mode == BOND_MODE_BRACBP) {
+  read_lock(&bond->curr_slave_lock);
+  if (bond->curr_active_slave) { /* one usable interface */
+   res = bond_dev_queue_xmit(bond, skb,
+     bond->curr_active_slave->dev);
+  }
+  read_unlock(&bond->curr_slave_lock);
+ }
+
+out:
+ if (res) {
+  /* no suitable interface, frame not sent */
+  dev_kfree_skb(skb);
+ }
+
+ read_unlock(&bond->lock);
+ return 0;
+}
+
 /*------------------------- Device initialization ---------------------------*/

 /*
@@ -4231,6 +4264,9 @@ static inline void bond_set_mode_ops(str
   bond_dev->hard_start_xmit = bond_alb_xmit;
   bond_dev->set_mac_address = bond_alb_set_mac_address;
   break;
+ case BOND_MODE_BRACBP:
+  bond_dev->hard_start_xmit = bond_xmit_bridge;
+  break;
  default:
   /* Should never happen, mode already checked */
   printk(KERN_ERR DRV_NAME
diff --git a/drivers/net/bonding/bonding.h b/drivers/net/bonding/bonding.h
--- a/drivers/net/bonding/bonding.h
+++ b/drivers/net/bonding/bonding.h
@@ -79,7 +79,8 @@
 #define USES_PRIMARY(mode)    \
   (((mode) == BOND_MODE_ACTIVEBACKUP) || \
    ((mode) == BOND_MODE_TLB)          || \
-   ((mode) == BOND_MODE_ALB))
+   ((mode) == BOND_MODE_ALB)          || \
+   ((mode) == BOND_MODE_BRACBP))

 /*
  * Less bad way to call ioctl from within the kernel; this needs to be
diff --git a/include/linux/if_bonding.h b/include/linux/if_bonding.h
--- a/include/linux/if_bonding.h
+++ b/include/linux/if_bonding.h
@@ -67,6 +67,7 @@
 #define BOND_MODE_8023AD        4
 #define BOND_MODE_TLB           5
 #define BOND_MODE_ALB  6 /* TLB + RLB (receive load balancing) */
+#define BOND_MODE_BRACBP 7 /* Active Backup for bridge */

 /* each slave's link has 4 states */
 #define BOND_LINK_UP    0           /* link is up and running */
diff --git a/net/core/dev.c b/net/core/dev.c
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -1597,6 +1597,11 @@ static __inline__ int handle_bridge(stru
      (port = rcu_dereference((*pskb)->dev->br_port)) == NULL)
   return 0;

+ if ((*pskb)->real_dev && !((*pskb)->real_dev->flags & IFF_PROMISC)) {
+  kfree_skb(*pskb);
+  return 1;
+ }
+
  if (*pt_prev) {
   *ret = deliver_skb(*pskb, *pt_prev);
   *pt_prev = NULL;


-------------------------------------------------------
