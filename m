Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261167AbVAFUBC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261167AbVAFUBC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 15:01:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263008AbVAFUBC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 15:01:02 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:12476 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261167AbVAFTuJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 14:50:09 -0500
Subject: PATCH: Ressurect ISICOM serial
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: torvalds@osdl.org, linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1105035699.17176.234.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 06 Jan 2005 18:45:50 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The isicom driver had bitrotted badly and although it had some 2.6
cleanup work didn't actually do anything useful. ISIcom had their own
2.4 driver which didn't work with 2.6 either but had done the hard work
like the locking rewrites. So I nailed them together and then fixed some
obvious bugs in the ISIcom driver version.

I doubt this is the end of the story but its at least the beginning

Alan

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.10/drivers/char/isicom.c linux-2.6.10/drivers/char/isicom.c
--- linux.vanilla-2.6.10/drivers/char/isicom.c	2004-12-25 21:15:34.000000000 +0000
+++ linux-2.6.10/drivers/char/isicom.c	2005-01-06 18:53:25.212762272 +0000
@@ -16,10 +16,81 @@
  *
  *	10/6/99 sameer			Merged the ISA and PCI drivers to
  *					a new unified driver.
+ *
+ *	3/9/99	sameer			Added support for ISI4616 cards.
+ *
+ *	16/9/99	sameer			We do not force RTS low anymore.
+ *					This is to prevent the firmware 
+ *					from getting confused.
+ *
+ *	26/10/99 sameer			Cosmetic changes:The driver now
+ *					dumps the Port Count information
+ *					along with I/O address and IRQ.
+ *
+ *	13/12/99 sameer			Fixed the problem with IRQ sharing.
+ *
+ *	10/5/00  sameer			Fixed isicom_shutdown_board()
+ *					to not lower DTR on all the ports
+ *					when the last port on the card is 
+ *					closed.
+ *
+ *	10/5/00  sameer			Signal mask setup command added
+ *					to  isicom_setup_port and 
+ *					isicom_shutdown_port.
+ *
+ *	24/5/00  sameer			The driver is now SMP aware.
+ *					
+ *	
+ *	27/11/00 Vinayak P Risbud	Fixed the Driver Crash Problem
+ *	
+ *	
+ *	03/01/01  anil .s		Added support for resetting the
+ *					internal modems on ISI cards.
+ *
+ *	08/02/01  anil .s		Upgraded the driver for kernel
+ *					2.4.x
+ *
+ *      11/04/01  Kevin			Fixed firmware load problem with
+ *					ISIHP-4X card
+ *	
+ *	30/04/01  anil .s		Fixed the remote login through
+ *					ISI port problem. Now the link
+ *					does not go down before password
+ *					prompt.
+ *
+ *	03/05/01  anil .s		Fixed the problem with IRQ sharing
+ *					among ISI-PCI cards.
+ *
+ *	03/05/01  anil .s		Added support to display the version
+ *					info during insmod as well as module 
+ *					listing by lsmod.
+ *	
+ *	10/05/01  anil .s		Done the modifications to the source
+ *					file and Install script so that the
+ *					same installation can be used for
+ *					2.2.x and 2.4.x kernel.
+ *
+ *	06/06/01  anil .s		Now we drop both dtr and rts during
+ *					shutdown_port as well as raise them
+ *					during isicom_config_port.
+ *  	
  *	09/06/01 acme@conectiva.com.br	use capable, not suser, do
  *					restore_flags on failure in
  *					isicom_send_break, verify put_user
  *					result
+ *
+ *  	11/02/03  ranjeeth		Added support for 230 Kbps and 460 Kbps
+ *  					Baud index extended to 21
+ *  	
+ *  	20/03/03  ranjeeth		Made to work for Linux Advanced server.
+ *  					Taken care of license warning.	
+ *      
+ *	10/12/03  Ravindra		Made to work for Fedora Core 1 of 
+ *					Red Hat Distribution
+ *
+ *	06/01/05  Alan Cox 		Merged the ISI and base kernel strands
+ *					into a single 2.6 driver
+ *
  *	***********************************************************
  *
  *	To use this driver you also need the support package. You 
@@ -35,6 +106,10 @@
  *
  *	Omit those entries for boards you don't have installed.
  *
+ *	TODO
+ *		Hotplug
+ *		Merge testing
+ *		64-bit verification
  */
 
 #include <linux/module.h>
@@ -74,7 +149,6 @@
 MODULE_DEVICE_TABLE(pci, isicom_pci_tbl);
 
 static int prev_card = 3;	/*	start servicing isi_card[0]	*/
-static struct isi_board * irq_to_board[16];
 static struct tty_driver *isicom_normal;
 
 static struct isi_board isi_card[BOARD_COUNT];
@@ -101,9 +175,205 @@
 	18, 19
 };
 
+struct	isi_board {
+	unsigned short		base;
+	unsigned char		irq;
+	unsigned char		port_count;
+	unsigned short		status;
+	unsigned short		port_status; /* each bit represents a single port */
+	unsigned short		shift_count;
+	struct isi_port		* ports;
+	signed char		count;
+	unsigned char		isa;
+	spinlock_t		card_lock; /* Card wide lock 11/5/00 -sameer */
+	unsigned long		flags;
+};
+
+struct	isi_port {
+	unsigned short		magic;
+	unsigned int		flags;
+	int			count;
+	int			blocked_open;
+	int			close_delay;
+	unsigned short		channel;
+	unsigned short		status;
+	unsigned short		closing_wait;
+	struct isi_board	* card;
+	struct tty_struct 	* tty;
+	wait_queue_head_t	close_wait;
+	wait_queue_head_t	open_wait;
+	struct work_struct	hangup_tq;
+	struct work_struct	bh_tqueue;
+	unsigned char		* xmit_buf;
+	int			xmit_head;
+	int			xmit_tail;
+	int			xmit_cnt;
+};
+
+/*
+ *	Locking functions for card level locking. We need to own both
+ *	the kernel lock for the card and have the card in a position that
+ *	it wants to talk.
+ */
+ 
+static int lock_card(struct isi_board *card)
+{
+	char		retries;
+	unsigned short base = card->base;
+
+	for (retries = 0; retries < 100; retries++) {
+		spin_lock_irqsave(&card->card_lock, card->flags);
+		if (inw(base + 0xe) & 0x1) {
+			return 1; 
+		} else {
+			spin_unlock_irqrestore(&card->card_lock, card->flags);
+			udelay(1000);   /* 1ms */
+		}
+	}
+	printk(KERN_WARNING "ISICOM: Failed to lock Card (0x%x)\n", card->base);
+	return 0;	/* Failed to aquire the card! */
+}
+
+static int lock_card_at_interrupt(struct isi_board *card)
+{
+	unsigned char		retries;
+	unsigned short 		base = card->base;
+
+	for (retries = 0; retries < 200; retries++) {
+		spin_lock_irqsave(&card->card_lock, card->flags);
+
+		if (inw(base + 0xe) & 0x1)
+			return 1; 
+		else
+			spin_unlock_irqrestore(&card->card_lock, card->flags);
+	}
+	/* Failing in interrupt is an acceptable event */
+	return 0;	/* Failed to aquire the card! */
+}
+
+static void unlock_card(struct isi_board *card)
+{
+	spin_unlock_irqrestore(&card->card_lock, card->flags);
+}
+
+/*
+ *  ISI Card specific ops ...
+ */
+ 
+static void raise_dtr(struct isi_port * port)
+{
+	struct isi_board * card = port->card;
+	unsigned short base = card->base;
+	unsigned char channel = port->channel;
+
+	if (!lock_card(card))
+		return;
+
+	outw(0x8000 | (channel << card->shift_count) | 0x02 , base);
+	outw(0x0504, base);
+	InterruptTheCard(base);
+	port->status |= ISI_DTR;
+	unlock_card(card);
+}
+
+static inline void drop_dtr(struct isi_port * port)
+{	
+	struct isi_board * card = port->card;
+	unsigned short base = card->base;
+	unsigned char channel = port->channel;
+
+	if (!lock_card(card))
+		return;
+
+	outw(0x8000 | (channel << card->shift_count) | 0x02 , base);
+	outw(0x0404, base);
+	InterruptTheCard(base);	
+	port->status &= ~ISI_DTR;
+	unlock_card(card);
+}
+
+static inline void raise_rts(struct isi_port * port)
+{
+	struct isi_board * card = port->card;
+	unsigned short base = card->base;
+	unsigned char channel = port->channel;
+
+	if (!lock_card(card))
+		return;
+
+	outw(0x8000 | (channel << card->shift_count) | 0x02 , base);
+	outw(0x0a04, base);
+	InterruptTheCard(base);	
+	port->status |= ISI_RTS;
+	unlock_card(card);
+}
+static inline void drop_rts(struct isi_port * port)
+{
+	struct isi_board * card = port->card;
+	unsigned short base = card->base;
+	unsigned char channel = port->channel;
+
+	if (!lock_card(card))
+		return;
+
+	outw(0x8000 | (channel << card->shift_count) | 0x02 , base);
+	outw(0x0804, base);
+	InterruptTheCard(base);	
+	port->status &= ~ISI_RTS;
+	unlock_card(card);
+}
+
+static inline void raise_dtr_rts(struct isi_port * port)
+{
+	struct isi_board * card = port->card;
+	unsigned short base = card->base;
+	unsigned char channel = port->channel;
+
+	if (!lock_card(card))
+		return;
+
+	outw(0x8000 | (channel << card->shift_count) | 0x02 , base);
+	outw(0x0f04, base);
+	InterruptTheCard(base);
+	port->status |= (ISI_DTR | ISI_RTS);
+	unlock_card(card);
+}
+
+static void drop_dtr_rts(struct isi_port * port)
+{
+	struct isi_board * card = port->card;
+	unsigned short base = card->base;
+	unsigned char channel = port->channel;
+
+	if (!lock_card(card))
+		return;
+
+	outw(0x8000 | (channel << card->shift_count) | 0x02 , base);
+	outw(0x0c04, base);
+	InterruptTheCard(base);	
+	port->status &= ~(ISI_RTS | ISI_DTR);
+	unlock_card(card);
+}
+
+static inline void kill_queue(struct isi_port * port, short queue)
+{
+	struct isi_board * card = port->card;
+	unsigned short base = card->base;
+	unsigned char channel = port->channel;
+
+	if (!lock_card(card))
+		return;
+
+	outw(0x8000 | (channel << card->shift_count) | 0x02 , base);
+	outw((queue << 8) | 0x06, base);
+	InterruptTheCard(base);	
+	unlock_card(card);
+}
+
+
 /* 
- *  Firmware loader driver specific routines
- *
+ *  Firmware loader driver specific routines. This needs to mostly die
+ *  and be replaced with request_firmware.
  */
 
 static struct file_operations ISILoad_fops = {
@@ -354,15 +624,19 @@
 	return 0;
 }
 			
-/*	Transmitter	*/
+/*
+ *	Transmitter. 
+ *
+ *	We shovel data into the card buffers on a regular basis. The card
+ *	will do the rest of the work for us.
+ */
 
 static void isicom_tx(unsigned long _data)
 {
 	short count = (BOARD_COUNT-1), card, base;
-	short txcount, wait, wrd, residue, word_count, cnt;
+	short txcount, wrd, residue, word_count, cnt;
 	struct isi_port * port;
 	struct tty_struct * tty;
-	unsigned long flags;
 	
 #ifdef ISICOM_DEBUG
 	++tx_count;
@@ -384,33 +658,29 @@
 	port = isi_card[card].ports;
 	base = isi_card[card].base;
 	for (;count > 0;count--, port++) {
+		if (!lock_card_at_interrupt(&isi_card[card]))
+			continue;
 		/* port not active or tx disabled to force flow control */
-		if (!(port->status & ISI_TXOK))
+		if (!(port->flags & ASYNC_INITIALIZED) ||
+		 	!(port->status & ISI_TXOK))
+			unlock_card(&isi_card[card]);
 			continue;
 		
 		tty = port->tty;
-		save_flags(flags); cli();
-		txcount = min_t(short, TX_SIZE, port->xmit_cnt);
-		if ((txcount <= 0) || tty->stopped || tty->hw_stopped) {
-			restore_flags(flags);
+		
+		
+		if(tty == NULL) {
+			unlock_card(&isi_card[card]);
 			continue;
 		}
-		wait = 200;	
-		while(((inw(base+0x0e) & 0x01) == 0) && (wait-- > 0));
-		if (wait <= 0) {
-			restore_flags(flags);
-#ifdef ISICOM_DEBUG
-			printk(KERN_DEBUG "ISICOM: isicom_tx:Card(0x%x) found busy.\n",
-				card);
-#endif
+		
+		txcount = min_t(short, TX_SIZE, port->xmit_cnt);
+		if (txcount <= 0 || tty->stopped || tty->hw_stopped) {
+			unlock_card(&isi_card[card]);
 			continue;
 		}
 		if (!(inw(base + 0x02) & (1 << port->channel))) {
-			restore_flags(flags);
-#ifdef ISICOM_DEBUG					
-			printk(KERN_DEBUG "ISICOM: isicom_tx: cannot tx to 0x%x:%d.\n",
-					base, port->channel + 1);
-#endif					
+			unlock_card(&isi_card[card]);
 			continue;		
 		}
 #ifdef ISICOM_DEBUG
@@ -459,10 +729,10 @@
 			port->status &= ~ISI_TXOK;
 		if (port->xmit_cnt <= WAKEUP_CHARS)
 			schedule_work(&port->bh_tqueue);
-		restore_flags(flags);
+		unlock_card(&isi_card[card]);
 	}	
 
-		/*	schedule another tx for hopefully in about 10ms	*/	
+	/*	schedule another tx for hopefully in about 10ms	*/	
 sched_again:	
 	if (!re_schedule)	
 		return;
@@ -490,7 +760,10 @@
 	wake_up_interruptible(&tty->write_wait);
 } 		
  		
-/* main interrupt handler routine */ 		
+/*
+ *	Main interrupt handler routine 
+ */
+ 
 static irqreturn_t isicom_interrupt(int irq, void *dev_id,
 					struct pt_regs *regs)
 {
@@ -501,31 +774,19 @@
 	unsigned char channel;
 	short byte_count;
 	
-	/*
-	 *      find the source of interrupt
-	 */
-	 
-	for(count = 0; count < BOARD_COUNT; count++) { 
-		card = &isi_card[count];
-		if (card->base != 0) {
-			if (((card->isa == YES) && (card->irq == irq)) || 
-				((card->isa == NO) && (card->irq == irq) && (inw(card->base+0x0e) & 0x02)))
-				break;
-		}
-		card = NULL;
-	}
+	card = (struct isi_board *) dev_id;
 
-	if (!card || !(card->status & FIRMWARE_LOADED)) {
-/*		printk(KERN_DEBUG "ISICOM: interrupt: not handling irq%d!.\n", irq);*/
+	if (!card || !(card->status & FIRMWARE_LOADED))
 		return IRQ_NONE;
-	}
 	
 	base = card->base;
+	spin_lock(&card->card_lock);
+	
 	if (card->isa == NO) {
-	/*
-	 *      disable any interrupts from the PCI card and lower the
-	 *      interrupt line
-	 */
+		/*
+		 *      disable any interrupts from the PCI card and lower the
+		 *      interrupt line
+		 */
 		outw(0x8000, base+0x04);
 		ClearInterrupt(base);
 	}
@@ -534,16 +795,15 @@
 	header = inw(base);
 	channel = (header & 0x7800) >> card->shift_count;
 	byte_count = header & 0xff;
-#ifdef ISICOM_DEBUG	
-	printk(KERN_DEBUG "ISICOM:Intr:(0x%x:%d).\n", base, channel+1);
-#endif	
-	if ((channel+1) > card->port_count) {
+
+	if (channel + 1 > card->port_count) {
 		printk(KERN_WARNING "ISICOM: isicom_interrupt(0x%x): %d(channel) > port_count.\n",
 				base, channel+1);
 		if (card->isa)
 			ClearInterrupt(base);
 		else
 			outw(0x0000, base+0x04); /* enable interrupts */		
+		spin_unlock(&card->card_lock);
 		return IRQ_HANDLED;			
 	}
 	port = card->ports + channel;
@@ -556,6 +816,21 @@
 	}	
 		
 	tty = port->tty;
+	if (tty == NULL) {
+		word_count = byte_count >> 1;
+		while(byte_count > 1) {
+			inw(base);
+			byte_count -= 2;
+		}
+		if (byte_count & 0x01)
+			inw(base);
+		if (card->isa == YES)
+			ClearInterrupt(base);
+		else
+			outw(0x0000, base+0x04); /* enable interrupts */
+		spin_unlock(&card->card_lock);
+		return IRQ_HANDLED;
+	}
 	
 	if (header & 0x8000) {		/* Status Packet */
 		header = inw(base);
@@ -631,7 +906,6 @@
 				if (tty->flip.count >= TTY_FLIPBUF_SIZE)
 					break;
 				*tty->flip.flag_buf_ptr++ = TTY_BREAK;
-				/* dunno if this is right */	
 				*tty->flip.char_buf_ptr++ = 0;
 				tty->flip.count++;
 				if (port->flags & ASYNC_SAK)
@@ -683,13 +957,12 @@
 	return IRQ_HANDLED;
 } 
 
- /* called with interrupts disabled */ 
 static void isicom_config_port(struct isi_port * port)
 {
 	struct isi_board * card = port->card;
 	struct tty_struct * tty;
 	unsigned long baud;
-	unsigned short channel_setup, wait, base = card->base;
+	unsigned short channel_setup, base = card->base;
 	unsigned short channel = port->channel, shift_count = card->shift_count;
 	unsigned char flow_ctrl;
 	
@@ -729,40 +1002,36 @@
 	else  
 		raise_dtr(port);
 		
-	wait = 100;	
-	while (((inw(base + 0x0e) & 0x0001) == 0) && (wait-- > 0));	
-	if (!wait) {
-		printk(KERN_WARNING "ISICOM: Card found busy in isicom_config_port at channel setup.\n");
-		return;
-	}			 
-	outw(0x8000 | (channel << shift_count) |0x03, base);
-	outw(linuxb_to_isib[baud] << 8 | 0x03, base);
-	channel_setup = 0;
-	switch(C_CSIZE(tty)) {
-		case CS5:
-			channel_setup |= ISICOM_CS5;
-			break;
-		case CS6:
-			channel_setup |= ISICOM_CS6;
-			break;
-		case CS7:
-			channel_setup |= ISICOM_CS7;
-			break;
-		case CS8:
-			channel_setup |= ISICOM_CS8;
-			break;
-	}
-		
-	if (C_CSTOPB(tty))
-		channel_setup |= ISICOM_2SB;
-	
-	if (C_PARENB(tty))
-		channel_setup |= ISICOM_EVPAR;
-	if (C_PARODD(tty))
-		channel_setup |= ISICOM_ODPAR;	
-	outw(channel_setup, base);	
-	InterruptTheCard(base);
-	
+	if (lock_card(card)) {
+		outw(0x8000 | (channel << shift_count) |0x03, base);
+		outw(linuxb_to_isib[baud] << 8 | 0x03, base);
+		channel_setup = 0;
+		switch(C_CSIZE(tty)) {
+			case CS5:
+				channel_setup |= ISICOM_CS5;
+				break;
+			case CS6:
+				channel_setup |= ISICOM_CS6;
+				break;
+			case CS7:
+				channel_setup |= ISICOM_CS7;
+				break;
+			case CS8:
+				channel_setup |= ISICOM_CS8;
+				break;
+		}
+			
+		if (C_CSTOPB(tty))
+			channel_setup |= ISICOM_2SB;
+		if (C_PARENB(tty)) {
+			channel_setup |= ISICOM_EVPAR;
+			if (C_PARODD(tty))
+				channel_setup |= ISICOM_ODPAR;	
+		}
+		outw(channel_setup, base);	
+		InterruptTheCard(base);
+		unlock_card(card);	
+	}	
 	if (C_CLOCAL(tty))
 		port->flags &= ~ASYNC_CHECK_CD;
 	else
@@ -780,23 +1049,19 @@
 	if (I_IXOFF(tty))
 		flow_ctrl |= ISICOM_INITIATE_XONXOFF;	
 		
-	wait = 100;	
-	while (((inw(base + 0x0e) & 0x0001) == 0) && (wait-- > 0));	
-	if (!wait) {
-		printk(KERN_WARNING "ISICOM: Card found busy in isicom_config_port at flow setup.\n");
-		return;
-	}			 
-	outw(0x8000 | (channel << shift_count) |0x04, base);
-	outw(flow_ctrl << 8 | 0x05, base);
-	outw((STOP_CHAR(tty)) << 8 | (START_CHAR(tty)), base);
-	InterruptTheCard(base);
+	if (lock_card(card)) {
+		outw(0x8000 | (channel << shift_count) |0x04, base);
+		outw(flow_ctrl << 8 | 0x05, base);
+		outw((STOP_CHAR(tty)) << 8 | (START_CHAR(tty)), base);
+		InterruptTheCard(base);
+		unlock_card(card);
+	}
 	
 	/*	rx enabled -> enable port for rx on the card	*/
 	if (C_CREAD(tty)) {
 		card->port_status |= (1 << channel);
 		outw(card->port_status, base + 0x02);
 	}
-		
 }
  
 /* open et all */ 
@@ -807,22 +1072,16 @@
 	struct isi_port * port;
 	unsigned long flags;
 	
-	if (bp->status & BOARD_ACTIVE) 
+	spin_lock_irqsave(&bp->card_lock, flags);
+	if (bp->status & BOARD_ACTIVE) {
+		spin_unlock_irqrestore(&bp->card_lock, flags);
 		return;
-	port = bp->ports;
-#ifdef ISICOM_DEBUG	
-	printk(KERN_DEBUG "ISICOM: setup_board: drop_dtr_rts start, port_count %d...\n", bp->port_count);
-#endif
-	for(channel = 0; channel < bp->port_count; channel++, port++) {
-		save_flags(flags); cli();
-		drop_dtr_rts(port);
-		restore_flags(flags);
 	}
-#ifdef ISICOM_DEBUG		
-	printk(KERN_DEBUG "ISICOM: setup_board: drop_dtr_rts stop...\n");	
-#endif	
-	
+	port = bp->ports;
 	bp->status |= BOARD_ACTIVE;
+	spin_unlock_irqrestore(&bp->card_lock, flags);
+	for(channel = 0; channel < bp->port_count; channel++, port++)
+		drop_dtr_rts(port);
 	return;
 }
  
@@ -831,8 +1090,9 @@
 	struct isi_board * card = port->card;
 	unsigned long flags;
 	
-	if (port->flags & ASYNC_INITIALIZED)
+	if (port->flags & ASYNC_INITIALIZED) {
 		return 0;
+	}
 	if (!port->xmit_buf) {
 		unsigned long page;
 		
@@ -845,7 +1105,8 @@
 		}
 		port->xmit_buf = (unsigned char *) page;	
 	}	
-	save_flags(flags); cli();
+
+	spin_lock_irqsave(&card->card_lock, flags);
 	if (port->tty)
 		clear_bit(TTY_IO_ERROR, &port->tty->flags);
 	if (port->count == 1)
@@ -858,15 +1119,16 @@
 	
 	isicom_config_port(port);
 	port->flags |= ASYNC_INITIALIZED;
-	
-	restore_flags(flags);
+	spin_unlock_irqrestore(&card->card_lock, flags);
 	
 	return 0;		
 } 
  
 static int block_til_ready(struct tty_struct * tty, struct file * filp, struct isi_port * port) 
 {
+	struct isi_board * card = port->card;
 	int do_clocal = 0, retval;
+	unsigned long flags;
 	DECLARE_WAITQUEUE(wait, current);
 
 	/* block if port is in the process of being closed */
@@ -894,49 +1156,34 @@
 	
 	if (C_CLOCAL(tty))
 		do_clocal = 1;
-#ifdef ISICOM_DEBUG	
-	if (do_clocal)
-		printk(KERN_DEBUG "ISICOM: block_til_ready: CLOCAL set.\n");
-#endif 		
 	
 	/* block waiting for DCD to be asserted, and while 
 						callout dev is busy */
 	retval = 0;
 	add_wait_queue(&port->open_wait, &wait);
-	cli();
-		if (!tty_hung_up_p(filp))
-			port->count--;
-	sti();
+
+	spin_lock_irqsave(&card->card_lock, flags);
+	if (!tty_hung_up_p(filp))
+		port->count--;
 	port->blocked_open++;
-#ifdef ISICOM_DEBUG	
-	printk(KERN_DEBUG "ISICOM: block_til_ready: waiting for DCD...\n");
-#endif	
+	spin_unlock_irqrestore(&card->card_lock, flags);
+	
 	while (1) {
-		cli();
 		raise_dtr_rts(port);
-		sti();
+
 		set_current_state(TASK_INTERRUPTIBLE);
 		if (tty_hung_up_p(filp) || !(port->flags & ASYNC_INITIALIZED)) { 	
 			if (port->flags & ASYNC_HUP_NOTIFY)
 				retval = -EAGAIN;
 			else
 				retval = -ERESTARTSYS;
-#ifdef ISICOM_DEBUG				
-			printk(KERN_DEBUG "ISICOM: block_til_ready: tty_hung_up_p || not init.\n"); 
-#endif			
 			break;
 		}	
 		if (!(port->flags & ASYNC_CLOSING) &&
 		    (do_clocal || (port->status & ISI_DCD))) {
-#ifdef ISICOM_DEBUG		    
-		 	printk(KERN_DEBUG "ISICOM: block_til_ready: do_clocal || DCD.\n");   
-#endif		 	
 			break;
 		}	
 		if (signal_pending(current)) {
-#ifdef ISICOM_DEBUG		
-			printk(KERN_DEBUG "ISICOM: block_til_ready: sig blocked.\n");
-#endif			
 			retval = -ERESTARTSYS;
 			break;
 		}
@@ -944,9 +1191,11 @@
 	}
 	set_current_state(TASK_RUNNING);
 	remove_wait_queue(&port->open_wait, &wait);
+	spin_lock_irqsave(&card->card_lock, flags);
 	if (!tty_hung_up_p(filp))
 		port->count++;
 	port->blocked_open--;
+	spin_unlock_irqrestore(&card->card_lock, flags);
 	if (retval)
 		return retval;
 	port->flags |= ASYNC_NORMAL_ACTIVE;
@@ -960,62 +1209,33 @@
 	unsigned int line, board;
 	int error;
 
-#ifdef ISICOM_DEBUG	
-	printk(KERN_DEBUG "ISICOM: open start!!!.\n");
-#endif	
 	line = tty->index;
-	
-#ifdef ISICOM_DEBUG	
-	printk(KERN_DEBUG "line = %d.\n", line);
-#endif	
-	
-	if ((line < 0) || (line > (PORT_COUNT-1)))
+	if (line < 0 || line > PORT_COUNT-1)
 		return -ENODEV;
 	board = BOARD(line);
-	
-#ifdef ISICOM_DEBUG	
-	printk(KERN_DEBUG "board = %d.\n", board);
-#endif	
-	
 	card = &isi_card[board];
-	if (!(card->status & FIRMWARE_LOADED)) {
-#ifdef ISICOM_DEBUG	
-		printk(KERN_DEBUG"ISICOM: Firmware not loaded to card%d.\n", board);
-#endif		
+	
+	if (!(card->status & FIRMWARE_LOADED))
 		return -ENODEV;
-	}
 	
 	/*  open on a port greater than the port count for the card !!! */
-	if (line > ((board * 16) + card->port_count - 1)) {
-		printk(KERN_ERR "ISICOM: Open on a port which exceeds the port_count of the card!\n");
+	if (line > ((board * 16) + card->port_count - 1))
 		return -ENODEV;
-	}	
+
 	port = &isi_ports[line];	
 	if (isicom_paranoia_check(port, tty->name, "isicom_open"))
 		return -ENODEV;
 		
-#ifdef ISICOM_DEBUG		
-	printk(KERN_DEBUG "ISICOM: isicom_setup_board ...\n");		
-#endif	
 	isicom_setup_board(card);		
 	
 	port->count++;
 	tty->driver_data = port;
 	port->tty = tty;
-#ifdef ISICOM_DEBUG	
-	printk(KERN_DEBUG "ISICOM: isicom_setup_port ...\n");
-#endif	
 	if ((error = isicom_setup_port(port))!=0)
 		return error;
-#ifdef ISICOM_DEBUG		
-	printk(KERN_DEBUG "ISICOM: block_til_ready ...\n");	
-#endif	
 	if ((error = block_til_ready(tty, filp, port))!=0)
 		return error;
 
-#ifdef ISICOM_DEBUG	
-	printk(KERN_DEBUG "ISICOM: open end!!!.\n");
-#endif	
 	return 0;      		
 }
  
@@ -1023,38 +1243,50 @@
 
 static inline void isicom_shutdown_board(struct isi_board * bp)
 {
-	int channel;
-	struct isi_port * port;
-	
-	if (!(bp->status & BOARD_ACTIVE))
-		return;
-	bp->status &= ~BOARD_ACTIVE;
-	port = bp->ports;
-	for(channel = 0; channel < bp->port_count; channel++, port++) {
-		drop_dtr_rts(port);
-	}	
+	unsigned long flags;
+
+	spin_lock_irqsave(&bp->card_lock, flags);
+	if (bp->status & BOARD_ACTIVE) {
+		bp->status &= ~BOARD_ACTIVE;
+	}
+	spin_unlock_irqrestore(&bp->card_lock, flags);
 }
 
 static void isicom_shutdown_port(struct isi_port * port)
 {
 	struct isi_board * card = port->card;
 	struct tty_struct * tty;	
+	unsigned long flags;
 	
-	if (!(port->flags & ASYNC_INITIALIZED))
+	tty = port->tty;
+
+	spin_lock_irqsave(&card->card_lock, flags);	
+	if (!(port->flags & ASYNC_INITIALIZED)) {
+		spin_unlock_irqrestore(&card->card_lock, flags);
 		return;
+	}
 	if (port->xmit_buf) {
 		free_page((unsigned long) port->xmit_buf);
 		port->xmit_buf = NULL;
 	}	
-	if (!(tty = port->tty) || C_HUPCL(tty)) 
+	port->flags &= ~ASYNC_INITIALIZED;
+	/* 3rd October 2000 : Vinayak P Risbud */
+	port->tty = 0;
+	spin_unlock_irqrestore(&card->card_lock, flags);
+	
+	/*Fix done by Anil .S on 30-04-2001
+	remote login through isi port has dtr toggle problem
+	due to which the carrier drops before the password prompt
+	appears on the remote end. Now we drop the dtr only if the 
+	HUPCL(Hangup on close) flag is set for the tty*/
+	
+	if (C_HUPCL(tty)) 
 		/* drop dtr on this port */
 		drop_dtr(port);
 		
 	/* any other port uninits  */ 
-	
 	if (tty)
 		set_bit(TTY_IO_ERROR, &tty->flags);
-	port->flags &= ~ASYNC_INITIALIZED;
 	
 	if (--card->count < 0) {
 		printk(KERN_DEBUG "ISICOM: isicom_shutdown_port: bad board(0x%x) count %d.\n",
@@ -1063,8 +1295,10 @@
 	}
 	
 	/* last port was closed , shutdown that boad too */
-	if (!card->count)
-		isicom_shutdown_board(card);
+	if(C_HUPCL(tty)) {
+		if (!card->count)
+			isicom_shutdown_board(card);
+	}
 }
 
 static void isicom_close(struct tty_struct * tty, struct file * filp)
@@ -1082,13 +1316,13 @@
 	printk(KERN_DEBUG "ISICOM: Close start!!!.\n");
 #endif	
 	
-	save_flags(flags); cli();
+	spin_lock_irqsave(&card->card_lock, flags);
 	if (tty_hung_up_p(filp)) {
-		restore_flags(flags);
+		spin_unlock_irqrestore(&card->card_lock, flags);
 		return;
 	}
 	
-	if ((tty->count == 1) && (port->count != 1)) {
+	if (tty->count == 1 && port->count != 1) {
 		printk(KERN_WARNING "ISICOM:(0x%x) isicom_close: bad port count"
 			"tty->count = 1	port count = %d.\n",
 			card->base, port->count);
@@ -1102,41 +1336,46 @@
 	}
 	
 	if (port->count) {
-		restore_flags(flags);
+		spin_unlock_irqrestore(&card->card_lock, flags);
 		return;
 	} 	
 	port->flags |= ASYNC_CLOSING;
 	tty->closing = 1;
+	spin_unlock_irqrestore(&card->card_lock, flags);
+	
 	if (port->closing_wait != ASYNC_CLOSING_WAIT_NONE)
 		tty_wait_until_sent(tty, port->closing_wait);
 	/* indicate to the card that no more data can be received 
 	   on this port */
+	spin_lock_irqsave(&card->card_lock, flags);
 	if (port->flags & ASYNC_INITIALIZED) {   
 		card->port_status &= ~(1 << port->channel);
 		outw(card->port_status, card->base + 0x02);
 	}	
 	isicom_shutdown_port(port);
+	spin_unlock_irqrestore(&card->card_lock, flags);
+	
 	if (tty->driver->flush_buffer)
 		tty->driver->flush_buffer(tty);
-		
 	tty_ldisc_flush(tty);
+
+	spin_lock_irqsave(&card->card_lock, flags);
 	tty->closing = 0;
-	port->tty = NULL;
+
 	if (port->blocked_open) {
+		spin_unlock_irqrestore(&card->card_lock, flags);
 		if (port->close_delay) {
 #ifdef ISICOM_DEBUG			
 			printk(KERN_DEBUG "ISICOM: scheduling until time out.\n");
 #endif			
 			msleep_interruptible(jiffies_to_msecs(port->close_delay));
 		}
+		spin_lock_irqsave(&card->card_lock, flags);
 		wake_up_interruptible(&port->open_wait);
 	}	
 	port->flags &= ~(ASYNC_NORMAL_ACTIVE | ASYNC_CLOSING);
 	wake_up_interruptible(&port->close_wait);
-	restore_flags(flags);
-#ifdef ISICOM_DEBUG	
-	printk(KERN_DEBUG "ISICOM: Close end!!!.\n");
-#endif	
+	spin_unlock_irqrestore(&card->card_lock, flags);
 }
 
 /* write et all */
@@ -1144,21 +1383,19 @@
 			const unsigned char * buf, int count)
 {
 	struct isi_port * port = (struct isi_port *) tty->driver_data;
+	struct isi_board * card = port->card;
 	unsigned long flags;
 	int cnt, total = 0;
-#ifdef ISICOM_DEBUG
-	printk(KERN_DEBUG "ISICOM: isicom_write for port%d: %d bytes.\n",
-			port->channel+1, count);
-#endif	  	
+
 	if (isicom_paranoia_check(port, tty->name, "isicom_write"))
 		return 0;
 	
 	if (!tty || !port->xmit_buf || !tmp_buf)
 		return 0;
 		
-	save_flags(flags);
+	spin_lock_irqsave(&card->card_lock, flags);
+	
 	while(1) {	
-		cli();
 		cnt = min_t(int, count, min(SERIAL_XMIT_SIZE - port->xmit_cnt - 1,
 					    SERIAL_XMIT_SIZE - port->xmit_head));
 		if (cnt <= 0) 
@@ -1167,17 +1404,13 @@
 		memcpy(port->xmit_buf + port->xmit_head, buf, cnt);
 		port->xmit_head = (port->xmit_head + cnt) & (SERIAL_XMIT_SIZE - 1);
 		port->xmit_cnt += cnt;
-		restore_flags(flags);
 		buf += cnt;
 		count -= cnt;
 		total += cnt;
 	}		
 	if (port->xmit_cnt && !tty->stopped && !tty->hw_stopped)
 		port->status |= ISI_TXOK;
-	restore_flags(flags);
-#ifdef ISICOM_DEBUG
-	printk(KERN_DEBUG "ISICOM: isicom_write %d bytes written.\n", total);
-#endif		
+	spin_unlock_irqrestore(&card->card_lock, flags);
 	return total;	
 }
 
@@ -1185,6 +1418,7 @@
 static void isicom_put_char(struct tty_struct * tty, unsigned char ch)
 {
 	struct isi_port * port = (struct isi_port *) tty->driver_data;
+	struct isi_board * card = port->card;
 	unsigned long flags;
 	
 	if (isicom_paranoia_check(port, tty->name, "isicom_put_char"))
@@ -1192,21 +1426,17 @@
 	
 	if (!tty || !port->xmit_buf)
 		return;
-#ifdef ISICOM_DEBUG
-	printk(KERN_DEBUG "ISICOM: put_char, port %d, char %c.\n", port->channel+1, ch);
-#endif			
-		
-	save_flags(flags); cli();
-	
-	if (port->xmit_cnt >= (SERIAL_XMIT_SIZE - 1)) {
-		restore_flags(flags);
+
+	spin_lock_irqsave(&card->card_lock, flags);
+	if (port->xmit_cnt >= SERIAL_XMIT_SIZE - 1) {
+		spin_unlock_irqrestore(&card->card_lock, flags);
 		return;
 	}
 	
 	port->xmit_buf[port->xmit_head++] = ch;
 	port->xmit_head &= (SERIAL_XMIT_SIZE - 1);
 	port->xmit_cnt++;
-	restore_flags(flags);
+	spin_unlock_irqrestore(&card->card_lock, flags);
 }
 
 /* flush_chars et all */
@@ -1217,8 +1447,7 @@
 	if (isicom_paranoia_check(port, tty->name, "isicom_flush_chars"))
 		return;
 	
-	if (port->xmit_cnt <= 0 || tty->stopped || tty->hw_stopped ||
-	    !port->xmit_buf)
+	if (port->xmit_cnt <= 0 || tty->stopped || tty->hw_stopped || !port->xmit_buf)
 		return;
 		
 	/* this tells the transmitter to consider this port for
@@ -1231,6 +1460,7 @@
 {
 	struct isi_port * port = (struct isi_port *) tty->driver_data;
 	int free;
+
 	if (isicom_paranoia_check(port, tty->name, "isicom_write_room"))
 		return 0;
 	
@@ -1253,21 +1483,17 @@
 static inline void isicom_send_break(struct isi_port * port, unsigned long length)
 {
 	struct isi_board * card = port->card;
-	short wait = 10;
 	unsigned short base = card->base;	
-	unsigned long flags;
 	
-	save_flags(flags); cli();
-	while (((inw(base + 0x0e) & 0x0001) == 0) && (wait-- > 0));	
-	if (!wait) {
-		printk(KERN_DEBUG "ISICOM: Card found busy in isicom_send_break.\n");
-		goto out;
-	}	
+	if(!lock_card(card))
+		return;
+		
 	outw(0x8000 | ((port->channel) << (card->shift_count)) | 0x3, base);
 	outw((length & 0xff) << 8 | 0x00, base);
 	outw((length & 0xff00), base);
 	InterruptTheCard(base);
-out:	restore_flags(flags);
+
+	unlock_card(card);
 }
 
 static int isicom_tiocmget(struct tty_struct *tty, struct file *file)
@@ -1291,12 +1517,10 @@
 			   unsigned int set, unsigned int clear)
 {
 	struct isi_port * port = (struct isi_port *) tty->driver_data;
-	unsigned long flags;
 	
 	if (isicom_paranoia_check(port, tty->name, "isicom_ioctl"))
 		return -ENODEV;
 	
-	save_flags(flags); cli();
 	if (set & TIOCM_RTS)
 		raise_rts(port);
 	if (set & TIOCM_DTR)
@@ -1307,7 +1531,6 @@
 	if (clear & TIOCM_DTR)
 		drop_dtr(port);
 
-	restore_flags(flags);
 	return 0;
 }			
 
@@ -1315,7 +1538,6 @@
 					struct serial_struct __user *info)
 {
 	struct serial_struct newinfo;
-	unsigned long flags;
 	int reconfig_port;
 
 	if(copy_from_user(&newinfo, info, sizeof(newinfo)))
@@ -1340,9 +1562,7 @@
 				(newinfo.flags & ASYNC_FLAGS));
 	}
 	if (reconfig_port) {
-		save_flags(flags); cli();
 		isicom_config_port(port);
-		restore_flags(flags);
 	}
 	return 0;		 
 }		
@@ -1421,7 +1641,6 @@
 static void isicom_set_termios(struct tty_struct * tty, struct termios * old_termios)
 {
 	struct isi_port * port = (struct isi_port *) tty->driver_data;
-	unsigned long flags;
 	
 	if (isicom_paranoia_check(port, tty->name, "isicom_set_termios"))
 		return;
@@ -1430,9 +1649,7 @@
 	    tty->termios->c_iflag == old_termios->c_iflag)
 		return;
 		
-	save_flags(flags); cli();
 	isicom_config_port(port);
-	restore_flags(flags);
 	
 	if ((old_termios->c_cflag & CRTSCTS) &&
 	    !(tty->termios->c_cflag & CRTSCTS)) {	
@@ -1446,16 +1663,13 @@
 {
 	struct isi_port * port = (struct isi_port *) tty->driver_data;
 	struct isi_board * card = port->card;
-	unsigned long flags;
 	
 	if (isicom_paranoia_check(port, tty->name, "isicom_throttle"))
 		return;
 	
 	/* tell the card that this port cannot handle any more data for now */
-	save_flags(flags); cli();
 	card->port_status &= ~(1 << port->channel);
 	outw(card->port_status, card->base + 0x02);
-	restore_flags(flags);
 }
 
 /* unthrottle et all */
@@ -1463,16 +1677,13 @@
 {
 	struct isi_port * port = (struct isi_port *) tty->driver_data;
 	struct isi_board * card = port->card;
-	unsigned long flags;
 	
 	if (isicom_paranoia_check(port, tty->name, "isicom_unthrottle"))
 		return;
 	
 	/* tell the card that this port is ready to accept more data */
-	save_flags(flags); cli();
 	card->port_status |= (1 << port->channel);
 	outw(card->port_status, card->base + 0x02);
-	restore_flags(flags);
 }
 
 /* stop et all */
@@ -1509,7 +1720,7 @@
 	
 	tty = port->tty;
 	if (tty)
-		tty_hangup(tty);	/* FIXME: module removal race here - AKPM */
+		tty_hangup(tty);
 }
 
 static void isicom_hangup(struct tty_struct * tty)
@@ -1530,21 +1741,22 @@
 static void isicom_flush_buffer(struct tty_struct * tty)
 {
 	struct isi_port * port = (struct isi_port *) tty->driver_data;
+	struct isi_board * card = port->card;
 	unsigned long flags;
 	
 	if (isicom_paranoia_check(port, tty->name, "isicom_flush_buffer"))
 		return;
 	
-	save_flags(flags); cli();
+	spin_lock_irqsave(&card->card_lock, flags);
 	port->xmit_cnt = port->xmit_head = port->xmit_tail = 0;
-	restore_flags(flags);
+	spin_unlock_irqrestore(&card->card_lock, flags);
 	
 	wake_up_interruptible(&tty->write_wait);
 	tty_wakeup(tty);
 }
 
 
-static int register_ioregion(void)
+static int __init register_ioregion(void)
 {
 	int count, done=0;
 	for (count=0; count < BOARD_COUNT; count++ ) {
@@ -1559,7 +1771,7 @@
 	return done;
 }
 
-static void unregister_ioregion(void)
+static void __exit unregister_ioregion(void)
 {
 	int count;
 	for (count=0; count < BOARD_COUNT; count++ ) 
@@ -1591,7 +1803,7 @@
 	.tiocmset	= isicom_tiocmset,
 };
 
-static int register_drivers(void)
+static int __init register_drivers(void)
 {
 	int error;
 
@@ -1622,7 +1834,7 @@
 	return 0;
 }
 
-static void unregister_drivers(void)
+static void __exit unregister_drivers(void)
 {
 	int error = tty_unregister_driver(isicom_normal);
 	if (error)
@@ -1630,78 +1842,48 @@
 	put_tty_driver(isicom_normal);
 }
 
-static int register_isr(void)
+static int __init register_isr(void)
 {
-	int count, done=0, card;
-	int flag;
-	unsigned char request;
+	int count, done=0;
+	unsigned long irqflags;
+
 	for (count=0; count < BOARD_COUNT; count++ ) {
 		if (isi_card[count].base) {
-		/*
-		 * verify if the required irq has already been requested for
-		 * another ISI Card, if so we already have it, else request it
-		 */
-			request = YES;
-			for(card = 0; card < count; card++)
-			if ((isi_card[card].base) && (isi_card[card].irq == isi_card[count].irq)) {
-				request = NO;
-				if ((isi_card[count].isa == NO) && (isi_card[card].isa == NO))
-					break;
-				/*
-				 * ISA cards cannot share interrupts with other
-				 * PCI or ISA devices hence disable this card.
-				 */
+			irqflags = (isi_card[count].isa == YES) ? 
+					SA_INTERRUPT : 
+					(SA_INTERRUPT | SA_SHIRQ);
+
+			if (request_irq(isi_card[count].irq, 
+					isicom_interrupt, 
+					irqflags, 
+					ISICOM_NAME, &isi_card[count])) {
+
+				printk(KERN_WARNING "ISICOM: Could not"
+					" install handler at Irq %d."
+					" Card%d will be disabled.\n",
+					isi_card[count].irq, count+1);
+
 				release_region(isi_card[count].base,16);
-				isi_card[count].base = 0;
-				break;
-			}
-			flag=0;
-			if(isi_card[count].isa == NO)
-				flag |= SA_SHIRQ;
-				
-			if (request == YES) { 
-				if (request_irq(isi_card[count].irq, isicom_interrupt, SA_INTERRUPT|flag, ISICOM_NAME, NULL)) {
-					printk(KERN_WARNING "ISICOM: Could not install handler at Irq %d. Card%d will be disabled.\n",
-						isi_card[count].irq, count+1);
-					release_region(isi_card[count].base,16);
-					isi_card[count].base=0;
-				}
-				else {
-					printk(KERN_INFO "ISICOM: Card%d at 0x%x using irq %d.\n", 
-					count+1, isi_card[count].base, isi_card[count].irq); 
-					
-					irq_to_board[isi_card[count].irq]=&isi_card[count];
-					done++;
-				}
+				isi_card[count].base=0;
 			}
+			else
+				done++;
 		}	
 	}
 	return done;
 }
 
-static void unregister_isr(void)
+static void __exit unregister_isr(void)
 {
-	int count, card;
-	unsigned char freeirq;
+	int count;
+
 	for (count=0; count < BOARD_COUNT; count++ ) {
-		if (isi_card[count].base) {
-			freeirq = YES;
-			for(card = 0; card < count; card++)
-				if ((isi_card[card].base) && (isi_card[card].irq == isi_card[count].irq)) {
-					freeirq = NO;
-					break;
-				}
-			if (freeirq == YES) {
-				free_irq(isi_card[count].irq, NULL);
-#ifdef ISICOM_DEBUG			
-				printk(KERN_DEBUG "ISICOM: Irq %d released for Card%d.\n",isi_card[count].irq, count+1);
-#endif	
-			}		
-		}
+		if (isi_card[count].base)
+			free_irq(isi_card[count].irq, &isi_card[count]);
 	}
 }
 
-static int isicom_init(void)
+static int __init isicom_init(void)
 {
 	int card, channel, base;
 	struct isi_port * port;
@@ -1744,11 +1926,12 @@
 	for (card = 0; card < BOARD_COUNT; card++) {
 		port = &isi_ports[card * 16];
 		isi_card[card].ports = port;
+		spin_lock_init(&isi_card[card].card_lock);
 		base = isi_card[card].base;
 		for (channel = 0; channel < 16; channel++, port++) {
 			port->magic = ISICOM_MAGIC;
 			port->card = &isi_card[card];
-			port->channel = channel;		
+			port->channel = channel;
 		 	port->close_delay = 50 * HZ/100;
 		 	port->closing_wait = 3000 * HZ/100;
 		 	INIT_WORK(&port->hangup_tq, do_isicom_hangup, port);
@@ -1778,7 +1961,7 @@
 module_param_array(irq, int, NULL, 0);
 MODULE_PARM_DESC(irq, "Interrupts for the cards");
 
-int init_module(void)
+static int __devinit isicom_setup(void)
 {
 	struct pci_dev *dev = NULL;
 	int retval, card, idx, count;
@@ -1878,38 +2061,19 @@
 	return 0;
 }
 
-void cleanup_module(void)
+static void __exit isicom_exit(void)
 {
 	re_schedule = 0;
+	/* FIXME */
 	msleep(1000);
-
-#ifdef ISICOM_DEBUG	
-	printk("ISICOM: isicom_tx tx_count = %ld.\n", tx_count);
-#endif	
-
-#ifdef ISICOM_DEBUG
-	printk("ISICOM: uregistering isr ...\n");
-#endif	
 	unregister_isr();
-
-#ifdef ISICOM_DEBUG	
-	printk("ISICOM: unregistering drivers ...\n");
-#endif
 	unregister_drivers();
-	
-#ifdef ISICOM_DEBUG	
-	printk("ISICOM: unregistering ioregion ...\n");
-#endif	
 	unregister_ioregion();	
-	
-#ifdef ISICOM_DEBUG	
-	printk("ISICOM: freeing tmp_buf ...\n");
-#endif	
-	free_page((unsigned long)tmp_buf);
-	
-#ifdef ISICOM_DEBUG		
-	printk("ISICOM: unregistering firmware loader ...\n");	
-#endif
+	if(tmp_buf)
+		free_page((unsigned long)tmp_buf);
 	if (misc_deregister(&isiloader_device))
 		printk(KERN_ERR "ISICOM: Unable to unregister Firmware Loader driver\n");
 }
+
+module_init(isicom_setup);
+module_exit(isicom_exit);
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.10/drivers/char/Kconfig linux-2.6.10/drivers/char/Kconfig
--- linux.vanilla-2.6.10/drivers/char/Kconfig	2004-12-25 21:15:34.000000000 +0000
+++ linux-2.6.10/drivers/char/Kconfig	2005-01-06 18:42:17.818221664 +0000
@@ -203,7 +203,7 @@
 
 config ISI
 	tristate "Multi-Tech multiport card support (EXPERIMENTAL)"
-	depends on SERIAL_NONSTANDARD && PCI && EXPERIMENTAL && BROKEN_ON_SMP && m
+	depends on SERIAL_NONSTANDARD
 	help
 	  This is a driver for the Multi-Tech cards which provide several
 	  serial ports.  The driver is experimental and can currently only be
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.10/include/linux/isicom.h linux-2.6.10/include/linux/isicom.h
--- linux.vanilla-2.6.10/include/linux/isicom.h	2004-12-25 21:13:59.000000000 +0000
+++ linux-2.6.10/include/linux/isicom.h	2005-01-06 18:28:29.859090584 +0000
@@ -125,179 +125,6 @@
 
 #define		ISI_TXOK		0x0001 
  
-struct	isi_board {
-	unsigned short		base;
-	unsigned char		irq;
-	unsigned char		port_count;
-	unsigned short		status;
-	unsigned short		port_status; /* each bit represents a single port */
-	unsigned short		shift_count;
-	struct isi_port		* ports;
-	signed char		count;
-	unsigned char		isa;
-};
-
-struct	isi_port {
-	unsigned short		magic;
-	unsigned int		flags;
-	int			count;
-	int			blocked_open;
-	int			close_delay;
-	unsigned short		channel;
-	unsigned short		status;
-	unsigned short		closing_wait;
-	struct isi_board	* card;
-	struct tty_struct 	* tty;
-	wait_queue_head_t	close_wait;
-	wait_queue_head_t	open_wait;
-	struct work_struct	hangup_tq;
-	struct work_struct	bh_tqueue;
-	unsigned char		* xmit_buf;
-	int			xmit_head;
-	int			xmit_tail;
-	int			xmit_cnt;
-};
-
-
-/*
- *  ISI Card specific ops ...
- */
- 
-static inline void raise_dtr(struct isi_port * port)
-{
-	struct isi_board * card = port->card;
-	unsigned short base = card->base;
-	unsigned char channel = port->channel;
-	short wait=400;
-	while(((inw(base+0x0e) & 0x01) == 0) && (wait-- > 0));
-	if (wait <= 0) {
-		printk(KERN_WARNING "ISICOM: Card found busy in raise_dtr.\n");
-		return;
-	}
-#ifdef ISICOM_DEBUG_DTR_RTS	
-	printk(KERN_DEBUG "ISICOM: raise_dtr.\n");
-#endif	
-	outw(0x8000 | (channel << card->shift_count) | 0x02 , base);
-	outw(0x0504, base);
-	InterruptTheCard(base);
-	port->status |= ISI_DTR;
-}
-
-static inline void drop_dtr(struct isi_port * port)
-{	
-	struct isi_board * card = port->card;
-	unsigned short base = card->base;
-	unsigned char channel = port->channel;
-	short wait=400;
-	while(((inw(base+0x0e) & 0x01) == 0) && (wait-- > 0));
-	if (wait <= 0) {
-		printk(KERN_WARNING "ISICOM: Card found busy in drop_dtr.\n");
-		return;
-	}
-#ifdef ISICOM_DEBUG_DTR_RTS	
-	printk(KERN_DEBUG "ISICOM: drop_dtr.\n");
-#endif	
-	outw(0x8000 | (channel << card->shift_count) | 0x02 , base);
-	outw(0x0404, base);
-	InterruptTheCard(base);	
-	port->status &= ~ISI_DTR;
-}
-static inline void raise_rts(struct isi_port * port)
-{
-	struct isi_board * card = port->card;
-	unsigned short base = card->base;
-	unsigned char channel = port->channel;
-	short wait=400;
-	while(((inw(base+0x0e) & 0x01) == 0) && (wait-- > 0));
-	if (wait <= 0) {
-		printk(KERN_WARNING "ISICOM: Card found busy in raise_rts.\n");
-		return;
-	}
-#ifdef ISICOM_DEBUG_DTR_RTS	
-	printk(KERN_DEBUG "ISICOM: raise_rts.\n");
-#endif	
-	outw(0x8000 | (channel << card->shift_count) | 0x02 , base);
-	outw(0x0a04, base);
-	InterruptTheCard(base);	
-	port->status |= ISI_RTS;
-}
-static inline void drop_rts(struct isi_port * port)
-{
-	struct isi_board * card = port->card;
-	unsigned short base = card->base;
-	unsigned char channel = port->channel;
-	short wait=400;
-	while(((inw(base+0x0e) & 0x01) == 0) && (wait-- > 0));
-	if (wait <= 0) {
-		printk(KERN_WARNING "ISICOM: Card found busy in drop_rts.\n");
-		return;
-	}
-#ifdef ISICOM_DEBUG_DTR_RTS	
-	printk(KERN_DEBUG "ISICOM: drop_rts.\n");
-#endif	
-	outw(0x8000 | (channel << card->shift_count) | 0x02 , base);
-	outw(0x0804, base);
-	InterruptTheCard(base);	
-	port->status &= ~ISI_RTS;
-}
-static inline void raise_dtr_rts(struct isi_port * port)
-{
-	struct isi_board * card = port->card;
-	unsigned short base = card->base;
-	unsigned char channel = port->channel;
-	short wait=400;
-	while(((inw(base+0x0e) & 0x01) == 0) && (wait-- > 0));
-	if (wait <= 0) {
-		printk(KERN_WARNING "ISICOM: Card found busy in raise_dtr_rts.\n");
-		return;
-	}
-#ifdef ISICOM_DEBUG_DTR_RTS	
-	printk(KERN_DEBUG "ISICOM: raise_dtr_rts.\n");
-#endif	
-	outw(0x8000 | (channel << card->shift_count) | 0x02 , base);
-	outw(0x0f04, base);
-	InterruptTheCard(base);
-	port->status |= (ISI_DTR | ISI_RTS);
-}
-static inline void drop_dtr_rts(struct isi_port * port)
-{
-	struct isi_board * card = port->card;
-	unsigned short base = card->base;
-	unsigned char channel = port->channel;
-	short wait=400;
-	while(((inw(base+0x0e) & 0x01) == 0) && (wait-- > 0));
-	if (wait <= 0) {
-		printk(KERN_WARNING "ISICOM: Card found busy in drop_dtr_rts.\n");
-		return;
-	}
-#ifdef ISICOM_DEBUG_DTR_RTS	
-	printk(KERN_DEBUG "ISICOM: drop_dtr_rts.\n");
-#endif	
-	outw(0x8000 | (channel << card->shift_count) | 0x02 , base);
-	outw(0x0c04, base);
-	InterruptTheCard(base);	
-	port->status &= ~(ISI_RTS | ISI_DTR);
-}
-
-static inline void kill_queue(struct isi_port * port, short queue)
-{
-	struct isi_board * card = port->card;
-	unsigned short base = card->base;
-	unsigned char channel = port->channel;
-	short wait=400;
-	while(((inw(base+0x0e) & 0x01) == 0) && (wait-- > 0));
-	if (wait <= 0) {
-		printk(KERN_WARNING "ISICOM: Card found busy in kill_queue.\n");
-		return;
-	}
-#ifdef ISICOM_DEBUG	
-	printk(KERN_DEBUG "ISICOM: kill_queue 0x%x.\n", queue);
-#endif	
-	outw(0x8000 | (channel << card->shift_count) | 0x02 , base);
-	outw((queue << 8) | 0x06, base);
-	InterruptTheCard(base);	
-}
-
 #endif	/*	__KERNEL__	*/
 
 #endif	/*	ISICOM_H	*/

