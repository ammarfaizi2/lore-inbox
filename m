Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261452AbTEAROj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 May 2003 13:14:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261462AbTEAROj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 May 2003 13:14:39 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.104]:57845 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261452AbTEARO1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 May 2003 13:14:27 -0400
Message-ID: <3EB15849.D0E1556D@us.ibm.com>
Date: Thu, 01 May 2003 10:24:25 -0700
From: "Jim Keniston[UNIX]" <jkenisto@us.ibm.com>
X-Mailer: Mozilla 4.75 [en] (WinNT; U)
X-Accept-Language: en
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       "Feldman, Scott" <scott.feldman@intel.com>, Greg KH <greg@kroah.com>,
       Janice Girard <girouard@us.ibm.com>, Jeff Garzik <jgarzik@pobox.com>,
       LOS team <losteam@intel.com>, Phil Cayton <phil.cayton@intel.com>,
       Randy Dunlap <rddunlap@osdl.org>, Larry Kessler <kessler@us.ibm.com>
Subject: [RFC] [PATCH] Net device error logging
Content-Type: multipart/mixed;
 boundary="------------F15D387DE3C5F76E9E19C644"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------F15D387DE3C5F76E9E19C644
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

This proposal extends the concept of Linux 2.5's dev_* logging macros to
support network devices.  This feature is intended to simplify error-log
analysis by programs (such as health/configuration monitors) and by
ordinary people who need clearer error reporting.

Two patches are appended.  The first implements the feature described
here.  The second is provided by Scott Feldman, maintainer of the e1000
Ethernet driver, and demonstrates how he could modify that driver to
take advantage of this feature.

BACKGROUND: dev_* MACROS
The existing dev_* macros (dev_dbg, dev_info, dev_warn, dev_err,
dev_printk) are defined in linux/device.h in Linux 2.5.  When used in
place of printk, they enhance the standard printk message by prepending
the driver name and bus ID of the device in question.  These macros take
the usual printk args, plus a pointer to the relevant struct device.
The driver name and bus ID enable the log reader to find the device's
information in sysfs.

netdev_* MACROS
Alan Cox suggested that the dev_* macros could serve as examples for
logging macros in other parts of the kernel.  This proposal defines
analogous macros for network devices.  These new macros are netdev_dbg,
netdev_info, netdev_warn, netdev_err, and netdev_printk.  These macros
take the usual printk args, plus a pointer to the relevant struct
net_device.

The enhanced printk message includes the device's interface name (e.g.,
"eth0").  It also includes the driver name and bus ID of the underlying
device; this makes it easy to associate the message with the network
device's sysfs info.

For example, changing
	printk(KERN_ERR "The EEPROM Checksum Is Not Valid\n");
to
	netdev_err(netdev, "The EEPROM Checksum Is Not Valid\n");
changes the message from
	The EEPROM Checksum Is Not Valid
to something like
	eth0 e1000 40:0b.0: The EEPROM Checksum Is Not Valid
You could find out more about the indicated device by looking in the
directory /sysfs/bus/*/drivers/e1000/40:0b.0.

This proposal adds a new member, dev, to struct net_device that points
to the underlying struct device.  This pointer is typically set in the
driver's probe function.

For simplicity, the netdev_* macros assume that netdev (the net_device
arg) and netdev->name are non-null.  The latter is true as soon as
you call alloc_netdev() for the device.

Jim Keniston
IBM Linux Technology Center
-----
--------------F15D387DE3C5F76E9E19C644
Content-Type: text/plain; charset=us-ascii;
 name="netdev_printk-2.5.68.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="netdev_printk-2.5.68.patch"

diff -Naur linux.org/include/linux/netdevice.h linux.netdev_printk.patched/include/linux/netdevice.h
--- linux.org/include/linux/netdevice.h	Thu May  1 08:46:13 2003
+++ linux.netdev_printk.patched/include/linux/netdevice.h	Thu May  1 08:46:13 2003
@@ -28,7 +28,7 @@
 #include <linux/if.h>
 #include <linux/if_ether.h>
 #include <linux/if_packet.h>
-#include <linux/kobject.h>
+#include <linux/device.h>
 
 #include <asm/atomic.h>
 #include <asm/cache.h>
@@ -269,6 +269,7 @@
 	unsigned long		state;
 
 	struct net_device	*next;
+	struct device		*dev;		/* underlying device */
 	
 	/* The device initialization function. Called only once. */
 	int			(*init)(struct net_device *dev);
@@ -835,6 +836,32 @@
 extern void		dev_clear_fastroute(struct net_device *dev);
 #endif
 
+/* debugging and troubleshooting/diagnostic helpers. */
+/**
+ * netdev_printk() - Log message with interface name, driver name, bus ID.
+ * @level: severity level -- e.g., KERN_INFO
+ * @netdev: net_device pointer
+ * @format: as with printk
+ * @args: as with printk
+ */
+#define netdev_printk(level, netdev, format, arg...)	\
+	printk(level "%s %s %s: " format , (netdev)->name ,	\
+		((netdev)->dev ? (netdev)->dev->driver->name : "") ,	\
+		((netdev)->dev ? (netdev)->dev->bus_id : "") , ## arg)
+
+#ifdef DEBUG
+#define netdev_dbg(netdev, format, arg...)		\
+	netdev_printk(KERN_DEBUG , netdev , format , ## arg)
+#else
+#define netdev_dbg(netdev, format, arg...) do {} while (0)
+#endif
+
+#define netdev_err(netdev, format, arg...)		\
+	netdev_printk(KERN_ERR , netdev , format , ## arg)
+#define netdev_info(netdev, format, arg...)		\
+	netdev_printk(KERN_INFO , netdev , format , ## arg)
+#define netdev_warn(netdev, format, arg...)		\
+	netdev_printk(KERN_WARNING , netdev , format , ## arg)
 
 #endif /* __KERNEL__ */
 

--------------F15D387DE3C5F76E9E19C644
Content-Type: text/plain; charset=us-ascii;
 name="e1000-ev.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="e1000-ev.diff"

diff -Naurp linux-2.5.68/drivers/net/e1000/e1000.h linux-2.5.68/drivers/net/e1000.ev/e1000.h
--- linux-2.5.68/drivers/net/e1000/e1000.h	2003-04-19 19:48:49.000000000 -0700
+++ linux-2.5.68/drivers/net/e1000.ev/e1000.h	2003-04-27 00:25:59.000000000 -0700
@@ -80,14 +80,6 @@ struct e1000_adapter;
 
 #include "e1000_hw.h"
 
-#if DBG
-#define E1000_DBG(args...) printk(KERN_DEBUG "e1000: " args)
-#else
-#define E1000_DBG(args...)
-#endif
-
-#define E1000_ERR(args...) printk(KERN_ERR "e1000: " args)
-
 #define E1000_MAX_INTR 10
 
 /* Supported Rx Buffer Sizes */
diff -Naurp linux-2.5.68/drivers/net/e1000/e1000_main.c linux-2.5.68/drivers/net/e1000.ev/e1000_main.c
--- linux-2.5.68/drivers/net/e1000/e1000_main.c	2003-04-19 19:49:10.000000000 -0700
+++ linux-2.5.68/drivers/net/e1000.ev/e1000_main.c	2003-04-27 00:25:59.000000000 -0700
@@ -375,7 +375,8 @@ e1000_probe(struct pci_dev *pdev,
 		pci_using_dac = 1;
 	} else {
 		if((i = pci_set_dma_mask(pdev, PCI_DMA_32BIT))) {
-			E1000_ERR("No usable DMA configuration, aborting\n");
+			printk(KERN_ERR
+			      "e1000: No usable DMA configuration, aborting\n");
 			return i;
 		}
 		pci_using_dac = 0;
@@ -393,6 +394,7 @@ e1000_probe(struct pci_dev *pdev,
 	SET_MODULE_OWNER(netdev);
 
 	pci_set_drvdata(pdev, netdev);
+	netdev->dev = &pdev->dev;
 	adapter = netdev->priv;
 	adapter->netdev = netdev;
 	adapter->pdev = pdev;
@@ -465,7 +467,7 @@ e1000_probe(struct pci_dev *pdev,
 	/* make sure the EEPROM is good */
 
 	if(e1000_validate_eeprom_checksum(&adapter->hw) < 0) {
-		printk(KERN_ERR "The EEPROM Checksum Is Not Valid\n");
+		netdev_err(netdev, "The EEPROM Checksum Is Not Valid\n");
 		goto err_eeprom;
 	}
 
@@ -505,7 +507,7 @@ e1000_probe(struct pci_dev *pdev,
 	netif_carrier_off(netdev);
 	netif_stop_queue(netdev);
 
-	printk(KERN_INFO "%s: %s\n", netdev->name, adapter->id_string);
+	netdev_info(netdev, "%s\n", adapter->id_string);
 	e1000_check_options(adapter);
 
 	/* Initial Wake on LAN setting
@@ -607,7 +609,7 @@ e1000_sw_init(struct e1000_adapter *adap
 	/* identify the MAC */
 
 	if (e1000_set_mac_type(hw)) {
-		E1000_ERR("Unknown MAC Type\n");
+		printk(KERN_ERR "Unknown MAC Type\n");
 		return -1;
 	}
 
@@ -1360,9 +1362,9 @@ e1000_watchdog(unsigned long data)
 			                           &adapter->link_speed,
 			                           &adapter->link_duplex);
 
-			printk(KERN_INFO
-			       "e1000: %s NIC Link is Up %d Mbps %s\n",
-			       netdev->name, adapter->link_speed,
+			netdev_info(netdev,
+			       "e1000: NIC Link is Up %d Mbps %s\n",
+			       adapter->link_speed,
 			       adapter->link_duplex == FULL_DUPLEX ?
 			       "Full Duplex" : "Half Duplex");
 
@@ -1375,9 +1377,7 @@ e1000_watchdog(unsigned long data)
 		if(netif_carrier_ok(netdev)) {
 			adapter->link_speed = 0;
 			adapter->link_duplex = 0;
-			printk(KERN_INFO
-			       "e1000: %s NIC Link is Down\n",
-			       netdev->name);
+			netdev_info(netdev, "e1000: NIC Link is Down\n");
 			netif_carrier_off(netdev);
 			netif_stop_queue(netdev);
 			mod_timer(&adapter->phy_info_timer, jiffies + 2 * HZ);
@@ -1774,7 +1774,7 @@ e1000_change_mtu(struct net_device *netd
 
 	if((max_frame < MINIMUM_ETHERNET_FRAME_SIZE) ||
 	   (max_frame > MAX_JUMBO_FRAME_SIZE)) {
-		E1000_ERR("Invalid MTU setting\n");
+		printk(KERN_ERR "Invalid MTU setting\n");
 		return -EINVAL;
 	}
 
@@ -1782,7 +1782,7 @@ e1000_change_mtu(struct net_device *netd
 		adapter->rx_buffer_len = E1000_RXBUFFER_2048;
 
 	} else if(adapter->hw.mac_type < e1000_82543) {
-		E1000_ERR("Jumbo Frames not supported on 82542\n");
+		printk(KERN_ERR "Jumbo Frames not supported on 82542\n");
 		return -EINVAL;
 
 	} else if(max_frame <= E1000_RXBUFFER_4096) {
@@ -2149,7 +2149,8 @@ e1000_clean_rx_irq(struct e1000_adapter 
 
 			/* All receives must fit into a single buffer */
 
-			E1000_DBG("Receive packet consumed multiple buffers\n");
+			netdev_dbg(netdev,
+			         "Receive packet consumed multiple buffers\n");
 
 			dev_kfree_skb_irq(skb);
 			rx_desc->status = 0;
diff -Naurp linux-2.5.68/drivers/net/e1000/e1000_osdep.h linux-2.5.68/drivers/net/e1000.ev/e1000_osdep.h
--- linux-2.5.68/drivers/net/e1000/e1000_osdep.h	2003-04-19 19:48:55.000000000 -0700
+++ linux-2.5.68/drivers/net/e1000.ev/e1000_osdep.h	2003-04-27 00:43:43.000000000 -0700
@@ -60,7 +60,7 @@ typedef enum {
 } boolean_t;
 
 #define ASSERT(x)	if(!(x)) BUG()
-#define MSGOUT(S, A, B)	printk(KERN_DEBUG S "\n", A, B)
+#define MSGOUT(S, A, B)	printk(S "\n", A, B)
 
 #if DBG
 #define DEBUGOUT(S)		printk(KERN_DEBUG S "\n")
diff -Naurp linux-2.5.68/drivers/net/e1000/e1000_param.c linux-2.5.68/drivers/net/e1000.ev/e1000_param.c
--- linux-2.5.68/drivers/net/e1000/e1000_param.c	2003-04-19 19:50:29.000000000 -0700
+++ linux-2.5.68/drivers/net/e1000.ev/e1000_param.c	2003-04-27 00:25:59.000000000 -0700
@@ -244,7 +244,8 @@ struct e1000_option {
 };
 
 static int __devinit
-e1000_validate_option(int *value, struct e1000_option *opt)
+e1000_validate_option(int *value, struct e1000_option *opt,
+	struct net_device *netdev)
 {
 	if(*value == OPTION_UNSET) {
 		*value = opt->def;
@@ -255,16 +256,17 @@ e1000_validate_option(int *value, struct
 	case enable_option:
 		switch (*value) {
 		case OPTION_ENABLED:
-			printk(KERN_INFO "%s Enabled\n", opt->name);
+			netdev_info(netdev, "%s Enabled\n", opt->name);
 			return 0;
 		case OPTION_DISABLED:
-			printk(KERN_INFO "%s Disabled\n", opt->name);
+			netdev_info(netdev, "%s Disabled\n", opt->name);
 			return 0;
 		}
 		break;
 	case range_option:
 		if(*value >= opt->arg.r.min && *value <= opt->arg.r.max) {
-			printk(KERN_INFO "%s set to %i\n", opt->name, *value);
+			netdev_info(netdev,
+			            "%s set to %i\n", opt->name, *value);
 			return 0;
 		}
 		break;
@@ -276,7 +278,7 @@ e1000_validate_option(int *value, struct
 			ent = &opt->arg.l.p[i];
 			if(*value == ent->i) {
 				if(ent->str[0] != '\0')
-					printk(KERN_INFO "%s\n", ent->str);
+					netdev_info(netdev, "%s\n", ent->str);
 				return 0;
 			}
 		}
@@ -286,8 +288,8 @@ e1000_validate_option(int *value, struct
 		BUG();
 	}
 
-	printk(KERN_INFO "Invalid %s specified (%i) %s\n",
-	       opt->name, *value, opt->err);
+	netdev_info(netdev, "Invalid %s specified (%i) %s\n",
+	            opt->name, *value, opt->err);
 	*value = opt->def;
 	return -1;
 }
@@ -308,11 +310,12 @@ static void e1000_check_copper_options(s
 void __devinit
 e1000_check_options(struct e1000_adapter *adapter)
 {
+	struct net_device *netdev = adapter->netdev;
 	int bd = adapter->bd_number;
 	if(bd >= E1000_MAX_NIC) {
-		printk(KERN_NOTICE
-		       "Warning: no configuration for board #%i\n", bd);
-		printk(KERN_NOTICE "Using defaults for all values\n");
+		netdev_warn(netdev,
+		              "Warning: no configuration for board #%i\n", bd);
+		netdev_warn(netdev, "Using defaults for all values\n");
 		bd = E1000_MAX_NIC;
 	}
 
@@ -330,7 +333,7 @@ e1000_check_options(struct e1000_adapter
 			MAX_TXD : MAX_82544_TXD;
 
 		tx_ring->count = TxDescriptors[bd];
-		e1000_validate_option(&tx_ring->count, &opt);
+		e1000_validate_option(&tx_ring->count, &opt, netdev);
 		E1000_ROUNDUP(tx_ring->count, REQ_TX_DESCRIPTOR_MULTIPLE);
 	}
 	{ /* Receive Descriptor Count */
@@ -346,7 +349,7 @@ e1000_check_options(struct e1000_adapter
 		opt.arg.r.max = mac_type < e1000_82544 ? MAX_RXD : MAX_82544_RXD;
 
 		rx_ring->count = RxDescriptors[bd];
-		e1000_validate_option(&rx_ring->count, &opt);
+		e1000_validate_option(&rx_ring->count, &opt, netdev);
 		E1000_ROUNDUP(rx_ring->count, REQ_RX_DESCRIPTOR_MULTIPLE);
 	}
 	{ /* Checksum Offload Enable/Disable */
@@ -358,7 +361,7 @@ e1000_check_options(struct e1000_adapter
 		};
 
 		int rx_csum = XsumRX[bd];
-		e1000_validate_option(&rx_csum, &opt);
+		e1000_validate_option(&rx_csum, &opt, netdev);
 		adapter->rx_csum = rx_csum;
 	}
 	{ /* Flow Control */
@@ -380,7 +383,7 @@ e1000_check_options(struct e1000_adapter
 		};
 
 		int fc = FlowControl[bd];
-		e1000_validate_option(&fc, &opt);
+		e1000_validate_option(&fc, &opt, netdev);
 		adapter->hw.fc = adapter->hw.original_fc = fc;
 	}
 	{ /* Transmit Interrupt Delay */
@@ -394,7 +397,7 @@ e1000_check_options(struct e1000_adapter
 		};
 
 		adapter->tx_int_delay = TxIntDelay[bd];
-		e1000_validate_option(&adapter->tx_int_delay, &opt);
+		e1000_validate_option(&adapter->tx_int_delay, &opt, netdev);
 	}
 	{ /* Transmit Absolute Interrupt Delay */
 		struct e1000_option opt = {
@@ -407,7 +410,7 @@ e1000_check_options(struct e1000_adapter
 		};
 
 		adapter->tx_abs_int_delay = TxAbsIntDelay[bd];
-		e1000_validate_option(&adapter->tx_abs_int_delay, &opt);
+		e1000_validate_option(&adapter->tx_abs_int_delay, &opt, netdev);
 	}
 	{ /* Receive Interrupt Delay */
 		struct e1000_option opt = {
@@ -420,7 +423,7 @@ e1000_check_options(struct e1000_adapter
 		};
 
 		adapter->rx_int_delay = RxIntDelay[bd];
-		e1000_validate_option(&adapter->rx_int_delay, &opt);
+		e1000_validate_option(&adapter->rx_int_delay, &opt, netdev);
 	}
 	{ /* Receive Absolute Interrupt Delay */
 		struct e1000_option opt = {
@@ -433,7 +436,7 @@ e1000_check_options(struct e1000_adapter
 		};
 
 		adapter->rx_abs_int_delay = RxAbsIntDelay[bd];
-		e1000_validate_option(&adapter->rx_abs_int_delay, &opt);
+		e1000_validate_option(&adapter->rx_abs_int_delay, &opt, netdev);
 	}
 	{ /* Interrupt Throttling Rate */
 		struct e1000_option opt = {
@@ -447,12 +450,12 @@ e1000_check_options(struct e1000_adapter
 
 		adapter->itr = InterruptThrottleRate[bd];
 		if(adapter->itr == 0) {
-			printk(KERN_INFO "%s turned off\n", opt.name);
+			netdev_info(netdev, "%s turned off\n", opt.name);
 		} else if(adapter->itr == 1 || adapter->itr == -1) {
 			/* Dynamic mode */
 			adapter->itr = 1;
 		} else {
-			e1000_validate_option(&adapter->itr, &opt);
+			e1000_validate_option(&adapter->itr, &opt, netdev);
 		}
 	}
 
@@ -478,20 +481,24 @@ e1000_check_options(struct e1000_adapter
 static void __devinit
 e1000_check_fiber_options(struct e1000_adapter *adapter)
 {
+	struct net_device *netdev = adapter->netdev;
 	int bd = adapter->bd_number;
 	bd = bd > E1000_MAX_NIC ? E1000_MAX_NIC : bd;
 
 	if((Speed[bd] != OPTION_UNSET)) {
-		printk(KERN_INFO "Speed not valid for fiber adapters, "
-		       "parameter ignored\n");
+		netdev_info(netdev,
+		            "Speed not valid for fiber adapters, "
+		            "parameter ignored\n");
 	}
 	if((Duplex[bd] != OPTION_UNSET)) {
-		printk(KERN_INFO "Duplex not valid for fiber adapters, "
-		       "parameter ignored\n");
+		netdev_info(netdev,
+		            "Duplex not valid for fiber adapters, "
+		            "parameter ignored\n");
 	}
 	if((AutoNeg[bd] != OPTION_UNSET)) {
-		printk(KERN_INFO "AutoNeg not valid for fiber adapters, "
-		       "parameter ignored\n");
+		netdev_info(netdev,
+		            "AutoNeg not valid for fiber adapters, "
+		            "parameter ignored\n");
 	}
 }
 
@@ -505,6 +512,7 @@ e1000_check_fiber_options(struct e1000_a
 static void __devinit
 e1000_check_copper_options(struct e1000_adapter *adapter)
 {
+	struct net_device *netdev = adapter->netdev;
 	int speed, dplx;
 	int bd = adapter->bd_number;
 	bd = bd > E1000_MAX_NIC ? E1000_MAX_NIC : bd;
@@ -525,7 +533,7 @@ e1000_check_copper_options(struct e1000_
 		};
 
 		speed = Speed[bd];
-		e1000_validate_option(&speed, &opt);
+		e1000_validate_option(&speed, &opt, netdev);
 	}
 	{ /* Duplex */
 		struct e1000_opt_list dplx_list[] = {{           0, "" },
@@ -542,13 +550,13 @@ e1000_check_copper_options(struct e1000_
 		};
 
 		dplx = Duplex[bd];
-		e1000_validate_option(&dplx, &opt);
+		e1000_validate_option(&dplx, &opt, netdev);
 	}
 
 	if(AutoNeg[bd] != OPTION_UNSET && (speed != 0 || dplx != 0)) {
-		printk(KERN_INFO
-		       "AutoNeg specified along with Speed or Duplex, "
-		       "parameter ignored\n");
+		netdev_info(netdev,
+		            "AutoNeg specified along with Speed or Duplex, "
+		            "parameter ignored\n");
 		adapter->hw.autoneg_advertised = AUTONEG_ADV_DEFAULT;
 	} else { /* Autoneg */
 		struct e1000_opt_list an_list[] =
@@ -595,7 +603,7 @@ e1000_check_copper_options(struct e1000_
 		};
 
 		int an = AutoNeg[bd];
-		e1000_validate_option(&an, &opt);
+		e1000_validate_option(&an, &opt, netdev);
 		adapter->hw.autoneg_advertised = an;
 	}
 
@@ -603,78 +611,83 @@ e1000_check_copper_options(struct e1000_
 	case 0:
 		adapter->hw.autoneg = 1;
 		if(Speed[bd] != OPTION_UNSET || Duplex[bd] != OPTION_UNSET)
-			printk(KERN_INFO
+			netdev_info(netdev,
 			       "Speed and duplex autonegotiation enabled\n");
 		break;
 	case HALF_DUPLEX:
-		printk(KERN_INFO "Half Duplex specified without Speed\n");
-		printk(KERN_INFO "Using Autonegotiation at Half Duplex only\n");
+		netdev_info(netdev, "Half Duplex specified without Speed\n");
+		netdev_info(netdev,
+		            "Using Autonegotiation at Half Duplex only\n");
 		adapter->hw.autoneg = 1;
 		adapter->hw.autoneg_advertised = ADVERTISE_10_HALF |
 		                                 ADVERTISE_100_HALF;
 		break;
 	case FULL_DUPLEX:
-		printk(KERN_INFO "Full Duplex specified without Speed\n");
-		printk(KERN_INFO "Using Autonegotiation at Full Duplex only\n");
+		netdev_info(netdev, "Full Duplex specified without Speed\n");
+		netdev_info(netdev,
+		            "Using Autonegotiation at Full Duplex only\n");
 		adapter->hw.autoneg = 1;
 		adapter->hw.autoneg_advertised = ADVERTISE_10_FULL |
 		                                 ADVERTISE_100_FULL |
 		                                 ADVERTISE_1000_FULL;
 		break;
 	case SPEED_10:
-		printk(KERN_INFO "10 Mbps Speed specified without Duplex\n");
-		printk(KERN_INFO "Using Autonegotiation at 10 Mbps only\n");
+		netdev_info(netdev, "10 Mbps Speed specified without Duplex\n");
+		netdev_info(netdev, "Using Autonegotiation at 10 Mbps only\n");
 		adapter->hw.autoneg = 1;
 		adapter->hw.autoneg_advertised = ADVERTISE_10_HALF |
 		                                 ADVERTISE_10_FULL;
 		break;
 	case SPEED_10 + HALF_DUPLEX:
-		printk(KERN_INFO "Forcing to 10 Mbps Half Duplex\n");
+		netdev_info(netdev, "Forcing to 10 Mbps Half Duplex\n");
 		adapter->hw.autoneg = 0;
 		adapter->hw.forced_speed_duplex = e1000_10_half;
 		adapter->hw.autoneg_advertised = 0;
 		break;
 	case SPEED_10 + FULL_DUPLEX:
-		printk(KERN_INFO "Forcing to 10 Mbps Full Duplex\n");
+		netdev_info(netdev, "Forcing to 10 Mbps Full Duplex\n");
 		adapter->hw.autoneg = 0;
 		adapter->hw.forced_speed_duplex = e1000_10_full;
 		adapter->hw.autoneg_advertised = 0;
 		break;
 	case SPEED_100:
-		printk(KERN_INFO "100 Mbps Speed specified without Duplex\n");
-		printk(KERN_INFO "Using Autonegotiation at 100 Mbps only\n");
+		netdev_info(netdev,
+		            "100 Mbps Speed specified without Duplex\n");
+		netdev_info(netdev, "Using Autonegotiation at 100 Mbps only\n");
 		adapter->hw.autoneg = 1;
 		adapter->hw.autoneg_advertised = ADVERTISE_100_HALF |
 		                                 ADVERTISE_100_FULL;
 		break;
 	case SPEED_100 + HALF_DUPLEX:
-		printk(KERN_INFO "Forcing to 100 Mbps Half Duplex\n");
+		netdev_info(netdev, "Forcing to 100 Mbps Half Duplex\n");
 		adapter->hw.autoneg = 0;
 		adapter->hw.forced_speed_duplex = e1000_100_half;
 		adapter->hw.autoneg_advertised = 0;
 		break;
 	case SPEED_100 + FULL_DUPLEX:
-		printk(KERN_INFO "Forcing to 100 Mbps Full Duplex\n");
+		netdev_info(netdev, "Forcing to 100 Mbps Full Duplex\n");
 		adapter->hw.autoneg = 0;
 		adapter->hw.forced_speed_duplex = e1000_100_full;
 		adapter->hw.autoneg_advertised = 0;
 		break;
 	case SPEED_1000:
-		printk(KERN_INFO "1000 Mbps Speed specified without Duplex\n");
-		printk(KERN_INFO
+		netdev_info(netdev,
+		            "1000 Mbps Speed specified without Duplex\n");
+		netdev_info(netdev,
 		       "Using Autonegotiation at 1000 Mbps Full Duplex only\n");
 		adapter->hw.autoneg = 1;
 		adapter->hw.autoneg_advertised = ADVERTISE_1000_FULL;
 		break;
 	case SPEED_1000 + HALF_DUPLEX:
-		printk(KERN_INFO "Half Duplex is not supported at 1000 Mbps\n");
-		printk(KERN_INFO
+		netdev_info(netdev,
+		            "Half Duplex is not supported at 1000 Mbps\n");
+		netdev_info(netdev,
 		       "Using Autonegotiation at 1000 Mbps Full Duplex only\n");
 		adapter->hw.autoneg = 1;
 		adapter->hw.autoneg_advertised = ADVERTISE_1000_FULL;
 		break;
 	case SPEED_1000 + FULL_DUPLEX:
-		printk(KERN_INFO
+		netdev_info(netdev,
 		       "Using Autonegotiation at 1000 Mbps Full Duplex only\n");
 		adapter->hw.autoneg = 1;
 		adapter->hw.autoneg_advertised = ADVERTISE_1000_FULL;
@@ -685,7 +698,8 @@ e1000_check_copper_options(struct e1000_
 
 	/* Speed, AutoNeg and MDI/MDI-X must all play nice */
 	if (e1000_validate_mdi_setting(&(adapter->hw)) < 0) {
-		printk(KERN_INFO "Speed, AutoNeg and MDI-X specifications are "
+		netdev_info(netdev,
+		            "Speed, AutoNeg and MDI-X specifications are "
 		       "incompatible. Setting MDI-X to a compatible value.\n");
 	}
 }

--------------F15D387DE3C5F76E9E19C644--

