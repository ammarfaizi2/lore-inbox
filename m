Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265476AbSJSCb6>; Fri, 18 Oct 2002 22:31:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265477AbSJSCb6>; Fri, 18 Oct 2002 22:31:58 -0400
Received: from roc-24-93-20-125.rochester.rr.com ([24.93.20.125]:26617 "EHLO
	www.kroptech.com") by vger.kernel.org with ESMTP id <S265476AbSJSCb5>;
	Fri, 18 Oct 2002 22:31:57 -0400
Date: Fri, 18 Oct 2002 22:37:54 -0400
From: Adam Kropelin <akropel1@rochester.rr.com>
To: jgarzik@pobox.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.5: ewrk3 ioctl locking fixups
Message-ID: <20021019023754.GA10058@www.kroptech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds some locking fixups to the ewrk3 ioctl routine. None of these
are critical since the ioctls AFAIK are used only by the EEPROM config utility.

Applies against 2.5.34 + ewrk3-ethtool + ewrk3-clisti. Relies only on the
cli/sti patch.

--Adam

--- linux-2.5.43-mm1/drivers/net/ewrk3.c	Fri Oct 18 22:26:24 2002
+++ linux-2.5.43-mm1/drivers/net/ewrk3.c.new	Fri Oct 18 22:17:11 2002
@@ -1844,6 +1844,10 @@
 	if (cmd == SIOCETHTOOL)
 		return ewrk3_ethtool_ioctl(dev, (void *)rq->ifr_data);
 
+	/* Other than ethtool, all we handle are private IOCTLs */
+	if (cmd != EWRK3IOCTL)
+		return -EOPNOTSUPP;
+
 	tmp = kmalloc(sizeof(union ewrk3_addr), GFP_KERNEL);
 	if(tmp==NULL)
 		return -ENOMEM;
@@ -1860,21 +1864,26 @@
 		
 	case EWRK3_SET_HWADDR:	/* Set the hardware address */
 		if (capable(CAP_NET_ADMIN)) {
+			spin_lock_irqsave(&lp->hw_lock, flags);
 			csr = inb(EWRK3_CSR);
 			csr |= (CSR_TXD | CSR_RXD);
 			outb(csr, EWRK3_CSR);	/* Disable the TX and RX */
+			spin_unlock_irqrestore(&lp->hw_lock, flags);
 
 			if (copy_from_user(tmp->addr, ioc->data, ETH_ALEN)) {
 				status = -EFAULT;
 				break;
 			}
+			spin_lock_irqsave(&lp->hw_lock, flags);
 			for (i = 0; i < ETH_ALEN; i++) {
 				dev->dev_addr[i] = tmp->addr[i];
 				outb(tmp->addr[i], EWRK3_PAR0 + i);
 			}
 
+			csr = inb(EWRK3_CSR);
 			csr &= ~(CSR_TXD | CSR_RXD);	/* Enable the TX and RX */
 			outb(csr, EWRK3_CSR);
+			spin_unlock_irqrestore(&lp->hw_lock, flags);
 		} else {
 			status = -EPERM;
 		}
@@ -1882,10 +1891,12 @@
 		break;
 	case EWRK3_SET_PROM:	/* Set Promiscuous Mode */
 		if (capable(CAP_NET_ADMIN)) {
+			spin_lock_irqsave(&lp->hw_lock, flags);
 			csr = inb(EWRK3_CSR);
 			csr |= CSR_PME;
 			csr &= ~CSR_MCE;
 			outb(csr, EWRK3_CSR);
+			spin_unlock_irqrestore(&lp->hw_lock, flags);
 		} else {
 			status = -EPERM;
 		}
@@ -1893,16 +1904,18 @@
 		break;
 	case EWRK3_CLR_PROM:	/* Clear Promiscuous Mode */
 		if (capable(CAP_NET_ADMIN)) {
+			spin_lock_irqsave(&lp->hw_lock, flags);
 			csr = inb(EWRK3_CSR);
 			csr &= ~CSR_PME;
 			outb(csr, EWRK3_CSR);
+			spin_unlock_irqrestore(&lp->hw_lock, flags);
 		} else {
 			status = -EPERM;
 		}
 
 		break;
 	case EWRK3_GET_MCA:	/* Get the multicast address table */
-		spin_lock_irq(&lp->hw_lock);
+		spin_lock_irqsave(&lp->hw_lock, flags);
 		if (lp->shmem_length == IO_ONLY) {
 			outb(0, EWRK3_IOPR);
 			outw(PAGE0_HTE, EWRK3_PIR1);
@@ -1913,7 +1926,7 @@
 			outb(0, EWRK3_MPR);
 			isa_memcpy_fromio(tmp->addr, lp->shmem_base + PAGE0_HTE, (HASH_TABLE_LEN >> 3));
 		}
-		spin_unlock_irq(&lp->hw_lock);
+		spin_unlock_irqrestore(&lp->hw_lock, flags);
 
 		ioc->len = (HASH_TABLE_LEN >> 3);
 		if (copy_to_user(ioc->data, tmp->addr, ioc->len))
@@ -1947,10 +1960,12 @@
 		break;
 	case EWRK3_MCA_EN:	/* Enable multicast addressing */
 		if (capable(CAP_NET_ADMIN)) {
+			spin_lock_irqsave(&lp->hw_lock, flags);
 			csr = inb(EWRK3_CSR);
 			csr |= CSR_MCE;
 			csr &= ~CSR_PME;
 			outb(csr, EWRK3_CSR);
+			spin_unlock_irqrestore(&lp->hw_lock, flags);
 		} else {
 			status = -EPERM;
 		}

