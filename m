Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130323AbQKNBAW>; Mon, 13 Nov 2000 20:00:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130400AbQKNBAN>; Mon, 13 Nov 2000 20:00:13 -0500
Received: from ottawa.linuxcare.com ([216.208.98.2]:30453 "EHLO
	plonk.linuxcare.com") by vger.kernel.org with ESMTP
	id <S130323AbQKNBAB>; Mon, 13 Nov 2000 20:00:01 -0500
Date: Mon, 13 Nov 2000 19:31:52 -0500
Message-Id: <200011140031.TAA13437@plonk.linuxcare.com>
From: Jes Sorensen <jes@trained-monkey.org>
To: torvalds@transmeta.com
CC: linux-kernel@vger.kernel.org
Subject: [patch] acenic driver update
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus

Here is a patch to bring the acenic driver update with the latest
fixes. It fixes the following issues:

- Driver wasn't being initialized when compiled statically into the
  kernel.
- set_macaddr() set the address incorrectly on little endian machines.
- netif_stop_queue() was called in post softnet mode when entering
  start_xmit() which was unnecessary. Now it is only set when the
  queue is full.
- SET_MODULE_OWNER() from Jeff Garzik.
- ETHTOOL support done in a way so it is backwards compatible.

The patch has been up for testing on the AceNIC list for almost a week
and so far nobody has reported problems with it so I consider it to be
stable.

Jes

--- /home/jes/test/linux-2.4.0-test11-pre4/drivers/net/acenic.c	Mon Nov 13 17:42:12 2000
+++ drivers/net/acenic.c	Mon Nov 13 19:26:23 2000
@@ -2,7 +2,7 @@
  * acenic.c: Linux driver for the Alteon AceNIC Gigabit Ethernet card
  *           and other Tigon based cards.
  *
- * Copyright 1998-2000 by Jes Sorensen, <Jes.Sorensen@cern.ch>.
+ * Copyright 1998-2000 by Jes Sorensen, <jes@linuxcare.com>.
  *
  * Thanks to Alteon and 3Com for providing hardware and documentation
  * enabling me to write this driver.
@@ -39,6 +39,8 @@
  *                                       where the driver would disable
  *                                       bus master mode if it had to disable
  *                                       write and invalidate.
+ *   Stephen Hack <stephen_hack@hp.com>: Fixed ace_set_mac_addr for little
+ *                                       endian systems.
  */
 
 #include <linux/config.h>
@@ -55,10 +57,12 @@
 #include <linux/init.h>
 #include <linux/delay.h>
 #include <linux/mm.h>
+#include <linux/sockios.h>
 
-#undef INDEX_DEBUG
-
+#ifdef SIOCETHTOOL
 #include <linux/ethtool.h>
+#endif
+
 #include <net/sock.h>
 #include <net/ip.h>
 
@@ -69,6 +73,9 @@
 #include <asm/uaccess.h>
 
 
+#undef INDEX_DEBUG
+
+
 #ifdef CONFIG_ACENIC_OMIT_TIGON_I
 #define ACE_IS_TIGON_I(ap)	0
 #else
@@ -119,6 +126,15 @@
 #define SMP_CACHE_BYTES	L1_CACHE_BYTES
 #endif
 
+#ifndef SET_MODULE_OWNER
+#define SET_MODULE_OWNER(dev)		{do{} while(0);}
+#define ACE_MOD_INC_USE_COUNT		MOD_INC_USE_COUNT
+#define ACE_MOD_DEC_USE_COUNT		MOD_DEC_USE_COUNT
+#else
+#define ACE_MOD_INC_USE_COUNT		{do{} while(0);}
+#define ACE_MOD_DEC_USE_COUNT		{do{} while(0);}
+#endif
+
 
 #if (LINUX_VERSION_CODE < 0x02030d)
 #define pci_resource_start(dev, bar)	dev->base_address[bar]
@@ -130,10 +146,6 @@
 #define net_device device
 #endif
 
-#if (LINUX_VERSION_CODE >= 0x02031b)
-#define NEW_NETINIT
-#endif
-
 #if (LINUX_VERSION_CODE < 0x02032a)
 typedef u32 dma_addr_t;
 
@@ -154,10 +166,20 @@
 #if (LINUX_VERSION_CODE < 0x02032b)
 /*
  * SoftNet
+ *
+ * For pre-softnet kernels we need to tell the upper layer not to
+ * re-enter start_xmit() while we are in there. However softnet
+ * guarantees not to enter while we are in there so there is no need
+ * to do the netif_stop_queue() dance unless the transmit queue really
+ * gets stuck. This should also improve performance according to tests
+ * done by Aman Singla.
  */
-#define dev_kfree_skb_irq(a)	dev_kfree_skb(a)
-#define netif_wake_queue(dev)	clear_bit(0, &dev->tbusy)
-#define netif_stop_queue(dev)	set_bit(0, &dev->tbusy)
+#define dev_kfree_skb_irq(a)			dev_kfree_skb(a)
+#define netif_wake_queue(dev)			clear_bit(0, &dev->tbusy)
+#define netif_stop_queue(dev)			set_bit(0, &dev->tbusy)
+#define late_stop_netif_stop_queue(dev)		{do{} while(0);}
+#define early_stop_netif_stop_queue(dev)	test_and_set_bit(0,&dev->tbusy)
+#define early_stop_netif_wake_queue(dev)	netif_wake_queue(dev)
 
 static inline void netif_start_queue(struct net_device *dev)
 {
@@ -166,16 +188,22 @@
 	dev->start = 1;
 }
 
-#define ace_mark_net_bh(foo)		mark_bh(foo)
-#define netif_queue_stopped(dev)	dev->tbusy
-#define netif_running(dev)		dev->start
-#define ace_if_down(dev)		{do{dev->start = 0;}while (0);}
+#define ace_mark_net_bh(foo)			mark_bh(foo)
+#define netif_queue_stopped(dev)		dev->tbusy
+#define netif_running(dev)			dev->start
+#define ace_if_down(dev)			{do{dev->start = 0;}while (0);}
 #else
-#define NET_BH			0
-#define ace_mark_net_bh(foo)	{do{} while(0);}
-#define ace_if_down(dev)	{do{} while(0);}
+#define NET_BH					0
+#define late_stop_netif_stop_queue(dev)		netif_stop_queue(dev)
+#define early_stop_netif_stop_queue(dev)	0
+#define early_stop_netif_wake_queue(dev)	{do{} while(0);}
+#define ace_mark_net_bh(foo)			{do{} while(0);}
+#define ace_if_down(dev)			{do{} while(0);}
 #endif
 
+#if (LINUX_VERSION_CODE >= 0x02031b)
+#define NEW_NETINIT
+#endif
 
 #define ACE_MAX_MOD_PARMS	8
 #define BOARD_IDX_STATIC	0
@@ -400,10 +428,10 @@
 static int dis_pci_mem_inval[ACE_MAX_MOD_PARMS] = {1, 1, 1, 1, 1, 1, 1, 1};
 
 static char version[] __initdata = 
-  "acenic.c: v0.47 09/18/2000  Jes Sorensen, linux-acenic@SunSITE.auc.dk\n"
+  "acenic.c: v0.48 11/14/2000  Jes Sorensen, linux-acenic@SunSITE.auc.dk\n"
   "                            http://home.cern.ch/~jes/gige/acenic.html\n";
 
-static struct net_device *root_dev;
+static struct net_device *root_dev = NULL;
 
 static int probed __initdata = 0;
 
@@ -460,6 +488,8 @@
 			break;
 		}
 
+		SET_MODULE_OWNER(dev);
+
 		if (!dev->priv)
 			dev->priv = kmalloc(sizeof(*ap), GFP_KERNEL);
 		if (!dev->priv) {
@@ -615,7 +645,7 @@
 
 
 #ifdef MODULE
-MODULE_AUTHOR("Jes Sorensen <Jes.Sorensen@cern.ch>");
+MODULE_AUTHOR("Jes Sorensen <jes@linuxcare.com>");
 MODULE_DESCRIPTION("AceNIC/3C985/GA620 Gigabit Ethernet driver");
 MODULE_PARM(link, "1-" __MODULE_STRING(8) "i");
 MODULE_PARM(trace, "1-" __MODULE_STRING(8) "i");
@@ -634,8 +664,8 @@
 	short i;
 
 	while (root_dev) {
-		next = ((struct ace_private *)root_dev->priv)->next;
 		ap = root_dev->priv;
+		next = ap->next;
 
 		regs = ap->regs;
 
@@ -730,8 +760,8 @@
 }
 
 
-#ifdef MODULE
 #if (LINUX_VERSION_CODE < 0x02032a)
+#ifdef MODULE
 int init_module(void)
 {
 	return ace_module_init();
@@ -742,11 +772,11 @@
 {
 	ace_module_cleanup();
 }
+#endif
 #else
 module_init(ace_module_init);
 module_exit(ace_module_cleanup);
 #endif
-#endif
 
 
 static void ace_free_descriptors(struct net_device *dev)
@@ -2211,7 +2241,7 @@
 
 	netif_start_queue(dev);
 
-	MOD_INC_USE_COUNT;
+	ACE_MOD_INC_USE_COUNT;
 
 	/*
 	 * Setup the timer
@@ -2294,7 +2324,7 @@
 
 	restore_flags(flags);
 
-	MOD_DEC_USE_COUNT;
+	ACE_MOD_DEC_USE_COUNT;
 	return 0;
 }
 
@@ -2307,14 +2337,10 @@
 	u32 idx, flagsize;
 
 	/*
-	 * ARGH, there is just no pretty way to do this
+	 * This only happens with pre-softnet, ie. 2.2.x kernels.
 	 */
-#if (LINUX_VERSION_CODE < 0x02032b)
-	if (test_and_set_bit(0, &dev->tbusy))
+	if (early_stop_netif_stop_queue(dev))
 		return 1;
-#else
-	netif_stop_queue(dev);
-#endif
 
 	idx = ap->tx_prd;
 
@@ -2358,7 +2384,8 @@
 		 */
 		mod_timer(&ap->timer, jiffies + (3 * HZ));
 
-		/* The following check will fix a race between the interrupt
+		/*
+		 * The following check will fix a race between the interrupt
 		 * handler increasing the tx_ret_csm and testing for tx_full
 		 * and this tx routine's testing the tx_ret_csm and setting
 		 * the tx_full; note that this fix makes assumptions on the
@@ -2369,13 +2396,17 @@
 		if (((idx + 2) % TX_RING_ENTRIES != ap->tx_ret_csm)
 			&& xchg(&ap->tx_full, 0)) {
 			del_timer(&ap->timer);
+			/*
+			 * We may not need this one in the post softnet era
+			 * in this case this can be changed to a
+			 * early_stop_netif_wake_queue(dev);
+			 */
 			netif_wake_queue(dev);
+		} else {
+			late_stop_netif_stop_queue(dev);
 		}
 	} else {
-		/*
-		 * No need for it to be atomic - seems it needs to be
-		 */
-		netif_wake_queue(dev);
+		early_stop_netif_wake_queue(dev);
 	}
 
 	dev->trans_start = jiffies;
@@ -2424,6 +2455,7 @@
 
 static int ace_ioctl(struct net_device *dev, struct ifreq *ifr, int cmd)
 {
+#ifdef SIOCETHTOOL
 	struct ace_private *ap = dev->priv;
 	struct ace_regs *regs = ap->regs;
 	struct ethtool_cmd ecmd;
@@ -2483,7 +2515,11 @@
 			ecmd.autoneg = AUTONEG_DISABLE;
 
 #if 0
+		/*
+		 * Current struct ethtool_cmd is insufficient
+		 */
 		ecmd.trace = readl(&regs->TuneTrace);
+
 		ecmd.txcoal = readl(&regs->TuneTxCoalTicks);
 		ecmd.rxcoal = readl(&regs->TuneRxCoalTicks);
 #endif
@@ -2551,6 +2587,7 @@
 		}
 		return 0;
 	}
+#endif
 
 	return -EOPNOTSUPP;
 }
@@ -2563,7 +2600,7 @@
 {
 	struct sockaddr *addr=p;
 	struct ace_regs *regs;
-	u16 *da;
+	u8 *da;
 	struct cmd cmd;
 
 	if(netif_running(dev))
@@ -2571,11 +2608,11 @@
 
 	memcpy(dev->dev_addr, addr->sa_data,dev->addr_len);
 
-	da = (u16 *)dev->dev_addr;
+	da = (u8 *)dev->dev_addr;
 
 	regs = ((struct ace_private *)dev->priv)->regs;
-	writel(da[0], &regs->MacAddrHi);
-	writel((da[1] << 16) | da[2], &regs->MacAddrLo);
+	writel(da[0] << 8 | da[1], &regs->MacAddrHi);
+	writel((da[2] << 24) | (da[3] << 16) | (da[4] << 8) | da[5] , &regs->MacAddrLo);
 
 	cmd.evt = C_SET_MAC_ADDR;
 	cmd.code = 0;
@@ -3000,6 +3037,6 @@
 
 /*
  * Local variables:
- * compile-command: "gcc -D__KERNEL__ -DMODULE -I../../include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -pipe -fno-strength-reduce -DMODVERSIONS -include ../../include/linux/modversions.h   -c -o acenic.o acenic.c"
+ * compile-command: "gcc -D__SMP__ -D__KERNEL__ -DMODULE -I../../include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -pipe -fno-strength-reduce -DMODVERSIONS -include ../../include/linux/modversions.h   -c -o acenic.o acenic.c"
  * End:
  */
--- /home/jes/test/linux-2.4.0-test11-pre4/drivers/net/acenic_firmware.h	Mon Sep 18 18:16:48 2000
+++ drivers/net/acenic_firmware.h	Mon Nov 13 17:22:40 2000
@@ -17,10 +17,11 @@
 #define tigonFwSbssLen 0x38
 #define tigonFwBssAddr 0x00015dd0
 #define tigonFwBssLen 0x2080
-u32 tigonFwText[];
-u32 tigonFwData[];
-u32 tigonFwRodata[];
 #ifndef CONFIG_ACENIC_OMIT_TIGON_I
+#define tigonFwText 0
+#define tigonFwData 0
+#define tigonFwRodata 0
+#else
 /* Generated by genfw.c */
 u32 tigonFwText[(MAX_TEXT_LEN/4) + 1] __initdata = {
 0x10000003, 
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
