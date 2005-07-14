Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263103AbVGNTbV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263103AbVGNTbV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Jul 2005 15:31:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263016AbVGNT3O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Jul 2005 15:29:14 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:11021 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S263103AbVGNT2D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Jul 2005 15:28:03 -0400
Date: Thu, 14 Jul 2005 20:27:53 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Linux Kernel List <linux-kernel@vger.kernel.org>,
       Linux Serial List <linux-serial@vger.kernel.org>
Subject: Re: [CFT:PATCH] Serial + Serial&Parallel PCI card cleanup
Message-ID: <20050714202752.D10410@flint.arm.linux.org.uk>
Mail-Followup-To: Linux Kernel List <linux-kernel@vger.kernel.org>,
	Linux Serial List <linux-serial@vger.kernel.org>
References: <20050625162100.A21120@flint.arm.linux.org.uk> <20050704081500.GA24025@pazke> <20050704095702.A26015@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="fdj2RfSjLxBAspz7"
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20050704095702.A26015@flint.arm.linux.org.uk>; from rmk+lkml@arm.linux.org.uk on Mon, Jul 04, 2005 at 09:57:02AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--fdj2RfSjLxBAspz7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jul 04, 2005 at 09:57:02AM +0100, Russell King wrote:
> On Mon, Jul 04, 2005 at 12:15:00PM +0400, Andrey Panin wrote:
> > Me too, but I can confirm that my SIIG single port serial card still works
> > with the patch, so at least SIIG quirk table cleanup didn't broke anything.
> 
> Thanks for testing.
> 
> > IMHO this cleanup could became a separate easy to merge patch.
> 
> I think the only split which would be reasonable is to make the changes
> to 8250_pci separate from parport_serial.  Trying to split the changes
> to parport_serial would be a recipe for disaster.

You can find the patches attached.  The end result should be the
same as the original patch (it applies in reverse).

If folk are happy with this, I'll see about queueing it up.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core

--fdj2RfSjLxBAspz7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="14-8250_pci-rename-pci_board.diff"

Rename pci_board to pciserial_board.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

diff --git a/drivers/serial/8250_pci.c b/drivers/serial/8250_pci.c
--- a/drivers/serial/8250_pci.c
+++ b/drivers/serial/8250_pci.c
@@ -54,7 +54,7 @@
 /* Use the Base address register size to cap number of ports */
 #define FL_REGION_SZ_CAP	0x0100
 
-struct pci_board {
+struct pciserial_board {
 	unsigned int flags;
 	unsigned int num_ports;
 	unsigned int base_baud;
@@ -75,7 +75,7 @@ struct pci_serial_quirk {
 	u32	subvendor;
 	u32	subdevice;
 	int	(*init)(struct pci_dev *dev);
-	int	(*setup)(struct pci_dev *dev, struct pci_board *board,
+	int	(*setup)(struct pci_dev *dev, struct pciserial_board *,
 			 struct uart_port *port, int idx);
 	void	(*exit)(struct pci_dev *dev);
 };
@@ -136,7 +136,7 @@ setup_port(struct pci_dev *dev, struct u
  * Not that ugly ;) -- HW
  */
 static int
-afavlab_setup(struct pci_dev *dev, struct pci_board *board,
+afavlab_setup(struct pci_dev *dev, struct pciserial_board *board,
 	      struct uart_port *port, int idx)
 {
 	unsigned int bar, offset = board->first_offset;
@@ -189,7 +189,7 @@ static int __devinit pci_hp_diva_init(st
  * some serial ports are supposed to be hidden on certain models.
  */
 static int
-pci_hp_diva_setup(struct pci_dev *dev, struct pci_board *board,
+pci_hp_diva_setup(struct pci_dev *dev, struct pciserial_board *board,
 	      struct uart_port *port, int idx)
 {
 	unsigned int offset = board->first_offset;
@@ -307,7 +307,7 @@ static void __devexit pci_plx9050_exit(s
 
 /* SBS Technologies Inc. PMC-OCTPRO and P-OCTAL cards */
 static int
-sbs_setup(struct pci_dev *dev, struct pci_board *board,
+sbs_setup(struct pci_dev *dev, struct pciserial_board *board,
 		struct uart_port *port, int idx)
 {
 	unsigned int bar, offset = board->first_offset;
@@ -520,7 +520,7 @@ static int __devinit pci_timedia_init(st
  * Ugh, this is ugly as all hell --- TYT
  */
 static int
-pci_timedia_setup(struct pci_dev *dev, struct pci_board *board,
+pci_timedia_setup(struct pci_dev *dev, struct pciserial_board *board,
 		  struct uart_port *port, int idx)
 {
 	unsigned int bar = 0, offset = board->first_offset;
@@ -553,7 +553,8 @@ pci_timedia_setup(struct pci_dev *dev, s
  * Some Titan cards are also a little weird
  */
 static int
-titan_400l_800l_setup(struct pci_dev *dev, struct pci_board *board,
+titan_400l_800l_setup(struct pci_dev *dev,
+		      struct pciserial_board *board,
 		      struct uart_port *port, int idx)
 {
 	unsigned int bar, offset = board->first_offset;
@@ -590,7 +591,7 @@ static int __devinit pci_netmos_init(str
 }
 
 static int
-pci_default_setup(struct pci_dev *dev, struct pci_board *board,
+pci_default_setup(struct pci_dev *dev, struct pciserial_board *board,
 		  struct uart_port *port, int idx)
 {
 	unsigned int bar, offset = board->first_offset, maxnr;
@@ -987,7 +988,7 @@ static struct pci_serial_quirk *find_qui
 }
 
 static _INLINE_ int
-get_pci_irq(struct pci_dev *dev, struct pci_board *board, int idx)
+get_pci_irq(struct pci_dev *dev, struct pciserial_board *board, int idx)
 {
 	if (board->flags & FL_NOIRQ)
 		return 0;
@@ -1108,7 +1109,7 @@ enum pci_board_num_t {
  * see first lines of serial_in() and serial_out() in 8250.c
 */
 
-static struct pci_board pci_boards[] __devinitdata = {
+static struct pciserial_board pci_boards[] __devinitdata = {
 	[pbn_default] = {
 		.flags		= FL_BASE0,
 		.num_ports	= 1,
@@ -1554,7 +1555,7 @@ static struct pci_board pci_boards[] __d
  * serial specs.  Returns 0 on success, 1 on failure.
  */
 static int __devinit
-serial_pci_guess_board(struct pci_dev *dev, struct pci_board *board)
+serial_pci_guess_board(struct pci_dev *dev, struct pciserial_board *board)
 {
 	int num_iomem, num_port, first_port = -1, i;
 	
@@ -1619,7 +1620,8 @@ serial_pci_guess_board(struct pci_dev *d
 }
 
 static inline int
-serial_pci_matches(struct pci_board *board, struct pci_board *guessed)
+serial_pci_matches(struct pciserial_board *board,
+		   struct pciserial_board *guessed)
 {
 	return
 	    board->num_ports == guessed->num_ports &&
@@ -1637,7 +1639,7 @@ static int __devinit
 pciserial_init_one(struct pci_dev *dev, const struct pci_device_id *ent)
 {
 	struct serial_private *priv;
-	struct pci_board *board, tmp;
+	struct pciserial_board *board, tmp;
 	struct pci_serial_quirk *quirk;
 	int rc, nr_ports, i;
 
@@ -1658,7 +1660,7 @@ pciserial_init_one(struct pci_dev *dev, 
 		 * Use a copy of the pci_board entry for this;
 		 * avoid changing entries in the table.
 		 */
-		memcpy(&tmp, board, sizeof(struct pci_board));
+		memcpy(&tmp, board, sizeof(struct pciserial_board));
 		board = &tmp;
 
 		/*
@@ -1674,7 +1676,8 @@ pciserial_init_one(struct pci_dev *dev, 
 		 * detect this boards settings with our heuristic,
 		 * then we no longer need this entry.
 		 */
-		memcpy(&tmp, &pci_boards[pbn_default], sizeof(struct pci_board));
+		memcpy(&tmp, &pci_boards[pbn_default],
+		       sizeof(struct pciserial_board));
 		rc = serial_pci_guess_board(dev, &tmp);
 		if (rc == 0 && serial_pci_matches(board, &tmp))
 			moan_device("Redundant entry in serial pci_table.",

--fdj2RfSjLxBAspz7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="15-8250_pci-factor-common.diff"

Factour out the common setup from the per-serial port loop.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

diff -u b/drivers/serial/8250_pci.c b/drivers/serial/8250_pci.c
--- b/drivers/serial/8250_pci.c
+++ b/drivers/serial/8250_pci.c
@@ -110,8 +110,9 @@
 	if (bar >= PCI_NUM_BAR_RESOURCES)
 		return -EINVAL;
 
+	base = pci_resource_start(dev, bar);
+
 	if (pci_resource_flags(dev, bar) & IORESOURCE_MEM) {
-		base = pci_resource_start(dev, bar);
 		len =  pci_resource_len(dev, bar);
 
 		if (!priv->remapped_bar[bar])
@@ -120,13 +121,16 @@
 			return -ENOMEM;
 
 		port->iotype = UPIO_MEM;
+		port->iobase = 0;
 		port->mapbase = base + offset;
 		port->membase = priv->remapped_bar[bar] + offset;
 		port->regshift = regshift;
 	} else {
-		base = pci_resource_start(dev, bar) + offset;
 		port->iotype = UPIO_PORT;
-		port->iobase = base;
+		port->iobase = base + offset;
+		port->mapbase = 0;
+		port->membase = NULL;
+		port->regshift = 0;
 	}
 	return 0;
 }
@@ -988,7 +992,7 @@
 }
 
 static _INLINE_ int
-get_pci_irq(struct pci_dev *dev, struct pciserial_board *board, int idx)
+get_pci_irq(struct pci_dev *dev, struct pciserial_board *board)
 {
 	if (board->flags & FL_NOIRQ)
 		return 0;
@@ -1638,6 +1642,7 @@
 static int __devinit
 pciserial_init_one(struct pci_dev *dev, const struct pci_device_id *ent)
 {
+	struct uart_port serial_port;
 	struct serial_private *priv;
 	struct pciserial_board *board, tmp;
 	struct pci_serial_quirk *quirk;
@@ -1720,17 +1725,16 @@
 	priv->quirk = quirk;
 	pci_set_drvdata(dev, priv);
 
-	for (i = 0; i < nr_ports; i++) {
-		struct uart_port serial_port;
-		memset(&serial_port, 0, sizeof(struct uart_port));
+	memset(&serial_port, 0, sizeof(struct uart_port));
+	serial_port.flags = UPF_SKIP_TEST | UPF_BOOT_AUTOCONF | UPF_SHARE_IRQ;
+	serial_port.uartclk = board->base_baud * 16;
+	serial_port.irq = get_pci_irq(dev, board);
+	serial_port.dev = &dev->dev;
 
-		serial_port.flags = UPF_SKIP_TEST | UPF_BOOT_AUTOCONF |
-				    UPF_SHARE_IRQ;
-		serial_port.uartclk = board->base_baud * 16;
-		serial_port.irq = get_pci_irq(dev, board, i);
-		serial_port.dev = &dev->dev;
+	for (i = 0; i < nr_ports; i++) {
 		if (quirk->setup(dev, board, &serial_port, i))
 			break;
+
 #ifdef SERIAL_DEBUG_PCI
 		printk("Setup PCI port: port %x, irq %d, type %d\n",
 		       serial_port.iobase, serial_port.irq, serial_port.iotype);

--fdj2RfSjLxBAspz7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="16-8250_pci-remove-genericsiig.diff"

Collapse all the SIIG quirk entries into one.  SIIG10x cards all have
PCI device IDs of 0x10xx, SIIG20x cards all have PCI device IDs of
0x20xx.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

diff -u b/drivers/serial/8250_pci.c b/drivers/serial/8250_pci.c
--- b/drivers/serial/8250_pci.c
+++ b/drivers/serial/8250_pci.c
@@ -393,6 +393,9 @@
  *     - 10x cards have control registers in IO and/or memory space;
  *     - 20x cards have control registers in standard PCI configuration space.
  *
+ * Note: all 10x cards have PCI device ids 0x10..
+ *       all 20x cards have PCI device ids 0x20..
+ *
  * Note: some SIIG cards are probed by the parport_serial object.
  */
 
@@ -446,6 +449,19 @@
 	return 0;
 }
 
+static int pci_siig_init(struct pci_dev *dev)
+{
+	unsigned int type = dev->device & 0xff00;
+
+	if (type == 0x1000)
+		return pci_siig10x_init(dev);
+	else if (type == 0x2000)
+		return pci_siig20x_init(dev);
+
+	moan_device("Unknown SIIG card", dev);
+	return -ENODEV;
+}
+
 int pci_siig10x_fn(struct pci_dev *dev, int enable)
 {
 	int ret = 0;
@@ -756,152 +772,15 @@
 		.setup		= sbs_setup,
 		.exit		= __devexit_p(sbs_exit),
 	},
-
 	/*
 	 * SIIG cards.
-	 *  It is not clear whether these could be collapsed.
 	 */
 	{
 		.vendor		= PCI_VENDOR_ID_SIIG,
-		.device		= PCI_DEVICE_ID_SIIG_1S_10x_550,
-		.subvendor	= PCI_ANY_ID,
-		.subdevice	= PCI_ANY_ID,
-		.init		= pci_siig10x_init,
-		.setup		= pci_default_setup,
-	},
-	{
-		.vendor		= PCI_VENDOR_ID_SIIG,
-		.device		= PCI_DEVICE_ID_SIIG_1S_10x_650,
-		.subvendor	= PCI_ANY_ID,
-		.subdevice	= PCI_ANY_ID,
-		.init		= pci_siig10x_init,
-		.setup		= pci_default_setup,
-	},
-	{
-		.vendor		= PCI_VENDOR_ID_SIIG,
-		.device		= PCI_DEVICE_ID_SIIG_1S_10x_850,
-		.subvendor	= PCI_ANY_ID,
-		.subdevice	= PCI_ANY_ID,
-		.init		= pci_siig10x_init,
-		.setup		= pci_default_setup,
-	},
-	{
-		.vendor		= PCI_VENDOR_ID_SIIG,
-		.device		= PCI_DEVICE_ID_SIIG_2S_10x_550,
-		.subvendor	= PCI_ANY_ID,
-		.subdevice	= PCI_ANY_ID,
-		.init		= pci_siig10x_init,
-		.setup		= pci_default_setup,
-	},
-	{
-		.vendor		= PCI_VENDOR_ID_SIIG,
-		.device		= PCI_DEVICE_ID_SIIG_2S_10x_650,
-		.subvendor	= PCI_ANY_ID,
-		.subdevice	= PCI_ANY_ID,
-		.init		= pci_siig10x_init,
-		.setup		= pci_default_setup,
-	},
-	{
-		.vendor		= PCI_VENDOR_ID_SIIG,
-		.device		= PCI_DEVICE_ID_SIIG_2S_10x_850,
-		.subvendor	= PCI_ANY_ID,
-		.subdevice	= PCI_ANY_ID,
-		.init		= pci_siig10x_init,
-		.setup		= pci_default_setup,
-	},
-	{
-		.vendor		= PCI_VENDOR_ID_SIIG,
-		.device		= PCI_DEVICE_ID_SIIG_4S_10x_550,
-		.subvendor	= PCI_ANY_ID,
-		.subdevice	= PCI_ANY_ID,
-		.init		= pci_siig10x_init,
-		.setup		= pci_default_setup,
-	},
-	{
-		.vendor		= PCI_VENDOR_ID_SIIG,
-		.device		= PCI_DEVICE_ID_SIIG_4S_10x_650,
-		.subvendor	= PCI_ANY_ID,
-		.subdevice	= PCI_ANY_ID,
-		.init		= pci_siig10x_init,
-		.setup		= pci_default_setup,
-	},
-	{
-		.vendor		= PCI_VENDOR_ID_SIIG,
-		.device		= PCI_DEVICE_ID_SIIG_4S_10x_850,
-		.subvendor	= PCI_ANY_ID,
-		.subdevice	= PCI_ANY_ID,
-		.init		= pci_siig10x_init,
-		.setup		= pci_default_setup,
-	},
-	{
-		.vendor		= PCI_VENDOR_ID_SIIG,
-		.device		= PCI_DEVICE_ID_SIIG_1S_20x_550,
-		.subvendor	= PCI_ANY_ID,
-		.subdevice	= PCI_ANY_ID,
-		.init		= pci_siig20x_init,
-		.setup		= pci_default_setup,
-	},
-	{
-		.vendor		= PCI_VENDOR_ID_SIIG,
-		.device		= PCI_DEVICE_ID_SIIG_1S_20x_650,
-		.subvendor	= PCI_ANY_ID,
-		.subdevice	= PCI_ANY_ID,
-		.init		= pci_siig20x_init,
-		.setup		= pci_default_setup,
-	},
-	{
-		.vendor		= PCI_VENDOR_ID_SIIG,
-		.device		= PCI_DEVICE_ID_SIIG_1S_20x_850,
-		.subvendor	= PCI_ANY_ID,
-		.subdevice	= PCI_ANY_ID,
-		.init		= pci_siig20x_init,
-		.setup		= pci_default_setup,
-	},
-	{
-		.vendor		= PCI_VENDOR_ID_SIIG,
-		.device		= PCI_DEVICE_ID_SIIG_2S_20x_550,
-		.subvendor	= PCI_ANY_ID,
-		.subdevice	= PCI_ANY_ID,
-		.init		= pci_siig20x_init,
-		.setup		= pci_default_setup,
-	},
-	{	.vendor		= PCI_VENDOR_ID_SIIG,
-		.device		= PCI_DEVICE_ID_SIIG_2S_20x_650,
-		.subvendor	= PCI_ANY_ID,
-		.subdevice	= PCI_ANY_ID,
-		.init		= pci_siig20x_init,
-		.setup		= pci_default_setup,
-	},
-	{
-		.vendor		= PCI_VENDOR_ID_SIIG,
-		.device		= PCI_DEVICE_ID_SIIG_2S_20x_850,
-		.subvendor	= PCI_ANY_ID,
-		.subdevice	= PCI_ANY_ID,
-		.init		= pci_siig20x_init,
-		.setup		= pci_default_setup,
-	},
-	{
-		.vendor		= PCI_VENDOR_ID_SIIG,
-		.device		= PCI_DEVICE_ID_SIIG_4S_20x_550,
-		.subvendor	= PCI_ANY_ID,
-		.subdevice	= PCI_ANY_ID,
-		.init		= pci_siig20x_init,
-		.setup		= pci_default_setup,
-	},
-	{
-		.vendor		= PCI_VENDOR_ID_SIIG,
-		.device		= PCI_DEVICE_ID_SIIG_4S_20x_650,
-		.subvendor	= PCI_ANY_ID,
-		.subdevice	= PCI_ANY_ID,
-		.init		= pci_siig20x_init,
-		.setup		= pci_default_setup,
-	},
-	{
-		.vendor		= PCI_VENDOR_ID_SIIG,
-		.device		= PCI_DEVICE_ID_SIIG_4S_20x_850,
+		.device		= PCI_ANY_ID,
 		.subvendor	= PCI_ANY_ID,
 		.subdevice	= PCI_ANY_ID,
-		.init		= pci_siig20x_init,
+		.init		= pci_siig_init,
 		.setup		= pci_default_setup,
 	},
 	/*

--fdj2RfSjLxBAspz7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="17-8250_pci-serial_private.diff"

Pass the serial_private structure via the setup method instead of
the pci_dev.  We don't want to assume that the pci_dev's driver
data is a pointer to serial_private.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

diff -u b/drivers/serial/8250_pci.c b/drivers/serial/8250_pci.c
--- b/drivers/serial/8250_pci.c
+++ b/drivers/serial/8250_pci.c
@@ -63,6 +63,8 @@
 	unsigned int first_offset;
 };
 
+struct serial_private;
+
 /*
  * init function returns:
  *  > 0 - number of ports
@@ -75,7 +77,7 @@
 	u32	subvendor;
 	u32	subdevice;
 	int	(*init)(struct pci_dev *dev);
-	int	(*setup)(struct pci_dev *dev, struct pciserial_board *,
+	int	(*setup)(struct serial_private *, struct pciserial_board *,
 			 struct uart_port *port, int idx);
 	void	(*exit)(struct pci_dev *dev);
 };
@@ -83,6 +85,7 @@
 #define PCI_NUM_BAR_RESOURCES	6
 
 struct serial_private {
+	struct pci_dev		*dev;
 	unsigned int		nr;
 	void __iomem		*remapped_bar[PCI_NUM_BAR_RESOURCES];
 	struct pci_serial_quirk	*quirk;
@@ -101,10 +104,10 @@
 }
 
 static int
-setup_port(struct pci_dev *dev, struct uart_port *port,
+setup_port(struct serial_private *priv, struct uart_port *port,
 	   int bar, int offset, int regshift)
 {
-	struct serial_private *priv = pci_get_drvdata(dev);
+	struct pci_dev *dev = priv->dev;
 	unsigned long base, len;
 
 	if (bar >= PCI_NUM_BAR_RESOURCES)
@@ -140,7 +143,7 @@
  * Not that ugly ;) -- HW
  */
 static int
-afavlab_setup(struct pci_dev *dev, struct pciserial_board *board,
+afavlab_setup(struct serial_private *priv, struct pciserial_board *board,
 	      struct uart_port *port, int idx)
 {
 	unsigned int bar, offset = board->first_offset;
@@ -153,7 +156,7 @@
 		offset += (idx - 4) * board->uart_offset;
 	}
 
-	return setup_port(dev, port, bar, offset, board->reg_shift);
+	return setup_port(priv, port, bar, offset, board->reg_shift);
 }
 
 /*
@@ -193,13 +196,13 @@
  * some serial ports are supposed to be hidden on certain models.
  */
 static int
-pci_hp_diva_setup(struct pci_dev *dev, struct pciserial_board *board,
+pci_hp_diva_setup(struct serial_private *priv, struct pciserial_board *board,
 	      struct uart_port *port, int idx)
 {
 	unsigned int offset = board->first_offset;
 	unsigned int bar = FL_GET_BASE(board->flags);
 
-	switch (dev->subsystem_device) {
+	switch (priv->dev->subsystem_device) {
 	case PCI_DEVICE_ID_HP_DIVA_MAESTRO:
 		if (idx == 3)
 			idx++;
@@ -216,7 +219,7 @@
 
 	offset += idx * board->uart_offset;
 
-	return setup_port(dev, port, bar, offset, board->reg_shift);
+	return setup_port(priv, port, bar, offset, board->reg_shift);
 }
 
 /*
@@ -311,7 +314,7 @@
 
 /* SBS Technologies Inc. PMC-OCTPRO and P-OCTAL cards */
 static int
-sbs_setup(struct pci_dev *dev, struct pciserial_board *board,
+sbs_setup(struct serial_private *priv, struct pciserial_board *board,
 		struct uart_port *port, int idx)
 {
 	unsigned int bar, offset = board->first_offset;
@@ -327,7 +330,7 @@
 	} else /* we have only 8 ports on PMC-OCTALPRO */
 		return 1;
 
-	return setup_port(dev, port, bar, offset, board->reg_shift);
+	return setup_port(priv, port, bar, offset, board->reg_shift);
 }
 
 /*
@@ -540,7 +543,7 @@
  * Ugh, this is ugly as all hell --- TYT
  */
 static int
-pci_timedia_setup(struct pci_dev *dev, struct pciserial_board *board,
+pci_timedia_setup(struct serial_private *priv, struct pciserial_board *board,
 		  struct uart_port *port, int idx)
 {
 	unsigned int bar = 0, offset = board->first_offset;
@@ -566,14 +569,14 @@
 		bar = idx - 2;
 	}
 
-	return setup_port(dev, port, bar, offset, board->reg_shift);
+	return setup_port(priv, port, bar, offset, board->reg_shift);
 }
 
 /*
  * Some Titan cards are also a little weird
  */
 static int
-titan_400l_800l_setup(struct pci_dev *dev,
+titan_400l_800l_setup(struct serial_private *priv,
 		      struct pciserial_board *board,
 		      struct uart_port *port, int idx)
 {
@@ -591,7 +594,7 @@
 		offset = (idx - 2) * board->uart_offset;
 	}
 
-	return setup_port(dev, port, bar, offset, board->reg_shift);
+	return setup_port(priv, port, bar, offset, board->reg_shift);
 }
 
 static int __devinit pci_xircom_init(struct pci_dev *dev)
@@ -611,7 +614,7 @@
 }
 
 static int
-pci_default_setup(struct pci_dev *dev, struct pciserial_board *board,
+pci_default_setup(struct serial_private *priv, struct pciserial_board *board,
 		  struct uart_port *port, int idx)
 {
 	unsigned int bar, offset = board->first_offset, maxnr;
@@ -622,13 +625,13 @@
 	else
 		offset += idx * board->uart_offset;
 
-	maxnr = (pci_resource_len(dev, bar) - board->first_offset) /
+	maxnr = (pci_resource_len(priv->dev, bar) - board->first_offset) /
 		(8 << board->reg_shift);
 
 	if (board->flags & FL_REGION_SZ_CAP && idx >= maxnr)
 		return 1;
 			
-	return setup_port(dev, port, bar, offset, board->reg_shift);
+	return setup_port(priv, port, bar, offset, board->reg_shift);
 }
 
 /* This should be in linux/pci_ids.h */
@@ -1601,6 +1604,7 @@
 	memset(priv, 0, sizeof(struct serial_private) +
 			sizeof(unsigned int) * nr_ports);
 
+	priv->dev = dev;
 	priv->quirk = quirk;
 	pci_set_drvdata(dev, priv);
 
@@ -1611,7 +1615,7 @@
 	serial_port.dev = &dev->dev;
 
 	for (i = 0; i < nr_ports; i++) {
-		if (quirk->setup(dev, board, &serial_port, i))
+		if (quirk->setup(priv, board, &serial_port, i))
 			break;
 
 #ifdef SERIAL_DEBUG_PCI

--fdj2RfSjLxBAspz7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="18-8250_pci-split-serial.diff"

Re-jig the setup/removal/suspend/resume of 8250 pci ports so that they
know slightly less about how they're attached to a PCI device.  Expose
this as the new interface for registering serial ports, as well as the
pciserial_board structure and associated flag definitions.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

diff -u b/drivers/serial/8250_pci.c b/drivers/serial/8250_pci.c
--- b/drivers/serial/8250_pci.c
+++ b/drivers/serial/8250_pci.c
@@ -34,38 +34,6 @@
 #undef SERIAL_DEBUG_PCI
 
 /*
- * Definitions for PCI support.
- */
-#define FL_BASE_MASK		0x0007
-#define FL_BASE0		0x0000
-#define FL_BASE1		0x0001
-#define FL_BASE2		0x0002
-#define FL_BASE3		0x0003
-#define FL_BASE4		0x0004
-#define FL_GET_BASE(x)		(x & FL_BASE_MASK)
-
-/* Use successive BARs (PCI base address registers),
-   else use offset into some specified BAR */
-#define FL_BASE_BARS		0x0008
-
-/* do not assign an irq */
-#define FL_NOIRQ		0x0080
-
-/* Use the Base address register size to cap number of ports */
-#define FL_REGION_SZ_CAP	0x0100
-
-struct pciserial_board {
-	unsigned int flags;
-	unsigned int num_ports;
-	unsigned int base_baud;
-	unsigned int uart_offset;
-	unsigned int reg_shift;
-	unsigned int first_offset;
-};
-
-struct serial_private;
-
-/*
  * init function returns:
  *  > 0 - number of ports
  *  = 0 - use board->num_ports
@@ -1517,60 +1485,14 @@
 	    board->first_offset == guessed->first_offset;
 }
 
-/*
- * Probe one serial board.  Unfortunately, there is no rhyme nor reason
- * to the arrangement of serial ports on a PCI card.
- */
-static int __devinit
-pciserial_init_one(struct pci_dev *dev, const struct pci_device_id *ent)
+struct serial_private *
+pciserial_init_ports(struct pci_dev *dev, struct pciserial_board *board)
 {
 	struct uart_port serial_port;
 	struct serial_private *priv;
-	struct pciserial_board *board, tmp;
 	struct pci_serial_quirk *quirk;
 	int rc, nr_ports, i;
 
-	if (ent->driver_data >= ARRAY_SIZE(pci_boards)) {
-		printk(KERN_ERR "pci_init_one: invalid driver_data: %ld\n",
-			ent->driver_data);
-		return -EINVAL;
-	}
-
-	board = &pci_boards[ent->driver_data];
-
-	rc = pci_enable_device(dev);
-	if (rc)
-		return rc;
-
-	if (ent->driver_data == pbn_default) {
-		/*
-		 * Use a copy of the pci_board entry for this;
-		 * avoid changing entries in the table.
-		 */
-		memcpy(&tmp, board, sizeof(struct pciserial_board));
-		board = &tmp;
-
-		/*
-		 * We matched one of our class entries.  Try to
-		 * determine the parameters of this board.
-		 */
-		rc = serial_pci_guess_board(dev, board);
-		if (rc)
-			goto disable;
-	} else {
-		/*
-		 * We matched an explicit entry.  If we are able to
-		 * detect this boards settings with our heuristic,
-		 * then we no longer need this entry.
-		 */
-		memcpy(&tmp, &pci_boards[pbn_default],
-		       sizeof(struct pciserial_board));
-		rc = serial_pci_guess_board(dev, &tmp);
-		if (rc == 0 && serial_pci_matches(board, &tmp))
-			moan_device("Redundant entry in serial pci_table.",
-				    dev);
-	}
-
 	nr_ports = board->num_ports;
 
 	/*
@@ -1587,8 +1509,10 @@
 	 */
 	if (quirk->init) {
 		rc = quirk->init(dev);
-		if (rc < 0)
-			goto disable;
+		if (rc < 0) {
+			priv = ERR_PTR(rc);
+			goto err_out;
+		}
 		if (rc)
 			nr_ports = rc;
 	}
@@ -1597,8 +1521,8 @@
 		       sizeof(unsigned int) * nr_ports,
 		       GFP_KERNEL);
 	if (!priv) {
-		rc = -ENOMEM;
-		goto deinit;
+		priv = ERR_PTR(-ENOMEM);
+		goto err_deinit;
 	}
 
 	memset(priv, 0, sizeof(struct serial_private) +
@@ -1606,7 +1530,6 @@
 
 	priv->dev = dev;
 	priv->quirk = quirk;
-	pci_set_drvdata(dev, priv);
 
 	memset(&serial_port, 0, sizeof(struct uart_port));
 	serial_port.flags = UPF_SKIP_TEST | UPF_BOOT_AUTOCONF | UPF_SHARE_IRQ;
@@ -1632,58 +1555,152 @@
 
 	priv->nr = i;
 
-	return 0;
+	return priv;
 
- deinit:
+ err_deinit:
 	if (quirk->exit)
 		quirk->exit(dev);
- disable:
-	pci_disable_device(dev);
-	return rc;
+ err_out:
+	return priv;
 }
+EXPORT_SYMBOL_GPL(pciserial_init_ports);
 
-static void __devexit pciserial_remove_one(struct pci_dev *dev)
+void pciserial_remove_ports(struct serial_private *priv)
 {
-	struct serial_private *priv = pci_get_drvdata(dev);
+	struct pci_serial_quirk *quirk;
+	int i;
 
-	pci_set_drvdata(dev, NULL);
+	for (i = 0; i < priv->nr; i++)
+		if (priv->line[i] >= 0)
+			serial8250_unregister_port(priv->line[i]);
 
-	if (priv) {
-		struct pci_serial_quirk *quirk;
-		int i;
+	for (i = 0; i < PCI_NUM_BAR_RESOURCES; i++) {
+		if (priv->remapped_bar[i])
+			iounmap(priv->remapped_bar[i]);
+		priv->remapped_bar[i] = NULL;
+	}
 
-		for (i = 0; i < priv->nr; i++)
-			serial8250_unregister_port(priv->line[i]);
+	/*
+	 * Find the exit quirks.
+	 */
+	quirk = find_quirk(priv->dev);
+	if (quirk->exit)
+		quirk->exit(priv->dev);
 
-		for (i = 0; i < PCI_NUM_BAR_RESOURCES; i++) {
-			if (priv->remapped_bar[i])
-				iounmap(priv->remapped_bar[i]);
-			priv->remapped_bar[i] = NULL;
-		}
+	kfree(priv);
+}
+EXPORT_SYMBOL_GPL(pciserial_remove_ports);
+
+void pciserial_suspend_ports(struct serial_private *priv)
+{
+	int i;
+
+	for (i = 0; i < priv->nr; i++)
+		if (priv->line[i] >= 0)
+			serial8250_suspend_port(priv->line[i]);
+}
+EXPORT_SYMBOL_GPL(pciserial_suspend_ports);
+
+void pciserial_resume_ports(struct serial_private *priv)
+{
+	int i;
+
+	/*
+	 * Ensure that the board is correctly configured.
+	 */
+	if (priv->quirk->init)
+		priv->quirk->init(priv->dev);
+
+	for (i = 0; i < priv->nr; i++)
+		if (priv->line[i] >= 0)
+			serial8250_resume_port(priv->line[i]);
+}
+EXPORT_SYMBOL_GPL(pciserial_resume_ports);
+
+/*
+ * Probe one serial board.  Unfortunately, there is no rhyme nor reason
+ * to the arrangement of serial ports on a PCI card.
+ */
+static int __devinit
+pciserial_init_one(struct pci_dev *dev, const struct pci_device_id *ent)
+{
+	struct serial_private *priv;
+	struct pciserial_board *board, tmp;
+	int rc;
 
+	if (ent->driver_data >= ARRAY_SIZE(pci_boards)) {
+		printk(KERN_ERR "pci_init_one: invalid driver_data: %ld\n",
+			ent->driver_data);
+		return -EINVAL;
+	}
+
+	board = &pci_boards[ent->driver_data];
+
+	rc = pci_enable_device(dev);
+	if (rc)
+		return rc;
+
+	if (ent->driver_data == pbn_default) {
 		/*
-		 * Find the exit quirks.
+		 * Use a copy of the pci_board entry for this;
+		 * avoid changing entries in the table.
 		 */
-		quirk = find_quirk(dev);
-		if (quirk->exit)
-			quirk->exit(dev);
+		memcpy(&tmp, board, sizeof(struct pciserial_board));
+		board = &tmp;
 
-		pci_disable_device(dev);
+		/*
+		 * We matched one of our class entries.  Try to
+		 * determine the parameters of this board.
+		 */
+		rc = serial_pci_guess_board(dev, board);
+		if (rc)
+			goto disable;
+	} else {
+		/*
+		 * We matched an explicit entry.  If we are able to
+		 * detect this boards settings with our heuristic,
+		 * then we no longer need this entry.
+		 */
+		memcpy(&tmp, &pci_boards[pbn_default],
+		       sizeof(struct pciserial_board));
+		rc = serial_pci_guess_board(dev, &tmp);
+		if (rc == 0 && serial_pci_matches(board, &tmp))
+			moan_device("Redundant entry in serial pci_table.",
+				    dev);
+	}
 
-		kfree(priv);
+	priv = pciserial_init_ports(dev, board);
+	if (!IS_ERR(priv)) {
+		pci_set_drvdata(dev, priv);
+		return 0;
 	}
+
+	rc = PTR_ERR(priv);
+
+ disable:
+	pci_disable_device(dev);
+	return rc;
+}
+
+static void __devexit pciserial_remove_one(struct pci_dev *dev)
+{
+	struct serial_private *priv = pci_get_drvdata(dev);
+
+	pci_set_drvdata(dev, NULL);
+
+	if (priv)
+		pciserial_remove_ports(priv);
+
+	pci_disable_device(dev);
 }
 
 static int pciserial_suspend_one(struct pci_dev *dev, pm_message_t state)
 {
 	struct serial_private *priv = pci_get_drvdata(dev);
 
-	if (priv) {
-		int i;
+	if (priv)
+		pciserial_suspend_ports(priv);
 
-		for (i = 0; i < priv->nr; i++)
-			serial8250_suspend_port(priv->line[i]);
-	}
 	pci_save_state(dev);
 	pci_set_power_state(dev, pci_choose_state(dev, state));
 	return 0;
@@ -1697,21 +1714,12 @@
 	pci_restore_state(dev);
 
 	if (priv) {
-		int i;
-
 		/*
 		 * The device may have been disabled.  Re-enable it.
 		 */
 		pci_enable_device(dev);
 
-		/*
-		 * Ensure that the board is correctly configured.
-		 */
-		if (priv->quirk->init)
-			priv->quirk->init(dev);
-
-		for (i = 0; i < priv->nr; i++)
-			serial8250_resume_port(priv->line[i]);
+		pciserial_resume_ports(priv);
 	}
 	return 0;
 }
only in patch2:
--- a/include/linux/8250_pci.h
+++ b/include/linux/8250_pci.h
@@ -1,2 +1,40 @@
+/*
+ * Definitions for PCI support.
+ */
+#define FL_BASE_MASK		0x0007
+#define FL_BASE0		0x0000
+#define FL_BASE1		0x0001
+#define FL_BASE2		0x0002
+#define FL_BASE3		0x0003
+#define FL_BASE4		0x0004
+#define FL_GET_BASE(x)		(x & FL_BASE_MASK)
+
+/* Use successive BARs (PCI base address registers),
+   else use offset into some specified BAR */
+#define FL_BASE_BARS		0x0008
+
+/* do not assign an irq */
+#define FL_NOIRQ		0x0080
+
+/* Use the Base address register size to cap number of ports */
+#define FL_REGION_SZ_CAP	0x0100
+
+struct pciserial_board {
+	unsigned int flags;
+	unsigned int num_ports;
+	unsigned int base_baud;
+	unsigned int uart_offset;
+	unsigned int reg_shift;
+	unsigned int first_offset;
+};
+
+struct serial_private;
+
+struct serial_private *
+pciserial_init_ports(struct pci_dev *dev, struct pciserial_board *board);
+void pciserial_remove_ports(struct serial_private *priv);
+void pciserial_suspend_ports(struct serial_private *priv);
+void pciserial_resume_ports(struct serial_private *priv);
+
 int pci_siig10x_fn(struct pci_dev *dev, int enable);
 int pci_siig20x_fn(struct pci_dev *dev, int enable);

--fdj2RfSjLxBAspz7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="20-8250parport.diff"

Convert parport_serial to use the new 8250_pci interface, converting
the table to a pciserial_board table.  This also unuses the SPCI_*
definitions in serialP.h, which can now be removed.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

diff -u b/drivers/serial/8250_pci.c uncommitted/drivers/serial/8250_pci.c  (mode:100644)
--- b/drivers/serial/8250_pci.c
+++ uncommitted/drivers/serial/8250_pci.c  (mode:100644)
@@ -46,7 +46,7 @@
 	u32	subdevice;
 	int	(*init)(struct pci_dev *dev);
 	int	(*setup)(struct serial_private *, struct pciserial_board *,
-			 struct uart_port *port, int idx);
+			 struct uart_port *, int idx);
 	void	(*exit)(struct pci_dev *dev);
 };
 
@@ -434,23 +434,4 @@
 }
 
-int pci_siig10x_fn(struct pci_dev *dev, int enable)
-{
-	int ret = 0;
-	if (enable)
-		ret = pci_siig10x_init(dev);
-	return ret;
-}
-
-int pci_siig20x_fn(struct pci_dev *dev, int enable)
-{
-	int ret = 0;
-	if (enable)
-		ret = pci_siig20x_init(dev);
-	return ret;
-}
-
-EXPORT_SYMBOL(pci_siig10x_fn);
-EXPORT_SYMBOL(pci_siig20x_fn);
-
 /*
  * Timedia has an explosion of boards, and to avoid the PCI table from
diff -u b/include/linux/8250_pci.h uncommitted/include/linux/8250_pci.h  (mode:100644)
--- b/include/linux/8250_pci.h
+++ uncommitted/include/linux/8250_pci.h  (mode:100644)
@@ -38,3 +37,0 @@
-
-int pci_siig10x_fn(struct pci_dev *dev, int enable);
-int pci_siig20x_fn(struct pci_dev *dev, int enable);
only in patch2:
unchanged:
--- 39040c7a05edd69381c0a25636a1a328d856cb9c/drivers/parport/parport_serial.c  (mode:100644)
+++ uncommitted/drivers/parport/parport_serial.c  (mode:100644)
@@ -23,13 +23,8 @@
 #include <linux/pci.h>
 #include <linux/parport.h>
 #include <linux/parport_pc.h>
-#include <linux/serial.h>
-#include <linux/serialP.h>
-#include <linux/list.h>
 #include <linux/8250_pci.h>
 
-#include <asm/serial.h>
-
 enum parport_pc_pci_cards {
 	titan_110l = 0,
 	titan_210l,
@@ -168,182 +163,147 @@
 };
 MODULE_DEVICE_TABLE(pci,parport_serial_pci_tbl);
 
-struct pci_board_no_ids {
-	int flags;
-	int num_ports;
-	int base_baud;
-	int uart_offset;
-	int reg_shift;
-	int (*init_fn)(struct pci_dev *dev, struct pci_board_no_ids *board,
-			int enable);
-	int first_uart_offset;
-};
-
-static int __devinit siig10x_init_fn(struct pci_dev *dev, struct pci_board_no_ids *board, int enable)
-{
-	return pci_siig10x_fn(dev, enable);
-}
-
-static int __devinit siig20x_init_fn(struct pci_dev *dev, struct pci_board_no_ids *board, int enable)
-{
-	return pci_siig20x_fn(dev, enable);
-}
-
-static int __devinit netmos_serial_init(struct pci_dev *dev, struct pci_board_no_ids *board, int enable)
-{
-	board->num_ports = dev->subsystem_device & 0xf;
-	return 0;
-}
-
-static struct pci_board_no_ids pci_boards[] __devinitdata = {
-	/*
-	 * PCI Flags, Number of Ports, Base (Maximum) Baud Rate,
-	 * Offset to get to next UART's registers,
-	 * Register shift to use for memory-mapped I/O,
-	 * Initialization function, first UART offset
-	 */
-
-// Cards not tested are marked n/t
-// If you have one of these cards and it works for you, please tell me..
-
-/* titan_110l */	{ SPCI_FL_BASE1 | SPCI_FL_BASE_TABLE, 1, 921600 },
-/* titan_210l */	{ SPCI_FL_BASE1 | SPCI_FL_BASE_TABLE, 2, 921600 },
-/* netmos_9xx5_combo */	{ SPCI_FL_BASE0 | SPCI_FL_BASE_TABLE, 1, 115200, 0, 0, netmos_serial_init },
-/* netmos_9855 */	{ SPCI_FL_BASE2 | SPCI_FL_BASE_TABLE, 1, 115200, 0, 0, netmos_serial_init },
-/* avlab_1s1p (n/t) */	{ SPCI_FL_BASE0 | SPCI_FL_BASE_TABLE, 1, 115200 },
-/* avlab_1s1p_650 (nt)*/{ SPCI_FL_BASE0 | SPCI_FL_BASE_TABLE, 1, 115200 },
-/* avlab_1s1p_850 (nt)*/{ SPCI_FL_BASE0 | SPCI_FL_BASE_TABLE, 1, 115200 },
-/* avlab_1s2p (n/t) */	{ SPCI_FL_BASE0 | SPCI_FL_BASE_TABLE, 1, 115200 },
-/* avlab_1s2p_650 (nt)*/{ SPCI_FL_BASE0 | SPCI_FL_BASE_TABLE, 1, 115200 },
-/* avlab_1s2p_850 (nt)*/{ SPCI_FL_BASE0 | SPCI_FL_BASE_TABLE, 1, 115200 },
-/* avlab_2s1p (n/t) */	{ SPCI_FL_BASE0 | SPCI_FL_BASE_TABLE, 2, 115200 },
-/* avlab_2s1p_650 (nt)*/{ SPCI_FL_BASE0 | SPCI_FL_BASE_TABLE, 2, 115200 },
-/* avlab_2s1p_850 (nt)*/{ SPCI_FL_BASE0 | SPCI_FL_BASE_TABLE, 2, 115200 },
-/* siig_1s1p_10x */	{ SPCI_FL_BASE2, 1, 460800, 0, 0, siig10x_init_fn },
-/* siig_2s1p_10x */	{ SPCI_FL_BASE2, 1, 921600, 0, 0, siig10x_init_fn },
-/* siig_2p1s_20x */	{ SPCI_FL_BASE0, 1, 921600, 0, 0, siig20x_init_fn },
-/* siig_1s1p_20x */	{ SPCI_FL_BASE0, 1, 921600, 0, 0, siig20x_init_fn },
-/* siig_2s1p_20x */	{ SPCI_FL_BASE0, 1, 921600, 0, 0, siig20x_init_fn },
+/*
+ * This table describes the serial "geometry" of these boards.  Any
+ * quirks for these can be found in drivers/serial/8250_pci.c
+ *
+ * Cards not tested are marked n/t
+ * If you have one of these cards and it works for you, please tell me..
+ */
+static struct pciserial_board pci_parport_serial_boards[] __devinitdata = {
+	[titan_110l] = {
+		.flags		= FL_BASE1 | FL_BASE_BARS,
+		.num_ports	= 1,
+		.base_baud	= 921600,
+		.uart_offset	= 8,
+	},
+	[titan_210l] = {
+		.flags		= FL_BASE1 | FL_BASE_BARS,
+		.num_ports	= 2,
+		.base_baud	= 921600,
+		.uart_offset	= 8,
+	},
+	[netmos_9xx5_combo] = {
+		.flags		= FL_BASE0 | FL_BASE_BARS,
+		.num_ports	= 1,
+		.base_baud	= 115200,
+		.uart_offset	= 8,
+	},
+	[netmos_9855] = {
+		.flags		= FL_BASE2 | FL_BASE_BARS,
+		.num_ports	= 1,
+		.base_baud	= 115200,
+		.uart_offset	= 8,
+	},
+	[avlab_1s1p] = { /* n/t */
+		.flags		= FL_BASE0 | FL_BASE_BARS,
+		.num_ports	= 1,
+		.base_baud	= 115200,
+		.uart_offset	= 8,
+	},
+	[avlab_1s1p_650] = { /* nt */
+		.flags		= FL_BASE0 | FL_BASE_BARS,
+		.num_ports	= 1,
+		.base_baud	= 115200,
+		.uart_offset	= 8,
+	},
+	[avlab_1s1p_850] = { /* nt */
+		.flags		= FL_BASE0 | FL_BASE_BARS,
+		.num_ports	= 1,
+		.base_baud	= 115200,
+		.uart_offset	= 8,
+	},
+	[avlab_1s2p] = { /* n/t */
+		.flags		= FL_BASE0 | FL_BASE_BARS,
+		.num_ports	= 1,
+		.base_baud	= 115200,
+		.uart_offset	= 8,
+	},
+	[avlab_1s2p_650] = { /* nt */
+		.flags		= FL_BASE0 | FL_BASE_BARS,
+		.num_ports	= 1,
+		.base_baud	= 115200,
+		.uart_offset	= 8,
+	},
+	[avlab_1s2p_850] = { /* nt */
+		.flags		= FL_BASE0 | FL_BASE_BARS,
+		.num_ports	= 1,
+		.base_baud	= 115200,
+		.uart_offset	= 8,
+	},
+	[avlab_2s1p] = { /* n/t */
+		.flags		= FL_BASE0 | FL_BASE_BARS,
+		.num_ports	= 2,
+		.base_baud	= 115200,
+		.uart_offset	= 8,
+	},
+	[avlab_2s1p_650] = { /* nt */
+		.flags		= FL_BASE0 | FL_BASE_BARS,
+		.num_ports	= 2,
+		.base_baud	= 115200,
+		.uart_offset	= 8,
+	},
+	[avlab_2s1p_850] = { /* nt */
+		.flags		= FL_BASE0 | FL_BASE_BARS,
+		.num_ports	= 2,
+		.base_baud	= 115200,
+		.uart_offset	= 8,
+	},
+	[siig_1s1p_10x] = {
+		.flags		= FL_BASE2,
+		.num_ports	= 1,
+		.base_baud	= 460800,
+		.uart_offset	= 8,
+	},
+	[siig_2s1p_10x] = {
+		.flags		= FL_BASE2,
+		.num_ports	= 1,
+		.base_baud	= 921600,
+		.uart_offset	= 8,
+	},
+	[siig_2p1s_20x] = {
+		.flags		= FL_BASE0,
+		.num_ports	= 1,
+		.base_baud	= 921600,
+		.uart_offset	= 8,
+	},
+	[siig_1s1p_20x] = {
+		.flags		= FL_BASE0,
+		.num_ports	= 1,
+		.base_baud	= 921600,
+		.uart_offset	= 8,
+	},
+	[siig_2s1p_20x] = {
+		.flags		= FL_BASE0,
+		.num_ports	= 1,
+		.base_baud	= 921600,
+		.uart_offset	= 8,
+	},
 };
 
 struct parport_serial_private {
-	int num_ser;
-	int line[20];
-	struct pci_board_no_ids ser;
+	struct serial_private	*serial;
 	int num_par;
 	struct parport *port[PARPORT_MAX];
 	struct parport_pc_pci par;
 };
 
-static int __devinit get_pci_port (struct pci_dev *dev,
-				   struct pci_board_no_ids *board,
-				   struct serial_struct *req,
-				   int idx)
-{
-	unsigned long port;
-	int base_idx;
-	int max_port;
-	int offset;
-
-	base_idx = SPCI_FL_GET_BASE(board->flags);
-	if (board->flags & SPCI_FL_BASE_TABLE)
-		base_idx += idx;
-
-	if (board->flags & SPCI_FL_REGION_SZ_CAP) {
-		max_port = pci_resource_len(dev, base_idx) / 8;
-		if (idx >= max_port)
-			return 1;
-	}
-			
-	offset = board->first_uart_offset;
-
-	/* Timedia/SUNIX uses a mixture of BARs and offsets */
-	/* Ugh, this is ugly as all hell --- TYT */
-	if(dev->vendor == PCI_VENDOR_ID_TIMEDIA )  /* 0x1409 */
-		switch(idx) {
-			case 0: base_idx=0;
-				break;
-			case 1: base_idx=0; offset=8;
-				break;
-			case 2: base_idx=1; 
-				break;
-			case 3: base_idx=1; offset=8;
-				break;
-			case 4: /* BAR 2*/
-			case 5: /* BAR 3 */
-			case 6: /* BAR 4*/
-			case 7: base_idx=idx-2; /* BAR 5*/
-		}
-  
-	port =  pci_resource_start(dev, base_idx) + offset;
-
-	if ((board->flags & SPCI_FL_BASE_TABLE) == 0)
-		port += idx * (board->uart_offset ? board->uart_offset : 8);
-
-	if (pci_resource_flags (dev, base_idx) & IORESOURCE_IO) {
-		int high_bits_offset = ((sizeof(long)-sizeof(int))*8);
-		req->port = port;
-		if (high_bits_offset)
-			req->port_high = port >> high_bits_offset;
-		else
-			req->port_high = 0;
-		return 0;
-	}
-	req->io_type = SERIAL_IO_MEM;
-	req->iomem_base = ioremap(port, board->uart_offset);
-	req->iomem_reg_shift = board->reg_shift;
-	req->port = 0;
-	return req->iomem_base ? 0 : 1;
-}
-
 /* Register the serial port(s) of a PCI card. */
 static int __devinit serial_register (struct pci_dev *dev,
 				      const struct pci_device_id *id)
 {
-	struct pci_board_no_ids *board;
 	struct parport_serial_private *priv = pci_get_drvdata (dev);
-	struct serial_struct serial_req;
-	int base_baud;
-	int k;
-	int success = 0;
-
-	priv->ser = pci_boards[id->driver_data];
-	board = &priv->ser;
-	if (board->init_fn && ((board->init_fn) (dev, board, 1) != 0))
-		return 1;
-
-	base_baud = board->base_baud;
-	if (!base_baud)
-		base_baud = BASE_BAUD;
-	memset (&serial_req, 0, sizeof (serial_req));
+	struct pciserial_board *board;
+	struct serial_private *serial;
 
-	for (k = 0; k < board->num_ports; k++) {
-		int line;
+	board = &pci_parport_serial_boards[id->driver_data];
+	serial = pciserial_init_ports(dev, board);
 
-		if (priv->num_ser == ARRAY_SIZE (priv->line)) {
-			printk (KERN_WARNING
-				"parport_serial: %s: only %u serial lines "
-				"supported (%d reported)\n", pci_name (dev),
-				ARRAY_SIZE (priv->line), board->num_ports);
-			break;
-		}
-
-		serial_req.irq = dev->irq;
-		if (get_pci_port (dev, board, &serial_req, k))
-			break;
-		serial_req.flags = ASYNC_SKIP_TEST | ASYNC_AUTOPROBE;
-		serial_req.baud_base = base_baud;
-		line = register_serial (&serial_req);
-		if (line < 0) {
-			printk (KERN_DEBUG
-				"parport_serial: register_serial failed\n");
-			continue;
-		}
-		priv->line[priv->num_ser++] = line;
-		success = 1;
-	}
+	if (IS_ERR(serial))
+		return PTR_ERR(serial);
 
-	return success ? 0 : 1;
+	priv->serial = serial;
+	return 0;
 }
 
 /* Register the parallel port(s) of a PCI card. */
@@ -411,7 +371,7 @@
 	priv = kmalloc (sizeof *priv, GFP_KERNEL);
 	if (!priv)
 		return -ENOMEM;
-	priv->num_ser = priv->num_par = 0;
+	memset(priv, 0, sizeof(struct parport_serial_private));
 	pci_set_drvdata (dev, priv);
 
 	err = pci_enable_device (dev);
@@ -444,15 +404,12 @@
 	struct parport_serial_private *priv = pci_get_drvdata (dev);
 	int i;
 
+	pci_set_drvdata(dev, NULL);
+
 	// Serial ports
-	for (i = 0; i < priv->num_ser; i++) {
-		unregister_serial (priv->line[i]);
+	if (priv->serial)
+		pciserial_remove_ports(priv->serial);
 
-		if (priv->ser.init_fn)
-			(priv->ser.init_fn) (dev, &priv->ser, 0);
-	}
-	pci_set_drvdata (dev, NULL);
-	
 	// Parallel ports
 	for (i = 0; i < priv->num_par; i++)
 		parport_pc_unregister_port (priv->port[i]);
@@ -461,11 +418,43 @@
 	return;
 }
 
+static int parport_serial_pci_suspend(struct pci_dev *dev, pm_message_t state)
+{
+	struct parport_serial_private *priv = pci_get_drvdata(dev);
+
+	if (priv->serial)
+		pciserial_suspend_ports(priv->serial);
+
+	pci_save_state(dev);
+	pci_set_power_state(dev, pci_choose_state(dev, state));
+	return 0;
+}
+
+static int parport_serial_pci_resume(struct pci_dev *dev)
+{
+	struct parport_serial_private *priv = pci_get_drvdata(dev);
+
+	pci_set_power_state(dev, PCI_D0);
+	pci_restore_state(dev);
+
+	/*
+	 * The device may have been disabled.  Re-enable it.
+	 */
+	pci_enable_device(dev);
+
+	if (priv->serial)
+		pciserial_resume_ports(priv->serial);
+
+	return 0;
+}
+
 static struct pci_driver parport_serial_pci_driver = {
 	.name		= "parport_serial",
 	.id_table	= parport_serial_pci_tbl,
 	.probe		= parport_serial_pci_probe,
 	.remove		= __devexit_p(parport_serial_pci_remove),
+	.suspend	= parport_serial_pci_suspend,
+	.resume		= parport_serial_pci_resume,
 };
 
 
only in patch2:
unchanged:
--- 39040c7a05edd69381c0a25636a1a328d856cb9c/include/linux/serialP.h  (mode:100644)
+++ uncommitted/include/linux/serialP.h  (mode:100644)
@@ -141,44 +141,4 @@
 #define ALPHA_KLUDGE_MCR 0
 #endif
 
-/*
- * Definitions for PCI support.
- */
-#define SPCI_FL_BASE_MASK	0x0007
-#define SPCI_FL_BASE0	0x0000
-#define SPCI_FL_BASE1	0x0001
-#define SPCI_FL_BASE2	0x0002
-#define SPCI_FL_BASE3	0x0003
-#define SPCI_FL_BASE4	0x0004
-#define SPCI_FL_GET_BASE(x)	(x & SPCI_FL_BASE_MASK)
-
-#define SPCI_FL_IRQ_MASK       (0x0007 << 4)
-#define SPCI_FL_IRQBASE0       (0x0000 << 4)
-#define SPCI_FL_IRQBASE1       (0x0001 << 4)
-#define SPCI_FL_IRQBASE2       (0x0002 << 4)
-#define SPCI_FL_IRQBASE3       (0x0003 << 4)
-#define SPCI_FL_IRQBASE4       (0x0004 << 4)
-#define SPCI_FL_GET_IRQBASE(x)        ((x & SPCI_FL_IRQ_MASK) >> 4)
-
-/* Use successive BARs (PCI base address registers), 
-   else use offset into some specified BAR */
-#define SPCI_FL_BASE_TABLE	0x0100
-
-/* Use successive entries in the irq resource table */
-#define SPCI_FL_IRQ_TABLE	0x0200
-
-/* Use the irq resource table instead of dev->irq */
-#define SPCI_FL_IRQRESOURCE	0x0400
-
-/* Use the Base address register size to cap number of ports */
-#define SPCI_FL_REGION_SZ_CAP	0x0800
-
-/* Do not use irq sharing for this device */
-#define SPCI_FL_NO_SHIRQ	0x1000
-
-/* This is a PNP device */
-#define SPCI_FL_ISPNP		0x2000
-
-#define SPCI_FL_PNPDEFAULT	(SPCI_FL_IRQRESOURCE|SPCI_FL_ISPNP)
-
 #endif /* _LINUX_SERIAL_H */

--fdj2RfSjLxBAspz7--
