Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263229AbSJHTEZ>; Tue, 8 Oct 2002 15:04:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263232AbSJHTDn>; Tue, 8 Oct 2002 15:03:43 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:17936 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S263207AbSJHTCL>; Tue, 8 Oct 2002 15:02:11 -0400
Subject: PATCH: 2.5 clean up of DE600
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Date: Tue, 8 Oct 2002 19:58:53 +0100 (BST)
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E17yzZF-0004sl-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.2.5.41/drivers/net/de600.c linux.2.5.41-ac1/drivers/net/de600.c
--- linux.2.5.41/drivers/net/de600.c	2002-10-02 21:33:48.000000000 +0100
+++ linux.2.5.41-ac1/drivers/net/de600.c	2002-10-07 00:41:21.000000000 +0100
@@ -1,5 +1,4 @@
-static const char version[] =
-	"de600.c: $Revision: 1.40 $,  Bjorn Ekwall (bj0rn@blox.se)\n";
+static const char version[] = "de600.c: $Revision: 1.41-2.5 $,  Bjorn Ekwall (bj0rn@blox.se)\n";
 /*
  *	de600.c
  *
@@ -18,10 +17,6 @@
  *	written by: Donald Becker <becker@super.org>
  *		(Now at <becker@scyld.com>)
  *
- *	compile-command:
- *	"gcc -D__KERNEL__  -Wall -Wstrict-prototypes -O6 -fomit-frame-pointer \
- *	 -m486 -c de600.c
- *
  **************************************************************/
 /*
  *	This program is free software; you can redistribute it and/or modify
@@ -39,8 +34,9 @@
  *	Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  *
  **************************************************************/
+
 /* Add more time here if your adapter won't work OK: */
-#define DE600_SLOW_DOWN udelay(delay_time)
+#define DE600_SLOW_DOWN	udelay(delay_time)
 
  /*
  * If you still have trouble reading/writing to the adapter,
@@ -49,38 +45,6 @@
  */
 #define SLOW_IO_BY_JUMPING /* Looks "better" than dummy write to port 0x80 :-) */
 
-/*
- * If you want to enable automatic continuous checking for the DE600,
- * keep this #define enabled.
- * It doesn't cost much per packet, so I think it is worth it!
- * If you disagree, comment away the #define, and live with it...
- *
- */
-#define CHECK_LOST_DE600
-
-/*
- * Enable this #define if you want the adapter to do a "ifconfig down" on
- * itself when we have detected that something is possibly wrong with it.
- * The default behaviour is to retry with "adapter_init()" until success.
- * This should be used for debugging purposes only.
- * (Depends on the CHECK_LOST_DE600 above)
- *
- */
-#define SHUTDOWN_WHEN_LOST
-
-/*
- * See comment at "de600_rspace()"!
- * This is an *ugly* hack, but for now it achieves its goal of
- * faking a TCP flow-control that will not flood the poor DE600.
- *
- * Tricks TCP to announce a small max window (max 2 fast packets please :-)
- *
- * Comment away at your own risk!
- *
- * Update: Use the more general per-device maxwindow parameter instead.
- */
-#undef FAKE_SMALL_MAX
-
 /* use 0 for production, 1 for verification, >2 for debug */
 #ifdef DE600_DEBUG
 #define PRINTK(x) if (de600_debug >= 2) printk x
@@ -88,7 +52,7 @@
 #define DE600_DEBUG 0
 #define PRINTK(x) /**/
 #endif
-
+
 #include <linux/module.h>
 
 #include <linux/kernel.h>
@@ -110,162 +74,25 @@
 #include <linux/etherdevice.h>
 #include <linux/skbuff.h>
 
+#include "de600.h"
+
 static unsigned int de600_debug = DE600_DEBUG;
 MODULE_PARM(de600_debug, "i");
 MODULE_PARM_DESC(de600_debug, "DE-600 debug level (0-2)");
 
+static unsigned int check_lost = 1;
+MODULE_PARM(check_lost, "i");
+MODULE_PARM_DESC(check_lost, "If set then check for unplugged de600");
+
 static unsigned int delay_time = 10;
 MODULE_PARM(delay_time, "i");
 MODULE_PARM_DESC(delay_time, "DE-600 deley on I/O in microseconds");
 
-#ifdef FAKE_SMALL_MAX
-static unsigned long de600_rspace(struct sock *sk);
-#include <net/sock.h>
-#endif
-
-typedef unsigned char byte;
-
-/**************************************************
- *                                                *
- * Definition of D-Link Ethernet Pocket adapter   *
- *                                                *
- **************************************************/
-/*
- * D-Link Ethernet pocket adapter ports
- */
-/*
- * OK, so I'm cheating, but there are an awful lot of
- * reads and writes in order to get anything in and out
- * of the DE-600 with 4 bits at a time in the parallel port,
- * so every saved instruction really helps :-)
- *
- * That is, I don't care what the device struct says
- * but hope that Space.c will keep the rest of the drivers happy.
- */
-#ifndef DE600_IO
-#define DE600_IO 0x378
-#endif
-
-#define DATA_PORT	(DE600_IO)
-#define STATUS_PORT	(DE600_IO + 1)
-#define COMMAND_PORT	(DE600_IO + 2)
-
-#ifndef DE600_IRQ
-#define DE600_IRQ	7
-#endif
-/*
- * It really should look like this, and autoprobing as well...
- *
-#define DATA_PORT	(dev->base_addr + 0)
-#define STATUS_PORT	(dev->base_addr + 1)
-#define COMMAND_PORT	(dev->base_addr + 2)
-#define DE600_IRQ	dev->irq
- */
-
-/*
- * D-Link COMMAND_PORT commands
- */
-#define SELECT_NIC	0x04 /* select Network Interface Card */
-#define SELECT_PRN	0x1c /* select Printer */
-#define NML_PRN		0xec /* normal Printer situation */
-#define IRQEN		0x10 /* enable IRQ line */
-
-/*
- * D-Link STATUS_PORT
- */
-#define RX_BUSY		0x80
-#define RX_GOOD		0x40
-#define TX_FAILED16	0x10
-#define TX_BUSY		0x08
-
-/*
- * D-Link DATA_PORT commands
- * command in low 4 bits
- * data in high 4 bits
- * select current data nibble with HI_NIBBLE bit
- */
-#define WRITE_DATA	0x00 /* write memory */
-#define READ_DATA	0x01 /* read memory */
-#define STATUS		0x02 /* read  status register */
-#define COMMAND		0x03 /* write command register (see COMMAND below) */
-#define NULL_COMMAND	0x04 /* null command */
-#define RX_LEN		0x05 /* read  received packet length */
-#define TX_ADDR		0x06 /* set adapter transmit memory address */
-#define RW_ADDR		0x07 /* set adapter read/write memory address */
-#define HI_NIBBLE	0x08 /* read/write the high nibble of data,
-				or-ed with rest of command */
-
-/*
- * command register, accessed through DATA_PORT with low bits = COMMAND
- */
-#define RX_ALL		0x01 /* PROMISCUOUS */
-#define RX_BP		0x02 /* default: BROADCAST & PHYSICAL ADDRESS */
-#define RX_MBP		0x03 /* MULTICAST, BROADCAST & PHYSICAL ADDRESS */
-
-#define TX_ENABLE	0x04 /* bit 2 */
-#define RX_ENABLE	0x08 /* bit 3 */
-
-#define RESET		0x80 /* set bit 7 high */
-#define STOP_RESET	0x00 /* set bit 7 low */
-
-/*
- * data to command register
- * (high 4 bits in write to DATA_PORT)
- */
-#define RX_PAGE2_SELECT	0x10 /* bit 4, only 2 pages to select */
-#define RX_BASE_PAGE	0x20 /* bit 5, always set when specifying RX_ADDR */
-#define FLIP_IRQ	0x40 /* bit 6 */
-
-/*
- * D-Link adapter internal memory:
- *
- * 0-2K 1:st transmit page (send from pointer up to 2K)
- * 2-4K	2:nd transmit page (send from pointer up to 4K)
- *
- * 4-6K 1:st receive page (data from 4K upwards)
- * 6-8K 2:nd receive page (data from 6K upwards)
- *
- * 8K+	Adapter ROM (contains magic code and last 3 bytes of Ethernet address)
- */
-#define MEM_2K		0x0800 /* 2048 */
-#define MEM_4K		0x1000 /* 4096 */
-#define MEM_6K		0x1800 /* 6144 */
-#define NODE_ADDRESS	0x2000 /* 8192 */
-
-#define RUNT 60		/* Too small Ethernet packet */
-
-/**************************************************
- *                                                *
- *             End of definition                  *
- *                                                *
- **************************************************/
-
-/*
- * Index to functions, as function prototypes.
- */
-/* Routines used internally. (See "convenience macros") */
-static byte	de600_read_status(struct net_device *dev);
-static byte	de600_read_byte(unsigned char type, struct net_device *dev);
-
-/* Put in the device structure. */
-static int	de600_open(struct net_device *dev);
-static int	de600_close(struct net_device *dev);
-static struct net_device_stats *get_stats(struct net_device *dev);
-static int	de600_start_xmit(struct sk_buff *skb, struct net_device *dev);
-
-/* Dispatch from interrupts. */
-static void	de600_interrupt(int irq, void *dev_id, struct pt_regs *regs);
-static int	de600_tx_intr(struct net_device *dev, int irq_status);
-static void	de600_rx_intr(struct net_device *dev);
-
-/* Initialization */
-static void	trigger_interrupt(struct net_device *dev);
-int		de600_probe(struct net_device *dev);
-static int	adapter_init(struct net_device *dev);
 
 /*
  * D-Link driver variables:
  */
+
 static volatile int		rx_page;
 
 #define TX_PAGES 2
@@ -274,46 +101,11 @@
 static volatile int		tx_fifo_out;
 static volatile int		free_tx_pages = TX_PAGES;
 static int			was_down;
+static spinlock_t		de600_lock;
 
-/*
- * Convenience macros/functions for D-Link adapter
- */
-
-#define select_prn() outb_p(SELECT_PRN, COMMAND_PORT); DE600_SLOW_DOWN
-#define select_nic() outb_p(SELECT_NIC, COMMAND_PORT); DE600_SLOW_DOWN
-
-/* Thanks for hints from Mark Burton <markb@ordern.demon.co.uk> */
-#define de600_put_byte(data) ( \
-	outb_p(((data) << 4)   | WRITE_DATA            , DATA_PORT), \
-	outb_p(((data) & 0xf0) | WRITE_DATA | HI_NIBBLE, DATA_PORT))
-
-/*
- * The first two outb_p()'s below could perhaps be deleted if there
- * would be more delay in the last two. Not certain about it yet...
- */
-#define de600_put_command(cmd) ( \
-	outb_p(( rx_page        << 4)   | COMMAND            , DATA_PORT), \
-	outb_p(( rx_page        & 0xf0) | COMMAND | HI_NIBBLE, DATA_PORT), \
-	outb_p(((rx_page | cmd) << 4)   | COMMAND            , DATA_PORT), \
-	outb_p(((rx_page | cmd) & 0xf0) | COMMAND | HI_NIBBLE, DATA_PORT))
-
-#define de600_setup_address(addr,type) ( \
-	outb_p((((addr) << 4) & 0xf0) | type            , DATA_PORT), \
-	outb_p(( (addr)       & 0xf0) | type | HI_NIBBLE, DATA_PORT), \
-	outb_p((((addr) >> 4) & 0xf0) | type            , DATA_PORT), \
-	outb_p((((addr) >> 8) & 0xf0) | type | HI_NIBBLE, DATA_PORT))
-
-#define rx_page_adr() ((rx_page & RX_PAGE2_SELECT)?(MEM_6K):(MEM_4K))
-
-/* Flip bit, only 2 pages */
-#define next_rx_page() (rx_page ^= RX_PAGE2_SELECT)
-
-#define tx_page_adr(a) (((a) + 1) * MEM_2K)
-
-static inline byte
-de600_read_status(struct net_device *dev)
+static inline u8 de600_read_status(struct net_device *dev)
 {
-	byte status;
+	u8 status;
 
 	outb_p(STATUS, DATA_PORT);
 	status = inb(STATUS_PORT);
@@ -322,16 +114,16 @@
 	return status;
 }
 
-static inline byte
-de600_read_byte(unsigned char type, struct net_device *dev) { /* dev used by macros */
-	byte lo;
-
-	(void)outb_p((type), DATA_PORT);
+static inline u8 de600_read_byte(unsigned char type, struct net_device *dev)
+{
+	/* dev used by macros */
+	u8 lo;
+	outb_p((type), DATA_PORT);
 	lo = ((unsigned char)inb(STATUS_PORT)) >> 4;
-	(void)outb_p((type) | HI_NIBBLE, DATA_PORT);
+	outb_p((type) | HI_NIBBLE, DATA_PORT);
 	return ((unsigned char)inb(STATUS_PORT) & (unsigned char)0xf0) | lo;
 }
-
+
 /*
  * Open/initialize the board.  This is called (in the current kernel)
  * after booting when 'ifconfig <dev->name> $IP_ADDR' is run (in rc.inet1).
@@ -340,26 +132,26 @@
  * registers that "should" only need to be set once at boot, so that
  * there is a non-reboot way to recover if something goes wrong.
  */
-static int
-de600_open(struct net_device *dev)
+
+static int de600_open(struct net_device *dev)
 {
+	unsigned long flags;
 	int ret = request_irq(DE600_IRQ, de600_interrupt, 0, dev->name, dev);
 	if (ret) {
-		printk ("%s: unable to get IRQ %d\n", dev->name, DE600_IRQ);
+		printk(KERN_ERR "%s: unable to get IRQ %d\n", dev->name, DE600_IRQ);
 		return ret;
 	}
-
-	if (adapter_init(dev))
-		return -EIO;
-
-	return 0;
+	spin_lock_irqsave(&de600_lock, flags);
+	ret = adapter_init(dev);
+	spin_unlock_irqrestore(&de600_lock, flags);
+	return ret;
 }
 
 /*
  * The inverse routine to de600_open().
  */
-static int
-de600_close(struct net_device *dev)
+
+static int de600_close(struct net_device *dev)
 {
 	select_nic();
 	rx_page = 0;
@@ -367,21 +159,16 @@
 	de600_put_command(STOP_RESET);
 	de600_put_command(0);
 	select_prn();
-
-	if (netif_running(dev)) { /* perhaps not needed? */
-		free_irq(DE600_IRQ, dev);
-	}
+	free_irq(DE600_IRQ, dev);
 	return 0;
 }
 
-static struct net_device_stats *
-get_stats(struct net_device *dev)
+static struct net_device_stats *get_stats(struct net_device *dev)
 {
-    return (struct net_device_stats *)(dev->priv);
+	return (struct net_device_stats *)(dev->priv);
 }
 
-static inline void
-trigger_interrupt(struct net_device *dev)
+static inline void trigger_interrupt(struct net_device *dev)
 {
 	de600_put_command(FLIP_IRQ);
 	select_prn();
@@ -394,31 +181,28 @@
  * Copy a buffer to the adapter transmit page memory.
  * Start sending.
  */
-static int
-de600_start_xmit(struct sk_buff *skb, struct net_device *dev)
+ 
+static int de600_start_xmit(struct sk_buff *skb, struct net_device *dev)
 {
 	unsigned long flags;
 	int	transmit_from;
 	int	len;
 	int	tickssofar;
-	byte	*buffer = skb->data;
+	u8	*buffer = skb->data;
 
 	if (free_tx_pages <= 0) {	/* Do timeouts, to avoid hangs. */
 		tickssofar = jiffies - dev->trans_start;
-
 		if (tickssofar < 5)
 			return 1;
-
 		/* else */
-		printk("%s: transmit timed out (%d), %s?\n",
-			dev->name,
-			tickssofar,
-			"network cable problem"
-			);
+		printk(KERN_WARNING "%s: transmit timed out (%d), %s?\n", dev->name, tickssofar, "network cable problem");
 		/* Restart the adapter. */
+		spin_lock_irqsave(&de600_lock, flags);
 		if (adapter_init(dev)) {
+			spin_unlock_irqrestore(&de600_lock, flags);
 			return 1;
 		}
+		spin_unlock_irqrestore(&de600_lock, flags);
 	}
 
 	/* Start real output */
@@ -427,23 +211,23 @@
 	if ((len = skb->len) < RUNT)
 		len = RUNT;
 
-	save_flags(flags);
-	cli();
+	spin_lock_irqsave(&de600_lock, flags);
 	select_nic();
 	tx_fifo[tx_fifo_in] = transmit_from = tx_page_adr(tx_fifo_in) - len;
 	tx_fifo_in = (tx_fifo_in + 1) % TX_PAGES; /* Next free tx page */
 
-#ifdef CHECK_LOST_DE600
-	/* This costs about 40 instructions per packet... */
-	de600_setup_address(NODE_ADDRESS, RW_ADDR);
-	de600_read_byte(READ_DATA, dev);
-	if (was_down || (de600_read_byte(READ_DATA, dev) != 0xde)) {
-		if (adapter_init(dev)) {
-			restore_flags(flags);
-			return 1;
+	if(check_lost)
+	{
+		/* This costs about 40 instructions per packet... */
+		de600_setup_address(NODE_ADDRESS, RW_ADDR);
+		de600_read_byte(READ_DATA, dev);
+		if (was_down || (de600_read_byte(READ_DATA, dev) != 0xde)) {
+			if (adapter_init(dev)) {
+				spin_unlock_irqrestore(&de600_lock, flags);
+				return 1;
+			}
 		}
 	}
-#endif
 
 	de600_setup_address(transmit_from, RW_ADDR);
 	for ( ; len > 0; --len, ++buffer)
@@ -463,39 +247,31 @@
 			netif_stop_queue(dev);
 		select_prn();
 	}
-
-	restore_flags(flags);
-
-#ifdef FAKE_SMALL_MAX
-	/* This will "patch" the socket TCP proto at an early moment */
-	if (skb->sk && (skb->sk->protocol == IPPROTO_TCP) &&
-		(skb->sk->prot->rspace != &de600_rspace))
-		skb->sk->prot->rspace = de600_rspace; /* Ugh! */
-#endif
-
-	dev_kfree_skb (skb);
-
+	spin_unlock_irqrestore(&de600_lock, flags);
+	dev_kfree_skb(skb);
 	return 0;
 }
-
+
 /*
  * The typical workload of the driver:
  * Handle the network interface interrupts.
  */
-static void
-de600_interrupt(int irq, void *dev_id, struct pt_regs * regs)
+
+static void de600_interrupt(int irq, void *dev_id, struct pt_regs * regs)
 {
 	struct net_device	*dev = dev_id;
-	byte		irq_status;
+	u8		irq_status;
 	int		retrig = 0;
 	int		boguscount = 0;
 
 	/* This might just as well be deleted now, no crummy drivers present :-) */
 	if ((dev == NULL) || (DE600_IRQ != irq)) {
-		printk("%s: bogus interrupt %d\n", dev?dev->name:"DE-600", irq);
+		printk(KERN_ERR "%s: bogus interrupt %d\n", dev?dev->name:"DE-600", irq);
 		return;
 	}
 
+	spin_lock(&de600_lock);
+	
 	select_nic();
 	irq_status = de600_read_status(dev);
 
@@ -523,15 +299,13 @@
 
 	/* Enable adapter interrupts */
 	select_prn();
-
 	if (retrig)
 		trigger_interrupt(dev);
-
+	spin_unlock(&de600_lock);
 	return;
 }
 
-static int
-de600_tx_intr(struct net_device *dev, int irq_status)
+static int de600_tx_intr(struct net_device *dev, int irq_status)
 {
 	/*
 	 * Returns 1 if tx still not done
@@ -565,18 +339,13 @@
 /*
  * We have a good packet, get it out of the adapter.
  */
-static void
-de600_rx_intr(struct net_device *dev)
+static void de600_rx_intr(struct net_device *dev)
 {
 	struct sk_buff	*skb;
-	unsigned long flags;
 	int		i;
 	int		read_from;
 	int		size;
-	register unsigned char	*buffer;
-
-	save_flags(flags);
-	cli();
+	unsigned char	*buffer;
 
 	/* Get size of received packet */
 	size = de600_read_byte(RX_LEN, dev);	/* low byte */
@@ -588,10 +357,8 @@
 	next_rx_page();
 	de600_put_command(RX_ENABLE);
 
-	restore_flags(flags);
-
 	if ((size < 32)  ||  (size > 1535)) {
-		printk("%s: Bogus packet size %d.\n", dev->name, size);
+		printk(KERN_WARNING "%s: Bogus packet size %d.\n", dev->name, size);
 		if (size > 10000)
 			adapter_init(dev);
 		return;
@@ -599,8 +366,7 @@
 
 	skb = dev_alloc_skb(size+2);
 	if (skb == NULL) {
-		printk("%s: Couldn't allocate a sk_buff of size %d.\n",
-			dev->name, size);
+		printk("%s: Couldn't allocate a sk_buff of size %d.\n", dev->name, size);
 		return;
 	}
 	/* else */
@@ -627,13 +393,11 @@
 
 	/*
 	 * If any worth-while packets have been received, netif_rx()
-	 * has done a mark_bh(INET_BH) for us and will work on them
-	 * when we get to the bottom-half routine.
+	 * will work on them when we get to the tasklets.
 	 */
 }
 
-int __init 
-de600_probe(struct net_device *dev)
+int __init de600_probe(struct net_device *dev)
 {
 	int	i;
 	static struct net_device_stats de600_netstats;
@@ -641,7 +405,7 @@
 
 	SET_MODULE_OWNER(dev);
 
-	printk("%s: D-Link DE-600 pocket adapter", dev->name);
+	printk(KERN_INFO "%s: D-Link DE-600 pocket adapter", dev->name);
 	/* Alpha testers must have the version number to report bugs. */
 	if (de600_debug > 1)
 		printk(version);
@@ -682,12 +446,6 @@
 		return -ENODEV;
 	}
 
-#if 0 /* Not yet */
-	if (check_region(DE600_IO, 3)) {
-		printk(", port 0x%x busy\n", DE600_IO);
-		return -EBUSY;
-	}
-#endif
 	request_region(DE600_IO, 3, "de600");
 
 	printk(", Ethernet Address: %02X", dev->dev_addr[0]);
@@ -713,20 +471,15 @@
 	return 0;
 }
 
-static int
-adapter_init(struct net_device *dev)
+static int adapter_init(struct net_device *dev)
 {
 	int	i;
-       unsigned long flags;
-
-	save_flags(flags);
-	cli();
 
 	select_nic();
 	rx_page = 0; /* used by RESET */
 	de600_put_command(RESET);
 	de600_put_command(STOP_RESET);
-#ifdef CHECK_LOST_DE600
+
 	/* Check if it is still there... */
 	/* Get the some bytes of the adapter ethernet address from the ROM */
 	de600_setup_address(NODE_ADDRESS, RW_ADDR);
@@ -734,32 +487,25 @@
 	if ((de600_read_byte(READ_DATA, dev) != 0xde) ||
 	    (de600_read_byte(READ_DATA, dev) != 0x15)) {
 	/* was: if (de600_read_status(dev) & 0xf0) { */
-		printk("Something has happened to the DE-600!  Please check it"
-#ifdef SHUTDOWN_WHEN_LOST
-			" and do a new ifconfig"
-#endif /* SHUTDOWN_WHEN_LOST */
-			"!\n");
-#ifdef SHUTDOWN_WHEN_LOST
+		printk("Something has happened to the DE-600!  Please check it and do a new ifconfig!\n");
 		/* Goodbye, cruel world... */
 		dev->flags &= ~IFF_UP;
 		de600_close(dev);
-#endif /* SHUTDOWN_WHEN_LOST */
 		was_down = 1;
 		netif_stop_queue(dev); /* Transmit busy...  */
-		restore_flags(flags);
 		return 1; /* failed */
 	}
-#endif /* CHECK_LOST_DE600 */
+
 	if (was_down) {
-		printk("Thanks, I feel much better now!\n");
+		printk(KERN_INFO "%s: Thanks, I feel much better now!\n", dev->name);
 		was_down = 0;
 	}
 
-	netif_start_queue(dev);
 	tx_fifo_in = 0;
 	tx_fifo_out = 0;
 	free_tx_pages = TX_PAGES;
 
+
 	/* set the ether address. */
 	de600_setup_address(NODE_ADDRESS, RW_ADDR);
 	for (i = 0; i < ETH_ALEN; i++)
@@ -771,82 +517,30 @@
 	/* Enable receiver */
 	de600_put_command(RX_ENABLE);
 	select_prn();
-	restore_flags(flags);
+
+	netif_start_queue(dev);
 
 	return 0; /* OK */
 }
 
-#ifdef FAKE_SMALL_MAX
-/*
- *	The new router code (coming soon 8-) ) will fix this properly.
- */
-#define DE600_MIN_WINDOW 1024
-#define DE600_MAX_WINDOW 2048
-#define DE600_TCP_WINDOW_DIFF 1024
-/*
- * Copied from "net/inet/sock.c"
- *
- * Sets a lower max receive window in order to achieve <= 2
- * packets arriving at the adapter in fast succession.
- * (No way that a DE-600 can keep up with a net saturated
- *  with packets homing in on it :-( )
- *
- * Since there are only 2 receive buffers in the DE-600
- * and it takes some time to copy from the adapter,
- * this is absolutely necessary for any TCP performance whatsoever!
- *
- * Note that the returned window info will never be smaller than
- * DE600_MIN_WINDOW, i.e. 1024
- * This differs from the standard function, that can return an
- * arbitrarily small window!
- */
-static unsigned long
-de600_rspace(struct sock *sk)
-{
-  int amt;
-
-  if (sk != NULL) {
-/*
- * Hack! You might want to play with commenting away the following line,
- * if you know what you do!
-  	sk->max_unacked = DE600_MAX_WINDOW - DE600_TCP_WINDOW_DIFF;
- */
-
-	if (atomic_read(&sk->rmem_alloc) >= sk->rcvbuf-2*DE600_MIN_WINDOW) return(0);
-	amt = min_t(int, (sk->rcvbuf-atomic_read(&sk->rmem_alloc))/2/*-DE600_MIN_WINDOW*/, DE600_MAX_WINDOW);
-	if (amt < 0) return(0);
-	return(amt);
-  }
-  return(0);
-}
-#endif
-
-#ifdef MODULE
 static struct net_device de600_dev;
 
-int
-init_module(void)
+static int __init de600_init(void)
 {
+	spin_lock_init(&de600_lock);
 	de600_dev.init = de600_probe;
 	if (register_netdev(&de600_dev) != 0)
 		return -EIO;
 	return 0;
 }
 
-void
-cleanup_module(void)
+static void __exit de600_exit(void)
 {
 	unregister_netdev(&de600_dev);
 	release_region(DE600_IO, 3);
 }
-#endif /* MODULE */
 
-MODULE_LICENSE("GPL");
+module_init(de600_init);
+module_exit(de600_exit);
 
-/*
- * Local variables:
- *  kernel-compile-command: "gcc -D__KERNEL__ -Ilinux/include -I../../net/inet -Wall -Wstrict-prototypes -O2 -m486 -c de600.c"
- *  module-compile-command: "gcc -D__KERNEL__ -DMODULE -Ilinux/include -I../../net/inet -Wall -Wstrict-prototypes -O2 -m486 -c de600.c"
- *  compile-command: "gcc -D__KERNEL__ -DMODULE -Ilinux/include -I../../net/inet -Wall -Wstrict-prototypes -O2 -m486 -c de600.c"
- * End:
- */
+MODULE_LICENSE("GPL");
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.2.5.41/drivers/net/de600.h linux.2.5.41-ac1/drivers/net/de600.h
--- linux.2.5.41/drivers/net/de600.h	1970-01-01 01:00:00.000000000 +0100
+++ linux.2.5.41-ac1/drivers/net/de600.h	2002-10-07 00:39:24.000000000 +0100
@@ -0,0 +1,170 @@
+/**************************************************
+ *                                                *
+ * Definition of D-Link Ethernet Pocket adapter   *
+ *                                                *
+ **************************************************/
+/*
+ * D-Link Ethernet pocket adapter ports
+ */
+/*
+ * OK, so I'm cheating, but there are an awful lot of
+ * reads and writes in order to get anything in and out
+ * of the DE-600 with 4 bits at a time in the parallel port,
+ * so every saved instruction really helps :-)
+ */
+
+#ifndef DE600_IO
+#define DE600_IO	0x378
+#endif
+
+#define DATA_PORT	(DE600_IO)
+#define STATUS_PORT	(DE600_IO + 1)
+#define COMMAND_PORT	(DE600_IO + 2)
+
+#ifndef DE600_IRQ
+#define DE600_IRQ	7
+#endif
+/*
+ * It really should look like this, and autoprobing as well...
+ *
+#define DATA_PORT	(dev->base_addr + 0)
+#define STATUS_PORT	(dev->base_addr + 1)
+#define COMMAND_PORT	(dev->base_addr + 2)
+#define DE600_IRQ	dev->irq
+ */
+
+/*
+ * D-Link COMMAND_PORT commands
+ */
+#define SELECT_NIC	0x04 /* select Network Interface Card */
+#define SELECT_PRN	0x1c /* select Printer */
+#define NML_PRN		0xec /* normal Printer situation */
+#define IRQEN		0x10 /* enable IRQ line */
+
+/*
+ * D-Link STATUS_PORT
+ */
+#define RX_BUSY		0x80
+#define RX_GOOD		0x40
+#define TX_FAILED16	0x10
+#define TX_BUSY		0x08
+
+/*
+ * D-Link DATA_PORT commands
+ * command in low 4 bits
+ * data in high 4 bits
+ * select current data nibble with HI_NIBBLE bit
+ */
+#define WRITE_DATA	0x00 /* write memory */
+#define READ_DATA	0x01 /* read memory */
+#define STATUS		0x02 /* read  status register */
+#define COMMAND		0x03 /* write command register (see COMMAND below) */
+#define NULL_COMMAND	0x04 /* null command */
+#define RX_LEN		0x05 /* read  received packet length */
+#define TX_ADDR		0x06 /* set adapter transmit memory address */
+#define RW_ADDR		0x07 /* set adapter read/write memory address */
+#define HI_NIBBLE	0x08 /* read/write the high nibble of data,
+				or-ed with rest of command */
+
+/*
+ * command register, accessed through DATA_PORT with low bits = COMMAND
+ */
+#define RX_ALL		0x01 /* PROMISCUOUS */
+#define RX_BP		0x02 /* default: BROADCAST & PHYSICAL ADDRESS */
+#define RX_MBP		0x03 /* MULTICAST, BROADCAST & PHYSICAL ADDRESS */
+
+#define TX_ENABLE	0x04 /* bit 2 */
+#define RX_ENABLE	0x08 /* bit 3 */
+
+#define RESET		0x80 /* set bit 7 high */
+#define STOP_RESET	0x00 /* set bit 7 low */
+
+/*
+ * data to command register
+ * (high 4 bits in write to DATA_PORT)
+ */
+#define RX_PAGE2_SELECT	0x10 /* bit 4, only 2 pages to select */
+#define RX_BASE_PAGE	0x20 /* bit 5, always set when specifying RX_ADDR */
+#define FLIP_IRQ	0x40 /* bit 6 */
+
+/*
+ * D-Link adapter internal memory:
+ *
+ * 0-2K 1:st transmit page (send from pointer up to 2K)
+ * 2-4K	2:nd transmit page (send from pointer up to 4K)
+ *
+ * 4-6K 1:st receive page (data from 4K upwards)
+ * 6-8K 2:nd receive page (data from 6K upwards)
+ *
+ * 8K+	Adapter ROM (contains magic code and last 3 bytes of Ethernet address)
+ */
+#define MEM_2K		0x0800 /* 2048 */
+#define MEM_4K		0x1000 /* 4096 */
+#define MEM_6K		0x1800 /* 6144 */
+#define NODE_ADDRESS	0x2000 /* 8192 */
+
+#define RUNT 60		/* Too small Ethernet packet */
+
+/**************************************************
+ *                                                *
+ *             End of definition                  *
+ *                                                *
+ **************************************************/
+
+/*
+ * Index to functions, as function prototypes.
+ */
+/* Routines used internally. (See "convenience macros") */
+static u8	de600_read_status(struct net_device *dev);
+static u8	de600_read_byte(unsigned char type, struct net_device *dev);
+
+/* Put in the device structure. */
+static int	de600_open(struct net_device *dev);
+static int	de600_close(struct net_device *dev);
+static struct net_device_stats *get_stats(struct net_device *dev);
+static int	de600_start_xmit(struct sk_buff *skb, struct net_device *dev);
+
+/* Dispatch from interrupts. */
+static void	de600_interrupt(int irq, void *dev_id, struct pt_regs *regs);
+static int	de600_tx_intr(struct net_device *dev, int irq_status);
+static void	de600_rx_intr(struct net_device *dev);
+
+/* Initialization */
+static void	trigger_interrupt(struct net_device *dev);
+int		de600_probe(struct net_device *dev);
+static int	adapter_init(struct net_device *dev);
+
+/*
+ * Convenience macros/functions for D-Link adapter
+ */
+
+#define select_prn() outb_p(SELECT_PRN, COMMAND_PORT); DE600_SLOW_DOWN
+#define select_nic() outb_p(SELECT_NIC, COMMAND_PORT); DE600_SLOW_DOWN
+
+/* Thanks for hints from Mark Burton <markb@ordern.demon.co.uk> */
+#define de600_put_byte(data) ( \
+	outb_p(((data) << 4)   | WRITE_DATA            , DATA_PORT), \
+	outb_p(((data) & 0xf0) | WRITE_DATA | HI_NIBBLE, DATA_PORT))
+
+/*
+ * The first two outb_p()'s below could perhaps be deleted if there
+ * would be more delay in the last two. Not certain about it yet...
+ */
+#define de600_put_command(cmd) ( \
+	outb_p(( rx_page        << 4)   | COMMAND            , DATA_PORT), \
+	outb_p(( rx_page        & 0xf0) | COMMAND | HI_NIBBLE, DATA_PORT), \
+	outb_p(((rx_page | cmd) << 4)   | COMMAND            , DATA_PORT), \
+	outb_p(((rx_page | cmd) & 0xf0) | COMMAND | HI_NIBBLE, DATA_PORT))
+
+#define de600_setup_address(addr,type) ( \
+	outb_p((((addr) << 4) & 0xf0) | type            , DATA_PORT), \
+	outb_p(( (addr)       & 0xf0) | type | HI_NIBBLE, DATA_PORT), \
+	outb_p((((addr) >> 4) & 0xf0) | type            , DATA_PORT), \
+	outb_p((((addr) >> 8) & 0xf0) | type | HI_NIBBLE, DATA_PORT))
+
+#define rx_page_adr() ((rx_page & RX_PAGE2_SELECT)?(MEM_6K):(MEM_4K))
+
+/* Flip bit, only 2 pages */
+#define next_rx_page() (rx_page ^= RX_PAGE2_SELECT)
+
+#define tx_page_adr(a) (((a) + 1) * MEM_2K)
