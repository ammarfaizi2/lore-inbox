Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261510AbTCTPMD>; Thu, 20 Mar 2003 10:12:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261530AbTCTPIH>; Thu, 20 Mar 2003 10:08:07 -0500
Received: from fmr01.intel.com ([192.55.52.18]:53972 "EHLO hermes.fm.intel.com")
	by vger.kernel.org with ESMTP id <S261510AbTCTPGR>;
	Thu, 20 Mar 2003 10:06:17 -0500
Date: Thu, 20 Mar 2003 17:17:07 +0200 (IST)
From: Shmulik Hen <hshmulik@intel.com>
X-X-Sender: hshmulik@jrslxjul4.npdj.intel.com
To: Bonding Developement list <bonding-devel@lists.sourceforge.net>,
       Bonding Announce list <bonding-announce@lists.sourceforge.net>,
       Linux Net Mailing list <linux-net@vger.kernel.org>,
       Linux Kernel Mailing list <linux-kernel@vger.kernel.org>,
       Oss SGI Netdev list <netdev@oss.sgi.com>,
       Jeff Garzik <jgarzik@pobox.com>
Subject: [patch] (5/8) Add 802.3ad support to bonding
Message-ID: <Pine.LNX.4.44.0303201637300.10351-100000@jrslxjul4.npdj.intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch enables support of modes that need to use the unique mac 
address of each slave. It moves setting the slave's mac address and 
opening it from the application to the driver.
This breaks backward compatibility between the new driver and older 
applications !
It also blocks possibility of enslaving before the master is up (to 
prevent putting the system in an unstable state), and removes the code 
that unconditionally restores all base driver's flags (flags are 
automatically restored once all undo stages are done in proper order).

This patch is against bonding 2.4.20-20030317.

diff -Nuarp linux-2.4.20-bonding-20030317/Documentation/networking/ifenslave.c linux-2.4.20-bonding-20030317-devel/Documentation/networking/ifenslave.c
--- linux-2.4.20-bonding-20030317/Documentation/networking/ifenslave.c	2003-03-18 17:03:28.000000000 +0200
+++ linux-2.4.20-bonding-20030317-devel/Documentation/networking/ifenslave.c	2003-03-18 17:03:28.000000000 +0200
@@ -51,6 +51,15 @@
  *         multiple interfaces are specified on a single ifenslave command
  *         (ifenslave bond0 eth0 eth1).
  *
+ *    - 2003/03/18 - Tsippy Mendelson <tsippy.mendelson at intel dot com> and
+ *                   Shmulik Hen <shmulik.hen at intel dot com>
+ *       - Moved setting the slave's mac address and openning it, from
+ *         the application to the driver. This enables support of modes
+ *         that need to use the unique mac address of each slave.
+ *         The driver also takes care of closing the slave and restoring its
+ *         original mac address upon release.
+ *         In addition, block possibility of enslaving before the master is up.
+ *         This prevents putting the system in an undefined state.
  */
 
 static char *version =
@@ -278,30 +287,11 @@ main(int argc, char **argv)
 					fprintf(stderr,	"SIOCBONDRELEASE: cannot detach %s from %s. errno=%s.\n",
 							slave_ifname, master_ifname, strerror(errno));
 			}
-			else {  /* we'll set the interface down to avoid any conflicts due to
-					   same IP/MAC */
-				strncpy(ifr2.ifr_name, slave_ifname, IFNAMSIZ);
-				if (ioctl(skfd, SIOCGIFFLAGS, &ifr2) < 0) {
-					int saved_errno = errno;
-					fprintf(stderr, "SIOCGIFFLAGS on %s failed: %s\n", slave_ifname,
-							strerror(saved_errno));
-				}
-				else {
-					ifr2.ifr_flags &= ~(IFF_UP | IFF_RUNNING);
-					if (ioctl(skfd, SIOCSIFFLAGS, &ifr2) < 0) {
-						int saved_errno = errno;
-						fprintf(stderr, "Shutting down interface %s failed: %s\n",
-								slave_ifname, strerror(saved_errno));
-					}
-				}
-			}
+			/* the bonding module takes care of restoring the slaves original
+			 * mac address and closing its net device
+			 */
 		}
 		else {  /* attach a slave interface to the master */
-			/* two possibilities :
-			   - if hwaddr_notset, do nothing.  The bond will assign the
-			     hwaddr from it's first slave.
-			   - if !hwaddr_notset, assign the master's hwaddr to each slave
-			*/
 
 			strncpy(ifr2.ifr_name, slave_ifname, IFNAMSIZ);
 			if (ioctl(skfd, SIOCGIFFLAGS, &ifr2) < 0) {
@@ -311,6 +301,7 @@ main(int argc, char **argv)
 				return 1;
 			}
 
+			/* if hwaddr_notset, assign the slave hw address to the master */
 			if (hwaddr_notset) {
 				/* assign the slave hw address to the 
 				 * master since it currently does not 
@@ -341,6 +332,10 @@ main(int argc, char **argv)
 						 */
 						master_up = 1; 
 					}
+				} else {
+					fprintf(stderr, "Cannot enslave; the specified master interface '%s' is not up.\n", master_ifname);
+
+					exit (1);
 				}
 
 				if (!goterr) {
@@ -389,41 +384,10 @@ main(int argc, char **argv)
 					}
 				}
 
-			} else {  
-				/* we'll assign master's hwaddr to this slave */
-				if (ifr2.ifr_flags & IFF_UP) {
-					ifr2.ifr_flags &= ~IFF_UP;
-					if (ioctl(skfd, SIOCSIFFLAGS, &ifr2) < 0) {
-						int saved_errno = errno;
-						fprintf(stderr, "Shutting down interface %s failed: %s\n",
-								slave_ifname, strerror(saved_errno));
-					}
-				}
-	
-				strncpy(if_hwaddr.ifr_name, slave_ifname, IFNAMSIZ);
-				if (ioctl(skfd, SIOCSIFHWADDR, &if_hwaddr) < 0) {
-					int saved_errno = errno;
-					fprintf(stderr, "SIOCSIFHWADDR on %s failed: %s\n", if_hwaddr.ifr_name,
-							strerror(saved_errno));
-					if (saved_errno == EBUSY)
-						fprintf(stderr, "  The slave device %s is busy: it must be"
-								" idle before running this command.\n", slave_ifname);
-					else if (saved_errno == EOPNOTSUPP)
-						fprintf(stderr, "  The slave device you specified does not support"
-								" setting the MAC address.\n  Your kernel likely does not"
-								" support slave devices.\n");
-					else if (saved_errno == EINVAL)
-						fprintf(stderr, "  The slave device's address type does not match"
-								" the master's address type.\n");
-				} else {
-					if (verbose) {
-						unsigned char *hwaddr = if_hwaddr.ifr_hwaddr.sa_data;
-						printf("Slave's (%s) hardware address set to "
-							   "%2.2x:%2.2x:%2.2x:%2.2x:%2.2x:%2.2x.\n", slave_ifname,
-							   hwaddr[0], hwaddr[1], hwaddr[2], hwaddr[3], hwaddr[4], hwaddr[5]);
-					}
-				}
 			}
+			/* the bonding module takes care of setting the slave's mac address
+			 * according to the mode requirements.
+			 */
 	
 			if (*spp  &&  !strcmp(*spp, "metric")) {
 				if (*++spp == NULL) {
@@ -500,18 +464,18 @@ main(int argc, char **argv)
 				}
 			}
 			
-			ifr2.ifr_flags |= IFF_UP; /* the interface will need to be up to be bonded */
-			if ((ifr2.ifr_flags &= ~(IFF_SLAVE | IFF_MASTER)) == 0
-				|| strncpy(ifr2.ifr_name, slave_ifname, IFNAMSIZ) <= 0
-				|| ioctl(skfd, SIOCSIFFLAGS, &ifr2) < 0) {
-				fprintf(stderr,
-						"Something broke setting the slave (%s) flags: %s.\n",
-						slave_ifname, strerror(errno));
-			} else {
-				if (verbose)
-					printf("Set the slave's (%s) flags %4.4x.\n", slave_ifname, if_flags.ifr_flags);
+			/* the bonding module takes care of openning the interface
+			 * after setting its mac address
+			 */
+			if (ifr2.ifr_flags & IFF_UP) { // the interface will need to be down
+				ifr2.ifr_flags &= ~IFF_UP;
+				if (ioctl(skfd, SIOCSIFFLAGS, &ifr2) < 0) {
+					int saved_errno = errno;
+					fprintf(stderr, "Shutting down interface %s failed: %s\n",
+							slave_ifname, strerror(saved_errno));
+				}
 			}
-	
+
 			/* Do the real thing */
 			if ( ! opt_r) {
 				strncpy(if_flags.ifr_name, master_ifname, IFNAMSIZ);
diff -Nuarp linux-2.4.20-bonding-20030317/drivers/net/bonding.c linux-2.4.20-bonding-20030317-devel/drivers/net/bonding.c
--- linux-2.4.20-bonding-20030317/drivers/net/bonding.c	2003-03-18 17:03:28.000000000 +0200
+++ linux-2.4.20-bonding-20030317-devel/drivers/net/bonding.c	2003-03-18 17:03:28.000000000 +0200
@@ -303,6 +303,22 @@
  * 2003/03/18 - Amir Noam <amir.noam at intel dot com>
  *	- Added support for getting slave's speed and duplex via ethtool.
  *	  Needed for 802.3ad and other future modes.
+ *
+ * 2003/03/18 - Tsippy Mendelson <tsippy.mendelson at intel dot com> and
+ *		Shmulik Hen <shmulik.hen at intel dot com>
+ *	- Enable support of modes that need to use the unique mac address of
+ *	  each slave.
+ *	  * bond_enslave(): Moved setting the slave's mac address, and
+ *	    openning it, from the application to the driver. This breaks
+ *	    backward comaptibility with old versions of ifenslave that open
+ *	     the slave before enalsving it !!!.
+ *	  * bond_release(): The driver also takes care of closing the slave
+ *	    and restoring its original mac address.
+ *	- Removed the code that restores all base driver's flags.
+ *	  Flags are automatically restored once all undo stages are done
+ *	  properly.
+ *	- Block possibility of enslaving before the master is up. This
+ *	  prevents putting the system in an unstable state.
  */
 
 #include <linux/config.h>
@@ -433,7 +449,6 @@ static void bond_mii_monitor(struct net_
 static void loadbalance_arp_monitor(struct net_device *dev);
 static void activebackup_arp_monitor(struct net_device *dev);
 static int bond_event(struct notifier_block *this, unsigned long event, void *ptr);
-static void bond_restore_slave_flags(slave_t *slave);
 static void bond_mc_list_destroy(struct bonding *bond);
 static void bond_mc_add(bonding_t *bond, void *addr, int alen);
 static void bond_mc_delete(bonding_t *bond, void *addr, int alen);
@@ -509,11 +524,6 @@ multicast_mode_name(void)
 	}
 }
 
-static void bond_restore_slave_flags(slave_t *slave)
-{
-	slave->dev->flags = slave->original_flags;
-}
-
 static void bond_set_slave_inactive_flags(slave_t *slave)
 {
 	slave->state = BOND_STATE_BACKUP;
@@ -1110,12 +1120,12 @@ static int bond_enslave(struct net_devic
 	slave_t *new_slave = NULL;
 	unsigned long flags = 0;
 	unsigned long rflags = 0;
-	int ndx = 0;
 	int err = 0;
 	struct dev_mc_list *dmi;
 	struct in_ifaddr **ifap;
 	struct in_ifaddr *ifa;
 	int link_reporting;
+	struct sockaddr addr;
 
 	if (master_dev == NULL || slave_dev == NULL) {
 		return -ENODEV;
@@ -1128,12 +1138,14 @@ static int bond_enslave(struct net_devic
 			slave_dev->name);
 	}
 
-	/* not running. */
-	if ((slave_dev->flags & IFF_UP) != IFF_UP) {
+	/* This breaks backward comaptibility with old versions
+	   of ifenslave which open the slave before enalsving */
+	/* already up. */
+	if ((slave_dev->flags & IFF_UP) == IFF_UP) {
 #ifdef BONDING_DEBUG
-		printk(KERN_CRIT "Error, slave_dev is not running\n");
+		printk(KERN_CRIT "Error, slave_dev is up\n");
 #endif
-		return -EINVAL;
+		return -EBUSY;
 	}
 
 	/* already enslaved */
@@ -1144,20 +1156,66 @@ static int bond_enslave(struct net_devic
 		return -EBUSY;
 	}
 		   
+	/* bond must be initialize by bond_open() before enslaving */
+	if ((master_dev->flags & IFF_UP) != IFF_UP) {
+#ifdef BONDING_DEBUG
+		printk(KERN_CRIT "Error, master_dev is not up\n");
+#endif
+		return -EPERM;
+	}
+
+	if (slave_dev->set_mac_address == NULL) {
+		printk(KERN_CRIT " The slave device you specified does not support"
+				 " setting the MAC address.\n  Your kernel likely does not"
+				 " support slave devices.\n");
+		return -EOPNOTSUPP;
+	}
+	
 	if ((new_slave = kmalloc(sizeof(slave_t), GFP_ATOMIC)) == NULL) {
 		return -ENOMEM;
 	}
 	memset(new_slave, 0, sizeof(slave_t));
 
-	/* save flags before call to netdev_set_master */
+	/* save slave's original flags before calling */
+	/* netdev_set_master and dev_open */
 	new_slave->original_flags = slave_dev->flags;
+
+	/* save slave's original ("permanent") mac address for
+	   modes that needs it, and for restoring it upon release,
+	   and then set it to the master's address */
+	memcpy(new_slave->perm_hwaddr, slave_dev->dev_addr, ETH_ALEN);
+	
+	if (bond->next != (slave_t*)bond) {
+		/* set slave to master's mac address 
+		   The application already set the master's
+		   mac address to that of the first slave */
+		memcpy(addr.sa_data, master_dev->dev_addr, ETH_ALEN);
+		addr.sa_family = slave_dev->type;
+		err = slave_dev->set_mac_address(slave_dev, &addr);
+		if (err) {
+#ifdef BONDING_DEBUG
+			printk(KERN_CRIT "Error %d calling set_mac_address\n", err);
+#endif
+			goto err_free;
+		}
+	}
+	
+	/* open the slave since the application closed it */
+	err = dev_open(slave_dev);
+	if (err) {
+#ifdef BONDING_DEBUG
+		printk(KERN_CRIT "Openning slave %s failed\n", slave_dev->name);
+#endif
+		goto err_restore_mac;
+	}
+
 	err = netdev_set_master(slave_dev, master_dev);
 
 	if (err) {
 #ifdef BONDING_DEBUG
 		printk(KERN_CRIT "Error %d calling netdev_set_master\n", err);
 #endif
-		goto err_free;
+		goto err_close;
 	}
 
 	new_slave->dev = slave_dev;
@@ -1285,39 +1343,6 @@ static int bond_enslave(struct net_devic
 
 	write_unlock_irqrestore(&bond->lock, flags);
 
-	/*
-	 * !!! This is to support old versions of ifenslave.  We can remove
-	 * this in 2.5 because our ifenslave takes care of this for us.
-	 * We check to see if the master has a mac address yet.  If not,
-	 * we'll give it the mac address of our slave device.
-	 */
-	for (ndx = 0; ndx < slave_dev->addr_len; ndx++) {
-#ifdef BONDING_DEBUG
-		printk(KERN_CRIT "Checking ndx=%d of master_dev->dev_addr\n",
-		       ndx);
-#endif
-		if (master_dev->dev_addr[ndx] != 0) {
-#ifdef BONDING_DEBUG
-		printk(KERN_CRIT "Found non-zero byte at ndx=%d\n",
-		       ndx);
-#endif
-			break;
-		}
-	}
-	if (ndx == slave_dev->addr_len) {
-		/*
-		 * We got all the way through the address and it was
-		 * all 0's.
-		 */
-#ifdef BONDING_DEBUG
-		printk(KERN_CRIT "%s doesn't have a MAC address yet.  ",
-		       master_dev->name);
-		printk(KERN_CRIT "Going to give assign it from %s.\n",
-		       slave_dev->name);
-#endif
-		bond_sethwaddr(master_dev, slave_dev);
-	}
-
 	printk (KERN_INFO "%s: enslaving %s as a%s interface with a%s link.\n",
 		master_dev->name, slave_dev->name,
 		new_slave->state == BOND_STATE_ACTIVE ? "n active" : " backup",
@@ -1325,6 +1350,16 @@ static int bond_enslave(struct net_devic
 
 	//enslave is successfull
 	return 0;
+	
+// Undo stages on error
+err_close:
+	dev_close(slave_dev);
+	
+err_restore_mac:
+	memcpy(addr.sa_data, new_slave->perm_hwaddr, ETH_ALEN);
+	addr.sa_family = slave_dev->type;
+	slave_dev->set_mac_address(slave_dev, &addr);
+
 err_free:
 	kfree(new_slave);
 	return err;
@@ -1539,6 +1574,7 @@ static int bond_release(struct net_devic
 	bonding_t *bond;
 	slave_t *our_slave, *old_current;
 	unsigned long flags;
+	struct sockaddr addr;
 	
 	if (master == NULL || slave == NULL)  {
 		return -ENODEV;
@@ -1612,21 +1648,29 @@ static int bond_release(struct net_devic
 
 	netdev_set_master(slave, NULL);
 
-	/* only restore its RUNNING flag if monitoring set it down */
-	if (slave->flags & IFF_UP) {
-		slave->flags |= IFF_RUNNING;
-	}
+	/* close slave before restoring its mac address */
+	dev_close(slave);
 
-	if (slave->flags & IFF_NOARP || 
-		bond->current_slave != NULL) {
-			dev_close(slave);
-			our_slave->original_flags &= ~IFF_UP;
+	/* restore original ("permanent") mac address*/
+	memcpy(addr.sa_data, our_slave->perm_hwaddr, ETH_ALEN);
+	addr.sa_family = slave->type;
+	slave->set_mac_address(slave, &addr);
+
+	/* restore the original state of the IFF_NOARP flag that might have */
+	/* been set by bond_set_slave_inactive_flags() */
+	if ((our_slave->original_flags & IFF_NOARP) == 0) {
+		slave->flags &= ~IFF_NOARP;
 	}
 
-	bond_restore_slave_flags(our_slave);
-	
 	kfree(our_slave);
 
+	/* if the last slave was removed, zero the mac address 
+	   of the master so it will be set by the application
+	   to the mac address of the first slave */
+	if (bond->next == (slave_t*)bond) {
+		memset(master->dev_addr, 0, master->addr_len);
+	}
+	
 	return 0;  /* deletion OK */
 }
 
@@ -1639,6 +1683,7 @@ static int bond_release_all(struct net_d
 	bonding_t *bond;
 	slave_t *our_slave;
 	struct net_device *slave_dev;
+	struct sockaddr addr;
 
 	if (master == NULL)  {
 		return -ENODEV;
@@ -1673,21 +1718,33 @@ static int bond_release_all(struct net_d
 				dev_set_allmulti(slave_dev, -1); 
 		}
 
-		kfree(our_slave);
-
 		/* Can be safely called from inside the bond lock
 		   since traffic and timers have already stopped
 		*/
 		netdev_set_master(slave_dev, NULL);
 
-		/* only restore its RUNNING flag if monitoring set it down */
-		if (slave_dev->flags & IFF_UP)
-			slave_dev->flags |= IFF_RUNNING;
+		/* close slave before restoring its mac address */
+		dev_close(slave_dev);
+
+		/* restore original ("permanent") mac address*/
+		memcpy(addr.sa_data, our_slave->perm_hwaddr, ETH_ALEN);
+		addr.sa_family = slave_dev->type;
+		slave_dev->set_mac_address(slave_dev, &addr);
+
+		/* restore the original state of the IFF_NOARP flag that might have */
+		/* been set by bond_set_slave_inactive_flags() */
+		if ((our_slave->original_flags & IFF_NOARP) == 0) {
+			slave_dev->flags &= ~IFF_NOARP;
+		}
 
-		if (slave_dev->flags & IFF_NOARP)
-			dev_close(slave_dev);
+		kfree(our_slave);
 	}
 
+	/* zero the mac address of the master so it will be
+	   set by the application to the mac address of the
+	   first slave */
+	memset(master->dev_addr, 0, master->addr_len);
+	
 	printk (KERN_INFO "%s: released all slaves\n", master->name);
 
 	return 0;
@@ -2904,6 +2961,15 @@ static int bond_get_info(char *buf, char
 				"up\n" : "down\n");
 			len += sprintf(buf + len, "Link Failure Count: %d\n", 
 				slave->link_failure_count);
+
+			len += sprintf(buf + len,
+				       "Permanent HW addr: %02x:%02x:%02x:%02x:%02x:%02x\n",
+				       slave->perm_hwaddr[0],
+				       slave->perm_hwaddr[1],
+				       slave->perm_hwaddr[2],
+				       slave->perm_hwaddr[3],
+				       slave->perm_hwaddr[4],
+				       slave->perm_hwaddr[5]);
 		}
 		read_unlock_irqrestore(&bond->lock, flags);
 
diff -Nuarp linux-2.4.20-bonding-20030317/include/linux/if_bonding.h linux-2.4.20-bonding-20030317-devel/include/linux/if_bonding.h
--- linux-2.4.20-bonding-20030317/include/linux/if_bonding.h	2003-03-18 17:03:28.000000000 +0200
+++ linux-2.4.20-bonding-20030317-devel/include/linux/if_bonding.h	2003-03-18 17:03:28.000000000 +0200
@@ -14,6 +14,11 @@
  * 2003/03/18 - Amir Noam <amir.noam at intel dot com>
  *	- Added support for getting slave's speed and duplex via ethtool.
  *	  Needed for 802.3ad and other future modes.
+ * 
+ * 2003/03/18 - Tsippy Mendelson <tsippy.mendelson at intel dot com> and
+ *		Shmulik Hen <shmulik.hen at intel dot com>
+ *	- Enable support of modes that need to use the unique mac address of
+ *	  each slave.
  */
 
 #ifndef _LINUX_IF_BONDING_H
@@ -94,6 +99,7 @@ typedef struct slave {
 	u32 link_failure_count;
 	u16    speed;
 	u8     duplex;
+	u8     perm_hwaddr[ETH_ALEN];
 } slave_t;
 
 /*

-- 
| Shmulik Hen                                    |
| Israel Design Center (Jerusalem)               |
| LAN Access Division                            |
| Intel Communications Group, Intel corp.        |
|                                                |
| Anti-Spam: shmulik dot hen at intel dot com    |



