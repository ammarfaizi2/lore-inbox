Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131934AbRA0K7k>; Sat, 27 Jan 2001 05:59:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132820AbRA0K7a>; Sat, 27 Jan 2001 05:59:30 -0500
Received: from saw.sw.com.sg ([203.120.9.98]:9609 "HELO saw.sw.com.sg")
	by vger.kernel.org with SMTP id <S131934AbRA0K7S>;
	Sat, 27 Jan 2001 05:59:18 -0500
Message-ID: <20010127185902.A6358@saw.sw.com.sg>
Date: Sat, 27 Jan 2001 18:59:02 +0800
From: Andrey Savochkin <saw@saw.sw.com.sg>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org, "David S. Miller" <davem@redhat.com>,
        Alan Cox <alan@redhat.com>
Subject: [patch] eepro100 driver fixes
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Here is a patch with important eepro100 fixes for 2.4 kernel:
 - Big-endian fixes (double cpu->bus conversion).
 - "card reports no resources" hardware timing bug workaround.
   Thanks to Donald Becker.
   It may also fix a problem with "wait_for_cmd_done timeout" symptom.

Best regards
		Andrey

diff -u linux/drivers/net/eepro100.c linux/drivers/net/eepro100.c
--- linux/drivers/net/eepro100.c	2000/11/17 08:53:22
+++ linux/drivers/net/eepro100.c	2001/01/27 10:07:13
@@ -29,7 +29,7 @@
 
 static const char *version =
 "eepro100.c:v1.09j-t 9/29/99 Donald Becker http://cesdis.gsfc.nasa.gov/linux/drivers/eepro100.html\n"
-"eepro100.c: $Revision: 1.35 $ 2000/11/17 Modified by Andrey V. Savochkin <saw@saw.sw.com.sg> and others\n";
+"eepro100.c: $Revision: 1.36 $ 2000/11/17 Modified by Andrey V. Savochkin <saw@saw.sw.com.sg> and others\n";
 
 /* A few user-configurable values that apply to all boards.
    First set is undocumented and spelled per Intel recommendations. */
@@ -698,6 +698,7 @@
 	   This takes less than 10usec and will easily finish before the next
 	   action. */
 	outl(PortReset, ioaddr + SCBPort);
+	inl(ioaddr + SCBPort);
 	udelay(10);
 
 	if (eeprom[3] & 0x0100)
@@ -785,6 +786,7 @@
 #endif  /* kernel_bloat */
 
 	outl(PortReset, ioaddr + SCBPort);
+	inl(ioaddr + SCBPort);
 	udelay(10);
 
 	/* Return the chip to its original power state. */
@@ -801,7 +803,7 @@
 	sp->tx_ring = tx_ring_space;
 	sp->tx_ring_dma = tx_ring_dma;
 	sp->lstats = (struct speedo_stats *)(sp->tx_ring + TX_RING_SIZE);
-	sp->lstats_dma = cpu_to_le32(TX_RING_ELEM_DMA(sp, TX_RING_SIZE));
+	sp->lstats_dma = TX_RING_ELEM_DMA(sp, TX_RING_SIZE);
 	init_timer(&sp->timer); /* used in ioctl() */
 
 	sp->full_duplex = option >= 0 && (option & 0x10) ? 1 : 0;
@@ -1002,7 +1004,9 @@
 	/* Set the segment registers to '0'. */
 	wait_for_cmd_done(ioaddr + SCBCmd);
 	outl(0, ioaddr + SCBPointer);
-	inl(ioaddr + SCBPointer); /* XXX */
+	/* impose a delay to avoid a bug */
+	inl(ioaddr + SCBPointer);
+	udelay(10);
 	outb(RxAddrLoad, ioaddr + SCBCmd);
 	wait_for_cmd_done(ioaddr + SCBCmd);
 	outb(CUCmdBase, ioaddr + SCBCmd);
@@ -1010,7 +1014,6 @@
 	/* Load the statistics block and rx ring addresses. */
 	wait_for_cmd_done(ioaddr + SCBCmd);
 	outl(sp->lstats_dma, ioaddr + SCBPointer);
-	inl(ioaddr + SCBPointer); /* XXX */
 	outb(CUStatsAddr, ioaddr + SCBCmd);
 	sp->lstats->done_marker = 0;
 
@@ -1045,7 +1048,7 @@
 
 	/* Start the chip's Tx process and unmask interrupts. */
 	wait_for_cmd_done(ioaddr + SCBCmd);
-	outl(cpu_to_le32(TX_RING_ELEM_DMA(sp, sp->dirty_tx % TX_RING_SIZE)),
+	outl(TX_RING_ELEM_DMA(sp, sp->dirty_tx % TX_RING_SIZE),
 		 ioaddr + SCBPointer);
 	/* We are not ACK-ing FCP and ER in the interrupt handler yet so they should
 	   remain masked --Dragan */
@@ -1274,7 +1277,7 @@
 		/* Only the command unit has stopped. */
 		printk(KERN_WARNING "%s: Trying to restart the transmitter...\n",
 			   dev->name);
-		outl(cpu_to_le32(TX_RING_ELEM_DMA(sp, dirty_tx % TX_RING_SIZE])),
+		outl(TX_RING_ELEM_DMA(sp, dirty_tx % TX_RING_SIZE]),
 			 ioaddr + SCBPointer);
 		outw(CUStart, ioaddr + SCBCmd);
 		reset_mii(dev);
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
