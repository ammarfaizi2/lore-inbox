Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265872AbTBCDAI>; Sun, 2 Feb 2003 22:00:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265880AbTBCDAI>; Sun, 2 Feb 2003 22:00:08 -0500
Received: from host194.steeleye.com ([66.206.164.34]:16389 "EHLO
	pogo.mtv1.steeleye.com") by vger.kernel.org with ESMTP
	id <S265872AbTBCDAB>; Sun, 2 Feb 2003 22:00:01 -0500
Subject: [PATCH] fix 3c509.c for MCA drivers
From: James Bottomley <James.Bottomley@steeleye.com>
To: linux-kernel@vger.kernel.org
Cc: jgarzik@pobox.com, mzyngier@freesurf.fr
Content-Type: multipart/mixed; boundary="=-FrPzSRi2awcdBv4vNAUA"
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 02 Feb 2003 22:09:24 -0500
Message-Id: <1044241767.3924.14.camel@mulgrave>
Mime-Version: 1.0
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-FrPzSRi2awcdBv4vNAUA
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



The attached fixes the MCA version of the 3c509 and updates it to the
new MCA API.

Someone who knows PNP-ISA should migrate it to a probing API for that
too.

I've put the el3_probe back into Space.c for ISA only otherwise the
driver won't work for ISA (could someone with an ISA card test this).

James


--=-FrPzSRi2awcdBv4vNAUA
Content-Disposition: attachment; filename=tmp.diff
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; name=tmp.diff; charset=ISO-8859-1

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher=
.
# This patch includes the following deltas:
#	           ChangeSet	1.956   -> 1.957 =20
#	 drivers/net/3c509.c	1.29    -> 1.30  =20
#	 drivers/net/Space.c	1.15    -> 1.16  =20
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/02/02	jejb@mulgrave.(none)	1.957
# 3c509 fixes: correct MCA probing, add back ISA probe to Space.c
# --------------------------------------------
#
diff -Nru a/drivers/net/3c509.c b/drivers/net/3c509.c
--- a/drivers/net/3c509.c	Sun Feb  2 22:04:26 2003
+++ b/drivers/net/3c509.c	Sun Feb  2 22:04:26 2003
@@ -103,6 +103,10 @@
 static int el3_debug =3D 2;
 #endif
=20
+/* Used to do a global count of all the cards in the system.  Must be
+ * a global variable so that the mca/eisa probe routines can increment
+ * it */
+static int el3_cards =3D 0;
=20
 /* To minimize the size of the driver source I only define operating
    constants if they are used several times.  You'll need the manual
@@ -167,16 +171,15 @@
 	/* skb send-queue */
 	int head, size;
 	struct sk_buff *queue[SKB_QUEUE_SIZE];
-	char mca_slot;
 #ifdef CONFIG_PM
 	struct pm_dev *pmdev;
 #endif
-#ifdef __ISAPNP__
-	struct pnp_dev *pnpdev;
-#endif
-#ifdef CONFIG_EISA
-	struct eisa_device *edev;
-#endif
+	enum {
+		EL3_MCA,
+		EL3_PNP,
+		EL3_EISA,
+	} type;						/* type of device */
+	struct device *dev;
 };
 static int id_port __initdata =3D 0x110;	/* Start with 0x110 to avoid new =
sound cards.*/
 static struct net_device *el3_root_dev;
@@ -200,6 +203,8 @@
 static int el3_resume(struct pm_dev *pdev);
 static int el3_pm_callback(struct pm_dev *pdev, pm_request_t rqst, void *d=
ata);
 #endif
+/* generic device remove for all device types */
+static int el3_device_remove (struct device *device);
=20
 #ifdef CONFIG_EISA
 struct eisa_device_id el3_eisa_ids[] =3D {
@@ -209,31 +214,46 @@
 };
=20
 static int el3_eisa_probe (struct device *device);
-static int el3_eisa_remove (struct device *device);
=20
 struct eisa_driver el3_eisa_driver =3D {
 		.id_table =3D el3_eisa_ids,
 		.driver   =3D {
 				.name    =3D "3c509",
 				.probe   =3D el3_eisa_probe,
-				.remove  =3D __devexit_p (el3_eisa_remove)
+				.remove  =3D __devexit_p (el3_device_remove)
 		}
 };
 #endif
=20
 #ifdef CONFIG_MCA
-struct el3_mca_adapters_struct {
-	char* name;
-	int id;
+static int el3_mca_probe(struct device *dev);
+
+static short el3_mca_adapter_ids[] __initdata =3D {
+		0x627c,
+		0x627d,
+		0x62db,
+		0x62f6,
+		0x62f7,
+		0x0000
+};
+
+static char *el3_mca_adapter_names[] __initdata =3D {
+		"3Com 3c529 EtherLink III (10base2)",
+		"3Com 3c529 EtherLink III (10baseT)",
+		"3Com 3c529 EtherLink III (test mode)",
+		"3Com 3c529 EtherLink III (TP or coax)",
+		"3Com 3c529 EtherLink III (TP)",
+		NULL
 };
=20
-static struct el3_mca_adapters_struct el3_mca_adapters[] __initdata =3D {
-	{ "3Com 3c529 EtherLink III (10base2)", 0x627c },
-	{ "3Com 3c529 EtherLink III (10baseT)", 0x627d },
-	{ "3Com 3c529 EtherLink III (test mode)", 0x62db },
-	{ "3Com 3c529 EtherLink III (TP or coax)", 0x62f6 },
-	{ "3Com 3c529 EtherLink III (TP)", 0x62f7 },
-	{ NULL, 0 },
+static struct mca_driver el3_mca_driver =3D {
+		.id_table =3D el3_mca_adapter_ids,
+		.driver =3D {
+				.name =3D "3c529",
+				.bus =3D &mca_bus_type,
+				.probe =3D el3_mca_probe,
+				.remove =3D __devexit_p(el3_device_remove),
+		},
 };
 #endif /* CONFIG_MCA */
=20
@@ -264,12 +284,12 @@
 };
=20
 static u16 el3_isapnp_phys_addr[8][3];
-#endif /* __ISAPNP__ */
 static int nopnp;
+#endif /* __ISAPNP__ */
=20
 /* With the driver model introduction for EISA devices, both init
  * and cleanup have been split :
- * - EISA devices probe/remove starts in el3_eisa_probe/el3_eisa_remove
+ * - EISA devices probe/remove starts in el3_eisa_probe/el3_device_remove
  * - MCA/ISA still use el3_probe
  *
  * Both call el3_common_init/el3_common_remove. */
@@ -278,10 +298,9 @@
 {
 	struct el3_private *lp =3D dev->priv;
 	short i;
- =20
-#ifdef CONFIG_EISA
-	if (!lp->edev)				/* EISA devices are not chained */
-#endif
+
+	el3_cards++;
+	if (!lp->dev)				/* probed devices are not chained */
 	{
 			lp->next_dev =3D el3_root_dev;
 			el3_root_dev =3D dev;
@@ -337,17 +356,13 @@
 		struct el3_private *lp =3D dev->priv;
=20
 		(void) lp;				/* Keep gcc quiet... */
-#ifdef CONFIG_MCA	=09
-		if(lp->mca_slot!=3D-1)
-			mca_mark_as_unused(lp->mca_slot);
-#endif
 #ifdef CONFIG_PM
 		if (lp->pmdev)
 			pm_unregister(lp->pmdev);
 #endif
 #ifdef __ISAPNP__
-		if (lp->pnpdev)
-			pnp_device_detach(lp->pnpdev);
+		if (lp->type =3D=3D EL3_PNP)
+			pnp_device_detach(to_pnp_dev(lp->dev));
 #endif
=20
 		unregister_netdev (dev);
@@ -363,76 +378,11 @@
 	int ioaddr, irq, if_port;
 	u16 phys_addr[3];
 	static int current_tag;
-	int mca_slot =3D -1;
 #ifdef __ISAPNP__
 	static int pnp_cards;
 	struct pnp_dev *idev =3D NULL;
 #endif /* __ISAPNP__ */
=20
-#ifdef CONFIG_MCA
-	/* Based on Erik Nygren's (nygren@mit.edu) 3c529 patch, heavily
-	 * modified by Chris Beauregard (cpbeaure@csclub.uwaterloo.ca)
-	 * to support standard MCA probing.
-	 *
-	 * redone for multi-card detection by ZP Gu (zpg@castle.net)
-	 * now works as a module
-	 */
-
-	if( MCA_bus ) {
-		int slot, j;
-		u_char pos4, pos5;
-
-		for( j =3D 0; el3_mca_adapters[j].name !=3D NULL; j ++ ) {
-			slot =3D 0;
-			while( slot !=3D MCA_NOTFOUND ) {
-				slot =3D mca_find_unused_adapter(
-					el3_mca_adapters[j].id, slot );
-				if( slot =3D=3D MCA_NOTFOUND ) break;
-
-				/* if we get this far, an adapter has been
-				 * detected and is enabled
-				 */
-
-				pos4 =3D mca_read_stored_pos( slot, 4 );
-				pos5 =3D mca_read_stored_pos( slot, 5 );
-
-				ioaddr =3D ((short)((pos4&0xfc)|0x02)) << 8;
-				irq =3D pos5 & 0x0f;
-
-				/* probing for a card at a particular IO/IRQ */
-				if(dev && ((dev->irq >=3D 1 && dev->irq !=3D irq) ||
-			   	(dev->base_addr >=3D 1 && dev->base_addr !=3D ioaddr))) {
-					slot++;         /* probing next slot */
-					continue;
-				}
-
-				printk("3c509: found %s at slot %d\n",
-					el3_mca_adapters[j].name, slot + 1 );
-
-				/* claim the slot */
-				mca_set_adapter_name(slot, el3_mca_adapters[j].name);
-				mca_set_adapter_procfn(slot, NULL, NULL);
-				mca_mark_as_used(slot);
-
-				if_port =3D pos4 & 0x03;
-				if (el3_debug > 2) {
-					printk("3c529: irq %d  ioaddr 0x%x  ifport %d\n", irq, ioaddr, if_por=
t);
-				}
-				EL3WINDOW(0);
-				for (i =3D 0; i < 3; i++) {
-					phys_addr[i] =3D htons(read_eeprom(ioaddr, i));
-				}
-			=09
-				mca_slot =3D slot;
-
-				goto found;
-			}
-		}
-		/* if we get here, we didn't find an MCA adapter */
-		return -ENODEV;
-	}
-#endif /* CONFIG_MCA */
-
 #ifdef __ISAPNP__
 	if (nopnp =3D=3D 1)
 		goto no_pnp;
@@ -580,7 +530,7 @@
=20
 	/* Free the interrupt so that some other card can use it. */
 	outw(0x0f00, ioaddr + WN0_IRQ);
- found:
+
 	dev =3D init_etherdev(NULL, sizeof(struct el3_private));
 	if (dev =3D=3D NULL) {
 	    release_region(ioaddr, EL3_IO_EXTENT);
@@ -594,13 +544,80 @@
 	dev->if_port =3D if_port;
 	lp =3D dev->priv;
 #ifdef __ISAPNP__
-	lp->pnpdev =3D idev;
+	lp->dev =3D &idev->dev;
 #endif
-	lp->mca_slot =3D mca_slot;
=20
 	return el3_common_init (dev);
 }
=20
+#ifdef CONFIG_MCA
+static int __init el3_mca_probe(struct device *device) {
+		/* Based on Erik Nygren's (nygren@mit.edu) 3c529 patch,
+		 * heavily modified by Chris Beauregard
+		 * (cpbeaure@csclub.uwaterloo.ca) to support standard MCA
+		 * probing.
+		 *
+		 * redone for multi-card detection by ZP Gu (zpg@castle.net)
+		 * now works as a module */
+
+		struct el3_private *lp;
+		short i;
+		int ioaddr, irq, if_port;
+		u16 phys_addr[3];
+		struct net_device *dev =3D NULL;
+		u_char pos4, pos5;
+		struct mca_device *mdev =3D to_mca_device(device);
+		int slot =3D mdev->slot;
+
+		pos4 =3D mca_device_read_stored_pos(mdev, 4);
+		pos5 =3D mca_device_read_stored_pos(mdev, 5);
+
+		ioaddr =3D ((short)((pos4&0xfc)|0x02)) << 8;
+		irq =3D pos5 & 0x0f;
+
+
+		printk("3c529: found %s at slot %d\n",
+			   el3_mca_adapter_names[mdev->index], slot + 1);
+
+		/* claim the slot */
+		strncpy(device->name, el3_mca_adapter_names[mdev->index],
+				sizeof(device->name));
+		mca_device_set_claim(mdev, 1);
+
+		if_port =3D pos4 & 0x03;
+
+		irq =3D mca_device_transform_irq(mdev, irq);
+		ioaddr =3D mca_device_transform_ioport(mdev, ioaddr);=20
+		if (el3_debug > 2) {
+				printk("3c529: irq %d  ioaddr 0x%x  ifport %d\n", irq, ioaddr, if_port=
);
+		}
+		EL3WINDOW(0);
+		for (i =3D 0; i < 3; i++) {
+				phys_addr[i] =3D htons(read_eeprom(ioaddr, i));
+		}
+
+		dev =3D init_etherdev(NULL, sizeof(struct el3_private));
+		if (dev =3D=3D NULL) {
+				release_region(ioaddr, EL3_IO_EXTENT);
+				return -ENOMEM;
+		}
+
+		SET_MODULE_OWNER(dev);
+
+		memcpy(dev->dev_addr, phys_addr, sizeof(phys_addr));
+		dev->base_addr =3D ioaddr;
+		dev->irq =3D irq;
+		dev->if_port =3D if_port;
+		lp =3D dev->priv;
+		lp->dev =3D device;
+		lp->type =3D EL3_MCA;
+		device->driver_data =3D dev;
+
+		return el3_common_init (dev);
+}
+	=09
+#endif /* CONFIG_MCA */
+
 #ifdef CONFIG_EISA
 static int __init el3_eisa_probe (struct device *device)
 {
@@ -642,25 +659,26 @@
 	dev->irq =3D irq;
 	dev->if_port =3D if_port;
 	lp =3D dev->priv;
-	lp->mca_slot =3D -1;
-	lp->edev =3D edev;
+	lp->dev =3D device;
+	lp->type =3D EL3_EISA;
 	eisa_set_drvdata (edev, dev);
=20
 	return el3_common_init (dev);
 }
+#endif
=20
-static int __devexit el3_eisa_remove (struct device *device)
+/* This remove works for all device types.
+ *
+ * The net dev must be stored in the driver_data field */
+static int __devexit el3_device_remove (struct device *device)
 {
-		struct eisa_device *edev;
 		struct net_device *dev;
=20
-		edev =3D to_eisa_device (device);
-		dev  =3D eisa_get_drvdata (edev);
+		dev  =3D device->driver_data;
=20
 		el3_common_remove (dev);
 		return 0;
 }
-#endif
=20
 /* Read a word from the EEPROM using the regular EEPROM access register.
    Assume that we are in register window zero.
@@ -1080,7 +1098,7 @@
 	free_irq(dev->irq, dev);
 	/* Switching back to window 0 disables the IRQ. */
 	EL3WINDOW(0);
-	if (!lp->edev) {
+	if (lp->type !=3D EL3_EISA) {
 	    /* But we explicitly zero the IRQ line select anyway. Don't do
 	     * it on EISA cards, it prevents the module from getting an
 	     * IRQ after unload+reload... */
@@ -1530,7 +1548,7 @@
=20
 static int __init el3_init_module(void)
 {
-	int el3_cards =3D 0;
+	el3_cards =3D 0;
=20
 	if (debug >=3D 0)
 		el3_debug =3D debug;
@@ -1548,8 +1566,9 @@
 	if (eisa_driver_register (&el3_eisa_driver) < 0) {
 			eisa_driver_unregister (&el3_eisa_driver);
 	}
-	else
-			el3_cards++;				/* Found an eisa card */
+#endif
+#ifdef CONFIG_MCA
+	mca_register_driver(&el3_mca_driver);
 #endif
 	return el3_cards ? 0 : -ENODEV;
 }
@@ -1568,6 +1587,9 @@
=20
 #ifdef CONFIG_EISA
 	eisa_driver_unregister (&el3_eisa_driver);
+#endif
+#ifdef CONFIG_MCA
+	mca_unregister_driver(&el3_mca_driver);
 #endif
 }
=20
diff -Nru a/drivers/net/Space.c b/drivers/net/Space.c
--- a/drivers/net/Space.c	Sun Feb  2 22:04:26 2003
+++ b/drivers/net/Space.c	Sun Feb  2 22:04:26 2003
@@ -224,6 +224,9 @@
 #ifdef CONFIG_EL2 		/* 3c503 */
 	{el2_probe, 0},
 #endif
+#ifdef CONFIG_EL3
+	{el3_probe, 0},
+#endif
 #ifdef CONFIG_HPLAN
 	{hp_probe, 0},
 #endif

--=-FrPzSRi2awcdBv4vNAUA--

