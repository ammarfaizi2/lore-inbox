Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262638AbUKLWAw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262638AbUKLWAw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Nov 2004 17:00:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262636AbUKLV6t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Nov 2004 16:58:49 -0500
Received: from e34.co.us.ibm.com ([32.97.110.132]:9659 "EHLO e34.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S262634AbUKLV4e (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Nov 2004 16:56:34 -0500
Message-Id: <200411122156.iACLuQLq014316@death.nxdomain.ibm.com>
To: "David S. Miller" <davem@davemloft.net>
cc: "Godse, Radheka" <radheka.godse@intel.com>,
       bonding-devel@lists.sourceforge.net, ctindel@users.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: [Bonding-devel][PATCH]Zero Copy Transmit Support (Update) 
In-Reply-To: Message from "David S. Miller" <davem@davemloft.net> 
   of "Fri, 12 Nov 2004 13:20:50 PST." <20041112132050.45b83434.davem@davemloft.net> 
X-Mailer: MH-E 7.82; nmh 1.0.4; GNU Emacs 21.3.1
Date: Fri, 12 Nov 2004 13:56:26 -0800
From: Jay Vosburgh <fubar@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


David S. Miller <davem@davemloft.net> wrote:
>> I had similar thoughts but then, the bond device does not have any
>> slaves attached to it at load time. By publishing them upfront the bond
>> device is able to take advantage of hardware acceleration if it is later
>> available...

	"Shlomi Yaakobovich" <Shlomi@exanet.com> posted a patch to
update the features as slaves are added and removed, based on the
features advertised by the slaves.  His original patch wasn't properly
based; this is the same change set redone to patch against 2.6.9.

	-J

---
	-Jay Vosburgh, IBM Linux Technology Center, fubar@us.ibm.com


Index: linux-2681-bd/drivers/net/bonding/bond_main.c
===================================================================
RCS file: /sda7/CVS/linux-2681-bd/drivers/net/bonding/bond_main.c,v
retrieving revision 1.2
retrieving revision 1.3
diff -u -u -r1.2 -r1.3
--- linux-2681-bd/drivers/net/bonding/bond_main.c	15 Oct 2004 22:11:14 -0000	1.2
+++ linux-2681-bd/drivers/net/bonding/bond_main.c	15 Oct 2004 23:27:34 -0000	1.3
@@ -1580,6 +1580,32 @@
 	return 0;
 }
 
+enum { /* don't set these here */
+       BOND_MAINTAINED_FEATURES =
+               NETIF_F_VLAN_CHALLENGED|NETIF_F_HW_VLAN_TX |
+               NETIF_F_HW_VLAN_RX |NETIF_F_HW_VLAN_FILTER
+};
+
+static void bond_set_features(struct net_device *bond_dev)
+{
+       struct bonding *bond = bond_dev->priv;
+       struct slave *slave;
+       int i, features = 0;
+
+       bond_for_each_slave(bond, slave, i) {
+               struct net_device *slave_dev = slave->dev;
+               if (i == 0) {
+                       features = slave_dev->features;
+	       } else {
+                       features &= slave_dev->features;
+	       }
+       }
+       /* clear all previous features */
+       bond_dev->features &= BOND_MAINTAINED_FEATURES;
+       /* add common features, don't touch driver maintained ones */
+       bond_dev->features |= (features & ~BOND_MAINTAINED_FEATURES);
+}
+
 /* enslave device <slave> to bond device <master> */
 static int bond_enslave(struct net_device *bond_dev, struct net_device *slave_dev)
 {
@@ -1972,6 +1998,7 @@
 	       new_slave->link != BOND_LINK_DOWN ? "n up" : " down");
 
 	/* enslave is successful */
+	bond_set_features(bond_dev);
 	return 0;
 
 /* Undo stages on error */
@@ -2177,6 +2204,7 @@
 
 	kfree(slave);
 
+	bond_set_features(bond_dev);
 	return 0;  /* deletion OK */
 }
 
@@ -2292,6 +2320,7 @@
 	printk(KERN_INFO DRV_NAME
 	       ": %s: released all slaves\n",
 	       bond_dev->name);
+	bond_set_features(bond_dev);
 
 out:
 	write_unlock_bh(&bond->lock);
