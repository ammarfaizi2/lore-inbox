Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264167AbTEGS3Y (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 14:29:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264160AbTEGS3Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 14:29:24 -0400
Received: from relax.cmf.nrl.navy.mil ([134.207.10.227]:384 "EHLO
	relax.cmf.nrl.navy.mil") by vger.kernel.org with ESMTP
	id S264177AbTEGS2n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 14:28:43 -0400
Date: Wed, 7 May 2003 14:41:16 -0400
From: chas williams <chas@cmf.nrl.navy.mil>
Message-Id: <200305071841.h47IfGW00890@relax.cmf.nrl.navy.mil>
To: davem@redhat.com
Subject: [PATCH][ATM] assorted atm patches
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[ATM]: drivers/atm/Makefile does not need this

--- linux-2.5.68/drivers/atm/Makefile.001	Wed May  7 09:32:34 2003
+++ linux-2.5.68/drivers/atm/Makefile	Wed May  7 09:32:40 2003
@@ -2,8 +2,6 @@
 # Makefile for the Linux network (ATM) device drivers.
 #
 
-EXTRA_CFLAGS := -g
-
 fore_200e-objs	:= fore200e.o
 host-progs	:= fore200e_mkfirm
 


[ATM]: ixmicro (now rapidwan) produces a version of these cards but
       they put the end station identifier (mac address to etherheads)
       in a different location in the eeprom.

--- linux-2.5.68/drivers/atm/nicstar.c.000	Wed May  7 09:39:30 2003
+++ linux-2.5.68/drivers/atm/nicstar.c	Wed May  7 09:42:18 2003
@@ -882,9 +882,14 @@
       return error;
    }
       
-   if (ns_parse_mac(mac[i], card->atmdev->esi))
+   if (ns_parse_mac(mac[i], card->atmdev->esi)) {
       nicstar_read_eprom(card->membase, NICSTAR_EPROM_MAC_ADDR_OFFSET,
                          card->atmdev->esi, 6);
+      if (memcmp(card->atmdev->esi, "\x00\x00\x00\x00\x00\x00", 6) == 0) {
+         nicstar_read_eprom(card->membase, NICSTAR_EPROM_MAC_ADDR_OFFSET_ALT,
+                         card->atmdev->esi, 6);
+      }
+   }
 
    printk("nicstar%d: MAC address %02X:%02X:%02X:%02X:%02X:%02X\n", i,
           card->atmdev->esi[0], card->atmdev->esi[1], card->atmdev->esi[2],
--- linux-2.5.68/drivers/atm/nicstar.h.000	Wed May  7 09:39:34 2003
+++ linux-2.5.68/drivers/atm/nicstar.h	Wed May  7 09:39:43 2003
@@ -96,6 +96,7 @@
 /* ESI stuff ******************************************************************/
 
 #define NICSTAR_EPROM_MAC_ADDR_OFFSET 0x6C
+#define NICSTAR_EPROM_MAC_ADDR_OFFSET_ALT 0xF6
 
 
 /* #defines *******************************************************************/




[ATM]: its a good idea to make sure skb->cb is empty before passing the
       pdu's to the network stack (this will bite you on 64-bit platforms
       eventually)

--- linux-2.5.68/net/atm/br2684.c.000	Wed May  7 11:12:02 2003
+++ linux-2.5.68/net/atm/br2684.c	Wed May  7 11:38:45 2003
@@ -481,6 +481,7 @@
 	}
 	brdev->stats.rx_packets++;
 	brdev->stats.rx_bytes += skb->len;
+	memset(ATM_SKB(skb), 0, sizeof(struct atm_skb_data));
 	netif_rx(skb);
 }
 
--- linux-2.5.68/net/atm/clip.c.002	Wed May  7 11:12:08 2003
+++ linux-2.5.68/net/atm/clip.c	Wed May  7 11:38:59 2003
@@ -223,6 +223,7 @@
 	clip_vcc->last_use = jiffies;
 	PRIV(skb->dev)->stats.rx_packets++;
 	PRIV(skb->dev)->stats.rx_bytes += skb->len;
+	memset(ATM_SKB(skb), 0, sizeof(struct atm_skb_data));
 	netif_rx(skb);
 }
 
--- linux-2.5.68/net/atm/lec.c.003	Wed May  7 11:12:14 2003
+++ linux-2.5.68/net/atm/lec.c	Wed May  7 11:39:05 2003
@@ -721,6 +721,7 @@
                 skb->protocol = eth_type_trans(skb, dev);
                 priv->stats.rx_packets++;
                 priv->stats.rx_bytes += skb->len;
+                memset(ATM_SKB(skb), 0, sizeof(struct atm_skb_data));
                 netif_rx(skb);
         }
 }
--- linux-2.5.68/net/atm/mpc.c.002	Wed May  7 11:12:19 2003
+++ linux-2.5.68/net/atm/mpc.c	Wed May  7 11:39:11 2003
@@ -730,6 +730,7 @@
 	eg->packets_rcvd++;
 	mpc->eg_ops->put(eg);
 
+	memset(ATM_SKB(skb), 0, sizeof(struct atm_skb_data));
 	netif_rx(new_skb);
 
 	return;
--- linux-2.5.68/net/atm/br2684.c.000	Wed May  7 11:12:02 2003
+++ linux-2.5.68/net/atm/br2684.c	Wed May  7 11:38:45 2003
@@ -481,6 +481,7 @@
 	}
 	brdev->stats.rx_packets++;
 	brdev->stats.rx_bytes += skb->len;
+	memset(ATM_SKB(skb), 0, sizeof(struct atm_skb_data));
 	netif_rx(skb);
 }
 
--- linux-2.5.68/net/atm/clip.c.002	Wed May  7 11:12:08 2003
+++ linux-2.5.68/net/atm/clip.c	Wed May  7 11:38:59 2003
@@ -223,6 +223,7 @@
 	clip_vcc->last_use = jiffies;
 	PRIV(skb->dev)->stats.rx_packets++;
 	PRIV(skb->dev)->stats.rx_bytes += skb->len;
+	memset(ATM_SKB(skb), 0, sizeof(struct atm_skb_data));
 	netif_rx(skb);
 }
 
--- linux-2.5.68/net/atm/lec.c.003	Wed May  7 11:12:14 2003
+++ linux-2.5.68/net/atm/lec.c	Wed May  7 12:05:35 2003
@@ -721,6 +721,7 @@
                 skb->protocol = eth_type_trans(skb, dev);
                 priv->stats.rx_packets++;
                 priv->stats.rx_bytes += skb->len;
+                memset(ATM_SKB(skb), 0, sizeof(struct atm_skb_data));
                 netif_rx(skb);
         }
 }
--- linux-2.5.68/net/atm/mpc.c.002	Wed May  7 11:12:19 2003
+++ linux-2.5.68/net/atm/mpc.c	Wed May  7 12:05:16 2003
@@ -730,6 +730,7 @@
 	eg->packets_rcvd++;
 	mpc->eg_ops->put(eg);
 
+	memset(ATM_SKB(new_skb), 0, sizeof(struct atm_skb_data));
 	netif_rx(new_skb);
 
 	return;



[ATM]: ATM_PDU_OVHD is 0, isnt used consistently and probably should
       just go away (it might be more useful to have something like 
       hard_trailer_len).  overloading driver->tx_alloc() doesnt work
       for skb's coming from the network.  the driver->send() routine
       should just deal with poorly aligned skb's.  the default 
       alignment from alloc_tx() meets the needs for all drivers.
       further, no driver actually takes advantage of this feature.
       driver->free_rx_skb() isn't used and should just go away.

--- linux-2.5.68/include/linux/atmdev.h.002	Wed May  7 09:47:39 2003
+++ linux-2.5.68/include/linux/atmdev.h	Wed May  7 09:49:07 2003
@@ -30,9 +30,6 @@
 #define ATM_DS3_PCR	(8000*12)
 			/* DS3: 12 cells in a 125 usec time slot */
 
-#define ATM_PDU_OVHD	0	/* number of bytes to charge against buffer
-				   quota per PDU */
-
 #define atm_sk(__sk) ((struct atm_vcc *)(__sk)->protinfo)
 #define ATM_SD(s)	(atm_sk((s)->sk))
 
@@ -289,10 +286,6 @@
 	struct atm_sap	sap;		/* SAP */
 	void (*push)(struct atm_vcc *vcc,struct sk_buff *skb);
 	void (*pop)(struct atm_vcc *vcc,struct sk_buff *skb); /* optional */
-	struct sk_buff *(*alloc_tx)(struct atm_vcc *vcc,unsigned int size);
-					/* TX allocation routine - can be */
-					/* modified by protocol or by driver.*/
-					/* NOTE: this interface will change */
 	int (*push_oam)(struct atm_vcc *vcc,void *cell);
 	int (*send)(struct atm_vcc *vcc,struct sk_buff *skb);
 	void		*dev_data;	/* per-device data */
@@ -378,8 +371,6 @@
 	void (*feedback)(struct atm_vcc *vcc,struct sk_buff *skb,
 	    unsigned long start,unsigned long dest,int len);
 	int (*change_qos)(struct atm_vcc *vcc,struct atm_qos *qos,int flags);
-	void (*free_rx_skb)(struct atm_vcc *vcc, struct sk_buff *skb);
-		/* @@@ temporary hack */
 	int (*proc_read)(struct atm_dev *dev,loff_t *pos,char *page);
 	struct module *owner;
 };
@@ -421,19 +412,19 @@
 
 static __inline__ void atm_force_charge(struct atm_vcc *vcc,int truesize)
 {
-	atomic_add(truesize+ATM_PDU_OVHD,&vcc->sk->rmem_alloc);
+	atomic_add(truesize, &vcc->sk->rmem_alloc);
 }
 
 
 static __inline__ void atm_return(struct atm_vcc *vcc,int truesize)
 {
-	atomic_sub(truesize+ATM_PDU_OVHD,&vcc->sk->rmem_alloc);
+	atomic_sub(truesize, &vcc->sk->rmem_alloc);
 }
 
 
 static __inline__ int atm_may_send(struct atm_vcc *vcc,unsigned int size)
 {
-	return size+atomic_read(&vcc->sk->wmem_alloc)+ATM_PDU_OVHD < vcc->sk->sndbuf;
+	return (size + atomic_read(&vcc->sk->wmem_alloc)) < vcc->sk->sndbuf;
 }
 
 
--- linux-2.5.68/net/atm/mpc.c.001	Wed May  7 09:58:40 2003
+++ linux-2.5.68/net/atm/mpc.c	Wed May  7 09:58:57 2003
@@ -861,7 +861,7 @@
 	
 	struct mpoa_client *mpc = find_mpc_by_vcc(vcc);
 	struct k_message *mesg = (struct k_message*)skb->data;
-	atomic_sub(skb->truesize+ATM_PDU_OVHD, &vcc->sk->wmem_alloc);
+	atomic_sub(skb->truesize, &vcc->sk->wmem_alloc);
 	
 	if (mpc == NULL) {
 		printk("mpoa: msg_from_mpoad: no mpc found\n");
--- linux-2.5.68/net/atm/signaling.c.001	Wed May  7 09:59:08 2003
+++ linux-2.5.68/net/atm/signaling.c	Wed May  7 09:59:20 2003
@@ -98,7 +98,7 @@
 	struct atm_vcc *session_vcc;
 
 	msg = (struct atmsvc_msg *) skb->data;
-	atomic_sub(skb->truesize+ATM_PDU_OVHD,&vcc->sk->wmem_alloc);
+	atomic_sub(skb->truesize, &vcc->sk->wmem_alloc);
 	DPRINTK("sigd_send %d (0x%lx)\n",(int) msg->type,
 	  (unsigned long) msg->vcc);
 	vcc = *(struct atm_vcc **) &msg->vcc;
--- linux-2.5.68/net/atm/raw.c.000	Wed May  7 10:05:08 2003
+++ linux-2.5.68/net/atm/raw.c	Wed May  7 10:05:23 2003
@@ -37,7 +37,7 @@
 static void atm_pop_raw(struct atm_vcc *vcc,struct sk_buff *skb)
 {
 	DPRINTK("APopR (%d) %d -= %d\n",vcc->vci,vcc->sk->wmem_alloc,skb->truesize);
-	atomic_sub(skb->truesize+ATM_PDU_OVHD,&vcc->sk->wmem_alloc);
+	atomic_sub(skb->truesize, &vcc->sk->wmem_alloc);
 	dev_kfree_skb_any(skb);
 	wake_up(&vcc->sleep);
 }
--- linux-2.5.68/net/atm/common.c.002	Wed May  7 09:56:24 2003
+++ linux-2.5.68/net/atm/common.c	Wed May  7 10:09:57 2003
@@ -98,7 +98,7 @@
 	}
 	while (!(skb = alloc_skb(size,GFP_KERNEL))) schedule();
 	DPRINTK("AlTx %d += %d\n",atomic_read(&vcc->sk->wmem_alloc),skb->truesize);
-	atomic_add(skb->truesize+ATM_PDU_OVHD,&vcc->sk->wmem_alloc);
+	atomic_add(skb->truesize, &vcc->sk->wmem_alloc);
 	return skb;
 }
 
@@ -114,7 +114,6 @@
 	vcc = atm_sk(sk);
 	memset(&vcc->flags,0,sizeof(vcc->flags));
 	vcc->dev = NULL;
-	vcc->alloc_tx = alloc_tx;
 	vcc->callback = NULL;
 	memset(&vcc->local,0,sizeof(struct sockaddr_atmsvc));
 	memset(&vcc->remote,0,sizeof(struct sockaddr_atmsvc));
@@ -144,9 +143,7 @@
 		if (vcc->push) vcc->push(vcc,NULL); /* atmarpd has no push */
 		while ((skb = skb_dequeue(&vcc->sk->receive_queue))) {
 			atm_return(vcc,skb->truesize);
-			if (vcc->dev->ops->free_rx_skb)
-				vcc->dev->ops->free_rx_skb(vcc,skb);
-			else kfree_skb(skb);
+			kfree_skb(skb);
 		}
 		spin_lock (&atm_dev_lock);	
 		fops_put (vcc->dev->ops);
@@ -412,13 +409,11 @@
 			el -= (iov->iov_len > el)?el:iov->iov_len;
 			iov++;
 		}
-		if (!vcc->dev->ops->free_rx_skb) kfree_skb(skb);
-		else vcc->dev->ops->free_rx_skb(vcc, skb);
+		kfree_skb(skb);
 		return error ? error : eff_len;
 	}
 	error = copy_to_user(buff,skb->data,eff_len) ? -EFAULT : 0;
-	if (!vcc->dev->ops->free_rx_skb) kfree_skb(skb);
-	else vcc->dev->ops->free_rx_skb(vcc, skb);
+	kfree_skb(skb);
 	return error ? error : eff_len;
 }
 
@@ -450,7 +445,7 @@
 	add_wait_queue(&vcc->sleep,&wait);
 	set_current_state(TASK_INTERRUPTIBLE);
 	error = 0;
-	while (!(skb = vcc->alloc_tx(vcc,eff))) {
+	while (!(skb = alloc_tx(vcc,eff))) {
 		if (m->msg_flags & MSG_DONTWAIT) {
 			error = -EAGAIN;
 			break;
@@ -502,8 +497,7 @@
 		mask |= POLLHUP;
 	if (sock->state != SS_CONNECTING) {
 		if (vcc->qos.txtp.traffic_class != ATM_NONE &&
-		    vcc->qos.txtp.max_sdu+atomic_read(&vcc->sk->wmem_alloc)+
-		    ATM_PDU_OVHD <= vcc->sk->sndbuf)
+		    vcc->qos.txtp.max_sdu+atomic_read(&vcc->sk->wmem_alloc) <= vcc->sk->sndbuf)
 			mask |= POLLOUT | POLLWRNORM;
 	}
 	else if (vcc->reply != WAITING) {
@@ -570,7 +564,7 @@
 				goto done;
 			}
 			ret_val =  put_user(vcc->sk->sndbuf-
-			    atomic_read(&vcc->sk->wmem_alloc)-ATM_PDU_OVHD,
+			    atomic_read(&vcc->sk->wmem_alloc),
 			    (int *) arg) ? -EFAULT : 0;
 			goto done;
 		case SIOCINQ:
--- linux-2.5.68/drivers/atm/lanai.c.000	Wed May  7 10:10:20 2003
+++ linux-2.5.68/drivers/atm/lanai.c	Wed May  7 10:10:32 2003
@@ -2841,7 +2841,6 @@
 	.phy_get	= NULL,
 	.feedback	= NULL,
 	.change_qos	= lanai_change_qos,
-	.free_rx_skb	= NULL,
 	.proc_read	= lanai_proc_read
 };
 
--- linux-2.5.68/drivers/atm/idt77252.c.000	Wed May  7 10:32:34 2003
+++ linux-2.5.68/drivers/atm/idt77252.c	Wed May  7 10:32:57 2003
@@ -2025,7 +2025,7 @@
 		atomic_inc(&vcc->stats->tx_err);
 		return -ENOMEM;
 	}
-	atomic_add(skb->truesize + ATM_PDU_OVHD, &vcc->sk->wmem_alloc);
+	atomic_add(skb->truesize, &vcc->sk->wmem_alloc);
 	ATM_SKB(skb)->iovcnt = 0;
 
 	memcpy(skb_put(skb, 52), cell, 52);




[ATM]: cleanup some oddities in the he driver (most are historical
       for one reason or another -- at one point iov_base did actually
       hold a pointer)  also, fixed a comment that was wrong.  the
       he finally has aal0 transmit support.

--- linux-2.5.68/drivers/atm/he.h.000	Wed May  7 07:11:29 2003
+++ linux-2.5.68/drivers/atm/he.h	Wed May  7 07:26:45 2003
@@ -355,10 +355,18 @@
 	struct he_dev *next;
 };
 
+struct he_iovec
+{
+	u32 iov_base;
+	u32 iov_len;
+};
+
+#define HE_MAXIOV 20
+
 struct he_vcc
 {
-	struct iovec iov_head[32];
-	struct iovec *iov_tail;
+	struct he_iovec iov_head[HE_MAXIOV];
+	struct he_iovec *iov_tail;
 	int pdu_len;
 
 	int rc_index;
--- linux-2.5.68/drivers/atm/he.c.000	Wed May  7 07:13:22 2003
+++ linux-2.5.68/drivers/atm/he.c	Wed May  7 07:40:18 2003
@@ -51,7 +51,7 @@
 	4096 supported 'connections'
 	group 0 is used for all traffic
 	interrupt queue 0 is used for all interrupts
-	aal0 support for receive only
+	aal0 support (based on work from ulrich.u.muller@nokia.com)
 
  */
 
@@ -114,16 +114,13 @@
 
 #include <linux/atm_he.h>
 
-#define hprintk(fmt,args...)	printk(DEV_LABEL "%d: " fmt, he_dev->number, args)
-#define hprintk1(fmt)		printk(DEV_LABEL "%d: " fmt, he_dev->number)
+#define hprintk(fmt,args...)	printk(KERN_ERR DEV_LABEL "%d: " fmt, he_dev->number, ##args)
 
 #undef DEBUG
 #ifdef DEBUG
 #define HPRINTK(fmt,args...)	hprintk(fmt,args)
-#define HPRINTK1(fmt)		hprintk1(fmt)
 #else
-#define HPRINTK(fmt,args...)
-#define HPRINTK1(fmt,args...)
+#define HPRINTK(fmt,args...)	do { } while(0)
 #endif /* DEBUG */
 
 
@@ -131,10 +128,6 @@
 
 static char *version = "$Id: he.c,v 1.18 2003/05/06 22:57:15 chas Exp $";
 
-/* defines */
-#define ALIGN_ADDRESS(addr, alignment) \
-	((((unsigned long) (addr)) + (((unsigned long) (alignment)) - 1)) & ~(((unsigned long) (alignment)) - 1))
-
 /* declarations */
 
 static int he_open(struct atm_vcc *vcc, short vpi, int vci);
@@ -555,7 +548,7 @@
 		CONFIG_TPDRQ_SIZE * sizeof(struct he_tpdrq), &he_dev->tpdrq_phys);
 	if (he_dev->tpdrq_base == NULL) 
 	{
-		hprintk1("failed to alloc tpdrq\n");
+		hprintk("failed to alloc tpdrq\n");
 		return -ENOMEM;
 	}
 	memset(he_dev->tpdrq_base, 0,
@@ -799,14 +792,14 @@
 #endif
 	if (he_dev->rbps_pool == NULL)
 	{
-		hprintk1("unable to create rbps pages\n");
+		hprintk("unable to create rbps pages\n");
 		return -ENOMEM;
 	}
 #else /* !USE_RBPS_POOL */
 	he_dev->rbps_pages = pci_alloc_consistent(he_dev->pci_dev,
 		CONFIG_RBPS_SIZE * CONFIG_RBPS_BUFSIZE, &he_dev->rbps_pages_phys);
 	if (he_dev->rbps_pages == NULL) {
-		hprintk1("unable to create rbps page pool\n");
+		hprintk("unable to create rbps page pool\n");
 		return -ENOMEM;
 	}
 #endif /* USE_RBPS_POOL */
@@ -815,7 +808,7 @@
 		CONFIG_RBPS_SIZE * sizeof(struct he_rbp), &he_dev->rbps_phys);
 	if (he_dev->rbps_base == NULL)
 	{
-		hprintk1("failed to alloc rbps\n");
+		hprintk("failed to alloc rbps\n");
 		return -ENOMEM;
 	}
 	memset(he_dev->rbps_base, 0, CONFIG_RBPS_SIZE * sizeof(struct he_rbp));
@@ -871,7 +864,7 @@
 #endif
 	if (he_dev->rbpl_pool == NULL)
 	{
-		hprintk1("unable to create rbpl pool\n");
+		hprintk("unable to create rbpl pool\n");
 		return -ENOMEM;
 	}
 #else /* !USE_RBPL_POOL */
@@ -879,7 +872,7 @@
 		CONFIG_RBPL_SIZE * CONFIG_RBPL_BUFSIZE, &he_dev->rbpl_pages_phys);
 	if (he_dev->rbpl_pages == NULL)
 	{
-		hprintk1("unable to create rbpl pages\n");
+		hprintk("unable to create rbpl pages\n");
 		return -ENOMEM;
 	}
 #endif /* USE_RBPL_POOL */
@@ -888,7 +881,7 @@
 		CONFIG_RBPL_SIZE * sizeof(struct he_rbp), &he_dev->rbpl_phys);
 	if (he_dev->rbpl_base == NULL)
 	{
-		hprintk1("failed to alloc rbpl\n");
+		hprintk("failed to alloc rbpl\n");
 		return -ENOMEM;
 	}
 	memset(he_dev->rbpl_base, 0, CONFIG_RBPL_SIZE * sizeof(struct he_rbp));
@@ -932,7 +925,7 @@
 		CONFIG_RBRQ_SIZE * sizeof(struct he_rbrq), &he_dev->rbrq_phys);
 	if (he_dev->rbrq_base == NULL)
 	{
-		hprintk1("failed to allocate rbrq\n");
+		hprintk("failed to allocate rbrq\n");
 		return -ENOMEM;
 	}
 	memset(he_dev->rbrq_base, 0, CONFIG_RBRQ_SIZE * sizeof(struct he_rbrq));
@@ -945,7 +938,7 @@
 						G0_RBRQ_Q + (group * 16));
 	if (irq_coalesce)
 	{
-		hprintk1("coalescing interrupts\n");
+		hprintk("coalescing interrupts\n");
 		he_writel(he_dev, RBRQ_TIME(768) | RBRQ_COUNT(7),
 						G0_RBRQ_I + (group * 16));
 	}
@@ -959,7 +952,7 @@
 		CONFIG_TBRQ_SIZE * sizeof(struct he_tbrq), &he_dev->tbrq_phys);
 	if (he_dev->tbrq_base == NULL)
 	{
-		hprintk1("failed to allocate tbrq\n");
+		hprintk("failed to allocate tbrq\n");
 		return -ENOMEM;
 	}
 	memset(he_dev->tbrq_base, 0, CONFIG_TBRQ_SIZE * sizeof(struct he_tbrq));
@@ -986,7 +979,7 @@
 			(CONFIG_IRQ_SIZE+1) * sizeof(struct he_irq), &he_dev->irq_phys);
 	if (he_dev->irq_base == NULL)
 	{
-		hprintk1("failed to allocate irq\n");
+		hprintk("failed to allocate irq\n");
 		return -ENOMEM;
 	}
 	he_dev->irq_tailoffset = (unsigned *)
@@ -1074,32 +1067,32 @@
 	/* 4.3 pci bus controller-specific initialization */
 	if (pci_read_config_dword(pci_dev, GEN_CNTL_0, &gen_cntl_0) != 0)
 	{
-		hprintk1("can't read GEN_CNTL_0\n");
+		hprintk("can't read GEN_CNTL_0\n");
 		return -EINVAL;
 	}
 	gen_cntl_0 |= (MRL_ENB | MRM_ENB | IGNORE_TIMEOUT);
 	if (pci_write_config_dword(pci_dev, GEN_CNTL_0, gen_cntl_0) != 0)
 	{
-		hprintk1("can't write GEN_CNTL_0.\n");
+		hprintk("can't write GEN_CNTL_0.\n");
 		return -EINVAL;
 	}
 
 	if (pci_read_config_word(pci_dev, PCI_COMMAND, &command) != 0)
 	{
-		hprintk1("can't read PCI_COMMAND.\n");
+		hprintk("can't read PCI_COMMAND.\n");
 		return -EINVAL;
 	}
 
 	command |= (PCI_COMMAND_MEMORY | PCI_COMMAND_MASTER | PCI_COMMAND_INVALIDATE);
 	if (pci_write_config_word(pci_dev, PCI_COMMAND, command) != 0)
 	{
-		hprintk1("can't enable memory.\n");
+		hprintk("can't enable memory.\n");
 		return -EINVAL;
 	}
 
 	if (pci_read_config_byte(pci_dev, PCI_CACHE_LINE_SIZE, &cache_size))
 	{
-		hprintk1("can't read cache line size?\n");
+		hprintk("can't read cache line size?\n");
 		return -EINVAL;
 	}
 
@@ -1112,7 +1105,7 @@
 
 	if (pci_read_config_byte(pci_dev, PCI_LATENCY_TIMER, &timer))
 	{
-		hprintk1("can't read latency timer?\n");
+		hprintk("can't read latency timer?\n");
 		return -EINVAL;
 	}
 
@@ -1134,7 +1127,7 @@
 	}
 
 	if (!(he_dev->membase = (unsigned long) ioremap(he_dev->membase, HE_REGMAP_SIZE))) {
-		hprintk1("can't set up page mapping\n");
+		hprintk("can't set up page mapping\n");
 		return -EINVAL;
 	}
 	      
@@ -1146,7 +1139,7 @@
 	status = he_readl(he_dev, RESET_CNTL);
 	if ((status & BOARD_RST_STATUS) == 0)
 	{
-		hprintk1("reset failed\n");
+		hprintk("reset failed\n");
 		return -EINVAL;
 	}
 
@@ -1159,11 +1152,11 @@
 
 	if (disable64 == 1)
 	{
-		hprintk1("disabling 64-bit pci bus transfers\n");
+		hprintk("disabling 64-bit pci bus transfers\n");
 		gen_cntl_0 &= ~ENBL_64;
 	}
 
-	if (gen_cntl_0 & ENBL_64) hprintk1("64-bit transfers enabled\n");
+	if (gen_cntl_0 & ENBL_64) hprintk("64-bit transfers enabled\n");
 
 	pci_write_config_dword(pci_dev, GEN_CNTL_0, gen_cntl_0);
 
@@ -1535,7 +1528,7 @@
 #endif
 	if (he_dev->tpd_pool == NULL)
 	{
-		hprintk1("unable to create tpd pci_pool\n");
+		hprintk("unable to create tpd pci_pool\n");
 		return -ENOMEM;         
 	}
 
@@ -1592,7 +1585,7 @@
 				sizeof(struct he_hsp), &he_dev->hsp_phys);
 	if (he_dev->hsp == NULL)
 	{
-		hprintk1("failed to allocate host status page\n");
+		hprintk("failed to allocate host status page\n");
 		return -ENOMEM;
 	}
 	memset(he_dev->hsp, 0, sizeof(struct he_hsp));
@@ -1632,7 +1625,7 @@
 			(1 << (he_dev->vcibits + he_dev->vpibits)), GFP_KERNEL);
 	if (he_dev->he_vcc_table == NULL)
 	{
-		hprintk1("failed to alloc he_vcc_table\n");
+		hprintk("failed to alloc he_vcc_table\n");
 		return -ENOMEM;
 	}
 	memset(he_dev->he_vcc_table, 0, sizeof(struct he_vcc_table) *
@@ -1868,7 +1861,7 @@
 	struct sk_buff *skb;
 	struct atm_vcc *vcc = NULL;
 	struct he_vcc *he_vcc;
-	struct iovec *iov;
+	struct he_iovec *iov;
 	int pdus_assembled = 0;
 	int updated = 0;
 
@@ -1934,7 +1927,7 @@
 			goto return_host_buffers;
 		}
 
-		he_vcc->iov_tail->iov_base = (void *) RBRQ_ADDR(he_dev->rbrq_head);
+		he_vcc->iov_tail->iov_base = RBRQ_ADDR(he_dev->rbrq_head);
 		he_vcc->iov_tail->iov_len = buf_len;
 		he_vcc->pdu_len += buf_len;
 		++he_vcc->iov_tail;
@@ -1948,7 +1941,7 @@
 		}
 
 #ifdef notdef
-		if (he_vcc->iov_tail - he_vcc->iov_head > 32)
+		if ((he_vcc->iov_tail - he_vcc->iov_head) > HE_MAXIOV)
 		{
 			hprintk("iovec full!  cid 0x%x\n", cid);
 			goto return_host_buffers;
@@ -2000,7 +1993,7 @@
 				iov < he_vcc->iov_tail; ++iov)
 		{
 #ifdef USE_RBPS
-			if ((u32)iov->iov_base & RBP_SMALLBUF)
+			if (iov->iov_base & RBP_SMALLBUF)
 				memcpy(skb_put(skb, iov->iov_len),
 					he_dev->rbps_virt[RBP_INDEX(iov->iov_base)].virt, iov->iov_len);
 			else
@@ -2055,7 +2048,7 @@
 				iov < he_vcc->iov_tail; ++iov)
 		{
 #ifdef USE_RBPS
-			if ((u32)iov->iov_base & RBP_SMALLBUF)
+			if (iov->iov_base & RBP_SMALLBUF)
 				rbp = &he_dev->rbps_base[RBP_INDEX(iov->iov_base)];
 			else
 #endif
@@ -2309,13 +2302,13 @@
 					he_dev->atm_dev->phy->interrupt(he_dev->atm_dev);
 				HE_SPIN_LOCK(he_dev, flags);
 #endif
-				HPRINTK1("phy interrupt\n");
+				HPRINTK("phy interrupt\n");
 				break;
 			case ITYPE_OTHER:
 				switch (type|group)
 				{
 					case ITYPE_PARITY:
-						hprintk1("parity error\n");
+						hprintk("parity error\n");
 						break;
 					case ITYPE_ABORT:
 						hprintk("abort 0x%x\n", he_readl(he_dev, ABORT_ADDR));
@@ -2387,7 +2380,7 @@
 
 	if (he_dev->irq_tail == he_dev->irq_head)
 	{
-		HPRINTK1("tailoffset not updated?\n");
+		HPRINTK("tailoffset not updated?\n");
 		he_dev->irq_tail = (struct he_irq *) ((unsigned long)he_dev->irq_base |
 			((he_readl(he_dev, IRQ0_BASE) & IRQ_MASK) << 2));
 		(void) he_readl(he_dev, INT_FIFO);	/* 8.1.2 controller errata */
@@ -2395,7 +2388,7 @@
 
 #ifdef DEBUG
 	if (he_dev->irq_head == he_dev->irq_tail /* && !IRQ_PENDING */)
-		hprintk1("spurious (or shared) interrupt?\n");
+		hprintk("spurious (or shared) interrupt?\n");
 #endif
 
 	if (he_dev->irq_head != he_dev->irq_tail)
@@ -2527,7 +2520,7 @@
 	he_vcc = (struct he_vcc *) kmalloc(sizeof(struct he_vcc), GFP_ATOMIC);
 	if (he_vcc == NULL)
 	{
-		hprintk1("unable to allocate he_vcc during open\n");
+		hprintk("unable to allocate he_vcc during open\n");
 		return -ENOMEM;
 	}
 
@@ -2987,7 +2980,7 @@
 #ifndef USE_SCATTERGATHER
 	if (skb_shinfo(skb)->nr_frags)
 	{
-		hprintk1("no scatter/gather support\n");
+		hprintk("no scatter/gather support\n");
 		if (vcc->pop)
 			vcc->pop(vcc, skb);
 		else
