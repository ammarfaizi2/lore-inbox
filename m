Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266251AbRGTLkF>; Fri, 20 Jul 2001 07:40:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266937AbRGTLj7>; Fri, 20 Jul 2001 07:39:59 -0400
Received: from mailout05.sul.t-online.com ([194.25.134.82]:21512 "EHLO
	mailout05.sul.t-online.de") by vger.kernel.org with ESMTP
	id <S266251AbRGTLjk>; Fri, 20 Jul 2001 07:39:40 -0400
From: Stefani Seibold <stefani@seibold.net>
Date: Fri, 20 Jul 2001 12:36:24 +0100
X-Mailer: KMail [version 1.2]
Content-Type: Multipart/Mixed;
  charset="us-ascii";
  boundary="------------Boundary-00=_O8SRX0779KVVWVCAFQFM"
To: torvalds@transmeta.com, alan@lxorguk.ukuu.org.uk
In-Reply-To: <Pine.SGI.4.10.10102071945350.926064-100000@Sky.inp.nsk.su>
In-Reply-To: <Pine.SGI.4.10.10102071945350.926064-100000@Sky.inp.nsk.su>
Subject: irda smc patch... oops
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <01072013362400.12348@deepthought>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing


--------------Boundary-00=_O8SRX0779KVVWVCAFQFM
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8bit

Hi folks,

sorry about the previous patch, it was my test code, which will not work....

This patch make the linux irda smc-ircc driver working with the newer LPC47xxx smc chips, 
mostly found notebook computers.

I added also support for all smc super i/o chips, which i have found a reference manual
on the smc webpage:

FDC37C44
FDC37C665GT
FDC37C669
FDC37C669
FDC37C78
FDC37N769
FDC37N869
FDC37B72X
FDC37B77X
FDC37B78X
FDC37B80X
FDC37C67X
FDC37C93X
FDC37C93XAPM
FDC37C93XFR
FDC37M707
FDC37M81X
FDC37N958FR
FDC37N972
LPC47N227
LPC47N267
LPC47B27X
LPC47B37X
LPC47M10X
LPC47M120
LPC47M13X
LPC47M14X
LPC47N252
LPC47S42X

It was tested currently on my INSPIRON 8000, so feedbacks are welcome

I hope this patch will go in to the 2.4 tree...

Greetings

diff -u --recursive --new-file linux-2.4.6-ac5/drivers/net/irda/smc-ircc.c.save linux-2.4.6-ac5/drivers/net/irda/smc-ircc.c
--- linux-2.4.6-ac5/drivers/net/irda/smc-ircc.c.save	Fri Jul 20 10:32:05 2001
+++ linux-2.4.6-ac5/drivers/net/irda/smc-ircc.c	Fri Jul 20 11:52:27 2001
@@ -8,7 +8,10 @@
  * Created at:    
  * Modified at:   Tue Feb 22 10:05:06 2000
  * Modified by:   Dag Brattli <dag@brattli.net>
+ * Modified at:   Tue Jun 26 2001
+ * Modified by:   Stefani Seibold <stefani@seibold.net>
  * 
+ *     Copyright (c) 2001      Stefani Seibold
  *     Copyright (c) 1999-2000 Dag Brattli
  *     Copyright (c) 1998-1999 Thomas Davis, 
  *     All Rights Reserved.
@@ -28,8 +31,9 @@
  *     Foundation, Inc., 59 Temple Place, Suite 330, Boston, 
  *     MA 02111-1307 USA
  *
- *     SIO's: SMC FDC37N869, FDC37C669, FDC37N958
- *     Applicable Models : Fujitsu Lifebook 635t, Sony PCG-505TX
+ *     SIO's: all SIO documentet by SMC (June, 2001)
+ *     Applicable Models :	Fujitsu Lifebook 635t, Sony PCG-505TX,
+ *     				Dell Inspiron 8000
  *
  ********************************************************************/
 
@@ -60,23 +64,27 @@
 #include <net/irda/smc-ircc.h>
 #include <net/irda/irport.h>
 
+struct smc_chip {
+	char *name;
+	u16 flags;
+	u8 devid;
+	u8 rev;
+};
+typedef struct smc_chip smc_chip_t;
+
 static char *driver_name = "smc-ircc";
 
-#define CHIP_IO_EXTENT 8
+#define	DIM(x)	(sizeof(x)/(sizeof(*(x))))
 
-static unsigned int io[]  = { ~0, ~0 }; 
-static unsigned int io2[] = { 0, 0 };
+#define CHIP_IO_EXTENT 8
 
 static struct ircc_cb *dev_self[] = { NULL, NULL};
 
 /* Some prototypes */
-static int  ircc_open(int i, unsigned int iobase, unsigned int board_addr);
+static int  ircc_open(unsigned int iobase, unsigned int board_addr);
 #ifdef MODULE
 static int  ircc_close(struct ircc_cb *self);
 #endif /* MODULE */
-static int  ircc_probe(int iobase, int board_addr);
-static int  ircc_probe_58(smc_chip_t *chip, chipio_t *info);
-static int  ircc_probe_69(smc_chip_t *chip, chipio_t *info);
 static int  ircc_dma_receive(struct ircc_cb *self, int iobase); 
 static void ircc_dma_receive_complete(struct ircc_cb *self, int iobase);
 static int  ircc_hard_xmit(struct sk_buff *skb, struct net_device *dev);
@@ -91,20 +99,73 @@
 static int  ircc_net_close(struct net_device *dev);
 static int  ircc_pmproc(struct pm_dev *dev, pm_request_t rqst, void *data);
 
-/* These are the currently known SMC chipsets */
-static smc_chip_t chips[] =
+#define	KEY55_1	0	// SuperIO Configuration mode with Key <0x55>
+#define	KEY55_2	1	// SuperIO Configuration mode with Key <0x55,0x55>
+#define	NoIRDA	2	// SuperIO Chip has no IRDA Port
+#define	SIR	0	// SuperIO Chip has only slow IRDA
+#define	FIR	4	// SuperIO Chip has fast IRDA
+#define	SERx4	8	// SuperIO Chip supports 115,2 KBaud * 4=460,8 KBaud
+
+/* These are the currently known SMC SuperIO chipsets */
+static smc_chip_t fdc_chips_flat[]=
+{
+	// Base address 0x3f0 or 0x370
+	{ "37C44",	KEY55_1|NoIRDA,		0x00, 0x00 }, /* This chip can not detected */
+	{ "37C665GT",	KEY55_2|NoIRDA,		0x65, 0x01 },
+	{ "37C665GT",	KEY55_2|NoIRDA,		0x66, 0x01 },
+	{ "37C669",	KEY55_2|SIR|SERx4,	0x03, 0x02 },
+	{ "37C669",	KEY55_2|SIR|SERx4,	0x04, 0x02 }, /* ID? */
+	{ "37C78",	KEY55_2|NoIRDA,		0x78, 0x00 },
+	{ "37N769",	KEY55_1|FIR|SERx4,	0x28, 0x00 },
+	{ "37N869",	KEY55_1|FIR|SERx4,	0x29, 0x00 },
+	{ NULL }
+};
+
+static smc_chip_t fdc_chips_paged[]=
+{
+	{ "37B72X",	KEY55_1|SIR|SERx4,	0x4c, 0x00 },
+	{ "37B77X",	KEY55_1|SIR|SERx4,	0x43, 0x00 },
+	{ "37B78X",	KEY55_1|SIR|SERx4,	0x44, 0x00 },
+	{ "37B80X",	KEY55_1|SIR|SERx4,	0x42, 0x00 },
+	{ "37C67X",	KEY55_1|FIR|SERx4,	0x40, 0x00 },
+	{ "37C93X",	KEY55_2|SIR|SERx4,	0x02, 0x01 },
+	{ "37C93XAPM",	KEY55_1|SIR|SERx4,	0x30, 0x01 },
+	{ "37C93XFR",	KEY55_2|FIR|SERx4,	0x03, 0x01 },
+	{ "37M707",	KEY55_1|SIR|SERx4,	0x42, 0x00 },
+	{ "37M81X",	KEY55_1|SIR|SERx4,	0x4d, 0x00 },
+	{ "37N958FR",	KEY55_1|FIR|SERx4,	0x09, 0x04 },
+	{ "37N972",	KEY55_1|FIR|SERx4,	0x0a, 0x00 },
+	{ "37N972",	KEY55_1|FIR|SERx4,	0x0b, 0x00 },
+	{ NULL }
+};
+
+static smc_chip_t lpc_chips_flat[]=
 {
-	{ "FDC37C669", 0x55, 0x55, 0x0d, 0x04, ircc_probe_69 },
-	{ "FDC37N769", 0x55, 0x55, 0x0d, 0x28, ircc_probe_69 },
-	{ "FDC37N869", 0x55, 0x00, 0x0d, 0x29, ircc_probe_69 },
-	{ "FDC37N958", 0x55, 0x55, 0x20, 0x09, ircc_probe_58 },
-	{ "FDC37N971", 0x55, 0x55, 0x20, 0x0a, ircc_probe_58 },
-	{ "FDC37N972", 0x55, 0x55, 0x20, 0x0b, ircc_probe_58 },
+	// Base address 0x2E or 0x4E
+	{ "47N227",	KEY55_1|FIR|SERx4,	0x5a, 0x00 },
+	{ "47N267",	KEY55_1|FIR|SERx4,	0x5e, 0x00 },
+	{ NULL }
+};
+
+static smc_chip_t lpc_chips_paged[]=
+{
+	{ "47B27X",	KEY55_1|SIR|SERx4,	0x51, 0x00 },
+	{ "47B37X",	KEY55_1|SIR|SERx4,	0x52, 0x00 },
+	{ "47M10X",	KEY55_1|SIR|SERx4,	0x59, 0x00 },
+	{ "47M120",	KEY55_1|NoIRDA|SERx4,	0x5c, 0x00 },
+	{ "47M13X",	KEY55_1|SIR|SERx4,	0x59, 0x00 },
+	{ "47M14X",	KEY55_1|SIR|SERx4,	0x5f, 0x00 },
+	{ "47N252",	KEY55_1|FIR|SERx4,	0x0e, 0x00 },
+	{ "47S42X",	KEY55_1|SIR|SERx4,	0x57, 0x00 },
 	{ NULL }
 };
 
 static int ircc_irq=255;
 static int ircc_dma=255;
+static int ircc_fir=0;
+static int ircc_sir=0;
+
+static unsigned short	dev_count=0;
 
 static inline void register_bank(int iobase, int bank)
 {
@@ -112,6 +173,209 @@
                iobase+IRCC_MASTER);
 }
 
+static int smc_access(unsigned short cfg_base,unsigned char reg)
+{
+	IRDA_DEBUG(0, __FUNCTION__ "()\n");
+
+	outb(reg, cfg_base);
+
+	if (inb(cfg_base)!=reg)
+		return -1;
+
+	return 0;
+}
+
+static smc_chip_t * smc_probe(unsigned short cfg_base,u8 reg,smc_chip_t *chip,char *type)
+{
+	u8	devid,xdevid; 
+	u8	rev; 
+
+	IRDA_DEBUG(0, __FUNCTION__ "()\n");
+
+	/* Leave configuration */
+
+	outb(0xaa, cfg_base);
+
+	if (inb(cfg_base)==0xaa)	/* not a smc superio chip */
+		return NULL;
+
+	outb(reg, cfg_base);
+
+	xdevid=inb(cfg_base+1);
+
+	/* Enter configuration */
+
+	outb(0x55, cfg_base);
+
+	if (smc_access(cfg_base,0x55))	/* send second key and check */
+		return NULL;
+
+	/* probe device ID */
+
+	if (smc_access(cfg_base,reg))
+		return NULL;
+
+	devid=inb(cfg_base+1);
+
+	if (devid==0)			/* typical value for unused port */
+		return NULL;
+
+	if (devid==0xff)		/* typical value for unused port */
+		return NULL;
+
+	/* probe revision ID */
+
+	if (smc_access(cfg_base,reg+1))
+		return NULL;
+
+	rev=inb(cfg_base+1);
+
+	if (rev>=128)			/* i think this will make no sense */
+		return NULL;
+
+	if (devid==xdevid)		/* protection against false positives */        
+		return NULL;
+
+	/* Check for expected device ID; are there others? */
+
+	while(chip->devid!=devid) {
+
+		chip++;
+
+		if (chip->name==NULL)
+			return NULL;
+	}
+	if (chip->rev>rev)
+		return NULL;
+
+	MESSAGE("found SMC SuperIO Chip (devid=0x%02x rev=%02X base=0x%04x): %s%s\n",devid,rev,cfg_base,type,chip->name);
+	
+	if (chip->flags&NoIRDA)
+		MESSAGE("chipset does not support IRDA\n");
+
+	return chip;
+}
+
+/*
+ * Function smc_superio_flat (chip, base, type)
+ *
+ *    Try get configuration of a smc SuperIO chip with flat register model
+ *
+ */
+static int smc_superio_flat(smc_chip_t *chips, unsigned short cfg_base, char *type)
+{
+	unsigned short fir_io;
+	unsigned short sir_io;
+	__u8 mode;
+	int ret = -ENODEV;
+
+	IRDA_DEBUG(0, __FUNCTION__ "()\n");
+
+	if (smc_probe(cfg_base,0xD,chips,type)==NULL)
+		return ret;
+
+	outb(0x0c, cfg_base);
+
+	mode = inb(cfg_base+1);
+	mode = (mode & 0x38) >> 3;
+		
+	/* Value for IR port */
+	if (mode && mode < 4) {
+		/* SIR iobase */
+		outb(0x25, cfg_base);
+		sir_io = inb(cfg_base+1) << 2;
+
+	       	/* FIR iobase */
+		outb(0x2b, cfg_base);
+		fir_io = inb(cfg_base+1) << 3;
+
+		if (fir_io) {
+			if (ircc_open(fir_io, sir_io) == 0)
+				ret=0; 
+		}
+	}
+	
+	/* Exit configuration */
+	outb(0xaa, cfg_base);
+
+	return ret;
+}
+
+/*
+ * Function smc_superio_paged (chip, base, type)
+ *
+ *    Try  get configuration of a smc SuperIO chip with paged register model
+ *
+ */
+static int smc_superio_paged(smc_chip_t *chips, unsigned short cfg_base, char *type)
+{
+	unsigned short fir_io;
+	unsigned short sir_io;
+	int ret = -ENODEV;
+	
+	IRDA_DEBUG(0, __FUNCTION__ "()\n");
+
+	if (smc_probe(cfg_base,0x20,chips,type)==NULL)
+		return ret;
+	
+	/* Select logical device (UART2) */
+	outb(0x07, cfg_base);
+	outb(0x05, cfg_base + 1);
+		
+	/* SIR iobase */
+	outb(0x60, cfg_base);
+	sir_io  = inb(cfg_base + 1) << 8;
+	outb(0x61, cfg_base);
+	sir_io |= inb(cfg_base + 1);
+		
+	/* Read FIR base */
+	outb(0x62, cfg_base);
+	fir_io = inb(cfg_base + 1) << 8;
+	outb(0x63, cfg_base);
+	fir_io |= inb(cfg_base + 1);
+	outb(0x2b, cfg_base); // ???
+
+	if (fir_io) {
+		if (ircc_open(fir_io, sir_io) == 0)
+			ret=0; 
+	}
+	
+	/* Exit configuration */
+	outb(0xaa, cfg_base);
+
+	return ret;
+}
+
+static int smc_superio_fdc(unsigned short cfg_base)
+{
+	if (check_region(cfg_base, 2) < 0) {
+		IRDA_DEBUG(0, __FUNCTION__ ": can't get cfg_base of 0x%03x\n",
+			   cfg_base);
+		return -1;
+	}
+
+	if (!smc_superio_flat(fdc_chips_flat,cfg_base,"FDC")||!smc_superio_paged(fdc_chips_paged,cfg_base,"FDC"))
+		return 0;
+
+	return -1;
+}
+
+static int smc_superio_lpc(unsigned short cfg_base)
+{
+#if 0
+	if (check_region(cfg_base, 2) < 0) {
+		IRDA_DEBUG(0, __FUNCTION__ ": can't get cfg_base of 0x%03x\n",
+			   cfg_base);
+		return -1;
+	}
+#endif
+
+	if (!smc_superio_flat(lpc_chips_flat,cfg_base,"LPC")||!smc_superio_paged(lpc_chips_paged,cfg_base,"LPC"))
+		return 0;
+
+	return -1;
+}
+
 /*
  * Function ircc_init ()
  *
@@ -120,37 +384,36 @@
  */
 int __init ircc_init(void)
 {
-	static int smcreg[] = { 0x3f0, 0x370 };
-	smc_chip_t *chip;
-	chipio_t info;
-	int ret = -ENODEV;
-	int i;
+	int ret=-ENODEV;
 
 	IRDA_DEBUG(0, __FUNCTION__ "\n");
 
-	/* Probe for all the NSC chipsets we know about */
-	for (chip=chips; chip->name ; chip++) {
-		for (i=0; i<2; i++) {
-			info.cfg_base = smcreg[i];
-			
-			/* 
-			 * First we check if the user has supplied any
-                         * parameters which we should use instead of probed
-			 * values
-			 */
-			if (io[i] < 0x2000) {
-				info.fir_base = io[i];
-				info.sir_base = io2[i];
-			} else if (chip->probe(chip, &info) < 0)
-				continue;
-			if (check_region(info.fir_base, CHIP_IO_EXTENT) < 0)
-				continue;
-			if (check_region(info.sir_base, CHIP_IO_EXTENT) < 0)
-				continue;
-			if (ircc_open(i, info.fir_base, info.sir_base) == 0)
-				ret = 0; 
-		}
+	dev_count=0;
+
+	if ((ircc_fir>0)&&(ircc_sir>0)) {
+	        MESSAGE(" Overriding FIR address 0x%04x\n", ircc_fir);
+		MESSAGE(" Overriding SIR address 0x%04x\n", ircc_sir);
+
+		if (ircc_open(ircc_fir, ircc_sir) == 0)
+			return 0;
+
+		return -ENODEV;
 	}
+
+	/* Trys to open for all the SMC chipsets we know about */
+
+	IRDA_DEBUG(0, __FUNCTION__ 
+	" Try to open all known SMC chipsets\n");
+
+	if (!smc_superio_fdc(0x3f0))
+		ret=0;
+	if (!smc_superio_fdc(0x370))
+		ret=0;
+	if (!smc_superio_lpc(0x2e))
+		ret=0;
+	if (!smc_superio_lpc(0x4e))
+		ret=0;
+
 	return ret;
 }
 
@@ -177,24 +440,57 @@
 /*
  * Function ircc_open (iobase, irq)
  *
- *    Open driver instance
+ *    Try to open driver instance
  *
  */
-static int ircc_open(int i, unsigned int fir_base, unsigned int sir_base)
+static int ircc_open(unsigned int fir_base, unsigned int sir_base)
 {
 	struct ircc_cb *self;
         struct irport_cb *irport;
-	int config;
-	int ret;
+	unsigned char low, high, chip, config, dma, irq, version;
+
 
 	IRDA_DEBUG(0, __FUNCTION__ "\n");
 
-	if ((config = ircc_probe(fir_base, sir_base)) == -1) {
+	if (check_region(fir_base, CHIP_IO_EXTENT) < 0) {
+		IRDA_DEBUG(0, __FUNCTION__ ": can't get fir_base of 0x%03x\n",
+			   fir_base);
+		return -ENODEV;
+	}
+#if POSSIBLE_USED_BY_SERIAL_DRIVER
+	if (check_region(sir_base, CHIP_IO_EXTENT) < 0) {
+		IRDA_DEBUG(0, __FUNCTION__ ": can't get sir_base of 0x%03x\n",
+			   sir_base);
+		return -ENODEV;
+	}
+#endif
+
+	register_bank(fir_base, 3);
+
+	high    = inb(fir_base+IRCC_ID_HIGH);
+	low     = inb(fir_base+IRCC_ID_LOW);
+	chip    = inb(fir_base+IRCC_CHIP_ID);
+	version = inb(fir_base+IRCC_VERSION);
+	config  = inb(fir_base+IRCC_INTERFACE);
+
+	irq     = config >> 4 & 0x0f;
+	dma     = config & 0x0f;
+
+        if (high != 0x10 || low != 0xb8 || (chip != 0xf1 && chip != 0xf2)) { 
 	        IRDA_DEBUG(0, __FUNCTION__ 
 			   "(), addr 0x%04x - no device found!\n", fir_base);
-		return -1;
+		return -ENODEV;
 	}
-	
+	MESSAGE("SMC IrDA Controller found\n IrCC version %d.%d, "
+		"firport 0x%03x, sirport 0x%03x dma=%d, irq=%d\n",
+		chip & 0x0f, version, fir_base, sir_base, dma, irq);
+
+	if (dev_count>DIM(dev_self)) {
+	        IRDA_DEBUG(0, __FUNCTION__ 
+			   "(), to many devices!\n");
+		return -ENOMEM;
+	}
+
 	/*
 	 *  Allocate new instance of the driver
 	 */
@@ -206,46 +502,74 @@
 	}
 	memset(self, 0, sizeof(struct ircc_cb));
 	spin_lock_init(&self->lock);
-   
-	/* Need to store self somewhere */
-	dev_self[i] = self;
 
-	irport = irport_open(i, sir_base, config >> 4 & 0x0f);
-	if (!irport)
+	/* Max DMA buffer size needed = (data_size + 6) * (window_size) + 6; */
+	self->rx_buff.truesize = 4000; 
+	self->tx_buff.truesize = 4000;
+
+	self->rx_buff.head = (__u8 *) kmalloc(self->rx_buff.truesize,
+					      GFP_KERNEL|GFP_DMA);
+	if (self->rx_buff.head == NULL) {
+		ERROR("%s, Can't allocate memory for receive buffer!\n",
+                      driver_name);
+		kfree(self);
+		return -ENOMEM;
+	}
+
+	self->tx_buff.head = (__u8 *) kmalloc(self->tx_buff.truesize, 
+					      GFP_KERNEL|GFP_DMA);
+	if (self->tx_buff.head == NULL) {
+		ERROR("%s, Can't allocate memory for transmit buffer!\n",
+                      driver_name);
+		kfree(self->rx_buff.head);
+		kfree(self);
+		return -ENOMEM;
+	}
+
+	irport = irport_open(dev_count, sir_base, irq);
+	if (!irport) {
+		kfree(self->tx_buff.head);
+		kfree(self->rx_buff.head);
+		kfree(self);
 		return -ENODEV;
+	}
+
+	memset(self->rx_buff.head, 0, self->rx_buff.truesize);
+	memset(self->tx_buff.head, 0, self->tx_buff.truesize);
+   
+	/* Need to store self somewhere */
+	dev_self[dev_count++] = self;
 
 	/* Steal the network device from irport */
 	self->netdev = irport->netdev;
 	self->irport = irport;
+
 	irport->priv = self;
 
 	/* Initialize IO */
 	self->io.fir_base  = fir_base;
         self->io.sir_base  = sir_base; /* Used by irport */
-        self->io.irq       = config >> 4 & 0x0f;
+        self->io.fir_ext   = CHIP_IO_EXTENT;
+        self->io.sir_ext   = 8;       /* Used by irport */
+
 	if (ircc_irq < 255) {
-	        MESSAGE("%s, Overriding IRQ - chip says %d, using %d\n",
-			driver_name, self->io.irq, ircc_irq);
+		if (ircc_irq!=irq)
+			MESSAGE("%s, Overriding IRQ - chip says %d, using %d\n",
+				driver_name, self->io.irq, ircc_irq);
 		self->io.irq = ircc_irq;
 	}
-        self->io.fir_ext   = CHIP_IO_EXTENT;
-        self->io.sir_ext   = 8;       /* Used by irport */
-        self->io.dma       = config & 0x0f;
+	else
+		self->io.irq = irq;
 	if (ircc_dma < 255) {
-	        MESSAGE("%s, Overriding DMA - chip says %d, using %d\n",
-			driver_name, self->io.dma, ircc_dma);
+		if (ircc_dma!=dma)
+			MESSAGE("%s, Overriding DMA - chip says %d, using %d\n",
+				driver_name, self->io.dma, ircc_dma);
 		self->io.dma = ircc_dma;
 	}
+	else
+		self->io.dma = dma;
 
-	/* Lock the port that we need */
-	ret = check_region(self->io.fir_base, self->io.fir_ext);
-	if (ret < 0) { 
-		IRDA_DEBUG(0, __FUNCTION__ ": can't get fir_base of 0x%03x\n",
-			   self->io.fir_base);
-                kfree(self);
-		return -ENODEV;
-	}
-	request_region(self->io.fir_base, self->io.fir_ext, driver_name);
+	request_region(fir_base, CHIP_IO_EXTENT, driver_name);
 
 	/* Initialize QoS for this device */
 	irda_init_max_qos_capabilies(&irport->qos);
@@ -260,23 +584,6 @@
 
 	irport->flags = IFF_FIR|IFF_MIR|IFF_SIR|IFF_DMA|IFF_PIO;
 	
-	/* Max DMA buffer size needed = (data_size + 6) * (window_size) + 6; */
-	self->rx_buff.truesize = 4000; 
-	self->tx_buff.truesize = 4000;
-
-	self->rx_buff.head = (__u8 *) kmalloc(self->rx_buff.truesize,
-					      GFP_KERNEL|GFP_DMA);
-	if (self->rx_buff.head == NULL)
-		return -ENOMEM;
-	memset(self->rx_buff.head, 0, self->rx_buff.truesize);
-	
-	self->tx_buff.head = (__u8 *) kmalloc(self->tx_buff.truesize, 
-					      GFP_KERNEL|GFP_DMA);
-	if (self->tx_buff.head == NULL) {
-		kfree(self->rx_buff.head);
-		return -ENOMEM;
-	}
-	memset(self->tx_buff.head, 0, self->tx_buff.truesize);
 
 	self->rx_buff.in_frame = FALSE;
 	self->rx_buff.state = OUTSIDE_FRAME;
@@ -295,6 +602,10 @@
         if (self->pmdev)
                 self->pmdev->data = self;
 
+	/* Power on device */
+
+	outb(0x00, fir_base+IRCC_MASTER);
+
 	return 0;
 }
 
@@ -347,146 +658,6 @@
 #endif /* MODULE */
 
 /*
- * Function ircc_probe_69 (chip, info)
- *
- *    Probes for the SMC FDC37C669 and FDC37N869
- *
- */
-static int ircc_probe_69(smc_chip_t *chip, chipio_t *info)
-{
-	int cfg_base = info->cfg_base;
-	__u8 devid, mode;
-	int ret = -ENODEV;
-	int fir_io;
-	
-	IRDA_DEBUG(0, __FUNCTION__ "()\n");
-
-	/* Enter configuration */
-	outb(chip->entr1, cfg_base);
-	outb(chip->entr2, cfg_base);
-	
-	outb(chip->cid_index, cfg_base);
-	devid = inb(cfg_base+1);
-	IRDA_DEBUG(0, __FUNCTION__ "(), devid=0x%02x\n",devid);
-	
-	/* Check for expected device ID; are there others? */
-	if (devid == chip->cid_value) {
-		outb(0x0c, cfg_base);
-		mode = inb(cfg_base+1);
-		mode = (mode & 0x38) >> 3;
-		
-		/* Value for IR port */
-		if (mode && mode < 4) {
-			/* SIR iobase */
-			outb(0x25, cfg_base);
-			info->sir_base = inb(cfg_base+1) << 2;
-
-		       	/* FIR iobase */
-			outb(0x2b, cfg_base);
-			fir_io = inb(cfg_base+1) << 3;
-			if (fir_io) {
-				ret = 0;
-				info->fir_base = fir_io;
-			}
-		}
-	}
-	
-	/* Exit configuration */
-	outb(0xaa, cfg_base);
-
-	return ret;
-}
-
-/*
- * Function ircc_probe_58 (chip, info)
- *
- *    Probes for the SMC FDC37N958
- *
- */
-static int ircc_probe_58(smc_chip_t *chip, chipio_t *info)
-{
-	int cfg_base = info->cfg_base;
-	__u8 devid;
-	int ret = -ENODEV;
-	int fir_io;
-	
-	IRDA_DEBUG(0, __FUNCTION__ "()\n");
-
-	/* Enter configuration */
-	outb(chip->entr1, cfg_base);
-	outb(chip->entr2, cfg_base);
-	
-	outb(chip->cid_index, cfg_base);
-	devid = inb(cfg_base+1);
-	IRDA_DEBUG(0, __FUNCTION__ "(), devid=0x%02x\n",devid);
-	
-	/* Check for expected device ID; are there others? */
-	if (devid == chip->cid_value) {
-		/* Select logical device (UART2) */
-		outb(0x07, cfg_base);
-		outb(0x05, cfg_base + 1);
-		
-		/* SIR iobase */
-		outb(0x60, cfg_base);
-		info->sir_base = inb(cfg_base + 1) << 8;
-		outb(0x61, cfg_base);
-		info->sir_base |= inb(cfg_base + 1);
-		
-		/* Read FIR base */
-		outb(0x62, cfg_base);
-		fir_io = inb(cfg_base + 1) << 8;
-		outb(0x63, cfg_base);
-		fir_io |= inb(cfg_base + 1);
-		outb(0x2b, cfg_base);
-		if (fir_io) {
-			ret = 0;
-			info->fir_base = fir_io;
-		}
-	}
-	
-	/* Exit configuration */
-	outb(0xaa, cfg_base);
-
-	return ret;
-}
-
-/*
- * Function ircc_probe (iobase, board_addr, irq, dma)
- *
- *    Returns non-negative on success.
- *
- */
-static int ircc_probe(int fir_base, int sir_base) 
-{
-	int low, high, chip, config, dma, irq;
-	int iobase = fir_base;
-	int version = 1;
-
-	IRDA_DEBUG(0, __FUNCTION__ "\n");
-
-	register_bank(iobase, 3);
-	high    = inb(iobase+IRCC_ID_HIGH);
-	low     = inb(iobase+IRCC_ID_LOW);
-	chip    = inb(iobase+IRCC_CHIP_ID);
-	version = inb(iobase+IRCC_VERSION);
-	config  = inb(iobase+IRCC_INTERFACE);
-	irq     = config >> 4 & 0x0f;
-	dma     = config & 0x0f;
-
-        if (high == 0x10 && low == 0xb8 && (chip == 0xf1 || chip == 0xf2)) { 
-                MESSAGE("SMC IrDA Controller found; IrCC version %d.%d, "
-			"port 0x%03x, dma=%d, irq=%d\n",
-			chip & 0x0f, version, iobase, dma, irq);
-	} else
-		return -ENODEV;
-
-	/* Power on device */
-	outb(0x00, iobase+IRCC_MASTER);
-
-	return config;
-}
-
-/*
  * Function ircc_change_speed (self, baud)
  *
  *    Change the speed of the device
@@ -1055,6 +1226,10 @@
 MODULE_PARM_DESC(ircc_dma, "DMA channel");
 MODULE_PARM(ircc_irq, "1i");
 MODULE_PARM_DESC(ircc_irq, "IRQ line");
+MODULE_PARM(ircc_fir, "1-4i");
+MODULE_PARM_DESC(ircc_fir, "FIR Base Adress");
+MODULE_PARM(ircc_sir, "1-4i");
+MODULE_PARM_DESC(ircc_sir, "SIR Base Adress");
 
 int init_module(void)
 {
diff -u --recursive --new-file linux-2.4.6-ac5/include/net/irda/smc-ircc.h.save linux-2.4.6-ac5/include/net/irda/smc-ircc.h
--- linux-2.4.6-ac5/include/net/irda/smc-ircc.h.save	Fri Jul 20 10:59:58 2001
+++ linux-2.4.6-ac5/include/net/irda/smc-ircc.h	Fri Jul 20 11:00:25 2001
@@ -154,16 +154,6 @@
 #define IRCC_1152                  0x80
 #define IRCC_CRC                   0x40
 
-struct smc_chip {
-	char *name;
-	unsigned char entr1;
-	unsigned char entr2;
-	unsigned char cid_index;
-	unsigned char cid_value;
-	int (*probe)(struct smc_chip *chip, chipio_t *info);
-};
-typedef struct smc_chip smc_chip_t;
-
 /* Private data for each instance */
 struct ircc_cb {
 	struct net_device *netdev;     /* Yes! we are some kind of netdevice */



--------------Boundary-00=_O8SRX0779KVVWVCAFQFM
Content-Type: text/plain;
  charset="us-ascii";
  name="smc-ircc-2.4-6-patch"
Content-Transfer-Encoding: base64
Content-Description: smc-ircc irda superio patch
Content-Disposition: attachment; filename="smc-ircc-2.4-6-patch"

ZGlmZiAtdSAtLXJlY3Vyc2l2ZSAtLW5ldy1maWxlIGxpbnV4LTIuNC42LWFjNS9kcml2ZXJzL25l
dC9pcmRhL3NtYy1pcmNjLmMuc2F2ZSBsaW51eC0yLjQuNi1hYzUvZHJpdmVycy9uZXQvaXJkYS9z
bWMtaXJjYy5jCi0tLSBsaW51eC0yLjQuNi1hYzUvZHJpdmVycy9uZXQvaXJkYS9zbWMtaXJjYy5j
LnNhdmUJRnJpIEp1bCAyMCAxMDozMjowNSAyMDAxCisrKyBsaW51eC0yLjQuNi1hYzUvZHJpdmVy
cy9uZXQvaXJkYS9zbWMtaXJjYy5jCUZyaSBKdWwgMjAgMTE6NTI6MjcgMjAwMQpAQCAtOCw3ICs4
LDEwIEBACiAgKiBDcmVhdGVkIGF0OiAgICAKICAqIE1vZGlmaWVkIGF0OiAgIFR1ZSBGZWIgMjIg
MTA6MDU6MDYgMjAwMAogICogTW9kaWZpZWQgYnk6ICAgRGFnIEJyYXR0bGkgPGRhZ0BicmF0dGxp
Lm5ldD4KKyAqIE1vZGlmaWVkIGF0OiAgIFR1ZSBKdW4gMjYgMjAwMQorICogTW9kaWZpZWQgYnk6
ICAgU3RlZmFuaSBTZWlib2xkIDxzdGVmYW5pQHNlaWJvbGQubmV0PgogICogCisgKiAgICAgQ29w
eXJpZ2h0IChjKSAyMDAxICAgICAgU3RlZmFuaSBTZWlib2xkCiAgKiAgICAgQ29weXJpZ2h0IChj
KSAxOTk5LTIwMDAgRGFnIEJyYXR0bGkKICAqICAgICBDb3B5cmlnaHQgKGMpIDE5OTgtMTk5OSBU
aG9tYXMgRGF2aXMsIAogICogICAgIEFsbCBSaWdodHMgUmVzZXJ2ZWQuCkBAIC0yOCw4ICszMSw5
IEBACiAgKiAgICAgRm91bmRhdGlvbiwgSW5jLiwgNTkgVGVtcGxlIFBsYWNlLCBTdWl0ZSAzMzAs
IEJvc3RvbiwgCiAgKiAgICAgTUEgMDIxMTEtMTMwNyBVU0EKICAqCi0gKiAgICAgU0lPJ3M6IFNN
QyBGREMzN044NjksIEZEQzM3QzY2OSwgRkRDMzdOOTU4Ci0gKiAgICAgQXBwbGljYWJsZSBNb2Rl
bHMgOiBGdWppdHN1IExpZmVib29rIDYzNXQsIFNvbnkgUENHLTUwNVRYCisgKiAgICAgU0lPJ3M6
IGFsbCBTSU8gZG9jdW1lbnRldCBieSBTTUMgKEp1bmUsIDIwMDEpCisgKiAgICAgQXBwbGljYWJs
ZSBNb2RlbHMgOglGdWppdHN1IExpZmVib29rIDYzNXQsIFNvbnkgUENHLTUwNVRYLAorICogICAg
IAkJCQlEZWxsIEluc3Bpcm9uIDgwMDAKICAqCiAgKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKiovCiAKQEAgLTYwLDIzICs2
NCwyNyBAQAogI2luY2x1ZGUgPG5ldC9pcmRhL3NtYy1pcmNjLmg+CiAjaW5jbHVkZSA8bmV0L2ly
ZGEvaXJwb3J0Lmg+CiAKK3N0cnVjdCBzbWNfY2hpcCB7CisJY2hhciAqbmFtZTsKKwl1MTYgZmxh
Z3M7CisJdTggZGV2aWQ7CisJdTggcmV2OworfTsKK3R5cGVkZWYgc3RydWN0IHNtY19jaGlwIHNt
Y19jaGlwX3Q7CisKIHN0YXRpYyBjaGFyICpkcml2ZXJfbmFtZSA9ICJzbWMtaXJjYyI7CiAKLSNk
ZWZpbmUgQ0hJUF9JT19FWFRFTlQgOAorI2RlZmluZQlESU0oeCkJKHNpemVvZih4KS8oc2l6ZW9m
KCooeCkpKSkKIAotc3RhdGljIHVuc2lnbmVkIGludCBpb1tdICA9IHsgfjAsIH4wIH07IAotc3Rh
dGljIHVuc2lnbmVkIGludCBpbzJbXSA9IHsgMCwgMCB9OworI2RlZmluZSBDSElQX0lPX0VYVEVO
VCA4CiAKIHN0YXRpYyBzdHJ1Y3QgaXJjY19jYiAqZGV2X3NlbGZbXSA9IHsgTlVMTCwgTlVMTH07
CiAKIC8qIFNvbWUgcHJvdG90eXBlcyAqLwotc3RhdGljIGludCAgaXJjY19vcGVuKGludCBpLCB1
bnNpZ25lZCBpbnQgaW9iYXNlLCB1bnNpZ25lZCBpbnQgYm9hcmRfYWRkcik7CitzdGF0aWMgaW50
ICBpcmNjX29wZW4odW5zaWduZWQgaW50IGlvYmFzZSwgdW5zaWduZWQgaW50IGJvYXJkX2FkZHIp
OwogI2lmZGVmIE1PRFVMRQogc3RhdGljIGludCAgaXJjY19jbG9zZShzdHJ1Y3QgaXJjY19jYiAq
c2VsZik7CiAjZW5kaWYgLyogTU9EVUxFICovCi1zdGF0aWMgaW50ICBpcmNjX3Byb2JlKGludCBp
b2Jhc2UsIGludCBib2FyZF9hZGRyKTsKLXN0YXRpYyBpbnQgIGlyY2NfcHJvYmVfNTgoc21jX2No
aXBfdCAqY2hpcCwgY2hpcGlvX3QgKmluZm8pOwotc3RhdGljIGludCAgaXJjY19wcm9iZV82OShz
bWNfY2hpcF90ICpjaGlwLCBjaGlwaW9fdCAqaW5mbyk7CiBzdGF0aWMgaW50ICBpcmNjX2RtYV9y
ZWNlaXZlKHN0cnVjdCBpcmNjX2NiICpzZWxmLCBpbnQgaW9iYXNlKTsgCiBzdGF0aWMgdm9pZCBp
cmNjX2RtYV9yZWNlaXZlX2NvbXBsZXRlKHN0cnVjdCBpcmNjX2NiICpzZWxmLCBpbnQgaW9iYXNl
KTsKIHN0YXRpYyBpbnQgIGlyY2NfaGFyZF94bWl0KHN0cnVjdCBza19idWZmICpza2IsIHN0cnVj
dCBuZXRfZGV2aWNlICpkZXYpOwpAQCAtOTEsMjAgKzk5LDczIEBACiBzdGF0aWMgaW50ICBpcmNj
X25ldF9jbG9zZShzdHJ1Y3QgbmV0X2RldmljZSAqZGV2KTsKIHN0YXRpYyBpbnQgIGlyY2NfcG1w
cm9jKHN0cnVjdCBwbV9kZXYgKmRldiwgcG1fcmVxdWVzdF90IHJxc3QsIHZvaWQgKmRhdGEpOwog
Ci0vKiBUaGVzZSBhcmUgdGhlIGN1cnJlbnRseSBrbm93biBTTUMgY2hpcHNldHMgKi8KLXN0YXRp
YyBzbWNfY2hpcF90IGNoaXBzW10gPQorI2RlZmluZQlLRVk1NV8xCTAJLy8gU3VwZXJJTyBDb25m
aWd1cmF0aW9uIG1vZGUgd2l0aCBLZXkgPDB4NTU+CisjZGVmaW5lCUtFWTU1XzIJMQkvLyBTdXBl
cklPIENvbmZpZ3VyYXRpb24gbW9kZSB3aXRoIEtleSA8MHg1NSwweDU1PgorI2RlZmluZQlOb0lS
REEJMgkvLyBTdXBlcklPIENoaXAgaGFzIG5vIElSREEgUG9ydAorI2RlZmluZQlTSVIJMAkvLyBT
dXBlcklPIENoaXAgaGFzIG9ubHkgc2xvdyBJUkRBCisjZGVmaW5lCUZJUgk0CS8vIFN1cGVySU8g
Q2hpcCBoYXMgZmFzdCBJUkRBCisjZGVmaW5lCVNFUng0CTgJLy8gU3VwZXJJTyBDaGlwIHN1cHBv
cnRzIDExNSwyIEtCYXVkICogND00NjAsOCBLQmF1ZAorCisvKiBUaGVzZSBhcmUgdGhlIGN1cnJl
bnRseSBrbm93biBTTUMgU3VwZXJJTyBjaGlwc2V0cyAqLworc3RhdGljIHNtY19jaGlwX3QgZmRj
X2NoaXBzX2ZsYXRbXT0KK3sKKwkvLyBCYXNlIGFkZHJlc3MgMHgzZjAgb3IgMHgzNzAKKwl7ICIz
N0M0NCIsCUtFWTU1XzF8Tm9JUkRBLAkJMHgwMCwgMHgwMCB9LCAvKiBUaGlzIGNoaXAgY2FuIG5v
dCBkZXRlY3RlZCAqLworCXsgIjM3QzY2NUdUIiwJS0VZNTVfMnxOb0lSREEsCQkweDY1LCAweDAx
IH0sCisJeyAiMzdDNjY1R1QiLAlLRVk1NV8yfE5vSVJEQSwJCTB4NjYsIDB4MDEgfSwKKwl7ICIz
N0M2NjkiLAlLRVk1NV8yfFNJUnxTRVJ4NCwJMHgwMywgMHgwMiB9LAorCXsgIjM3QzY2OSIsCUtF
WTU1XzJ8U0lSfFNFUng0LAkweDA0LCAweDAyIH0sIC8qIElEPyAqLworCXsgIjM3Qzc4IiwJS0VZ
NTVfMnxOb0lSREEsCQkweDc4LCAweDAwIH0sCisJeyAiMzdONzY5IiwJS0VZNTVfMXxGSVJ8U0VS
eDQsCTB4MjgsIDB4MDAgfSwKKwl7ICIzN044NjkiLAlLRVk1NV8xfEZJUnxTRVJ4NCwJMHgyOSwg
MHgwMCB9LAorCXsgTlVMTCB9Cit9OworCitzdGF0aWMgc21jX2NoaXBfdCBmZGNfY2hpcHNfcGFn
ZWRbXT0KK3sKKwl7ICIzN0I3MlgiLAlLRVk1NV8xfFNJUnxTRVJ4NCwJMHg0YywgMHgwMCB9LAor
CXsgIjM3Qjc3WCIsCUtFWTU1XzF8U0lSfFNFUng0LAkweDQzLCAweDAwIH0sCisJeyAiMzdCNzhY
IiwJS0VZNTVfMXxTSVJ8U0VSeDQsCTB4NDQsIDB4MDAgfSwKKwl7ICIzN0I4MFgiLAlLRVk1NV8x
fFNJUnxTRVJ4NCwJMHg0MiwgMHgwMCB9LAorCXsgIjM3QzY3WCIsCUtFWTU1XzF8RklSfFNFUng0
LAkweDQwLCAweDAwIH0sCisJeyAiMzdDOTNYIiwJS0VZNTVfMnxTSVJ8U0VSeDQsCTB4MDIsIDB4
MDEgfSwKKwl7ICIzN0M5M1hBUE0iLAlLRVk1NV8xfFNJUnxTRVJ4NCwJMHgzMCwgMHgwMSB9LAor
CXsgIjM3QzkzWEZSIiwJS0VZNTVfMnxGSVJ8U0VSeDQsCTB4MDMsIDB4MDEgfSwKKwl7ICIzN003
MDciLAlLRVk1NV8xfFNJUnxTRVJ4NCwJMHg0MiwgMHgwMCB9LAorCXsgIjM3TTgxWCIsCUtFWTU1
XzF8U0lSfFNFUng0LAkweDRkLCAweDAwIH0sCisJeyAiMzdOOTU4RlIiLAlLRVk1NV8xfEZJUnxT
RVJ4NCwJMHgwOSwgMHgwNCB9LAorCXsgIjM3Tjk3MiIsCUtFWTU1XzF8RklSfFNFUng0LAkweDBh
LCAweDAwIH0sCisJeyAiMzdOOTcyIiwJS0VZNTVfMXxGSVJ8U0VSeDQsCTB4MGIsIDB4MDAgfSwK
Kwl7IE5VTEwgfQorfTsKKworc3RhdGljIHNtY19jaGlwX3QgbHBjX2NoaXBzX2ZsYXRbXT0KIHsK
LQl7ICJGREMzN0M2NjkiLCAweDU1LCAweDU1LCAweDBkLCAweDA0LCBpcmNjX3Byb2JlXzY5IH0s
Ci0JeyAiRkRDMzdONzY5IiwgMHg1NSwgMHg1NSwgMHgwZCwgMHgyOCwgaXJjY19wcm9iZV82OSB9
LAotCXsgIkZEQzM3Tjg2OSIsIDB4NTUsIDB4MDAsIDB4MGQsIDB4MjksIGlyY2NfcHJvYmVfNjkg
fSwKLQl7ICJGREMzN045NTgiLCAweDU1LCAweDU1LCAweDIwLCAweDA5LCBpcmNjX3Byb2JlXzU4
IH0sCi0JeyAiRkRDMzdOOTcxIiwgMHg1NSwgMHg1NSwgMHgyMCwgMHgwYSwgaXJjY19wcm9iZV81
OCB9LAotCXsgIkZEQzM3Tjk3MiIsIDB4NTUsIDB4NTUsIDB4MjAsIDB4MGIsIGlyY2NfcHJvYmVf
NTggfSwKKwkvLyBCYXNlIGFkZHJlc3MgMHgyRSBvciAweDRFCisJeyAiNDdOMjI3IiwJS0VZNTVf
MXxGSVJ8U0VSeDQsCTB4NWEsIDB4MDAgfSwKKwl7ICI0N04yNjciLAlLRVk1NV8xfEZJUnxTRVJ4
NCwJMHg1ZSwgMHgwMCB9LAorCXsgTlVMTCB9Cit9OworCitzdGF0aWMgc21jX2NoaXBfdCBscGNf
Y2hpcHNfcGFnZWRbXT0KK3sKKwl7ICI0N0IyN1giLAlLRVk1NV8xfFNJUnxTRVJ4NCwJMHg1MSwg
MHgwMCB9LAorCXsgIjQ3QjM3WCIsCUtFWTU1XzF8U0lSfFNFUng0LAkweDUyLCAweDAwIH0sCisJ
eyAiNDdNMTBYIiwJS0VZNTVfMXxTSVJ8U0VSeDQsCTB4NTksIDB4MDAgfSwKKwl7ICI0N00xMjAi
LAlLRVk1NV8xfE5vSVJEQXxTRVJ4NCwJMHg1YywgMHgwMCB9LAorCXsgIjQ3TTEzWCIsCUtFWTU1
XzF8U0lSfFNFUng0LAkweDU5LCAweDAwIH0sCisJeyAiNDdNMTRYIiwJS0VZNTVfMXxTSVJ8U0VS
eDQsCTB4NWYsIDB4MDAgfSwKKwl7ICI0N04yNTIiLAlLRVk1NV8xfEZJUnxTRVJ4NCwJMHgwZSwg
MHgwMCB9LAorCXsgIjQ3UzQyWCIsCUtFWTU1XzF8U0lSfFNFUng0LAkweDU3LCAweDAwIH0sCiAJ
eyBOVUxMIH0KIH07CiAKIHN0YXRpYyBpbnQgaXJjY19pcnE9MjU1Owogc3RhdGljIGludCBpcmNj
X2RtYT0yNTU7CitzdGF0aWMgaW50IGlyY2NfZmlyPTA7CitzdGF0aWMgaW50IGlyY2Nfc2lyPTA7
CisKK3N0YXRpYyB1bnNpZ25lZCBzaG9ydAlkZXZfY291bnQ9MDsKIAogc3RhdGljIGlubGluZSB2
b2lkIHJlZ2lzdGVyX2JhbmsoaW50IGlvYmFzZSwgaW50IGJhbmspCiB7CkBAIC0xMTIsNiArMTcz
LDIwOSBAQAogICAgICAgICAgICAgICAgaW9iYXNlK0lSQ0NfTUFTVEVSKTsKIH0KIAorc3RhdGlj
IGludCBzbWNfYWNjZXNzKHVuc2lnbmVkIHNob3J0IGNmZ19iYXNlLHVuc2lnbmVkIGNoYXIgcmVn
KQoreworCUlSREFfREVCVUcoMCwgX19GVU5DVElPTl9fICIoKVxuIik7CisKKwlvdXRiKHJlZywg
Y2ZnX2Jhc2UpOworCisJaWYgKGluYihjZmdfYmFzZSkhPXJlZykKKwkJcmV0dXJuIC0xOworCisJ
cmV0dXJuIDA7Cit9CisKK3N0YXRpYyBzbWNfY2hpcF90ICogc21jX3Byb2JlKHVuc2lnbmVkIHNo
b3J0IGNmZ19iYXNlLHU4IHJlZyxzbWNfY2hpcF90ICpjaGlwLGNoYXIgKnR5cGUpCit7CisJdTgJ
ZGV2aWQseGRldmlkOyAKKwl1OAlyZXY7IAorCisJSVJEQV9ERUJVRygwLCBfX0ZVTkNUSU9OX18g
IigpXG4iKTsKKworCS8qIExlYXZlIGNvbmZpZ3VyYXRpb24gKi8KKworCW91dGIoMHhhYSwgY2Zn
X2Jhc2UpOworCisJaWYgKGluYihjZmdfYmFzZSk9PTB4YWEpCS8qIG5vdCBhIHNtYyBzdXBlcmlv
IGNoaXAgKi8KKwkJcmV0dXJuIE5VTEw7CisKKwlvdXRiKHJlZywgY2ZnX2Jhc2UpOworCisJeGRl
dmlkPWluYihjZmdfYmFzZSsxKTsKKworCS8qIEVudGVyIGNvbmZpZ3VyYXRpb24gKi8KKworCW91
dGIoMHg1NSwgY2ZnX2Jhc2UpOworCisJaWYgKHNtY19hY2Nlc3MoY2ZnX2Jhc2UsMHg1NSkpCS8q
IHNlbmQgc2Vjb25kIGtleSBhbmQgY2hlY2sgKi8KKwkJcmV0dXJuIE5VTEw7CisKKwkvKiBwcm9i
ZSBkZXZpY2UgSUQgKi8KKworCWlmIChzbWNfYWNjZXNzKGNmZ19iYXNlLHJlZykpCisJCXJldHVy
biBOVUxMOworCisJZGV2aWQ9aW5iKGNmZ19iYXNlKzEpOworCisJaWYgKGRldmlkPT0wKQkJCS8q
IHR5cGljYWwgdmFsdWUgZm9yIHVudXNlZCBwb3J0ICovCisJCXJldHVybiBOVUxMOworCisJaWYg
KGRldmlkPT0weGZmKQkJLyogdHlwaWNhbCB2YWx1ZSBmb3IgdW51c2VkIHBvcnQgKi8KKwkJcmV0
dXJuIE5VTEw7CisKKwkvKiBwcm9iZSByZXZpc2lvbiBJRCAqLworCisJaWYgKHNtY19hY2Nlc3Mo
Y2ZnX2Jhc2UscmVnKzEpKQorCQlyZXR1cm4gTlVMTDsKKworCXJldj1pbmIoY2ZnX2Jhc2UrMSk7
CisKKwlpZiAocmV2Pj0xMjgpCQkJLyogaSB0aGluayB0aGlzIHdpbGwgbWFrZSBubyBzZW5zZSAq
LworCQlyZXR1cm4gTlVMTDsKKworCWlmIChkZXZpZD09eGRldmlkKQkJLyogcHJvdGVjdGlvbiBh
Z2FpbnN0IGZhbHNlIHBvc2l0aXZlcyAqLyAgICAgICAgCisJCXJldHVybiBOVUxMOworCisJLyog
Q2hlY2sgZm9yIGV4cGVjdGVkIGRldmljZSBJRDsgYXJlIHRoZXJlIG90aGVycz8gKi8KKworCXdo
aWxlKGNoaXAtPmRldmlkIT1kZXZpZCkgeworCisJCWNoaXArKzsKKworCQlpZiAoY2hpcC0+bmFt
ZT09TlVMTCkKKwkJCXJldHVybiBOVUxMOworCX0KKwlpZiAoY2hpcC0+cmV2PnJldikKKwkJcmV0
dXJuIE5VTEw7CisKKwlNRVNTQUdFKCJmb3VuZCBTTUMgU3VwZXJJTyBDaGlwIChkZXZpZD0weCUw
MnggcmV2PSUwMlggYmFzZT0weCUwNHgpOiAlcyVzXG4iLGRldmlkLHJldixjZmdfYmFzZSx0eXBl
LGNoaXAtPm5hbWUpOworCQorCWlmIChjaGlwLT5mbGFncyZOb0lSREEpCisJCU1FU1NBR0UoImNo
aXBzZXQgZG9lcyBub3Qgc3VwcG9ydCBJUkRBXG4iKTsKKworCXJldHVybiBjaGlwOworfQorCisv
KgorICogRnVuY3Rpb24gc21jX3N1cGVyaW9fZmxhdCAoY2hpcCwgYmFzZSwgdHlwZSkKKyAqCisg
KiAgICBUcnkgZ2V0IGNvbmZpZ3VyYXRpb24gb2YgYSBzbWMgU3VwZXJJTyBjaGlwIHdpdGggZmxh
dCByZWdpc3RlciBtb2RlbAorICoKKyAqLworc3RhdGljIGludCBzbWNfc3VwZXJpb19mbGF0KHNt
Y19jaGlwX3QgKmNoaXBzLCB1bnNpZ25lZCBzaG9ydCBjZmdfYmFzZSwgY2hhciAqdHlwZSkKK3sK
Kwl1bnNpZ25lZCBzaG9ydCBmaXJfaW87CisJdW5zaWduZWQgc2hvcnQgc2lyX2lvOworCV9fdTgg
bW9kZTsKKwlpbnQgcmV0ID0gLUVOT0RFVjsKKworCUlSREFfREVCVUcoMCwgX19GVU5DVElPTl9f
ICIoKVxuIik7CisKKwlpZiAoc21jX3Byb2JlKGNmZ19iYXNlLDB4RCxjaGlwcyx0eXBlKT09TlVM
TCkKKwkJcmV0dXJuIHJldDsKKworCW91dGIoMHgwYywgY2ZnX2Jhc2UpOworCisJbW9kZSA9IGlu
YihjZmdfYmFzZSsxKTsKKwltb2RlID0gKG1vZGUgJiAweDM4KSA+PiAzOworCQkKKwkvKiBWYWx1
ZSBmb3IgSVIgcG9ydCAqLworCWlmIChtb2RlICYmIG1vZGUgPCA0KSB7CisJCS8qIFNJUiBpb2Jh
c2UgKi8KKwkJb3V0YigweDI1LCBjZmdfYmFzZSk7CisJCXNpcl9pbyA9IGluYihjZmdfYmFzZSsx
KSA8PCAyOworCisJICAgICAgIAkvKiBGSVIgaW9iYXNlICovCisJCW91dGIoMHgyYiwgY2ZnX2Jh
c2UpOworCQlmaXJfaW8gPSBpbmIoY2ZnX2Jhc2UrMSkgPDwgMzsKKworCQlpZiAoZmlyX2lvKSB7
CisJCQlpZiAoaXJjY19vcGVuKGZpcl9pbywgc2lyX2lvKSA9PSAwKQorCQkJCXJldD0wOyAKKwkJ
fQorCX0KKwkKKwkvKiBFeGl0IGNvbmZpZ3VyYXRpb24gKi8KKwlvdXRiKDB4YWEsIGNmZ19iYXNl
KTsKKworCXJldHVybiByZXQ7Cit9CisKKy8qCisgKiBGdW5jdGlvbiBzbWNfc3VwZXJpb19wYWdl
ZCAoY2hpcCwgYmFzZSwgdHlwZSkKKyAqCisgKiAgICBUcnkgIGdldCBjb25maWd1cmF0aW9uIG9m
IGEgc21jIFN1cGVySU8gY2hpcCB3aXRoIHBhZ2VkIHJlZ2lzdGVyIG1vZGVsCisgKgorICovCitz
dGF0aWMgaW50IHNtY19zdXBlcmlvX3BhZ2VkKHNtY19jaGlwX3QgKmNoaXBzLCB1bnNpZ25lZCBz
aG9ydCBjZmdfYmFzZSwgY2hhciAqdHlwZSkKK3sKKwl1bnNpZ25lZCBzaG9ydCBmaXJfaW87CisJ
dW5zaWduZWQgc2hvcnQgc2lyX2lvOworCWludCByZXQgPSAtRU5PREVWOworCQorCUlSREFfREVC
VUcoMCwgX19GVU5DVElPTl9fICIoKVxuIik7CisKKwlpZiAoc21jX3Byb2JlKGNmZ19iYXNlLDB4
MjAsY2hpcHMsdHlwZSk9PU5VTEwpCisJCXJldHVybiByZXQ7CisJCisJLyogU2VsZWN0IGxvZ2lj
YWwgZGV2aWNlIChVQVJUMikgKi8KKwlvdXRiKDB4MDcsIGNmZ19iYXNlKTsKKwlvdXRiKDB4MDUs
IGNmZ19iYXNlICsgMSk7CisJCQorCS8qIFNJUiBpb2Jhc2UgKi8KKwlvdXRiKDB4NjAsIGNmZ19i
YXNlKTsKKwlzaXJfaW8gID0gaW5iKGNmZ19iYXNlICsgMSkgPDwgODsKKwlvdXRiKDB4NjEsIGNm
Z19iYXNlKTsKKwlzaXJfaW8gfD0gaW5iKGNmZ19iYXNlICsgMSk7CisJCQorCS8qIFJlYWQgRklS
IGJhc2UgKi8KKwlvdXRiKDB4NjIsIGNmZ19iYXNlKTsKKwlmaXJfaW8gPSBpbmIoY2ZnX2Jhc2Ug
KyAxKSA8PCA4OworCW91dGIoMHg2MywgY2ZnX2Jhc2UpOworCWZpcl9pbyB8PSBpbmIoY2ZnX2Jh
c2UgKyAxKTsKKwlvdXRiKDB4MmIsIGNmZ19iYXNlKTsgLy8gPz8/CisKKwlpZiAoZmlyX2lvKSB7
CisJCWlmIChpcmNjX29wZW4oZmlyX2lvLCBzaXJfaW8pID09IDApCisJCQlyZXQ9MDsgCisJfQor
CQorCS8qIEV4aXQgY29uZmlndXJhdGlvbiAqLworCW91dGIoMHhhYSwgY2ZnX2Jhc2UpOworCisJ
cmV0dXJuIHJldDsKK30KKworc3RhdGljIGludCBzbWNfc3VwZXJpb19mZGModW5zaWduZWQgc2hv
cnQgY2ZnX2Jhc2UpCit7CisJaWYgKGNoZWNrX3JlZ2lvbihjZmdfYmFzZSwgMikgPCAwKSB7CisJ
CUlSREFfREVCVUcoMCwgX19GVU5DVElPTl9fICI6IGNhbid0IGdldCBjZmdfYmFzZSBvZiAweCUw
M3hcbiIsCisJCQkgICBjZmdfYmFzZSk7CisJCXJldHVybiAtMTsKKwl9CisKKwlpZiAoIXNtY19z
dXBlcmlvX2ZsYXQoZmRjX2NoaXBzX2ZsYXQsY2ZnX2Jhc2UsIkZEQyIpfHwhc21jX3N1cGVyaW9f
cGFnZWQoZmRjX2NoaXBzX3BhZ2VkLGNmZ19iYXNlLCJGREMiKSkKKwkJcmV0dXJuIDA7CisKKwly
ZXR1cm4gLTE7Cit9CisKK3N0YXRpYyBpbnQgc21jX3N1cGVyaW9fbHBjKHVuc2lnbmVkIHNob3J0
IGNmZ19iYXNlKQoreworI2lmIDAKKwlpZiAoY2hlY2tfcmVnaW9uKGNmZ19iYXNlLCAyKSA8IDAp
IHsKKwkJSVJEQV9ERUJVRygwLCBfX0ZVTkNUSU9OX18gIjogY2FuJ3QgZ2V0IGNmZ19iYXNlIG9m
IDB4JTAzeFxuIiwKKwkJCSAgIGNmZ19iYXNlKTsKKwkJcmV0dXJuIC0xOworCX0KKyNlbmRpZgor
CisJaWYgKCFzbWNfc3VwZXJpb19mbGF0KGxwY19jaGlwc19mbGF0LGNmZ19iYXNlLCJMUEMiKXx8
IXNtY19zdXBlcmlvX3BhZ2VkKGxwY19jaGlwc19wYWdlZCxjZmdfYmFzZSwiTFBDIikpCisJCXJl
dHVybiAwOworCisJcmV0dXJuIC0xOworfQorCiAvKgogICogRnVuY3Rpb24gaXJjY19pbml0ICgp
CiAgKgpAQCAtMTIwLDM3ICszODQsMzYgQEAKICAqLwogaW50IF9faW5pdCBpcmNjX2luaXQodm9p
ZCkKIHsKLQlzdGF0aWMgaW50IHNtY3JlZ1tdID0geyAweDNmMCwgMHgzNzAgfTsKLQlzbWNfY2hp
cF90ICpjaGlwOwotCWNoaXBpb190IGluZm87Ci0JaW50IHJldCA9IC1FTk9ERVY7Ci0JaW50IGk7
CisJaW50IHJldD0tRU5PREVWOwogCiAJSVJEQV9ERUJVRygwLCBfX0ZVTkNUSU9OX18gIlxuIik7
CiAKLQkvKiBQcm9iZSBmb3IgYWxsIHRoZSBOU0MgY2hpcHNldHMgd2Uga25vdyBhYm91dCAqLwot
CWZvciAoY2hpcD1jaGlwczsgY2hpcC0+bmFtZSA7IGNoaXArKykgewotCQlmb3IgKGk9MDsgaTwy
OyBpKyspIHsKLQkJCWluZm8uY2ZnX2Jhc2UgPSBzbWNyZWdbaV07Ci0JCQkKLQkJCS8qIAotCQkJ
ICogRmlyc3Qgd2UgY2hlY2sgaWYgdGhlIHVzZXIgaGFzIHN1cHBsaWVkIGFueQotICAgICAgICAg
ICAgICAgICAgICAgICAgICogcGFyYW1ldGVycyB3aGljaCB3ZSBzaG91bGQgdXNlIGluc3RlYWQg
b2YgcHJvYmVkCi0JCQkgKiB2YWx1ZXMKLQkJCSAqLwotCQkJaWYgKGlvW2ldIDwgMHgyMDAwKSB7
Ci0JCQkJaW5mby5maXJfYmFzZSA9IGlvW2ldOwotCQkJCWluZm8uc2lyX2Jhc2UgPSBpbzJbaV07
Ci0JCQl9IGVsc2UgaWYgKGNoaXAtPnByb2JlKGNoaXAsICZpbmZvKSA8IDApCi0JCQkJY29udGlu
dWU7Ci0JCQlpZiAoY2hlY2tfcmVnaW9uKGluZm8uZmlyX2Jhc2UsIENISVBfSU9fRVhURU5UKSA8
IDApCi0JCQkJY29udGludWU7Ci0JCQlpZiAoY2hlY2tfcmVnaW9uKGluZm8uc2lyX2Jhc2UsIENI
SVBfSU9fRVhURU5UKSA8IDApCi0JCQkJY29udGludWU7Ci0JCQlpZiAoaXJjY19vcGVuKGksIGlu
Zm8uZmlyX2Jhc2UsIGluZm8uc2lyX2Jhc2UpID09IDApCi0JCQkJcmV0ID0gMDsgCi0JCX0KKwlk
ZXZfY291bnQ9MDsKKworCWlmICgoaXJjY19maXI+MCkmJihpcmNjX3Npcj4wKSkgeworCSAgICAg
ICAgTUVTU0FHRSgiIE92ZXJyaWRpbmcgRklSIGFkZHJlc3MgMHglMDR4XG4iLCBpcmNjX2Zpcik7
CisJCU1FU1NBR0UoIiBPdmVycmlkaW5nIFNJUiBhZGRyZXNzIDB4JTA0eFxuIiwgaXJjY19zaXIp
OworCisJCWlmIChpcmNjX29wZW4oaXJjY19maXIsIGlyY2Nfc2lyKSA9PSAwKQorCQkJcmV0dXJu
IDA7CisKKwkJcmV0dXJuIC1FTk9ERVY7CiAJfQorCisJLyogVHJ5cyB0byBvcGVuIGZvciBhbGwg
dGhlIFNNQyBjaGlwc2V0cyB3ZSBrbm93IGFib3V0ICovCisKKwlJUkRBX0RFQlVHKDAsIF9fRlVO
Q1RJT05fXyAKKwkiIFRyeSB0byBvcGVuIGFsbCBrbm93biBTTUMgY2hpcHNldHNcbiIpOworCisJ
aWYgKCFzbWNfc3VwZXJpb19mZGMoMHgzZjApKQorCQlyZXQ9MDsKKwlpZiAoIXNtY19zdXBlcmlv
X2ZkYygweDM3MCkpCisJCXJldD0wOworCWlmICghc21jX3N1cGVyaW9fbHBjKDB4MmUpKQorCQly
ZXQ9MDsKKwlpZiAoIXNtY19zdXBlcmlvX2xwYygweDRlKSkKKwkJcmV0PTA7CisKIAlyZXR1cm4g
cmV0OwogfQogCkBAIC0xNzcsMjQgKzQ0MCw1NyBAQAogLyoKICAqIEZ1bmN0aW9uIGlyY2Nfb3Bl
biAoaW9iYXNlLCBpcnEpCiAgKgotICogICAgT3BlbiBkcml2ZXIgaW5zdGFuY2UKKyAqICAgIFRy
eSB0byBvcGVuIGRyaXZlciBpbnN0YW5jZQogICoKICAqLwotc3RhdGljIGludCBpcmNjX29wZW4o
aW50IGksIHVuc2lnbmVkIGludCBmaXJfYmFzZSwgdW5zaWduZWQgaW50IHNpcl9iYXNlKQorc3Rh
dGljIGludCBpcmNjX29wZW4odW5zaWduZWQgaW50IGZpcl9iYXNlLCB1bnNpZ25lZCBpbnQgc2ly
X2Jhc2UpCiB7CiAJc3RydWN0IGlyY2NfY2IgKnNlbGY7CiAgICAgICAgIHN0cnVjdCBpcnBvcnRf
Y2IgKmlycG9ydDsKLQlpbnQgY29uZmlnOwotCWludCByZXQ7CisJdW5zaWduZWQgY2hhciBsb3cs
IGhpZ2gsIGNoaXAsIGNvbmZpZywgZG1hLCBpcnEsIHZlcnNpb247CisKIAogCUlSREFfREVCVUco
MCwgX19GVU5DVElPTl9fICJcbiIpOwogCi0JaWYgKChjb25maWcgPSBpcmNjX3Byb2JlKGZpcl9i
YXNlLCBzaXJfYmFzZSkpID09IC0xKSB7CisJaWYgKGNoZWNrX3JlZ2lvbihmaXJfYmFzZSwgQ0hJ
UF9JT19FWFRFTlQpIDwgMCkgeworCQlJUkRBX0RFQlVHKDAsIF9fRlVOQ1RJT05fXyAiOiBjYW4n
dCBnZXQgZmlyX2Jhc2Ugb2YgMHglMDN4XG4iLAorCQkJICAgZmlyX2Jhc2UpOworCQlyZXR1cm4g
LUVOT0RFVjsKKwl9CisjaWYgUE9TU0lCTEVfVVNFRF9CWV9TRVJJQUxfRFJJVkVSCisJaWYgKGNo
ZWNrX3JlZ2lvbihzaXJfYmFzZSwgQ0hJUF9JT19FWFRFTlQpIDwgMCkgeworCQlJUkRBX0RFQlVH
KDAsIF9fRlVOQ1RJT05fXyAiOiBjYW4ndCBnZXQgc2lyX2Jhc2Ugb2YgMHglMDN4XG4iLAorCQkJ
ICAgc2lyX2Jhc2UpOworCQlyZXR1cm4gLUVOT0RFVjsKKwl9CisjZW5kaWYKKworCXJlZ2lzdGVy
X2JhbmsoZmlyX2Jhc2UsIDMpOworCisJaGlnaCAgICA9IGluYihmaXJfYmFzZStJUkNDX0lEX0hJ
R0gpOworCWxvdyAgICAgPSBpbmIoZmlyX2Jhc2UrSVJDQ19JRF9MT1cpOworCWNoaXAgICAgPSBp
bmIoZmlyX2Jhc2UrSVJDQ19DSElQX0lEKTsKKwl2ZXJzaW9uID0gaW5iKGZpcl9iYXNlK0lSQ0Nf
VkVSU0lPTik7CisJY29uZmlnICA9IGluYihmaXJfYmFzZStJUkNDX0lOVEVSRkFDRSk7CisKKwlp
cnEgICAgID0gY29uZmlnID4+IDQgJiAweDBmOworCWRtYSAgICAgPSBjb25maWcgJiAweDBmOwor
CisgICAgICAgIGlmIChoaWdoICE9IDB4MTAgfHwgbG93ICE9IDB4YjggfHwgKGNoaXAgIT0gMHhm
MSAmJiBjaGlwICE9IDB4ZjIpKSB7IAogCSAgICAgICAgSVJEQV9ERUJVRygwLCBfX0ZVTkNUSU9O
X18gCiAJCQkgICAiKCksIGFkZHIgMHglMDR4IC0gbm8gZGV2aWNlIGZvdW5kIVxuIiwgZmlyX2Jh
c2UpOwotCQlyZXR1cm4gLTE7CisJCXJldHVybiAtRU5PREVWOwogCX0KLQkKKwlNRVNTQUdFKCJT
TUMgSXJEQSBDb250cm9sbGVyIGZvdW5kXG4gSXJDQyB2ZXJzaW9uICVkLiVkLCAiCisJCSJmaXJw
b3J0IDB4JTAzeCwgc2lycG9ydCAweCUwM3ggZG1hPSVkLCBpcnE9JWRcbiIsCisJCWNoaXAgJiAw
eDBmLCB2ZXJzaW9uLCBmaXJfYmFzZSwgc2lyX2Jhc2UsIGRtYSwgaXJxKTsKKworCWlmIChkZXZf
Y291bnQ+RElNKGRldl9zZWxmKSkgeworCSAgICAgICAgSVJEQV9ERUJVRygwLCBfX0ZVTkNUSU9O
X18gCisJCQkgICAiKCksIHRvIG1hbnkgZGV2aWNlcyFcbiIpOworCQlyZXR1cm4gLUVOT01FTTsK
Kwl9CisKIAkvKgogCSAqICBBbGxvY2F0ZSBuZXcgaW5zdGFuY2Ugb2YgdGhlIGRyaXZlcgogCSAq
LwpAQCAtMjA2LDQ2ICs1MDIsNzQgQEAKIAl9CiAJbWVtc2V0KHNlbGYsIDAsIHNpemVvZihzdHJ1
Y3QgaXJjY19jYikpOwogCXNwaW5fbG9ja19pbml0KCZzZWxmLT5sb2NrKTsKLSAgIAotCS8qIE5l
ZWQgdG8gc3RvcmUgc2VsZiBzb21ld2hlcmUgKi8KLQlkZXZfc2VsZltpXSA9IHNlbGY7CiAKLQlp
cnBvcnQgPSBpcnBvcnRfb3BlbihpLCBzaXJfYmFzZSwgY29uZmlnID4+IDQgJiAweDBmKTsKLQlp
ZiAoIWlycG9ydCkKKwkvKiBNYXggRE1BIGJ1ZmZlciBzaXplIG5lZWRlZCA9IChkYXRhX3NpemUg
KyA2KSAqICh3aW5kb3dfc2l6ZSkgKyA2OyAqLworCXNlbGYtPnJ4X2J1ZmYudHJ1ZXNpemUgPSA0
MDAwOyAKKwlzZWxmLT50eF9idWZmLnRydWVzaXplID0gNDAwMDsKKworCXNlbGYtPnJ4X2J1ZmYu
aGVhZCA9IChfX3U4ICopIGttYWxsb2Moc2VsZi0+cnhfYnVmZi50cnVlc2l6ZSwKKwkJCQkJICAg
ICAgR0ZQX0tFUk5FTHxHRlBfRE1BKTsKKwlpZiAoc2VsZi0+cnhfYnVmZi5oZWFkID09IE5VTEwp
IHsKKwkJRVJST1IoIiVzLCBDYW4ndCBhbGxvY2F0ZSBtZW1vcnkgZm9yIHJlY2VpdmUgYnVmZmVy
IVxuIiwKKyAgICAgICAgICAgICAgICAgICAgICBkcml2ZXJfbmFtZSk7CisJCWtmcmVlKHNlbGYp
OworCQlyZXR1cm4gLUVOT01FTTsKKwl9CisKKwlzZWxmLT50eF9idWZmLmhlYWQgPSAoX191OCAq
KSBrbWFsbG9jKHNlbGYtPnR4X2J1ZmYudHJ1ZXNpemUsIAorCQkJCQkgICAgICBHRlBfS0VSTkVM
fEdGUF9ETUEpOworCWlmIChzZWxmLT50eF9idWZmLmhlYWQgPT0gTlVMTCkgeworCQlFUlJPUigi
JXMsIENhbid0IGFsbG9jYXRlIG1lbW9yeSBmb3IgdHJhbnNtaXQgYnVmZmVyIVxuIiwKKyAgICAg
ICAgICAgICAgICAgICAgICBkcml2ZXJfbmFtZSk7CisJCWtmcmVlKHNlbGYtPnJ4X2J1ZmYuaGVh
ZCk7CisJCWtmcmVlKHNlbGYpOworCQlyZXR1cm4gLUVOT01FTTsKKwl9CisKKwlpcnBvcnQgPSBp
cnBvcnRfb3BlbihkZXZfY291bnQsIHNpcl9iYXNlLCBpcnEpOworCWlmICghaXJwb3J0KSB7CisJ
CWtmcmVlKHNlbGYtPnR4X2J1ZmYuaGVhZCk7CisJCWtmcmVlKHNlbGYtPnJ4X2J1ZmYuaGVhZCk7
CisJCWtmcmVlKHNlbGYpOwogCQlyZXR1cm4gLUVOT0RFVjsKKwl9CisKKwltZW1zZXQoc2VsZi0+
cnhfYnVmZi5oZWFkLCAwLCBzZWxmLT5yeF9idWZmLnRydWVzaXplKTsKKwltZW1zZXQoc2VsZi0+
dHhfYnVmZi5oZWFkLCAwLCBzZWxmLT50eF9idWZmLnRydWVzaXplKTsKKyAgIAorCS8qIE5lZWQg
dG8gc3RvcmUgc2VsZiBzb21ld2hlcmUgKi8KKwlkZXZfc2VsZltkZXZfY291bnQrK10gPSBzZWxm
OwogCiAJLyogU3RlYWwgdGhlIG5ldHdvcmsgZGV2aWNlIGZyb20gaXJwb3J0ICovCiAJc2VsZi0+
bmV0ZGV2ID0gaXJwb3J0LT5uZXRkZXY7CiAJc2VsZi0+aXJwb3J0ID0gaXJwb3J0OworCiAJaXJw
b3J0LT5wcml2ID0gc2VsZjsKIAogCS8qIEluaXRpYWxpemUgSU8gKi8KIAlzZWxmLT5pby5maXJf
YmFzZSAgPSBmaXJfYmFzZTsKICAgICAgICAgc2VsZi0+aW8uc2lyX2Jhc2UgID0gc2lyX2Jhc2U7
IC8qIFVzZWQgYnkgaXJwb3J0ICovCi0gICAgICAgIHNlbGYtPmlvLmlycSAgICAgICA9IGNvbmZp
ZyA+PiA0ICYgMHgwZjsKKyAgICAgICAgc2VsZi0+aW8uZmlyX2V4dCAgID0gQ0hJUF9JT19FWFRF
TlQ7CisgICAgICAgIHNlbGYtPmlvLnNpcl9leHQgICA9IDg7ICAgICAgIC8qIFVzZWQgYnkgaXJw
b3J0ICovCisKIAlpZiAoaXJjY19pcnEgPCAyNTUpIHsKLQkgICAgICAgIE1FU1NBR0UoIiVzLCBP
dmVycmlkaW5nIElSUSAtIGNoaXAgc2F5cyAlZCwgdXNpbmcgJWRcbiIsCi0JCQlkcml2ZXJfbmFt
ZSwgc2VsZi0+aW8uaXJxLCBpcmNjX2lycSk7CisJCWlmIChpcmNjX2lycSE9aXJxKQorCQkJTUVT
U0FHRSgiJXMsIE92ZXJyaWRpbmcgSVJRIC0gY2hpcCBzYXlzICVkLCB1c2luZyAlZFxuIiwKKwkJ
CQlkcml2ZXJfbmFtZSwgc2VsZi0+aW8uaXJxLCBpcmNjX2lycSk7CiAJCXNlbGYtPmlvLmlycSA9
IGlyY2NfaXJxOwogCX0KLSAgICAgICAgc2VsZi0+aW8uZmlyX2V4dCAgID0gQ0hJUF9JT19FWFRF
TlQ7Ci0gICAgICAgIHNlbGYtPmlvLnNpcl9leHQgICA9IDg7ICAgICAgIC8qIFVzZWQgYnkgaXJw
b3J0ICovCi0gICAgICAgIHNlbGYtPmlvLmRtYSAgICAgICA9IGNvbmZpZyAmIDB4MGY7CisJZWxz
ZQorCQlzZWxmLT5pby5pcnEgPSBpcnE7CiAJaWYgKGlyY2NfZG1hIDwgMjU1KSB7Ci0JICAgICAg
ICBNRVNTQUdFKCIlcywgT3ZlcnJpZGluZyBETUEgLSBjaGlwIHNheXMgJWQsIHVzaW5nICVkXG4i
LAotCQkJZHJpdmVyX25hbWUsIHNlbGYtPmlvLmRtYSwgaXJjY19kbWEpOworCQlpZiAoaXJjY19k
bWEhPWRtYSkKKwkJCU1FU1NBR0UoIiVzLCBPdmVycmlkaW5nIERNQSAtIGNoaXAgc2F5cyAlZCwg
dXNpbmcgJWRcbiIsCisJCQkJZHJpdmVyX25hbWUsIHNlbGYtPmlvLmRtYSwgaXJjY19kbWEpOwog
CQlzZWxmLT5pby5kbWEgPSBpcmNjX2RtYTsKIAl9CisJZWxzZQorCQlzZWxmLT5pby5kbWEgPSBk
bWE7CiAKLQkvKiBMb2NrIHRoZSBwb3J0IHRoYXQgd2UgbmVlZCAqLwotCXJldCA9IGNoZWNrX3Jl
Z2lvbihzZWxmLT5pby5maXJfYmFzZSwgc2VsZi0+aW8uZmlyX2V4dCk7Ci0JaWYgKHJldCA8IDAp
IHsgCi0JCUlSREFfREVCVUcoMCwgX19GVU5DVElPTl9fICI6IGNhbid0IGdldCBmaXJfYmFzZSBv
ZiAweCUwM3hcbiIsCi0JCQkgICBzZWxmLT5pby5maXJfYmFzZSk7Ci0gICAgICAgICAgICAgICAg
a2ZyZWUoc2VsZik7Ci0JCXJldHVybiAtRU5PREVWOwotCX0KLQlyZXF1ZXN0X3JlZ2lvbihzZWxm
LT5pby5maXJfYmFzZSwgc2VsZi0+aW8uZmlyX2V4dCwgZHJpdmVyX25hbWUpOworCXJlcXVlc3Rf
cmVnaW9uKGZpcl9iYXNlLCBDSElQX0lPX0VYVEVOVCwgZHJpdmVyX25hbWUpOwogCiAJLyogSW5p
dGlhbGl6ZSBRb1MgZm9yIHRoaXMgZGV2aWNlICovCiAJaXJkYV9pbml0X21heF9xb3NfY2FwYWJp
bGllcygmaXJwb3J0LT5xb3MpOwpAQCAtMjYwLDIzICs1ODQsNiBAQAogCiAJaXJwb3J0LT5mbGFn
cyA9IElGRl9GSVJ8SUZGX01JUnxJRkZfU0lSfElGRl9ETUF8SUZGX1BJTzsKIAkKLQkvKiBNYXgg
RE1BIGJ1ZmZlciBzaXplIG5lZWRlZCA9IChkYXRhX3NpemUgKyA2KSAqICh3aW5kb3dfc2l6ZSkg
KyA2OyAqLwotCXNlbGYtPnJ4X2J1ZmYudHJ1ZXNpemUgPSA0MDAwOyAKLQlzZWxmLT50eF9idWZm
LnRydWVzaXplID0gNDAwMDsKLQotCXNlbGYtPnJ4X2J1ZmYuaGVhZCA9IChfX3U4ICopIGttYWxs
b2Moc2VsZi0+cnhfYnVmZi50cnVlc2l6ZSwKLQkJCQkJICAgICAgR0ZQX0tFUk5FTHxHRlBfRE1B
KTsKLQlpZiAoc2VsZi0+cnhfYnVmZi5oZWFkID09IE5VTEwpCi0JCXJldHVybiAtRU5PTUVNOwot
CW1lbXNldChzZWxmLT5yeF9idWZmLmhlYWQsIDAsIHNlbGYtPnJ4X2J1ZmYudHJ1ZXNpemUpOwot
CQotCXNlbGYtPnR4X2J1ZmYuaGVhZCA9IChfX3U4ICopIGttYWxsb2Moc2VsZi0+dHhfYnVmZi50
cnVlc2l6ZSwgCi0JCQkJCSAgICAgIEdGUF9LRVJORUx8R0ZQX0RNQSk7Ci0JaWYgKHNlbGYtPnR4
X2J1ZmYuaGVhZCA9PSBOVUxMKSB7Ci0JCWtmcmVlKHNlbGYtPnJ4X2J1ZmYuaGVhZCk7Ci0JCXJl
dHVybiAtRU5PTUVNOwotCX0KLQltZW1zZXQoc2VsZi0+dHhfYnVmZi5oZWFkLCAwLCBzZWxmLT50
eF9idWZmLnRydWVzaXplKTsKIAogCXNlbGYtPnJ4X2J1ZmYuaW5fZnJhbWUgPSBGQUxTRTsKIAlz
ZWxmLT5yeF9idWZmLnN0YXRlID0gT1VUU0lERV9GUkFNRTsKQEAgLTI5NSw2ICs2MDIsMTAgQEAK
ICAgICAgICAgaWYgKHNlbGYtPnBtZGV2KQogICAgICAgICAgICAgICAgIHNlbGYtPnBtZGV2LT5k
YXRhID0gc2VsZjsKIAorCS8qIFBvd2VyIG9uIGRldmljZSAqLworCisJb3V0YigweDAwLCBmaXJf
YmFzZStJUkNDX01BU1RFUik7CisKIAlyZXR1cm4gMDsKIH0KIApAQCAtMzQ3LDE0NiArNjU4LDYg
QEAKICNlbmRpZiAvKiBNT0RVTEUgKi8KIAogLyoKLSAqIEZ1bmN0aW9uIGlyY2NfcHJvYmVfNjkg
KGNoaXAsIGluZm8pCi0gKgotICogICAgUHJvYmVzIGZvciB0aGUgU01DIEZEQzM3QzY2OSBhbmQg
RkRDMzdOODY5Ci0gKgotICovCi1zdGF0aWMgaW50IGlyY2NfcHJvYmVfNjkoc21jX2NoaXBfdCAq
Y2hpcCwgY2hpcGlvX3QgKmluZm8pCi17Ci0JaW50IGNmZ19iYXNlID0gaW5mby0+Y2ZnX2Jhc2U7
Ci0JX191OCBkZXZpZCwgbW9kZTsKLQlpbnQgcmV0ID0gLUVOT0RFVjsKLQlpbnQgZmlyX2lvOwot
CQotCUlSREFfREVCVUcoMCwgX19GVU5DVElPTl9fICIoKVxuIik7Ci0KLQkvKiBFbnRlciBjb25m
aWd1cmF0aW9uICovCi0Jb3V0YihjaGlwLT5lbnRyMSwgY2ZnX2Jhc2UpOwotCW91dGIoY2hpcC0+
ZW50cjIsIGNmZ19iYXNlKTsKLQkKLQlvdXRiKGNoaXAtPmNpZF9pbmRleCwgY2ZnX2Jhc2UpOwot
CWRldmlkID0gaW5iKGNmZ19iYXNlKzEpOwotCUlSREFfREVCVUcoMCwgX19GVU5DVElPTl9fICIo
KSwgZGV2aWQ9MHglMDJ4XG4iLGRldmlkKTsKLQkKLQkvKiBDaGVjayBmb3IgZXhwZWN0ZWQgZGV2
aWNlIElEOyBhcmUgdGhlcmUgb3RoZXJzPyAqLwotCWlmIChkZXZpZCA9PSBjaGlwLT5jaWRfdmFs
dWUpIHsKLQkJb3V0YigweDBjLCBjZmdfYmFzZSk7Ci0JCW1vZGUgPSBpbmIoY2ZnX2Jhc2UrMSk7
Ci0JCW1vZGUgPSAobW9kZSAmIDB4MzgpID4+IDM7Ci0JCQotCQkvKiBWYWx1ZSBmb3IgSVIgcG9y
dCAqLwotCQlpZiAobW9kZSAmJiBtb2RlIDwgNCkgewotCQkJLyogU0lSIGlvYmFzZSAqLwotCQkJ
b3V0YigweDI1LCBjZmdfYmFzZSk7Ci0JCQlpbmZvLT5zaXJfYmFzZSA9IGluYihjZmdfYmFzZSsx
KSA8PCAyOwotCi0JCSAgICAgICAJLyogRklSIGlvYmFzZSAqLwotCQkJb3V0YigweDJiLCBjZmdf
YmFzZSk7Ci0JCQlmaXJfaW8gPSBpbmIoY2ZnX2Jhc2UrMSkgPDwgMzsKLQkJCWlmIChmaXJfaW8p
IHsKLQkJCQlyZXQgPSAwOwotCQkJCWluZm8tPmZpcl9iYXNlID0gZmlyX2lvOwotCQkJfQotCQl9
Ci0JfQotCQotCS8qIEV4aXQgY29uZmlndXJhdGlvbiAqLwotCW91dGIoMHhhYSwgY2ZnX2Jhc2Up
OwotCi0JcmV0dXJuIHJldDsKLX0KLQotLyoKLSAqIEZ1bmN0aW9uIGlyY2NfcHJvYmVfNTggKGNo
aXAsIGluZm8pCi0gKgotICogICAgUHJvYmVzIGZvciB0aGUgU01DIEZEQzM3Tjk1OAotICoKLSAq
Lwotc3RhdGljIGludCBpcmNjX3Byb2JlXzU4KHNtY19jaGlwX3QgKmNoaXAsIGNoaXBpb190ICpp
bmZvKQotewotCWludCBjZmdfYmFzZSA9IGluZm8tPmNmZ19iYXNlOwotCV9fdTggZGV2aWQ7Ci0J
aW50IHJldCA9IC1FTk9ERVY7Ci0JaW50IGZpcl9pbzsKLQkKLQlJUkRBX0RFQlVHKDAsIF9fRlVO
Q1RJT05fXyAiKClcbiIpOwotCi0JLyogRW50ZXIgY29uZmlndXJhdGlvbiAqLwotCW91dGIoY2hp
cC0+ZW50cjEsIGNmZ19iYXNlKTsKLQlvdXRiKGNoaXAtPmVudHIyLCBjZmdfYmFzZSk7Ci0JCi0J
b3V0YihjaGlwLT5jaWRfaW5kZXgsIGNmZ19iYXNlKTsKLQlkZXZpZCA9IGluYihjZmdfYmFzZSsx
KTsKLQlJUkRBX0RFQlVHKDAsIF9fRlVOQ1RJT05fXyAiKCksIGRldmlkPTB4JTAyeFxuIixkZXZp
ZCk7Ci0JCi0JLyogQ2hlY2sgZm9yIGV4cGVjdGVkIGRldmljZSBJRDsgYXJlIHRoZXJlIG90aGVy
cz8gKi8KLQlpZiAoZGV2aWQgPT0gY2hpcC0+Y2lkX3ZhbHVlKSB7Ci0JCS8qIFNlbGVjdCBsb2dp
Y2FsIGRldmljZSAoVUFSVDIpICovCi0JCW91dGIoMHgwNywgY2ZnX2Jhc2UpOwotCQlvdXRiKDB4
MDUsIGNmZ19iYXNlICsgMSk7Ci0JCQotCQkvKiBTSVIgaW9iYXNlICovCi0JCW91dGIoMHg2MCwg
Y2ZnX2Jhc2UpOwotCQlpbmZvLT5zaXJfYmFzZSA9IGluYihjZmdfYmFzZSArIDEpIDw8IDg7Ci0J
CW91dGIoMHg2MSwgY2ZnX2Jhc2UpOwotCQlpbmZvLT5zaXJfYmFzZSB8PSBpbmIoY2ZnX2Jhc2Ug
KyAxKTsKLQkJCi0JCS8qIFJlYWQgRklSIGJhc2UgKi8KLQkJb3V0YigweDYyLCBjZmdfYmFzZSk7
Ci0JCWZpcl9pbyA9IGluYihjZmdfYmFzZSArIDEpIDw8IDg7Ci0JCW91dGIoMHg2MywgY2ZnX2Jh
c2UpOwotCQlmaXJfaW8gfD0gaW5iKGNmZ19iYXNlICsgMSk7Ci0JCW91dGIoMHgyYiwgY2ZnX2Jh
c2UpOwotCQlpZiAoZmlyX2lvKSB7Ci0JCQlyZXQgPSAwOwotCQkJaW5mby0+ZmlyX2Jhc2UgPSBm
aXJfaW87Ci0JCX0KLQl9Ci0JCi0JLyogRXhpdCBjb25maWd1cmF0aW9uICovCi0Jb3V0YigweGFh
LCBjZmdfYmFzZSk7Ci0KLQlyZXR1cm4gcmV0OwotfQotCi0vKgotICogRnVuY3Rpb24gaXJjY19w
cm9iZSAoaW9iYXNlLCBib2FyZF9hZGRyLCBpcnEsIGRtYSkKLSAqCi0gKiAgICBSZXR1cm5zIG5v
bi1uZWdhdGl2ZSBvbiBzdWNjZXNzLgotICoKLSAqLwotc3RhdGljIGludCBpcmNjX3Byb2JlKGlu
dCBmaXJfYmFzZSwgaW50IHNpcl9iYXNlKSAKLXsKLQlpbnQgbG93LCBoaWdoLCBjaGlwLCBjb25m
aWcsIGRtYSwgaXJxOwotCWludCBpb2Jhc2UgPSBmaXJfYmFzZTsKLQlpbnQgdmVyc2lvbiA9IDE7
Ci0KLQlJUkRBX0RFQlVHKDAsIF9fRlVOQ1RJT05fXyAiXG4iKTsKLQotCXJlZ2lzdGVyX2Jhbmso
aW9iYXNlLCAzKTsKLQloaWdoICAgID0gaW5iKGlvYmFzZStJUkNDX0lEX0hJR0gpOwotCWxvdyAg
ICAgPSBpbmIoaW9iYXNlK0lSQ0NfSURfTE9XKTsKLQljaGlwICAgID0gaW5iKGlvYmFzZStJUkND
X0NISVBfSUQpOwotCXZlcnNpb24gPSBpbmIoaW9iYXNlK0lSQ0NfVkVSU0lPTik7Ci0JY29uZmln
ICA9IGluYihpb2Jhc2UrSVJDQ19JTlRFUkZBQ0UpOwotCWlycSAgICAgPSBjb25maWcgPj4gNCAm
IDB4MGY7Ci0JZG1hICAgICA9IGNvbmZpZyAmIDB4MGY7Ci0KLSAgICAgICAgaWYgKGhpZ2ggPT0g
MHgxMCAmJiBsb3cgPT0gMHhiOCAmJiAoY2hpcCA9PSAweGYxIHx8IGNoaXAgPT0gMHhmMikpIHsg
Ci0gICAgICAgICAgICAgICAgTUVTU0FHRSgiU01DIElyREEgQ29udHJvbGxlciBmb3VuZDsgSXJD
QyB2ZXJzaW9uICVkLiVkLCAiCi0JCQkicG9ydCAweCUwM3gsIGRtYT0lZCwgaXJxPSVkXG4iLAot
CQkJY2hpcCAmIDB4MGYsIHZlcnNpb24sIGlvYmFzZSwgZG1hLCBpcnEpOwotCX0gZWxzZQotCQly
ZXR1cm4gLUVOT0RFVjsKLQotCS8qIFBvd2VyIG9uIGRldmljZSAqLwotCW91dGIoMHgwMCwgaW9i
YXNlK0lSQ0NfTUFTVEVSKTsKLQotCXJldHVybiBjb25maWc7Ci19Ci0KLS8qCiAgKiBGdW5jdGlv
biBpcmNjX2NoYW5nZV9zcGVlZCAoc2VsZiwgYmF1ZCkKICAqCiAgKiAgICBDaGFuZ2UgdGhlIHNw
ZWVkIG9mIHRoZSBkZXZpY2UKQEAgLTEwNTUsNiArMTIyNiwxMCBAQAogTU9EVUxFX1BBUk1fREVT
QyhpcmNjX2RtYSwgIkRNQSBjaGFubmVsIik7CiBNT0RVTEVfUEFSTShpcmNjX2lycSwgIjFpIik7
CiBNT0RVTEVfUEFSTV9ERVNDKGlyY2NfaXJxLCAiSVJRIGxpbmUiKTsKK01PRFVMRV9QQVJNKGly
Y2NfZmlyLCAiMS00aSIpOworTU9EVUxFX1BBUk1fREVTQyhpcmNjX2ZpciwgIkZJUiBCYXNlIEFk
cmVzcyIpOworTU9EVUxFX1BBUk0oaXJjY19zaXIsICIxLTRpIik7CitNT0RVTEVfUEFSTV9ERVND
KGlyY2Nfc2lyLCAiU0lSIEJhc2UgQWRyZXNzIik7CiAKIGludCBpbml0X21vZHVsZSh2b2lkKQog
ewpkaWZmIC11IC0tcmVjdXJzaXZlIC0tbmV3LWZpbGUgbGludXgtMi40LjYtYWM1L2luY2x1ZGUv
bmV0L2lyZGEvc21jLWlyY2MuaC5zYXZlIGxpbnV4LTIuNC42LWFjNS9pbmNsdWRlL25ldC9pcmRh
L3NtYy1pcmNjLmgKLS0tIGxpbnV4LTIuNC42LWFjNS9pbmNsdWRlL25ldC9pcmRhL3NtYy1pcmNj
Lmguc2F2ZQlGcmkgSnVsIDIwIDEwOjU5OjU4IDIwMDEKKysrIGxpbnV4LTIuNC42LWFjNS9pbmNs
dWRlL25ldC9pcmRhL3NtYy1pcmNjLmgJRnJpIEp1bCAyMCAxMTowMDoyNSAyMDAxCkBAIC0xNTQs
MTYgKzE1NCw2IEBACiAjZGVmaW5lIElSQ0NfMTE1MiAgICAgICAgICAgICAgICAgIDB4ODAKICNk
ZWZpbmUgSVJDQ19DUkMgICAgICAgICAgICAgICAgICAgMHg0MAogCi1zdHJ1Y3Qgc21jX2NoaXAg
ewotCWNoYXIgKm5hbWU7Ci0JdW5zaWduZWQgY2hhciBlbnRyMTsKLQl1bnNpZ25lZCBjaGFyIGVu
dHIyOwotCXVuc2lnbmVkIGNoYXIgY2lkX2luZGV4OwotCXVuc2lnbmVkIGNoYXIgY2lkX3ZhbHVl
OwotCWludCAoKnByb2JlKShzdHJ1Y3Qgc21jX2NoaXAgKmNoaXAsIGNoaXBpb190ICppbmZvKTsK
LX07Ci10eXBlZGVmIHN0cnVjdCBzbWNfY2hpcCBzbWNfY2hpcF90OwotCiAvKiBQcml2YXRlIGRh
dGEgZm9yIGVhY2ggaW5zdGFuY2UgKi8KIHN0cnVjdCBpcmNjX2NiIHsKIAlzdHJ1Y3QgbmV0X2Rl
dmljZSAqbmV0ZGV2OyAgICAgLyogWWVzISB3ZSBhcmUgc29tZSBraW5kIG9mIG5ldGRldmljZSAq
Lwo=

--------------Boundary-00=_O8SRX0779KVVWVCAFQFM--
