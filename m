Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265470AbSJSB4H>; Fri, 18 Oct 2002 21:56:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265471AbSJSB4G>; Fri, 18 Oct 2002 21:56:06 -0400
Received: from roc-24-93-20-125.rochester.rr.com ([24.93.20.125]:51960 "EHLO
	www.kroptech.com") by vger.kernel.org with ESMTP id <S265470AbSJSBzi>;
	Fri, 18 Oct 2002 21:55:38 -0400
Date: Fri, 18 Oct 2002 22:01:29 -0400
From: Adam Kropelin <akropel1@rochester.rr.com>
To: jgarjik@pobox.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.4/2.5: ewrk3 ethtool support
Message-ID: <20021019020128.GA21496@www.kroptech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following patch adds support for ethtool to the ewrk3 driver. It is against
2.5-BK but should apply to any recent 2.5 and 2.4 as well. In addition to adding
ethtool support, it also removes the cli/sti fixup attribution from the
changelog since that didn't actually go in yet and fixes a small style issue I
introduced in the multi-card support patch.

Note that for 2.5 ewrk3 still needs VDA's cli/sti removal patch, which I will
send along in a separate mail along with some other cleanups.

This has been tested on an SMP x86 box containing 3 DE205 NICs.

--Adam

--- /home/adk0212/linus-2.5/drivers/net/ewrk3.c	Fri Oct 18 16:12:25 2002
+++ linux-2.5.43-mm1/drivers/net/ewrk3.c	Fri Oct 18 21:55:44 2002
@@ -135,8 +135,8 @@
    0.43    16-Aug-96   Update alloc_device() to conform to de4x5.c
    0.44    08-Nov-01   use library crc32 functions <Matt_Domsch@dell.com>
    0.45    19-Jul-02   fix unaligned access on alpha <martin@bruli.net>
-   0.46    10-Oct-02   cli/sti removal <VDA@port.imtp.ilyichevsk.odessa.ua>
-   Multiple NIC support when module <akropel1@rochester.rr.com>
+   0.46    10-Oct-02   Multiple NIC support when module <akropel1@rochester.rr.com>
+   0.47    18-Oct-02   ethtool support <akropel1@rochester.rr.com>
 
    =========================================================================
  */
@@ -161,6 +161,7 @@
 #include <linux/netdevice.h>
 #include <linux/etherdevice.h>
 #include <linux/skbuff.h>
+#include <linux/ethtool.h>
 
 #include <linux/time.h>
 #include <linux/types.h>
@@ -169,8 +170,11 @@
 
 #include "ewrk3.h"
 
+#define DRV_NAME	"ewrk3"
+#define DRV_VERSION	"0.47"
+
 static char version[] __initdata =
-"ewrk3.c:v0.46 2002/10/09 davies@maniac.ultranet.com\n";
+DRV_NAME ":v" DRV_VERSION " 2002/10/17 davies@maniac.ultranet.com\n";
 
 #ifdef EWRK3_DEBUG
 static int ewrk3_debug = EWRK3_DEBUG;
@@ -278,6 +282,7 @@
 	u_char hard_strapped;	/* Don't allow a full open */
 	u_char txc;		/* Transmit cut through */
 	u_char *mctbl;		/* Pointer to the multicast table */
+	u_char led_mask;	/* Used to reserve LED access for ethtool */
 	spinlock_t hw_lock;
 };
 
@@ -533,6 +538,7 @@
 							lp->shmem_length = shmem_length;
 							lp->lemac = lemac;
 							lp->hard_strapped = hard_strapped;
+							lp->led_mask = CR_LED;
 							spin_lock_init(&lp->hw_lock);
 
 							lp->mPage = 64;
@@ -903,7 +909,7 @@
 	DISABLE_IRQs;
 
 	cr = inb(EWRK3_CR);
-	cr |= CR_LED;
+	cr |= lp->led_mask;
 	outb(cr, EWRK3_CR);
 
 	if (csr & CSR_RNE)	/* Rx interrupt (packet[s] arrived) */
@@ -928,7 +934,7 @@
 	}
 
 	/* Unmask the EWRK3 board interrupts and turn off the LED */
-	cr &= ~CR_LED;
+	cr &= ~(lp->led_mask);
 	outb(cr, EWRK3_CR);
 	ENABLE_IRQs;
 	spin_unlock(&lp->hw_lock);
@@ -1624,6 +1630,195 @@
 	return status;		/* return the device name string */
 }
 
+static int ewrk3_ethtool_ioctl(struct net_device *dev, void *useraddr)
+{
+	struct ewrk3_private *lp = (struct ewrk3_private *) dev->priv;
+	u_long iobase = dev->base_addr;
+	u32 ethcmd;
+
+	if (get_user(ethcmd, (u32 *)useraddr))
+		return -EFAULT;
+
+	switch (ethcmd) {
+
+	/* Get driver info */
+	case ETHTOOL_GDRVINFO: {
+		struct ethtool_drvinfo info = { ETHTOOL_GDRVINFO };
+		int fwrev = Read_EEPROM(dev->base_addr, EEPROM_REVLVL);
+
+		strcpy(info.driver, DRV_NAME);
+		strcpy(info.version, DRV_VERSION);
+		sprintf(info.fw_version, "%d", fwrev);
+		strcpy(info.bus_info, "N/A");
+		info.eedump_len = EEPROM_MAX;
+		if (copy_to_user(useraddr, &info, sizeof(info)))
+			return -EFAULT;
+		return 0;
+	}
+
+	/* Get settings */
+	case ETHTOOL_GSET: {
+		struct ethtool_cmd ecmd = { ETHTOOL_GSET };
+		u_char cr = inb(EWRK3_CR);
+
+		switch (lp->adapter_name[4]) {
+		case '3': /* DE203 */
+			ecmd.supported = SUPPORTED_BNC;
+			ecmd.port = PORT_BNC;
+			break;
+
+		case '4': /* DE204 */
+			ecmd.supported = SUPPORTED_TP;
+			ecmd.port = PORT_TP;
+			break;
+
+		case '5': /* DE205 */
+			ecmd.supported = SUPPORTED_TP | SUPPORTED_BNC | SUPPORTED_AUI;
+			ecmd.autoneg = !(cr & CR_APD);
+			/*
+			** Port is only valid if autoneg is disabled
+			** and even then we don't know if AUI is jumpered.
+			*/
+			if (!ecmd.autoneg)
+				ecmd.port = (cr & CR_PSEL) ? PORT_BNC : PORT_TP;
+			break;
+		}
+
+		ecmd.supported |= SUPPORTED_10baseT_Half;
+		ecmd.speed = SPEED_10;
+		ecmd.duplex = DUPLEX_HALF;
+
+		if (copy_to_user(useraddr, &ecmd, sizeof(ecmd)))
+			return -EFAULT;
+		return 0;
+	}
+
+	/* Set settings */
+	case ETHTOOL_SSET: {
+		struct ethtool_cmd ecmd;
+		u_char cr;
+		u_long flags;
+
+		/* DE205 is the only card with anything to set */
+		if (lp->adapter_name[4] != '5')
+			return -EOPNOTSUPP;
+
+		if (copy_from_user(&ecmd, useraddr, sizeof(ecmd)))
+			return -EFAULT;
+
+		/* Sanity-check parameters */
+		if (ecmd.speed != SPEED_10)
+			return -EINVAL;
+		if (ecmd.port != PORT_TP && ecmd.port != PORT_BNC)
+			return -EINVAL; /* AUI is not software-selectable */
+		if (ecmd.transceiver != XCVR_INTERNAL)
+			return -EINVAL;
+		if (ecmd.duplex != DUPLEX_HALF)
+			return -EINVAL;
+		if (ecmd.phy_address != 0)
+			return -EINVAL;
+
+		spin_lock_irqsave(&lp->hw_lock, flags);
+		cr = inb(EWRK3_CR);
+
+		/* If Autoneg is set, change to Auto Port mode */
+		/* Otherwise, disable Auto Port and set port explicitly */
+		if (ecmd.autoneg) {
+			cr &= ~CR_APD;
+		} else {
+			cr |= CR_APD;
+			if (ecmd.port == PORT_TP)
+				cr &= ~CR_PSEL;		/* Force TP */
+			else
+				cr |= CR_PSEL;		/* Force BNC */
+		}
+
+		/* Commit the changes */
+		outb(cr, EWRK3_CR);
+
+		spin_unlock_irqrestore(&lp->hw_lock, flags);
+		if (copy_to_user(useraddr, &ecmd, sizeof(ecmd)))
+			return -EFAULT;
+		return 0;
+	}
+
+	/* Get link status */
+	case ETHTOOL_GLINK: {
+		struct ethtool_value edata = { ETHTOOL_GLINK };
+		u_char cmr = inb(EWRK3_CMR);
+
+		/* DE203 has BNC only and link status does not apply */
+		if (lp->adapter_name[4] == '3')
+			return -EOPNOTSUPP;
+
+		/* On DE204 this is always valid since TP is the only port. */
+		/* On DE205 this reflects TP status even if BNC or AUI is selected. */
+		edata.data = !(cmr & CMR_LINK);
+
+		if (copy_to_user(useraddr, &edata, sizeof(edata)))
+			return -EFAULT;
+		return 0;
+	}
+
+	/* Blink LED for identification */
+	case ETHTOOL_PHYS_ID: {
+		struct ethtool_value edata;
+		u_long flags;
+		long delay, ret;
+		u_char cr;
+		int count;
+		wait_queue_head_t wait;
+
+		init_waitqueue_head(&wait);
+
+		if (copy_from_user(&edata, useraddr, sizeof(edata)))
+			return -EFAULT;
+
+		/* Toggle LED 4x per second */
+		delay = HZ >> 2;
+		count = edata.data << 2;
+
+		spin_lock_irqsave(&lp->hw_lock, flags);
+
+		/* Bail if a PHYS_ID is already in progress */
+		if (lp->led_mask == 0) {
+			spin_unlock_irqrestore(&lp->hw_lock, flags);
+			return -EBUSY;
+		}
+
+		/* Prevent ISR from twiddling the LED */
+		lp->led_mask = 0;
+
+		while (count--) {
+			/* Toggle the LED */
+			cr = inb(EWRK3_CR);
+			outb(cr ^ CR_LED, EWRK3_CR);
+
+			/* Wait a little while */
+			spin_unlock_irqrestore(&lp->hw_lock, flags);
+			ret = delay;
+			__wait_event_interruptible_timeout(wait, 0, ret);
+			spin_lock_irqsave(&lp->hw_lock, flags);
+
+			/* Exit if we got a signal */
+			if (ret == -ERESTARTSYS)
+				goto out;
+		}
+
+		ret = 0;
+out:
+		lp->led_mask = CR_LED;
+		cr = inb(EWRK3_CR);
+		outb(cr & ~CR_LED, EWRK3_CR);
+		spin_unlock_irqrestore(&lp->hw_lock, flags);
+		return ret;
+	}
+
+	}
+
+	return -EOPNOTSUPP;
+}
+
 /*
    ** Perform IOCTL call functions here. Some are privileged operations and the
    ** effective uid is checked in those cases.
@@ -1642,6 +1837,10 @@
 	
 	union ewrk3_addr *tmp;
 
+	/* ethtool IOCTLs are handled elsewhere */
+	if (cmd == SIOCETHTOOL)
+		return ewrk3_ethtool_ioctl(dev, (void *)rq->ifr_data);
+
 	tmp = kmalloc(sizeof(union ewrk3_addr), GFP_KERNEL);
 	if(tmp==NULL)
 		return -ENOMEM;
@@ -1854,7 +2053,7 @@
 #ifdef MODULE
 static struct net_device *ewrk3_devs[MAX_NUM_EWRK3S];
 static int ndevs;
-static int io[MAX_NUM_EWRK3S+1] = { 0x300, 0, };		/* <--- EDIT THESE LINES FOR YOUR CONFIGURATION */
+static int io[MAX_NUM_EWRK3S+1] = { 0x300, 0, };	/* <--- EDIT THESE LINES FOR YOUR CONFIGURATION */
 static int irq[MAX_NUM_EWRK3S+1] = { 5, 0, };		/* or use the insmod io= irq= options           */
 
 /* '21' below should really be 'MAX_NUM_EWRK3S' */
@@ -1895,8 +2094,7 @@
 {
 	int i;
 
-	for( i=0; i<ndevs; i++ )
-	{
+	for( i=0; i<ndevs; i++ ) {
 		unregister_netdev(ewrk3_devs[i]);
 		if (ewrk3_devs[i]->priv) {
 			kfree(ewrk3_devs[i]->priv);

