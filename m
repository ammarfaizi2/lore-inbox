Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262335AbTHYVqt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Aug 2003 17:46:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262246AbTHYVqc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Aug 2003 17:46:32 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:58086 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S262319AbTHYVpa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Aug 2003 17:45:30 -0400
Message-ID: <3F4A8274.CC498C22@us.ibm.com>
Date: Mon, 25 Aug 2003 14:41:08 -0700
From: Jim Keniston <jkenisto@us.ibm.com>
X-Mailer: Mozilla 4.75 [en] (WinNT; U)
X-Accept-Language: en
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>, netdev <netdev@oss.sgi.com>,
       Jeff Garzik <jgarzik@pobox.com>,
       "Feldman, Scott" <scott.feldman@intel.com>,
       Larry Kessler <kessler@us.ibm.com>, Greg KH <greg@kroah.com>,
       Randy Dunlap <rddunlap@osdl.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Andrew Morton <akpm@osdl.org>, jkenisto <jkenisto@us.ibm.com>
Subject: Subject: [PATCH 3/4] Net device error logging, revised (e1000)
References: <3F4A8027.6FE3F594@us.ibm.com>
Content-Type: multipart/mixed;
 boundary="------------9E478A7045D2DC2C7D0081CA"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------9E478A7045D2DC2C7D0081CA
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Here's a patch to modify the v2.6.0-test4 e1000 driver to use netdev_*
macros and support verbosity control via the NETIF_MSG_* message levels.

Jim Keniston
IBM Linux Technology Center
--------------9E478A7045D2DC2C7D0081CA
Content-Type: text/plain; charset=us-ascii;
 name="e1000-2.6.0-test4.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="e1000-2.6.0-test4.patch"

diff -Naur linux.org/drivers/net/e1000/e1000.h linux.e1000.patched/drivers/net/e1000/e1000.h
--- linux.org/drivers/net/e1000/e1000.h	Mon Aug 25 13:29:38 2003
+++ linux.e1000.patched/drivers/net/e1000/e1000.h	Mon Aug 25 13:29:38 2003
@@ -35,6 +35,7 @@
 #include <linux/stddef.h>
 #include <linux/config.h>
 #include <linux/module.h>
+#include <linux/moduleparam.h>
 #include <linux/types.h>
 #include <asm/byteorder.h>
 #include <linux/init.h>
@@ -81,14 +82,6 @@
 struct e1000_adapter;
 
 #include "e1000_hw.h"
-
-#if DBG
-#define E1000_DBG(args...) printk(KERN_DEBUG "e1000: " args)
-#else
-#define E1000_DBG(args...)
-#endif
-
-#define E1000_ERR(args...) printk(KERN_ERR "e1000: " args)
 
 #define E1000_MAX_INTR 10
 
diff -Naur linux.org/drivers/net/e1000/e1000_ethtool.c linux.e1000.patched/drivers/net/e1000/e1000_ethtool.c
--- linux.org/drivers/net/e1000/e1000_ethtool.c	Mon Aug 25 13:29:38 2003
+++ linux.e1000.patched/drivers/net/e1000/e1000_ethtool.c	Mon Aug 25 13:29:38 2003
@@ -1576,6 +1576,20 @@
 		return 0;
 	}
 #endif
+	case ETHTOOL_GMSGLVL: {
+		struct ethtool_value edata = {ETHTOOL_GMSGLVL};
+		edata.data = netdev->msg_enable;
+		if (copy_to_user(addr, &edata, sizeof(edata)))
+			return -EFAULT;
+		return 0;
+	}
+	case ETHTOOL_SMSGLVL: {
+		struct ethtool_value edata;
+		if (copy_from_user(&edata, addr, sizeof(edata)))
+			return -EFAULT;
+		netdev->msg_enable = edata.data;
+		return 0;
+	}
 	default:
 		return -EOPNOTSUPP;
 	}
diff -Naur linux.org/drivers/net/e1000/e1000_main.c linux.e1000.patched/drivers/net/e1000/e1000_main.c
--- linux.org/drivers/net/e1000/e1000_main.c	Mon Aug 25 13:29:38 2003
+++ linux.e1000.patched/drivers/net/e1000/e1000_main.c	Mon Aug 25 13:29:38 2003
@@ -178,9 +178,14 @@
 #endif
 };
 
+static int debug = -1;
+#define E1000_DFLT_MSGLVL (NETIF_MSG_DRV | NETIF_MSG_PROBE | NETIF_MSG_LINK)
+
 MODULE_AUTHOR("Intel Corporation, <linux.nics@intel.com>");
 MODULE_DESCRIPTION("Intel(R) PRO/1000 Network Driver");
 MODULE_LICENSE("GPL");
+module_param(debug, int, 0);
+MODULE_PARM_DESC(debug, "e1000 debug level: 0 (quiet) to 15 (verbose)");
 
 /**
  * e1000_init_module - Driver Registration Routine
@@ -337,7 +342,8 @@
 		pci_using_dac = 1;
 	} else {
 		if((i = pci_set_dma_mask(pdev, PCI_DMA_32BIT))) {
-			E1000_ERR("No usable DMA configuration, aborting\n");
+			dev_err(&pdev->dev,
+			      "No usable DMA configuration, aborting\n");
 			return i;
 		}
 		pci_using_dac = 0;
@@ -361,6 +367,15 @@
 	adapter->pdev = pdev;
 	adapter->hw.back = adapter;
 
+	if (debug < 0) {
+		netdev->msg_enable = E1000_DFLT_MSGLVL;
+	} else if (debug >= 8 * sizeof(int)) {
+		/* All levels enabled */
+		netdev->msg_enable = -1;
+	} else {
+		netdev->msg_enable = (1 << debug) - 1;
+	}
+
 	mmio_start = pci_resource_start(pdev, BAR_0);
 	mmio_len = pci_resource_len(pdev, BAR_0);
 
@@ -429,7 +444,7 @@
 	/* make sure the EEPROM is good */
 
 	if(e1000_validate_eeprom_checksum(&adapter->hw) < 0) {
-		printk(KERN_ERR "The EEPROM Checksum Is Not Valid\n");
+		netdev_err(netdev,, "The EEPROM Checksum Is Not Valid\n");
 		goto err_eeprom;
 	}
 
@@ -467,8 +482,7 @@
 	netif_carrier_off(netdev);
 	netif_stop_queue(netdev);
 
-	printk(KERN_INFO "%s: Intel(R) PRO/1000 Network Connection\n",
-	       netdev->name);
+	netdev_info(netdev, PROBE, "Intel(R) PRO/1000 Network Connection\n");
 	e1000_check_options(adapter);
 
 	/* Initial Wake on LAN setting
@@ -569,7 +583,7 @@
 	/* identify the MAC */
 
 	if (e1000_set_mac_type(hw)) {
-		E1000_ERR("Unknown MAC Type\n");
+		netdev_err(netdev,, "Unknown MAC Type\n");
 		return -1;
 	}
 
@@ -1329,9 +1343,8 @@
 			                           &adapter->link_speed,
 			                           &adapter->link_duplex);
 
-			printk(KERN_INFO
-			       "e1000: %s NIC Link is Up %d Mbps %s\n",
-			       netdev->name, adapter->link_speed,
+			netdev_info(netdev, LINK, "NIC Link is Up %d Mbps %s\n",
+			       adapter->link_speed,
 			       adapter->link_duplex == FULL_DUPLEX ?
 			       "Full Duplex" : "Half Duplex");
 
@@ -1344,9 +1357,7 @@
 		if(netif_carrier_ok(netdev)) {
 			adapter->link_speed = 0;
 			adapter->link_duplex = 0;
-			printk(KERN_INFO
-			       "e1000: %s NIC Link is Down\n",
-			       netdev->name);
+			netdev_info(netdev, LINK, "NIC Link is Down\n");
 			netif_carrier_off(netdev);
 			netif_stop_queue(netdev);
 			mod_timer(&adapter->phy_info_timer, jiffies + 2 * HZ);
@@ -1758,7 +1769,7 @@
 
 	if((max_frame < MINIMUM_ETHERNET_FRAME_SIZE) ||
 	   (max_frame > MAX_JUMBO_FRAME_SIZE)) {
-		E1000_ERR("Invalid MTU setting\n");
+		netdev_err(netdev,, "Invalid MTU setting\n");
 		return -EINVAL;
 	}
 
@@ -1766,7 +1777,7 @@
 		adapter->rx_buffer_len = E1000_RXBUFFER_2048;
 
 	} else if(adapter->hw.mac_type < e1000_82543) {
-		E1000_ERR("Jumbo Frames not supported on 82542\n");
+		netdev_err(netdev,, "Jumbo Frames not supported on 82542\n");
 		return -EINVAL;
 
 	} else if(max_frame <= E1000_RXBUFFER_4096) {
@@ -2147,7 +2158,8 @@
 
 			/* All receives must fit into a single buffer */
 
-			E1000_DBG("Receive packet consumed multiple buffers\n");
+			netdev_dbg(netdev, RX_ERR,
+			         "Receive packet consumed multiple buffers\n");
 
 			dev_kfree_skb_irq(skb);
 			rx_desc->status = 0;
diff -Naur linux.org/drivers/net/e1000/e1000_param.c linux.e1000.patched/drivers/net/e1000/e1000_param.c
--- linux.org/drivers/net/e1000/e1000_param.c	Mon Aug 25 13:29:38 2003
+++ linux.e1000.patched/drivers/net/e1000/e1000_param.c	Mon Aug 25 13:29:38 2003
@@ -244,7 +244,8 @@
 };
 
 static int __devinit
-e1000_validate_option(int *value, struct e1000_option *opt)
+e1000_validate_option(int *value, struct e1000_option *opt,
+	struct net_device *netdev)
 {
 	if(*value == OPTION_UNSET) {
 		*value = opt->def;
@@ -255,16 +256,17 @@
 	case enable_option:
 		switch (*value) {
 		case OPTION_ENABLED:
-			printk(KERN_INFO "%s Enabled\n", opt->name);
+			netdev_info(netdev, PROBE, "%s Enabled\n", opt->name);
 			return 0;
 		case OPTION_DISABLED:
-			printk(KERN_INFO "%s Disabled\n", opt->name);
+			netdev_info(netdev, PROBE, "%s Disabled\n", opt->name);
 			return 0;
 		}
 		break;
 	case range_option:
 		if(*value >= opt->arg.r.min && *value <= opt->arg.r.max) {
-			printk(KERN_INFO "%s set to %i\n", opt->name, *value);
+			netdev_info(netdev, PROBE,
+			            "%s set to %i\n", opt->name, *value);
 			return 0;
 		}
 		break;
@@ -276,7 +278,8 @@
 			ent = &opt->arg.l.p[i];
 			if(*value == ent->i) {
 				if(ent->str[0] != '\0')
-					printk(KERN_INFO "%s\n", ent->str);
+					netdev_info(netdev, PROBE, "%s\n",
+						ent->str);
 				return 0;
 			}
 		}
@@ -286,8 +289,8 @@
 		BUG();
 	}
 
-	printk(KERN_INFO "Invalid %s specified (%i) %s\n",
-	       opt->name, *value, opt->err);
+	netdev_info(netdev,, "Invalid %s specified (%i) %s\n",
+	            opt->name, *value, opt->err);
 	*value = opt->def;
 	return -1;
 }
@@ -308,11 +311,12 @@
 void __devinit
 e1000_check_options(struct e1000_adapter *adapter)
 {
+	struct net_device *netdev = adapter->netdev;
 	int bd = adapter->bd_number;
 	if(bd >= E1000_MAX_NIC) {
-		printk(KERN_NOTICE
-		       "Warning: no configuration for board #%i\n", bd);
-		printk(KERN_NOTICE "Using defaults for all values\n");
+		netdev_warn(netdev, PROBE,
+			"Warning: no configuration for board #%i.  "
+			"Using defaults for all values\n", bd);
 		bd = E1000_MAX_NIC;
 	}
 
@@ -330,7 +334,7 @@
 			MAX_TXD : MAX_82544_TXD;
 
 		tx_ring->count = TxDescriptors[bd];
-		e1000_validate_option(&tx_ring->count, &opt);
+		e1000_validate_option(&tx_ring->count, &opt, netdev);
 		E1000_ROUNDUP(tx_ring->count, REQ_TX_DESCRIPTOR_MULTIPLE);
 	}
 	{ /* Receive Descriptor Count */
@@ -346,7 +350,7 @@
 		opt.arg.r.max = mac_type < e1000_82544 ? MAX_RXD : MAX_82544_RXD;
 
 		rx_ring->count = RxDescriptors[bd];
-		e1000_validate_option(&rx_ring->count, &opt);
+		e1000_validate_option(&rx_ring->count, &opt, netdev);
 		E1000_ROUNDUP(rx_ring->count, REQ_RX_DESCRIPTOR_MULTIPLE);
 	}
 	{ /* Checksum Offload Enable/Disable */
@@ -358,7 +362,7 @@
 		};
 
 		int rx_csum = XsumRX[bd];
-		e1000_validate_option(&rx_csum, &opt);
+		e1000_validate_option(&rx_csum, &opt, netdev);
 		adapter->rx_csum = rx_csum;
 	}
 	{ /* Flow Control */
@@ -380,7 +384,7 @@
 		};
 
 		int fc = FlowControl[bd];
-		e1000_validate_option(&fc, &opt);
+		e1000_validate_option(&fc, &opt, netdev);
 		adapter->hw.fc = adapter->hw.original_fc = fc;
 	}
 	{ /* Transmit Interrupt Delay */
@@ -394,7 +398,7 @@
 		};
 
 		adapter->tx_int_delay = TxIntDelay[bd];
-		e1000_validate_option(&adapter->tx_int_delay, &opt);
+		e1000_validate_option(&adapter->tx_int_delay, &opt, netdev);
 	}
 	{ /* Transmit Absolute Interrupt Delay */
 		struct e1000_option opt = {
@@ -407,7 +411,7 @@
 		};
 
 		adapter->tx_abs_int_delay = TxAbsIntDelay[bd];
-		e1000_validate_option(&adapter->tx_abs_int_delay, &opt);
+		e1000_validate_option(&adapter->tx_abs_int_delay, &opt, netdev);
 	}
 	{ /* Receive Interrupt Delay */
 		struct e1000_option opt = {
@@ -420,7 +424,7 @@
 		};
 
 		adapter->rx_int_delay = RxIntDelay[bd];
-		e1000_validate_option(&adapter->rx_int_delay, &opt);
+		e1000_validate_option(&adapter->rx_int_delay, &opt, netdev);
 	}
 	{ /* Receive Absolute Interrupt Delay */
 		struct e1000_option opt = {
@@ -433,7 +437,7 @@
 		};
 
 		adapter->rx_abs_int_delay = RxAbsIntDelay[bd];
-		e1000_validate_option(&adapter->rx_abs_int_delay, &opt);
+		e1000_validate_option(&adapter->rx_abs_int_delay, &opt, netdev);
 	}
 	{ /* Interrupt Throttling Rate */
 		struct e1000_option opt = {
@@ -447,12 +451,12 @@
 
 		adapter->itr = InterruptThrottleRate[bd];
 		if(adapter->itr == 0) {
-			printk(KERN_INFO "%s turned off\n", opt.name);
+			netdev_info(netdev, PROBE, "%s turned off\n", opt.name);
 		} else if(adapter->itr == 1 || adapter->itr == -1) {
 			/* Dynamic mode */
 			adapter->itr = 1;
 		} else {
-			e1000_validate_option(&adapter->itr, &opt);
+			e1000_validate_option(&adapter->itr, &opt, netdev);
 		}
 	}
 
@@ -478,20 +482,24 @@
 static void __devinit
 e1000_check_fiber_options(struct e1000_adapter *adapter)
 {
+	struct net_device *netdev = adapter->netdev;
 	int bd = adapter->bd_number;
 	bd = bd > E1000_MAX_NIC ? E1000_MAX_NIC : bd;
 
 	if((Speed[bd] != OPTION_UNSET)) {
-		printk(KERN_INFO "Speed not valid for fiber adapters, "
-		       "parameter ignored\n");
+		netdev_info(netdev, PROBE,
+		            "Speed not valid for fiber adapters, "
+		            "parameter ignored\n");
 	}
 	if((Duplex[bd] != OPTION_UNSET)) {
-		printk(KERN_INFO "Duplex not valid for fiber adapters, "
-		       "parameter ignored\n");
+		netdev_info(netdev, PROBE,
+		            "Duplex not valid for fiber adapters, "
+		            "parameter ignored\n");
 	}
 	if((AutoNeg[bd] != OPTION_UNSET)) {
-		printk(KERN_INFO "AutoNeg not valid for fiber adapters, "
-		       "parameter ignored\n");
+		netdev_info(netdev, PROBE,
+		            "AutoNeg not valid for fiber adapters, "
+		            "parameter ignored\n");
 	}
 }
 
@@ -505,6 +513,7 @@
 static void __devinit
 e1000_check_copper_options(struct e1000_adapter *adapter)
 {
+	struct net_device *netdev = adapter->netdev;
 	int speed, dplx;
 	int bd = adapter->bd_number;
 	bd = bd > E1000_MAX_NIC ? E1000_MAX_NIC : bd;
@@ -525,7 +534,7 @@
 		};
 
 		speed = Speed[bd];
-		e1000_validate_option(&speed, &opt);
+		e1000_validate_option(&speed, &opt, netdev);
 	}
 	{ /* Duplex */
 		struct e1000_opt_list dplx_list[] = {{           0, "" },
@@ -542,13 +551,13 @@
 		};
 
 		dplx = Duplex[bd];
-		e1000_validate_option(&dplx, &opt);
+		e1000_validate_option(&dplx, &opt, netdev);
 	}
 
 	if(AutoNeg[bd] != OPTION_UNSET && (speed != 0 || dplx != 0)) {
-		printk(KERN_INFO
-		       "AutoNeg specified along with Speed or Duplex, "
-		       "parameter ignored\n");
+		netdev_info(netdev, PROBE,
+		            "AutoNeg specified along with Speed or Duplex, "
+		            "parameter ignored\n");
 		adapter->hw.autoneg_advertised = AUTONEG_ADV_DEFAULT;
 	} else { /* Autoneg */
 		struct e1000_opt_list an_list[] =
@@ -595,7 +604,7 @@
 		};
 
 		int an = AutoNeg[bd];
-		e1000_validate_option(&an, &opt);
+		e1000_validate_option(&an, &opt, netdev);
 		adapter->hw.autoneg_advertised = an;
 	}
 
@@ -603,78 +612,82 @@
 	case 0:
 		adapter->hw.autoneg = 1;
 		if(Speed[bd] != OPTION_UNSET || Duplex[bd] != OPTION_UNSET)
-			printk(KERN_INFO
+			netdev_info(netdev, PROBE,
 			       "Speed and duplex autonegotiation enabled\n");
 		break;
 	case HALF_DUPLEX:
-		printk(KERN_INFO "Half Duplex specified without Speed\n");
-		printk(KERN_INFO "Using Autonegotiation at Half Duplex only\n");
+		netdev_info(netdev, PROBE,
+			"Half Duplex specified without Speed.  "
+			"Using Autonegotiation at Half Duplex only\n");
 		adapter->hw.autoneg = 1;
 		adapter->hw.autoneg_advertised = ADVERTISE_10_HALF |
 		                                 ADVERTISE_100_HALF;
 		break;
 	case FULL_DUPLEX:
-		printk(KERN_INFO "Full Duplex specified without Speed\n");
-		printk(KERN_INFO "Using Autonegotiation at Full Duplex only\n");
+		netdev_info(netdev, PROBE,
+			"Full Duplex specified without Speed.  "
+			"Using Autonegotiation at Full Duplex only\n");
 		adapter->hw.autoneg = 1;
 		adapter->hw.autoneg_advertised = ADVERTISE_10_FULL |
 		                                 ADVERTISE_100_FULL |
 		                                 ADVERTISE_1000_FULL;
 		break;
 	case SPEED_10:
-		printk(KERN_INFO "10 Mbps Speed specified without Duplex\n");
-		printk(KERN_INFO "Using Autonegotiation at 10 Mbps only\n");
+		netdev_info(netdev, PROBE,
+			"10 Mbps Speed specified without Duplex.  "
+			"Using Autonegotiation at 10 Mbps only\n");
 		adapter->hw.autoneg = 1;
 		adapter->hw.autoneg_advertised = ADVERTISE_10_HALF |
 		                                 ADVERTISE_10_FULL;
 		break;
 	case SPEED_10 + HALF_DUPLEX:
-		printk(KERN_INFO "Forcing to 10 Mbps Half Duplex\n");
+		netdev_info(netdev, PROBE, "Forcing to 10 Mbps Half Duplex\n");
 		adapter->hw.autoneg = 0;
 		adapter->hw.forced_speed_duplex = e1000_10_half;
 		adapter->hw.autoneg_advertised = 0;
 		break;
 	case SPEED_10 + FULL_DUPLEX:
-		printk(KERN_INFO "Forcing to 10 Mbps Full Duplex\n");
+		netdev_info(netdev, PROBE, "Forcing to 10 Mbps Full Duplex\n");
 		adapter->hw.autoneg = 0;
 		adapter->hw.forced_speed_duplex = e1000_10_full;
 		adapter->hw.autoneg_advertised = 0;
 		break;
 	case SPEED_100:
-		printk(KERN_INFO "100 Mbps Speed specified without Duplex\n");
-		printk(KERN_INFO "Using Autonegotiation at 100 Mbps only\n");
+		netdev_info(netdev, PROBE,
+			"100 Mbps Speed specified without Duplex.  "
+			"Using Autonegotiation at 100 Mbps only\n");
 		adapter->hw.autoneg = 1;
 		adapter->hw.autoneg_advertised = ADVERTISE_100_HALF |
 		                                 ADVERTISE_100_FULL;
 		break;
 	case SPEED_100 + HALF_DUPLEX:
-		printk(KERN_INFO "Forcing to 100 Mbps Half Duplex\n");
+		netdev_info(netdev, PROBE, "Forcing to 100 Mbps Half Duplex\n");
 		adapter->hw.autoneg = 0;
 		adapter->hw.forced_speed_duplex = e1000_100_half;
 		adapter->hw.autoneg_advertised = 0;
 		break;
 	case SPEED_100 + FULL_DUPLEX:
-		printk(KERN_INFO "Forcing to 100 Mbps Full Duplex\n");
+		netdev_info(netdev, PROBE, "Forcing to 100 Mbps Full Duplex\n");
 		adapter->hw.autoneg = 0;
 		adapter->hw.forced_speed_duplex = e1000_100_full;
 		adapter->hw.autoneg_advertised = 0;
 		break;
 	case SPEED_1000:
-		printk(KERN_INFO "1000 Mbps Speed specified without Duplex\n");
-		printk(KERN_INFO
-		       "Using Autonegotiation at 1000 Mbps Full Duplex only\n");
+		netdev_info(netdev, PROBE,
+			"1000 Mbps Speed specified without Duplex.  "
+			"Using Autonegotiation at 1000 Mbps Full Duplex only\n");
 		adapter->hw.autoneg = 1;
 		adapter->hw.autoneg_advertised = ADVERTISE_1000_FULL;
 		break;
 	case SPEED_1000 + HALF_DUPLEX:
-		printk(KERN_INFO "Half Duplex is not supported at 1000 Mbps\n");
-		printk(KERN_INFO
-		       "Using Autonegotiation at 1000 Mbps Full Duplex only\n");
+		netdev_info(netdev, PROBE,
+			"Half Duplex is not supported at 1000 Mbps.  "
+			"Using Autonegotiation at 1000 Mbps Full Duplex only\n");
 		adapter->hw.autoneg = 1;
 		adapter->hw.autoneg_advertised = ADVERTISE_1000_FULL;
 		break;
 	case SPEED_1000 + FULL_DUPLEX:
-		printk(KERN_INFO
+		netdev_info(netdev, PROBE,
 		       "Using Autonegotiation at 1000 Mbps Full Duplex only\n");
 		adapter->hw.autoneg = 1;
 		adapter->hw.autoneg_advertised = ADVERTISE_1000_FULL;
@@ -685,8 +698,9 @@
 
 	/* Speed, AutoNeg and MDI/MDI-X must all play nice */
 	if (e1000_validate_mdi_setting(&(adapter->hw)) < 0) {
-		printk(KERN_INFO "Speed, AutoNeg and MDI-X specifications are "
-		       "incompatible. Setting MDI-X to a compatible value.\n");
+		netdev_info(netdev, PROBE,
+			"Speed, AutoNeg and MDI-X specifications are "
+			"incompatible. Setting MDI-X to a compatible value.\n");
 	}
 }
 

--------------9E478A7045D2DC2C7D0081CA--

