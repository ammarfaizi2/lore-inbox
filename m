Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262280AbTHYVmm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Aug 2003 17:42:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262281AbTHYVmm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Aug 2003 17:42:42 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:37254 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S262280AbTHYVmS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Aug 2003 17:42:18 -0400
Message-ID: <3F4A8217.33647992@us.ibm.com>
Date: Mon, 25 Aug 2003 14:39:35 -0700
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
Subject: Subject: [PATCH 2/4] Net device error logging, revised (e100)
References: <3F4A8027.6FE3F594@us.ibm.com>
Content-Type: multipart/mixed;
 boundary="------------09E8359C42A09191C013F7B9"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------09E8359C42A09191C013F7B9
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Here's a patch to modify the v2.6.0-test4 e100 driver to use netdev_*
macros and support verbosity control via the NETIF_MSG_* message levels.

Jim Keniston
IBM Linux Technology Center
--------------09E8359C42A09191C013F7B9
Content-Type: text/plain; charset=us-ascii;
 name="e100-2.6.0-test4.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="e100-2.6.0-test4.patch"

diff -Naur linux.org/drivers/net/e100/e100_config.c linux.e100.patched/drivers/net/e100/e100_config.c
--- linux.org/drivers/net/e100/e100_config.c	Mon Aug 25 13:29:38 2003
+++ linux.e100.patched/drivers/net/e100/e100_config.c	Mon Aug 25 13:29:38 2003
@@ -565,7 +565,8 @@
 		config_byte = CB_CFIG_LOOPBACK_EXTERNAL;
 		break;
 	default:
-		printk(KERN_NOTICE "e100: e100_config_loopback_mode: "
+		netdev_printk(KERN_NOTICE, bdp->device,,
+		       "e100_config_loopback_mode: "
 		       "Invalid argument 'mode': %d\n", mode);
 		goto exit;
 	}
diff -Naur linux.org/drivers/net/e100/e100_main.c linux.e100.patched/drivers/net/e100/e100_main.c
--- linux.org/drivers/net/e100/e100_main.c	Mon Aug 25 13:29:38 2003
+++ linux.e100.patched/drivers/net/e100/e100_main.c	Mon Aug 25 13:29:38 2003
@@ -78,6 +78,7 @@
 #include <net/checksum.h>
 #include <linux/tcp.h>
 #include <linux/udp.h>
+#include <linux/moduleparam.h>
 #include "e100.h"
 #include "e100_ucode.h"
 #include "e100_config.h"
@@ -215,12 +216,19 @@
 static void e100_dump_stats_cntrs(struct e100_private *);
 
 static void e100_check_options(int board, struct e100_private *bdp);
-static void e100_set_int_option(int *, int, int, int, int, char *);
+static void e100_set_int_option(struct e100_private *bdp, int *,
+				int, int, int, int, char *);
 static void e100_set_bool_option(struct e100_private *bdp, int, u32, int,
 				 char *);
 unsigned char e100_wait_exec_cmplx(struct e100_private *, u32, u8, u8);
 void e100_exec_cmplx(struct e100_private *, u32, u8);
 
+static int debug = -1;
+#define E100_DFLT_MSGLVL (NETIF_MSG_DRV | NETIF_MSG_PROBE | NETIF_MSG_LINK)
+
+module_param(debug, int, 0);
+MODULE_PARM_DESC(debug, "e100 debug level: 0 (quiet) to 15 (verbose)");
+
 /**
  * e100_get_rx_struct - retrieve cell to hold skb buff from the pool
  * @bdp: atapter's private data struct
@@ -433,15 +441,12 @@
 e100_wait_exec_simple(struct e100_private *bdp, u8 scb_cmd_low)
 {
 	if (!e100_wait_scb(bdp)) {
-		printk(KERN_DEBUG "e100: %s: e100_wait_exec_simple: failed\n",
-		       bdp->device->name);
+		netdev_dbg(bdp->device,, "e100_wait_exec_simple: failed\n");
 #ifdef E100_CU_DEBUG		
-		printk(KERN_ERR "e100: %s: Last command (%x/%x) "
-			"timeout\n", bdp->device->name, 
+		netdev_err(bdp->device,, "Last command (%x/%x) timeout\n",
 			bdp->last_cmd, bdp->last_sub_cmd);
-		printk(KERN_ERR "e100: %s: Current simple command (%x) "
-			"can't be executed\n", 
-			bdp->device->name, scb_cmd_low);
+		netdev_err(bdp->device,, "Current simple command (%x) "
+			"can't be executed\n", scb_cmd_low);
 #endif		
 		return false;
 	}
@@ -466,12 +471,10 @@
 {
 	if (!e100_wait_scb(bdp)) {
 #ifdef E100_CU_DEBUG		
-		printk(KERN_ERR "e100: %s: Last command (%x/%x) "
-			"timeout\n", bdp->device->name, 
+		netdev_err(bdp->device,, "Last command (%x/%x) timeout\n",
 			bdp->last_cmd, bdp->last_sub_cmd);
-		printk(KERN_ERR "e100: %s: Current complex command "
-			"(%x/%x) can't be executed\n", 
-			bdp->device->name, cmd, sub_cmd);
+		netdev_err(bdp->device,, "Current complex command "
+			"(%x/%x) can't be executed\n", cmd, sub_cmd);
 #endif		
 		return false;
 	}
@@ -562,7 +565,7 @@
 
 	dev = alloc_etherdev(sizeof (struct e100_private));
 	if (dev == NULL) {
-		printk(KERN_ERR "e100: Not able to alloc etherdev struct\n");
+		dev_err(&pcid->dev, "Not able to alloc etherdev struct\n");
 		rc = -ENODEV;
 		goto out;
 	}
@@ -584,6 +587,15 @@
 	pci_set_drvdata(pcid, dev);
 	SET_NETDEV_DEV(dev, &pcid->dev);
 
+	if (debug < 0) {
+		dev->msg_enable = E100_DFLT_MSGLVL;
+	} else if (debug >= 8 * sizeof(int)) {
+		/* All levels enabled */
+		dev->msg_enable = -1;
+	} else {
+		dev->msg_enable = (1 << debug) - 1;
+	}
+
 	if ((rc = e100_alloc_space(bdp)) != 0) {
 		goto err_dev;
 	}
@@ -655,7 +667,7 @@
 	e100_check_options(e100nics, bdp);
 
 	if (!e100_init(bdp)) {
-		printk(KERN_ERR "e100: Failed to initialize, instance #%d\n",
+		netdev_err(dev,, "Failed to initialize, instance #%d\n",
 		       e100nics);
 		rc = -ENODEV;
 		goto err_unregister_netdev;
@@ -665,7 +677,7 @@
 	cal_checksum = e100_eeprom_calculate_chksum(bdp);
 	read_checksum = e100_eeprom_read(bdp, (bdp->eeprom_size - 1));
 	if (cal_checksum != read_checksum) {
-                printk(KERN_ERR "e100: Corrupted EEPROM on instance #%d\n",
+                netdev_err(dev,, "Corrupted EEPROM on instance #%d\n",
 		       e100nics);
                 rc = -ENODEV;
                 goto err_unregister_netdev;
@@ -675,9 +687,8 @@
 
 	e100_get_speed_duplex_caps(bdp);
 
-	printk(KERN_NOTICE
-	       "e100: %s: %s\n", 
-	       bdp->device->name, "Intel(R) PRO/100 Network Connection");
+	netdev_printk(KERN_NOTICE,
+		dev, PROBE, "Intel(R) PRO/100 Network Connection\n");
 	e100_print_brd_conf(bdp);
 
 	bdp->wolsupported = 0;
@@ -694,8 +705,6 @@
 		bdp->wolopts = WAKE_MAGIC;
 	}
 
-	printk(KERN_NOTICE "\n");
-
 	goto out;
 
 err_unregister_netdev:
@@ -839,26 +848,28 @@
 e100_check_options(int board, struct e100_private *bdp)
 {
 	if (board >= E100_MAX_NIC) {
-		printk(KERN_NOTICE 
-		       "e100: No configuration available for board #%d\n",
-		       board);
-		printk(KERN_NOTICE "e100: Using defaults for all values\n");
+		netdev_printk(KERN_NOTICE, bdp->device, PROBE,
+			"No configuration available for board #%d.  "
+			"Using defaults for all values\n", board);
 		board = E100_MAX_NIC;
 	}
 
-	e100_set_int_option(&(bdp->params.TxDescriptors), TxDescriptors[board],
+	e100_set_int_option(bdp, &(bdp->params.TxDescriptors),
+			    TxDescriptors[board],
 			    E100_MIN_TCB, E100_MAX_TCB, E100_DEFAULT_TCB,
 			    "TxDescriptor count");
 
-	e100_set_int_option(&(bdp->params.RxDescriptors), RxDescriptors[board],
+	e100_set_int_option(bdp, &(bdp->params.RxDescriptors),
+			    RxDescriptors[board],
 			    E100_MIN_RFD, E100_MAX_RFD, E100_DEFAULT_RFD,
 			    "RxDescriptor count");
 
-	e100_set_int_option(&(bdp->params.e100_speed_duplex),
+	e100_set_int_option(bdp, &(bdp->params.e100_speed_duplex),
 			    e100_speed_duplex[board], 0, 4,
 			    E100_DEFAULT_SPEED_DUPLEX, "speed/duplex mode");
 
-	e100_set_int_option(&(bdp->params.ber), ber[board], 0, ZLOCK_MAX_ERRORS,
+	e100_set_int_option(bdp, &(bdp->params.ber), ber[board], 0,
+			    ZLOCK_MAX_ERRORS,
 			    E100_DEFAULT_BER, "Bit Error Rate count");
 
 	e100_set_bool_option(bdp, XsumRX[board], PRM_XSUMRX, E100_DEFAULT_XSUM,
@@ -883,11 +894,11 @@
 			     E100_DEFAULT_BUNDLE_SMALL_FR,
 			     "CPU saver bundle small frames value");
 
-	e100_set_int_option(&(bdp->params.IntDelay), IntDelay[board], 0x0,
+	e100_set_int_option(bdp, &(bdp->params.IntDelay), IntDelay[board], 0x0,
 			    0xFFFF, E100_DEFAULT_CPUSAVER_INTERRUPT_DELAY,
 			    "CPU saver interrupt delay value");
 
-	e100_set_int_option(&(bdp->params.BundleMax), BundleMax[board], 0x1,
+	e100_set_int_option(bdp, &(bdp->params.BundleMax), BundleMax[board], 0x1,
 			    0xFFFF, E100_DEFAULT_CPUSAVER_BUNDLE_MAX,
 			    "CPU saver bundle max value");
 
@@ -895,6 +906,7 @@
 
 /**
  * e100_set_int_option - check and set an integer option
+ * @bdp: adapter's private data struct
  * @option: a pointer to the relevant option field
  * @val: the value specified
  * @min: the minimum valid value
@@ -907,22 +919,22 @@
  * Otherwise, if the value is invalid, change it to the default.
  */
 void __devinit
-e100_set_int_option(int *option, int val, int min, int max, int default_val,
-		    char *name)
+e100_set_int_option(struct e100_private *bdp, int *option, int val,
+	int min, int max, int default_val, char *name)
 {
 	if (val == -1) {	/* no value specified. use default */
 		*option = default_val;
 
 	} else if ((val < min) || (val > max)) {
-		printk(KERN_NOTICE
-		       "e100: Invalid %s specified (%i). "
-		       "Valid range is %i-%i\n",
-		       name, val, min, max);
-		printk(KERN_NOTICE "e100: Using default %s of %i\n", name,
-		       default_val);
+		netdev_printk(KERN_NOTICE, bdp->device, PROBE,
+		       "Invalid %s specified (%i). "
+		       "Valid range is %i-%i. "
+		       "Using default %s of %i\n",
+		       name, val, min, max, name, default_val);
 		*option = default_val;
 	} else {
-		printk(KERN_INFO "e100: Using specified %s of %i\n", name, val);
+		netdev_info(bdp->device, PROBE,
+		       "Using specified %s of %i\n", name, val);
 		*option = val;
 	}
 }
@@ -949,17 +961,17 @@
 			bdp->params.b_params |= mask;
 
 	} else if ((val != true) && (val != false)) {
-		printk(KERN_NOTICE
-		       "e100: Invalid %s specified (%i). "
-		       "Valid values are %i/%i\n",
-		       name, val, false, true);
-		printk(KERN_NOTICE "e100: Using default %s of %i\n", name,
-		       default_val);
+		netdev_printk(KERN_NOTICE, bdp->device, PROBE,
+		       "Invalid %s specified (%i). "
+		       "Valid values are %i/%i. "
+		       "Using default %s of %i\n",
+		       name, val, false, true, name, default_val);
 
 		if (default_val)
 			bdp->params.b_params |= mask;
 	} else {
-		printk(KERN_INFO "e100: Using specified %s of %i\n", name, val);
+		netdev_info(bdp->device, PROBE,
+			"Using specified %s of %i\n", name, val);
 		if (val)
 			bdp->params.b_params |= mask;
 	}
@@ -1181,8 +1193,7 @@
 	}
 
 	if (!e100_exec_non_cu_cmd(bdp, cmd)) {
-		printk(KERN_WARNING "e100: %s: Multicast setup failed\n", 
-		       dev->name);
+		netdev_warn(dev,, "Multicast setup failed\n");
 	}
 }
 
@@ -1262,20 +1273,20 @@
 
 	if (!e100_selftest(bdp, &st_timeout, &st_result)) {
         	if (st_timeout) {
-			printk(KERN_ERR "e100: selftest timeout\n");
+			netdev_err(bdp->device,, "selftest timeout\n");
 		} else {
-			printk(KERN_ERR "e100: selftest failed. Results: %x\n",
-					st_result);
+			netdev_err(bdp->device,,
+				"selftest failed. Results: %x\n", st_result);
 		}
 		return false;
 	}
 	else
-		printk(KERN_DEBUG "e100: selftest OK.\n");
+		netdev_dbg(bdp->device,, "selftest OK.\n");
 
 	/* read the MAC address from the eprom */
 	e100_rd_eaddr(bdp);
 	if (!is_valid_ether_addr(bdp->device->dev_addr)) {
-		printk(KERN_ERR "e100: Invalid Ethernet address\n");
+		netdev_err(bdp->device,, "Invalid Ethernet address\n");
 		return false;
 	}
 	/* read NIC's part number */
@@ -1426,7 +1437,7 @@
 
 	return true;
 err:
-	printk(KERN_ERR "e100: hw init failed\n");
+	netdev_err(bdp->device,, "hw init failed\n");
 	return false;
 }
 
@@ -1555,8 +1566,7 @@
 	return 0;
 
 err:
-	printk(KERN_ERR
-	       "e100: Failed to allocate memory\n");
+	netdev_err(bdp->device,, "Failed to allocate memory\n");
 	return -ENOMEM;
 }
 
@@ -1697,8 +1707,7 @@
 
 #ifdef E100_CU_DEBUG
 	if (e100_cu_unknown_state(bdp)) {
-		printk(KERN_ERR "e100: %s: CU unknown state in e100_watchdog\n",
-			dev->name);
+		netdev_err(dev,, "CU unknown state in e100_watchdog\n");
 	}
 #endif	
 	if (!netif_running(dev)) {
@@ -1708,9 +1717,9 @@
 	/* check if link state has changed */
 	if (e100_phy_check(bdp)) {
 		if (netif_carrier_ok(dev)) {
-			printk(KERN_ERR
-			       "e100: %s NIC Link is Up %d Mbps %s duplex\n",
-			       bdp->device->name, bdp->cur_line_speed,
+			netdev_err(dev, LINK,
+			       "NIC Link is Up %d Mbps %s duplex\n",
+			       bdp->cur_line_speed,
 			       (bdp->cur_dplx_mode == HALF_DUPLEX) ?
 			       "Half" : "Full");
 
@@ -1718,8 +1727,7 @@
 			e100_config(bdp);  
 
 		} else {
-			printk(KERN_ERR "e100: %s NIC Link is Down\n",
-			       bdp->device->name);
+			netdev_err(dev, LINK, "NIC Link is Down\n");
 		}
 	}
 
@@ -2289,14 +2297,12 @@
 	case START_WAIT:
 		// The last command was a non_tx CU command
 		if (!e100_wait_cus_idle(bdp))
-			printk(KERN_DEBUG
-			       "e100: %s: cu_start: timeout waiting for cu\n",
-			       bdp->device->name);
+			netdev_dbg(bdp->device,,
+			       "cu_start: timeout waiting for cu\n");
 		if (!e100_wait_exec_cmplx(bdp, (u32) (tcb->tcb_phys),
 					  SCB_CUC_START, CB_TRANSMIT)) {
-			printk(KERN_DEBUG
-			       "e100: %s: cu_start: timeout waiting for scb\n",
-			       bdp->device->name);
+			netdev_dbg(bdp->device,,
+			       "cu_start: timeout waiting for scb\n");
 			e100_exec_cmplx(bdp, (u32) (tcb->tcb_phys),
 					SCB_CUC_START);
 			ret = false;
@@ -2414,8 +2420,7 @@
 
 	res = e100_exec_non_cu_cmd(bdp, cmd);
 	if (!res)
-		printk(KERN_WARNING "e100: %s: IA setup failed\n", 
-		       bdp->device->name);
+		netdev_warn(bdp->device,, "IA setup failed\n");
 
 exit:
 	return res;
@@ -2460,9 +2465,7 @@
 	spin_lock(&bdp->bd_lock);
 
 	if (!e100_wait_exec_cmplx(bdp, rx_struct->dma_addr, SCB_RUC_START, 0)) {
-		printk(KERN_DEBUG
-		       "e100: %s: start_ru: wait_scb failed\n", 
-		       bdp->device->name);
+		netdev_dbg(bdp->device,, "start_ru: wait_scb failed\n");
 		e100_exec_cmplx(bdp, rx_struct->dma_addr, SCB_RUC_START);
 	}
 	if (bdp->next_cu_cmd == RESUME_NO_WAIT) {
@@ -2707,8 +2710,8 @@
 			spin_lock_bh(&(bdp->bd_non_tx_lock));
 		} else {
 #ifdef E100_CU_DEBUG			
-			printk(KERN_ERR "e100: %s: non-TX command (%x) "
-				"timeout\n", bdp->device->name, sub_cmd);
+			netdev_err(bdp->device,, "non-TX command (%x) "
+				"timeout\n", sub_cmd);
 #endif			
 			rc = false;
 			goto exit;
@@ -2961,14 +2964,17 @@
 {
 	/* Print the string if checksum Offloading was enabled */
 	if (bdp->flags & DF_CSUM_OFFLOAD)
-		printk(KERN_NOTICE "  Hardware receive checksums enabled\n");
+		netdev_printk(KERN_NOTICE, bdp->device, PROBE,
+			"  Hardware receive checksums enabled\n");
 	else {
 		if (bdp->rev_id >= D101MA_REV_ID) 
-			printk(KERN_NOTICE "  Hardware receive checksums disabled\n");
+			netdev_printk(KERN_NOTICE, bdp->device, PROBE,
+				"  Hardware receive checksums disabled\n");
 	}
 
 	if ((bdp->flags & DF_UCODE_LOADED))
-		printk(KERN_NOTICE "  cpu cycle saver enabled\n");
+		netdev_printk(KERN_NOTICE, bdp->device, PROBE,
+			"  cpu cycle saver enabled\n");
 }
 
 /**
@@ -3017,8 +3023,8 @@
 	bdp->scb = (scb_t *) ioremap_nocache(dev->mem_start, sizeof (scb_t));
 
 	if (!bdp->scb) {
-		printk(KERN_ERR "e100: %s: Failed to map PCI address 0x%lX\n",
-		       dev->name, pci_resource_start(pcid, 0));
+		netdev_err(dev,, "Failed to map PCI address 0x%lX\n",
+		       pci_resource_start(pcid, 0));
 		rc = -ENOMEM;
 		goto err_region;
 	}
@@ -3092,7 +3098,7 @@
 		return false;
 
 	if (!e100_setup_iaaddr(bdp, bdp->device->dev_addr)) {
-		printk(KERN_ERR "e100: e100_configure_device: "
+		netdev_err(bdp->device,, "e100_configure_device: "
 			"setup iaaddr failed\n");
 		return false;
 	}
@@ -3122,7 +3128,7 @@
 	e100_sw_reset(bdp, cmd);
 	if (cmd == PORT_SOFTWARE_RESET) {
 		if (!e100_configure_device(bdp))
-			printk(KERN_ERR "e100: e100_deisolate_driver:" 
+			netdev_err(bdp->device,, "e100_deisolate_driver:"
 		       		" device configuration failed\n");
 	} 
 
@@ -3206,6 +3212,20 @@
 	case ETHTOOL_PHYS_ID:
 		rc = e100_ethtool_led_blink(dev,ifr);
 		break;
+	case ETHTOOL_GMSGLVL: {
+		struct ethtool_value eval = {ETHTOOL_GMSGLVL};
+		eval.data = dev->msg_enable;
+		if (copy_to_user(ifr->ifr_data, &eval, sizeof(eval)))
+			return -EFAULT;
+		return 0;
+	}
+	case ETHTOOL_SMSGLVL: {
+		struct ethtool_value eval;
+		if (copy_from_user(&eval, ifr->ifr_data, sizeof(eval)))
+			return -EFAULT;
+		dev->msg_enable = eval.data;
+		return 0;
+	}
 #ifdef	ETHTOOL_GRINGPARAM
 	case ETHTOOL_GRINGPARAM: {
 		struct ethtool_ringparam ering;
@@ -3843,8 +3863,7 @@
 
 	res = e100_exec_non_cu_cmd(bdp, cmd);
 	if (!res)
-		printk(KERN_WARNING "e100: %s: Filter setup failed\n",
-		       bdp->device->name);
+		netdev_warn(bdp->device,, "Filter setup failed\n");
 
 exit:
 	return res;
@@ -3859,10 +3878,10 @@
 	if (e100_config(bdp)) {
 		if (bdp->wolopts & (WAKE_UCAST | WAKE_ARP))
 			if (!e100_setup_filter(bdp))
-				printk(KERN_ERR
-				       "e100: WOL options failed\n");
+				netdev_err(bdp->device,,
+				       "WOL options failed\n");
 	} else {
-		printk(KERN_ERR "e100: config WOL failed\n");
+		netdev_err(bdp->device,, "config WOL failed\n");
 	}
 }
 #endif
@@ -4159,9 +4178,9 @@
 #ifdef E100_CU_DEBUG			
 			if (!(non_tx_cmd->cb_status 
 			    & __constant_cpu_to_le16(CB_STATUS_COMPLETE)))
-				printk(KERN_ERR "e100: %s: Queued "
+				netdev_err(bdp->device,, "Queued "
 					"command (%x) timeout\n", 
-					bdp->device->name, sub_cmd);
+					sub_cmd);
 #endif			
 			list_del(&(active_command->list_elem));
 			e100_free_non_tx_cmd(bdp, active_command);
diff -Naur linux.org/drivers/net/e100/e100_phy.c linux.e100.patched/drivers/net/e100/e100_phy.c
--- linux.org/drivers/net/e100/e100_phy.c	Mon Aug 25 13:29:38 2003
+++ linux.e100.patched/drivers/net/e100/e100_phy.c	Mon Aug 25 13:29:38 2003
@@ -72,7 +72,7 @@
 	if (mdi_cntrl & MDI_PHY_READY) 
 		return 0;
 	else {
-		printk(KERN_ERR "e100: MDI write timeout\n");
+		netdev_err(bdp->device,, "MDI write timeout\n");
 		return 1;
 	}
 }
@@ -127,7 +127,7 @@
 		return 0;
 	}
 	else {
-		printk(KERN_ERR "e100: MDI read timeout\n");
+		netdev_err(bdp->device,, "MDI read timeout\n");
 		return 1;
 	}
 }
@@ -236,22 +236,20 @@
 		switch (bdp->params.e100_speed_duplex) {
 		case E100_AUTONEG:
 			/* The adapter can't autoneg. so set to 10/HALF */
-			printk(KERN_INFO
-			       "e100: 503 serial component detected which "
-			       "cannot autonegotiate\n");
-			printk(KERN_INFO
-			       "e100: speed/duplex forced to "
+			netdev_info(bdp->device, PROBE,
+			       "503 serial component detected which "
+			       "cannot autonegotiate. "
+			       "speed/duplex forced to "
 			       "10Mbps / Half duplex\n");
 			bdp->params.e100_speed_duplex = E100_SPEED_10_HALF;
 			break;
 
 		case E100_SPEED_100_HALF:
 		case E100_SPEED_100_FULL:
-			printk(KERN_ERR
-			       "e100: 503 serial component detected "
-			       "which does not support 100Mbps\n");
-			printk(KERN_ERR
-			       "e100: Change the forced speed/duplex "
+			netdev_err(bdp->device,,
+			       "503 serial component detected "
+			       "which does not support 100Mbps. "
+			       "Change the forced speed/duplex "
 			       "to a supported setting\n");
 			return false;
 		}
@@ -269,7 +267,7 @@
 		if ((bdp->params.e100_speed_duplex != E100_AUTONEG) &&
 		    (bdp->params.e100_speed_duplex != E100_SPEED_100_FULL)) {
 			/* just inform user about 100 full */
-			printk(KERN_ERR "e100: NC3133 NIC can only run "
+			netdev_err(bdp->device,, "NC3133 NIC can only run "
 			       "at 100Mbps full duplex\n");
 		}
 
diff -Naur linux.org/drivers/net/e100/e100_test.c linux.e100.patched/drivers/net/e100/e100_test.c
--- linux.org/drivers/net/e100/e100_test.c	Mon Aug 25 13:29:38 2003
+++ linux.e100.patched/drivers/net/e100/e100_test.c	Mon Aug 25 13:29:38 2003
@@ -44,7 +44,7 @@
 static void e100_diag_config_loopback(struct e100_private *, u8, u8, u8 *,u8 *);
 static u8 e100_diag_loopback_alloc(struct e100_private *);
 static void e100_diag_loopback_cu_ru_exec(struct e100_private *);
-static u8 e100_diag_check_pkt(u8 *);
+static u8 e100_diag_check_pkt(struct e100_private *bdp, u8 *);
 static void e100_diag_loopback_free(struct e100_private *);
 static int e100_cable_diag(struct e100_private *bdp);
 
@@ -169,19 +169,19 @@
 {
 	u8 rc = 0;
 
-	printk(KERN_DEBUG "%s: PHY loopback test starts\n", dev->name);
+	netdev_printk(KERN_DEBUG, dev,, "PHY loopback test starts\n");
 	e100_hw_init(dev->priv);
 	if (!e100_diag_one_loopback(dev, PHY_LOOPBACK)) {
 		rc |= PHY_LOOPBACK;
 	}
-	printk(KERN_DEBUG "%s: PHY loopback test ends\n", dev->name);
+	netdev_printk(KERN_DEBUG, dev,, "PHY loopback test ends\n");
 
-	printk(KERN_DEBUG "%s: MAC loopback test starts\n", dev->name);
+	netdev_printk(KERN_DEBUG, dev,, "MAC loopback test starts\n");
 	e100_hw_init(dev->priv);
 	if (!e100_diag_one_loopback(dev, MAC_LOOPBACK)) {
 		rc |= MAC_LOOPBACK;
 	}
-	printk(KERN_DEBUG "%s: MAC loopback test ends\n", dev->name);
+	netdev_printk(KERN_DEBUG, dev,, "MAC loopback test ends\n");
 
 	return rc;
 }
@@ -349,7 +349,7 @@
 {
 	/*load CU & RU base */ 
 	if(!e100_wait_exec_cmplx(bdp, bdp->loopback.dma_handle, SCB_RUC_START, 0))
-		printk(KERN_ERR "e100: SCB_RUC_START failed!\n");
+		netdev_err(bdp->device,, "SCB_RUC_START failed!\n");
 
 	bdp->next_cu_cmd = START_WAIT;
 	e100_start_cu(bdp, bdp->loopback.tcb);
@@ -359,20 +359,23 @@
 /**
  * e100_diag_check_pkt - checks if a given packet is a loopback packet
  * @bdp: atapter's private data struct
+ * @datap: pointer to packet data
  *
  * Returns true if OK false otherwise.
  */
 static u8
-e100_diag_check_pkt(u8 *datap)
+e100_diag_check_pkt(struct e100_private *bdp, u8 *datap)
 {
 	int i;
 	for (i = 0; i<512; i++) {
 		if( !((*datap)==0xFF && (*(datap + 512) == 0xBA)) ) {
-			printk (KERN_ERR "e100: check loopback packet failed at: %x\n", i);
+			netdev_err(bdp->device,,
+				"check loopback packet failed at: %x\n", i);
 			return false;
 			}
 	}
-	printk (KERN_DEBUG "e100: Check received loopback packet OK\n");
+	netdev_printk(KERN_DEBUG, bdp->device,,
+		"Check received loopback packet OK\n");
 	return true;
 }
 
@@ -404,11 +407,13 @@
         }
 
         if (rfd_status & RFD_STATUS_COMPLETE) {
-		printk(KERN_DEBUG "e100: Loopback packet received\n");
-                return e100_diag_check_pkt(((u8 *)rfdp+bdp->rfd_size));
+		netdev_printk(KERN_DEBUG, bdp->device,,
+			"Loopback packet received\n");
+                return e100_diag_check_pkt(bdp,
+			((u8 *)rfdp+bdp->rfd_size));
 	}
 	else {
-		printk(KERN_ERR "e100: Loopback packet not received\n");
+		netdev_err(bdp->device,, "Loopback packet not received\n");
 		return false;
 	}
 }

--------------09E8359C42A09191C013F7B9--

