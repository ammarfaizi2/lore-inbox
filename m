Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131401AbQLMQyY>; Wed, 13 Dec 2000 11:54:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131628AbQLMQyO>; Wed, 13 Dec 2000 11:54:14 -0500
Received: from [216.12.246.94] ([216.12.246.94]:54386 "EHLO trampoline")
	by vger.kernel.org with ESMTP id <S131401AbQLMQyG>;
	Wed, 13 Dec 2000 11:54:06 -0500
To: tytso@MIT.EDU
CC: rgooch@ras.ucalgary.ca, jgarzik@mandrakesoft.mandrakesoft.com,
        dhinds@valinux.com, torvalds@transmeta.com,
        linux-kernel@vger.kernel.org
In-Reply-To: <200012081805.eB8I5AT08790@snap.thunk.org> (tytso@MIT.EDU)
Subject: Re: Serial cardbus code.... for testing, please.....
From: tytso@MIT.EDU
Phone: (781) 391-3464
In-Reply-To: <Pine.LNX.3.96.1001003164737.31485F-100000@mandrakesoft.mandrakesoft.com>
	<200010032248.SAA23371@tsx-prime.MIT.EDU> <200010040118.e941IuF00625@vindaloo.ras.ucalgary.ca> <200012081805.eB8I5AT08790@snap.thunk.org>
Message-Id: <E146EcA-0002dJ-00@trampoline>
Date: Wed, 13 Dec 2000 11:18:46 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


OK, so I'm currently at the road (San Diego IETF meeting) so I can't
really test this very well; when your compile engine is your Vaio
laptop, it's really slow and painful to do test builds and test booting
kernels.   

But I know some people are eager to test it, and would rather have
something potentially flaky earlier rather waiting for something more
tested later, so here it is.  Please note, the only testing that I have
done to date is Linus's famous "it builds, ship it" regression test
suite.  So if you're not willing to test a patch which might crash your
machine, come back in a day or two after I and others have had a chance
to do some testing.  (But hey, Linus has released kernels to the entire
world without even doing a test compile, so why can't I do it with
something as simple as a serial driver?  :-)


This version of the patch has a couple of new features over past ones,
including sanity check code which should prevent receive_chars() from
getting stuck in a tight loop when the serial card is ejected while a
port is active.  It also has functions correctly labelled with __devinit
and __devexit, and will check to see if an entry in the serial pci table
isn't necessay, and ask the user to report the information in that case.
(mailing list to be active within 24 hours; until then, send the
information to me instead of the e-mail adddress listed in the patch).

The patch also has changes which Kanoj from SGI has been bugging me
about constantly because he needs some changes to support his big-iron
MIPS box project which he's working on.  I had sat on them because
clearly I have a different understanding of "code freeze; critical bugs
only" than other folks on the L-K mailing list, but they're included
here now.  Linus, I can back out some or all of these changes when I
feed the patches to use for merging with 2.4; just let me know what you
want and don't want.

						- Ted


Release notes
=============

	* Add support for PCI hot plugging.  
		- Functions should be correctly labeled with __devinit
			and __devexit now.
		- Set a safety check to prevent infinite loops in
			receive_chars
		- Added support for removing PCI cards

	* Added code to test to see if an entry in the serial driver's
		PCI table is redundant (i.e., could have been deduced
		using our hueristics) and asks the user to report the
		information if so.

	* Add support for flow controled serial console.  (Feature
		desperately requested to be merged into 2.4.0 by Kanoj
		Sarcar <kanoj@sgi.com> for his big-iron MIPS box)

	* Add new interface, early_serial_setup() which allows
		architecture specific code to set up serial consoles
		for those platforms where the port and bus information
		must be dynamically determined by the boot.
		Early_serial_setup() must be called before rs_init().
		(Feature desperately requested to be merged into 2.4.0
		by Kanoj Sarcar <kanoj@sgi.com> for his big-iron MIPS
		box)


	* Fixed fencepost bug which could cause the serial driver to
		overrun the flip buffer by a single character if the
		UART reports an overrun when the flip buffer is nearly
		full.  (not really a critical problem because we have
		slop space in the flip buffer for this purpose, but it
		really would be good to have this fixed.)

	* Add support for the DCI PCCOM8 8-port serial board


Patch generated: on Wed Dec 13 10:39:41 EST 2000 by tytso@trampoline
against Linux version 2.4.0
 
===================================================================
RCS file: Documentation/RCS/serial-console.txt,v
retrieving revision 1.1
diff -u -r1.1 Documentation/serial-console.txt
--- Documentation/serial-console.txt	2000/12/13 15:12:57	1.1
+++ Documentation/serial-console.txt	2000/12/13 15:13:09
@@ -20,9 +20,11 @@
 
 	options:	depend on the driver. For the serial port this
 			defines the baudrate/parity/bits of the port,
-			in the format BBBBPN, where BBBB is the speed,
-			P is parity (n/o/e), and N is bits. Default is
-			9600n8. The maximum baudrate is 115200.
+			in the format BBBBPNF, where BBBB is the speed,
+			P is parity (n/o/e), N is bits, and F is
+			flow control (n/r for none/rtscts).  P, N,
+			and F are optional.  The default setting is
+			9600n8n. The maximum baudrate is 115200.  
 
 You can specify multiple console= options on the kernel command line.
 Output will appear on all of them. The last device will be used when
===================================================================
RCS file: drivers/char/RCS/serial.c,v
retrieving revision 1.1
diff -u -r1.1 drivers/char/serial.c
--- drivers/char/serial.c	2000/12/13 01:08:20	1.1
+++ drivers/char/serial.c	2000/12/13 15:13:35
@@ -54,13 +54,16 @@
  *  7/00: fix some returns on failure not using MOD_DEC_USE_COUNT.
  *	  Arnaldo Carvalho de Melo <acme@conectiva.com.br>
  *
+ * 10/00: add in optional software flow control for serial console.
+ *	  Kanoj Sarcar <kanoj@sgi.com>  (Modified by Theodore Ts'o)
+ *
  * This module exports the following rs232 io functions:
  *
  *	int rs_init(void);
  */
 
-static char *serial_version = "5.02";
-static char *serial_revdate = "2000-08-09";
+static char *serial_version = "5.05";
+static char *serial_revdate = "2000-12-13";
 
 /*
  * Serial driver configuration section.  Here are the various options:
@@ -325,7 +328,6 @@
 #define NR_PCI_BOARDS	8
 
 static struct pci_board_inst	serial_pci_board[NR_PCI_BOARDS];
-static int serial_pci_board_idx;
 
 #ifndef IS_PCI_REGION_IOPORT
 #define IS_PCI_REGION_IOPORT(dev, r) (pci_resource_flags((dev), (r)) & \
@@ -564,8 +566,8 @@
 {
 	struct tty_struct *tty = info->tty;
 	unsigned char ch;
-	int ignored = 0;
 	struct	async_icount *icount;
+	int	max_count = 256;
 
 	icount = &info->state->icount;
 	do {
@@ -612,15 +614,8 @@
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
@@ -639,19 +634,6 @@
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
@@ -664,16 +646,30 @@
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
-	} while (*status & UART_LSR_DR);
+	} while ((*status & UART_LSR_DR) && (max_count-- > 0));
 #if (LINUX_VERSION_CODE > 131394) /* 2.1.66 */
 	tty_flip_buffer_push(tty);
 #else
-	queue_task(&tty->flip.tqueue, &tq_timer);
+	queue_task_irq_off(&tty->flip.tqueue, &tq_timer);
 #endif	
 }
 
@@ -827,6 +823,9 @@
 				end_mark = info;
 			goto next;
 		}
+#ifdef SERIAL_DEBUG_INTR
+		printk("IIR = %x...", serial_in(info, UART_IIR));
+#endif
 		end_mark = 0;
 
 		info->last_active = jiffies;
@@ -910,6 +909,9 @@
 #endif
 			break;
 		}
+#ifdef SERIAL_DEBUG_INTR
+		printk("IIR = %x...", serial_in(info, UART_IIR));
+#endif
 	} while (!(serial_in(info, UART_IIR) & UART_IIR_NO_INT));
 	info->last_active = jiffies;
 #ifdef CONFIG_SERIAL_MULTIPORT	
@@ -1310,7 +1312,7 @@
 	 */
 	if (!(info->flags & ASYNC_BUGGY_UART) &&
 	    (serial_inp(info, UART_LSR) == 0xff)) {
-		printk("LSR safety check engaged!\n");
+		printk("ttyS%d: LSR safety check engaged!\n", state->line);
 		if (capable(CAP_SYS_ADMIN)) {
 			if (info->tty)
 				set_bit(TTY_IO_ERROR, &info->tty->flags);
@@ -1554,7 +1556,10 @@
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
@@ -2906,7 +2911,6 @@
 		if (timeout && time_after(jiffies, orig_jiffies + timeout))
 			break;
 	}
-	set_current_state(TASK_RUNNING);
 #ifdef SERIAL_DEBUG_RS_WAIT_UNTIL_SENT
 	printk("lsr = %d (jiff=%lu)...done\n", lsr, jiffies);
 #endif
@@ -3254,6 +3258,10 @@
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
@@ -3809,7 +3817,7 @@
 
 #if defined(ENABLE_SERIAL_PCI) || defined(ENABLE_SERIAL_PNP) 
 
-static void __init printk_pnp_dev_id(unsigned short vendor,
+static void __devinit printk_pnp_dev_id(unsigned short vendor,
 				     unsigned short device)
 {
 	printk("%c%c%c%x%x%x%x",
@@ -3901,7 +3909,7 @@
 /*
  * Common enabler code shared by both PCI and ISAPNP probes
  */
-static void __init start_pci_pnp_board(struct pci_dev *dev,
+static void __devinit start_pci_pnp_board(struct pci_dev *dev,
 				       struct pci_board *board)
 {
 	int k, line;
@@ -3933,19 +3941,19 @@
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
@@ -3965,6 +3973,7 @@
 		if (line < 0)
 			break;
 		rs_table[line].baud_base = base_baud;
+		rs_table[line].dev = dev;
 	}
 }
 #endif	/* ENABLE_SERIAL_PCI || ENABLE_SERIAL_PNP */
@@ -3978,7 +3987,7 @@
  */
 static int
 #ifndef MODULE
-__init
+__devinit
 #endif
 pci_plx9050_fn(struct pci_dev *dev, struct pci_board *board, int enable)
 {
@@ -4045,7 +4054,7 @@
 
 static int
 #ifndef MODULE
-__init
+__devinit
 #endif
 pci_siig10x_fn(struct pci_dev *dev, struct pci_board *board, int enable)
 {
@@ -4077,7 +4086,7 @@
 
 static int
 #ifndef MODULE
-__init
+__devinit
 #endif
 pci_siig20x_fn(struct pci_dev *dev, struct pci_board *board, int enable)
 {
@@ -4101,7 +4110,7 @@
 /* Added for EKF Intel i960 serial boards */
 static int
 #ifndef MODULE
-__init
+__devinit
 #endif
 pci_inteli960ni_fn(struct pci_dev *dev,
 		   struct pci_board *board,
@@ -4162,7 +4171,7 @@
 
 static int
 #ifndef MODULE
-__init
+__devinit
 #endif
 pci_timedia_fn(struct pci_dev *dev, struct pci_board *board, int enable)
 {
@@ -4577,6 +4586,10 @@
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
@@ -4626,6 +4639,90 @@
 	return 1;
 }
 
+static int __devinit serial_init_one(struct pci_dev *dev,
+				     const struct pci_device_id *ent)
+{
+	struct pci_board *board, tmp;
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
+	else if (serial_pci_guess_board(dev, &tmp) == 0) {
+		printk(KERN_INFO "Redundant entry in serial pci_table.  "
+		       "Please send the output of\n"
+		       "lspci -vv, this message (%d,%d,%d,%d)\n"
+		       "and the manufacturer and name of "
+		       "serial board or modem board\n"
+		       "to serial-pci-info@lists.sourceforge.net.\n",
+		       dev->vendor, dev->device,
+		       pci_get_subvendor(dev), pci_get_subdevice(dev));
+	}
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
@@ -4635,38 +4732,19 @@
  * Accept a maximum of eight boards
  *
  */
-static void __init probe_serial_pci(void) 
+static void __devinit probe_serial_pci(void) 
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
@@ -4682,7 +4760,7 @@
 	unsigned short device;
 };
 
-static struct pnp_board pnp_devices[] __initdata = {
+static struct pnp_board pnp_devices[] __devinitdata = {
 	/* Archtek America Corp. */
 	/* Archtek SmartLink Modem 3334BT Plug & Play */
 	{	ISAPNP_VENDOR('A', 'A', 'C'), ISAPNP_DEVICE(0x000F) },
@@ -4972,14 +5050,14 @@
 			irq->map = map;
 }
 
-static char *modem_names[] __initdata = {
+static char *modem_names[] __devinitdata = {
        "MODEM", "Modem", "modem", "FAX", "Fax", "fax",
        "56K", "56k", "K56", "33.6", "28.8", "14.4",
        "33,600", "28,800", "14,400", "33.600", "28.800", "14.400",
        "33600", "28800", "14400", "V.90", "V.34", "V.32", 0
 };
 
-static int __init check_name(char *name)
+static int __devinit check_name(char *name)
 {
        char **tmp = modem_names;
 
@@ -5041,7 +5119,7 @@
        return 1;
 }
 
-static void __init probe_serial_pnp(void)
+static void __devinit probe_serial_pnp(void)
 {
        struct pci_dev *dev = NULL;
        struct pnp_board *pnp_board;
@@ -5099,7 +5177,7 @@
 /*
  * The serial driver boot-time initialization code!
  */
-static int __init rs_init(void)
+int __init rs_init(void)
 {
 	int i;
 	struct serial_state * state;
@@ -5252,6 +5330,36 @@
 }
 
 /*
+ * This is for use by architectures that know their serial console 
+ * attributes only at run time. Not to be invoked after rs_init().
+ */
+int __init early_serial_setup(struct serial_struct *req)
+{
+	int i = req->line;
+
+	if (i >= NR_IRQS)
+		return(-ENOENT);
+	rs_table[i].magic = 0;
+	rs_table[i].baud_base = req->baud_base;
+	rs_table[i].port = req->port;
+	if (HIGH_BITS_OFFSET)
+		rs_table[i].port += (unsigned long) req->port_high << 
+							HIGH_BITS_OFFSET;
+	rs_table[i].irq = req->irq;
+	rs_table[i].flags = req->flags;
+	rs_table[i].close_delay = req->close_delay;
+	rs_table[i].io_type = req->io_type;
+	rs_table[i].hub6 = req->hub6;
+	rs_table[i].iomem_base = req->iomem_base;
+	rs_table[i].iomem_reg_shift = req->iomem_reg_shift;
+	rs_table[i].type = req->type;
+	rs_table[i].xmit_fifo_size = req->xmit_fifo_size;
+	rs_table[i].custom_divisor = req->custom_divisor;
+	rs_table[i].closing_wait = req->closing_wait;
+	return(0);
+}
+
+/*
  * register_serial and unregister_serial allows for 16x50 serial ports to be
  * configured at run-time, to support PCMCIA modems.
  */
@@ -5288,6 +5396,14 @@
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
@@ -5411,12 +5527,13 @@
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
@@ -5426,6 +5543,11 @@
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
@@ -5461,6 +5583,13 @@
 		if (--tmout == 0)
 			break;
 	} while((status & BOTH_EMPTY) != BOTH_EMPTY);
+
+	/* Wait for flow control if necessary */
+	if (info->flags & ASYNC_CONS_FLOW) {
+		tmout = 1000000;
+		while (--tmout &&
+		       ((serial_in(info, UART_MSR) & UART_MSR_CTS) == 0));
+	}	
 }
 
 
@@ -5543,7 +5672,7 @@
 }
 
 /*
- *	Setup initial baud/bits/parity. We do two things here:
+ *	Setup initial baud/bits/parity/flow control. We do two things here:
  *	- construct a cflag setting for the first rs_open()
  *	- initialize the serial port
  *	Return non-zero if we didn't find a serial port.
@@ -5556,6 +5685,7 @@
 	int	baud = 9600;
 	int	bits = 8;
 	int	parity = 'n';
+	int	doflow = 0;
 	int	cflag = CREAD | HUPCL | CLOCAL;
 	int	quot = 0;
 	char	*s;
@@ -5566,7 +5696,8 @@
 		while(*s >= '0' && *s <= '9')
 			s++;
 		if (*s) parity = *s++;
-		if (*s) bits   = *s - '0';
+		if (*s) bits   = *s++ - '0';
+		if (*s) doflow = (*s++ == 'r');
 	}
 
 	/*
@@ -5622,6 +5753,8 @@
 	 *	Divisor, bytesize and parity
 	 */
 	state = rs_table + co->index;
+	if (doflow)
+		state->flags |= ASYNC_CONS_FLOW;
 	info = &async_sercons;
 	info->magic = SERIAL_MAGIC;
 	info->state = state;
===================================================================
RCS file: include/linux/RCS/serial.h,v
retrieving revision 1.1
diff -u -r1.1 include/linux/serial.h
--- include/linux/serial.h	2000/12/13 01:08:21	1.1
+++ include/linux/serial.h	2000/12/13 15:19:28
@@ -139,8 +139,9 @@
 #define ASYNC_CHECK_CD		0x02000000 /* i.e., CLOCAL */
 #define ASYNC_SHARE_IRQ		0x01000000 /* for multifunction cards
 					     --- no longer used */
+#define ASYNC_CONS_FLOW		0x00800000 /* flow control for console  */
 
-#define ASYNC_INTERNAL_FLAGS	0xFF000000 /* Internal flags */
+#define ASYNC_INTERNAL_FLAGS	0xFF800000 /* Internal flags */
 
 /*
  * Multiport serial configuration structure --- external structure
@@ -176,6 +177,9 @@
 /* Export to allow PCMCIA to use this - Dave Hinds */
 extern int register_serial(struct serial_struct *req);
 extern void unregister_serial(int line);
+
+/* Allow complicated architectures to specify rs_table[] at run time */
+extern int early_serial_setup(struct serial_struct *req);
 
 #endif /* __KERNEL__ */
 #endif /* _LINUX_SERIAL_H */
===================================================================
RCS file: include/linux/RCS/serial_reg.h,v
retrieving revision 1.1
diff -u -r1.1 include/linux/serial_reg.h
--- include/linux/serial_reg.h	2000/12/13 01:08:21	1.1
+++ include/linux/serial_reg.h	2000/12/13 01:08:42
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
--- include/linux/serialP.h	2000/12/13 01:08:21	1.1
+++ include/linux/serialP.h	2000/12/13 15:25:02
@@ -52,6 +52,7 @@
 	struct termios		callout_termios;
 	int	io_type;
 	struct async_struct *info;
+	struct pci_dev	*dev;
 };
 
 struct async_struct {
===================================================================
RCS file: include/linux/RCS/pci_ids.h,v
retrieving revision 1.1
diff -u -r1.1 include/linux/pci_ids.h
--- include/linux/pci_ids.h	2000/12/13 01:08:21	1.1
+++ include/linux/pci_ids.h	2000/12/13 15:39:37
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
