Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276761AbRKMQ6N>; Tue, 13 Nov 2001 11:58:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276956AbRKMQ6G>; Tue, 13 Nov 2001 11:58:06 -0500
Received: from palrel11.hp.com ([156.153.255.246]:45582 "HELO palrel11.hp.com")
	by vger.kernel.org with SMTP id <S276761AbRKMQ5l>;
	Tue, 13 Nov 2001 11:57:41 -0500
Subject: Re: Linux 2.4.15-pre4 - merge with Alan
From: "Chad N. Tindel" <ctindel@cup.hp.com>
To: "Chad N. Tindel" <ctindel@cup.hp.com>
Cc: Keith Owens <kaos@ocs.com.au>, Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>,
        alan@lxorguk.ukuu.org.uk
In-Reply-To: <1005672430.1361.2.camel@ct742302.cup.hp.com>
In-Reply-To: <12029.1005628638@kao2.melbourne.sgi.com> 
	<1005672430.1361.2.camel@ct742302.cup.hp.com>
Content-Type: multipart/mixed; boundary="=-gCz3vk5O9o2GBcUBfW5l"
X-Mailer: Evolution/0.15 (Preview Release)
Date: 13 Nov 2001 09:58:42 -0800
Message-Id: <1005674323.1361.12.camel@ct742302.cup.hp.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-gCz3vk5O9o2GBcUBfW5l
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, 2001-11-13 at 09:27, Chad N. Tindel wrote:
> > drivers/net/bonding.c has #include <limits.h>, exposing the kernel to
> > user space dependencies.  It must be removed.
> > 
> > I could not find a maintainer for this beast so cc'ed to seevral users
> > in the changelog.

Here's a bonding patch against 2.4.15-pre4 which:

1.  removes the limits.h include
2.  fixes the compiler warning about #include <linux/malloc.h>
3.  Fixes several SMP race conditions
4.  Fixes a deadlock when hotswapping an enslaved ethernet device

I wasn't sure whether or not to send it to Linus, Alan, or lk so I sent
it to all 3.

So that everybody on the list knows, there's a lot of changes that just
went into the bonding driver.  These have been accumulating over time as
people from IBM, HP, Fujitsu, Monta Vista, and other companies have been
working on enhancements in the High Availability area.  I suggest any
interested parties read Documentation/networking/bonding.txt.

Also, this bonding driver *SHOULD* be backwards compatible with the old
one--- meaning  you shouldn't need to recompile ifenslave or pass any
module parameters unless you want to use any of the new features. 
However, if anybody has any problems with this, please email
bonding-devel@lists.sourceforge.net.  Patches will also be accepted.  :)
The new ifenslave is also available in
Documentation/networking/ifenslave.c, if you want to use it.

Chad 

-- 
Chad N. Tindel <ctindel@cup.hp.com>
Software Engineer
Hewlett Packard, Cupertino
(408) 447-4230

--=-gCz3vk5O9o2GBcUBfW5l
Content-Type: text/x-patch
Content-Disposition: attachment; filename=bonding-2.4.15-pre4-20011113
Content-Transfer-Encoding: 7bit

diff -Naru linux-2.4.15-pre4-original/drivers/net/bonding.c linux/drivers/net/bonding.c
--- linux-2.4.15-pre4-original/drivers/net/bonding.c	Tue Nov 13 09:23:22 2001
+++ linux/drivers/net/bonding.c	Tue Nov 13 09:35:24 2001
@@ -153,6 +153,14 @@
  *
  * 2001/10/23 - Takao Indoh <indou dot takao at jp dot fujitsu dot com>
  *     - Various memory leak fixes
+ *
+ * 2001/11/5 - Mark Huth <mark dot huth at mvista dot com>
+ *     - Don't take rtnl lock in bond_mii_monitor as it deadlocks under 
+ *       certain hotswap conditions.  
+ *       Note:  this same change may be required in bond_arp_monitor ???
+ *     - Remove possibility of calling bond_sethwaddr with NULL slave_dev ptr 
+ *     - Handle hot swap ethernet interface deregistration events to remove
+ *       kernel oops following hot swap of enslaved interface
  */
 
 #include <linux/config.h>
@@ -165,7 +173,7 @@
 #include <linux/ptrace.h>
 #include <linux/ioport.h>
 #include <linux/in.h>
-#include <linux/malloc.h>
+#include <linux/slab.h>
 #include <linux/string.h>
 #include <linux/init.h>
 #include <linux/timer.h>
@@ -185,7 +193,6 @@
 
 #include <linux/if_bonding.h>
 #include <linux/smp.h>
-#include <limits.h>
 #include <linux/if_ether.h>
 #include <linux/if_arp.h>
 
@@ -257,6 +264,7 @@
 static void bond_set_slave_active_flags(slave_t *slave);
 static int bond_enslave(struct net_device *master, struct net_device *slave);
 static int bond_release(struct net_device *master, struct net_device *slave);
+static int bond_release_all(struct net_device *master);
 static int bond_sethwaddr(struct net_device *master, struct net_device *slave);
 
 /*
@@ -372,10 +380,13 @@
 static u16 bond_check_mii_link(bonding_t *bond)
 {
 	int has_active_interface = 0;
+	unsigned long flags;
 
+	read_lock_irqsave(&bond->lock, flags);
 	read_lock(&bond->ptrlock);
 	has_active_interface = (bond->current_slave != NULL);
 	read_unlock(&bond->ptrlock);
+	read_unlock_irqrestore(&bond->lock, flags);
 
 	return (has_active_interface ? MII_LINK_READY : 0);
 }
@@ -407,7 +418,6 @@
 static int bond_close(struct net_device *master)
 {
 	bonding_t *bond = (struct bonding *) master->priv;
-	slave_t *slave;
 	unsigned long flags;
 
 	write_lock_irqsave(&bond->lock, flags);
@@ -418,13 +428,11 @@
 	if (arp_interval> 0) {  /* arp interval, in milliseconds. */
 		del_timer(&bond->arp_timer);
 	}
-	/* We need to unlock this because bond_release will re-lock it */
-	write_unlock_irqrestore(&bond->lock, flags);
 
 	/* Release the bonded slaves */
-	while ((slave = bond->prev) != (slave_t *)bond) {
-		bond_release(master, slave->dev);
-	}
+	bond_release_all(master);
+
+	write_unlock_irqrestore(&bond->lock, flags);
 
 	MOD_DEC_USE_COUNT;
 	return 0;
@@ -866,6 +874,49 @@
 	return -EINVAL;
 }
 
+/* 
+ * This function releases all slaves.
+ * Warning: must put write-locks around the call to this function.
+ */
+static int bond_release_all(struct net_device *master)
+{
+	bonding_t *bond;
+	slave_t *our_slave;
+	struct net_device *slave_dev;
+
+	if (master == NULL)  {
+		return -ENODEV;
+	}
+
+	if (master->flags & IFF_SLAVE) {
+		return -EINVAL;
+	}
+
+	bond = (struct bonding *) master->priv;
+	bond->current_slave = NULL;
+
+	while ((our_slave = bond->prev) != (slave_t *)bond) {
+		slave_dev = our_slave->dev;
+		bond->prev = our_slave->prev;
+
+		kfree(our_slave);
+
+		netdev_set_master(slave_dev, NULL);
+
+		/* only restore its RUNNING flag if monitoring set it down */
+		if (slave_dev->flags & IFF_UP)
+			slave_dev->flags |= IFF_RUNNING;
+
+		if (slave_dev->flags & IFF_NOARP)
+			dev_close(slave_dev);
+	}
+	bond->next = (slave_t *)bond;
+	bond->slave_cnt = 0;
+	printk (KERN_INFO "%s: releases all slaves\n", master->name);
+
+	return 0;
+}
+
 /* this function is called regularly to monitor each slave's link. */
 static void bond_mii_monitor(struct net_device *master)
 {
@@ -876,14 +927,6 @@
 
 	read_lock_irqsave(&bond->lock, flags);
 
-	if (rtnl_shlock_nowait()) {
-		goto monitor_out;
-	}
-
-	if (rtnl_exlock_nowait()) {
-		rtnl_shunlock();
-		goto monitor_out;
-	}
 	/* we will try to read the link status of each of our slaves, and
 	 * set their IFF_RUNNING flag appropriately. For each slave not
 	 * supporting MII status, we won't do anything so that a user-space
@@ -1057,9 +1100,10 @@
 		} /* end of switch */
 	} /* end of while */
 
-	/* if there's no active interface and we discovered that one
-	   of the slaves could be activated earlier, so we do it.
-	*/
+	/* 
+	 * if there's no active interface and we discovered that one
+	 * of the slaves could be activated earlier, so we do it.
+	 */
 	read_lock(&bond->ptrlock);
 	oldcurrent = bond->current_slave;
 	read_unlock(&bond->ptrlock);
@@ -1097,9 +1141,6 @@
 		}
 	}
 
-	rtnl_exunlock();
-	rtnl_shunlock();
-monitor_out:
 	read_unlock_irqrestore(&bond->lock, flags);
 	/* re-arm the timer */
 	mod_timer(&bond->mii_timer, jiffies + (miimon * HZ / 1000));
@@ -1128,17 +1169,17 @@
 
 	if (!IS_UP(master)) {
 		mod_timer(&bond->arp_timer, next_timer);
-		goto monitor_out;
+		goto arp_monitor_out;
 	}
 
 
 	if (rtnl_shlock_nowait()) {
-		goto monitor_out;
+		goto arp_monitor_out;
 	}
 
 	if (rtnl_exlock_nowait()) {
 		rtnl_shunlock();
-		goto monitor_out;
+		goto arp_monitor_out;
 	}
 
 	/* see if any of the previous devices are up now (i.e. they have seen a 
@@ -1243,7 +1284,9 @@
 	 * an arp on all of the interfaces 
 	 */
 
+	read_lock(&bond->ptrlock);
 	if (bond->current_slave == NULL) { 
+		read_unlock(&bond->ptrlock);
 		slave = (slave_t *)bond;
 		while ((slave = slave->prev) != (slave_t *)bond)   {
 			arp_send(ARPOP_REQUEST, ETH_P_ARP, arp_target, 
@@ -1251,11 +1294,14 @@
 				 slave->dev->dev_addr, arp_target_hw_addr); 
 		}
 	}
+	else {
+		read_unlock(&bond->ptrlock);
+	}
 
 	rtnl_exunlock();
 	rtnl_shunlock();
 
-monitor_out:
+arp_monitor_out:
 	read_unlock_irqrestore(&bond->lock, flags);
 
 	/* re-arm the timer */
@@ -1367,16 +1413,17 @@
 {
 	bonding_t *bond = (struct bonding *) master->priv;
 	slave_t *slave;
+	unsigned long flags;
 
 	info->bond_mode = mode;
 	info->num_slaves = 0;
 	info->miimon = miimon;
 
-	read_lock(&bond->ptrlock);
+	read_lock_irqsave(&bond->lock, flags);
 	for (slave = bond->prev; slave!=(slave_t *)bond; slave = slave->prev) {
 		info->num_slaves++;
 	}
-	read_unlock(&bond->ptrlock);
+	read_unlock_irqrestore(&bond->lock, flags);
 
 	return 0;
 }
@@ -1387,27 +1434,28 @@
 	bonding_t *bond = (struct bonding *) master->priv;
 	slave_t *slave;
 	int cur_ndx = 0;
+	unsigned long flags;
 
 	if (info->slave_id < 0) {
 		return -ENODEV;
 	}
 
-	read_lock(&bond->ptrlock);
+	read_lock_irqsave(&bond->lock, flags);
 	for (slave = bond->prev; 
 		 slave != (slave_t *)bond && cur_ndx < info->slave_id; 
 		 slave = slave->prev) {
 		cur_ndx++;
 	}
+	read_unlock_irqrestore(&bond->lock, flags);
+
 	if (cur_ndx == info->slave_id) {
 		strcpy(info->slave_name, slave->dev->name);
 		info->link = slave->link;
 		info->state = slave->state;
 		info->link_failure_count = slave->link_failure_count;
 	} else {
-		read_unlock(&bond->ptrlock);
 		return -ENODEV;
 	}
-	read_unlock(&bond->ptrlock);
 
 	return 0;
 }
@@ -1480,40 +1528,40 @@
 	}
 
 	slave_dev = dev_get_by_name(ifr->ifr_slave);
+
 #ifdef BONDING_DEBUG
 	printk(KERN_INFO "slave_dev=%x: \n", (unsigned int)slave_dev);
 	printk(KERN_INFO "slave_dev->name=%s: \n", slave_dev->name);
 #endif
-	switch (cmd) {
-	case BOND_ENSLAVE_OLD:
-	case SIOCBONDENSLAVE:		
-		ret = bond_enslave(master_dev, slave_dev);
-		break;
-	case BOND_RELEASE_OLD:			
-	case SIOCBONDRELEASE:	
-		ret = bond_release(master_dev, slave_dev); 
-		break;
-	case BOND_SETHWADDR_OLD:
-	case SIOCBONDSETHWADDR:	
-		ret = bond_sethwaddr(master_dev, slave_dev);
-		break;
-	case BOND_CHANGE_ACTIVE_OLD:
-	case SIOCBONDCHANGEACTIVE:
-		if (mode == BOND_MODE_ACTIVEBACKUP) {
-			ret = bond_change_active(master_dev, slave_dev);
-		}
-		else {
-			ret = -EINVAL;
-		}
-		break;
-	default:
-		ret = -EOPNOTSUPP;
-	}
 
-	if (slave_dev) {
-		/*
-		 * Clear the module reference that was added by dev_get_by_name
-		 */
+	if (slave_dev == NULL) {
+		ret = -ENODEV;
+	} else {
+		switch (cmd) {
+		case BOND_ENSLAVE_OLD:
+		case SIOCBONDENSLAVE:		
+			ret = bond_enslave(master_dev, slave_dev);
+			break;
+		case BOND_RELEASE_OLD:			
+		case SIOCBONDRELEASE:	
+			ret = bond_release(master_dev, slave_dev); 
+			break;
+		case BOND_SETHWADDR_OLD:
+		case SIOCBONDSETHWADDR:	
+			ret = bond_sethwaddr(master_dev, slave_dev);
+			break;
+		case BOND_CHANGE_ACTIVE_OLD:
+		case SIOCBONDCHANGEACTIVE:
+			if (mode == BOND_MODE_ACTIVEBACKUP) {
+				ret = bond_change_active(master_dev, slave_dev);
+			}
+			else {
+				ret = -EINVAL;
+			}
+			break;
+		default:
+			ret = -EOPNOTSUPP;
+		}
 		dev_put(slave_dev);
 	}
 	return ret;
@@ -1593,13 +1641,11 @@
 	}
 
 	read_lock_irqsave(&bond->lock, flags);
-	read_lock(&bond->ptrlock);
 	slave = bond->prev;
 
 	/* we're at the root, get the first slave */
 	if ((slave == NULL) || (slave->dev == NULL)) { 
 		/* no suitable interface, frame not sent */
-		read_unlock(&bond->ptrlock);
 		dev_kfree_skb(skb);
 		read_unlock_irqrestore(&bond->lock, flags);
 		return 0;
@@ -1607,8 +1653,6 @@
 
 	slave_no = (data->h_dest[5]^slave->dev->dev_addr[5]) % bond->slave_cnt;
 
-	read_unlock(&bond->ptrlock);
-
 	while ( (slave_no > 0) && (slave != (slave_t *)bond) ) {
 		slave = slave->prev;
 		slave_no--;
@@ -1749,6 +1793,7 @@
 	off_t begin = 0;
 	u16 link;
 	slave_t *slave = NULL;
+	unsigned long flags;
 
 	while (bond != NULL) {
 		/*
@@ -1757,17 +1802,19 @@
 		 */
 		link = bond_check_mii_link(bond);
 
-		read_lock(&bond->ptrlock);
-
 		len += sprintf(buf + len, "Bonding Mode: ");
 		len += sprintf(buf + len, "%s\n", mode ? "active-backup" : "load balancing");
 
 		if (mode == BOND_MODE_ACTIVEBACKUP) {
+			read_lock_irqsave(&bond->lock, flags);
+			read_lock(&bond->ptrlock);
 			if (bond->current_slave != NULL) {
 				len += sprintf(buf + len, 
 					"Currently Active Slave: %s\n", 
 					bond->current_slave->dev->name);
 			}
+			read_unlock(&bond->ptrlock);
+			read_unlock_irqrestore(&bond->lock, flags);
 		}
 
 		len += sprintf(buf + len, "MII Status: ");
@@ -1778,6 +1825,7 @@
 		len += sprintf(buf + len, "Up Delay (ms): %d\n", updelay);
 		len += sprintf(buf + len, "Down Delay (ms): %d\n", downdelay);
 
+		read_lock_irqsave(&bond->lock, flags);
 		for (slave = bond->prev; slave != (slave_t *)bond; 
 		     slave = slave->prev) {
 			len += sprintf(buf + len, "\nSlave Interface: %s\n", slave->dev->name);
@@ -1790,6 +1838,7 @@
 			len += sprintf(buf + len, "Link Failure Count: %d\n", 
 				slave->link_failure_count);
 		}
+		read_unlock_irqrestore(&bond->lock, flags);
 
 		/*
 		 * Figure out the calcs for the /proc/net interface
@@ -1803,7 +1852,6 @@
 			len = 0;
 		}
 
-		read_unlock(&bond->ptrlock);
 
 		bond = bond->next_bond;
 	}
@@ -1844,7 +1892,14 @@
 			default:
 				return NOTIFY_DONE;
 			}
-		} 
+		} else if (this_bond->device == event_dev->master) {
+			switch (event) {
+			case NETDEV_UNREGISTER:
+				bond_release(this_bond->device, event_dev);
+				break;
+			}
+			return NOTIFY_DONE;
+		}
 		this_bond = this_bond->next_bond;
 	}
 	return NOTIFY_DONE;
diff -Naru linux-2.4.15-pre4-original/include/linux/if_bonding.h linux/include/linux/if_bonding.h
--- linux-2.4.15-pre4-original/include/linux/if_bonding.h	Tue Nov 13 09:23:46 2001
+++ linux/include/linux/if_bonding.h	Tue Nov 13 09:31:56 2001
@@ -79,6 +79,15 @@
 	u32 link_failure_count;
 } slave_t;
 
+/*
+ * Here are the locking policies for the two bonding locks:
+ *
+ * 1) Get bond->lock when reading/writing slave list.
+ * 2) Get bond->ptrlock when reading/writing bond->current_slave.
+ *    (It is unnecessary when the write-lock is put with bond->lock.)
+ * 3) When we lock with bond->ptrlock, we must lock with bond->lock
+ *    beforehand.
+ */
 typedef struct bonding {
 	slave_t *next;
 	slave_t *prev;

--=-gCz3vk5O9o2GBcUBfW5l--

