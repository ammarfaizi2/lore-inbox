Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129535AbQLGP4m>; Thu, 7 Dec 2000 10:56:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130152AbQLGP4c>; Thu, 7 Dec 2000 10:56:32 -0500
Received: from isis.its.uow.edu.au ([130.130.68.21]:33442 "EHLO
	isis.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S129535AbQLGP40>; Thu, 7 Dec 2000 10:56:26 -0500
Message-ID: <3A2FACE5.C789850D@uow.edu.au>
Date: Fri, 08 Dec 2000 02:29:41 +1100
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.4.0-test8 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Miles Lane <miles@megapathdsl.net>, linux-kernel@vger.kernel.org
Subject: Re: The horrible hack from hell called A20
In-Reply-To: <3A2EBF17.9010509@megapathdsl.net> <Pine.LNX.4.10.10012061814020.7391-100000@penguin.transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On Wed, 6 Dec 2000, Miles Lane wrote:
> >
> > Here is what goes wrong:
> >
> > Dec  6 04:21:32 agate kernel: eth0: Host error, FIFO diagnostic register  0000.
> 
> But it continues to work, right?
> 
> I bet that your ethernet card is just unhappy that it couldn't get DMA in
> time, because the bus was so busy. Many of the busmastering ethernet
> devices will start the packet send early, happy in the knowledge that
> they'll usually have plenty of time to DMA the data by the time they need
> it.
> 
> This works fine most of the time, but if you have a busy PCI bus and
> you're doing things over a (potentially slow) PCI bridge like the Cardbus
> bridge, you're taking chances. And sometimes those chances do not work out
> ok.. Especially if you have slow memory, which most laptops have.
> 
> I suspect that the worst result of this is just a noisy driver: both on
> the network (runt packets) and on the console. And it obviously will cause
> performance to suffer too, due to retransmitting packets that failed,
> and/or losing packets.
> 
> There may be some rule for the threshold for sending packets or something
> else to make this happen less, so this is probably tweakable. But it
> doesn't sound deadly (unless the driver causes this to result in a dead
> network - does it?)
> 

We initialise the 3com NICs so that the DMA of Tx frames doesn't
commence until 1536 free bytes are available in the Tx FIFO.  I assume
this is to make the most of the NIC's ability to bus-master-transfer an
entire frame in one slurp.  But this is irrelevant.

We initialise the NIC so it starts putting data on the wire after 128
bytes are in the Tx FIFO.  So yes, there is an opportunity for another
bus master to interrupt the slurp and to hold the bus for so long that
the NIC gets a TX underrun.  But surely not by just wiggling the mouse
around?

I have seen just one report of a person getting Tx underruns.  The
driver recovered OK.  But Miles is reporting "Host error".  This is
different.  The 3com datasheet says:

   This bit is set when a catastrophic error related to the bus
   interface occurs.

   The errors that set this bit are PCI target abort and PCI master
   abort.  

   This bis is cleared by issuing the GlobalReset command...

This is a very rare problem.  Trolling the vortex archives comes up
with a few comments from Das Nicmeisters:

   > Donald Becker write:
   > Another PCMCIA setup bug, except this one is much harder to track down.
   > The CardBus bridge chip isn't configured correctly.
   > This is a real bus problem, not a false report.

   > David Hinds wrote:
   > I've gotten a few reports of these PCI bus errors.  They have indeed
   > been very hard to track down, since they are specific to particular
   > hardware combinations, and I've never been able to reproduce them.

   > Donald Becker wrote:
   > I've gotten this error on my Vaio 505TR, but I've never been able to
   > reproduce it when I'm ready to observe it.

Miles, could you please apply the below patch? It'll give us a
little more info about the PCI error.  Bit 31 of `bus status' is
MasterAbort and bit 30 is TargetAbort.

Also, you can disable the start-tx-after-128-bytes feature by uncommenting

//	wait_for_completion(dev, SetTxStart|0x07ff);

near the end of vortex_up().  With this change the NIC won't start
transmitting until it has the entire frame onboard.  It shouldn't make
any difference (hah).  

This does look like a Cardbus bridge problem.



--- linux-2.4.0-test12-pre7/drivers/net/3c59x.c	Tue Nov 21 20:11:20 2000
+++ linux-akpm/drivers/net/3c59x.c	Fri Dec  8 02:24:11 2000
@@ -203,7 +203,7 @@
 #include <linux/delay.h>
 
 static char version[] __devinitdata =
-"3c59x.c:LK1.1.11 13 Nov 2000  Donald Becker and others. http://www.scyld.com/network/vortex.html " "$Revision: 1.102.2.46 $\n";
+"3c59x.c:LK1.1.11 13 Nov 2000  Donald Becker and others. http://www.scyld.com/network/vortex.html " "$Revision: 1.102.2.40 $\n";
 
 MODULE_AUTHOR("Donald Becker <becker@scyld.com>");
 MODULE_DESCRIPTION("3Com 3c59x/3c90x/3c575 series Vortex/Boomerang/Cyclone driver");
@@ -843,10 +843,15 @@
 {
 	int rc;
 
-	rc = vortex_probe1 (pdev, pci_resource_start (pdev, 0), pdev->irq,
-			    ent->driver_data, vortex_cards_found);
-	if (rc == 0)
-		vortex_cards_found++;
+	/* wake up and enable device */		
+	if (pci_enable_device (pdev)) {
+		rc = -EIO;
+	} else {
+		rc = vortex_probe1 (pdev, pci_resource_start (pdev, 0), pdev->irq,
+				    ent->driver_data, vortex_cards_found);
+		if (rc == 0)
+			vortex_cards_found++;
+	}
 	return rc;
 }
 
@@ -863,7 +868,7 @@
 	struct vortex_private *vp;
 	int option;
 	unsigned int eeprom[0x40], checksum = 0;		/* EEPROM contents */
-	int i;
+	int i, step;
 	struct net_device *dev;
 	static int printed_version;
 	int retval;
@@ -912,12 +917,6 @@
 			vp->must_free_region = 1;
 		}
 
-		/* wake up and enable device */		
-		if (pci_enable_device (pdev)) {
-			retval = -EIO;
-			goto free_region;
-		}
-
 		/* enable bus-mastering if necessary */		
 		if (vci->flags & PCI_USES_MASTER)
 			pci_set_master (pdev);
@@ -1025,6 +1024,13 @@
 			   dev->irq);
 #endif
 
+	EL3WINDOW(4);
+	step = (inb(ioaddr + Wn4_NetDiag) & 0x1e) >> 1;
+	printk(KERN_INFO "  product code '%c%c' rev %02x.%d date %02d-"
+		   "%02d-%02d\n", eeprom[6]&0xff, eeprom[6]>>8, eeprom[0x14],
+		   step, (eeprom[4]>>5) & 15, eeprom[4] & 31, eeprom[4]>>9);
+
+
 	if (pdev && vci->drv_flags & HAS_CB_FNS) {
 		unsigned long fn_st_addr;			/* Cardbus function status space */
 		unsigned short n;
@@ -1148,14 +1154,19 @@
 	return retval;
 }
 
-static void wait_for_completion(struct net_device *dev, int cmd)
+#define wait_for_completion(dev, cmd) _wait_for_completion(dev, cmd, __LINE__)
+
+static void _wait_for_completion(struct net_device *dev, int cmd, int line)
 {
-	int i = 4000;
+	int i;
 
 	outw(cmd, dev->base_addr + EL3_CMD);
-	while (--i > 0) {
-		if (!(inw(dev->base_addr + EL3_STATUS) & CmdInProgress))
+	for (i = 0; i < 4000000; i++) {
+		if (!(inw(dev->base_addr + EL3_STATUS) & CmdInProgress)) {
+			if (i > 1000)
+				printk("wait_for_completion: line=%d, count=%d\n", line, i);
 			return;
+		}
 	}
 	printk(KERN_ERR "%s: command 0x%04x did not complete! Status=0x%x\n",
 			   dev->name, cmd, inw(dev->base_addr + EL3_STATUS));
@@ -1331,6 +1342,7 @@
 	set_rx_mode(dev);
 	outw(StatsEnable, ioaddr + EL3_CMD); /* Turn on statistics. */
 
+//	wait_for_completion(dev, SetTxStart|0x07ff);
 	outw(RxEnable, ioaddr + EL3_CMD); /* Enable the receiver. */
 	outw(TxEnable, ioaddr + EL3_CMD); /* Enable transmitter. */
 	/* Allow status bits to be seen. */
@@ -1663,6 +1675,12 @@
 			   dev->name, fifo_diag);
 		/* Adapter failure requires Tx/Rx reset and reinit. */
 		if (vp->full_bus_master_tx) {
+			int bus_status = inl(ioaddr + PktStatus);
+			/* 0x80000000 PCI master abort. */
+			/* 0x40000000 PCI target abort. */
+			if (vortex_debug)
+				printk(KERN_ERR "%s: PCI bus error, bus status %8.8x\n", dev->name, bus_status);
+
 			/* In this case, blow the card away */
 			vortex_down(dev);
 			wait_for_completion(dev, TotalReset | 0xff);
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
