Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270283AbUJTBUg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270283AbUJTBUg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 21:20:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270271AbUJTBOY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 21:14:24 -0400
Received: from palrel11.hp.com ([156.153.255.246]:4012 "EHLO palrel11.hp.com")
	by vger.kernel.org with ESMTP id S270257AbUJTBGL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 21:06:11 -0400
Date: Tue, 19 Oct 2004 18:06:10 -0700
To: "David S. Miller" <davem@davemloft.net>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.6 IrDA] via-ircc driver speed fixes
Message-ID: <20041020010610.GH12932@bougret.hpl.hp.com>
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

ir269_via_speed_fixes-2.diff :
~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	o [CORRECT] Speed change fixes in via-ircc driver
	o [FEATURE] Add new dongle ID in via-ircc driver
	o [FEATURE] Various code cleanups in via-ircc driver
Signed-off-by: Jean Tourrilhes <jt@hpl.hp.com>


diff -u -p linux/drivers/net/irda/via-ircc.d0.h linux/drivers/net/irda/via-ircc.h
--- linux/drivers/net/irda/via-ircc.d0.h	Wed Sep 22 17:48:03 2004
+++ linux/drivers/net/irda/via-ircc.h	Thu Sep 23 15:58:56 2004
@@ -170,17 +170,6 @@ struct via_ircc_cb {
 			// Sets bit to 1
 #define ResetBit(val,bit) val= (unsigned char ) (val & ~(0x1 << bit))
 			// Sets bit to 0
-#define PCI_CONFIG_ADDRESS 0xcf8
-#define PCI_CONFIG_DATA    0xcfc
-
-#define VenderID    0x1106
-#define DeviceID1   0x8231
-#define DeviceID2   0x3109
-#define DeviceID3   0x3074
-//F01_S
-#define DeviceID4   0x3147
-#define DeviceID5   0x3177
-//F01_E
 
 #define OFF   0
 #define ON   1
@@ -794,7 +783,7 @@ static void SetBaudRate(__u16 iobase, __
 		value = 0;	// will automatically be fixed in 4M
 	}
 	temp = (ReadReg(iobase, I_CF_H_1) & 0x03);
-	temp = temp | (value << 2);
+	temp |= value << 2;
 	WriteReg(iobase, I_CF_H_1, temp);
 }
 
@@ -805,9 +794,9 @@ static void SetPulseWidth(__u16 iobase, 
 	temp = (ReadReg(iobase, I_CF_L_1) & 0x1f);
 	temp1 = (ReadReg(iobase, I_CF_H_1) & 0xfc);
 	temp2 = (width & 0x07) << 5;
-	temp = temp | temp2;
+	temp |= temp2;
 	temp2 = (width & 0x18) >> 3;
-	temp1 = temp1 | temp2;
+	temp1 |= temp2;
 	WriteReg(iobase, I_CF_L_1, temp);
 	WriteReg(iobase, I_CF_H_1, temp1);
 }
@@ -817,7 +806,7 @@ static void SetSendPreambleCount(__u16 i
 	__u8 temp;
 
 	temp = ReadReg(iobase, I_CF_L_1) & 0xe0;
-	temp = temp | count;
+	temp |= count;
 	WriteReg(iobase, I_CF_L_1, temp);
 
 }
diff -u -p linux/drivers/net/irda/via-ircc.d0.c linux/drivers/net/irda/via-ircc.c
--- linux/drivers/net/irda/via-ircc.d0.c	Wed Sep 22 17:47:57 2004
+++ linux/drivers/net/irda/via-ircc.c	Thu Sep 23 15:53:26 2004
@@ -26,6 +26,16 @@ F02 Oct/28/02: Add SB device ID for 3147
        jul/09/2002 : only implement two kind of dongle currently.
        Oct/02/2002 : work on VT8231 and VT8233 .
        Aug/06/2003 : change driver format to pci driver .
+
+2004-02-16: <sda@bdit.de>
+- Removed unneeded 'legacy' pci stuff.
+- Make sure SIR mode is set (hw_init()) before calling mode-dependant stuff.
+- On speed change from core, don't send SIR frame with new speed. 
+  Use current speed and change speeds later.
+- Make module-param dongle_id actually work.
+- New dongle_id 17 (0x11): TDFS4500. Single-ended SIR only. 
+  Tested with home-grown PCB on EPIA boards.
+- Code cleanup.
        
  ********************************************************************/
 #include <linux/module.h>
@@ -53,26 +63,16 @@ F02 Oct/28/02: Add SB device ID for 3147
 
 #include "via-ircc.h"
 
-//#define DBG_IO	1
-//#define   DBGMSG 1
-//#define   DBGMSG_96 1
-//#define   DBGMSG_76 1
-//static int debug=0;
-
-
-#define DBG(x) {if (debug) x;}
+#define VIA_MODULE_NAME "via-ircc"
+#define CHIP_IO_EXTENT 0x40
 
-#define   VIA_MODULE_NAME "via-ircc"
-#define CHIP_IO_EXTENT 8
-#define BROKEN_DONGLE_ID
-
-static char *driver_name = "via-ircc";
+static char *driver_name = VIA_MODULE_NAME;
 
 /* Module parameters */
 static int qos_mtt_bits = 0x07;	/* 1 ms or more */
-static int dongle_id = 9;	//defalut IBM type
+static int dongle_id = 0;	/* default: probe */
 
-/* Resource is allocate by BIOS user only need to supply dongle_id*/
+/* We can't guess the type of connected dongle, user *must* supply it. */
 MODULE_PARM(dongle_id, "i");
 
 /* Max 4 instances for now */
@@ -81,7 +81,6 @@ static struct via_ircc_cb *dev_self[] = 
 /* Some prototypes */
 static int via_ircc_open(int i, chipio_t * info, unsigned int id);
 static int __exit via_ircc_close(struct via_ircc_cb *self);
-static int via_ircc_setup(chipio_t * info, unsigned int id);
 static int via_ircc_dma_receive(struct via_ircc_cb *self);
 static int via_ircc_dma_receive_complete(struct via_ircc_cb *self,
 					 int iobase);
@@ -89,6 +88,7 @@ static int via_ircc_hard_xmit_sir(struct
 				  struct net_device *dev);
 static int via_ircc_hard_xmit_fir(struct sk_buff *skb,
 				  struct net_device *dev);
+static void via_hw_init(struct via_ircc_cb *self);
 static void via_ircc_change_speed(struct via_ircc_cb *self, __u32 baud);
 static irqreturn_t via_ircc_interrupt(int irq, void *dev_id,
 				      struct pt_regs *regs);
@@ -110,7 +110,7 @@ static int upload_rxdata(struct via_ircc
 static int __devinit via_init_one (struct pci_dev *pcidev, const struct pci_device_id *id);
 static void __exit via_remove_one (struct pci_dev *pdev);
 
-/* Should use udelay() instead, even if we are x86 only - Jean II */
+/* FIXME : Should use udelay() instead, even if we are x86 only - Jean II */
 static void iodelay(int udelay)
 {
 	u8 data;
@@ -122,11 +122,11 @@ static void iodelay(int udelay)
 }
 
 static struct pci_device_id via_pci_tbl[] = {
-	{ PCI_VENDOR_ID_VIA, DeviceID1, PCI_ANY_ID, PCI_ANY_ID,0,0,0 },
-	{ PCI_VENDOR_ID_VIA, DeviceID2, PCI_ANY_ID, PCI_ANY_ID,0,0,1 },
-	{ PCI_VENDOR_ID_VIA, DeviceID3, PCI_ANY_ID, PCI_ANY_ID,0,0,2 },
-	{ PCI_VENDOR_ID_VIA, DeviceID4, PCI_ANY_ID, PCI_ANY_ID,0,0,3 },
-	{ PCI_VENDOR_ID_VIA, DeviceID5, PCI_ANY_ID, PCI_ANY_ID,0,0,4 },
+	{ PCI_VENDOR_ID_VIA, 0x8231, PCI_ANY_ID, PCI_ANY_ID,0,0,0 },
+	{ PCI_VENDOR_ID_VIA, 0x3109, PCI_ANY_ID, PCI_ANY_ID,0,0,1 },
+	{ PCI_VENDOR_ID_VIA, 0x3074, PCI_ANY_ID, PCI_ANY_ID,0,0,2 },
+	{ PCI_VENDOR_ID_VIA, 0x3147, PCI_ANY_ID, PCI_ANY_ID,0,0,3 },
+	{ PCI_VENDOR_ID_VIA, 0x3177, PCI_ANY_ID, PCI_ANY_ID,0,0,4 },
 	{ 0, }
 };
 
@@ -150,18 +150,14 @@ static int __init via_ircc_init(void)
 {
 	int rc;
 
-#ifdef	HEADMSG
-        DBG(printk(KERN_INFO "via_ircc_init ......\n"));
-#endif
-	rc = pci_register_driver (&via_driver);
-#ifdef	HEADMSG
-        DBG(printk(KERN_INFO "via_ircc_init :rc = %d......\n",rc));
-#endif
+	IRDA_DEBUG(3, "%s()\n", __FUNCTION__);
+
+	rc = pci_register_driver(&via_driver);
 	if (rc < 1) {
-#ifdef	HEADMSG
-        DBG(printk(KERN_INFO "via_ircc_init return -ENODEV......\n"));
-#endif
-		if (rc == 0)	pci_unregister_driver (&via_driver);
+		IRDA_DEBUG(0, "%s(): error rc = %d, returning  -ENODEV...\n",
+			   __FUNCTION__, rc);
+		if (rc == 0)
+			pci_unregister_driver (&via_driver);
 		return -ENODEV;
 	}
 	return 0;
@@ -174,33 +170,24 @@ static int __devinit via_init_one (struc
         u8 temp,oldPCI_40,oldPCI_44,bTmp,bTmp1;
 	u16 Chipset,FirDRQ1,FirDRQ0,FirIRQ,FirIOBase;
 	chipio_t info;
-	
-#ifdef	HEADMSG
-        DBG(printk(KERN_INFO "via_init_one : Device ID=(0X%X)\n",id->device));
-#endif
-	if(id->device != DeviceID1 && id->device != DeviceID2 &&
-	   id->device != DeviceID3 && id->device != DeviceID4 &&
-	   id->device != DeviceID5  ){
-#ifdef	HEADMSG
-		DBG(printk(KERN_INFO "via_init_one : Device ID(0X%X) not Supported\n",id->device));
-#endif
-	      return -ENODEV; //South not exist !!!!!
-	}
+
+	IRDA_DEBUG(2, "%s(): Device ID=(0X%X)\n", __FUNCTION__, id->device);
+
 	rc = pci_enable_device (pcidev);
-#ifdef	HEADMSG
-	DBG(printk(KERN_INFO "via_init_one : rc=%d\n",rc));
-#endif
-	if (rc)
-		return -ENODEV; 
-        //South Bridge exist
+	if (rc) {
+		IRDA_DEBUG(0, "%s(): error rc = %d\n", __FUNCTION__, rc);
+		return -ENODEV;
+	}
+
+	// South Bridge exist
         if ( ReadLPCReg(0x20) != 0x3C )
 		Chipset=0x3096;
 	else
 		Chipset=0x3076;
+
 	if (Chipset==0x3076) {
-#ifdef	HEADMSG
-		DBG(printk(KERN_INFO "via_init_one : 3076 ......\n"));
-#endif
+		IRDA_DEBUG(2, "%s(): Chipset = 3076\n", __FUNCTION__);
+
 		WriteLPCReg(7,0x0c );
 		temp=ReadLPCReg(0x30);//check if BIOS Enable Fir
 		if((temp&0x01)==1) {   // BIOS close or no FIR
@@ -236,9 +223,8 @@ static int __devinit via_init_one (struc
 		} else
 			rc = -ENODEV; //IR not turn on	 
 	} else { //Not VT1211
-#ifdef	HEADMSG
-		DBG(printk(KERN_INFO "via_init_one : 3096 ......\n"));
-#endif
+		IRDA_DEBUG(2, "%s(): Chipset = 3096\n", __FUNCTION__);
+
 		pci_read_config_byte(pcidev,0x67,&bTmp);//check if BIOS Enable Fir
 		if((bTmp&0x01)==1) {  // BIOS enable FIR
 			//Enable Double DMA clock
@@ -276,9 +262,8 @@ static int __devinit via_init_one (struc
 		} else
 			rc = -ENODEV; //IR not turn on !!!!!
 	}//Not VT1211
-#ifdef	HEADMSG
-	DBG(printk(KERN_INFO "via_init_one End : rc=%d\n",rc));
-#endif
+
+	IRDA_DEBUG(2, "%s(): End - rc = %d\n", __FUNCTION__, rc);
 	return rc;
 }
 
@@ -292,9 +277,8 @@ static void __exit via_ircc_clean(void)
 {
 	int i;
 
-#ifdef	HEADMSG
-	DBG(printk(KERN_INFO "via_ircc_clean\n"));
-#endif
+	IRDA_DEBUG(3, "%s()\n", __FUNCTION__);
+
 	for (i=0; i < 4; i++) {
 		if (dev_self[i])
 			via_ircc_close(dev_self[i]);
@@ -303,19 +287,16 @@ static void __exit via_ircc_clean(void)
 
 static void __exit via_remove_one (struct pci_dev *pdev)
 {
-#ifdef	HEADMSG
-        DBG(printk(KERN_INFO "via_remove_one :  ......\n"));
-#endif
+	IRDA_DEBUG(3, "%s()\n", __FUNCTION__);
+
 	via_ircc_clean();
 
 }
 
 static void __exit via_ircc_cleanup(void)
 {
+	IRDA_DEBUG(3, "%s()\n", __FUNCTION__);
 
-#ifdef	HEADMSG
-	DBG(printk(KERN_INFO "via_ircc_cleanup ......\n"));
-#endif
 	via_ircc_clean();
 	pci_unregister_driver (&via_driver); 
 }
@@ -332,8 +313,7 @@ static __devinit int via_ircc_open(int i
 	struct via_ircc_cb *self;
 	int err;
 
-	if ((via_ircc_setup(info, id)) == -1)
-		return -1;
+	IRDA_DEBUG(3, "%s()\n", __FUNCTION__);
 
 	/* Allocate new instance of the driver */
 	dev = alloc_irdadev(sizeof(struct via_ircc_cb));
@@ -361,19 +341,40 @@ static __devinit int via_ircc_open(int i
 
 	/* Reserve the ioports that we need */
 	if (!request_region(self->io.fir_base, self->io.fir_ext, driver_name)) {
-//              WARNING("%s(), can't get iobase of 0x%03x\n", __FUNCTION__, self->io.fir_base);
+		IRDA_DEBUG(0, "%s(), can't get iobase of 0x%03x\n",
+			   __FUNCTION__, self->io.fir_base);
 		err = -ENODEV;
 		goto err_out1;
 	}
 	
 	/* Initialize QoS for this device */
 	irda_init_max_qos_capabilies(&self->qos);
+
+	/* Check if user has supplied the dongle id or not */
+	if (!dongle_id)
+		dongle_id = via_ircc_read_dongle_id(self->io.fir_base);
+	self->io.dongle_id = dongle_id;
+
 	/* The only value we must override it the baudrate */
-//      self->qos.baud_rate.bits = IR_9600;// May use this for testing
+	/* Maximum speeds and capabilities are dongle-dependant. */
+	switch( self->io.dongle_id ){
+	case 0x0d:
+		self->qos.baud_rate.bits =
+		    IR_9600 | IR_19200 | IR_38400 | IR_57600 | IR_115200 |
+		    IR_576000 | IR_1152000 | (IR_4000000 << 8);
+		break;
+	default:
+		self->qos.baud_rate.bits =
+		    IR_9600 | IR_19200 | IR_38400 | IR_57600 | IR_115200;
+		break;
+	}
 
-	self->qos.baud_rate.bits =
-	    IR_9600 | IR_19200 | IR_38400 | IR_57600 | IR_115200 |
-	    IR_576000 | IR_1152000 | (IR_4000000 << 8);
+	/* Following was used for testing:
+	 *
+	 *   self->qos.baud_rate.bits = IR_9600;
+	 *
+	 * Is is no good, as it prohibits (error-prone) speed-changes.
+	 */
 
 	self->qos.min_turn_time.bits = qos_mtt_bits;
 	irda_qos_bits_to_value(&self->qos);
@@ -424,15 +425,12 @@ static __devinit int via_ircc_open(int i
 	if (err)
 		goto err_out4;
 
-	MESSAGE("IrDA: Registered device %s\n", dev->name);
-
-	/* Check if user has supplied the dongle id or not */
-	if (!dongle_id)
-		dongle_id = via_ircc_read_dongle_id(self->io.fir_base);
-	self->io.dongle_id = dongle_id;
-	via_ircc_change_dongle_speed(self->io.fir_base, 9600,
-				     self->io.dongle_id);
+	MESSAGE("IrDA: Registered device %s (via-ircc)\n", dev->name);
 
+	/* Initialise the hardware..
+	*/
+	self->io.speed = 9600;
+	via_hw_init(self);
 	return 0;
  err_out4:
 	dma_free_coherent(NULL, self->tx_buff.truesize,
@@ -458,7 +456,7 @@ static int __exit via_ircc_close(struct 
 {
 	int iobase;
 
-	IRDA_DEBUG(4, "%s()\n", __FUNCTION__);
+	IRDA_DEBUG(3, "%s()\n", __FUNCTION__);
 
 	ASSERT(self != NULL, return -1;);
 
@@ -469,7 +467,7 @@ static int __exit via_ircc_close(struct 
 	unregister_netdev(self->netdev);
 
 	/* Release the PORT that this driver is using */
-	IRDA_DEBUG(4, "%s(), Releasing Region %03x\n",
+	IRDA_DEBUG(2, "%s(), Releasing Region %03x\n",
 		   __FUNCTION__, self->io.fir_base);
 	release_region(self->io.fir_base, self->io.fir_ext);
 	if (self->tx_buff.head)
@@ -486,14 +484,17 @@ static int __exit via_ircc_close(struct 
 }
 
 /*
- * Function via_ircc_setup (info)
+ * Function via_hw_init(self)
  *
  *    Returns non-negative on success.
  *
+ * Formerly via_ircc_setup 
  */
-static int via_ircc_setup(chipio_t * info, unsigned int chip_id)
+static void via_hw_init(struct via_ircc_cb *self)
 {
-	int iobase = info->fir_base;
+	int iobase = self->io.fir_base;
+
+	IRDA_DEBUG(3, "%s()\n", __FUNCTION__);
 
 	SetMaxRxPacketSize(iobase, 0x0fff);	//set to max:4095
 	// FIFO Init
@@ -504,22 +505,40 @@ static int via_ircc_setup(chipio_t * inf
 	EnTXFIFOReadyInt(iobase, OFF);
 	InvertTX(iobase, OFF);
 	InvertRX(iobase, OFF);
+
 	if (ReadLPCReg(0x20) == 0x3c)
 		WriteLPCReg(0xF0, 0);	// for VT1211
-	if (IsSIROn(iobase)) {
-		SIRFilter(iobase, ON);
-		SIRRecvAny(iobase, ON);
-	} else {
-		SIRFilter(iobase, OFF);
-		SIRRecvAny(iobase, OFF);
-	}
-	//Int Init
+	/* Int Init */
 	EnRXSpecInt(iobase, ON);
-	//DMA Init Later....
-	WriteReg(iobase, I_ST_CT_0, 0x80);
-	EnableDMA(iobase, ON);
 
-	return 0;
+	/* The following is basically hwreset */
+	/* If this is the case, why not just call hwreset() ? Jean II */
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
+
+	self->io.speed = 9600;
+	self->st_fifo.len = 0;
+
+	via_ircc_change_dongle_speed(iobase, self->io.speed,
+				     self->io.dongle_id);
+
+	WriteReg(iobase, I_ST_CT_0, 0x80);
 }
 
 /*
@@ -528,8 +547,9 @@ static int via_ircc_setup(chipio_t * inf
  */
 static int via_ircc_read_dongle_id(int iobase)
 {
-	int dongle_id = 9;
+	int dongle_id = 9;	/* Default to IBM */
 
+	ERROR("via-ircc: dongle probing not supported, please specify dongle_id module parameter.\n");
 	return dongle_id;
 }
 
@@ -543,22 +563,16 @@ static void via_ircc_change_dongle_speed
 {
 	u8 mode = 0;
 
-	WriteReg(iobase, I_ST_CT_0, 0x0);
-	switch (dongle_id) {	//HP1100
-	case 0x00:		/* same as */
-	case 0x01:		/* Differential serial interface */
-		break;
-	case 0x02:		/* same as */
-	case 0x03:		/* Reserved */
-		break;
-	case 0x04:		/* Sharp RY5HD01 */
-		break;
-	case 0x05:		/* Reserved, but this is what the Thinkpad reports */
-		break;
-	case 0x06:		/* Single-ended serial interface */
-		break;
-	case 0x07:		/* Consumer-IR only */
-		break;
+	/* speed is unused, as we use IsSIROn()/IsMIROn() */
+	speed = speed;
+
+	IRDA_DEBUG(1, "%s(): change_dongle_speed to %d for 0x%x, %d\n",
+		   __FUNCTION__, speed, iobase, dongle_id);
+
+	switch (dongle_id) {
+
+		/* Note: The dongle_id's listed here are derived from
+		 * nsc-ircc.c */ 
 
 	case 0x08:		/* HP HSDL-2300, HP HSDL-3600/HSDL-3610 */
 		UseOneRX(iobase, ON);	// use one RX pin   RX1,RX2
@@ -587,10 +601,12 @@ static void via_ircc_change_dongle_speed
 			}
 		}
 		break;
+
 	case 0x09:		/* IBM31T1100 or Temic TFDS6000/TFDS6500 */
 		UseOneRX(iobase, ON);	//use ONE RX....RX1
 		InvertTX(iobase, OFF);
 		InvertRX(iobase, OFF);	// invert RX pin
+
 		EnRX2(iobase, ON);
 		EnGPIOtoRX2(iobase, OFF);
 		if (IsSIROn(iobase)) {	//sir
@@ -621,6 +637,7 @@ static void via_ircc_change_dongle_speed
 			}
 		}
 		break;
+
 	case 0x0d:
 		UseOneRX(iobase, OFF);	// use two RX pin   RX1,RX2
 		InvertTX(iobase, OFF);
@@ -636,6 +653,31 @@ static void via_ircc_change_dongle_speed
 			EnRX2(iobase, OFF);	//fir to rx
 		}
 		break;
+
+	case 0x11:		/* Temic TFDS4500 */
+
+		IRDA_DEBUG(2, "%s: Temic TFDS4500: One RX pin, TX normal, RX inverted.\n", __FUNCTION__);
+
+		UseOneRX(iobase, ON);	//use ONE RX....RX1
+		InvertTX(iobase, OFF);
+		InvertRX(iobase, ON);	// invert RX pin
+	
+		EnRX2(iobase, ON);	//sir to rx2
+		EnGPIOtoRX2(iobase, OFF);
+
+		if( IsSIROn(iobase) ){	//sir
+
+			// Mode select On
+			SlowIRRXLowActive(iobase, ON);
+			udelay(20);
+			// Mode select Off
+			SlowIRRXLowActive(iobase, OFF);
+
+		} else{
+			IRDA_DEBUG(0, "%s: Warning: TFDS4500 not running in SIR mode !\n", __FUNCTION__);
+		}
+		break;
+
 	case 0x0ff:		/* Vishay */
 		if (IsSIROn(iobase))
 			mode = 0;
@@ -646,9 +688,12 @@ static void via_ircc_change_dongle_speed
 		else if (IsVFIROn(iobase))
 			mode = 5;	//VFIR-16
 		SI_SetMode(iobase, mode);
-	}
-	WriteReg(iobase, I_ST_CT_0, 0x80);
+		break;
 
+	default:
+		ERROR("%s: Error: dongle_id %d unsupported !\n",
+		      __FUNCTION__, dongle_id);
+	}
 }
 
 /*
@@ -666,46 +711,25 @@ static void via_ircc_change_speed(struct
 	iobase = self->io.fir_base;
 	/* Update accounting for new speed */
 	self->io.speed = speed;
-#ifdef	DBGMSG
-	DBG(printk(KERN_INFO "change_speed =%x......\n", speed));
-#endif
-
-#ifdef	DBG_IO
-	if (self->io.speed > 0x2580)
-		outb(0xaa, 0x90);
-	else
-		outb(0xbb, 0x90);
-#endif
+	IRDA_DEBUG(1, "%s: change_speed to %d bps.\n", __FUNCTION__, speed);
 
+	WriteReg(iobase, I_ST_CT_0, 0x0);
 
 	/* Controller mode sellection */
 	switch (speed) {
+	case 2400:
 	case 9600:
-		value = 11;
-		SetSIR(iobase, ON);
-		CRC16(iobase, ON);
-		break;
 	case 19200:
-		value = 5;
-		SetSIR(iobase, ON);
-		CRC16(iobase, ON);
-		break;
 	case 38400:
-		value = 2;
-		SetSIR(iobase, ON);
-		CRC16(iobase, ON);
-		break;
 	case 57600:
-		value = 1;
-		SetSIR(iobase, ON);
-		CRC16(iobase, ON);
-		break;
 	case 115200:
-		value = 0;
+		value = (115200/speed)-1;
 		SetSIR(iobase, ON);
 		CRC16(iobase, ON);
 		break;
 	case 576000:
+		/* FIXME: this can't be right, as it's the same as 115200,
+		 * and 576000 is MIR, not SIR. */
 		value = 0;
 		SetSIR(iobase, ON);
 		CRC16(iobase, ON);
@@ -713,6 +737,7 @@ static void via_ircc_change_speed(struct
 	case 1152000:
 		value = 0;
 		SetMIR(iobase, ON);
+		/* FIXME: CRC ??? */
 		break;
 	case 4000000:
 		value = 0;
@@ -725,19 +750,29 @@ static void via_ircc_change_speed(struct
 	case 16000000:
 		value = 0;
 		SetVFIR(iobase, ON);
+		/* FIXME: CRC ??? */
 		break;
 	default:
 		value = 0;
 		break;
 	}
+
 	/* Set baudrate to 0x19[2..7] */
 	bTmp = (ReadReg(iobase, I_CF_H_1) & 0x03);
-	bTmp = bTmp | (value << 2);
+	bTmp |= value << 2;
 	WriteReg(iobase, I_CF_H_1, bTmp);
+
+	/* Some dongles may need to be informed about speed changes. */
 	via_ircc_change_dongle_speed(iobase, speed, self->io.dongle_id);
-// EnTXFIFOHalfLevelInt(iobase,ON);
+
 	/* Set FIFO size to 64 */
 	SetFIFO(iobase, 64);
+
+	/* Enable IR */
+	WriteReg(iobase, I_ST_CT_0, 0x80);
+
+	// EnTXFIFOHalfLevelInt(iobase,ON);
+
 	/* Enable some interrupts so we can receive frames */
 	//EnAllInt(iobase,ON);
 
@@ -748,6 +783,7 @@ static void via_ircc_change_speed(struct
 		SIRFilter(iobase, OFF);
 		SIRRecvAny(iobase, OFF);
 	}
+
 	if (speed > 115200) {
 		/* Install FIR xmit handler */
 		dev->hard_start_xmit = via_ircc_hard_xmit_fir;
@@ -805,7 +841,8 @@ static int via_ircc_hard_xmit_sir(struct
 			   self->tx_buff.truesize);
 
 	self->stats.tx_bytes += self->tx_buff.len;
-	SetBaudRate(iobase, speed);
+	/* Send this frame with old speed */
+	SetBaudRate(iobase, self->io.speed);
 	SetPulseWidth(iobase, 12);
 	SetSendPreambleCount(iobase, 0);
 	WriteReg(iobase, I_ST_CT_0, 0x80);
@@ -887,9 +924,6 @@ static int via_ircc_hard_xmit_fir(struct
 
 static int via_ircc_dma_xmit(struct via_ircc_cb *self, u16 iobase)
 {
-//      int i;
-//      u8 *ch;
-
 	EnTXDMA(iobase, OFF);
 	self->io.direction = IO_XMIT;
 	EnPhys(iobase, ON);
@@ -907,18 +941,10 @@ static int via_ircc_dma_xmit(struct via_
 		       ((u8 *)self->tx_fifo.queue[self->tx_fifo.ptr].start -
 			self->tx_buff.head) + self->tx_buff_dma,
 		       self->tx_fifo.queue[self->tx_fifo.ptr].len, DMA_TX_MODE);
-#ifdef	DBGMSG
-	DBG(printk
-	    (KERN_INFO "dma_xmit:tx_fifo.ptr=%x,len=%x,tx_fifo.len=%x..\n",
-	     self->tx_fifo.ptr, self->tx_fifo.queue[self->tx_fifo.ptr].len,
-	     self->tx_fifo.len));
-/*   
-	ch = self->tx_fifo.queue[self->tx_fifo.ptr].start;
-	for(i=0 ; i < self->tx_fifo.queue[self->tx_fifo.ptr].len ; i++) {
-	    DBG(printk(KERN_INFO "%x..\n",ch[i]));
-	}
-*/
-#endif
+	IRDA_DEBUG(1, "%s: tx_fifo.ptr=%x,len=%x,tx_fifo.len=%x..\n",
+		   __FUNCTION__, self->tx_fifo.ptr,
+		   self->tx_fifo.queue[self->tx_fifo.ptr].len,
+		   self->tx_fifo.len);
 
 	SetSendByte(iobase, self->tx_fifo.queue[self->tx_fifo.ptr].len);
 	RXStart(iobase, OFF);
@@ -940,7 +966,8 @@ static int via_ircc_dma_xmit_complete(st
 	int ret = TRUE;
 	u8 Tx_status;
 
-	IRDA_DEBUG(2, "%s()\n", __FUNCTION__);
+	IRDA_DEBUG(3, "%s()\n", __FUNCTION__);
+
 	iobase = self->io.fir_base;
 	/* Disable DMA */
 //      DisableDmaChannel(self->io.dma);
@@ -970,12 +997,10 @@ static int via_ircc_dma_xmit_complete(st
 			self->tx_fifo.ptr++;
 		}
 	}
-#ifdef	DBGMSG
-	DBG(printk
-	    (KERN_INFO
-	     "via_ircc_dma_xmit_complete:tx_fifo.len=%x ,tx_fifo.ptr=%x,tx_fifo.free=%x...\n",
-	     self->tx_fifo.len, self->tx_fifo.ptr, self->tx_fifo.free));
-#endif
+	IRDA_DEBUG(1,
+		   "%s: tx_fifo.len=%x ,tx_fifo.ptr=%x,tx_fifo.free=%x...\n",
+		   __FUNCTION__,
+		   self->tx_fifo.len, self->tx_fifo.ptr, self->tx_fifo.free);
 /* F01_S
 	// Any frames to be sent back-to-back? 
 	if (self->tx_fifo.len) {
@@ -1010,6 +1035,8 @@ static int via_ircc_dma_receive(struct v
 
 	iobase = self->io.fir_base;
 
+	IRDA_DEBUG(3, "%s()\n", __FUNCTION__);
+
 	self->tx_fifo.len = self->tx_fifo.ptr = self->tx_fifo.free = 0;
 	self->tx_fifo.tail = self->tx_buff.head;
 	self->RxDataReady = 0;
@@ -1017,6 +1044,7 @@ static int via_ircc_dma_receive(struct v
 	self->rx_buff.data = self->rx_buff.head;
 	self->st_fifo.len = self->st_fifo.pending_bytes = 0;
 	self->st_fifo.tail = self->st_fifo.head = 0;
+
 	EnPhys(iobase, ON);
 	EnableTX(iobase, OFF);
 	EnableRX(iobase, ON);
@@ -1090,22 +1118,16 @@ static int via_ircc_dma_receive_complete
 		if (len == 0)
 			return TRUE;	//interrupt only, data maybe move by RxT  
 		if (((len - 4) < 2) || ((len - 4) > 2048)) {
-#ifdef	DBGMSG
-			DBG(printk
-			    (KERN_INFO
-			     "receive_comple:Trouble:len=%x,CurCount=%x,LastCount=%x..\n",
-			     len, RxCurCount(iobase, self),
-			     self->RxLastCount));
-#endif
+			IRDA_DEBUG(1, "%s(): Trouble:len=%x,CurCount=%x,LastCount=%x..\n",
+				   __FUNCTION__, len, RxCurCount(iobase, self),
+				   self->RxLastCount);
 			hwreset(self);
 			return FALSE;
 		}
-#ifdef	DBGMSG
-		DBG(printk
-		    (KERN_INFO
-		     "recv_comple:fifo.len=%x,len=%x,CurCount=%x..\n",
-		     st_fifo->len, len - 4, RxCurCount(iobase, self)));
-#endif
+		IRDA_DEBUG(2, "%s(): fifo.len=%x,len=%x,CurCount=%x..\n",
+			   __FUNCTION__,
+			   st_fifo->len, len - 4, RxCurCount(iobase, self));
+
 		st_fifo->entries[st_fifo->tail].status = status;
 		st_fifo->entries[st_fifo->tail].len = len;
 		st_fifo->pending_bytes += len;
@@ -1148,16 +1170,11 @@ F01_E */
 		}
 		skb_reserve(skb, 1);
 		skb_put(skb, len - 4);
+
 		memcpy(skb->data, self->rx_buff.data, len - 4);
-#ifdef	DBGMSG
-		DBG(printk
-		    (KERN_INFO "RxT:len=%x.rx_buff=%x\n", len - 4,
-		     self->rx_buff.data));
-/*		for(i=0 ; i < (len-4) ; i++) {
-		    DBG(printk(KERN_INFO "%x..\n",self->rx_buff.data[i]));
-		}
-*/
-#endif
+		IRDA_DEBUG(2, "%s(): len=%x.rx_buff=%p\n", __FUNCTION__,
+			   len - 4, self->rx_buff.data);
+
 		// Move to next frame 
 		self->rx_buff.data += len;
 		self->stats.rx_bytes += len;
@@ -1185,9 +1202,8 @@ static int upload_rxdata(struct via_ircc
 
 	len = GetRecvByte(iobase, self);
 
-#ifdef	DBGMSG
-	DBG(printk(KERN_INFO "upload_rxdata: len=%x\n", len));
-#endif
+	IRDA_DEBUG(2, "%s(): len=%x\n", __FUNCTION__, len);
+
 	skb = dev_alloc_skb(len + 1);
 	if ((skb == NULL) || ((len - 4) < 2)) {
 		self->stats.rx_dropped++;
@@ -1265,11 +1281,10 @@ static int RxTimerHandler(struct via_irc
 			skb_reserve(skb, 1);
 			skb_put(skb, len - 4);
 			memcpy(skb->data, self->rx_buff.data, len - 4);
-#ifdef	DBGMSG
-			DBG(printk
-			    (KERN_INFO "RxT:len=%x.head=%x\n", len - 4,
-			     st_fifo->head));
-#endif
+
+			IRDA_DEBUG(2, "%s(): len=%x.head=%x\n", __FUNCTION__,
+				   len - 4, st_fifo->head);
+
 			// Move to next frame 
 			self->rx_buff.data += len;
 			self->stats.rx_bytes += len;
@@ -1280,12 +1295,12 @@ static int RxTimerHandler(struct via_irc
 			netif_rx(skb);
 		}		//while
 		self->RetryCount = 0;
-#ifdef	DBGMSG
-		DBG(printk
-		    (KERN_INFO
-		     "RxT:End of upload HostStatus=%x,RxStatus=%x\n",
-		     GetHostStatus(iobase), GetRXStatus(iobase)));
-#endif
+
+		IRDA_DEBUG(2,
+			   "%s(): End of upload HostStatus=%x,RxStatus=%x\n",
+			   __FUNCTION__,
+			   GetHostStatus(iobase), GetRXStatus(iobase));
+
 		/*
 		 * if frame is receive complete at this routine ,then upload
 		 * frame.
@@ -1328,6 +1343,14 @@ static irqreturn_t via_ircc_interrupt(in
 	iobase = self->io.fir_base;
 	spin_lock(&self->lock);
 	iHostIntType = GetHostStatus(iobase);
+
+	IRDA_DEBUG(4, "%s(): iHostIntType %02x:  %s %s %s  %02x\n",
+		   __FUNCTION__, iHostIntType,
+		   (iHostIntType & 0x40) ? "Timer" : "",
+		   (iHostIntType & 0x20) ? "Tx" : "",
+		   (iHostIntType & 0x10) ? "Rx" : "",
+		   (iHostIntType & 0x0e) >> 1);
+
 	if ((iHostIntType & 0x40) != 0) {	//Timer Event
 		self->EventFlag.TimeOut++;
 		ClearTimerInt(iobase, 1);
@@ -1340,8 +1363,7 @@ static irqreturn_t via_ircc_interrupt(in
 			 */
 			if (self->RxDataReady > 30) {
 				hwreset(self);
-				if (irda_device_txqueue_empty
-				    (self->netdev)) {
+				if (irda_device_txqueue_empty(self->netdev)) {
 					via_ircc_dma_receive(self);
 				}
 			} else {	// call this to upload frame.
@@ -1351,6 +1373,14 @@ static irqreturn_t via_ircc_interrupt(in
 	}			//Timer Event
 	if ((iHostIntType & 0x20) != 0) {	//Tx Event
 		iTxIntType = GetTXStatus(iobase);
+
+		IRDA_DEBUG(4, "%s(): iTxIntType %02x:  %s %s %s %s\n",
+			   __FUNCTION__, iTxIntType,
+			   (iTxIntType & 0x08) ? "FIFO underr." : "",
+			   (iTxIntType & 0x04) ? "EOM" : "",
+			   (iTxIntType & 0x02) ? "FIFO ready" : "",
+			   (iTxIntType & 0x01) ? "Early EOM" : "");
+
 		if (iTxIntType & 0x4) {
 			self->EventFlag.EOMessage++;	// read and will auto clean
 			if (via_ircc_dma_xmit_complete(self)) {
@@ -1367,10 +1397,19 @@ static irqreturn_t via_ircc_interrupt(in
 	if ((iHostIntType & 0x10) != 0) {	//Rx Event
 		/* Check if DMA has finished */
 		iRxIntType = GetRXStatus(iobase);
-#ifdef	DBGMSG
+
+		IRDA_DEBUG(4, "%s(): iRxIntType %02x:  %s %s %s %s %s %s %s\n",
+			   __FUNCTION__, iRxIntType,
+			   (iRxIntType & 0x80) ? "PHY err."	: "",
+			   (iRxIntType & 0x40) ? "CRC err"	: "",
+			   (iRxIntType & 0x20) ? "FIFO overr."	: "",
+			   (iRxIntType & 0x10) ? "EOF"		: "",
+			   (iRxIntType & 0x08) ? "RxData"	: "",
+			   (iRxIntType & 0x02) ? "RxMaxLen"	: "",
+			   (iRxIntType & 0x01) ? "SIR bad"	: "");
 		if (!iRxIntType)
-			DBG(printk(KERN_INFO " RxIRQ =0\n"));
-#endif
+			IRDA_DEBUG(3, "%s(): RxIRQ =0\n", __FUNCTION__);
+
 		if (iRxIntType & 0x10) {
 			if (via_ircc_dma_receive_complete(self, iobase)) {
 //F01       if(!(IsFIROn(iobase)))  via_ircc_dma_receive(self);
@@ -1378,14 +1417,11 @@ static irqreturn_t via_ircc_interrupt(in
 			}
 		}		// No ERR     
 		else {		//ERR
-#ifdef	DBGMSG
-			DBG(printk
-			    (KERN_INFO
-			     " RxIRQ ERR:iRxIntType=%x,HostIntType=%x,CurCount=%x,RxLastCount=%x_____\n",
-			     iRxIntType, iHostIntType, RxCurCount(iobase,
-								  self),
-			     self->RxLastCount));
-#endif
+			IRDA_DEBUG(4, "%s(): RxIRQ ERR:iRxIntType=%x,HostIntType=%x,CurCount=%x,RxLastCount=%x_____\n",
+				   __FUNCTION__, iRxIntType, iHostIntType,
+				   RxCurCount(iobase, self),
+				   self->RxLastCount);
+
 			if (iRxIntType & 0x20) {	//FIFO OverRun ERR
 				ResetChip(iobase, 0);
 				ResetChip(iobase, 1);
@@ -1406,9 +1442,9 @@ static void hwreset(struct via_ircc_cb *
 {
 	int iobase;
 	iobase = self->io.fir_base;
-#ifdef	DBGMSG
-	DBG(printk(KERN_INFO "hwreset  ....\n"));
-#endif
+
+	IRDA_DEBUG(3, "%s()\n", __FUNCTION__);
+
 	ResetChip(iobase, 5);
 	EnableDMA(iobase, OFF);
 	EnableTX(iobase, OFF);
@@ -1428,7 +1464,10 @@ static void hwreset(struct via_ircc_cb *
 	SetPulseWidth(iobase, 12);
 	SetSendPreambleCount(iobase, 0);
 	WriteReg(iobase, I_ST_CT_0, 0x80);
+
+	/* Restore speed. */
 	via_ircc_change_speed(self, self->io.speed);
+
 	self->st_fifo.len = 0;
 }
 
@@ -1448,9 +1487,9 @@ static int via_ircc_is_receiving(struct 
 	iobase = self->io.fir_base;
 	if (CkRxRecv(iobase, self))
 		status = TRUE;
-#ifdef	DBGMSG
-	DBG(printk(KERN_INFO "is_receiving  status=%x....\n", status));
-#endif
+
+	IRDA_DEBUG(2, "%s(): status=%x....\n", __FUNCTION__, status);
+
 	return status;
 }
 
@@ -1467,15 +1506,14 @@ static int via_ircc_net_open(struct net_
 	int iobase;
 	char hwname[32];
 
-	IRDA_DEBUG(4, "%s()\n", __FUNCTION__);
+	IRDA_DEBUG(3, "%s()\n", __FUNCTION__);
 
 	ASSERT(dev != NULL, return -1;);
 	self = (struct via_ircc_cb *) dev->priv;
 	self->stats.rx_packets = 0;
 	ASSERT(self != NULL, return 0;);
 	iobase = self->io.fir_base;
-	if (request_irq
-	    (self->io.irq, via_ircc_interrupt, 0, dev->name, dev)) {
+	if (request_irq(self->io.irq, via_ircc_interrupt, 0, dev->name, dev)) {
 		WARNING("%s, unable to allocate irq=%d\n", driver_name,
 			self->io.irq);
 		return -EAGAIN;
@@ -1504,6 +1542,10 @@ static int via_ircc_net_open(struct net_
 	EnAllInt(iobase, ON);
 	EnInternalLoop(iobase, OFF);
 	EnExternalLoop(iobase, OFF);
+
+	/* */
+	via_ircc_dma_receive(self);
+
 	/* Ready to play! */
 	netif_start_queue(dev);
 
@@ -1511,12 +1553,8 @@ static int via_ircc_net_open(struct net_
 	 * Open new IrLAP layer instance, now that everything should be
 	 * initialized properly 
 	 */
-	sprintf(hwname, "VIA");
-	/*
-	 * for different kernel ,irlap_open have different parameter.
-	 */
+	sprintf(hwname, "VIA @ 0x%x", iobase);
 	self->irlap = irlap_open(dev, &self->qos, hwname);
-//      self->irlap = irlap_open(dev, &self->qos);
 
 	self->RxLastCount = 0;
 
@@ -1534,16 +1572,12 @@ static int via_ircc_net_close(struct net
 	struct via_ircc_cb *self;
 	int iobase;
 
-	IRDA_DEBUG(4, "%s()\n", __FUNCTION__);
+	IRDA_DEBUG(3, "%s()\n", __FUNCTION__);
 
 	ASSERT(dev != NULL, return -1;);
 	self = (struct via_ircc_cb *) dev->priv;
 	ASSERT(self != NULL, return 0;);
 
-#ifdef	DBG_IO
-	outb(0xff, 0x90);
-	outb(0xff, 0x94);
-#endif
 	/* Stop device */
 	netif_stop_queue(dev);
 	/* Stop and remove instance of IrLAP */
@@ -1580,7 +1614,7 @@ static int via_ircc_net_ioctl(struct net
 	ASSERT(dev != NULL, return -1;);
 	self = dev->priv;
 	ASSERT(self != NULL, return -1;);
-	IRDA_DEBUG(2, "%s(), %s, (cmd=0x%X)\n", __FUNCTION__, dev->name,
+	IRDA_DEBUG(1, "%s(), %s, (cmd=0x%X)\n", __FUNCTION__, dev->name,
 		   cmd);
 	/* Disable interrupts & save flags */
 	spin_lock_irqsave(&self->lock, flags);
