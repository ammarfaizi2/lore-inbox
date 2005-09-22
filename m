Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030366AbVIVVUH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030366AbVIVVUH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Sep 2005 17:20:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030368AbVIVVUH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Sep 2005 17:20:07 -0400
Received: from havoc.gtf.org ([69.61.125.42]:17545 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S1030366AbVIVVUE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Sep 2005 17:20:04 -0400
Date: Thu, 22 Sep 2005 17:20:02 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org
Subject: [PATCH] remove some more check_region stuff
Message-ID: <20050922212002.GA15770@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Removed some more references to check_region().

I checked these changes into the 'checkreg' branch of
rsync://rsync.kernel.org/pub/scm/linux/kernel/git/jgarzik/misc-2.6.git

The only valid references remaining are in:
drivers/scsi/advansys.c
drivers/scsi/BusLogic.c
drivers/cdrom/sbpcd.c
sound/oss/pss.c

Patch included since kernel.org mirroring is taking >24 hours currently.



 Documentation/i2c/writing-clients |    1 
 arch/ppc/platforms/hdpu.c         |    5 
 arch/sparc/kernel/pcic.c          |    4 
 drivers/char/specialix.c          |  342 ++++++++++++++++++--------------------
 drivers/net/eepro.c               |   50 ++---
 include/asm-m68k/sun3xflop.h      |    2 
 include/asm-m68knommu/ide.h       |    7 
 include/asm-parisc/ide.h          |    1 
 include/asm-sparc/floppy.h        |    2 
 sound/oss/cs4232.c                |    6 
 sound/oss/wavfront.c              |   38 +++-
 11 files changed, 230 insertions(+), 228 deletions(-)


Jeff Garzik:
  Remove last vestiges of ide_check_region()
  drivers/char/specialix: trim trailing whitespace
  drivers/char/specialix: eliminate use of check_region()
  Remove outdated and unused references to check_region()
  [sound oss] remove check_region() usage from cs4232, wavfront
  [netdrvr eepro] trim trailing whitespace
  [netdrvr eepro] remove check_region() usage


diff --git a/Documentation/i2c/writing-clients b/Documentation/i2c/writing-clients
--- a/Documentation/i2c/writing-clients
+++ b/Documentation/i2c/writing-clients
@@ -275,6 +275,7 @@ For now, you can ignore the `flags' para
     if (is_isa) {
 
       /* Discard immediately if this ISA range is already used */
+      /* FIXME: never use check_region(), only request_region() */
       if (check_region(address,FOO_EXTENT))
         goto ERROR0;
 
diff --git a/arch/ppc/platforms/hdpu.c b/arch/ppc/platforms/hdpu.c
--- a/arch/ppc/platforms/hdpu.c
+++ b/arch/ppc/platforms/hdpu.c
@@ -609,11 +609,6 @@ static void parse_bootinfo(unsigned long
 }
 
 #if defined(CONFIG_BLK_DEV_IDE) || defined(CONFIG_BLK_DEV_IDE_MODULE)
-static int hdpu_ide_check_region(ide_ioreg_t from, unsigned int extent)
-{
-	return check_region(from, extent);
-}
-
 static void
 hdpu_ide_request_region(ide_ioreg_t from, unsigned int extent, const char *name)
 {
diff --git a/arch/sparc/kernel/pcic.c b/arch/sparc/kernel/pcic.c
--- a/arch/sparc/kernel/pcic.c
+++ b/arch/sparc/kernel/pcic.c
@@ -497,8 +497,8 @@ static void pcic_map_pci_device(struct l
 				 * CheerIO makes a similar conversion.
 				 * See ebus.c for details.
 				 *
-				 * Note that check_region()/request_region()
-				 * work for these devices.
+				 * Note that request_region()
+				 * works for these devices.
 				 *
 				 * XXX Neat trick, but it's a *bad* idea
 				 * to shit into regions like that.
diff --git a/drivers/char/specialix.c b/drivers/char/specialix.c
--- a/drivers/char/specialix.c
+++ b/drivers/char/specialix.c
@@ -38,19 +38,19 @@
  *
  * Revision 1.0:  April 1st 1997.
  *                Initial release for alpha testing.
- * Revision 1.1:  April 14th 1997. 
- *                Incorporated Richard Hudsons suggestions, 
+ * Revision 1.1:  April 14th 1997.
+ *                Incorporated Richard Hudsons suggestions,
  *                removed some debugging printk's.
  * Revision 1.2:  April 15th 1997.
  *                Ported to 2.1.x kernels.
- * Revision 1.3:  April 17th 1997 
- *                Backported to 2.0. (Compatibility macros). 
+ * Revision 1.3:  April 17th 1997
+ *                Backported to 2.0. (Compatibility macros).
  * Revision 1.4:  April 18th 1997
- *                Fixed DTR/RTS bug that caused the card to indicate 
- *                "don't send data" to a modem after the password prompt.  
+ *                Fixed DTR/RTS bug that caused the card to indicate
+ *                "don't send data" to a modem after the password prompt.
  *                Fixed bug for premature (fake) interrupts.
  * Revision 1.5:  April 19th 1997
- *                fixed a minor typo in the header file, cleanup a little. 
+ *                fixed a minor typo in the header file, cleanup a little.
  *                performance warnings are now MAXed at once per minute.
  * Revision 1.6:  May 23 1997
  *                Changed the specialix=... format to include interrupt.
@@ -60,10 +60,10 @@
  *                port to linux-2.1.43 kernel.
  * Revision 1.9:  Oct 9  1998
  *                Added stuff for the IO8+/PCI version.
- * Revision 1.10: Oct 22  1999 / Jan 21 2000. 
- *                Added stuff for setserial. 
+ * Revision 1.10: Oct 22  1999 / Jan 21 2000.
+ *                Added stuff for setserial.
  *                Nicolas Mailhot (Nicolas.Mailhot@email.enst.fr)
- * 
+ *
  */
 
 #define VERSION "1.11"
@@ -154,7 +154,7 @@ static int sx_poll = HZ;
 
 
 
-/* 
+/*
  * The following defines are mostly for testing purposes. But if you need
  * some nice reporting in your syslog, you can define them also.
  */
@@ -188,7 +188,7 @@ static DECLARE_MUTEX(tmp_buf_sem);
 
 static unsigned long baud_table[] =  {
 	0, 50, 75, 110, 134, 150, 200, 300, 600, 1200, 1800, 2400, 4800,
-	9600, 19200, 38400, 57600, 115200, 0, 
+	9600, 19200, 38400, 57600, 115200, 0,
 };
 
 static struct specialix_board sx_board[SX_NBOARD] =  {
@@ -216,7 +216,7 @@ static inline int sx_paranoia_check(stru
 		KERN_ERR "sx: Warning: bad specialix port magic number for device %s in %s\n";
 	static const char *badinfo =
 		KERN_ERR "sx: Warning: null specialix port for device %s in %s\n";
- 
+
 	if (!port) {
 		printk(badinfo, name, routine);
 		return 1;
@@ -231,9 +231,9 @@ static inline int sx_paranoia_check(stru
 
 
 /*
- * 
+ *
  *  Service functions for specialix IO8+ driver.
- * 
+ *
  */
 
 /* Get board number from pointer */
@@ -246,7 +246,7 @@ static inline int board_No (struct speci
 /* Get port number from pointer */
 static inline int port_No (struct specialix_port const * port)
 {
-	return SX_PORT(port - sx_port); 
+	return SX_PORT(port - sx_port);
 }
 
 
@@ -309,7 +309,7 @@ static inline void sx_wait_CCR(struct sp
 			return;
 		udelay (1);
 	}
-	
+
 	printk(KERN_ERR "sx%d: Timeout waiting for CCR.\n", board_No(bp));
 }
 
@@ -329,7 +329,7 @@ static inline void sx_wait_CCR_off(struc
 			return;
 		udelay (1);
 	}
-	
+
 	printk(KERN_ERR "sx%d: Timeout waiting for CCR.\n", board_No(bp));
 }
 
@@ -338,34 +338,28 @@ static inline void sx_wait_CCR_off(struc
  *  specialix IO8+ IO range functions.
  */
 
-static inline int sx_check_io_range(struct specialix_board * bp)
+static inline int sx_request_io_range(struct specialix_board * bp)
 {
-	return check_region (bp->base, SX_IO_SPACE);
-}
-
-
-static inline void sx_request_io_range(struct specialix_board * bp)
-{
-	request_region(bp->base, 
-	               bp->flags&SX_BOARD_IS_PCI?SX_PCI_IO_SPACE:SX_IO_SPACE,
-	               "specialix IO8+" );
+	return request_region(bp->base,
+		bp->flags & SX_BOARD_IS_PCI ? SX_PCI_IO_SPACE : SX_IO_SPACE,
+		"specialix IO8+") == NULL;
 }
 
 
 static inline void sx_release_io_range(struct specialix_board * bp)
 {
-	release_region(bp->base, 
+	release_region(bp->base,
 	               bp->flags&SX_BOARD_IS_PCI?SX_PCI_IO_SPACE:SX_IO_SPACE);
 }
 
-	
+
 /* Must be called with enabled interrupts */
-/* Ugly. Very ugly. Don't use this for anything else than initialization 
+/* Ugly. Very ugly. Don't use this for anything else than initialization
    code */
 static inline void sx_long_delay(unsigned long delay)
 {
 	unsigned long i;
-	
+
 	for (i = jiffies + delay; time_after(i, jiffies); ) ;
 }
 
@@ -378,7 +372,7 @@ static int sx_set_irq ( struct specialix
 	int i;
 	unsigned long flags;
 
-	if (bp->flags & SX_BOARD_IS_PCI) 
+	if (bp->flags & SX_BOARD_IS_PCI)
 		return 1;
 	switch (bp->irq) {
 	/* In the same order as in the docs... */
@@ -420,7 +414,7 @@ static int sx_init_CD186x(struct special
 	sx_out_off(bp, CD186x_PILR3, SX_ACK_RINT);      /* Prio for receiver intr    */
 	/* Set RegAckEn */
 	sx_out_off(bp, CD186x_SRCR, sx_in (bp, CD186x_SRCR) | SRCR_REGACKEN);
-	
+
 	/* Setting up prescaler. We need 4 ticks per 1 ms */
 	scaler =  SX_OSCFREQ/SPECIALIX_TPS;
 
@@ -448,7 +442,7 @@ static int read_cross_byte (struct speci
 	spin_lock_irqsave(&bp->lock, flags);
 	for (i=0, t=0;i<8;i++) {
 		sx_out_off (bp, CD186x_CAR, i);
-		if (sx_in_off (bp, reg) & bit) 
+		if (sx_in_off (bp, reg) & bit)
 			t |= 1 << i;
 	}
 	spin_unlock_irqrestore(&bp->lock, flags);
@@ -472,7 +466,7 @@ void missed_irq (unsigned long data)
 	spin_unlock_irqrestore(&bp->lock, flags);
 	if (irq) {
 		printk (KERN_INFO "Missed interrupt... Calling int from timer. \n");
-		sx_interrupt (((struct specialix_board *)data)->irq, 
+		sx_interrupt (((struct specialix_board *)data)->irq,
 		              (void*)data, NULL);
 	}
 	missed_irq_timer.expires = jiffies + sx_poll;
@@ -495,7 +489,7 @@ static int sx_probe(struct specialix_boa
 
 	func_enter();
 
-	if (sx_check_io_range(bp)) {
+	if (sx_request_io_range(bp)) {
 		func_exit();
 		return 1;
 	}
@@ -509,15 +503,16 @@ static int sx_probe(struct specialix_boa
 	short_pause ();
 	val2 = sx_in_off(bp, CD186x_PPRL);
 
-	
+
 	if ((val1 != 0x5a) || (val2 != 0xa5)) {
 		printk(KERN_INFO "sx%d: specialix IO8+ Board at 0x%03x not found.\n",
 		       board_No(bp), bp->base);
+		sx_release_io_range(bp);
 		func_exit();
 		return 1;
 	}
 
-	/* Check the DSR lines that Specialix uses as board 
+	/* Check the DSR lines that Specialix uses as board
 	   identification */
 	val1 = read_cross_byte (bp, CD186x_MSVR, MSVR_DSR);
 	val2 = read_cross_byte (bp, CD186x_MSVR, MSVR_RTS);
@@ -532,6 +527,7 @@ static int sx_probe(struct specialix_boa
 	if (val1 != val2) {
 		printk(KERN_INFO "sx%d: specialix IO8+ ID %02x at 0x%03x not found (%02x).\n",
 		       board_No(bp), val2, bp->base, val1);
+		sx_release_io_range(bp);
 		func_exit();
 		return 1;
 	}
@@ -546,7 +542,7 @@ static int sx_probe(struct specialix_boa
 		sx_wait_CCR(bp);
 		sx_out(bp, CD186x_CCR, CCR_TXEN);        /* Enable transmitter     */
 		sx_out(bp, CD186x_IER, IER_TXRDY);       /* Enable tx empty intr   */
-		sx_long_delay(HZ/20);	       		
+		sx_long_delay(HZ/20);
 		irqs = probe_irq_off(irqs);
 
 		dprintk (SX_DEBUG_INIT, "SRSR = %02x, ", sx_in(bp, CD186x_SRSR));
@@ -561,14 +557,15 @@ static int sx_probe(struct specialix_boa
 		}
 
 		dprintk (SX_DEBUG_INIT "val1 = %02x, val2 = %02x, val3 = %02x.\n",
-		        val1, val2, val3); 
-	
+		        val1, val2, val3);
+
 	}
-	
+
 #if 0
 	if (irqs <= 0) {
 		printk(KERN_ERR "sx%d: Can't find IRQ for specialix IO8+ board at 0x%03x.\n",
 		       board_No(bp), bp->base);
+		sx_release_io_range(bp);
 		func_exit();
 		return 1;
 	}
@@ -579,19 +576,20 @@ static int sx_probe(struct specialix_boa
 #endif
 	/* Reset CD186x again  */
 	if (!sx_init_CD186x(bp)) {
+		sx_release_io_range(bp);
 		func_exit();
-		return -EIO;
+		return 1;
 	}
 
 	sx_request_io_range(bp);
 	bp->flags |= SX_BOARD_PRESENT;
-	
+
 	/* Chip           revcode   pkgtype
 	                  GFRCR     SRCR bit 7
 	   CD180 rev B    0x81      0
 	   CD180 rev C    0x82      0
 	   CD1864 rev A   0x82      1
-	   CD1865 rev A   0x83      1  -- Do not use!!! Does not work. 
+	   CD1865 rev A   0x83      1  -- Do not use!!! Does not work.
 	   CD1865 rev B   0x84      1
 	 -- Thanks to Gwen Wang, Cirrus Logic.
 	 */
@@ -623,8 +621,8 @@ static int sx_probe(struct specialix_boa
 	return 0;
 }
 
-/* 
- * 
+/*
+ *
  *  Interrupt processing routines.
  * */
 
@@ -657,7 +655,7 @@ static inline struct specialix_port * sx
 			return port;
 		}
 	}
-	printk(KERN_INFO "sx%d: %s interrupt from invalid port %d\n", 
+	printk(KERN_INFO "sx%d: %s interrupt from invalid port %d\n",
 	       board_No(bp), what, channel);
 	return NULL;
 }
@@ -681,7 +679,7 @@ static inline void sx_receive_exc(struct
 	tty = port->tty;
 	dprintk (SX_DEBUG_RX, "port: %p count: %d BUFF_SIZE: %d\n",
 		 port,  tty->flip.count, TTY_FLIPBUF_SIZE);
-	
+
 	status = sx_in(bp, CD186x_RCSR);
 
 	dprintk (SX_DEBUG_RX, "status: 0x%x\n", status);
@@ -707,30 +705,30 @@ static inline void sx_receive_exc(struct
 		return;
 	}
 	if (status & RCSR_TOUT) {
-		printk(KERN_INFO "sx%d: port %d: Receiver timeout. Hardware problems ?\n", 
+		printk(KERN_INFO "sx%d: port %d: Receiver timeout. Hardware problems ?\n",
 		       board_No(bp), port_No(port));
 		func_exit();
 		return;
-		
+
 	} else if (status & RCSR_BREAK) {
 		dprintk(SX_DEBUG_RX, "sx%d: port %d: Handling break...\n",
 		       board_No(bp), port_No(port));
 		*tty->flip.flag_buf_ptr++ = TTY_BREAK;
 		if (port->flags & ASYNC_SAK)
 			do_SAK(tty);
-		
-	} else if (status & RCSR_PE) 
+
+	} else if (status & RCSR_PE)
 		*tty->flip.flag_buf_ptr++ = TTY_PARITY;
-	
-	else if (status & RCSR_FE) 
+
+	else if (status & RCSR_FE)
 		*tty->flip.flag_buf_ptr++ = TTY_FRAME;
-	
+
 	else if (status & RCSR_OE)
 		*tty->flip.flag_buf_ptr++ = TTY_OVERRUN;
-	
+
 	else
 		*tty->flip.flag_buf_ptr++ = 0;
-	
+
 	*tty->flip.char_buf_ptr++ = ch;
 	tty->flip.count++;
 	schedule_delayed_work(&tty->flip.work, 1);
@@ -746,18 +744,18 @@ static inline void sx_receive(struct spe
 	unsigned char count;
 
 	func_enter();
-	
+
 	if (!(port = sx_get_port(bp, "Receive"))) {
 		dprintk (SX_DEBUG_RX, "Hmm, couldn't find port.\n");
 		func_exit();
 		return;
 	}
 	tty = port->tty;
-	
+
 	count = sx_in(bp, CD186x_RDCR);
 	dprintk (SX_DEBUG_RX, "port: %p: count: %d\n", port, count);
 	port->hits[count > 8 ? 9 : count]++;
-	
+
 	while (count--) {
 		if (tty->flip.count >= TTY_FLIPBUF_SIZE) {
 			printk(KERN_INFO "sx%d: port %d: Working around flip buffer overflow.\n",
@@ -787,7 +785,7 @@ static inline void sx_transmit(struct sp
 	}
 	dprintk (SX_DEBUG_TX, "port: %p\n", port);
 	tty = port->tty;
-	
+
 	if (port->IER & IER_TXEMPTY) {
 		/* FIFO drained */
 		sx_out(bp, CD186x_CAR, port_No(port));
@@ -796,7 +794,7 @@ static inline void sx_transmit(struct sp
 		func_exit();
 		return;
 	}
-	
+
 	if ((port->xmit_cnt <= 0 && !port->break_length)
 	    || tty->stopped || tty->hw_stopped) {
 		sx_out(bp, CD186x_CAR, port_No(port));
@@ -805,7 +803,7 @@ static inline void sx_transmit(struct sp
 		func_exit();
 		return;
 	}
-	
+
 	if (port->break_length) {
 		if (port->break_length > 0) {
 			if (port->COR2 & COR2_ETC) {
@@ -831,7 +829,7 @@ static inline void sx_transmit(struct sp
 		func_exit();
 		return;
 	}
-	
+
 	count = CD186x_NFIFO;
 	do {
 		sx_out(bp, CD186x_TDR, port->xmit_buf[port->xmit_tail++]);
@@ -839,7 +837,7 @@ static inline void sx_transmit(struct sp
 		if (--port->xmit_cnt <= 0)
 			break;
 	} while (--count > 0);
-	
+
 	if (port->xmit_cnt <= 0) {
 		sx_out(bp, CD186x_CAR, port_No(port));
 		port->IER &= ~IER_TXRDY;
@@ -862,9 +860,9 @@ static inline void sx_check_modem(struct
 	dprintk (SX_DEBUG_SIGNALS, "Modem intr. ");
 	if (!(port = sx_get_port(bp, "Modem")))
 		return;
-	
+
 	tty = port->tty;
-	
+
 	mcr = sx_in(bp, CD186x_MCR);
 	printk ("mcr = %02x.\n", mcr);
 
@@ -879,7 +877,7 @@ static inline void sx_check_modem(struct
 			schedule_work(&port->tqueue_hangup);
 		}
 	}
-	
+
 #ifdef SPECIALIX_BRAIN_DAMAGED_CTS
 	if (mcr & MCR_CTSCHG) {
 		if (sx_in(bp, CD186x_MSVR) & MSVR_CTS) {
@@ -906,7 +904,7 @@ static inline void sx_check_modem(struct
 		sx_out(bp, CD186x_IER, port->IER);
 	}
 #endif /* SPECIALIX_BRAIN_DAMAGED_CTS */
-	
+
 	/* Clear change bits */
 	sx_out(bp, CD186x_MCR, 0);
 }
@@ -940,7 +938,7 @@ static irqreturn_t sx_interrupt(int irq,
 	while ((++loop < 16) && (status = (sx_in(bp, CD186x_SRSR) &
 	                                   (SRSR_RREQint |
 		                            SRSR_TREQint |
-	                                    SRSR_MREQint)))) {	
+	                                    SRSR_MREQint)))) {
 		if (status & SRSR_RREQint) {
 			ack = sx_in(bp, CD186x_RRAR);
 
@@ -951,7 +949,7 @@ static irqreturn_t sx_interrupt(int irq,
 			else
 				printk(KERN_ERR "sx%d: status: 0x%x Bad receive ack 0x%02x.\n",
 				       board_No(bp), status, ack);
-		
+
 		} else if (status & SRSR_TREQint) {
 			ack = sx_in(bp, CD186x_TRAR);
 
@@ -963,13 +961,13 @@ static irqreturn_t sx_interrupt(int irq,
 		} else if (status & SRSR_MREQint) {
 			ack = sx_in(bp, CD186x_MRAR);
 
-			if (ack == (SX_ID | GIVR_IT_MODEM)) 
+			if (ack == (SX_ID | GIVR_IT_MODEM))
 				sx_check_modem(bp);
 			else
 				printk(KERN_ERR "sx%d: status: 0x%x Bad modem ack 0x%02x.\n",
 				       board_No(bp), status, ack);
-		
-		} 
+
+		}
 
 		sx_out(bp, CD186x_EOIR, 0);   /* Mark end of interrupt */
 	}
@@ -1026,7 +1024,7 @@ static inline int sx_setup_board(struct 
 {
 	int error;
 
-	if (bp->flags & SX_BOARD_ACTIVE) 
+	if (bp->flags & SX_BOARD_ACTIVE)
 		return 0;
 
 	if (bp->flags & SX_BOARD_IS_PCI)
@@ -1034,7 +1032,7 @@ static inline int sx_setup_board(struct 
 	else
 		error = request_irq(bp->irq, sx_interrupt, SA_INTERRUPT, "specialix IO8+", bp);
 
-	if (error) 
+	if (error)
 		return error;
 
 	turn_ints_on (bp);
@@ -1055,7 +1053,7 @@ static inline void sx_shutdown_board(str
 	}
 
 	bp->flags &= ~SX_BOARD_ACTIVE;
-	
+
 	dprintk (SX_DEBUG_IRQ, "Freeing IRQ%d for board %d.\n",
 		 bp->irq, board_No (bp));
 	free_irq(bp->irq, bp);
@@ -1068,7 +1066,7 @@ static inline void sx_shutdown_board(str
 
 
 /*
- * Setting up port characteristics. 
+ * Setting up port characteristics.
  * Must be called with disabled interrupts
  */
 static void sx_change_speed(struct specialix_board *bp, struct specialix_port *port)
@@ -1103,10 +1101,10 @@ static void sx_change_speed(struct speci
 	spin_unlock_irqrestore(&bp->lock, flags);
 	dprintk (SX_DEBUG_TERMIOS, "sx: got MSVR=%02x.\n", port->MSVR);
 	baud = C_BAUD(tty);
-	
+
 	if (baud & CBAUDEX) {
 		baud &= ~CBAUDEX;
-		if (baud < 1 || baud > 2) 
+		if (baud < 1 || baud > 2)
 			port->tty->termios->c_cflag &= ~CBAUDEX;
 		else
 			baud += 15;
@@ -1117,8 +1115,8 @@ static void sx_change_speed(struct speci
 		if ((port->flags & ASYNC_SPD_MASK) == ASYNC_SPD_VHI)
 			baud += 2;
 	}
-	
-	
+
+
 	if (!baud_table[baud]) {
 		/* Drop DTR & exit */
 		dprintk (SX_DEBUG_TERMIOS, "Dropping DTR...  Hmm....\n");
@@ -1127,7 +1125,7 @@ static void sx_change_speed(struct speci
 			spin_lock_irqsave(&bp->lock, flags);
 			sx_out(bp, CD186x_MSVR, port->MSVR );
 			spin_unlock_irqrestore(&bp->lock, flags);
-		} 
+		}
 		else
 			dprintk (SX_DEBUG_TERMIOS, "Can't drop DTR: no DTR.\n");
 		return;
@@ -1137,9 +1135,9 @@ static void sx_change_speed(struct speci
 			port ->MSVR |= MSVR_DTR;
 		}
 	}
-	
+
 	/*
-	 * Now we must calculate some speed depended things 
+	 * Now we must calculate some speed depended things
 	 */
 
 	/* Set baud rate for port */
@@ -1152,7 +1150,7 @@ static void sx_change_speed(struct speci
 		tmp = (((SX_OSCFREQ + baud_table[baud]/2) / baud_table[baud] +
 		         CD186x_TPC/2) / CD186x_TPC);
 
-	if ((tmp < 0x10) && time_before(again, jiffies)) { 
+	if ((tmp < 0x10) && time_before(again, jiffies)) {
 		again = jiffies + HZ * 60;
 		/* Page 48 of version 2.0 of the CL-CD1865 databook */
 		if (tmp >= 12) {
@@ -1164,27 +1162,27 @@ static void sx_change_speed(struct speci
 			printk (KERN_INFO "sx%d: Baud rate divisor is %ld. \n"
 			        "Warning: overstressing Cirrus chip. "
 			        "This might not work.\n"
-			        "Read specialix.txt for more info.\n", 
+			        "Read specialix.txt for more info.\n",
 			        port_No (port), tmp);
 		}
 	}
 	spin_lock_irqsave(&bp->lock, flags);
-	sx_out(bp, CD186x_RBPRH, (tmp >> 8) & 0xff); 
-	sx_out(bp, CD186x_TBPRH, (tmp >> 8) & 0xff); 
-	sx_out(bp, CD186x_RBPRL, tmp & 0xff); 
+	sx_out(bp, CD186x_RBPRH, (tmp >> 8) & 0xff);
+	sx_out(bp, CD186x_TBPRH, (tmp >> 8) & 0xff);
+	sx_out(bp, CD186x_RBPRL, tmp & 0xff);
 	sx_out(bp, CD186x_TBPRL, tmp & 0xff);
 	spin_unlock_irqrestore(&bp->lock, flags);
 	if (port->custom_divisor) {
 		baud = (SX_OSCFREQ + port->custom_divisor/2) / port->custom_divisor;
 		baud = ( baud + 5 ) / 10;
-	} else 
+	} else
 		baud = (baud_table[baud] + 5) / 10;   /* Estimated CPS */
 
 	/* Two timer ticks seems enough to wakeup something like SLIP driver */
-	tmp = ((baud + HZ/2) / HZ) * 2 - CD186x_NFIFO;		
+	tmp = ((baud + HZ/2) / HZ) * 2 - CD186x_NFIFO;
 	port->wakeup_chars = (tmp < 0) ? 0 : ((tmp >= SERIAL_XMIT_SIZE) ?
 					      SERIAL_XMIT_SIZE - 1 : tmp);
-	
+
 	/* Receiver timeout will be transmission time for 1.5 chars */
 	tmp = (SPECIALIX_TPS + SPECIALIX_TPS/2 + baud/2) / baud;
 	tmp = (tmp > 0xff) ? 0xff : tmp;
@@ -1205,29 +1203,29 @@ static void sx_change_speed(struct speci
 		cor1 |= COR1_8BITS;
 		break;
 	}
-	
-	if (C_CSTOPB(tty)) 
+
+	if (C_CSTOPB(tty))
 		cor1 |= COR1_2SB;
-	
+
 	cor1 |= COR1_IGNORE;
 	if (C_PARENB(tty)) {
 		cor1 |= COR1_NORMPAR;
-		if (C_PARODD(tty)) 
+		if (C_PARODD(tty))
 			cor1 |= COR1_ODDP;
-		if (I_INPCK(tty)) 
+		if (I_INPCK(tty))
 			cor1 &= ~COR1_IGNORE;
 	}
 	/* Set marking of some errors */
 	port->mark_mask = RCSR_OE | RCSR_TOUT;
-	if (I_INPCK(tty)) 
+	if (I_INPCK(tty))
 		port->mark_mask |= RCSR_FE | RCSR_PE;
-	if (I_BRKINT(tty) || I_PARMRK(tty)) 
+	if (I_BRKINT(tty) || I_PARMRK(tty))
 		port->mark_mask |= RCSR_BREAK;
-	if (I_IGNPAR(tty)) 
+	if (I_IGNPAR(tty))
 		port->mark_mask &= ~(RCSR_FE | RCSR_PE);
 	if (I_IGNBRK(tty)) {
 		port->mark_mask &= ~RCSR_BREAK;
-		if (I_IGNPAR(tty)) 
+		if (I_IGNPAR(tty))
 			/* Real raw mode. Ignore all */
 			port->mark_mask &= ~RCSR_OE;
 	}
@@ -1241,7 +1239,7 @@ static void sx_change_speed(struct speci
 		tty->hw_stopped = !(sx_in(bp, CD186x_MSVR) & (MSVR_CTS|MSVR_DSR));
 		spin_unlock_irqrestore(&bp->lock, flags);
 #else
-		port->COR2 |= COR2_CTSAE; 
+		port->COR2 |= COR2_CTSAE;
 #endif
 	}
 	/* Enable Software Flow Control. FIXME: I'm not sure about this */
@@ -1264,11 +1262,11 @@ static void sx_change_speed(struct speci
 		mcor1 |= MCOR1_CDZD;
 		mcor2 |= MCOR2_CDOD;
 	}
-	
-	if (C_CREAD(tty)) 
+
+	if (C_CREAD(tty))
 		/* Enable receiver */
 		port->IER |= IER_RXD;
-	
+
 	/* Set input FIFO size (1-8 bytes) */
 	cor3 |= sx_rxfifo;
 	/* Setting up CD186x channel registers */
@@ -1311,11 +1309,11 @@ static int sx_setup_port(struct speciali
 		func_exit();
 		return 0;
 	}
-	
+
 	if (!port->xmit_buf) {
 		/* We may sleep in get_zeroed_page() */
 		unsigned long tmp;
-		
+
 		if (!(tmp = get_zeroed_page(GFP_KERNEL))) {
 			func_exit();
 			return -ENOMEM;
@@ -1328,10 +1326,10 @@ static int sx_setup_port(struct speciali
 		}
 		port->xmit_buf = (unsigned char *) tmp;
 	}
-		
+
 	spin_lock_irqsave(&port->lock, flags);
 
-	if (port->tty) 
+	if (port->tty)
 		clear_bit(TTY_IO_ERROR, &port->tty->flags);
 
 	port->xmit_cnt = port->xmit_head = port->xmit_tail = 0;
@@ -1340,7 +1338,7 @@ static int sx_setup_port(struct speciali
 
 	spin_unlock_irqrestore(&port->lock, flags);
 
-		
+
 	func_exit();
 	return 0;
 }
@@ -1352,14 +1350,14 @@ static void sx_shutdown_port(struct spec
 	struct tty_struct *tty;
 	int i;
 	unsigned long flags;
-	
+
 	func_enter();
 
 	if (!(port->flags & ASYNC_INITIALIZED)) {
 		func_exit();
 		return;
 	}
-	
+
 	if (sx_debug & SX_DEBUG_FIFO) {
 		dprintk(SX_DEBUG_FIFO, "sx%d: port %d: %ld overruns, FIFO hits [ ",
 			board_No(bp), port_No(port), port->overrun);
@@ -1394,13 +1392,13 @@ static void sx_shutdown_port(struct spec
 	if (tty)
 		set_bit(TTY_IO_ERROR, &tty->flags);
 	port->flags &= ~ASYNC_INITIALIZED;
-	
-	if (!bp->count) 
+
+	if (!bp->count)
 		sx_shutdown_board(bp);
 	func_exit();
 }
 
-	
+
 static int block_til_ready(struct tty_struct *tty, struct file * filp,
                            struct specialix_port *port)
 {
@@ -1427,7 +1425,7 @@ static int block_til_ready(struct tty_st
 			return -ERESTARTSYS;
 		}
 	}
-	
+
 	/*
 	 * If non-blocking mode is set, or the port is not enabled,
 	 * then make the check up front and then exit.
@@ -1477,7 +1475,7 @@ static int block_til_ready(struct tty_st
 			if (port->flags & ASYNC_HUP_NOTIFY)
 				retval = -EAGAIN;
 			else
-				retval = -ERESTARTSYS;	
+				retval = -ERESTARTSYS;
 			break;
 		}
 		if (!(port->flags & ASYNC_CLOSING) &&
@@ -1506,7 +1504,7 @@ static int block_til_ready(struct tty_st
 	port->flags |= ASYNC_NORMAL_ACTIVE;
 	func_exit();
 	return 0;
-}	
+}
 
 
 static int sx_open(struct tty_struct * tty, struct file * filp)
@@ -1526,7 +1524,7 @@ static int sx_open(struct tty_struct * t
 		func_exit();
 		return -ENODEV;
 	}
-	
+
 	bp = &sx_board[board];
 	port = sx_port + board * SX_NPORT + SX_PORT(tty->index);
 	port->overrun = 0;
@@ -1557,7 +1555,7 @@ static int sx_open(struct tty_struct * t
 		func_enter();
 		return error;
 	}
-	
+
 	if ((error = block_til_ready(tty, filp, port))) {
 		func_enter();
 		return error;
@@ -1574,7 +1572,7 @@ static void sx_close(struct tty_struct *
 	struct specialix_board *bp;
 	unsigned long flags;
 	unsigned long timeout;
-	
+
 	func_enter();
 	if (!port || sx_paranoia_check(port, tty->name, "close")) {
 		func_exit();
@@ -1587,7 +1585,7 @@ static void sx_close(struct tty_struct *
 		func_exit();
 		return;
 	}
-	
+
 	bp = port_Board(port);
 	if ((tty->count == 1) && (port->count != 1)) {
 		printk(KERN_ERR "sx%d: sx_close: bad port count;"
@@ -1607,7 +1605,7 @@ static void sx_close(struct tty_struct *
 	}
 	port->flags |= ASYNC_CLOSING;
 	/*
-	 * Now we wait for the transmit buffer to clear; and we notify 
+	 * Now we wait for the transmit buffer to clear; and we notify
 	 * the line discipline to only process XON/XOFF characters.
 	 */
 	tty->closing = 1;
@@ -1681,7 +1679,7 @@ static void sx_close(struct tty_struct *
 }
 
 
-static int sx_write(struct tty_struct * tty, 
+static int sx_write(struct tty_struct * tty,
                     const unsigned char *buf, int count)
 {
 	struct specialix_port *port = (struct specialix_port *)tty->driver_data;
@@ -1694,7 +1692,7 @@ static int sx_write(struct tty_struct * 
 		func_exit();
 		return 0;
 	}
-	
+
 	bp = port_Board(port);
 
 	if (!tty || !port->xmit_buf || !tmp_buf) {
@@ -1824,7 +1822,7 @@ static int sx_chars_in_buffer(struct tty
 	struct specialix_port *port = (struct specialix_port *)tty->driver_data;
 
 	func_enter();
-	
+
 	if (sx_paranoia_check(port, tty->name, "sx_chars_in_buffer")) {
 		func_exit();
 		return 0;
@@ -1881,13 +1879,13 @@ static int sx_tiocmget(struct tty_struct
 		port_No(port), status, sx_in (bp, CD186x_CAR));
 	dprintk (SX_DEBUG_INIT, "sx_port = %p, port = %p\n", sx_port, port);
 	if (SX_CRTSCTS(port->tty)) {
-		result  = /*   (status & MSVR_RTS) ? */ TIOCM_DTR /* : 0) */ 
+		result  = /*   (status & MSVR_RTS) ? */ TIOCM_DTR /* : 0) */
 		          |   ((status & MSVR_DTR) ? TIOCM_RTS : 0)
 		          |   ((status & MSVR_CD)  ? TIOCM_CAR : 0)
 		          |/* ((status & MSVR_DSR) ? */ TIOCM_DSR /* : 0) */
 		          |   ((status & MSVR_CTS) ? TIOCM_CTS : 0);
 	} else {
-		result  = /*   (status & MSVR_RTS) ? */ TIOCM_RTS /* : 0) */ 
+		result  = /*   (status & MSVR_RTS) ? */ TIOCM_RTS /* : 0) */
 		          |   ((status & MSVR_DTR) ? TIOCM_DTR : 0)
 		          |   ((status & MSVR_CD)  ? TIOCM_CAR : 0)
 		          |/* ((status & MSVR_DSR) ? */ TIOCM_DSR /* : 0) */
@@ -1955,7 +1953,7 @@ static inline void sx_send_break(struct 
 {
 	struct specialix_board *bp = port_Board(port);
 	unsigned long flags;
-	
+
 	func_enter();
 
 	spin_lock_irqsave (&port->lock, flags);
@@ -1996,8 +1994,8 @@ static inline int sx_set_serial_info(str
 		func_enter();
 		return -EFAULT;
 	}
-	
-#if 0	
+
+#if 0
 	if ((tmp.irq != bp->irq) ||
 	    (tmp.port != bp->base) ||
 	    (tmp.type != PORT_CIRRUS) ||
@@ -2008,12 +2006,12 @@ static inline int sx_set_serial_info(str
 		func_exit();
 		return -EINVAL;
 	}
-#endif	
+#endif
 
 	change_speed = ((port->flags & ASYNC_SPD_MASK) !=
 			(tmp.flags & ASYNC_SPD_MASK));
 	change_speed |= (tmp.custom_divisor != port->custom_divisor);
-	
+
 	if (!capable(CAP_SYS_ADMIN)) {
 		if ((tmp.close_delay != port->close_delay) ||
 		    (tmp.closing_wait != port->closing_wait) ||
@@ -2045,7 +2043,7 @@ static inline int sx_get_serial_info(str
 {
 	struct serial_struct tmp;
 	struct specialix_board *bp = port_Board(port);
-	
+
 	func_enter();
 
 	/*
@@ -2074,7 +2072,7 @@ static inline int sx_get_serial_info(str
 }
 
 
-static int sx_ioctl(struct tty_struct * tty, struct file * filp, 
+static int sx_ioctl(struct tty_struct * tty, struct file * filp,
                     unsigned int cmd, unsigned long arg)
 {
 	struct specialix_port *port = (struct specialix_port *)tty->driver_data;
@@ -2087,7 +2085,7 @@ static int sx_ioctl(struct tty_struct * 
 		func_exit();
 		return -ENODEV;
 	}
-	
+
 	switch (cmd) {
 	 case TCSBRK:	/* SVID version: non-zero arg --> no break */
 		retval = tty_check_change(tty);
@@ -2129,7 +2127,7 @@ static int sx_ioctl(struct tty_struct * 
 	 case TIOCGSERIAL:
 		 func_exit();
 		return sx_get_serial_info(port, argp);
-	 case TIOCSSERIAL:	
+	 case TIOCSSERIAL:
 		 func_exit();
 		return sx_set_serial_info(port, argp);
 	 default:
@@ -2153,16 +2151,16 @@ static void sx_throttle(struct tty_struc
 		func_exit();
 		return;
 	}
-	
+
 	bp = port_Board(port);
-	
+
 	/* Use DTR instead of RTS ! */
-	if (SX_CRTSCTS (tty)) 
+	if (SX_CRTSCTS (tty))
 		port->MSVR &= ~MSVR_DTR;
 	else {
 		/* Auch!!! I think the system shouldn't call this then. */
 		/* Or maybe we're supposed (allowed?) to do our side of hw
-		   handshake anyway, even when hardware handshake is off. 
+		   handshake anyway, even when hardware handshake is off.
 		   When you see this in your logs, please report.... */
 		printk (KERN_ERR "sx%d: Need to throttle, but can't (hardware hs is off)\n",
 	                 port_No (port));
@@ -2193,14 +2191,14 @@ static void sx_unthrottle(struct tty_str
 	unsigned long flags;
 
 	func_enter();
-				
+
 	if (sx_paranoia_check(port, tty->name, "sx_unthrottle")) {
 		func_exit();
 		return;
 	}
-	
+
 	bp = port_Board(port);
-	
+
 	spin_lock_irqsave(&port->lock, flags);
 	/* XXXX Use DTR INSTEAD???? */
 	if (SX_CRTSCTS(tty)) {
@@ -2234,14 +2232,14 @@ static void sx_stop(struct tty_struct * 
 	unsigned long flags;
 
 	func_enter();
-	
+
 	if (sx_paranoia_check(port, tty->name, "sx_stop")) {
 		func_exit();
 		return;
 	}
 
 	bp = port_Board(port);
-	
+
 	spin_lock_irqsave(&port->lock, flags);
 	port->IER &= ~IER_TXRDY;
 	spin_lock_irqsave(&bp->lock, flags);
@@ -2261,14 +2259,14 @@ static void sx_start(struct tty_struct *
 	unsigned long flags;
 
 	func_enter();
-				
+
 	if (sx_paranoia_check(port, tty->name, "sx_start")) {
 		func_exit();
 		return;
 	}
-	
+
 	bp = port_Board(port);
-	
+
 	spin_lock_irqsave(&port->lock, flags);
 	if (port->xmit_cnt && port->xmit_buf && !(port->IER & IER_TXRDY)) {
 		port->IER |= IER_TXRDY;
@@ -2290,13 +2288,13 @@ static void sx_start(struct tty_struct *
  *
  * 	serial interrupt routine -> (workqueue) ->
  * 	do_sx_hangup() -> tty->hangup() -> sx_hangup()
- * 
+ *
  */
 static void do_sx_hangup(void *private_)
 {
 	struct specialix_port	*port = (struct specialix_port *) private_;
 	struct tty_struct	*tty;
-	
+
 	func_enter();
 
 	tty = port->tty;
@@ -2319,9 +2317,9 @@ static void sx_hangup(struct tty_struct 
 		func_exit();
 		return;
 	}
-	
+
 	bp = port_Board(port);
-	
+
 	sx_shutdown_port(bp, port);
 	spin_lock_irqsave(&port->lock, flags);
 	port->event = 0;
@@ -2346,10 +2344,10 @@ static void sx_set_termios(struct tty_st
 	struct specialix_port *port = (struct specialix_port *)tty->driver_data;
 	unsigned long flags;
 	struct specialix_board  * bp;
-				
+
 	if (sx_paranoia_check(port, tty->name, "sx_set_termios"))
 		return;
-	
+
 	if (tty->termios->c_cflag == old_termios->c_cflag &&
 	    tty->termios->c_iflag == old_termios->c_iflag)
 		return;
@@ -2420,7 +2418,7 @@ static int sx_init_drivers(void)
 		func_exit();
 		return 1;
 	}
-	
+
 	if (!(tmp_buf = (unsigned char *) get_zeroed_page(GFP_KERNEL))) {
 		printk(KERN_ERR "sx: Couldn't get free page.\n");
 		put_tty_driver(specialix_driver);
@@ -2457,7 +2455,7 @@ static int sx_init_drivers(void)
 		init_waitqueue_head(&sx_port[i].close_wait);
 		spin_lock_init(&sx_port[i].lock);
 	}
-	
+
 	func_exit();
 	return 0;
 }
@@ -2472,8 +2470,8 @@ static void sx_release_drivers(void)
 	func_exit();
 }
 
-/* 
- * This routine must be called by kernel at boot time 
+/*
+ * This routine must be called by kernel at boot time
  */
 static int __init specialix_init(void)
 {
@@ -2489,7 +2487,7 @@ static int __init specialix_init(void)
 #else
 	printk (KERN_INFO "sx: DTR/RTS pin is RTS when CRTSCTS is on.\n");
 #endif
-	
+
 	for (i = 0; i < SX_NBOARD; i++)
 		sx_board[i].lock = SPIN_LOCK_UNLOCKED;
 
@@ -2498,7 +2496,7 @@ static int __init specialix_init(void)
 		return -EIO;
 	}
 
-	for (i = 0; i < SX_NBOARD; i++) 
+	for (i = 0; i < SX_NBOARD; i++)
 		if (sx_board[i].base && !sx_probe(&sx_board[i]))
 			found++;
 
@@ -2512,8 +2510,8 @@ static int __init specialix_init(void)
 				i++;
 				continue;
 			}
-			pdev = pci_find_device (PCI_VENDOR_ID_SPECIALIX, 
-			                        PCI_DEVICE_ID_SPECIALIX_IO8, 
+			pdev = pci_find_device (PCI_VENDOR_ID_SPECIALIX,
+			                        PCI_DEVICE_ID_SPECIALIX_IO8,
 			                        pdev);
 			if (!pdev) break;
 
@@ -2557,10 +2555,10 @@ module_param(sx_poll, int, 0);
 /*
  * You can setup up to 4 boards.
  * by specifying "iobase=0xXXX,0xXXX ..." as insmod parameter.
- * You should specify the IRQs too in that case "irq=....,...". 
- * 
+ * You should specify the IRQs too in that case "irq=....,...".
+ *
  * More than 4 boards in one computer is not possible, as the card can
- * only use 4 different interrupts. 
+ * only use 4 different interrupts.
  *
  */
 static int __init specialix_init_module(void)
@@ -2583,16 +2581,16 @@ static int __init specialix_init_module(
 
 	return specialix_init();
 }
-	
+
 static void __exit specialix_exit_module(void)
 {
 	int i;
-	
+
 	func_enter();
 
 	sx_release_drivers();
 	for (i = 0; i < SX_NBOARD; i++)
-		if (sx_board[i].flags & SX_BOARD_PRESENT) 
+		if (sx_board[i].flags & SX_BOARD_PRESENT)
 			sx_release_io_range(&sx_board[i]);
 #ifdef SPECIALIX_TIMER
 	del_timer (&missed_irq_timer);
diff --git a/drivers/net/eepro.c b/drivers/net/eepro.c
--- a/drivers/net/eepro.c
+++ b/drivers/net/eepro.c
@@ -552,8 +552,7 @@ static int __init do_eepro_probe(struct 
 	{
 		unsigned short int WS[32]=WakeupSeq;
 
-		if (check_region(WakeupPort, 2)==0) {
-
+		if (request_region(WakeupPort, 2, "eepro wakeup")) {
 			if (net_debug>5)
 				printk(KERN_DEBUG "Waking UP\n");
 
@@ -563,7 +562,10 @@ static int __init do_eepro_probe(struct 
 				outb_p(WS[i],WakeupPort);
 				if (net_debug>5) printk(KERN_DEBUG ": %#x ",WS[i]);
 			}
-		} else printk(KERN_WARNING "Checkregion Failed!\n");
+
+			release_region(WakeupPort, 2);
+		} else
+			printk(KERN_WARNING "PnP wakeup region busy!\n");
 	}
 #endif
 
@@ -705,7 +707,7 @@ static void __init eepro_print_info (str
 					dev->name, (unsigned)dev->base_addr);
 			break;
 		case LAN595FX:
-			printk("%s: Intel EtherExpress Pro/10+ ISA\n at %#x,", 
+			printk("%s: Intel EtherExpress Pro/10+ ISA\n at %#x,",
 					dev->name, (unsigned)dev->base_addr);
 			break;
 		case LAN595TX:
@@ -713,7 +715,7 @@ static void __init eepro_print_info (str
 					dev->name, (unsigned)dev->base_addr);
 			break;
 		case LAN595:
-			printk("%s: Intel 82595-based lan card at %#x,", 
+			printk("%s: Intel 82595-based lan card at %#x,",
 					dev->name, (unsigned)dev->base_addr);
 	}
 
@@ -726,7 +728,7 @@ static void __init eepro_print_info (str
 
 	if (dev->irq > 2)
 		printk(", IRQ %d, %s.\n", dev->irq, ifmap[dev->if_port]);
-	else 
+	else
 		printk(", %s.\n", ifmap[dev->if_port]);
 
 	if (net_debug > 3) {
@@ -756,7 +758,7 @@ static int __init eepro_probe1(struct ne
 	int err;
 
 	/* Grab the region so we can find another board if autoIRQ fails. */
-	if (!request_region(ioaddr, EEPRO_IO_EXTENT, DRV_NAME)) { 
+	if (!request_region(ioaddr, EEPRO_IO_EXTENT, DRV_NAME)) {
 		if (!autoprobe)
 			printk(KERN_WARNING "EEPRO: io-port 0x%04x in use \n",
 				ioaddr);
@@ -838,15 +840,15 @@ static int __init eepro_probe1(struct ne
  		/* Mask off INT number */
  		int count = lp->word[1] & 7;
  		unsigned irqMask = lp->word[7];
- 
+
  		while (count--)
  			irqMask &= irqMask - 1;
- 
+
  		count = ffs(irqMask);
- 
+
  		if (count)
  			dev->irq = count - 1;
- 
+
  		if (dev->irq < 2) {
  			printk(KERN_ERR " Duh! illegal interrupt vector stored in EEPROM.\n");
  			goto exit;
@@ -854,7 +856,7 @@ static int __init eepro_probe1(struct ne
  			dev->irq = 9;
  		}
  	}
- 
+
  	dev->open               = eepro_open;
  	dev->stop               = eepro_close;
  	dev->hard_start_xmit    = eepro_send_packet;
@@ -863,7 +865,7 @@ static int __init eepro_probe1(struct ne
  	dev->tx_timeout		= eepro_tx_timeout;
  	dev->watchdog_timeo	= TX_TIMEOUT;
 	dev->ethtool_ops	= &eepro_ethtool_ops;
- 
+
 	/* print boot time info */
 	eepro_print_info(dev);
 
@@ -1047,8 +1049,8 @@ static int eepro_open(struct net_device 
 
 
 	/* Initialize the RCV and XMT upper and lower limits */
-	outb(lp->rcv_lower_limit >> 8, ioaddr + RCV_LOWER_LIMIT_REG); 
-	outb(lp->rcv_upper_limit >> 8, ioaddr + RCV_UPPER_LIMIT_REG); 
+	outb(lp->rcv_lower_limit >> 8, ioaddr + RCV_LOWER_LIMIT_REG);
+	outb(lp->rcv_upper_limit >> 8, ioaddr + RCV_UPPER_LIMIT_REG);
 	outb(lp->xmt_lower_limit >> 8, ioaddr + lp->xmt_lower_limit_reg);
 	outb(lp->xmt_upper_limit >> 8, ioaddr + lp->xmt_upper_limit_reg);
 
@@ -1065,12 +1067,12 @@ static int eepro_open(struct net_device 
 	eepro_clear_int(ioaddr);
 
 	/* Initialize RCV */
-	outw(lp->rcv_lower_limit, ioaddr + RCV_BAR); 
+	outw(lp->rcv_lower_limit, ioaddr + RCV_BAR);
 	lp->rx_start = lp->rcv_lower_limit;
-	outw(lp->rcv_upper_limit | 0xfe, ioaddr + RCV_STOP); 
+	outw(lp->rcv_upper_limit | 0xfe, ioaddr + RCV_STOP);
 
 	/* Initialize XMT */
-	outw(lp->xmt_lower_limit, ioaddr + lp->xmt_bar); 
+	outw(lp->xmt_lower_limit, ioaddr + lp->xmt_bar);
 	lp->tx_start = lp->tx_end = lp->xmt_lower_limit;
 	lp->tx_last = 0;
 
@@ -1411,7 +1413,7 @@ set_multicast_list(struct net_device *de
 				outb(0x08, ioaddr + STATUS_REG);
 
 				if (i & 0x20) { /* command ABORTed */
-					printk(KERN_NOTICE "%s: multicast setup failed.\n", 
+					printk(KERN_NOTICE "%s: multicast setup failed.\n",
 						dev->name);
 					break;
 				} else if ((i & 0x0f) == 0x03)	{ /* MC-Done */
@@ -1512,7 +1514,7 @@ hardware_send_packet(struct net_device *
 		end = last + (((length + 3) >> 1) << 1) + XMT_HEADER;
 
 	if (end >= lp->xmt_upper_limit + 2) { /* the transmit buffer is wrapped around */
-		if ((lp->xmt_upper_limit + 2 - last) <= XMT_HEADER) {	
+		if ((lp->xmt_upper_limit + 2 - last) <= XMT_HEADER) {
 				/* Arrrr!!!, must keep the xmt header together,
 				several days were lost to chase this one down. */
 			last = lp->xmt_lower_limit;
@@ -1643,7 +1645,7 @@ eepro_rx(struct net_device *dev)
 			else if (rcv_status & 0x0800)
 				lp->stats.rx_crc_errors++;
 
-			printk(KERN_DEBUG "%s: event = %#x, status = %#x, next = %#x, size = %#x\n", 
+			printk(KERN_DEBUG "%s: event = %#x, status = %#x, next = %#x, size = %#x\n",
 				dev->name, rcv_event, rcv_status, rcv_next_frame, rcv_size);
 		}
 
@@ -1674,10 +1676,10 @@ eepro_transmit_interrupt(struct net_devi
 {
 	struct eepro_local *lp = netdev_priv(dev);
 	short ioaddr = dev->base_addr;
-	short boguscount = 25; 
+	short boguscount = 25;
 	short xmt_status;
 
-	while ((lp->tx_start != lp->tx_end) && boguscount--) { 
+	while ((lp->tx_start != lp->tx_end) && boguscount--) {
 
 		outw(lp->tx_start, ioaddr + HOST_ADDRESS_REG);
 		xmt_status = inw(ioaddr+IO_PORT);
@@ -1723,7 +1725,7 @@ static int eepro_ethtool_get_settings(st
 {
 	struct eepro_local	*lp = (struct eepro_local *)dev->priv;
 
-	cmd->supported = 	SUPPORTED_10baseT_Half | 
+	cmd->supported = 	SUPPORTED_10baseT_Half |
 				SUPPORTED_10baseT_Full |
 				SUPPORTED_Autoneg;
 	cmd->advertising =	ADVERTISED_10baseT_Half |
diff --git a/include/asm-m68k/sun3xflop.h b/include/asm-m68k/sun3xflop.h
--- a/include/asm-m68k/sun3xflop.h
+++ b/include/asm-m68k/sun3xflop.h
@@ -27,10 +27,8 @@
 
 /* We don't need no stinkin' I/O port allocation crap. */
 #undef release_region
-#undef check_region
 #undef request_region
 #define release_region(X, Y)	do { } while(0)
-#define check_region(X, Y)	(0)
 #define request_region(X, Y, Z)	(1)
 
 struct sun3xflop_private {
diff --git a/include/asm-m68knommu/ide.h b/include/asm-m68knommu/ide.h
--- a/include/asm-m68knommu/ide.h
+++ b/include/asm-m68knommu/ide.h
@@ -163,13 +163,6 @@ ide_free_irq(unsigned int irq, void *dev
 }
 
 
-static IDE_INLINE int
-ide_check_region(ide_ioreg_t from, unsigned int extent)
-{
-	return 0;
-}
-
-
 static IDE_INLINE void
 ide_request_region(ide_ioreg_t from, unsigned int extent, const char *name)
 {
diff --git a/include/asm-parisc/ide.h b/include/asm-parisc/ide.h
--- a/include/asm-parisc/ide.h
+++ b/include/asm-parisc/ide.h
@@ -22,7 +22,6 @@
 
 #define ide_request_irq(irq,hand,flg,dev,id)	request_irq((irq),(hand),(flg),(dev),(id))
 #define ide_free_irq(irq,dev_id)		free_irq((irq), (dev_id))
-#define ide_check_region(from,extent)		check_region((from), (extent))
 #define ide_request_region(from,extent,name)	request_region((from), (extent), (name))
 #define ide_release_region(from,extent)		release_region((from), (extent))
 /* Generic I/O and MEMIO string operations.  */
diff --git a/include/asm-sparc/floppy.h b/include/asm-sparc/floppy.h
--- a/include/asm-sparc/floppy.h
+++ b/include/asm-sparc/floppy.h
@@ -17,10 +17,8 @@
 
 /* We don't need no stinkin' I/O port allocation crap. */
 #undef release_region
-#undef check_region
 #undef request_region
 #define release_region(X, Y)	do { } while(0)
-#define check_region(X, Y)	(0)
 #define request_region(X, Y, Z)	(1)
 
 /* References:
diff --git a/sound/oss/cs4232.c b/sound/oss/cs4232.c
--- a/sound/oss/cs4232.c
+++ b/sound/oss/cs4232.c
@@ -195,10 +195,12 @@ static int __init probe_cs4232(struct ad
 		CS_OUT2(0x15, 0x00);	/* Select logical device 0 (WSS/SB/FM) */
 		CS_OUT3(0x47, (base >> 8) & 0xff, base & 0xff);	/* WSS base */
 
-		if (check_region(0x388, 4))	/* Not free */
+		if (!request_region(0x388, 4, "FM"))	/* Not free */
 			CS_OUT3(0x48, 0x00, 0x00)	/* FM base off */
-		else
+		else {
+			release_region(0x388, 4);
 			CS_OUT3(0x48, 0x03, 0x88);	/* FM base 0x388 */
+		}
 
 		CS_OUT3(0x42, 0x00, 0x00);	/* SB base off */
 		CS_OUT2(0x22, irq);		/* SB+WSS IRQ */
diff --git a/sound/oss/wavfront.c b/sound/oss/wavfront.c
--- a/sound/oss/wavfront.c
+++ b/sound/oss/wavfront.c
@@ -2434,7 +2434,7 @@ static int __init detect_wavefront (int 
 	   consumes 16.
 	*/
 
-	if (check_region (io_base, 16)) {
+	if (!request_region (io_base, 16, "wavfront")) {
 		printk (KERN_ERR LOGNAME "IO address range 0x%x - 0x%x "
 			"already in use - ignored\n", dev.base,
 			dev.base+15);
@@ -2466,10 +2466,13 @@ static int __init detect_wavefront (int 
 		} else {
 			printk (KERN_WARNING LOGNAME "not raw, but no "
 				"hardware version!\n");
+			release_region (io_base, 16);
 			return 0;
 		}
 
 		if (!wf_raw) {
+			/* will re-acquire region in install_wavefront() */
+			release_region (io_base, 16);
 			return 1;
 		} else {
 			printk (KERN_INFO LOGNAME
@@ -2489,6 +2492,7 @@ static int __init detect_wavefront (int 
 
 	if (wavefront_hw_reset ()) {
 		printk (KERN_WARNING LOGNAME "hardware reset failed\n");
+		release_region (io_base, 16);
 		return 0;
 	}
 
@@ -2496,6 +2500,8 @@ static int __init detect_wavefront (int 
 
 	dev.has_fx = (detect_wffx () == 0);
 
+	/* will re-acquire region in install_wavefront() */
+	release_region (io_base, 16);
 	return 1;
 }
 
@@ -2804,17 +2810,27 @@ static int __init wavefront_init (int at
 }
 
 static int __init install_wavefront (void)
-
 {
+	if (!request_region (dev.base+2, 6, "wavefront synth"))
+		return -1;
+
+	if (dev.has_fx) {
+		if (!request_region (dev.base+8, 8, "wavefront fx")) {
+			release_region (dev.base+2, 6);
+			return -1;
+		}
+	}
+
 	if ((dev.synth_dev = register_sound_synth (&wavefront_fops, -1)) < 0) {
 		printk (KERN_ERR LOGNAME "cannot register raw synth\n");
-		return -1;
+		goto err_out;
 	}
 
 #if OSS_SUPPORT_LEVEL & OSS_SUPPORT_SEQ
 	if ((dev.oss_dev = sound_alloc_synthdev()) == -1) {
 		printk (KERN_ERR LOGNAME "Too many sequencers\n");
-		return -1;
+		/* FIXME: leak: should unregister sound synth */
+		goto err_out;
 	} else {
 		synth_devs[dev.oss_dev] = &wavefront_operations;
 	}
@@ -2827,20 +2843,20 @@ static int __init install_wavefront (voi
 		sound_unload_synthdev (dev.oss_dev);
 #endif /* OSS_SUPPORT_SEQ */ 
 
-		return -1;
+		goto err_out;
 	}
     
-	request_region (dev.base+2, 6, "wavefront synth");
-
-	if (dev.has_fx) {
-		request_region (dev.base+8, 8, "wavefront fx");
-	}
-
 	if (wavefront_config_midi ()) {
 		printk (KERN_WARNING LOGNAME "could not initialize MIDI.\n");
 	}
 
 	return dev.oss_dev;
+
+err_out:
+	release_region (dev.base+2, 6);
+	if (dev.has_fx)
+		release_region (dev.base+8, 8);
+	return -1;
 }
 
 static void __exit uninstall_wavefront (void)
