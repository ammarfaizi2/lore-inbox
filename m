Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932239AbWC1VtH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932239AbWC1VtH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Mar 2006 16:49:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932249AbWC1VtG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Mar 2006 16:49:06 -0500
Received: from cust8446.nsw01.dataco.com.au ([203.171.93.254]:26063 "EHLO
	cust8446.nsw01.dataco.com.au") by vger.kernel.org with ESMTP
	id S932239AbWC1VtF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Mar 2006 16:49:05 -0500
From: Nigel Cunningham <ncunningham@cyclades.com>
Organization: Cyclades Corporation
To: Prakash Punnoor <prakash@punnoor.de>
Subject: Re: Issues with uli526x networking module
Date: Wed, 29 Mar 2006 07:47:32 +1000
User-Agent: KMail/1.9.1
Cc: linux-kernel <linux-kernel@vger.kernel.org>, jgarzik@pobox.com
References: <200601260900.57951.prakash@punnoor.de> <200601262110.48090.ncunningham@cyclades.com> <200603281930.53859.prakash@punnoor.de>
In-Reply-To: <200603281930.53859.prakash@punnoor.de>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart3867060.pLFUHy05HL";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200603290747.38402.ncunningham@cyclades.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart3867060.pLFUHy05HL
Content-Type: multipart/mixed;
  boundary="Boundary-01=_17aKE7VafrYZNl/"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

--Boundary-01=_17aKE7VafrYZNl/
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi.

On Wednesday 29 March 2006 03:30, Prakash Punnoor wrote:
> Hi, I am just wondering whether you found out what the issue is with the
> link problem. If you have some patch ready (even if it is hackish) I would
> be happy to use it.
>
> Anyways, I know you are busy with swsusp2. ;-)
>
> Cheers,

Yes, I do have a patch. It is hackish at the moment because as you've right=
ly=20
guessed, I haven't gotten around to finishing it. It also doesn't work=20
perfectly - I sometimes need to rmmod and insmod after booting a new kernel=
=20
to get the link to come up. But, apart from that, it works fine. Attached.=
=20
(Jeff, I'm sure it doesn't need saying, but please don't apply!)

Regards,

Nigel

--Boundary-01=_17aKE7VafrYZNl/
Content-Type: text/x-diff;
  charset="utf-8";
  name="180-uli-power-manaagement.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="180-uli-power-manaagement.patch"

 uli526x.c |  335 +++++++++++++++++++++++++++++++++++++++++++++++----------=
=2D----
 1 file changed, 255 insertions(+), 80 deletions(-)
diff -ruNp 180-uli-power-manaagement.patch-old/drivers/net/tulip/uli526x.c =
180-uli-power-manaagement.patch-new/drivers/net/tulip/uli526x.c
=2D-- 180-uli-power-manaagement.patch-old/drivers/net/tulip/uli526x.c	2006-=
03-13 10:02:46.000000000 +1000
+++ 180-uli-power-manaagement.patch-new/drivers/net/tulip/uli526x.c	2006-03=
=2D15 09:35:15.000000000 +1000
@@ -13,8 +13,8 @@
 */
=20
 #define DRV_NAME	"uli526x"
=2D#define DRV_VERSION	"0.9.3"
=2D#define DRV_RELDATE	"2005-7-29"
+#define DRV_VERSION	"0.9.4"
+#define DRV_RELDATE	"2006-1-17"
=20
 #include <linux/module.h>
=20
@@ -248,6 +248,68 @@ static void uli526x_set_phyxcer(struct u
=20
 /* ULI526X network board routine ---------------------------- */
=20
+static void uli526x_free_resources(struct uli526x_board_info *db)
+{
+	if(db->desc_pool_ptr) {
+		pci_free_consistent(db->pdev, sizeof(struct tx_desc) * DESC_ALL_CNT + 0x=
20,
+			db->desc_pool_ptr, db->desc_pool_dma_ptr);
+		db->desc_pool_ptr =3D NULL;
+	}
+		=09
+	if(db->buf_pool_ptr !=3D NULL) {
+		pci_free_consistent(db->pdev, TX_BUF_ALLOC * TX_DESC_CNT + 4,
+			db->buf_pool_ptr, db->buf_pool_dma_ptr);
+		db->buf_pool_ptr =3D NULL;
+	}
+}
+
+static int uli526x_get_resources(struct uli526x_board_info *db)
+{
+	/* Allocate Tx/Rx descriptor memory */
+	db->desc_pool_ptr =3D pci_alloc_consistent(db->pdev, sizeof(struct tx_des=
c) * DESC_ALL_CNT + 0x20, &db->desc_pool_dma_ptr);
+	if(!db->desc_pool_ptr)
+		return -ENOMEM;
+
+	db->buf_pool_ptr =3D pci_alloc_consistent(db->pdev, TX_BUF_ALLOC * TX_DES=
C_CNT + 4, &db->buf_pool_dma_ptr);
+	return db->buf_pool_ptr ? 0 : -ENOMEM;
+}
+
+static void do_reset(struct net_device *dev)
+{
+	struct uli526x_board_info *db =3D netdev_priv(dev);
+	int i;
+
+	printk("Do_reset\n");
+
+	/* read 64 word srom data */
+	for (i =3D 0; i < 64; i++)
+		((u16 *) db->srom)[i] =3D cpu_to_le16(read_srom_word(db->ioaddr, i));
+
+	/* Set Node address */
+	if(((u16 *) db->srom)[0] =3D=3D 0xffff || ((u16 *) db->srom)[0] =3D=3D 0)=
		/* SROM absent, so read MAC address from ID Table */
+	{
+		outl(0x10000, db->ioaddr + DCR0);	//Diagnosis mode
+		outl(0x1c0, db->ioaddr + DCR13);	//Reset dianostic pointer port
+		outl(0, db->ioaddr + DCR14);		//Clear reset port
+		outl(0x10, db->ioaddr + DCR14);		//Reset ID Table pointer
+		outl(0, db->ioaddr + DCR14);		//Clear reset port
+		outl(0, db->ioaddr + DCR13);		//Clear CR13
+		outl(0x1b0, db->ioaddr + DCR13);	//Select ID Table access port
+		//Read MAC address from CR14
+		for (i =3D 0; i < 6; i++)
+			dev->dev_addr[i] =3D inl(db->ioaddr + DCR14);
+		//Read end
+		outl(0, db->ioaddr + DCR13);	//Clear CR13
+		outl(0, db->ioaddr + DCR0);		//Clear CR0
+		udelay(10);
+	}
+	else		/*Exist SROM*/
+	{
+		for (i =3D 0; i < 6; i++)
+			dev->dev_addr[i] =3D db->srom[20 + i];
+	}
+}
+
 /*
  *	Search ULI526X board, allocate space and register it
  */
@@ -256,18 +318,30 @@ static int __devinit uli526x_init_one (s
 				    const struct pci_device_id *ent)
 {
 	struct uli526x_board_info *db;	/* board information structure */
=2D	struct net_device *dev;
+	struct net_device *dev =3D NULL;
 	int i, err;
 =09
 	ULI526X_DBUG(0, "uli526x_init_one()", 0);
+	printk("uli526x_init_one()\n");
=20
 	if (!printed_version++)
 		printk(version);
=20
+
+	/* Enable Master/IO access, Disable memory access */
+	err =3D pci_enable_device(pdev);
+	if (err)
+		goto err_out_free;
+
+	pci_set_power_state(pdev, PCI_D0);
+
 	/* Init network device */
 	dev =3D alloc_etherdev(sizeof(*db));
=2D	if (dev =3D=3D NULL)
=2D		return -ENOMEM;
+	if (dev =3D=3D NULL) {
+		err =3D -ENOMEM;
+		goto err_out_disable;
+	}
+
 	SET_MODULE_OWNER(dev);
 	SET_NETDEV_DEV(dev, &pdev->dev);
=20
@@ -277,11 +351,6 @@ static int __devinit uli526x_init_one (s
 		goto err_out_free;
 	}
=20
=2D	/* Enable Master/IO access, Disable memory access */
=2D	err =3D pci_enable_device(pdev);
=2D	if (err)
=2D		goto err_out_free;
=2D
 	if (!pci_resource_start(pdev, 0)) {
 		printk(KERN_ERR DRV_NAME ": I/O base is zero\n");
 		err =3D -ENODEV;
@@ -303,19 +372,9 @@ static int __devinit uli526x_init_one (s
 	/* Init system & device */
 	db =3D netdev_priv(dev);
=20
=2D	/* Allocate Tx/Rx descriptor memory */
=2D	db->desc_pool_ptr =3D pci_alloc_consistent(pdev, sizeof(struct tx_desc)=
 * DESC_ALL_CNT + 0x20, &db->desc_pool_dma_ptr);
=2D	if(db->desc_pool_ptr =3D=3D NULL)
=2D	{
=2D		err =3D -ENOMEM;
=2D		goto err_out_nomem;
=2D	}
=2D	db->buf_pool_ptr =3D pci_alloc_consistent(pdev, TX_BUF_ALLOC * TX_DESC_=
CNT + 4, &db->buf_pool_dma_ptr);
=2D	if(db->buf_pool_ptr =3D=3D NULL)
=2D	{
=2D		err =3D -ENOMEM;
+	err =3D uli526x_get_resources(db);
+	if (err)
 		goto err_out_nomem;
=2D	}
 =09
 	db->first_tx_desc =3D (struct tx_desc *) db->desc_pool_ptr;
 	db->first_tx_desc_dma =3D db->desc_pool_dma_ptr;
@@ -341,34 +400,8 @@ static int __devinit uli526x_init_one (s
 	dev->ethtool_ops =3D &netdev_ethtool_ops;
 	spin_lock_init(&db->lock);
=20
=2D	=09
=2D	/* read 64 word srom data */
=2D	for (i =3D 0; i < 64; i++)
=2D		((u16 *) db->srom)[i] =3D cpu_to_le16(read_srom_word(db->ioaddr, i));
+	do_reset(dev);
=20
=2D	/* Set Node address */
=2D	if(((u16 *) db->srom)[0] =3D=3D 0xffff || ((u16 *) db->srom)[0] =3D=3D =
0)		/* SROM absent, so read MAC address from ID Table */
=2D	{
=2D		outl(0x10000, db->ioaddr + DCR0);	//Diagnosis mode
=2D		outl(0x1c0, db->ioaddr + DCR13);	//Reset dianostic pointer port
=2D		outl(0, db->ioaddr + DCR14);		//Clear reset port
=2D		outl(0x10, db->ioaddr + DCR14);		//Reset ID Table pointer
=2D		outl(0, db->ioaddr + DCR14);		//Clear reset port
=2D		outl(0, db->ioaddr + DCR13);		//Clear CR13
=2D		outl(0x1b0, db->ioaddr + DCR13);	//Select ID Table access port
=2D		//Read MAC address from CR14
=2D		for (i =3D 0; i < 6; i++)
=2D			dev->dev_addr[i] =3D inl(db->ioaddr + DCR14);
=2D		//Read end
=2D		outl(0, db->ioaddr + DCR13);	//Clear CR13
=2D		outl(0, db->ioaddr + DCR0);		//Clear CR0
=2D		udelay(10);
=2D	}
=2D	else		/*Exist SROM*/
=2D	{
=2D		for (i =3D 0; i < 6; i++)
=2D			dev->dev_addr[i] =3D db->srom[20 + i];
=2D	}
 	err =3D register_netdev (dev);
 	if (err)
 		goto err_out_res;
@@ -379,25 +412,34 @@ static int __devinit uli526x_init_one (s
 		printk("%c%02x", i ? ':' : ' ', dev->dev_addr[i]);
 	printk(", irq %d.\n", dev->irq);
=20
+	pci_set_power_state(pdev, PCI_D0);
+
 	pci_set_master(pdev);
=20
+	printk("Register 0 is %x.\n", inl(db->ioaddr));
+	printk("Register 3 is %x.\n", inl(db->ioaddr + 0x18));
+	printk("Register 4 is %x.\n", inl(db->ioaddr + 0x20));
+	printk("Register 5 is %x.\n", inl(db->ioaddr + 0x28));
+	printk("Register 6 is %x.\n", inl(db->ioaddr + 0x30));
+	printk("Register 7 is %x.\n", inl(db->ioaddr + 0x38));
+	printk("Register 8 is %x.\n", inl(db->ioaddr + 0x40));
+	printk("Register 9 is %x.\n", inl(db->ioaddr + 0x48));
+	printk("Register 10 is %x.\n", inl(db->ioaddr + 0x50));
+	printk("Register 11 is %x.\n", inl(db->ioaddr + 0x58));
+	printk("Register 12 is %x.\n", inl(db->ioaddr + 0x60));
+	printk("Register 15 is %x.\n", inl(db->ioaddr + 0x78));
 	return 0;
=20
 err_out_res:
 	pci_release_regions(pdev);
 err_out_nomem:
=2D	if(db->desc_pool_ptr)
=2D		pci_free_consistent(pdev, sizeof(struct tx_desc) * DESC_ALL_CNT + 0x20,
=2D			db->desc_pool_ptr, db->desc_pool_dma_ptr);
=2D		=09
=2D	if(db->buf_pool_ptr !=3D NULL)
=2D		pci_free_consistent(pdev, TX_BUF_ALLOC * TX_DESC_CNT + 4,
=2D			db->buf_pool_ptr, db->buf_pool_dma_ptr);
+	uli526x_free_resources(db);
 err_out_disable:
 	pci_disable_device(pdev);
 err_out_free:
 	pci_set_drvdata(pdev, NULL);
=2D	free_netdev(dev);
+	if (dev)
+		free_netdev(dev);
=20
 	return err;
 }
@@ -410,15 +452,19 @@ static void __devexit uli526x_remove_one
=20
 	ULI526X_DBUG(0, "uli526x_remove_one()", 0);
=20
=2D	pci_free_consistent(db->pdev, sizeof(struct tx_desc) *
=2D				DESC_ALL_CNT + 0x20, db->desc_pool_ptr,
=2D 				db->desc_pool_dma_ptr);
=2D	pci_free_consistent(db->pdev, TX_BUF_ALLOC * TX_DESC_CNT + 4,
=2D				db->buf_pool_ptr, db->buf_pool_dma_ptr);
+	//20060306 - Uncommented
+	//netif_poll_disable(dev);
+=09
+	//netif_stop_queue(dev);
 	unregister_netdev(dev);
=2D	pci_release_regions(pdev);
+	uli526x_free_resources(db);
 	free_netdev(dev);	/* free board information */
+=09
+	//20060306 - Uncommented
+	//pci_iounmap(pdev, (void *) dev->base_addr);
+	pci_release_regions(pdev);
 	pci_set_drvdata(pdev, NULL);
+	pci_set_power_state(pdev, PCI_D3hot);
 	pci_disable_device(pdev);
 	ULI526X_DBUG(0, "uli526x_remove_one() exit", 0);
 }
@@ -435,6 +481,7 @@ static int uli526x_open(struct net_devic
 	struct uli526x_board_info *db =3D netdev_priv(dev);
 =09
 	ULI526X_DBUG(0, "uli526x_open", 0);
+	printk("uli526x_open\n");
=20
 	ret =3D request_irq(dev->irq, &uli526x_interrupt, SA_SHIRQ, dev->name, de=
v);
 	if (ret)
@@ -443,6 +490,7 @@ static int uli526x_open(struct net_devic
 	/* system variable init */
 	db->cr6_data =3D CR6_DEFAULT | uli526x_cr6_user_set;
 	db->tx_packet_cnt =3D 0;
+	//ULI526X_DBUG(0, "db->tx_packet_cnt reset to %d.", db->tx_packet_cnt);
 	db->rx_avail_cnt =3D 0;
 	db->link_failed =3D 1;
 	netif_carrier_off(dev);
@@ -488,6 +536,7 @@ static void uli526x_init(struct net_devi
 	u16 phy_reg_reset;
=20
 	ULI526X_DBUG(0, "uli526x_init()", 0);
+	printk("uli526x_init\n");
=20
 	/* Reset M526x MAC controller */
 	outl(ULI526X_RESET, ioaddr + DCR0);	/* RESET MAC */
@@ -557,7 +606,7 @@ static int uli526x_start_xmit(struct sk_
 	struct tx_desc *txptr;
 	unsigned long flags;
=20
=2D	ULI526X_DBUG(0, "uli526x_start_xmit", 0);
+	//ULI526X_DBUG(0, "uli526x_start_xmit", 0);
=20
 	/* Resource flag check */
 	netif_stop_queue(dev);
@@ -593,6 +642,7 @@ static int uli526x_start_xmit(struct sk_
 	if ( (db->tx_packet_cnt < TX_DESC_CNT) ) {
 		txptr->tdes0 =3D cpu_to_le32(0x80000000);	/* Set owner bit */
 		db->tx_packet_cnt++;			/* Ready to send */
+		//ULI526X_DBUG(0, "db->tx_packet_cnt =3D %d.", db->tx_packet_cnt);
 		outl(0x1, dev->base_addr + DCR1);	/* Issue Tx polling */
 		dev->trans_start =3D jiffies;		/* saved time stamp */
 	}
@@ -638,6 +688,8 @@ static int uli526x_stop(struct net_devic
 	/* free interrupt */
 	free_irq(dev->irq, dev);
=20
+	netif_carrier_off(dev);
+
 	/* free allocated rx buffer */
 	uli526x_free_rxbuffer(db);
=20
@@ -678,6 +730,7 @@ static irqreturn_t uli526x_interrupt(int
 	db->cr5_data =3D inl(ioaddr + DCR5);
 	outl(db->cr5_data, ioaddr + DCR5);
 	if ( !(db->cr5_data & 0x180c1) ) {
+		ULI526X_DBUG(1, "Earlier return. CR5=3D", db->cr5_data);
 		spin_unlock_irqrestore(&db->lock, flags);
 		outl(db->cr7_data, ioaddr + DCR7);
 		return IRQ_HANDLED;
@@ -698,7 +751,7 @@ static irqreturn_t uli526x_interrupt(int
 		uli526x_rx_packet(dev, db);
=20
 	/* reallocate rx descriptor buffer */
=2D	if (db->rx_avail_cnt<RX_DESC_CNT)
+	if (db->rx_avail_cnt < RX_DESC_CNT)
 		allocate_rx_buffer(db);
=20
 	/* Free the transmitted descriptor */
@@ -729,8 +782,10 @@ static void uli526x_free_tx_pkt(struct n
 		if (tdes0 & 0x80000000)
 			break;
=20
+		//ULI526X_DBUG(0, "Free tx pkt.\n", NULL);
 		/* A packet sent completed */
 		db->tx_packet_cnt--;
+		//ULI526X_DBUG(0, "db->tx_packet_cnt =3D %d.", db->tx_packet_cnt);
 		db->stats.tx_packets++;
=20
 		/* Transmit statistic counter */
@@ -788,10 +843,9 @@ static void uli526x_rx_packet(struct net
 	while(db->rx_avail_cnt) {
 		rdes0 =3D le32_to_cpu(rxptr->rdes0);
 		if (rdes0 & 0x80000000)	/* packet owner check */
=2D		{
 			break;
=2D		}
=20
+		//ULI526X_DBUG(0, "rx pkt.", NULL);
 		db->rx_avail_cnt--;
 		db->interval_rx_cnt++;
=20
@@ -799,7 +853,7 @@ static void uli526x_rx_packet(struct net
 		if ( (rdes0 & 0x300) !=3D 0x300) {
 			/* A packet without First/Last flag */
 			/* reuse this SKB */
=2D			ULI526X_DBUG(0, "Reuse SK buffer, rdes0", rdes0);
+			//ULI526X_DBUG(0, "Reuse SK buffer, rdes0", rdes0);
 			uli526x_reuse_skb(db, rxptr->rx_skb_ptr);
 		} else {
 			/* A packet with First/Last flag */
@@ -808,7 +862,7 @@ static void uli526x_rx_packet(struct net
 			/* error summary bit check */
 			if (rdes0 & 0x8000) {
 				/* This is a error packet */
=2D				//printk(DRV_NAME ": rdes0: %lx\n", rdes0);
+				printk(DRV_NAME ": rdes0: %x\n", rdes0);
 				db->stats.rx_errors++;
 				if (rdes0 & 1)
 					db->stats.rx_fifo_errors++;
@@ -844,7 +898,7 @@ static void uli526x_rx_packet(struct net
 			=09
 			} else {
 				/* Reuse SKB buffer when the packet is error */
=2D				ULI526X_DBUG(0, "Reuse SK buffer, rdes0", rdes0);
+				//ULI526X_DBUG(0, "Reuse SK buffer, rdes0", rdes0);
 				uli526x_reuse_skb(db, rxptr->rx_skb_ptr);
 			}
 		}
@@ -864,7 +918,7 @@ static struct net_device_stats * uli526x
 {
 	struct uli526x_board_info *db =3D netdev_priv(dev);
=20
=2D	ULI526X_DBUG(0, "uli526x_get_stats", 0);
+	//ULI526X_DBUG(0, "uli526x_get_stats", 0);
 	return &db->stats;
 }
=20
@@ -878,11 +932,11 @@ static void uli526x_set_filter_mode(stru
 	struct uli526x_board_info *db =3D dev->priv;
 	unsigned long flags;
=20
=2D	ULI526X_DBUG(0, "uli526x_set_filter_mode()", 0);
+	//ULI526X_DBUG(0, "uli526x_set_filter_mode()", 0);
 	spin_lock_irqsave(&db->lock, flags);
=20
 	if (dev->flags & IFF_PROMISC) {
=2D		ULI526X_DBUG(0, "Enable PROM Mode", 0);
+		//ULI526X_DBUG(0, "Enable PROM Mode", 0);
 		db->cr6_data |=3D CR6_PM | CR6_PBF;
 		update_cr6(db->cr6_data, db->ioaddr);
 		spin_unlock_irqrestore(&db->lock, flags);
@@ -890,14 +944,14 @@ static void uli526x_set_filter_mode(stru
 	}
=20
 	if (dev->flags & IFF_ALLMULTI || dev->mc_count > ULI5261_MAX_MULTICAST) {
=2D		ULI526X_DBUG(0, "Pass all multicast address", dev->mc_count);
+		//ULI526X_DBUG(0, "Pass all multicast address", dev->mc_count);
 		db->cr6_data &=3D ~(CR6_PM | CR6_PBF);
 		db->cr6_data |=3D CR6_PAM;
 		spin_unlock_irqrestore(&db->lock, flags);
 		return;
 	}
=20
=2D	ULI526X_DBUG(0, "Set multicast address", dev->mc_count);
+	//ULI526X_DBUG(0, "Set multicast address", dev->mc_count);
 	send_filter_frame(dev, dev->mc_count); 	/* M5261/M5263 */
 	spin_unlock_irqrestore(&db->lock, flags);
 }
@@ -1005,6 +1059,7 @@ static void uli526x_timer(unsigned long=20
 	struct uli526x_board_info *db =3D netdev_priv(dev);
  	unsigned long flags;
 	u8 TmpSpeed=3D10;
+	int link_status =3D 0;
 =09
 	//ULI526X_DBUG(0, "uli526x_timer()", 0);
 	spin_lock_irqsave(&db->lock, flags);
@@ -1023,6 +1078,7 @@ static void uli526x_timer(unsigned long=20
 	     time_after(jiffies, dev->trans_start + ULI526X_TX_KICK) ) {
 		outl(0x1, dev->base_addr + DCR1);   // Tx polling again=20
=20
+		//ULI526X_DBUG(0, "db->tx_packet_cnt =3D %d.", db->tx_packet_cnt);
 		// TX Timeout=20
 		if ( time_after(jiffies, dev->trans_start + ULI526X_TX_TIMEOUT) ) {
 			db->reset_TXtimeout++;
@@ -1043,7 +1099,9 @@ static void uli526x_timer(unsigned long=20
 	}
=20
 	/* Link status check, Dynamic media type change */
=2D	if((phy_read(db->ioaddr, db->phy_addr, 5, db->chip_id) & 0x01e0)!=3D0)
+	link_status =3D phy_read(db->ioaddr, db->phy_addr, 5, db->chip_id);
+	//ULI526X_DBUG(0, "Link status is ", link_status);
+	if (link_status & 0x1e0)
 		tmp_cr12 =3D 3;
=20
 	if ( !(tmp_cr12 & 0x3) && !db->link_failed ) {
@@ -1065,7 +1123,7 @@ static void uli526x_timer(unsigned long=20
 		}
 	} else
 		if ((tmp_cr12 & 0x3) && db->link_failed) {
=2D			ULI526X_DBUG(0, "Link link OK", tmp_cr12);
+			//ULI526X_DBUG(0, "Link link OK", tmp_cr12);
 			db->link_failed =3D 0;
=20
 			/* Auto Sense Speed */
@@ -1137,6 +1195,7 @@ static void uli526x_dynamic_reset(struct
=20
 	/* system variable init */
 	db->tx_packet_cnt =3D 0;
+	ULI526X_DBUG(0, "db->tx_packet_cnt reset to ", db->tx_packet_cnt);
 	db->rx_avail_cnt =3D 0;
 	db->link_failed =3D 1;
 	db->init=3D1;
@@ -1156,11 +1215,12 @@ static void uli526x_dynamic_reset(struct
=20
 static void uli526x_free_rxbuffer(struct uli526x_board_info * db)
 {
=2D	ULI526X_DBUG(0, "uli526x_free_rxbuffer()", 0);
+	//ULI526X_DBUG(0, "uli526x_free_rxbuffer()", 0);
=20
 	/* free allocated rx buffer */
 	while (db->rx_avail_cnt) {
=2D		dev_kfree_skb(db->rx_ready_ptr->rx_skb_ptr);
+		if (db->rx_ready_ptr->rx_skb_ptr)
+			dev_kfree_skb(db->rx_ready_ptr->rx_skb_ptr);
 		db->rx_ready_ptr =3D db->rx_ready_ptr->next_rx_desc;
 		db->rx_avail_cnt--;
 	}
@@ -1277,7 +1337,7 @@ static void send_filter_frame(struct net
 	u32 * suptr;
 	int i;
=20
=2D	ULI526X_DBUG(0, "send_filter_frame()", 0);
+	//ULI526X_DBUG(0, "send_filter_frame()", 0);
=20
 	txptr =3D db->tx_insert_ptr;
 	suptr =3D (u32 *) txptr->tx_buf_ptr;
@@ -1669,6 +1729,117 @@ static u16 phy_read_1bit(unsigned long i
 	return phy_data;
 }
=20
+#ifdef CONFIG_PM
+
+#if 0
+static void uli526x_set_power_state (
+		struct uli526x_board_info *deb,
+		   int sleep, int snooze)
+{
+	if (tp->flags & HAS_ACPI) {
+		u32 tmp, newtmp;
+		pci_read_config_dword (tp->pdev, CFDD, &tmp);
+		newtmp =3D tmp & ~(CFDD_Sleep | CFDD_Snooze);
+		if (sleep)
+			newtmp |=3D CFDD_Sleep;
+		else if (snooze)
+			newtmp |=3D CFDD_Snooze;
+		if (tmp !=3D newtmp)
+			pci_write_config_dword (tp->pdev, CFDD, newtmp);
+	}
+
+}
+#endif
+
+static u32 *dcr_save;
+
+static int uli526x_suspend (struct pci_dev *pdev, pm_message_t state)
+{
+	struct net_device *dev =3D pci_get_drvdata (pdev);
+	struct uli526x_board_info *db =3D netdev_priv(dev);
+	unsigned long ioaddr =3D db->ioaddr;
+	unsigned long flags;
+	int i;
+
+	if (!dev)
+	       return -EINVAL;
+
+	if (netif_running(dev))
+		netif_stop_queue(dev);
+=09
+	netif_device_detach(dev);
+
+	spin_lock_irqsave(&db->lock, flags);
+
+	/* Disable interrupts, stop Tx and Rx. */
+	outl(0, ioaddr + DCR7);
+	db->cr6_data &=3D ~(CR6_RXSC | CR6_TXSC);
+	update_cr6(db->cr6_data, ioaddr);
+
+	dcr_save =3D kmalloc(sizeof(u32) * 16, GFP_ATOMIC);
+	for (i=3D0; i<16; i++)
+		dcr_save[i] =3D inl(ioaddr + i);
+
+	//phy_write_1bit(ioaddr, PHY_POWER_DOWN, chip_id);
+
+	spin_unlock_irqrestore(&db->lock, flags);
+
+	pci_save_state(pdev);
+
+	pci_disable_device(pdev);
+	pci_set_power_state(pdev,
+		pci_choose_state(pdev, state));
+
+	return 0;
+}
+
+
+static int uli526x_resume (struct pci_dev *pdev)
+{
+	struct net_device *dev =3D pci_get_drvdata (pdev);
+	struct uli526x_board_info *db =3D netdev_priv(dev);
+	unsigned long ioaddr =3D db->ioaddr;
+	u32 val;
+	int i;
+
+	pci_set_power_state(pdev, PCI_D0);
+	pci_restore_state(pdev);
+	pci_enable_device(pdev);
+
+	netif_device_attach(dev);
+
+	if (!netif_running(dev))
+		return 0;
+
+	pci_set_master(pdev);
+=09
+	pci_read_config_dword(pdev, 0x40, &val);
+	if ((val & 0x0000ff00) !=3D 0)
+		pci_write_config_dword(pdev, 0x40, val & 0xffff00ff);
+=09
+	for (i=3D0; i<16; i++)
+		outl(ioaddr+i, dcr_save[i]);
+
+	kfree(dcr_save);
+	dcr_save =3D NULL;
+
+	db->tx_packet_cnt =3D 0;
+	db->first_tx_desc =3D (struct tx_desc *) db->desc_pool_ptr;
+	db->first_tx_desc_dma =3D db->desc_pool_dma_ptr;
+	db->buf_pool_start =3D db->buf_pool_ptr;
+	db->buf_pool_dma_start =3D db->buf_pool_dma_ptr;
+
+	do_reset(dev);
+
+	uli526x_get_resources(db);
+=09
+	uli526x_init(dev);
+
+	return 0;
+}
+
+#endif /* CONFIG_PM */
+
=20
 static struct pci_device_id uli526x_pci_tbl[] =3D {
 	{ 0x10B9, 0x5261, PCI_ANY_ID, PCI_ANY_ID, 0, 0, PCI_ULI5261_ID },
@@ -1683,6 +1854,10 @@ static struct pci_driver uli526x_driver=20
 	.id_table	=3D uli526x_pci_tbl,
 	.probe		=3D uli526x_init_one,
 	.remove		=3D __devexit_p(uli526x_remove_one),
+#ifdef CONFIG_PM
+	.suspend	=3D uli526x_suspend,
+	.resume		=3D uli526x_resume,
+#endif /* CONFIG_PM */
 };
=20
 MODULE_AUTHOR("Peer Chen, peer.chen@uli.com.tw");

--Boundary-01=_17aKE7VafrYZNl/--

--nextPart3867060.pLFUHy05HL
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBEKa76N0y+n1M3mo0RAr7JAKDeUs1eLz6zKwZcM7QXCVvdESXyvgCg8rOt
yKT8YOoB2HS9dYW9r31tuCY=
=p/vJ
-----END PGP SIGNATURE-----

--nextPart3867060.pLFUHy05HL--
