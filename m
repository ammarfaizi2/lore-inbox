Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271749AbTHHTAp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Aug 2003 15:00:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271824AbTHHTAo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Aug 2003 15:00:44 -0400
Received: from palrel13.hp.com ([156.153.255.238]:29623 "EHLO palrel13.hp.com")
	by vger.kernel.org with ESMTP id S271749AbTHHSxW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Aug 2003 14:53:22 -0400
Date: Fri, 8 Aug 2003 11:53:20 -0700
To: Jeff Garzik <jgarzik@pobox.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.5 IrDA] VIA FIR driver (improved)
Message-ID: <20030808185320.GE13274@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ir260_via_ircc-4.diff :
~~~~~~~~~~~~~~~~~~~~~
		<Patch from Frank Liu/VIA and Oliver Neukum>
	o [FEATURE] driver for IrDA integrated in VIA chipsets
	o [CORRECT] Use PCI table for probing
	o [FEATURE] Beautify source code


diff -u -p -r --new-file linux/drivers/net/irda.d1/Kconfig linux/drivers/net/irda/Kconfig
--- linux/drivers/net/irda.d1/Kconfig	Fri Aug  8 09:48:49 2003
+++ linux/drivers/net/irda/Kconfig	Fri Aug  8 09:51:33 2003
@@ -348,5 +348,23 @@ config SA1100_FIR
 	tristate "SA1100 Internal IR"
 	depends on ARCH_SA1100 && IRDA
 
+config VIA_FIR
+	tristate "VIA VT8231/VT1211 SIR/MIR/FIR"
+	depends on IRDA && ISA
+	help
+	  Say Y here if you want to build support for the VIA VT8231
+	  and VIA VT1211 IrDA controllers, found on the motherboards using
+	  those those VIA chipsets. To use this controller, you will need
+	  to plug a specific 5 pins FIR IrDA dongle in the specific
+	  motherboard connector. The driver provides support for SIR, MIR
+	  and FIR (4Mbps) speeds.
+
+	  You will need to specify the 'dongle_id' module parameter to
+	  indicate the FIR dongle attached to the controller.
+
+	  If you want to compile it as a module, say M here and read
+	  <file:Documentation/modules.txt>. The module will be called
+	  via-ircc.
+
 endmenu
 
diff -u -p -r --new-file linux/drivers/net/irda.d1/Makefile linux/drivers/net/irda/Makefile
--- linux/drivers/net/irda.d1/Makefile	Fri Aug  8 09:48:49 2003
+++ linux/drivers/net/irda/Makefile	Fri Aug  8 09:51:33 2003
@@ -19,6 +19,7 @@ obj-$(CONFIG_SMC_IRCC_OLD)	+= smc-ircc.o
 obj-$(CONFIG_SMC_IRCC_FIR)	+= smsc-ircc2.o
 obj-$(CONFIG_ALI_FIR)		+= ali-ircc.o
 obj-$(CONFIG_VLSI_FIR)		+= vlsi_ir.o
+obj-$(CONFIG_VIA_FIR)		+= via-ircc.o
 # Old dongle drivers for old SIR drivers
 obj-$(CONFIG_ESI_DONGLE_OLD)		+= esi.o
 obj-$(CONFIG_TEKRAM_DONGLE_OLD)	+= tekram.o
diff -u -p -r --new-file linux/drivers/net/irda.d1/via-ircc.c linux/drivers/net/irda/via-ircc.c
--- linux/drivers/net/irda.d1/via-ircc.c	Wed Dec 31 16:00:00 1969
+++ linux/drivers/net/irda/via-ircc.c	Fri Aug  8 10:07:07 2003
@@ -0,0 +1,1648 @@
+/********************************************************************
+ Filename:      via-ircc.c
+ Version:       1.0 
+ Description:   Driver for the VIA VT8231/VT8233 IrDA chipsets
+ Author:        VIA Technologies,inc
+ Date  :	08/06/2003
+
+Copyright (c) 1998-2003 VIA Technologies, Inc.
+
+This program is free software; you can redistribute it and/or modify it under
+the terms of the GNU General Public License as published by the Free Software
+Foundation; either version 2, or (at your option) any later version.
+
+This program is distributed in the hope that it will be useful, but WITHOUT
+ANY WARRANTIES OR REPRESENTATIONS; without even the implied warranty of
+MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
+See the GNU General Public License for more details.
+
+You should have received a copy of the GNU General Public License along with
+this program; if not, write to the Free Software Foundation, Inc.,
+59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
+
+F01 Oct/02/02: Modify code for V0.11(move out back to back transfer)
+F02 Oct/28/02: Add SB device ID for 3147 and 3177.
+ Comment :
+       jul/09/2002 : only implement two kind of dongle currently.
+       Oct/02/2002 : work on VT8231 and VT8233 .
+       Aug/06/2003 : change driver format to pci driver .
+       
+ ********************************************************************/
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/types.h>
+#include <linux/skbuff.h>
+#include <linux/netdevice.h>
+#include <linux/ioport.h>
+#include <linux/delay.h>
+#include <linux/slab.h>
+#include <linux/init.h>
+#include <linux/rtnetlink.h>
+#include <linux/pci.h>
+
+#include <asm/io.h>
+#include <asm/dma.h>
+#include <asm/byteorder.h>
+
+#include <linux/pm.h>
+
+#include <net/irda/wrapper.h>
+#include <net/irda/irda.h>
+#include <net/irda/irda_device.h>
+
+#include "via-ircc.h"
+
+//#define DBG_IO	1
+//#define   DBGMSG 1
+//#define   DBGMSG_96 1
+//#define   DBGMSG_76 1
+//static int debug=0;
+
+
+#define DBG(x) {if (debug) x;}
+
+#define   VIA_MODULE_NAME "via-ircc"
+#define CHIP_IO_EXTENT 8
+#define BROKEN_DONGLE_ID
+
+static char *driver_name = "via-ircc";
+
+/* Module parameters */
+static int qos_mtt_bits = 0x07;	/* 1 ms or more */
+static int dongle_id = 9;	//defalut IBM type
+
+/* Resource is allocate by BIOS user only need to supply dongle_id*/
+MODULE_PARM(dongle_id, "i");
+
+/* Max 4 instances for now */
+static struct via_ircc_cb *dev_self[] = { NULL, NULL, NULL, NULL };
+
+/* Some prototypes */
+static int via_ircc_open(int i, chipio_t * info, unsigned int id);
+static int __exit via_ircc_close(struct via_ircc_cb *self);
+static int via_ircc_setup(chipio_t * info, unsigned int id);
+static int via_ircc_dma_receive(struct via_ircc_cb *self);
+static int via_ircc_dma_receive_complete(struct via_ircc_cb *self,
+					 int iobase);
+static int via_ircc_hard_xmit_sir(struct sk_buff *skb,
+				  struct net_device *dev);
+static int via_ircc_hard_xmit_fir(struct sk_buff *skb,
+				  struct net_device *dev);
+static void via_ircc_change_speed(struct via_ircc_cb *self, __u32 baud);
+static irqreturn_t via_ircc_interrupt(int irq, void *dev_id,
+				      struct pt_regs *regs);
+static int via_ircc_is_receiving(struct via_ircc_cb *self);
+static int via_ircc_read_dongle_id(int iobase);
+
+static int via_ircc_net_init(struct net_device *dev);
+static int via_ircc_net_open(struct net_device *dev);
+static int via_ircc_net_close(struct net_device *dev);
+static int via_ircc_net_ioctl(struct net_device *dev, struct ifreq *rq,
+			      int cmd);
+static struct net_device_stats *via_ircc_net_get_stats(struct net_device
+						       *dev);
+static void via_ircc_change_dongle_speed(int iobase, int speed,
+					 int dongle_id);
+static int RxTimerHandler(struct via_ircc_cb *self, int iobase);
+void hwreset(struct via_ircc_cb *self);
+static int via_ircc_dma_xmit(struct via_ircc_cb *self, u16 iobase);
+static int upload_rxdata(struct via_ircc_cb *self, int iobase);
+static int __init via_init_one (struct pci_dev *pcidev, const struct pci_device_id *id);
+static void __exit via_remove_one (struct pci_dev *pdev);
+
+/* Should use udelay() instead, even if we are x86 only - Jean II */
+void iodelay(int udelay)
+{
+	u8 data;
+	int i;
+
+	for (i = 0; i < udelay; i++) {
+		data = inb(0x80);
+	}
+}
+
+static struct pci_device_id via_pci_tbl[] __initdata = {
+	{ PCI_VENDOR_ID_VIA, DeviceID1, PCI_ANY_ID, PCI_ANY_ID,0,0,0 },
+	{ PCI_VENDOR_ID_VIA, DeviceID2, PCI_ANY_ID, PCI_ANY_ID,0,0,1 },
+	{ PCI_VENDOR_ID_VIA, DeviceID3, PCI_ANY_ID, PCI_ANY_ID,0,0,2 },
+	{ PCI_VENDOR_ID_VIA, DeviceID4, PCI_ANY_ID, PCI_ANY_ID,0,0,3 },
+	{ PCI_VENDOR_ID_VIA, DeviceID5, PCI_ANY_ID, PCI_ANY_ID,0,0,4 },
+	{ 0, }
+};
+
+MODULE_DEVICE_TABLE(pci,via_pci_tbl);
+
+
+static struct pci_driver via_driver = {
+	name:		VIA_MODULE_NAME,
+	id_table:	via_pci_tbl,
+	probe:		via_init_one,
+	remove:		via_remove_one,
+};
+
+
+/*
+ * Function via_ircc_init ()
+ *
+ *    Initialize chip. Just find out chip type and resource.
+ */
+int __init via_ircc_init(void)
+{
+	int rc;
+
+#ifdef	HEADMSG
+        DBG(printk(KERN_INFO "via_ircc_init ......\n"));
+#endif
+	rc = pci_register_driver (&via_driver);
+#ifdef	HEADMSG
+        DBG(printk(KERN_INFO "via_ircc_init :rc = %d......\n",rc));
+#endif
+	if (rc < 1) {
+#ifdef	HEADMSG
+        DBG(printk(KERN_INFO "via_ircc_init return -ENODEV......\n"));
+#endif
+		if (rc == 0)	pci_unregister_driver (&via_driver);
+		return -ENODEV;
+	}
+	return 0;
+
+}
+
+static int __init via_init_one (struct pci_dev *pcidev, const struct pci_device_id *id)
+{
+	int rc;
+        u8 temp,oldPCI_40,oldPCI_44,bTmp,bTmp1;
+	u16 Chipset,FirDRQ1,FirDRQ0,FirIRQ,FirIOBase;
+	chipio_t info;
+	
+#ifdef	HEADMSG
+        DBG(printk(KERN_INFO "via_init_one : Device ID=(0X%X)\n",id->device));
+#endif
+	if(id->device != DeviceID1 && id->device != DeviceID2 &&
+	   id->device != DeviceID3 && id->device != DeviceID4 &&
+	   id->device != DeviceID5  ){
+#ifdef	HEADMSG
+		DBG(printk(KERN_INFO "via_init_one : Device ID(0X%X) not Supported\n",id->device));
+#endif
+	      return -ENODEV; //South not exist !!!!!
+	}
+	rc = pci_enable_device (pcidev);
+#ifdef	HEADMSG
+	DBG(printk(KERN_INFO "via_init_one : rc=%d\n",rc));
+#endif
+	if (rc)
+		return -ENODEV; 
+        //South Bridge exist
+        if ( ReadLPCReg(0x20) != 0x3C )
+		Chipset=0x3096;
+	else
+		Chipset=0x3076;
+	if (Chipset==0x3076) {
+#ifdef	HEADMSG
+		DBG(printk(KERN_INFO "via_init_one : 3076 ......\n"));
+#endif
+		WriteLPCReg(7,0x0c );
+		temp=ReadLPCReg(0x30);//check if BIOS Enable Fir
+		if((temp&0x01)==1) {   // BIOS close or no FIR
+			WriteLPCReg(0x1d, 0x82 );
+			WriteLPCReg(0x23,0x18);
+			temp=ReadLPCReg(0xF0);
+			if((temp&0x01)==0) {
+				temp=(ReadLPCReg(0x74)&0x03);    //DMA
+				FirDRQ0=temp + 4;
+				temp=(ReadLPCReg(0x74)&0x0C) >> 2;
+				FirDRQ1=temp + 4;
+			} else {
+				temp=(ReadLPCReg(0x74)&0x0C) >> 2;    //DMA
+				FirDRQ0=temp + 4;
+				FirDRQ1=FirDRQ0;
+			}
+			FirIRQ=(ReadLPCReg(0x70)&0x0f);		//IRQ
+			FirIOBase=ReadLPCReg(0x60 ) << 8;	//IO Space :high byte
+			FirIOBase=FirIOBase| ReadLPCReg(0x61) ;	//low byte
+			FirIOBase=FirIOBase  ;
+			info.fir_base=FirIOBase;
+			info.irq=FirIRQ;
+			info.dma=FirDRQ1;
+			info.dma2=FirDRQ0;
+			pci_read_config_byte(pcidev,0x40,&bTmp);
+			pci_write_config_byte(pcidev,0x40,((bTmp | 0x08) & 0xfe));
+			pci_read_config_byte(pcidev,0x42,&bTmp);
+			pci_write_config_byte(pcidev,0x42,(bTmp | 0xf0));
+			pci_write_config_byte(pcidev,0x5a,0xc0);
+			WriteLPCReg(0x28, 0x70 );
+			if (via_ircc_open(0, &info,0x3076) == 0)
+				rc=0;
+		} else
+			rc = -ENODEV; //IR not turn on	 
+	} else { //Not VT1211
+#ifdef	HEADMSG
+		DBG(printk(KERN_INFO "via_init_one : 3096 ......\n"));
+#endif
+		pci_read_config_byte(pcidev,0x67,&bTmp);//check if BIOS Enable Fir
+		if((bTmp&0x01)==1) {  // BIOS enable FIR
+			//Enable Double DMA clock
+			pci_read_config_byte(pcidev,0x42,&oldPCI_40);
+			pci_write_config_byte(pcidev,0x42,oldPCI_40 | 0x80);
+			pci_read_config_byte(pcidev,0x40,&oldPCI_40);
+			pci_write_config_byte(pcidev,0x40,oldPCI_40 & 0xf7);
+			pci_read_config_byte(pcidev,0x44,&oldPCI_44);
+			pci_write_config_byte(pcidev,0x44,0x4e);
+  //---------- read configuration from Function0 of south bridge
+			if((bTmp&0x02)==0) {
+				pci_read_config_byte(pcidev,0x44,&bTmp1); //DMA
+				FirDRQ0 = (bTmp1 & 0x30) >> 4;
+				pci_read_config_byte(pcidev,0x44,&bTmp1);
+				FirDRQ1 = (bTmp1 & 0xc0) >> 6;
+			} else  {
+				pci_read_config_byte(pcidev,0x44,&bTmp1);    //DMA
+				FirDRQ0 = (bTmp1 & 0x30) >> 4 ;
+				FirDRQ1=0;
+			}
+			pci_read_config_byte(pcidev,0x47,&bTmp1);  //IRQ
+			FirIRQ = bTmp1 & 0x0f;
+
+			pci_read_config_byte(pcidev,0x69,&bTmp);
+			FirIOBase = bTmp << 8;//hight byte
+			pci_read_config_byte(pcidev,0x68,&bTmp);
+			FirIOBase = (FirIOBase | bTmp ) & 0xfff0;
+  //-------------------------
+			info.fir_base=FirIOBase;
+			info.irq=FirIRQ;
+			info.dma=FirDRQ1;
+			info.dma2=FirDRQ0;
+			if (via_ircc_open(0, &info,0x3096) == 0)
+				rc=0;
+		} else
+			rc = -ENODEV; //IR not turn on !!!!!
+	}//Not VT1211
+#ifdef	HEADMSG
+	DBG(printk(KERN_INFO "via_init_one End : rc=%d\n",rc));
+#endif
+	return rc;
+}
+
+/*
+ * Function via_ircc_clean ()
+ *
+ *    Close all configured chips
+ *
+ */
+static void __exit via_ircc_clean(void)
+{
+	int i;
+
+#ifdef	HEADMSG
+	DBG(printk(KERN_INFO "via_ircc_clean\n"));
+#endif
+	for (i=0; i < 4; i++) {
+		if (dev_self[i])
+			via_ircc_close(dev_self[i]);
+	}
+}
+
+static void __exit via_remove_one (struct pci_dev *pdev)
+{
+#ifdef	HEADMSG
+        DBG(printk(KERN_INFO "via_remove_one :  ......\n"));
+#endif
+	via_ircc_clean();
+
+}
+
+static void __exit via_ircc_cleanup(void)
+{
+
+#ifdef	HEADMSG
+	DBG(printk(KERN_INFO "via_ircc_cleanup ......\n"));
+#endif
+	via_ircc_clean();
+	pci_unregister_driver (&via_driver); 
+}
+
+/*
+ * Function via_ircc_open (iobase, irq)
+ *
+ *    Open driver instance
+ *
+ */
+static __init int via_ircc_open(int i, chipio_t * info, unsigned int id)
+{
+	struct net_device *dev;
+	struct via_ircc_cb *self;
+	int ret;
+	int err;
+
+	if ((via_ircc_setup(info, id)) == -1)
+		return -1;
+
+	/* Allocate new instance of the driver */
+	self = kmalloc(sizeof(struct via_ircc_cb), GFP_KERNEL);
+	if (self == NULL) {
+		return -ENOMEM;
+	}
+	memset(self, 0, sizeof(struct via_ircc_cb));
+	spin_lock_init(&self->lock);
+
+	/* Need to store self somewhere */
+	dev_self[i] = self;
+	self->index = i;
+	/* Initialize Resource */
+	self->io.cfg_base = info->cfg_base;
+	self->io.fir_base = info->fir_base;
+	self->io.irq = info->irq;
+	self->io.fir_ext = CHIP_IO_EXTENT;
+	self->io.dma = info->dma;
+	self->io.dma2 = info->dma2;
+	self->io.fifo_size = 32;
+	self->chip_id = id;
+	self->st_fifo.len = 0;
+	self->RxDataReady = 0;
+
+	/* Reserve the ioports that we need */
+	ret = check_region(self->io.fir_base, self->io.fir_ext);
+	if (ret < 0) {
+//              WARNING(__FUNCTION__ "(), can't get iobase of 0x%03x\n",self->io.fir_base);
+		dev_self[i] = NULL;
+		kfree(self);
+		return -ENODEV;
+	}
+	request_region(self->io.fir_base, self->io.fir_ext, driver_name);
+	/* Initialize QoS for this device */
+	irda_init_max_qos_capabilies(&self->qos);
+	/* The only value we must override it the baudrate */
+//      self->qos.baud_rate.bits = IR_9600;// May use this for testing
+
+	self->qos.baud_rate.bits =
+	    IR_9600 | IR_19200 | IR_38400 | IR_57600 | IR_115200 |
+	    IR_576000 | IR_1152000 | (IR_4000000 << 8);
+
+	self->qos.min_turn_time.bits = qos_mtt_bits;
+	irda_qos_bits_to_value(&self->qos);
+
+	self->flags =
+	    IFF_FIR | IFF_MIR | IFF_SIR | IFF_DMA | IFF_PIO | IFF_DONGLE;
+
+	/* Max DMA buffer size needed = (data_size + 6) * (window_size) + 6; */
+	self->rx_buff.truesize = 14384 + 2048;
+	self->tx_buff.truesize = 14384 + 2048;
+
+	/* Allocate memory if needed */
+	self->rx_buff.head =
+	    (__u8 *) kmalloc(self->rx_buff.truesize, GFP_KERNEL | GFP_DMA);
+	if (self->rx_buff.head == NULL) {
+		kfree(self);
+		return -ENOMEM;
+	}
+	memset(self->rx_buff.head, 0, self->rx_buff.truesize);
+
+	self->tx_buff.head =
+	    (__u8 *) kmalloc(self->tx_buff.truesize, GFP_KERNEL | GFP_DMA);
+	if (self->tx_buff.head == NULL) {
+		kfree(self->rx_buff.head);
+		kfree(self);
+		return -ENOMEM;
+	}
+	memset(self->tx_buff.head, 0, self->tx_buff.truesize);
+
+	self->rx_buff.in_frame = FALSE;
+	self->rx_buff.state = OUTSIDE_FRAME;
+	self->tx_buff.data = self->tx_buff.head;
+	self->rx_buff.data = self->rx_buff.head;
+
+	/* Reset Tx queue info */
+	self->tx_fifo.len = self->tx_fifo.ptr = self->tx_fifo.free = 0;
+	self->tx_fifo.tail = self->tx_buff.head;
+
+	if (!(dev = dev_alloc("irda%d", &err))) {
+		kfree(self->tx_buff.head);
+		kfree(self->rx_buff.head);
+		kfree(self);
+		return -ENOMEM;
+	}
+
+	dev->priv = (void *) self;
+	self->netdev = dev;
+
+	/* Override the network functions we need to use */
+	dev->init = via_ircc_net_init;
+	dev->hard_start_xmit = via_ircc_hard_xmit_sir;
+	dev->open = via_ircc_net_open;
+	dev->stop = via_ircc_net_close;
+	dev->do_ioctl = via_ircc_net_ioctl;
+	dev->get_stats = via_ircc_net_get_stats;
+
+	rtnl_lock();
+	err = register_netdevice(dev);
+	rtnl_unlock();
+	if (err) {
+		return -1;
+	}
+	MESSAGE("IrDA: Registered device %s\n", dev->name);
+
+	/* Check if user has supplied the dongle id or not */
+	if (!dongle_id)
+		dongle_id = via_ircc_read_dongle_id(self->io.fir_base);
+	self->io.dongle_id = dongle_id;
+	via_ircc_change_dongle_speed(self->io.fir_base, 9600,
+				     self->io.dongle_id);
+
+	return 0;
+}
+
+/*
+ * Function via_ircc_close (self)
+ *
+ *    Close driver instance
+ *
+ */
+static int __exit via_ircc_close(struct via_ircc_cb *self)
+{
+	int iobase;
+
+	IRDA_DEBUG(4, "%s()\n", __FUNCTION__);
+
+	ASSERT(self != NULL, return -1;);
+
+	iobase = self->io.fir_base;
+
+	ResetChip(iobase, 5);	//hardware reset.
+	/* Remove netdevice */
+	if (self->netdev) {
+		rtnl_lock();
+		unregister_netdevice(self->netdev);
+		rtnl_unlock();
+	}
+
+	/* Release the PORT that this driver is using */
+	IRDA_DEBUG(4, "%s(), Releasing Region %03x\n",
+		   __FUNCTION__, self->io.fir_base);
+	release_region(self->io.fir_base, self->io.fir_ext);
+	if (self->tx_buff.head)
+		kfree(self->tx_buff.head);
+	if (self->rx_buff.head)
+		kfree(self->rx_buff.head);
+	dev_self[self->index] = NULL;
+	kfree(self);
+
+	return 0;
+}
+
+/*
+ * Function via_ircc_setup (info)
+ *
+ *    Returns non-negative on success.
+ *
+ */
+static int via_ircc_setup(chipio_t * info, unsigned int chip_id)
+{
+	int iobase = info->fir_base;
+
+	SetMaxRxPacketSize(iobase, 0x0fff);	//set to max:4095
+	// FIFO Init
+	EnRXFIFOReadyInt(iobase, OFF);
+	EnRXFIFOHalfLevelInt(iobase, OFF);
+	EnTXFIFOHalfLevelInt(iobase, OFF);
+	EnTXFIFOUnderrunEOMInt(iobase, ON);
+	EnTXFIFOReadyInt(iobase, OFF);
+	InvertTX(iobase, OFF);
+	InvertRX(iobase, OFF);
+	if (ReadLPCReg(0x20) == 0x3c)
+		WriteLPCReg(0xF0, 0);	// for VT1211
+	if (IsSIROn(iobase)) {
+		SIRFilter(iobase, ON);
+		SIRRecvAny(iobase, ON);
+	} else {
+		SIRFilter(iobase, OFF);
+		SIRRecvAny(iobase, OFF);
+	}
+	//Int Init
+	EnRXSpecInt(iobase, ON);
+	//DMA Init Later....
+	WriteReg(iobase, I_ST_CT_0, 0x80);
+	EnableDMA(iobase, ON);
+
+	return 0;
+}
+
+/*
+ * Function via_ircc_read_dongle_id (void)
+ *
+ */
+static int via_ircc_read_dongle_id(int iobase)
+{
+	int dongle_id = 9;
+
+	return dongle_id;
+}
+
+/*
+ * Function via_ircc_change_dongle_speed (iobase, speed, dongle_id)
+ *    Change speed of the attach dongle
+ *    only implement two type of dongle currently.
+ */
+static void via_ircc_change_dongle_speed(int iobase, int speed,
+					 int dongle_id)
+{
+	u8 mode = 0;
+
+	WriteReg(iobase, I_ST_CT_0, 0x0);
+	switch (dongle_id) {	//HP1100
+	case 0x00:		/* same as */
+	case 0x01:		/* Differential serial interface */
+		break;
+	case 0x02:		/* same as */
+	case 0x03:		/* Reserved */
+		break;
+	case 0x04:		/* Sharp RY5HD01 */
+		break;
+	case 0x05:		/* Reserved, but this is what the Thinkpad reports */
+		break;
+	case 0x06:		/* Single-ended serial interface */
+		break;
+	case 0x07:		/* Consumer-IR only */
+		break;
+
+	case 0x08:		/* HP HSDL-2300, HP HSDL-3600/HSDL-3610 */
+		UseOneRX(iobase, ON);	// use one RX pin   RX1,RX2
+		InvertTX(iobase, OFF);
+		InvertRX(iobase, OFF);
+
+		EnRX2(iobase, ON);	//sir to rx2
+		EnGPIOtoRX2(iobase, OFF);
+
+		if (IsSIROn(iobase)) {	//sir
+			// Mode select Off
+			SlowIRRXLowActive(iobase, ON);
+			udelay(1000);
+			SlowIRRXLowActive(iobase, OFF);
+		} else {
+			if (IsMIROn(iobase)) {	//mir
+				// Mode select On
+				SlowIRRXLowActive(iobase, OFF);
+				udelay(20);
+			} else {	// fir
+				if (IsFIROn(iobase)) {	//fir
+					// Mode select On
+					SlowIRRXLowActive(iobase, OFF);
+					udelay(20);
+				}
+			}
+		}
+		break;
+	case 0x09:		/* IBM31T1100 or Temic TFDS6000/TFDS6500 */
+		UseOneRX(iobase, ON);	//use ONE RX....RX1
+		InvertTX(iobase, OFF);
+		InvertRX(iobase, OFF);	// invert RX pin
+		EnRX2(iobase, ON);
+		EnGPIOtoRX2(iobase, OFF);
+		if (IsSIROn(iobase)) {	//sir
+			// Mode select On
+			SlowIRRXLowActive(iobase, ON);
+			udelay(20);
+			// Mode select Off
+			SlowIRRXLowActive(iobase, OFF);
+		}
+		if (IsMIROn(iobase)) {	//mir
+			// Mode select On
+			SlowIRRXLowActive(iobase, OFF);
+			udelay(20);
+			// Mode select Off
+			SlowIRRXLowActive(iobase, ON);
+		} else {	// fir
+			if (IsFIROn(iobase)) {	//fir
+				// Mode select On
+				SlowIRRXLowActive(iobase, OFF);
+				// TX On
+				WriteTX(iobase, ON);
+				udelay(20);
+				// Mode select OFF
+				SlowIRRXLowActive(iobase, ON);
+				udelay(20);
+				// TX Off
+				WriteTX(iobase, OFF);
+			}
+		}
+		break;
+	case 0x0d:
+		UseOneRX(iobase, OFF);	// use two RX pin   RX1,RX2
+		InvertTX(iobase, OFF);
+		InvertRX(iobase, OFF);
+		SlowIRRXLowActive(iobase, OFF);
+		if (IsSIROn(iobase)) {	//sir
+			EnGPIOtoRX2(iobase, OFF);
+			WriteGIO(iobase, OFF);
+			EnRX2(iobase, OFF);	//sir to rx2
+		} else {	// fir mir
+			EnGPIOtoRX2(iobase, OFF);
+			WriteGIO(iobase, OFF);
+			EnRX2(iobase, OFF);	//fir to rx
+		}
+		break;
+	case 0x0ff:		/* Vishay */
+		if (IsSIROn(iobase))
+			mode = 0;
+		else if (IsMIROn(iobase))
+			mode = 1;
+		else if (IsFIROn(iobase))
+			mode = 2;
+		else if (IsVFIROn(iobase))
+			mode = 5;	//VFIR-16
+		SI_SetMode(iobase, mode);
+	}
+	WriteReg(iobase, I_ST_CT_0, 0x80);
+
+}
+
+/*
+ * Function via_ircc_change_speed (self, baud)
+ *
+ *    Change the speed of the device
+ *
+ */
+static void via_ircc_change_speed(struct via_ircc_cb *self, __u32 speed)
+{
+	struct net_device *dev = self->netdev;
+	u16 iobase;
+	u8 value = 0, bTmp;
+
+	iobase = self->io.fir_base;
+	/* Update accounting for new speed */
+	self->io.speed = speed;
+#ifdef	DBGMSG
+	DBG(printk(KERN_INFO "change_speed =%x......\n", speed));
+#endif
+
+#ifdef	DBG_IO
+	if (self->io.speed > 0x2580)
+		outb(0xaa, 0x90);
+	else
+		outb(0xbb, 0x90);
+#endif
+
+
+	/* Controller mode sellection */
+	switch (speed) {
+	case 9600:
+		value = 11;
+		SetSIR(iobase, ON);
+		CRC16(iobase, ON);
+		break;
+	case 19200:
+		value = 5;
+		SetSIR(iobase, ON);
+		CRC16(iobase, ON);
+		break;
+	case 38400:
+		value = 2;
+		SetSIR(iobase, ON);
+		CRC16(iobase, ON);
+		break;
+	case 57600:
+		value = 1;
+		SetSIR(iobase, ON);
+		CRC16(iobase, ON);
+		break;
+	case 115200:
+		value = 0;
+		SetSIR(iobase, ON);
+		CRC16(iobase, ON);
+		break;
+	case 576000:
+		value = 0;
+		SetSIR(iobase, ON);
+		CRC16(iobase, ON);
+		break;
+	case 1152000:
+		value = 0;
+		SetMIR(iobase, ON);
+		break;
+	case 4000000:
+		value = 0;
+		SetFIR(iobase, ON);
+		SetPulseWidth(iobase, 0);
+		SetSendPreambleCount(iobase, 14);
+		CRC16(iobase, OFF);
+		EnTXCRC(iobase, ON);
+		break;
+	case 16000000:
+		value = 0;
+		SetVFIR(iobase, ON);
+		break;
+	default:
+		value = 0;
+		break;
+	}
+	/* Set baudrate to 0x19[2..7] */
+	bTmp = (ReadReg(iobase, I_CF_H_1) & 0x03);
+	bTmp = bTmp | (value << 2);
+	WriteReg(iobase, I_CF_H_1, bTmp);
+	via_ircc_change_dongle_speed(iobase, speed, self->io.dongle_id);
+// EnTXFIFOHalfLevelInt(iobase,ON);
+	/* Set FIFO size to 64 */
+	SetFIFO(iobase, 64);
+	/* Enable some interrupts so we can receive frames */
+	//EnAllInt(iobase,ON);
+
+	if (IsSIROn(iobase)) {
+		SIRFilter(iobase, ON);
+		SIRRecvAny(iobase, ON);
+	} else {
+		SIRFilter(iobase, OFF);
+		SIRRecvAny(iobase, OFF);
+	}
+	if (speed > 115200) {
+		/* Install FIR xmit handler */
+		dev->hard_start_xmit = via_ircc_hard_xmit_fir;
+		via_ircc_dma_receive(self);
+	} else {
+		/* Install SIR xmit handler */
+		dev->hard_start_xmit = via_ircc_hard_xmit_sir;
+	}
+	netif_wake_queue(dev);
+}
+
+/*
+ * Function via_ircc_hard_xmit (skb, dev)
+ *
+ *    Transmit the frame!
+ *
+ */
+static int via_ircc_hard_xmit_sir(struct sk_buff *skb,
+				  struct net_device *dev)
+{
+	struct via_ircc_cb *self;
+	unsigned long flags;
+	u16 iobase;
+	__u32 speed;
+
+	self = (struct via_ircc_cb *) dev->priv;
+	ASSERT(self != NULL, return 0;);
+	iobase = self->io.fir_base;
+
+	netif_stop_queue(dev);
+	/* Check if we need to change the speed */
+	speed = irda_get_next_speed(skb);
+	if ((speed != self->io.speed) && (speed != -1)) {
+		/* Check for empty frame */
+		if (!skb->len) {
+			via_ircc_change_speed(self, speed);
+			dev->trans_start = jiffies;
+			dev_kfree_skb(skb);
+			return 0;
+		} else
+			self->new_speed = speed;
+	}
+	InitCard(iobase);
+	CommonInit(iobase);
+	SIRFilter(iobase, ON);
+	SetSIR(iobase, ON);
+	CRC16(iobase, ON);
+	EnTXCRC(iobase, 0);
+	WriteReg(iobase, I_ST_CT_0, 0x00);
+
+	spin_lock_irqsave(&self->lock, flags);
+	self->tx_buff.data = self->tx_buff.head;
+	self->tx_buff.len =
+	    async_wrap_skb(skb, self->tx_buff.data,
+			   self->tx_buff.truesize);
+
+	self->stats.tx_bytes += self->tx_buff.len;
+	SetBaudRate(iobase, speed);
+	SetPulseWidth(iobase, 12);
+	SetSendPreambleCount(iobase, 0);
+	WriteReg(iobase, I_ST_CT_0, 0x80);
+
+	EnableTX(iobase, ON);
+	EnableRX(iobase, OFF);
+
+	ResetChip(iobase, 0);
+	ResetChip(iobase, 1);
+	ResetChip(iobase, 2);
+	ResetChip(iobase, 3);
+	ResetChip(iobase, 4);
+
+	EnAllInt(iobase, ON);
+	EnTXDMA(iobase, ON);
+	EnRXDMA(iobase, OFF);
+
+	setup_dma(self->io.dma, self->tx_buff.data, self->tx_buff.len,
+		  DMA_TX_MODE);
+
+	SetSendByte(iobase, self->tx_buff.len);
+	RXStart(iobase, OFF);
+	TXStart(iobase, ON);
+
+	dev->trans_start = jiffies;
+	spin_unlock_irqrestore(&self->lock, flags);
+	dev_kfree_skb(skb);
+	return 0;
+}
+
+static int via_ircc_hard_xmit_fir(struct sk_buff *skb,
+				  struct net_device *dev)
+{
+	struct via_ircc_cb *self;
+	u16 iobase;
+	__u32 speed;
+	unsigned long flags;
+
+	self = (struct via_ircc_cb *) dev->priv;
+	iobase = self->io.fir_base;
+
+	if (self->st_fifo.len)
+		return 0;
+	if (self->chip_id == 0x3076)
+		iodelay(1500);
+	else
+		udelay(1500);
+	netif_stop_queue(dev);
+	speed = irda_get_next_speed(skb);
+	if ((speed != self->io.speed) && (speed != -1)) {
+		if (!skb->len) {
+			via_ircc_change_speed(self, speed);
+			dev->trans_start = jiffies;
+			dev_kfree_skb(skb);
+			return 0;
+		} else
+			self->new_speed = speed;
+	}
+	spin_lock_irqsave(&self->lock, flags);
+	self->tx_fifo.queue[self->tx_fifo.free].start = self->tx_fifo.tail;
+	self->tx_fifo.queue[self->tx_fifo.free].len = skb->len;
+
+	self->tx_fifo.tail += skb->len;
+	self->stats.tx_bytes += skb->len;
+	memcpy(self->tx_fifo.queue[self->tx_fifo.free].start, skb->data,
+	       skb->len);
+	self->tx_fifo.len++;
+	self->tx_fifo.free++;
+//F01   if (self->tx_fifo.len == 1) {
+	via_ircc_dma_xmit(self, iobase);
+//F01   }
+//F01   if (self->tx_fifo.free < (MAX_TX_WINDOW -1 )) netif_wake_queue(self->netdev);
+	dev->trans_start = jiffies;
+	dev_kfree_skb(skb);
+	spin_unlock_irqrestore(&self->lock, flags);
+	return 0;
+
+}
+
+static int via_ircc_dma_xmit(struct via_ircc_cb *self, u16 iobase)
+{
+//      int i;
+//      u8 *ch;
+
+	EnTXDMA(iobase, OFF);
+	self->io.direction = IO_XMIT;
+	EnPhys(iobase, ON);
+	EnableTX(iobase, ON);
+	EnableRX(iobase, OFF);
+	ResetChip(iobase, 0);
+	ResetChip(iobase, 1);
+	ResetChip(iobase, 2);
+	ResetChip(iobase, 3);
+	ResetChip(iobase, 4);
+	EnAllInt(iobase, ON);
+	EnTXDMA(iobase, ON);
+	EnRXDMA(iobase, OFF);
+	setup_dma(self->io.dma,
+		  self->tx_fifo.queue[self->tx_fifo.ptr].start,
+		  self->tx_fifo.queue[self->tx_fifo.ptr].len, DMA_TX_MODE);
+#ifdef	DBGMSG
+	DBG(printk
+	    (KERN_INFO "dma_xmit:tx_fifo.ptr=%x,len=%x,tx_fifo.len=%x..\n",
+	     self->tx_fifo.ptr, self->tx_fifo.queue[self->tx_fifo.ptr].len,
+	     self->tx_fifo.len));
+/*   
+	ch = self->tx_fifo.queue[self->tx_fifo.ptr].start;
+	for(i=0 ; i < self->tx_fifo.queue[self->tx_fifo.ptr].len ; i++) {
+	    DBG(printk(KERN_INFO "%x..\n",ch[i]));
+	}
+*/
+#endif
+
+	SetSendByte(iobase, self->tx_fifo.queue[self->tx_fifo.ptr].len);
+	RXStart(iobase, OFF);
+	TXStart(iobase, ON);
+	return 0;
+
+}
+
+/*
+ * Function via_ircc_dma_xmit_complete (self)
+ *
+ *    The transfer of a frame in finished. This function will only be called 
+ *    by the interrupt handler
+ *
+ */
+static int via_ircc_dma_xmit_complete(struct via_ircc_cb *self)
+{
+	int iobase;
+	int ret = TRUE;
+	u8 Tx_status;
+
+	IRDA_DEBUG(2, "%s()\n", __FUNCTION__);
+	iobase = self->io.fir_base;
+	/* Disable DMA */
+//      DisableDmaChannel(self->io.dma);
+	/* Check for underrrun! */
+	/* Clear bit, by writing 1 into it */
+	Tx_status = GetTXStatus(iobase);
+	if (Tx_status & 0x08) {
+		self->stats.tx_errors++;
+		self->stats.tx_fifo_errors++;
+		hwreset(self);
+// how to clear underrrun ?
+	} else {
+		self->stats.tx_packets++;
+		ResetChip(iobase, 3);
+		ResetChip(iobase, 4);
+	}
+	/* Check if we need to change the speed */
+	if (self->new_speed) {
+		via_ircc_change_speed(self, self->new_speed);
+		self->new_speed = 0;
+	}
+
+	/* Finished with this frame, so prepare for next */
+	if (IsFIROn(iobase)) {
+		if (self->tx_fifo.len) {
+			self->tx_fifo.len--;
+			self->tx_fifo.ptr++;
+		}
+	}
+#ifdef	DBGMSG
+	DBG(printk
+	    (KERN_INFO
+	     "via_ircc_dma_xmit_complete:tx_fifo.len=%x ,tx_fifo.ptr=%x,tx_fifo.free=%x...\n",
+	     self->tx_fifo.len, self->tx_fifo.ptr, self->tx_fifo.free));
+#endif
+/* F01_S
+	// Any frames to be sent back-to-back? 
+	if (self->tx_fifo.len) {
+		// Not finished yet! 
+	  	via_ircc_dma_xmit(self, iobase);
+		ret = FALSE;
+	} else { 
+F01_E*/
+	// Reset Tx FIFO info 
+	self->tx_fifo.len = self->tx_fifo.ptr = self->tx_fifo.free = 0;
+	self->tx_fifo.tail = self->tx_buff.head;
+//F01   }
+
+	// Make sure we have room for more frames 
+//F01   if (self->tx_fifo.free < (MAX_TX_WINDOW -1 )) {
+	// Not busy transmitting anymore 
+	// Tell the network layer, that we can accept more frames 
+	netif_wake_queue(self->netdev);
+//F01   }
+	return ret;
+}
+
+/*
+ * Function via_ircc_dma_receive (self)
+ *
+ *    Set configuration for receive a frame.
+ *
+ */
+static int via_ircc_dma_receive(struct via_ircc_cb *self)
+{
+	int iobase;
+
+	iobase = self->io.fir_base;
+
+	self->tx_fifo.len = self->tx_fifo.ptr = self->tx_fifo.free = 0;
+	self->tx_fifo.tail = self->tx_buff.head;
+	self->RxDataReady = 0;
+	self->io.direction = IO_RECV;
+	self->rx_buff.data = self->rx_buff.head;
+	self->st_fifo.len = self->st_fifo.pending_bytes = 0;
+	self->st_fifo.tail = self->st_fifo.head = 0;
+	EnPhys(iobase, ON);
+	EnableTX(iobase, OFF);
+	EnableRX(iobase, ON);
+
+	ResetChip(iobase, 0);
+	ResetChip(iobase, 1);
+	ResetChip(iobase, 2);
+	ResetChip(iobase, 3);
+	ResetChip(iobase, 4);
+
+	EnAllInt(iobase, ON);
+	EnTXDMA(iobase, OFF);
+	EnRXDMA(iobase, ON);
+	setup_dma(self->io.dma2, self->rx_buff.data,
+		  self->rx_buff.truesize, DMA_RX_MODE);
+	TXStart(iobase, OFF);
+	RXStart(iobase, ON);
+
+	return 0;
+}
+
+/*
+ * Function via_ircc_dma_receive_complete (self)
+ *
+ *    Controller Finished with receiving frames,
+ *    and this routine is call by ISR
+ *    
+ */
+static int via_ircc_dma_receive_complete(struct via_ircc_cb *self,
+					 int iobase)
+{
+	struct st_fifo *st_fifo;
+	struct sk_buff *skb;
+	int len, i;
+	u8 status = 0;
+
+	iobase = self->io.fir_base;
+	st_fifo = &self->st_fifo;
+
+	if (self->io.speed < 4000000) {	//Speed below FIR
+		len = GetRecvByte(iobase, self);
+		skb = dev_alloc_skb(len + 1);
+		if (skb == NULL)
+			return FALSE;
+		// Make sure IP header gets aligned 
+		skb_reserve(skb, 1);
+		skb_put(skb, len - 2);
+		if (self->chip_id == 0x3076) {
+			for (i = 0; i < len - 2; i++)
+				skb->data[i] = self->rx_buff.data[i * 2];
+		} else {
+			if (self->chip_id == 0x3096) {
+				for (i = 0; i < len - 2; i++)
+					skb->data[i] =
+					    self->rx_buff.data[i];
+			}
+		}
+		// Move to next frame 
+		self->rx_buff.data += len;
+		self->stats.rx_bytes += len;
+		self->stats.rx_packets++;
+		skb->dev = self->netdev;
+		skb->mac.raw = skb->data;
+		skb->protocol = htons(ETH_P_IRDA);
+		netif_rx(skb);
+		return TRUE;
+	}
+
+	else {			//FIR mode
+		len = GetRecvByte(iobase, self);
+		if (len == 0)
+			return TRUE;	//interrupt only, data maybe move by RxT  
+		if (((len - 4) < 2) || ((len - 4) > 2048)) {
+#ifdef	DBGMSG
+			DBG(printk
+			    (KERN_INFO
+			     "receive_comple:Trouble:len=%x,CurCount=%x,LastCount=%x..\n",
+			     len, RxCurCount(iobase, self),
+			     self->RxLastCount));
+#endif
+			hwreset(self);
+			return FALSE;
+		}
+#ifdef	DBGMSG
+		DBG(printk
+		    (KERN_INFO
+		     "recv_comple:fifo.len=%x,len=%x,CurCount=%x..\n",
+		     st_fifo->len, len - 4, RxCurCount(iobase, self)));
+#endif
+		st_fifo->entries[st_fifo->tail].status = status;
+		st_fifo->entries[st_fifo->tail].len = len;
+		st_fifo->pending_bytes += len;
+		st_fifo->tail++;
+		st_fifo->len++;
+		if (st_fifo->tail > MAX_RX_WINDOW)
+			st_fifo->tail = 0;
+		self->RxDataReady = 0;
+
+		// It maybe have MAX_RX_WINDOW package receive by
+		// receive_complete before Timer IRQ
+/* F01_S
+          if (st_fifo->len < (MAX_RX_WINDOW+2 )) { 
+		  RXStart(iobase,ON);
+	  	  SetTimer(iobase,4);
+	  }
+	  else	  { 
+F01_E */
+		EnableRX(iobase, OFF);
+		EnRXDMA(iobase, OFF);
+		RXStart(iobase, OFF);
+//F01_S
+		// Put this entry back in fifo 
+		if (st_fifo->head > MAX_RX_WINDOW)
+			st_fifo->head = 0;
+		status = st_fifo->entries[st_fifo->head].status;
+		len = st_fifo->entries[st_fifo->head].len;
+		st_fifo->head++;
+		st_fifo->len--;
+
+		skb = dev_alloc_skb(len + 1 - 4);
+		/*
+		 * if frame size,data ptr,or skb ptr are wrong ,the get next
+		 * entry.
+		 */
+		if ((skb == NULL) || (skb->data == NULL)
+		    || (self->rx_buff.data == NULL) || (len < 6)) {
+			self->stats.rx_dropped++;
+			return TRUE;
+		}
+		skb_reserve(skb, 1);
+		skb_put(skb, len - 4);
+		memcpy(skb->data, self->rx_buff.data, len - 4);
+#ifdef	DBGMSG
+		DBG(printk
+		    (KERN_INFO "RxT:len=%x.rx_buff=%x\n", len - 4,
+		     self->rx_buff.data));
+/*		for(i=0 ; i < (len-4) ; i++) {
+		    DBG(printk(KERN_INFO "%x..\n",self->rx_buff.data[i]));
+		}
+*/
+#endif
+		// Move to next frame 
+		self->rx_buff.data += len;
+		self->stats.rx_bytes += len;
+		self->stats.rx_packets++;
+		skb->dev = self->netdev;
+		skb->mac.raw = skb->data;
+		skb->protocol = htons(ETH_P_IRDA);
+		netif_rx(skb);
+
+//F01_E
+	}			//FIR
+	return TRUE;
+
+}
+
+/*
+ * if frame is received , but no INT ,then use this routine to upload frame.
+ */
+static int upload_rxdata(struct via_ircc_cb *self, int iobase)
+{
+	struct sk_buff *skb;
+	int len;
+	struct st_fifo *st_fifo;
+	st_fifo = &self->st_fifo;
+
+	len = GetRecvByte(iobase, self);
+
+#ifdef	DBGMSG
+	DBG(printk(KERN_INFO "upload_rxdata: len=%x\n", len));
+#endif
+	skb = dev_alloc_skb(len + 1);
+	if ((skb == NULL) || ((len - 4) < 2)) {
+		self->stats.rx_dropped++;
+		return FALSE;
+	}
+	skb_reserve(skb, 1);
+	skb_put(skb, len - 4 + 1);
+	memcpy(skb->data, self->rx_buff.data, len - 4 + 1);
+	st_fifo->tail++;
+	st_fifo->len++;
+	if (st_fifo->tail > MAX_RX_WINDOW)
+		st_fifo->tail = 0;
+	// Move to next frame 
+	self->rx_buff.data += len;
+	self->stats.rx_bytes += len;
+	self->stats.rx_packets++;
+	skb->dev = self->netdev;
+	skb->mac.raw = skb->data;
+	skb->protocol = htons(ETH_P_IRDA);
+	netif_rx(skb);
+	if (st_fifo->len < (MAX_RX_WINDOW + 2)) {
+		RXStart(iobase, ON);
+	} else {
+		EnableRX(iobase, OFF);
+		EnRXDMA(iobase, OFF);
+		RXStart(iobase, OFF);
+	}
+	return TRUE;
+}
+
+/*
+ * Implement back to back receive , use this routine to upload data.
+ */
+
+static int RxTimerHandler(struct via_ircc_cb *self, int iobase)
+{
+	struct st_fifo *st_fifo;
+	struct sk_buff *skb;
+	int len;
+	u8 status;
+
+	st_fifo = &self->st_fifo;
+
+	if (CkRxRecv(iobase, self)) {
+		// if still receiving ,then return ,don't upload frame 
+		self->RetryCount = 0;
+		SetTimer(iobase, 20);
+		self->RxDataReady++;
+		return FALSE;
+	} else
+		self->RetryCount++;
+
+	if ((self->RetryCount >= 1) ||
+	    ((st_fifo->pending_bytes + 2048) > self->rx_buff.truesize)
+	    || (st_fifo->len >= (MAX_RX_WINDOW))) {
+		while (st_fifo->len > 0) {	//upload frame
+			// Put this entry back in fifo 
+			if (st_fifo->head > MAX_RX_WINDOW)
+				st_fifo->head = 0;
+			status = st_fifo->entries[st_fifo->head].status;
+			len = st_fifo->entries[st_fifo->head].len;
+			st_fifo->head++;
+			st_fifo->len--;
+
+			skb = dev_alloc_skb(len + 1 - 4);
+			/*
+			 * if frame size, data ptr, or skb ptr are wrong,
+			 * then get next entry.
+			 */
+			if ((skb == NULL) || (skb->data == NULL)
+			    || (self->rx_buff.data == NULL) || (len < 6)) {
+				self->stats.rx_dropped++;
+				continue;
+			}
+			skb_reserve(skb, 1);
+			skb_put(skb, len - 4);
+			memcpy(skb->data, self->rx_buff.data, len - 4);
+#ifdef	DBGMSG
+			DBG(printk
+			    (KERN_INFO "RxT:len=%x.head=%x\n", len - 4,
+			     st_fifo->head));
+#endif
+			// Move to next frame 
+			self->rx_buff.data += len;
+			self->stats.rx_bytes += len;
+			self->stats.rx_packets++;
+			skb->dev = self->netdev;
+			skb->mac.raw = skb->data;
+			skb->protocol = htons(ETH_P_IRDA);
+			netif_rx(skb);
+		}		//while
+		self->RetryCount = 0;
+#ifdef	DBGMSG
+		DBG(printk
+		    (KERN_INFO
+		     "RxT:End of upload HostStatus=%x,RxStatus=%x\n",
+		     GetHostStatus(iobase), GetRXStatus(iobase)));
+#endif
+		/*
+		 * if frame is receive complete at this routine ,then upload
+		 * frame.
+		 */
+		if ((GetRXStatus(iobase) & 0x10)
+		    && (RxCurCount(iobase, self) != self->RxLastCount)) {
+			upload_rxdata(self, iobase);
+			if (irda_device_txqueue_empty(self->netdev))
+				via_ircc_dma_receive(self);
+		}
+	}			// timer detect complete
+	else
+		SetTimer(iobase, 4);
+	return TRUE;
+
+}
+
+
+
+/*
+ * Function via_ircc_interrupt (irq, dev_id, regs)
+ *
+ *    An interrupt from the chip has arrived. Time to do some work
+ *
+ */
+static irqreturn_t via_ircc_interrupt(int irq, void *dev_id,
+				      struct pt_regs *regs)
+{
+	struct net_device *dev = (struct net_device *) dev_id;
+	struct via_ircc_cb *self;
+	int iobase;
+	u8 iHostIntType, iRxIntType, iTxIntType;
+
+	if (!dev) {
+		WARNING("%s: irq %d for unknown device.\n", driver_name,
+			irq);
+		return IRQ_NONE;
+	}
+	self = (struct via_ircc_cb *) dev->priv;
+	iobase = self->io.fir_base;
+	spin_lock(&self->lock);
+	iHostIntType = GetHostStatus(iobase);
+	if ((iHostIntType & 0x40) != 0) {	//Timer Event
+		self->EventFlag.TimeOut++;
+		ClearTimerInt(iobase, 1);
+		if (self->io.direction == IO_XMIT) {
+			via_ircc_dma_xmit(self, iobase);
+		}
+		if (self->io.direction == IO_RECV) {
+			/*
+			 * frame ready hold too long, must reset.
+			 */
+			if (self->RxDataReady > 30) {
+				hwreset(self);
+				if (irda_device_txqueue_empty
+				    (self->netdev)) {
+					via_ircc_dma_receive(self);
+				}
+			} else {	// call this to upload frame.
+				RxTimerHandler(self, iobase);
+			}
+		}		//RECV
+	}			//Timer Event
+	if ((iHostIntType & 0x20) != 0) {	//Tx Event
+		iTxIntType = GetTXStatus(iobase);
+		if (iTxIntType & 0x4) {
+			self->EventFlag.EOMessage++;	// read and will auto clean
+			if (via_ircc_dma_xmit_complete(self)) {
+				if (irda_device_txqueue_empty
+				    (self->netdev)) {
+					via_ircc_dma_receive(self);
+				}
+			} else {
+				self->EventFlag.Unknown++;
+			}
+		}		//EOP
+	}			//Tx Event
+	//----------------------------------------
+	if ((iHostIntType & 0x10) != 0) {	//Rx Event
+		/* Check if DMA has finished */
+		iRxIntType = GetRXStatus(iobase);
+#ifdef	DBGMSG
+		if (!iRxIntType)
+			DBG(printk(KERN_INFO " RxIRQ =0\n"));
+#endif
+		if (iRxIntType & 0x10) {
+			if (via_ircc_dma_receive_complete(self, iobase)) {
+//F01       if(!(IsFIROn(iobase)))  via_ircc_dma_receive(self);
+				via_ircc_dma_receive(self);
+			}
+		}		// No ERR     
+		else {		//ERR
+#ifdef	DBGMSG
+			DBG(printk
+			    (KERN_INFO
+			     " RxIRQ ERR:iRxIntType=%x,HostIntType=%x,CurCount=%x,RxLastCount=%x_____\n",
+			     iRxIntType, iHostIntType, RxCurCount(iobase,
+								  self),
+			     self->RxLastCount));
+#endif
+			if (iRxIntType & 0x20) {	//FIFO OverRun ERR
+				ResetChip(iobase, 0);
+				ResetChip(iobase, 1);
+			} else {	//PHY,CRC ERR
+
+				if (iRxIntType != 0x08)
+					hwreset(self);	//F01
+			}
+			via_ircc_dma_receive(self);
+		}		//ERR
+
+	}			//Rx Event
+	spin_unlock(&self->lock);
+	return IRQ_HANDLED;
+}
+
+void hwreset(struct via_ircc_cb *self)
+{
+	int iobase;
+	iobase = self->io.fir_base;
+#ifdef	DBGMSG
+	DBG(printk(KERN_INFO "hwreset  ....\n"));
+#endif
+	ResetChip(iobase, 5);
+	EnableDMA(iobase, OFF);
+	EnableTX(iobase, OFF);
+	EnableRX(iobase, OFF);
+	EnRXDMA(iobase, OFF);
+	EnTXDMA(iobase, OFF);
+	RXStart(iobase, OFF);
+	TXStart(iobase, OFF);
+	InitCard(iobase);
+	CommonInit(iobase);
+	SIRFilter(iobase, ON);
+	SetSIR(iobase, ON);
+	CRC16(iobase, ON);
+	EnTXCRC(iobase, 0);
+	WriteReg(iobase, I_ST_CT_0, 0x00);
+	SetBaudRate(iobase, 9600);
+	SetPulseWidth(iobase, 12);
+	SetSendPreambleCount(iobase, 0);
+	WriteReg(iobase, I_ST_CT_0, 0x80);
+	via_ircc_change_speed(self, self->io.speed);
+	self->st_fifo.len = 0;
+}
+
+/*
+ * Function via_ircc_is_receiving (self)
+ *
+ *    Return TRUE is we are currently receiving a frame
+ *
+ */
+static int via_ircc_is_receiving(struct via_ircc_cb *self)
+{
+	int status = FALSE;
+	int iobase;
+
+	ASSERT(self != NULL, return FALSE;);
+
+	iobase = self->io.fir_base;
+	if (CkRxRecv(iobase, self))
+		status = TRUE;
+#ifdef	DBGMSG
+	DBG(printk(KERN_INFO "is_receiving  status=%x....\n", status));
+#endif
+	return status;
+}
+
+/*
+ * Function via_ircc_net_init (dev)
+ *
+ *    Initialize network device
+ *
+ */
+static int via_ircc_net_init(struct net_device *dev)
+{
+	IRDA_DEBUG(4, "%s()\n", __FUNCTION__);
+
+	/* Keep track of module usage */
+	SET_MODULE_OWNER(dev);
+
+	/* Setup to be a normal IrDA network device driver */
+	irda_device_setup(dev);
+
+	/* Insert overrides below this line! */
+
+	return 0;
+}
+
+/*
+ * Function via_ircc_net_open (dev)
+ *
+ *    Start the device
+ *
+ */
+static int via_ircc_net_open(struct net_device *dev)
+{
+	struct via_ircc_cb *self;
+	int iobase;
+	char hwname[32];
+
+	IRDA_DEBUG(4, "%s()\n", __FUNCTION__);
+
+	ASSERT(dev != NULL, return -1;);
+	self = (struct via_ircc_cb *) dev->priv;
+	self->stats.rx_packets = 0;
+	ASSERT(self != NULL, return 0;);
+	iobase = self->io.fir_base;
+	if (request_irq
+	    (self->io.irq, via_ircc_interrupt, 0, dev->name, dev)) {
+		WARNING("%s, unable to allocate irq=%d\n", driver_name,
+			self->io.irq);
+		return -EAGAIN;
+	}
+	/*
+	 * Always allocate the DMA channel after the IRQ, and clean up on 
+	 * failure.
+	 */
+	if (request_dma(self->io.dma, dev->name)) {
+		WARNING("%s, unable to allocate dma=%d\n", driver_name,
+			self->io.dma);
+		free_irq(self->io.irq, self);
+		return -EAGAIN;
+	}
+	if (self->io.dma2 != self->io.dma) {
+		if (request_dma(self->io.dma2, dev->name)) {
+			WARNING("%s, unable to allocate dma2=%d\n",
+				driver_name, self->io.dma2);
+			free_irq(self->io.irq, self);
+			return -EAGAIN;
+		}
+	}
+
+
+	/* turn on interrupts */
+	EnAllInt(iobase, ON);
+	EnInternalLoop(iobase, OFF);
+	EnExternalLoop(iobase, OFF);
+	/* Ready to play! */
+	netif_start_queue(dev);
+
+	/* 
+	 * Open new IrLAP layer instance, now that everything should be
+	 * initialized properly 
+	 */
+	sprintf(hwname, "VIA");
+	/*
+	 * for different kernel ,irlap_open have different parameter.
+	 */
+	self->irlap = irlap_open(dev, &self->qos, hwname);
+//      self->irlap = irlap_open(dev, &self->qos);
+
+	self->RxLastCount = 0;
+
+	return 0;
+}
+
+/*
+ * Function via_ircc_net_close (dev)
+ *
+ *    Stop the device
+ *
+ */
+static int via_ircc_net_close(struct net_device *dev)
+{
+	struct via_ircc_cb *self;
+	int iobase;
+
+	IRDA_DEBUG(4, "%s()\n", __FUNCTION__);
+
+	ASSERT(dev != NULL, return -1;);
+	self = (struct via_ircc_cb *) dev->priv;
+	ASSERT(self != NULL, return 0;);
+
+#ifdef	DBG_IO
+	outb(0xff, 0x90);
+	outb(0xff, 0x94);
+#endif
+	/* Stop device */
+	netif_stop_queue(dev);
+	/* Stop and remove instance of IrLAP */
+	if (self->irlap)
+		irlap_close(self->irlap);
+	self->irlap = NULL;
+	iobase = self->io.fir_base;
+	EnTXDMA(iobase, OFF);
+	EnRXDMA(iobase, OFF);
+	DisableDmaChannel(self->io.dma);
+
+	/* Disable interrupts */
+	EnAllInt(iobase, OFF);
+	free_irq(self->io.irq, dev);
+	free_dma(self->io.dma);
+
+	return 0;
+}
+
+/*
+ * Function via_ircc_net_ioctl (dev, rq, cmd)
+ *
+ *    Process IOCTL commands for this device
+ *
+ */
+static int via_ircc_net_ioctl(struct net_device *dev, struct ifreq *rq,
+			      int cmd)
+{
+	struct if_irda_req *irq = (struct if_irda_req *) rq;
+	struct via_ircc_cb *self;
+	unsigned long flags;
+	int ret = 0;
+
+	ASSERT(dev != NULL, return -1;);
+	self = dev->priv;
+	ASSERT(self != NULL, return -1;);
+	IRDA_DEBUG(2, "%s(), %s, (cmd=0x%X)\n", __FUNCTION__, dev->name,
+		   cmd);
+	/* Disable interrupts & save flags */
+	spin_lock_irqsave(&self->lock, flags);
+	switch (cmd) {
+	case SIOCSBANDWIDTH:	/* Set bandwidth */
+		if (!capable(CAP_NET_ADMIN)) {
+			ret = -EPERM;
+			goto out;
+		}
+		via_ircc_change_speed(self, irq->ifr_baudrate);
+		break;
+	case SIOCSMEDIABUSY:	/* Set media busy */
+		if (!capable(CAP_NET_ADMIN)) {
+			ret = -EPERM;
+			goto out;
+		}
+		irda_device_set_media_busy(self->netdev, TRUE);
+		break;
+	case SIOCGRECEIVING:	/* Check if we are receiving right now */
+		irq->ifr_receiving = via_ircc_is_receiving(self);
+		break;
+	default:
+		ret = -EOPNOTSUPP;
+	}
+      out:
+	spin_unlock_irqrestore(&self->lock, flags);
+	return ret;
+}
+
+static struct net_device_stats *via_ircc_net_get_stats(struct net_device
+						       *dev)
+{
+	struct via_ircc_cb *self = (struct via_ircc_cb *) dev->priv;
+
+	return &self->stats;
+}
+
+MODULE_AUTHOR("VIA Technologies,inc");
+MODULE_DESCRIPTION("VIA IrDA Device Driver");
+MODULE_LICENSE("GPL");
+
+module_init(via_ircc_init);
+module_exit(via_ircc_cleanup);
diff -u -p -r --new-file linux/drivers/net/irda.d1/via-ircc.h linux/drivers/net/irda/via-ircc.h
--- linux/drivers/net/irda.d1/via-ircc.h	Wed Dec 31 16:00:00 1969
+++ linux/drivers/net/irda/via-ircc.h	Fri Aug  8 10:05:55 2003
@@ -0,0 +1,1044 @@
+/*********************************************************************
+ *                
+ * Filename:      via-ircc.h
+ * Version:       1.0
+ * Description:   Driver for the VIA VT8231/VT8233 IrDA chipsets
+ * Author:        VIA Technologies, inc
+ * Date  :	  08/06/2003
+
+Copyright (c) 1998-2003 VIA Technologies, Inc.
+
+This program is free software; you can redistribute it and/or modify it under
+the terms of the GNU General Public License as published by the Free Software
+Foundation; either version 2, or (at your option) any later version.
+
+This program is distributed in the hope that it will be useful, but WITHOUT
+ANY WARRANTIES OR REPRESENTATIONS; without even the implied warranty of
+MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
+See the GNU General Public License for more details.
+
+You should have received a copy of the GNU General Public License along with
+this program; if not, write to the Free Software Foundation, Inc.,
+59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
+
+ * Comment:
+ * jul/08/2002 : Rx buffer length should use Rx ring ptr.	
+ * Oct/28/2002 : Add SB id for 3147 and 3177.	
+ * jul/09/2002 : only implement two kind of dongle currently.
+ * Oct/02/2002 : work on VT8231 and VT8233 .
+ * Aug/06/2003 : change driver format to pci driver .
+ ********************************************************************/
+#ifndef via_IRCC_H
+#define via_IRCC_H
+#include <linux/time.h>
+#include <linux/spinlock.h>
+#include <linux/pm.h>
+#include <asm/io.h>
+
+#define MAX_TX_WINDOW 7
+#define MAX_RX_WINDOW 7
+
+struct st_fifo_entry {
+	int status;
+	int len;
+};
+
+struct st_fifo {
+	struct st_fifo_entry entries[MAX_RX_WINDOW + 2];
+	int pending_bytes;
+	int head;
+	int tail;
+	int len;
+};
+
+struct frame_cb {
+	void *start;		/* Start of frame in DMA mem */
+	int len;		/* Lenght of frame in DMA mem */
+};
+
+struct tx_fifo {
+	struct frame_cb queue[MAX_TX_WINDOW + 2];	/* Info about frames in queue */
+	int ptr;		/* Currently being sent */
+	int len;		/* Lenght of queue */
+	int free;		/* Next free slot */
+	void *tail;		/* Next free start in DMA mem */
+};
+
+
+struct eventflag		// for keeping track of Interrupt Events
+{
+	//--------tx part
+	unsigned char TxFIFOUnderRun;
+	unsigned char EOMessage;
+	unsigned char TxFIFOReady;
+	unsigned char EarlyEOM;
+	//--------rx part
+	unsigned char PHYErr;
+	unsigned char CRCErr;
+	unsigned char RxFIFOOverRun;
+	unsigned char EOPacket;
+	unsigned char RxAvail;
+	unsigned char TooLargePacket;
+	unsigned char SIRBad;
+	//--------unknown
+	unsigned char Unknown;
+	//----------
+	unsigned char TimeOut;
+	unsigned char RxDMATC;
+	unsigned char TxDMATC;
+};
+
+/* Private data for each instance */
+struct via_ircc_cb {
+	struct st_fifo st_fifo;	/* Info about received frames */
+	struct tx_fifo tx_fifo;	/* Info about frames to be transmitted */
+
+	struct net_device *netdev;	/* Yes! we are some kind of netdevice */
+	struct net_device_stats stats;
+
+	struct irlap_cb *irlap;	/* The link layer we are binded to */
+	struct qos_info qos;	/* QoS capabilities for this device */
+
+	chipio_t io;		/* IrDA controller information */
+	iobuff_t tx_buff;	/* Transmit buffer */
+	iobuff_t rx_buff;	/* Receive buffer */
+
+	__u8 ier;		/* Interrupt enable register */
+
+	struct timeval stamp;
+	struct timeval now;
+
+	spinlock_t lock;	/* For serializing operations */
+
+	__u32 flags;		/* Interface flags */
+	__u32 new_speed;
+	int index;		/* Instance index */
+
+	struct eventflag EventFlag;
+	struct pm_dev *dev;
+	unsigned int chip_id;	/* to remember chip id */
+	unsigned int RetryCount;
+	unsigned int RxDataReady;
+	unsigned int RxLastCount;
+};
+
+
+//---------I=Infrared,  H=Host, M=Misc, T=Tx, R=Rx, ST=Status,
+//         CF=Config, CT=Control, L=Low, H=High, C=Count
+#define  I_CF_L_0  		0x10
+#define  I_CF_H_0		0x11
+#define  I_SIR_BOF		0x12
+#define  I_SIR_EOF		0x13
+#define  I_ST_CT_0		0x15
+#define  I_ST_L_1		0x16
+#define  I_ST_H_1		0x17
+#define  I_CF_L_1		0x18
+#define  I_CF_H_1		0x19
+#define  I_CF_L_2		0x1a
+#define  I_CF_H_2		0x1b
+#define  I_CF_3		0x1e
+#define  H_CT			0x20
+#define  H_ST			0x21
+#define  M_CT			0x22
+#define  TX_CT_1		0x23
+#define  TX_CT_2		0x24
+#define  TX_ST			0x25
+#define  RX_CT			0x26
+#define  RX_ST			0x27
+#define  RESET			0x28
+#define  P_ADDR		0x29
+#define  RX_C_L		0x2a
+#define  RX_C_H		0x2b
+#define  RX_P_L		0x2c
+#define  RX_P_H		0x2d
+#define  TX_C_L		0x2e
+#define  TX_C_H		0x2f
+#define  TIMER         	0x32
+#define  I_CF_4         	0x33
+#define  I_T_C_L		0x34
+#define  I_T_C_H		0x35
+#define  VERSION		0x3f
+//-------------------------------
+#define StartAddr 	0x10	// the first register address
+#define EndAddr 	0x3f	// the last register address
+#define GetBit(val,bit)  val = (unsigned char) ((val>>bit) & 0x1)
+			// Returns the bit
+#define SetBit(val,bit)  val= (unsigned char ) (val | (0x1 << bit))
+			// Sets bit to 1
+#define ResetBit(val,bit) val= (unsigned char ) (val & ~(0x1 << bit))
+			// Sets bit to 0
+#define PCI_CONFIG_ADDRESS 0xcf8
+#define PCI_CONFIG_DATA    0xcfc
+
+#define VenderID    0x1106
+#define DeviceID1   0x8231
+#define DeviceID2   0x3109
+#define DeviceID3   0x3074
+//F01_S
+#define DeviceID4   0x3147
+#define DeviceID5   0x3177
+//F01_E
+
+#define OFF   0
+#define ON   1
+#define DMA_TX_MODE   0x08
+#define DMA_RX_MODE   0x04
+
+#define DMA1   0
+#define DMA2   0xc0
+#define MASK1   DMA1+0x0a
+#define MASK2   DMA2+0x14
+
+#define Clk_bit 0x40
+#define Tx_bit 0x01
+#define Rd_Valid 0x08
+#define RxBit 0x08
+
+__u8 ReadPCIByte(__u8, __u8, __u8, __u8);
+__u32 ReadPCI(__u8, __u8, __u8, __u8);
+void WritePCI(__u8, __u8, __u8, __u8, __u32);
+void WritePCIByte(__u8, __u8, __u8, __u8, __u8);
+int mySearchPCI(__u8 *, __u16, __u16);
+
+
+void DisableDmaChannel(unsigned int channel)
+{
+	switch (channel) {	// 8 Bit DMA channels DMAC1
+	case 0:
+		outb(4, MASK1);	//mask channel 0
+		break;
+	case 1:
+		outb(5, MASK1);	//Mask channel 1
+		break;
+	case 2:
+		outb(6, MASK1);	//Mask channel 2
+		break;
+	case 3:
+		outb(7, MASK1);	//Mask channel 3
+		break;
+	case 5:
+		outb(5, MASK2);	//Mask channel 5
+		break;
+	case 6:
+		outb(6, MASK2);	//Mask channel 6
+		break;
+	case 7:
+		outb(7, MASK2);	//Mask channel 7
+		break;
+	default:
+		break;
+	};			//Switch
+}
+
+unsigned char ReadLPCReg(int iRegNum)
+{
+	unsigned char iVal;
+
+	outb(0x87, 0x2e);
+	outb(0x87, 0x2e);
+	outb(iRegNum, 0x2e);
+	iVal = inb(0x2f);
+	outb(0xaa, 0x2e);
+
+	return iVal;
+}
+
+void WriteLPCReg(int iRegNum, unsigned char iVal)
+{
+
+	outb(0x87, 0x2e);
+	outb(0x87, 0x2e);
+	outb(iRegNum, 0x2e);
+	outb(iVal, 0x2f);
+	outb(0xAA, 0x2e);
+}
+
+__u8 ReadReg(unsigned int BaseAddr, int iRegNum)
+{
+	return ((__u8) inb(BaseAddr + iRegNum));
+}
+
+void WriteReg(unsigned int BaseAddr, int iRegNum, unsigned char iVal)
+{
+	outb(iVal, BaseAddr + iRegNum);
+}
+
+int WriteRegBit(unsigned int BaseAddr, unsigned char RegNum,
+		unsigned char BitPos, unsigned char value)
+{
+	__u8 Rtemp, Wtemp;
+
+	if (BitPos > 7) {
+		return -1;
+	}
+	if ((RegNum < StartAddr) || (RegNum > EndAddr))
+		return -1;
+	Rtemp = ReadReg(BaseAddr, RegNum);
+	if (value == 0)
+		Wtemp = ResetBit(Rtemp, BitPos);
+	else {
+		if (value == 1)
+			Wtemp = SetBit(Rtemp, BitPos);
+		else
+			return -1;
+	}
+	WriteReg(BaseAddr, RegNum, Wtemp);
+	return 0;
+}
+
+__u8 CheckRegBit(unsigned int BaseAddr, unsigned char RegNum,
+		 unsigned char BitPos)
+{
+	__u8 temp;
+
+	if (BitPos > 7)
+		return 0xff;
+	if ((RegNum < StartAddr) || (RegNum > EndAddr)) {
+//     printf("what is the register %x!\n",RegNum);
+	}
+	temp = ReadReg(BaseAddr, RegNum);
+	return GetBit(temp, BitPos);
+}
+
+__u8 ReadPCIByte(__u8 bus, __u8 device, __u8 fun, __u8 reg)
+{
+	__u32 dTmp;
+	__u8 bData, bTmp;
+
+	bTmp = reg & ~0x03;
+	dTmp = ReadPCI(bus, device, fun, bTmp);
+	bTmp = reg & 0x03;
+	bData = (__u8) (dTmp >> bTmp);
+	return bData;
+}
+
+__u32 ReadPCI(__u8 bus, __u8 device, __u8 fun, __u8 reg)
+{
+	__u32 CONFIG_ADDR, temp, data;
+
+	if ((bus == 0xff) || (device == 0xff) || (fun == 0xff))
+		return 0xffffffff;
+	CONFIG_ADDR = 0x80000000;
+	temp = (__u32) reg << 2;
+	CONFIG_ADDR = CONFIG_ADDR | temp;
+	temp = (__u32) fun << 8;
+	CONFIG_ADDR = CONFIG_ADDR | temp;
+	temp = (__u32) device << 11;
+	CONFIG_ADDR = CONFIG_ADDR | temp;
+	temp = (__u32) bus << 16;
+	CONFIG_ADDR = CONFIG_ADDR | temp;
+
+	outl(PCI_CONFIG_ADDRESS, CONFIG_ADDR);
+	data = inl(PCI_CONFIG_DATA);
+	return data;
+}
+
+
+void WritePCIByte(__u8 bus, __u8 device, __u8 fun, __u8 reg,
+		  __u8 CONFIG_DATA)
+{
+	__u32 dTmp, dTmp1 = 0;
+	__u8 bTmp;
+
+	bTmp = reg & ~0x03;
+	dTmp = ReadPCI(bus, device, fun, bTmp);
+	switch (reg & 0x03) {
+	case 0:
+		dTmp1 = (dTmp & ~0xff) | CONFIG_DATA;
+		break;
+	case 1:
+		dTmp = (dTmp & ~0x00ff00);
+		dTmp1 = CONFIG_DATA;
+		dTmp1 = dTmp1 << 8;
+		dTmp1 = dTmp1 | dTmp;
+		break;
+	case 2:
+		dTmp = (dTmp & ~0xff0000);
+		dTmp1 = CONFIG_DATA;
+		dTmp1 = dTmp1 << 16;
+		dTmp1 = dTmp1 | dTmp;
+		break;
+	case 3:
+		dTmp = (dTmp & ~0xff000000);
+		dTmp1 = CONFIG_DATA;
+		dTmp1 = dTmp1 << 24;
+		dTmp1 = dTmp1 | dTmp;
+		break;
+	}
+	WritePCI(bus, device, fun, bTmp, dTmp1);
+}
+
+//------------------
+void WritePCI(__u8 bus, __u8 device, __u8 fun, __u8 reg, __u32 CONFIG_DATA)
+{
+	__u32 CONFIG_ADDR, temp;
+
+	if ((bus == 0xff) || (device == 0xff) || (fun == 0xff))
+		return;
+	CONFIG_ADDR = 0x80000000;
+	temp = (__u32) reg << 2;
+	CONFIG_ADDR = CONFIG_ADDR | temp;
+	temp = (__u32) fun << 8;
+	CONFIG_ADDR = CONFIG_ADDR | temp;
+	temp = (__u32) device << 11;
+	CONFIG_ADDR = CONFIG_ADDR | temp;
+	temp = (__u32) bus << 16;
+	CONFIG_ADDR = CONFIG_ADDR | temp;
+
+	outl(PCI_CONFIG_ADDRESS, CONFIG_ADDR);
+	outl(PCI_CONFIG_DATA, CONFIG_DATA);
+
+}
+
+											// find device with DeviceID and VenderID                                       // if match return three byte buffer (bus,device,function)                      // no found, address={99,99,99} 
+int mySearchPCI(__u8 * SBridpos, __u16 VID, __u16 DID)
+{
+	__u8 i, j, k;
+	__u16 FindDeviceID, FindVenderID;
+
+	for (k = 0; k < 8; k++) {	//scan function
+		i = 0;
+		j = 0x11;
+		k = 0;
+		if (ReadPCI(i, j, k, 0) < 0xffffffff) {	// not empty
+			FindDeviceID = (__u16) (ReadPCI(i, j, k, 0) >> 16);
+			FindVenderID =
+			    (__u16) (ReadPCI(i, j, k, 0) & 0x0000ffff);
+			if ((VID == FindVenderID) && (DID == FindDeviceID)) {
+				SBridpos[0] = i;	// bus
+				SBridpos[1] = j;	//device
+				SBridpos[2] = k;	//func
+				return 1;
+			}
+		}
+	}
+	return 0;
+}
+
+void SetMaxRxPacketSize(__u16 iobase, __u16 size)
+{
+	__u16 low, high;
+	if ((size & 0xe000) == 0) {
+		low = size & 0x00ff;
+		high = (size & 0x1f00) >> 8;
+		WriteReg(iobase, I_CF_L_2, low);
+		WriteReg(iobase, I_CF_H_2, high);
+
+	}
+
+}
+
+//for both Rx and Tx
+
+void SetFIFO(__u16 iobase, __u16 value)
+{
+	switch (value) {
+	case 128:
+		WriteRegBit(iobase, 0x11, 0, 0);
+		WriteRegBit(iobase, 0x11, 7, 1);
+		break;
+	case 64:
+		WriteRegBit(iobase, 0x11, 0, 0);
+		WriteRegBit(iobase, 0x11, 7, 0);
+		break;
+	case 32:
+		WriteRegBit(iobase, 0x11, 0, 1);
+		WriteRegBit(iobase, 0x11, 7, 0);
+		break;
+	default:
+		WriteRegBit(iobase, 0x11, 0, 0);
+		WriteRegBit(iobase, 0x11, 7, 0);
+	}
+
+}
+
+#define CRC16(BaseAddr,val)         WriteRegBit(BaseAddr,I_CF_L_0,7,val)	//0 for 32 CRC
+/*
+#define SetVFIR(BaseAddr,val)       WriteRegBit(BaseAddr,I_CF_H_0,5,val)
+#define SetFIR(BaseAddr,val)        WriteRegBit(BaseAddr,I_CF_L_0,6,val)
+#define SetMIR(BaseAddr,val)        WriteRegBit(BaseAddr,I_CF_L_0,5,val)
+#define SetSIR(BaseAddr,val)        WriteRegBit(BaseAddr,I_CF_L_0,4,val)
+*/
+#define SIRFilter(BaseAddr,val)     WriteRegBit(BaseAddr,I_CF_L_0,3,val)
+#define Filter(BaseAddr,val)        WriteRegBit(BaseAddr,I_CF_L_0,2,val)
+#define InvertTX(BaseAddr,val)      WriteRegBit(BaseAddr,I_CF_L_0,1,val)
+#define InvertRX(BaseAddr,val)      WriteRegBit(BaseAddr,I_CF_L_0,0,val)
+//****************************I_CF_H_0
+#define EnableTX(BaseAddr,val)      WriteRegBit(BaseAddr,I_CF_H_0,4,val)
+#define EnableRX(BaseAddr,val)      WriteRegBit(BaseAddr,I_CF_H_0,3,val)
+#define EnableDMA(BaseAddr,val)     WriteRegBit(BaseAddr,I_CF_H_0,2,val)
+#define SIRRecvAny(BaseAddr,val)    WriteRegBit(BaseAddr,I_CF_H_0,1,val)
+#define DiableTrans(BaseAddr,val)   WriteRegBit(BaseAddr,I_CF_H_0,0,val)
+//***************************I_SIR_BOF,I_SIR_EOF
+#define SetSIRBOF(BaseAddr,val)     WriteReg(BaseAddr,I_SIR_BOF,val)
+#define SetSIREOF(BaseAddr,val)     WriteReg(BaseAddr,I_SIR_EOF,val)
+#define GetSIRBOF(BaseAddr)        ReadReg(BaseAddr,I_SIR_BOF)
+#define GetSIREOF(BaseAddr)        ReadReg(BaseAddr,I_SIR_EOF)
+//*******************I_ST_CT_0
+#define EnPhys(BaseAddr,val)   WriteRegBit(BaseAddr,I_ST_CT_0,7,val)
+#define IsModeError(BaseAddr) CheckRegBit(BaseAddr,I_ST_CT_0,6)	//RO
+#define IsVFIROn(BaseAddr)     CheckRegBit(BaseAddr,0x14,0)	//RO for VT1211 only
+#define IsFIROn(BaseAddr)     CheckRegBit(BaseAddr,I_ST_CT_0,5)	//RO
+#define IsMIROn(BaseAddr)     CheckRegBit(BaseAddr,I_ST_CT_0,4)	//RO
+#define IsSIROn(BaseAddr)     CheckRegBit(BaseAddr,I_ST_CT_0,3)	//RO
+#define IsEnableTX(BaseAddr)  CheckRegBit(BaseAddr,I_ST_CT_0,2)	//RO
+#define IsEnableRX(BaseAddr)  CheckRegBit(BaseAddr,I_ST_CT_0,1)	//RO
+#define Is16CRC(BaseAddr)     CheckRegBit(BaseAddr,I_ST_CT_0,0)	//RO
+//***************************I_CF_3
+#define DisableAdjacentPulseWidth(BaseAddr,val) WriteRegBit(BaseAddr,I_CF_3,5,val)	//1 disable
+#define DisablePulseWidthAdjust(BaseAddr,val)   WriteRegBit(BaseAddr,I_CF_3,4,val)	//1 disable
+#define UseOneRX(BaseAddr,val)                  WriteRegBit(BaseAddr,I_CF_3,1,val)	//0 use two RX
+#define SlowIRRXLowActive(BaseAddr,val)         WriteRegBit(BaseAddr,I_CF_3,0,val)	//0 show RX high=1 in SIR
+//***************************H_CT
+#define EnAllInt(BaseAddr,val)   WriteRegBit(BaseAddr,H_CT,7,val)
+#define TXStart(BaseAddr,val)    WriteRegBit(BaseAddr,H_CT,6,val)
+#define RXStart(BaseAddr,val)    WriteRegBit(BaseAddr,H_CT,5,val)
+#define ClearRXInt(BaseAddr,val)   WriteRegBit(BaseAddr,H_CT,4,val)	// 1 clear
+//*****************H_ST
+#define IsRXInt(BaseAddr)           CheckRegBit(BaseAddr,H_ST,4)
+#define GetIntIndentify(BaseAddr)   ((ReadReg(BaseAddr,H_ST)&0xf1) >>1)
+#define IsHostBusy(BaseAddr)        CheckRegBit(BaseAddr,H_ST,0)
+#define GetHostStatus(BaseAddr)     ReadReg(BaseAddr,H_ST)	//RO
+//**************************M_CT
+#define EnTXDMA(BaseAddr,val)         WriteRegBit(BaseAddr,M_CT,7,val)
+#define EnRXDMA(BaseAddr,val)         WriteRegBit(BaseAddr,M_CT,6,val)
+#define SwapDMA(BaseAddr,val)         WriteRegBit(BaseAddr,M_CT,5,val)
+#define EnInternalLoop(BaseAddr,val)  WriteRegBit(BaseAddr,M_CT,4,val)
+#define EnExternalLoop(BaseAddr,val)  WriteRegBit(BaseAddr,M_CT,3,val)
+//**************************TX_CT_1
+#define EnTXFIFOHalfLevelInt(BaseAddr,val)   WriteRegBit(BaseAddr,TX_CT_1,4,val)	//half empty int (1 half)
+#define EnTXFIFOUnderrunEOMInt(BaseAddr,val) WriteRegBit(BaseAddr,TX_CT_1,5,val)
+#define EnTXFIFOReadyInt(BaseAddr,val)       WriteRegBit(BaseAddr,TX_CT_1,6,val)	//int when reach it threshold (setting by bit 4)
+//**************************TX_CT_2
+#define ForceUnderrun(BaseAddr,val)   WriteRegBit(BaseAddr,TX_CT_2,7,val)	// force an underrun int
+#define EnTXCRC(BaseAddr,val)         WriteRegBit(BaseAddr,TX_CT_2,6,val)	//1 for FIR,MIR...0 (not SIR)
+#define ForceBADCRC(BaseAddr,val)     WriteRegBit(BaseAddr,TX_CT_2,5,val)	//force an bad CRC
+#define SendSIP(BaseAddr,val)         WriteRegBit(BaseAddr,TX_CT_2,4,val)	//send indication pulse for prevent SIR disturb
+#define ClearEnTX(BaseAddr,val)       WriteRegBit(BaseAddr,TX_CT_2,3,val)	// opposite to EnTX
+//*****************TX_ST
+#define GetTXStatus(BaseAddr) 	ReadReg(BaseAddr,TX_ST)	//RO
+//**************************RX_CT
+#define EnRXSpecInt(BaseAddr,val)           WriteRegBit(BaseAddr,RX_CT,0,val)
+#define EnRXFIFOReadyInt(BaseAddr,val)      WriteRegBit(BaseAddr,RX_CT,1,val)	//enable int when reach it threshold (setting by bit 7)
+#define EnRXFIFOHalfLevelInt(BaseAddr,val)  WriteRegBit(BaseAddr,RX_CT,7,val)	//enable int when (1) half full...or (0) just not full
+//*****************RX_ST
+#define GetRXStatus(BaseAddr) 	ReadReg(BaseAddr,RX_ST)	//RO
+//***********************P_ADDR
+#define SetPacketAddr(BaseAddr,addr)        WriteReg(BaseAddr,P_ADDR,addr)
+//***********************I_CF_4
+#define EnGPIOtoRX2(BaseAddr,val)	WriteRegBit(BaseAddr,I_CF_4,7,val)
+#define EnTimerInt(BaseAddr,val)		WriteRegBit(BaseAddr,I_CF_4,1,val)
+#define ClearTimerInt(BaseAddr,val)	WriteRegBit(BaseAddr,I_CF_4,0,val)
+//***********************I_T_C_L
+#define WriteGIO(BaseAddr,val)	    WriteRegBit(BaseAddr,I_T_C_L,7,val)
+#define ReadGIO(BaseAddr)		    CheckRegBit(BaseAddr,I_T_C_L,7)
+#define ReadRX(BaseAddr)		    CheckRegBit(BaseAddr,I_T_C_L,3)	//RO
+#define WriteTX(BaseAddr,val)		WriteRegBit(BaseAddr,I_T_C_L,0,val)
+//***********************I_T_C_H
+#define EnRX2(BaseAddr,val)		    WriteRegBit(BaseAddr,I_T_C_H,7,val)
+#define ReadRX2(BaseAddr)           CheckRegBit(BaseAddr,I_T_C_H,7)
+//**********************Version
+#define GetFIRVersion(BaseAddr)		ReadReg(BaseAddr,VERSION)
+
+
+void SetTimer(__u16 iobase, __u8 count)
+{
+	EnTimerInt(iobase, OFF);
+	WriteReg(iobase, TIMER, count);
+	EnTimerInt(iobase, ON);
+}
+
+
+void SetSendByte(__u16 iobase, __u32 count)
+{
+	__u32 low, high;
+
+	if ((count & 0xf000) == 0) {
+		low = count & 0x00ff;
+		high = (count & 0x0f00) >> 8;
+		WriteReg(iobase, TX_C_L, low);
+		WriteReg(iobase, TX_C_H, high);
+	}
+}
+
+void ResetChip(__u16 iobase, __u8 type)
+{
+	__u8 value;
+
+	value = (type + 2) << 4;
+	WriteReg(iobase, RESET, type);
+}
+
+void SetAddrMode(__u16 iobase, __u8 mode)
+{
+	__u8 bTmp = 0;
+	if (mode < 3) {
+		bTmp = (ReadReg(iobase, RX_CT) & 0xcf) | (mode << 4);
+		WriteReg(iobase, RX_CT, bTmp);
+	}
+}
+
+int CkRxRecv(__u16 iobase, struct via_ircc_cb *self)
+{
+	__u8 low, high;
+	__u16 wTmp = 0, wTmp1 = 0, wTmp_new = 0;
+
+	low = ReadReg(iobase, RX_C_L);
+	high = ReadReg(iobase, RX_C_H);
+	wTmp1 = high;
+	wTmp = (wTmp1 << 8) | low;
+	udelay(10);
+	low = ReadReg(iobase, RX_C_L);
+	high = ReadReg(iobase, RX_C_H);
+	wTmp1 = high;
+	wTmp_new = (wTmp1 << 8) | low;
+	if (wTmp_new != wTmp)
+		return 1;
+	else
+		return 0;
+
+}
+
+__u16 RxCurCount(__u16 iobase, struct via_ircc_cb * self)
+{
+	__u8 low, high;
+	__u16 wTmp = 0, wTmp1 = 0;
+
+	low = ReadReg(iobase, RX_P_L);
+	high = ReadReg(iobase, RX_P_H);
+	wTmp1 = high;
+	wTmp = (wTmp1 << 8) | low;
+	return wTmp;
+}
+
+/* This Routine can only use in recevie_complete
+ * for it will update last count.
+ */
+
+__u16 GetRecvByte(__u16 iobase, struct via_ircc_cb * self)
+{
+	__u8 low, high;
+	__u16 wTmp, wTmp1, ret;
+
+	low = ReadReg(iobase, RX_P_L);
+	high = ReadReg(iobase, RX_P_H);
+	wTmp1 = high;
+	wTmp = (wTmp1 << 8) | low;
+
+
+	if (wTmp >= self->RxLastCount)
+		ret = wTmp - self->RxLastCount;
+	else
+		ret = (0x8000 - self->RxLastCount) + wTmp;
+	self->RxLastCount = wTmp;
+
+/* RX_P is more actually the RX_C
+ low=ReadReg(iobase,RX_C_L);
+ high=ReadReg(iobase,RX_C_H);
+
+ if(!(high&0xe000)) {
+	 temp=(high<<8)+low;
+	 return temp;
+ }
+ else return 0;
+*/
+	return ret;
+}
+
+
+__u16 GetRecvLen(__u16 iobase)
+{
+	__u8 low, high;
+	__u16 temp;
+
+	low = ReadReg(iobase, RX_P_L);
+	high = ReadReg(iobase, RX_P_H);
+
+	if (!(high & 0xe000)) {
+		temp = (high << 8) + low;
+		return temp;
+	} else
+		return 0;
+}
+
+void Sdelay(__u16 scale)
+{
+	__u8 bTmp;
+	int i, j;
+
+	for (j = 0; j < scale; j++) {
+		for (i = 0; i < 0x20; i++) {
+			bTmp = inb(0xeb);
+			outb(bTmp, 0xeb);
+		}
+	}
+}
+
+void Tdelay(__u16 scale)
+{
+	__u8 bTmp;
+	int i, j;
+
+	for (j = 0; j < scale; j++) {
+		for (i = 0; i < 0x50; i++) {
+			bTmp = inb(0xeb);
+			outb(bTmp, 0xeb);
+		}
+	}
+}
+
+
+void ActClk(__u16 iobase, __u8 value)
+{
+	__u8 bTmp;
+	bTmp = ReadReg(iobase, 0x34);
+	if (value)
+		WriteReg(iobase, 0x34, bTmp | Clk_bit);
+	else
+		WriteReg(iobase, 0x34, bTmp & ~Clk_bit);
+}
+
+void ActTx(__u16 iobase, __u8 value)
+{
+	__u8 bTmp;
+
+	bTmp = ReadReg(iobase, 0x34);
+	if (value)
+		WriteReg(iobase, 0x34, bTmp | Tx_bit);
+	else
+		WriteReg(iobase, 0x34, bTmp & ~Tx_bit);
+}
+
+void ClkTx(__u16 iobase, __u8 Clk, __u8 Tx)
+{
+	__u8 bTmp;
+
+	bTmp = ReadReg(iobase, 0x34);
+	if (Clk == 0)
+		bTmp &= ~Clk_bit;
+	else {
+		if (Clk == 1)
+			bTmp |= Clk_bit;
+	}
+	WriteReg(iobase, 0x34, bTmp);
+	Sdelay(1);
+	if (Tx == 0)
+		bTmp &= ~Tx_bit;
+	else {
+		if (Tx == 1)
+			bTmp |= Tx_bit;
+	}
+	WriteReg(iobase, 0x34, bTmp);
+}
+
+void Wr_Byte(__u16 iobase, __u8 data)
+{
+	__u8 bData = data;
+//      __u8 btmp;
+	int i;
+
+	ClkTx(iobase, 0, 1);
+
+	Tdelay(2);
+	ActClk(iobase, 1);
+	Tdelay(1);
+
+	for (i = 0; i < 8; i++) {	//LDN
+
+		if ((bData >> i) & 0x01) {
+			ClkTx(iobase, 0, 1);	//bit data = 1;
+		} else {
+			ClkTx(iobase, 0, 0);	//bit data = 1;
+		}
+		Tdelay(2);
+		Sdelay(1);
+		ActClk(iobase, 1);	//clk hi
+		Tdelay(1);
+	}
+}
+
+__u8 Rd_Indx(__u16 iobase, __u8 addr, __u8 index)
+{
+	__u8 data = 0, bTmp, data_bit;
+	int i;
+
+	bTmp = addr | (index << 1) | 0;
+	ClkTx(iobase, 0, 0);
+	Tdelay(2);
+	ActClk(iobase, 1);
+	udelay(1);
+	Wr_Byte(iobase, bTmp);
+	Sdelay(1);
+	ClkTx(iobase, 0, 0);
+	Tdelay(2);
+	for (i = 0; i < 10; i++) {
+		ActClk(iobase, 1);
+		Tdelay(1);
+		ActClk(iobase, 0);
+		Tdelay(1);
+		ClkTx(iobase, 0, 1);
+		Tdelay(1);
+		bTmp = ReadReg(iobase, 0x34);
+		if (!(bTmp & Rd_Valid))
+			break;
+	}
+	if (!(bTmp & Rd_Valid)) {
+		for (i = 0; i < 8; i++) {
+			ActClk(iobase, 1);
+			Tdelay(1);
+			ActClk(iobase, 0);
+			bTmp = ReadReg(iobase, 0x34);
+			data_bit = 1 << i;
+			if (bTmp & RxBit)
+				data |= data_bit;
+			else
+				data &= ~data_bit;
+			Tdelay(2);
+		}
+	} else {
+		for (i = 0; i < 2; i++) {
+			ActClk(iobase, 1);
+			Tdelay(1);
+			ActClk(iobase, 0);
+			Tdelay(2);
+		}
+		bTmp = ReadReg(iobase, 0x34);
+	}
+	for (i = 0; i < 1; i++) {
+		ActClk(iobase, 1);
+		Tdelay(1);
+		ActClk(iobase, 0);
+		Tdelay(2);
+	}
+	ClkTx(iobase, 0, 0);
+	Tdelay(1);
+	for (i = 0; i < 3; i++) {
+		ActClk(iobase, 1);
+		Tdelay(1);
+		ActClk(iobase, 0);
+		Tdelay(2);
+	}
+	return data;
+}
+
+void Wr_Indx(__u16 iobase, __u8 addr, __u8 index, __u8 data)
+{
+	int i;
+	__u8 bTmp;
+
+	ClkTx(iobase, 0, 0);
+	udelay(2);
+	ActClk(iobase, 1);
+	udelay(1);
+	bTmp = addr | (index << 1) | 1;
+	Wr_Byte(iobase, bTmp);
+	Wr_Byte(iobase, data);
+	for (i = 0; i < 2; i++) {
+		ClkTx(iobase, 0, 0);
+		Tdelay(2);
+		ActClk(iobase, 1);
+		Tdelay(1);
+	}
+	ActClk(iobase, 0);
+}
+
+void ResetDongle(__u16 iobase)
+{
+	int i;
+	ClkTx(iobase, 0, 0);
+	Tdelay(1);
+	for (i = 0; i < 30; i++) {
+		ActClk(iobase, 1);
+		Tdelay(1);
+		ActClk(iobase, 0);
+		Tdelay(1);
+	}
+	ActClk(iobase, 0);
+}
+
+void SetSITmode(__u16 iobase)
+{
+
+	__u8 bTmp;
+
+	bTmp = ReadLPCReg(0x28);
+	WriteLPCReg(0x28, bTmp | 0x10);	//select ITMOFF
+	bTmp = ReadReg(iobase, 0x35);
+	WriteReg(iobase, 0x35, bTmp | 0x40);	// Driver ITMOFF
+	WriteReg(iobase, 0x28, bTmp | 0x80);	// enable All interrupt
+}
+
+void SI_SetMode(__u16 iobase, int mode)
+{
+	//__u32 dTmp;
+	__u8 bTmp;
+
+	WriteLPCReg(0x28, 0x70);	// S/W Reset
+	SetSITmode(iobase);
+	ResetDongle(iobase);
+	udelay(10);
+	Wr_Indx(iobase, 0x40, 0x0, 0x17);	//RX ,APEN enable,Normal power
+	Wr_Indx(iobase, 0x40, 0x1, mode);	//Set Mode
+	Wr_Indx(iobase, 0x40, 0x2, 0xff);	//Set power to FIR VFIR > 1m
+	bTmp = Rd_Indx(iobase, 0x40, 1);
+}
+
+void InitCard(__u16 iobase)
+{
+	ResetChip(iobase, 5);
+	WriteReg(iobase, I_ST_CT_0, 0x00);	// open CHIP on
+	SetSIRBOF(iobase, 0xc0);	// hardware default value
+	SetSIREOF(iobase, 0xc1);
+}
+
+void CommonShutDown(__u16 iobase, __u8 TxDMA)
+{
+	DisableDmaChannel(TxDMA);
+}
+
+void CommonInit(__u16 iobase)
+{
+//  EnTXCRC(iobase,0);
+	SwapDMA(iobase, OFF);
+	SetMaxRxPacketSize(iobase, 0x0fff);	//set to max:4095
+	EnRXFIFOReadyInt(iobase, OFF);
+	EnRXFIFOHalfLevelInt(iobase, OFF);
+	EnTXFIFOHalfLevelInt(iobase, OFF);
+	EnTXFIFOUnderrunEOMInt(iobase, ON);
+//  EnTXFIFOReadyInt(iobase,ON);
+	InvertTX(iobase, OFF);
+	InvertRX(iobase, OFF);
+//  WriteLPCReg(0xF0,0); //(if VT1211 then do this)
+	if (IsSIROn(iobase)) {
+		SIRFilter(iobase, ON);
+		SIRRecvAny(iobase, ON);
+	} else {
+		SIRFilter(iobase, OFF);
+		SIRRecvAny(iobase, OFF);
+	}
+	EnRXSpecInt(iobase, ON);
+	WriteReg(iobase, I_ST_CT_0, 0x80);
+	EnableDMA(iobase, ON);
+}
+
+void SetBaudRate(__u16 iobase, __u32 rate)
+{
+	__u8 value = 11, temp;
+
+	if (IsSIROn(iobase)) {
+		switch (rate) {
+		case (__u32) (2400L):
+			value = 47;
+			break;
+		case (__u32) (9600L):
+			value = 11;
+			break;
+		case (__u32) (19200L):
+			value = 5;
+			break;
+		case (__u32) (38400L):
+			value = 2;
+			break;
+		case (__u32) (57600L):
+			value = 1;
+			break;
+		case (__u32) (115200L):
+			value = 0;
+			break;
+		default:
+			break;
+		};
+	} else if (IsMIROn(iobase)) {
+		value = 0;	// will automatically be fixed in 1.152M
+	} else if (IsFIROn(iobase)) {
+		value = 0;	// will automatically be fixed in 4M
+	}
+	temp = (ReadReg(iobase, I_CF_H_1) & 0x03);
+	temp = temp | (value << 2);
+	WriteReg(iobase, I_CF_H_1, temp);
+}
+
+void SetPulseWidth(__u16 iobase, __u8 width)
+{
+	__u8 temp, temp1, temp2;
+
+	temp = (ReadReg(iobase, I_CF_L_1) & 0x1f);
+	temp1 = (ReadReg(iobase, I_CF_H_1) & 0xfc);
+	temp2 = (width & 0x07) << 5;
+	temp = temp | temp2;
+	temp2 = (width & 0x18) >> 3;
+	temp1 = temp1 | temp2;
+	WriteReg(iobase, I_CF_L_1, temp);
+	WriteReg(iobase, I_CF_H_1, temp1);
+}
+
+void SetSendPreambleCount(__u16 iobase, __u8 count)
+{
+	__u8 temp;
+
+	temp = ReadReg(iobase, I_CF_L_1) & 0xe0;
+	temp = temp | count;
+	WriteReg(iobase, I_CF_L_1, temp);
+
+}
+
+void SetVFIR(__u16 BaseAddr, __u8 val)
+{
+	__u8 tmp;
+
+	tmp = ReadReg(BaseAddr, I_CF_L_0);
+	WriteReg(BaseAddr, I_CF_L_0, tmp & 0x8f);
+	WriteRegBit(BaseAddr, I_CF_H_0, 5, val);
+}
+
+void SetFIR(__u16 BaseAddr, __u8 val)
+{
+	__u8 tmp;
+
+	WriteRegBit(BaseAddr, I_CF_H_0, 5, 0);
+	tmp = ReadReg(BaseAddr, I_CF_L_0);
+	WriteReg(BaseAddr, I_CF_L_0, tmp & 0x8f);
+	WriteRegBit(BaseAddr, I_CF_L_0, 6, val);
+}
+
+void SetMIR(__u16 BaseAddr, __u8 val)
+{
+	__u8 tmp;
+
+	WriteRegBit(BaseAddr, I_CF_H_0, 5, 0);
+	tmp = ReadReg(BaseAddr, I_CF_L_0);
+	WriteReg(BaseAddr, I_CF_L_0, tmp & 0x8f);
+	WriteRegBit(BaseAddr, I_CF_L_0, 5, val);
+}
+
+void SetSIR(__u16 BaseAddr, __u8 val)
+{
+	__u8 tmp;
+
+	WriteRegBit(BaseAddr, I_CF_H_0, 5, 0);
+	tmp = ReadReg(BaseAddr, I_CF_L_0);
+	WriteReg(BaseAddr, I_CF_L_0, tmp & 0x8f);
+	WriteRegBit(BaseAddr, I_CF_L_0, 4, val);
+}
+
+void ClrHBusy(__u16 iobase)
+{
+
+	EnableDMA(iobase, OFF);
+	EnableDMA(iobase, ON);
+	RXStart(iobase, OFF);
+	RXStart(iobase, ON);
+	RXStart(iobase, OFF);
+	EnableDMA(iobase, OFF);
+	EnableDMA(iobase, ON);
+}
+
+void SetFifo64(__u16 iobase)
+{
+
+	WriteRegBit(iobase, I_CF_H_0, 0, 0);
+	WriteRegBit(iobase, I_CF_H_0, 7, 0);
+}
+
+
+#endif				/* via_IRCC_H */
