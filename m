Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129909AbQLHSgn>; Fri, 8 Dec 2000 13:36:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130013AbQLHSge>; Fri, 8 Dec 2000 13:36:34 -0500
Received: from SNAP.THUNK.ORG ([216.175.175.173]:16645 "EHLO snap.thunk.org")
	by vger.kernel.org with ESMTP id <S129909AbQLHSgT>;
	Fri, 8 Dec 2000 13:36:19 -0500
Date: Fri, 8 Dec 2000 13:05:10 -0500
Message-Id: <200012081805.eB8I5AT08790@snap.thunk.org>
To: rgooch@ras.ucalgary.ca, jgarzik@mandrakesoft.mandrakesoft.com,
        dhinds@valinux.com, torvalds@transmeta.com
cc: linux-kernel@vger.kernel.org
Subject: Serial cardbus code.... for testing, please.....
From: tytso@mit.edu
Address: 1 Amherst St., Cambridge, MA 02139
Phone: (617) 253-8091
In-Reply-To: <Pine.LNX.3.96.1001003164737.31485F-100000@mandrakesoft.mandrakesoft.com>
	<200010032248.SAA23371@tsx-prime.MIT.EDU> <200010040118.e941IuF00625@vindaloo.ras.ucalgary.ca>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I haven't been able to get PCMCIA working under Linux 2.4 with any kind
of serial devices (Cardbus or normal ISA), at least not reliably, on my
Vaio 505TX.  I've tried both yenta_socket and i82365.  It works about
one time in ten, but I've never figured out what causes it to work or
not work.  When it doesn't work, any attempt to read the LSR and IIR
registers return *either* 0 or 0x80, and interrupts aren't delievered at
all.  So I think it's some sort of ioport/irq setup problem that's not
related to the serial driver itself.....

(However, most but not all of the time, the ethernet PC cards work fine
--- although if I insert an cardbus ethernet card (using epic_cb) in, it
locks up the PCMCIA subsystem after it detects the card but before it
activates it.  And after that, the ref count on the yenta_socket is set
to 1, and there's no way to reset the pcmcia subsystem except rebooting
the machine.  Very frustating; I suspect there are several things going
wrong, and I'm trying to debug them all simultaneously.  And yes, all
this works just flawlessly under Linux 2.2.  For both 2.2 and 2.4, I'm
using the latest version of pcmcia-cs, 3.1.22.)

Anyway, all of this means I haven't been able to test this code.  So if
someone with access to a cardbus serial card and a working 2.4
PCMCIA/Cardbus setup could test this new version of the serial driver
(patch versus 2.4.0test12-pre6), I'd appreciate it.  It has both the
cardbus insert and removal code, so it *should* work, but as I said, I
haven't been able to find any way of testing it, and I've wasted enough
time that I'm giving up trying to get PCMCIA on my laptop working under
2.4 for now.....

	    					 - Ted

Patch generated: on Fri Dec  8 12:52:51 EST 2000 by tytso@snap.thunk.org
against Linux version 2.4.0test12-pre6
 
===================================================================
RCS file: drivers/char/RCS/serial.c,v
retrieving revision 1.1
diff -u -r1.1 drivers/char/serial.c
--- drivers/char/serial.c	2000/12/08 04:17:14	1.1
+++ drivers/char/serial.c	2000/12/08 14:03:36
@@ -59,8 +59,8 @@
  *	int rs_init(void);
  */
 
-static char *serial_version = "5.02";
-static char *serial_revdate = "2000-08-09";
+static char *serial_version = "5.05";
+static char *serial_revdate = "2000-09-14";
 
 /*
  * Serial driver configuration section.  Here are the various options:
@@ -325,7 +325,6 @@
 #define NR_PCI_BOARDS	8
 
 static struct pci_board_inst	serial_pci_board[NR_PCI_BOARDS];
-static int serial_pci_board_idx;
 
 #ifndef IS_PCI_REGION_IOPORT
 #define IS_PCI_REGION_IOPORT(dev, r) (pci_resource_flags((dev), (r)) & \
@@ -564,7 +563,6 @@
 {
 	struct tty_struct *tty = info->tty;
 	unsigned char ch;
-	int ignored = 0;
 	struct	async_icount *icount;
 
 	icount = &info->state->icount;
@@ -612,15 +610,8 @@
 				icount->overrun++;
 
 			/*
-			 * Now check to see if character should be
-			 * ignored, and mask off conditions which
-			 * should be ignored.
+			 * Mask off conditions which should be ignored.
 			 */
-			if (*status & info->ignore_status_mask) {
-				if (++ignored > 100)
-					break;
-				goto ignore_char;
-			}
 			*status &= info->read_status_mask;
 
 #ifdef CONFIG_SERIAL_CONSOLE
@@ -639,19 +630,6 @@
 				*tty->flip.flag_buf_ptr = TTY_PARITY;
 			else if (*status & UART_LSR_FE)
 				*tty->flip.flag_buf_ptr = TTY_FRAME;
-			if (*status & UART_LSR_OE) {
-				/*
-				 * Overrun is special, since it's
-				 * reported immediately, and doesn't
-				 * affect the current character
-				 */
-				tty->flip.count++;
-				tty->flip.flag_buf_ptr++;
-				tty->flip.char_buf_ptr++;
-				*tty->flip.flag_buf_ptr = TTY_OVERRUN;
-				if (tty->flip.count >= TTY_FLIPBUF_SIZE)
-					goto ignore_char;
-			}
 		}
 #if defined(CONFIG_SERIAL_CONSOLE) && defined(CONFIG_MAGIC_SYSRQ)
 		if (break_pressed && info->line == sercons.index) {
@@ -664,9 +642,23 @@
 			break_pressed = 0;
 		}
 #endif
-		tty->flip.flag_buf_ptr++;
-		tty->flip.char_buf_ptr++;
-		tty->flip.count++;
+		if ((*status & info->ignore_status_mask) == 0) {
+			tty->flip.flag_buf_ptr++;
+			tty->flip.char_buf_ptr++;
+			tty->flip.count++;
+		}
+		if ((*status & UART_LSR_OE) &&
+		    (tty->flip.count < TTY_FLIPBUF_SIZE)) {
+			/*
+			 * Overrun is special, since it's reported
+			 * immediately, and doesn't affect the current
+			 * character
+			 */
+			*tty->flip.flag_buf_ptr = TTY_OVERRUN;
+			tty->flip.count++;
+			tty->flip.flag_buf_ptr++;
+			tty->flip.char_buf_ptr++;
+		}
 	ignore_char:
 		*status = serial_inp(info, UART_LSR);
 	} while (*status & UART_LSR_DR);
@@ -1310,7 +1302,7 @@
 	 */
 	if (!(info->flags & ASYNC_BUGGY_UART) &&
 	    (serial_inp(info, UART_LSR) == 0xff)) {
-		printk("LSR safety check engaged!\n");
+		printk("ttyS%d: LSR safety check engaged!\n", state->line);
 		if (capable(CAP_SYS_ADMIN)) {
 			if (info->tty)
 				set_bit(TTY_IO_ERROR, &info->tty->flags);
@@ -1554,7 +1546,10 @@
 		/* Arrange to enter sleep mode */
 		serial_outp(info, UART_LCR, 0xBF);
 		serial_outp(info, UART_EFR, UART_EFR_ECB);
+		serial_outp(info, UART_LCR, 0);
 		serial_outp(info, UART_IER, UART_IERX_SLEEP);
+		serial_outp(info, UART_LCR, 0xBF);
+		serial_outp(info, UART_EFR, 0);
 		serial_outp(info, UART_LCR, 0);
 	}
 	if (info->state->type == PORT_16750) {
@@ -2906,7 +2901,6 @@
 		if (timeout && time_after(jiffies, orig_jiffies + timeout))
 			break;
 	}
-	set_current_state(TASK_RUNNING);
 #ifdef SERIAL_DEBUG_RS_WAIT_UNTIL_SENT
 	printk("lsr = %d (jiff=%lu)...done\n", lsr, jiffies);
 #endif
@@ -3254,6 +3248,10 @@
 		info->magic = SERIAL_MAGIC;
 		info->port = state->port;
 		info->flags = state->flags;
+		info->hub6 = state->hub6;
+		info->io_type = state->io_type;
+		info->iomem_base = state->iomem_base;
+		info->iomem_reg_shift = state->iomem_reg_shift;
 		info->quot = 0;
 		info->tty = 0;
 	}
@@ -3933,19 +3931,19 @@
 	if (board->init_fn && ((board->init_fn)(dev, board, 1) != 0))
 		return;
 
-#ifdef MODULE
 	/*
 	 * Register the serial board in the array if we need to
-	 * shutdown the board on a module unload.
+	 * shutdown the board on a module unload or card removal
 	 */
 	if (DEACTIVATE_FUNC(dev) || board->init_fn) {
-		if (serial_pci_board_idx >= NR_PCI_BOARDS)
+		for (k=0; k < NR_PCI_BOARDS; k++)
+			if (serial_pci_board[k].dev == 0)
+				break;
+		if (k >= NR_PCI_BOARDS)
 			return;
-		serial_pci_board[serial_pci_board_idx].board = *board;
-		serial_pci_board[serial_pci_board_idx].dev = dev;
-		serial_pci_board_idx++;
+		serial_pci_board[k].board = *board;
+		serial_pci_board[k].dev = dev;
 	}
-#endif
 
 	base_baud = board->base_baud;
 	if (!base_baud)
@@ -3965,6 +3963,7 @@
 		if (line < 0)
 			break;
 		rs_table[line].baud_base = base_baud;
+		rs_table[line].dev = dev;
 	}
 }
 #endif	/* ENABLE_SERIAL_PCI || ENABLE_SERIAL_PNP */
@@ -3978,7 +3977,7 @@
  */
 static int
 #ifndef MODULE
-__init
+__devinit
 #endif
 pci_plx9050_fn(struct pci_dev *dev, struct pci_board *board, int enable)
 {
@@ -4045,7 +4044,7 @@
 
 static int
 #ifndef MODULE
-__init
+__devinit
 #endif
 pci_siig10x_fn(struct pci_dev *dev, struct pci_board *board, int enable)
 {
@@ -4077,7 +4076,7 @@
 
 static int
 #ifndef MODULE
-__init
+__devinit
 #endif
 pci_siig20x_fn(struct pci_dev *dev, struct pci_board *board, int enable)
 {
@@ -4101,7 +4100,7 @@
 /* Added for EKF Intel i960 serial boards */
 static int
 #ifndef MODULE
-__init
+__devinit
 #endif
 pci_inteli960ni_fn(struct pci_dev *dev,
 		   struct pci_board *board,
@@ -4162,7 +4161,7 @@
 
 static int
 #ifndef MODULE
-__init
+__devinit
 #endif
 pci_timedia_fn(struct pci_dev *dev, struct pci_board *board, int enable)
 {
@@ -4577,6 +4576,10 @@
 		SPCI_FL_BASE0, 1, 520833,
 		64, 3, NULL, 0x300 },
 #endif
+	{	PCI_VENDOR_ID_DCI, PCI_DEVICE_ID_DCI_PCCOM8,
+		PCI_ANY_ID, PCI_ANY_ID,
+		SPCI_FL_BASE3, 8, 115200,
+		8 },		
 	/* Generic serial board */
 	{	0, 0,
 		0, 0,
@@ -4626,6 +4629,80 @@
 	return 1;
 }
 
+static int __devinit serial_init_one(struct pci_dev *dev,
+				     const struct pci_device_id *ent)
+{
+	struct pci_board *board;
+
+	for (board = pci_boards; board->vendor; board++) {
+		if (board->vendor != (unsigned short) PCI_ANY_ID &&
+		    dev->vendor != board->vendor)
+			continue;
+		if (board->device != (unsigned short) PCI_ANY_ID &&
+		    dev->device != board->device)
+			continue;
+		if (board->subvendor != (unsigned short) PCI_ANY_ID &&
+		    pci_get_subvendor(dev) != board->subvendor)
+			continue;
+		if (board->subdevice != (unsigned short) PCI_ANY_ID &&
+		    pci_get_subdevice(dev) != board->subdevice)
+			continue;
+		break;
+	}
+
+	if (board->vendor == 0 && serial_pci_guess_board(dev, board))
+		return -ENODEV;
+	
+	start_pci_pnp_board(dev, board);
+
+	return 0;
+}
+
+static void __devexit serial_remove_one(struct pci_dev *dev)
+{
+	int	i;
+
+	/*
+	 * Iterate through all of the ports finding those that belong
+	 * to this PCI device.
+	 */
+	for(i = 0; i < NR_PORTS; i++) {
+		if (rs_table[i].dev != dev)
+			continue;
+		unregister_serial(i);
+		rs_table[i].dev = 0;
+	}
+	/*
+	 * Now execute any board-specific shutdown procedure
+	 */
+	for (i=0; i < NR_PCI_BOARDS; i++) {
+		struct pci_board_inst *brd = &serial_pci_board[i];
+
+		if (serial_pci_board[i].dev != dev)
+			continue;
+		if (brd->board.init_fn)
+			(brd->board.init_fn)(brd->dev, &brd->board, 0);
+		if (DEACTIVATE_FUNC(brd->dev))
+			(DEACTIVATE_FUNC(brd->dev))(brd->dev);
+		serial_pci_board[i].dev = 0;
+	}
+}
+
+
+static struct pci_device_id serial_pci_tbl[] __devinitdata = {
+       { PCI_ANY_ID, PCI_ANY_ID, PCI_ANY_ID, PCI_ANY_ID,
+	 PCI_CLASS_COMMUNICATION_SERIAL << 8, 0xffff00, },
+       { 0, }
+};
+
+MODULE_DEVICE_TABLE(pci, serial_pci_tbl);
+
+static struct pci_driver serial_pci_driver = {
+       name:           "serial",
+       probe:          serial_init_one,
+       remove:	       serial_remove_one,
+       id_table:       serial_pci_tbl,
+};
 
 
 /*
@@ -4637,36 +4714,17 @@
  */
 static void __init probe_serial_pci(void) 
 {
-	struct pci_dev *dev = NULL;
-	struct pci_board *board;
-
 #ifdef SERIAL_DEBUG_PCI
 	printk(KERN_DEBUG "Entered probe_serial_pci()\n");
 #endif
-  
-	pci_for_each_dev(dev) {
-		for (board = pci_boards; board->vendor; board++) {
-			if (board->vendor != (unsigned short) PCI_ANY_ID &&
-			    dev->vendor != board->vendor)
-				continue;
-			if (board->device != (unsigned short) PCI_ANY_ID &&
-			    dev->device != board->device)
-				continue;
-			if (board->subvendor != (unsigned short) PCI_ANY_ID &&
-			    pci_get_subvendor(dev) != board->subvendor)
-				continue;
-			if (board->subdevice != (unsigned short) PCI_ANY_ID &&
-			    pci_get_subdevice(dev) != board->subdevice)
-				continue;
-			break;
-		}
-	
-		if (board->vendor == 0 && serial_pci_guess_board(dev, board))
-			continue;
-		
-		start_pci_pnp_board(dev, board);
-	}
-	
+
+	/* Register call PCI serial devices.  Null out
+	 * the driver name upon failure, as a signal
+	 * not to attempt to unregister the driver later
+	 */
+	if (pci_module_init (&serial_pci_driver) != 0)
+		serial_pci_driver.name[0] = 0;
+
 #ifdef SERIAL_DEBUG_PCI
 	printk(KERN_DEBUG "Leaving probe_serial_pci() (probe finished)\n");
 #endif
@@ -5099,7 +5157,7 @@
 /*
  * The serial driver boot-time initialization code!
  */
-static int __init rs_init(void)
+int __init rs_init(void)
 {
 	int i;
 	struct serial_state * state;
@@ -5288,6 +5346,14 @@
 		    (rs_table[i].iomem_base == req->iomem_base))
 			break;
 	}
+#ifdef __i386__
+	if (i == NR_PORTS) {
+		for (i = 4; i < NR_PORTS; i++)
+			if ((rs_table[i].type == PORT_UNKNOWN) &&
+			    (rs_table[i].count == 0))
+				break;
+	}
+#endif
 	if (i == NR_PORTS) {
 		for (i = 0; i < NR_PORTS; i++)
 			if ((rs_table[i].type == PORT_UNKNOWN) &&
@@ -5411,12 +5477,13 @@
 #endif
 	}
 #if defined(ENABLE_SERIAL_PCI) || defined(ENABLE_SERIAL_PNP)
-	for (i=0; i < serial_pci_board_idx; i++) {
+	for (i=0; i < NR_PCI_BOARDS; i++) {
 		struct pci_board_inst *brd = &serial_pci_board[i];
-		
+
+		if (serial_pci_board[i].dev == 0)
+			continue;
 		if (brd->board.init_fn)
 			(brd->board.init_fn)(brd->dev, &brd->board, 0);
-
 		if (DEACTIVATE_FUNC(brd->dev))
 			(DEACTIVATE_FUNC(brd->dev))(brd->dev);
 	}
@@ -5426,6 +5493,11 @@
 		tmp_buf = NULL;
 		free_page(pg);
 	}
+	
+#ifdef ENABLE_SERIAL_PCI
+	if (serial_pci_driver.name[0])
+		pci_unregister_driver (&serial_pci_driver);
+#endif
 }
 
 module_init(rs_init);
===================================================================
RCS file: include/linux/RCS/serial.h,v
retrieving revision 1.1
diff -u -r1.1 include/linux/serial.h
===================================================================
RCS file: include/linux/RCS/serial_reg.h,v
retrieving revision 1.1
diff -u -r1.1 include/linux/serial_reg.h
--- include/linux/serial_reg.h	2000/12/08 04:17:14	1.1
+++ include/linux/serial_reg.h	2000/12/08 04:17:35
@@ -156,8 +156,8 @@
  * These register definitions are for the 16C950
  */
 #define UART_ASR	0x01	/* Additional Status Register */
-#define UART_RFL	0x03	/* Transmitter FIFO level */
-#define UART_TFL 	0x04	/* Receiver FIFO level */
+#define UART_RFL	0x03	/* Receiver FIFO level */
+#define UART_TFL 	0x04	/* Transmitter FIFO level */
 #define UART_ICR	0x05	/* Index Control Register */
 
 /* The 16950 ICR registers */
===================================================================
RCS file: include/linux/RCS/serialP.h,v
retrieving revision 1.1
diff -u -r1.1 include/linux/serialP.h
--- include/linux/serialP.h	2000/12/08 04:17:14	1.1
+++ include/linux/serialP.h	2000/12/08 04:17:35
@@ -52,6 +52,7 @@
 	struct termios		callout_termios;
 	int	io_type;
 	struct async_struct *info;
+	struct pci_dev	*dev;
 };
 
 struct async_struct {
===================================================================
RCS file: include/asm-i386/RCS/serial.h,v
retrieving revision 1.1
diff -u -r1.1 include/asm-i386/serial.h
===================================================================
RCS file: include/linux/RCS/pci_ids.h,v
retrieving revision 1.1
diff -u -r1.1 include/linux/pci_ids.h
--- include/linux/pci_ids.h	2000/12/08 04:22:16	1.1
+++ include/linux/pci_ids.h	2000/12/08 04:23:12
@@ -1320,6 +1320,7 @@
 
 #define PCI_VENDOR_ID_DCI		0x6666
 #define PCI_DEVICE_ID_DCI_PCCOM4	0x0001
+#define PCI_DEVICE_ID_DCI_PCCOM8	0x0002
 
 #define PCI_VENDOR_ID_GENROCO		0x5555
 #define PCI_DEVICE_ID_GENROCO_HFP832	0x0003



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
