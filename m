Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129043AbQJ3TbC>; Mon, 30 Oct 2000 14:31:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129450AbQJ3Ta5>; Mon, 30 Oct 2000 14:30:57 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:38151 "EHLO
	havoc.gtf.org") by vger.kernel.org with ESMTP id <S129043AbQJ3Tas>;
	Mon, 30 Oct 2000 14:30:48 -0500
Message-ID: <39FDCC17.4C8B8074@mandrakesoft.com>
Date: Mon, 30 Oct 2000 14:29:27 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Paul Gortmaker <p_gortmaker@yahoo.com>
CC: pavel rabel <pavel@web.sajt.cz>, linux-net@vger.kernel.org,
        netdev@oss.sgi.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [patch] NE2000
In-Reply-To: <Pine.LNX.4.21.0010300344130.6792-100000@web.sajt.cz> <39FC83CD.B10BF08D@mandrakesoft.com> <39FD3CB6.2F641BBF@yahoo.com>
Content-Type: multipart/mixed;
 boundary="------------6333FE7853C048EC25185249"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------6333FE7853C048EC25185249
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Paul Gortmaker wrote:
> There is no urgency in trying to squeeze a patch like this in the back
> door of a 2.4.0 release.  For example, there are people out there now
> who are using the ne.c driver to run both ISA and PCI cards in the same
> box without having to use 2 different drivers.  We can wait until 2.5.0
> to break their .config file.

IMNSHO this is a bug, though...

Do a diff of the key 8390 interface routines in ne.c, and ne2k-pci.c. 
Ignoring the inb_p and outb_p differences, there are distinct advantages
to using ne2k-pci.c on with an NE2000 PCI board.

Since ne2k-pci.c supports all boards ne.c does, and includes some fixes
that ne.c does not, it seems like removing the PCI support in ne.c is a
bug fix change.

It looks like ne2k-pci.c does need a HZ scaling fixing from ne.c
though...

	Jeff



-- 
Jeff Garzik             | "Mind if I drive?"  -Sam
Building 1024           | "Not if you don't mind me clawing at the
MandrakeSoft            |  dash and shrieking like a cheerleader."
                        |                     -Max
--------------6333FE7853C048EC25185249
Content-Type: text/plain; charset=us-ascii;
 name="ne2000.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ne2000.diff"

--- /g/g/tmp/1	Mon Oct 30 14:22:41 2000
+++ /g/g/tmp/2	Mon Oct 30 14:22:58 2000
@@ -1,60 +1,61 @@
 /* Hard reset the card.  This used to pause for the same period that a
    8390 reset command required, but that shouldn't be necessary. */
-
-static void ne_reset_8390(struct net_device *dev)
+static void
+ne2k_pci_reset_8390(struct net_device *dev)
 {
 	unsigned long reset_start_time = jiffies;
 
-	if (ei_debug > 1)
-		printk(KERN_DEBUG "resetting the 8390 t=%ld...", jiffies);
+	if (debug > 1) printk("%s: Resetting the 8390 t=%ld...",
+						  dev->name, jiffies);
 
-	/* DON'T change these to inb_p/outb_p or reset will fail on clones. */
 	outb(inb(NE_BASE + NE_RESET), NE_BASE + NE_RESET);
 
 	ei_status.txing = 0;
 	ei_status.dmaing = 0;
 
 	/* This check _should_not_ be necessary, omit eventually. */
-	while ((inb_p(NE_BASE+EN0_ISR) & ENISR_RESET) == 0)
-		if (jiffies - reset_start_time > 2*HZ/100) {
-			printk(KERN_WARNING "%s: ne_reset_8390() did not complete.\n", dev->name);
+	while ((inb(NE_BASE+EN0_ISR) & ENISR_RESET) == 0)
+		if (jiffies - reset_start_time > 2) {
+			printk("%s: ne2k_pci_reset_8390() did not complete.\n", dev->name);
 			break;
 		}
-	outb_p(ENISR_RESET, NE_BASE + EN0_ISR);	/* Ack intr. */
+	outb(ENISR_RESET, NE_BASE + EN0_ISR);	/* Ack intr. */
 }
 
 /* Grab the 8390 specific header. Similar to the block_input routine, but
    we don't need to be concerned with ring wrap as the header will be at
    the start of a page, so we optimize accordingly. */
 
-static void ne_get_8390_hdr(struct net_device *dev, struct e8390_pkt_hdr *hdr, int ring_page)
+static void
+ne2k_pci_get_8390_hdr(struct net_device *dev, struct e8390_pkt_hdr *hdr, int ring_page)
 {
-	int nic_base = dev->base_addr;
 
-	/* This *shouldn't* happen. If it does, it's the last thing you'll see */
+	long nic_base = dev->base_addr;
 
-	if (ei_status.dmaing) 
-	{
-		printk(KERN_EMERG "%s: DMAing conflict in ne_get_8390_hdr "
+	/* This *shouldn't* happen. If it does, it's the last thing you'll see */
+	if (ei_status.dmaing) {
+		printk("%s: DMAing conflict in ne2k_pci_get_8390_hdr "
 			"[DMAstat:%d][irqlock:%d].\n",
 			dev->name, ei_status.dmaing, ei_status.irqlock);
 		return;
 	}
 
 	ei_status.dmaing |= 0x01;
-	outb_p(E8390_NODMA+E8390_PAGE0+E8390_START, nic_base+ NE_CMD);
-	outb_p(sizeof(struct e8390_pkt_hdr), nic_base + EN0_RCNTLO);
-	outb_p(0, nic_base + EN0_RCNTHI);
-	outb_p(0, nic_base + EN0_RSARLO);		/* On page boundary */
-	outb_p(ring_page, nic_base + EN0_RSARHI);
-	outb_p(E8390_RREAD+E8390_START, nic_base + NE_CMD);
+	outb(E8390_NODMA+E8390_PAGE0+E8390_START, nic_base+ NE_CMD);
+	outb(sizeof(struct e8390_pkt_hdr), nic_base + EN0_RCNTLO);
+	outb(0, nic_base + EN0_RCNTHI);
+	outb(0, nic_base + EN0_RSARLO);		/* On page boundary */
+	outb(ring_page, nic_base + EN0_RSARHI);
+	outb(E8390_RREAD+E8390_START, nic_base + NE_CMD);
 
-	if (ei_status.word16)
+	if (ei_status.ne2k_flags & ONLY_16BIT_IO) {
 		insw(NE_BASE + NE_DATAPORT, hdr, sizeof(struct e8390_pkt_hdr)>>1);
-	else
-		insb(NE_BASE + NE_DATAPORT, hdr, sizeof(struct e8390_pkt_hdr));
+	} else {
+		*(u32*)hdr = le32_to_cpu(inl(NE_BASE + NE_DATAPORT));
+		le16_to_cpus(&hdr->count);
+	}
 
-	outb_p(ENISR_RDC, nic_base + EN0_ISR);	/* Ack intr. */
+	outb(ENISR_RDC, nic_base + EN0_ISR);	/* Ack intr. */
 	ei_status.dmaing &= ~0x01;
 }
 
@@ -63,172 +64,116 @@
    The NEx000 doesn't share the on-board packet memory -- you have to put
    the packet out through the "remote DMA" dataport using outb. */
 
-static void ne_block_input(struct net_device *dev, int count, struct sk_buff *skb, int ring_offset)
+static void
+ne2k_pci_block_input(struct net_device *dev, int count, struct sk_buff *skb, int ring_offset)
 {
-#ifdef NE_SANITY_CHECK
-	int xfer_count = count;
-#endif
-	int nic_base = dev->base_addr;
+	long nic_base = dev->base_addr;
 	char *buf = skb->data;
 
 	/* This *shouldn't* happen. If it does, it's the last thing you'll see */
-	if (ei_status.dmaing) 
-	{
-		printk(KERN_EMERG "%s: DMAing conflict in ne_block_input "
+	if (ei_status.dmaing) {
+		printk("%s: DMAing conflict in ne2k_pci_block_input "
 			"[DMAstat:%d][irqlock:%d].\n",
 			dev->name, ei_status.dmaing, ei_status.irqlock);
 		return;
 	}
 	ei_status.dmaing |= 0x01;
-	outb_p(E8390_NODMA+E8390_PAGE0+E8390_START, nic_base+ NE_CMD);
-	outb_p(count & 0xff, nic_base + EN0_RCNTLO);
-	outb_p(count >> 8, nic_base + EN0_RCNTHI);
-	outb_p(ring_offset & 0xff, nic_base + EN0_RSARLO);
-	outb_p(ring_offset >> 8, nic_base + EN0_RSARHI);
-	outb_p(E8390_RREAD+E8390_START, nic_base + NE_CMD);
-	if (ei_status.word16) 
-	{
+	if (ei_status.ne2k_flags & ONLY_32BIT_IO)
+		count = (count + 3) & 0xFFFC;
+	outb(E8390_NODMA+E8390_PAGE0+E8390_START, nic_base+ NE_CMD);
+	outb(count & 0xff, nic_base + EN0_RCNTLO);
+	outb(count >> 8, nic_base + EN0_RCNTHI);
+	outb(ring_offset & 0xff, nic_base + EN0_RSARLO);
+	outb(ring_offset >> 8, nic_base + EN0_RSARHI);
+	outb(E8390_RREAD+E8390_START, nic_base + NE_CMD);
+
+	if (ei_status.ne2k_flags & ONLY_16BIT_IO) {
 		insw(NE_BASE + NE_DATAPORT,buf,count>>1);
-		if (count & 0x01) 
-		{
+		if (count & 0x01) {
 			buf[count-1] = inb(NE_BASE + NE_DATAPORT);
-#ifdef NE_SANITY_CHECK
-			xfer_count++;
-#endif
 		}
 	} else {
-		insb(NE_BASE + NE_DATAPORT, buf, count);
+		insl(NE_BASE + NE_DATAPORT, buf, count>>2);
+		if (count & 3) {
+			buf += count & ~3;
+			if (count & 2)
+				*((u16*)buf)++ = le16_to_cpu(inw(NE_BASE + NE_DATAPORT));
+			if (count & 1)
+				*buf = inb(NE_BASE + NE_DATAPORT);
 	}
-
-#ifdef NE_SANITY_CHECK
-	/* This was for the ALPHA version only, but enough people have
-	   been encountering problems so it is still here.  If you see
-	   this message you either 1) have a slightly incompatible clone
-	   or 2) have noise/speed problems with your bus. */
-
-	if (ei_debug > 1) 
-	{
-		/* DMA termination address check... */
-		int addr, tries = 20;
-		do {
-			/* DON'T check for 'inb_p(EN0_ISR) & ENISR_RDC' here
-			   -- it's broken for Rx on some cards! */
-			int high = inb_p(nic_base + EN0_RSARHI);
-			int low = inb_p(nic_base + EN0_RSARLO);
-			addr = (high << 8) + low;
-			if (((ring_offset + xfer_count) & 0xff) == low)
-				break;
-		} while (--tries > 0);
-	 	if (tries <= 0)
-			printk(KERN_WARNING "%s: RX transfer address mismatch,"
-				"%#4.4x (expected) vs. %#4.4x (actual).\n",
-				dev->name, ring_offset + xfer_count, addr);
 	}
-#endif
-	outb_p(ENISR_RDC, nic_base + EN0_ISR);	/* Ack intr. */
+
+	outb(ENISR_RDC, nic_base + EN0_ISR);	/* Ack intr. */
 	ei_status.dmaing &= ~0x01;
 }
 
-static void ne_block_output(struct net_device *dev, int count,
+static void
+ne2k_pci_block_output(struct net_device *dev, int count,
 		const unsigned char *buf, const int start_page)
 {
-	int nic_base = NE_BASE;
+	long nic_base = NE_BASE;
 	unsigned long dma_start;
-#ifdef NE_SANITY_CHECK
-	int retries = 0;
-#endif
 
-	/* Round the count up for word writes.  Do we need to do this?
-	   What effect will an odd byte count have on the 8390?
-	   I should check someday. */
-	   
-	if (ei_status.word16 && (count & 0x01))
+	/* On little-endian it's always safe to round the count up for
+	   word writes. */
+	if (ei_status.ne2k_flags & ONLY_32BIT_IO)
+		count = (count + 3) & 0xFFFC;
+	else
+		if (count & 0x01)
 		count++;
 
 	/* This *shouldn't* happen. If it does, it's the last thing you'll see */
-	if (ei_status.dmaing) 
-	{
-		printk(KERN_EMERG "%s: DMAing conflict in ne_block_output."
+	if (ei_status.dmaing) {
+		printk("%s: DMAing conflict in ne2k_pci_block_output."
 			"[DMAstat:%d][irqlock:%d]\n",
 			dev->name, ei_status.dmaing, ei_status.irqlock);
 		return;
 	}
 	ei_status.dmaing |= 0x01;
 	/* We should already be in page 0, but to be safe... */
-	outb_p(E8390_PAGE0+E8390_START+E8390_NODMA, nic_base + NE_CMD);
-
-#ifdef NE_SANITY_CHECK
-retry:
-#endif
+	outb(E8390_PAGE0+E8390_START+E8390_NODMA, nic_base + NE_CMD);
 
 #ifdef NE8390_RW_BUGFIX
 	/* Handle the read-before-write bug the same way as the
 	   Crynwr packet driver -- the NatSemi method doesn't work.
 	   Actually this doesn't always work either, but if you have
 	   problems with your NEx000 this is better than nothing! */
-	   
-	outb_p(0x42, nic_base + EN0_RCNTLO);
-	outb_p(0x00,   nic_base + EN0_RCNTHI);
-	outb_p(0x42, nic_base + EN0_RSARLO);
-	outb_p(0x00, nic_base + EN0_RSARHI);
-	outb_p(E8390_RREAD+E8390_START, nic_base + NE_CMD);
-	/* Make certain that the dummy read has occurred. */
-	udelay(6);
+	outb(0x42, nic_base + EN0_RCNTLO);
+	outb(0x00, nic_base + EN0_RCNTHI);
+	outb(0x42, nic_base + EN0_RSARLO);
+	outb(0x00, nic_base + EN0_RSARHI);
+	outb(E8390_RREAD+E8390_START, nic_base + NE_CMD);
 #endif
-
-	outb_p(ENISR_RDC, nic_base + EN0_ISR);
+	outb(ENISR_RDC, nic_base + EN0_ISR);
 
 	/* Now the normal output. */
-	outb_p(count & 0xff, nic_base + EN0_RCNTLO);
-	outb_p(count >> 8,   nic_base + EN0_RCNTHI);
-	outb_p(0x00, nic_base + EN0_RSARLO);
-	outb_p(start_page, nic_base + EN0_RSARHI);
-
-	outb_p(E8390_RWRITE+E8390_START, nic_base + NE_CMD);
-	if (ei_status.word16) {
+	outb(count & 0xff, nic_base + EN0_RCNTLO);
+	outb(count >> 8,   nic_base + EN0_RCNTHI);
+	outb(0x00, nic_base + EN0_RSARLO);
+	outb(start_page, nic_base + EN0_RSARHI);
+	outb(E8390_RWRITE+E8390_START, nic_base + NE_CMD);
+	if (ei_status.ne2k_flags & ONLY_16BIT_IO) {
 		outsw(NE_BASE + NE_DATAPORT, buf, count>>1);
 	} else {
-		outsb(NE_BASE + NE_DATAPORT, buf, count);
+		outsl(NE_BASE + NE_DATAPORT, buf, count>>2);
+		if (count & 3) {
+			buf += count & ~3;
+			if (count & 2)
+				outw(cpu_to_le16(*((u16*)buf)++), NE_BASE + NE_DATAPORT);
+		}
 	}
 
 	dma_start = jiffies;
 
-#ifdef NE_SANITY_CHECK
-	/* This was for the ALPHA version only, but enough people have
-	   been encountering problems so it is still here. */
-	
-	if (ei_debug > 1) 
-	{
-		/* DMA termination address check... */
-		int addr, tries = 20;
-		do {
-			int high = inb_p(nic_base + EN0_RSARHI);
-			int low = inb_p(nic_base + EN0_RSARLO);
-			addr = (high << 8) + low;
-			if ((start_page << 8) + count == addr)
-				break;
-		} while (--tries > 0);
-
-		if (tries <= 0) 
-		{
-			printk(KERN_WARNING "%s: Tx packet transfer address mismatch,"
-				"%#4.4x (expected) vs. %#4.4x (actual).\n",
-				dev->name, (start_page << 8) + count, addr);
-			if (retries++ == 0)
-				goto retry;
-		}
-	}
-#endif
-
-	while ((inb_p(nic_base + EN0_ISR) & ENISR_RDC) == 0)
-		if (jiffies - dma_start > 2*HZ/100) {		/* 20ms */
-			printk(KERN_WARNING "%s: timeout waiting for Tx RDC.\n", dev->name);
-			ne_reset_8390(dev);
+	while ((inb(nic_base + EN0_ISR) & ENISR_RDC) == 0)
+		if (jiffies - dma_start > 2) { 			/* Avoid clock roll-over. */
+			printk("%s: timeout waiting for Tx RDC.\n", dev->name);
+			ne2k_pci_reset_8390(dev);
 			NS8390_init(dev,1);
 			break;
 		}
 
-	outb_p(ENISR_RDC, nic_base + EN0_ISR);	/* Ack intr. */
+	outb(ENISR_RDC, nic_base + EN0_ISR);	/* Ack intr. */
 	ei_status.dmaing &= ~0x01;
 	return;
 }

--------------6333FE7853C048EC25185249--

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
