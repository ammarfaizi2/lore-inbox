Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261472AbSJHTNo>; Tue, 8 Oct 2002 15:13:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261465AbSJHTN3>; Tue, 8 Oct 2002 15:13:29 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:23568 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S261684AbSJHTGB>; Tue, 8 Oct 2002 15:06:01 -0400
Subject: PATCH: update fdomain scsi
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Date: Tue, 8 Oct 2002 20:02:54 +0100 (BST)
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E17yzd8-0004u2-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.2.5.41/drivers/scsi/fdomain.c linux.2.5.41-ac1/drivers/scsi/fdomain.c
--- linux.2.5.41/drivers/scsi/fdomain.c	2002-10-02 21:33:41.000000000 +0100
+++ linux.2.5.41-ac1/drivers/scsi/fdomain.c	2002-10-07 15:43:18.000000000 +0100
@@ -418,7 +418,7 @@
 static int               FIFO_Size = 0x2000; /* 8k FIFO for
 						pre-tmc18c30 chips */
 
-extern void              do_fdomain_16x0_intr( int irq, void *dev_id,
+static void              do_fdomain_16x0_intr( int irq, void *dev_id,
 					    struct pt_regs * regs );
 
 #ifdef MODULE
@@ -528,16 +528,16 @@
    if (!shpnt) return;		/* This won't ever happen */
 
    if (bios_major < 0 && bios_minor < 0) {
-      printk( "scsi%d: <fdomain> No BIOS; using scsi id %d\n",
-	      shpnt->host_no, shpnt->this_id );
+      printk(KERN_INFO "scsi%d: <fdomain> No BIOS; using scsi id %d\n",
+	      shpnt->host_no, shpnt->this_id);
    } else {
-      printk( "scsi%d: <fdomain> BIOS version ", shpnt->host_no );
+      printk(KERN_INFO "scsi%d: <fdomain> BIOS version ", shpnt->host_no);
 
-      if (bios_major >= 0) printk( "%d.", bios_major );
-      else                 printk( "?." );
+      if (bios_major >= 0) printk("%d.", bios_major);
+      else                 printk("?.");
 
-      if (bios_minor >= 0) printk( "%d", bios_minor );
-      else                 printk( "?." );
+      if (bios_minor >= 0) printk("%d", bios_minor);
+      else                 printk("?.");
    
       printk( " at 0x%lx using scsi id %d\n",
 	      bios_base, shpnt->this_id );
@@ -547,31 +547,28 @@
 				   boards, we will have to modify banner
 				   for additional PCI cards, but for now if
 				   it's PCI it's a TMC-3260 - JTM */
-   printk( "scsi%d: <fdomain> %s chip at 0x%x irq ",
+   printk(KERN_INFO "scsi%d: <fdomain> %s chip at 0x%x irq ",
 	   shpnt->host_no,
-	   chip == tmc1800 ? "TMC-1800"
-	   : (chip == tmc18c50 ? "TMC-18C50"
-	      : (chip == tmc18c30 ?
-		 (PCI_bus ? "TMC-36C70 (PCI bus)" : "TMC-18C30")
-		 : "Unknown")),
-	   port_base );
+	   chip == tmc1800 ? "TMC-1800" : (chip == tmc18c50 ? "TMC-18C50" : (chip == tmc18c30 ? (PCI_bus ? "TMC-36C70 (PCI bus)" : "TMC-18C30") : "Unknown")),
+	   port_base);
 
-   if (interrupt_level) printk( "%d", interrupt_level );
-   else                 printk( "<none>" );
+   if (interrupt_level)
+   	printk("%d", interrupt_level);
+   else
+        printk("<none>");
 
    printk( "\n" );
 }
 
-static int __init fdomain_setup( char *str )
+static int __init fdomain_setup(char *str)
 {
 	int ints[4];
 
 	(void)get_options(str, ARRAY_SIZE(ints), ints);
 
 	if (setup_called++ || ints[0] < 2 || ints[0] > 3) {
-		printk( "scsi: <fdomain>"
-		" Usage: fdomain=<PORT_BASE>,<IRQ>[,<ADAPTER_ID>]\n" );
-		printk( "scsi: <fdomain> Bad LILO/INSMOD parameters?\n" );
+		printk(KERN_INFO "scsi: <fdomain> Usage: fdomain=<PORT_BASE>,<IRQ>[,<ADAPTER_ID>]\n");
+		printk(KERN_ERR "scsi: <fdomain> Bad LILO/INSMOD parameters?\n");
 		return 0;
 	}
 
@@ -587,9 +584,9 @@
 __setup("fdomain=", fdomain_setup);
 
 
-static void do_pause( unsigned amount )	/* Pause for amount*10 milliseconds */
+static void do_pause(unsigned amount)	/* Pause for amount*10 milliseconds */
 {
-   mdelay(10*amount);
+	mdelay(10*amount);
 }
 
 inline static void fdomain_make_bus_idle( void )
@@ -672,22 +669,20 @@
 
 static int fdomain_get_irq( int base )
 {
-   int options = inb( base + Configuration1 );
+   int options = inb(base + Configuration1);
 
 #if DEBUG_DETECT
-   printk( "scsi: <fdomain> Options = %x\n", options );
+   printk("scsi: <fdomain> Options = %x\n", options);
 #endif
-   
-				/* Check for board with lowest bios_base --
-				   this isn't valid for the 18c30 or for
-				   boards on the PCI bus, so just assume we
-				   have the right board. */
-
-   if (chip != tmc18c30
-       && !PCI_bus
-       && addresses[ (options & 0xc0) >> 6 ] != bios_base) return 0;
+ 
+   /* Check for board with lowest bios_base --
+      this isn't valid for the 18c30 or for
+      boards on the PCI bus, so just assume we
+      have the right board. */
 
-   return ints[ (options & 0x0e) >> 1 ];
+   if (chip != tmc18c30 && !PCI_bus && addresses[(options & 0xc0) >> 6 ] != bios_base)
+   	return 0;
+   return ints[(options & 0x0e) >> 1];
 }
 
 static int fdomain_isa_detect( int *irq, int *iobase )
@@ -700,7 +695,6 @@
    printk( "scsi: <fdomain> fdomain_isa_detect:" );
 #endif
 
-
    for (i = 0; !bios_base && i < ADDRESS_COUNT; i++) {
 #if DEBUG_DETECT
       printk( " %lx(%lx),", addresses[i], bios_base );
@@ -811,8 +805,6 @@
    unsigned long    pci_base;               /* PCI I/O base address */
    struct pci_dev   *pdev = NULL;
 
-   if (!pci_present()) return 0;
-
 #if DEBUG_DETECT
    /* Tell how to print a list of the known PCI devices from bios32 and
       list vendor and device IDs being used if in debug mode.  */
@@ -824,10 +816,8 @@
 	   PCI_DEVICE_ID_FD_36C70 );
 #endif 
 
-   if ((pdev = pci_find_device(PCI_VENDOR_ID_FD,
-			       PCI_DEVICE_ID_FD_36C70,
-			       pdev)) == NULL)
-     return 0;
+   if ((pdev = pci_find_device(PCI_VENDOR_ID_FD, PCI_DEVICE_ID_FD_36C70, pdev)) == NULL)
+		return 0;
    if (pci_enable_device(pdev)) return 0;
        
 #if DEBUG_DETECT
@@ -857,8 +847,7 @@
 #endif
 
    if (!fdomain_is_valid_port( *iobase )) {
-      printk( "scsi: <fdomain>"
-	      " PCI card detected, but driver not loaded (invalid port)\n" );
+      printk(KERN_ERR "scsi: <fdomain> PCI card detected, but driver not loaded (invalid port)\n" );
       return 0;
    }
 
@@ -872,7 +861,7 @@
 }
 #endif
 
-int fdomain_16x0_detect( Scsi_Host_Template *tpnt )
+static int fdomain_16x0_detect( Scsi_Host_Template *tpnt )
 {
    int              retcode;
    struct Scsi_Host *shpnt;
@@ -939,13 +928,12 @@
    Write_FIFO_port       = port_base + Write_FIFO;
    Write_SCSI_Data_port  = port_base + Write_SCSI_Data;
 
-   fdomain_16x0_reset( NULL, 0 );
+   fdomain_16x0_bus_reset( NULL);
 
    if (fdomain_test_loopback()) {
-      printk( "scsi: <fdomain> Detection failed"
-	      " (loopback test failed at port base 0x%x)\n", port_base );
+      printk(KERN_ERR  "scsi: <fdomain> Detection failed (loopback test failed at port base 0x%x)\n", port_base);
       if (setup_called) {
-	 printk( "scsi: <fdomain> Bad LILO/INSMOD parameters?\n" );
+	 printk(KERN_ERR "scsi: <fdomain> Bad LILO/INSMOD parameters?\n");
       }
       return 0;
    }
@@ -963,8 +951,8 @@
       }
    }
 
-				/* Print out a banner here in case we can't
-				   get resources.  */
+/* Print out a banner here in case we can't
+   get resources.  */
 
    shpnt = scsi_register( tpnt, 0 );
    if(shpnt == NULL)
@@ -975,10 +963,9 @@
    shpnt->n_io_port = 0x10;
    print_banner( shpnt );
 
-				/* Log IRQ with kernel */   
+   /* Log IRQ with kernel */   
    if (!interrupt_level) {
-      printk( "scsi: <fdomain>"
-	      " Card Detected, but driver not loaded (no IRQ)\n" );
+      printk(KERN_ERR "scsi: <fdomain> Card Detected, but driver not loaded (no IRQ)\n" );
       return 0;
    } else {
       /* Register the IRQ with the kernel */
@@ -988,25 +975,23 @@
 
       if (retcode < 0) {
 	 if (retcode == -EINVAL) {
-	    printk( "scsi: <fdomain> IRQ %d is bad!\n", interrupt_level );
-	    printk( "                This shouldn't happen!\n" );
-	    printk( "                Send mail to faith@acm.org\n" );
+	    printk(KERN_ERR "scsi: <fdomain> IRQ %d is bad!\n", interrupt_level );
+	    printk(KERN_ERR "                This shouldn't happen!\n" );
+	    printk(KERN_ERR "                Send mail to faith@acm.org\n" );
 	 } else if (retcode == -EBUSY) {
-	    printk( "scsi: <fdomain> IRQ %d is already in use!\n",
-		    interrupt_level );
-	    printk( "                Please use another IRQ!\n" );
+	    printk(KERN_ERR "scsi: <fdomain> IRQ %d is already in use!\n", interrupt_level );
+	    printk(KERN_ERR "                Please use another IRQ!\n" );
 	 } else {
-	    printk( "scsi: <fdomain> Error getting IRQ %d\n",
-		    interrupt_level );
-	    printk( "                This shouldn't happen!\n" );
-	    printk( "                Send mail to faith@acm.org\n" );
+	    printk(KERN_ERR "scsi: <fdomain> Error getting IRQ %d\n", interrupt_level );
+	    printk(KERN_ERR "                This shouldn't happen!\n" );
+	    printk(KERN_ERR "                Send mail to faith@acm.org\n" );
 	 }
-	 printk( "scsi: <fdomain> Detected, but driver not loaded (IRQ)\n" );
+	 printk(KERN_ERR "scsi: <fdomain> Detected, but driver not loaded (IRQ)\n" );
 	 return 0;
       }
    }
 
-				/* Log I/O ports with kernel */
+   /* Log I/O ports with kernel */
    request_region( port_base, 0x10, "fdomain" );
 
 #if DO_DETECT
@@ -1065,7 +1050,7 @@
    return 1;			/* Maximum of one adapter will be detected. */
 }
 
-const char *fdomain_16x0_info( struct Scsi_Host *ignore )
+static const char *fdomain_16x0_info( struct Scsi_Host *ignore )
 {
    static char buffer[128];
    char        *pt;
@@ -1097,7 +1082,7 @@
  * length: If inout==FALSE max number of bytes to be written into the buffer 
  *         else number of bytes in the buffer
  */
-int fdomain_16x0_proc_info( char *buffer, char **start, off_t offset,
+static int fdomain_16x0_proc_info( char *buffer, char **start, off_t offset,
 			    int length, int hostno, int inout )
 {
    const char *info = fdomain_16x0_info( NULL );
@@ -1105,7 +1090,7 @@
    int        pos;
    int        begin;
 
-   if (inout) return(-ENOSYS);
+   if (inout) return(-EINVAL);
     
    begin = 0;
    strcpy( buffer, info );
@@ -1200,7 +1185,7 @@
    return 1;
 }
 
-void my_done( int error )
+static void my_done(int error)
 {
    if (in_command) {
       in_command = 0;
@@ -1218,7 +1203,7 @@
 #endif
 }
 
-void do_fdomain_16x0_intr( int irq, void *dev_id, struct pt_regs * regs )
+static void do_fdomain_16x0_intr( int irq, void *dev_id, struct pt_regs * regs )
 {
    unsigned long flags;
    int      status;
@@ -1376,167 +1361,18 @@
       }
    }
 
-   if (chip == tmc1800
-       && !current_SC->SCp.have_data_in
-       && (current_SC->SCp.sent_command
-	   >= current_SC->cmd_len)) {
-				/* We have to get the FIFO direction
-				   correct, so I've made a table based
-				   on the SCSI Standard of which commands
-				   appear to require a DATA OUT phase.
-				 */
-      /*
-	p. 94: Command for all device types
-	CHANGE DEFINITION            40 DATA OUT
-	COMPARE                      39 DATA OUT
-	COPY                         18 DATA OUT
-	COPY AND VERIFY              3a DATA OUT
-	INQUIRY                      12 
-	LOG SELECT                   4c DATA OUT
-	LOG SENSE                    4d
-	MODE SELECT (6)              15 DATA OUT
-	MODE SELECT (10)             55 DATA OUT
-	MODE SENSE (6)               1a
-	MODE SENSE (10)              5a
-	READ BUFFER                  3c
-	RECEIVE DIAGNOSTIC RESULTS   1c
-	REQUEST SENSE                03
-	SEND DIAGNOSTIC              1d DATA OUT
-	TEST UNIT READY              00
-	WRITE BUFFER                 3b DATA OUT
-
-	p.178: Commands for direct-access devices (not listed on p. 94)
-	FORMAT UNIT                  04 DATA OUT
-	LOCK-UNLOCK CACHE            36
-	PRE-FETCH                    34
-	PREVENT-ALLOW MEDIUM REMOVAL 1e
-	READ (6)/RECEIVE             08
-	READ (10)                    3c
-	READ CAPACITY                25
-	READ DEFECT DATA (10)        37
-	READ LONG                    3e
-	REASSIGN BLOCKS              07 DATA OUT
-	RELEASE                      17
-	RESERVE                      16 DATA OUT
-	REZERO UNIT/REWIND           01
-	SEARCH DATA EQUAL (10)       31 DATA OUT
-	SEARCH DATA HIGH (10)        30 DATA OUT
-	SEARCH DATA LOW (10)         32 DATA OUT
-	SEEK (6)                     0b
-	SEEK (10)                    2b
-	SET LIMITS (10)              33
-	START STOP UNIT              1b
-	SYNCHRONIZE CACHE            35
-	VERIFY (10)                  2f
-	WRITE (6)/PRINT/SEND         0a DATA OUT
-	WRITE (10)/SEND              2a DATA OUT
-	WRITE AND VERIFY (10)        2e DATA OUT
-	WRITE LONG                   3f DATA OUT
-	WRITE SAME                   41 DATA OUT ?
-
-	p. 261: Commands for sequential-access devices (not previously listed)
-	ERASE                        19
-	LOAD UNLOAD                  1b
-	LOCATE                       2b
-	READ BLOCK LIMITS            05
-	READ POSITION                34
-	READ REVERSE                 0f
-	RECOVER BUFFERED DATA        14
-	SPACE                        11
-	WRITE FILEMARKS              10 ?
-
-	p. 298: Commands for printer devices (not previously listed)
-	****** NOT SUPPORTED BY THIS DRIVER, since 0b is SEEK (6) *****
-	SLEW AND PRINT               0b DATA OUT  -- same as seek
-	STOP PRINT                   1b
-	SYNCHRONIZE BUFFER           10
-
-	p. 315: Commands for processor devices (not previously listed)
-	
-	p. 321: Commands for write-once devices (not previously listed)
-	MEDIUM SCAN                  38
-	READ (12)                    a8
-	SEARCH DATA EQUAL (12)       b1 DATA OUT
-	SEARCH DATA HIGH (12)        b0 DATA OUT
-	SEARCH DATA LOW (12)         b2 DATA OUT
-	SET LIMITS (12)              b3
-	VERIFY (12)                  af
-	WRITE (12)                   aa DATA OUT
-	WRITE AND VERIFY (12)        ae DATA OUT
-
-	p. 332: Commands for CD-ROM devices (not previously listed)
-	PAUSE/RESUME                 4b
-	PLAY AUDIO (10)              45
-	PLAY AUDIO (12)              a5
-	PLAY AUDIO MSF               47
-	PLAY TRACK RELATIVE (10)     49
-	PLAY TRACK RELATIVE (12)     a9
-	READ HEADER                  44
-	READ SUB-CHANNEL             42
-	READ TOC                     43
-
-	p. 370: Commands for scanner devices (not previously listed)
-	GET DATA BUFFER STATUS       34
-	GET WINDOW                   25
-	OBJECT POSITION              31
-	SCAN                         1b
-	SET WINDOW                   24 DATA OUT
-
-	p. 391: Commands for optical memory devices (not listed)
-	ERASE (10)                   2c
-	ERASE (12)                   ac
-	MEDIUM SCAN                  38 DATA OUT
-	READ DEFECT DATA (12)        b7
-	READ GENERATION              29
-	READ UPDATED BLOCK           2d
-	UPDATE BLOCK                 3d DATA OUT
-
-	p. 419: Commands for medium changer devices (not listed)
-	EXCHANGE MEDIUM              46
-	INITIALIZE ELEMENT STATUS    07
-	MOVE MEDIUM                  a5
-	POSITION TO ELEMENT          2b
-	READ ELEMENT STATUS          b8
-	REQUEST VOL. ELEMENT ADDRESS b5
-	SEND VOLUME TAG              b6 DATA OUT
-
-	p. 454: Commands for communications devices (not listed previously)
-	GET MESSAGE (6)              08
-	GET MESSAGE (10)             28
-	GET MESSAGE (12)             a8
-      */
-	
-      switch (current_SC->cmnd[0]) {
-      case CHANGE_DEFINITION: case COMPARE:         case COPY:
-      case COPY_VERIFY:       case LOG_SELECT:      case MODE_SELECT:
-      case MODE_SELECT_10:    case SEND_DIAGNOSTIC: case WRITE_BUFFER:
-
-      case FORMAT_UNIT:       case REASSIGN_BLOCKS: case RESERVE:
-      case SEARCH_EQUAL:      case SEARCH_HIGH:     case SEARCH_LOW:
-      case WRITE_6:           case WRITE_10:        case WRITE_VERIFY:
-      case 0x3f:              case 0x41:
-
-      case 0xb1:              case 0xb0:            case 0xb2:
-      case 0xaa:              case 0xae:
-
-      case 0x24:
-
-      case 0x38:              case 0x3d:
-
-      case 0xb6:
-	 
-      case 0xea:		/* alternate number for WRITE LONG */
-	 
+   if (chip == tmc1800 && !current_SC->SCp.have_data_in
+       && (current_SC->SCp.sent_command >= current_SC->cmd_len)) {
+      
+      if(scsi_to_pci_dma_dir(current_SC->sc_data_direction)	== PCI_DMA_TODEVICE)
+      {
 	 current_SC->SCp.have_data_in = -1;
 	 outb( 0xd0 | PARITY_MASK, TMC_Cntl_port );
-	 break;
-
-      case 0x00:
-      default:
-	 
+      }
+      else
+      {
 	 current_SC->SCp.have_data_in = 1;
 	 outb( 0x90 | PARITY_MASK, TMC_Cntl_port );
-	 break;
       }
    }
 
@@ -1565,7 +1401,7 @@
 	    if (current_SC->SCp.buffers_residual) {
 	       --current_SC->SCp.buffers_residual;
 	       ++current_SC->SCp.buffer;
-	       current_SC->SCp.ptr = current_SC->SCp.buffer->address;
+	       current_SC->SCp.ptr = page_address(current_SC->SCp.buffer->page) + current_SC->SCp.buffer->offset;
 	       current_SC->SCp.this_residual = current_SC->SCp.buffer->length;
 	    } else
 		  break;
@@ -1598,7 +1434,7 @@
 	     && current_SC->SCp.buffers_residual) {
 	    --current_SC->SCp.buffers_residual;
 	    ++current_SC->SCp.buffer;
-	    current_SC->SCp.ptr = current_SC->SCp.buffer->address;
+	    current_SC->SCp.ptr = page_address(current_SC->SCp.buffer->page) + current_SC->SCp.buffer->offset;
 	    current_SC->SCp.this_residual = current_SC->SCp.buffer->length;
 	 }
       }
@@ -1661,7 +1497,7 @@
    return;
 }
 
-int fdomain_16x0_queue( Scsi_Cmnd * SCpnt, void (*done)(Scsi_Cmnd *))
+static int fdomain_16x0_queue( Scsi_Cmnd * SCpnt, void (*done)(Scsi_Cmnd *))
 {
    if (in_command) {
       panic( "scsi: <fdomain> fdomain_16x0_queue() NOT REENTRANT!\n" );
@@ -1684,7 +1520,7 @@
    if (current_SC->use_sg) {
       current_SC->SCp.buffer =
 	    (struct scatterlist *)current_SC->request_buffer;
-      current_SC->SCp.ptr              = current_SC->SCp.buffer->address;
+      current_SC->SCp.ptr              = page_address(current_SC->SCp.buffer->page) + current_SC->SCp.buffer->offset;
       current_SC->SCp.this_residual    = current_SC->SCp.buffer->length;
       current_SC->SCp.buffers_residual = current_SC->use_sg - 1;
    } else {
@@ -1719,45 +1555,45 @@
 static volatile int internal_done_flag    = 0;
 static volatile int internal_done_errcode = 0;
 
-static void internal_done( Scsi_Cmnd *SCpnt )
+static void internal_done(Scsi_Cmnd *SCpnt)
 {
     internal_done_errcode = SCpnt->result;
     ++internal_done_flag;
 }
 
-int fdomain_16x0_command( Scsi_Cmnd *SCpnt )
+static int fdomain_16x0_command(Scsi_Cmnd *SCpnt)
 {
-    fdomain_16x0_queue( SCpnt, internal_done );
+    fdomain_16x0_queue(SCpnt, internal_done);
 
     while (!internal_done_flag)
-	  ;
+	  cpu_relax();
     internal_done_flag = 0;
     return internal_done_errcode;
 }
 
 /* End of code derived from Tommy Thorn's work. */
 
-void print_info( Scsi_Cmnd *SCpnt )
+static void print_info(Scsi_Cmnd *SCpnt)
 {
    unsigned int imr;
    unsigned int irr;
    unsigned int isr;
 
    if (!SCpnt || !SCpnt->host) {
-      printk( "scsi: <fdomain> Cannot provide detailed information\n" );
+      printk(KERN_WARNING "scsi: <fdomain> Cannot provide detailed information\n");
       return;
    }
    
-   printk( "%s\n", fdomain_16x0_info( SCpnt->host ) );
-   print_banner( SCpnt->host );
+   printk(KERN_INFO "%s\n", fdomain_16x0_info( SCpnt->host ) );
+   print_banner(SCpnt->host);
    switch (SCpnt->SCp.phase) {
-   case in_arbitration: printk( "arbitration " ); break;
-   case in_selection:   printk( "selection " );   break;
-   case in_other:       printk( "other " );       break;
-   default:             printk( "unknown " );     break;
+   case in_arbitration: printk("arbitration"); break;
+   case in_selection:   printk("selection");   break;
+   case in_other:       printk("other");       break;
+   default:             printk("unknown");     break;
    }
 
-   printk( "(%d), target = %d cmnd = 0x%02x pieces = %d size = %u\n",
+   printk( " (%d), target = %d cmnd = 0x%02x pieces = %d size = %u\n",
 	   SCpnt->SCp.phase,
 	   SCpnt->target,
 	   *(unsigned char *)SCpnt->cmnd,
@@ -1807,21 +1643,17 @@
 		 inb( port_base + Configuration2 ) );
 }
 
-int fdomain_16x0_abort( Scsi_Cmnd *SCpnt)
+static int fdomain_16x0_abort( Scsi_Cmnd *SCpnt)
 {
-   unsigned long flags;
 #if EVERY_ACCESS || ERRORS_ONLY || DEBUG_ABORT
    printk( "scsi: <fdomain> abort " );
 #endif
 
-   save_flags( flags );
-   cli();
    if (!in_command) {
 #if EVERY_ACCESS || ERRORS_ONLY
       printk( " (not in command)\n" );
 #endif
-      restore_flags( flags );
-      return SCSI_ABORT_NOT_RUNNING;
+      return FAILED;
    } else printk( "\n" );
 
 #if DEBUG_ABORT
@@ -1829,52 +1661,39 @@
 #endif
 
    fdomain_make_bus_idle();
-
    current_SC->SCp.phase |= aborted;
-
    current_SC->result = DID_ABORT << 16;
-
-   restore_flags( flags );
    
    /* Aborts are not done well. . . */
-   my_done( DID_ABORT << 16 );
-
-   return SCSI_ABORT_SUCCESS;
+   my_done(DID_ABORT << 16);
+   return SUCCESS;
 }
 
-int fdomain_16x0_reset( Scsi_Cmnd *SCpnt, unsigned int ignored )
+static int fdomain_16x0_bus_reset(Scsi_Cmnd *SCpnt)
 {
-#if DEBUG_RESET
-   static int called_once = 0;
-#endif
-
-#if ERRORS_ONLY
-   if (SCpnt) printk( "scsi: <fdomain> SCSI Bus Reset\n" );
-#endif
-
-#if DEBUG_RESET
-   if (called_once) print_info( current_SC );
-   called_once = 1;
-#endif
-   
    outb( 1, SCSI_Cntl_port );
    do_pause( 2 );
    outb( 0, SCSI_Cntl_port );
    do_pause( 115 );
    outb( 0, SCSI_Mode_Cntl_port );
    outb( PARITY_MASK, TMC_Cntl_port );
+   return SUCCESS;
+}
 
-   /* Unless this is the very first call (i.e., SCPnt == NULL), everything
-      is probably hosed at this point.  We will, however, try to keep
-      things going by informing the high-level code that we need help. */
+static int fdomain_16x0_host_reset(Scsi_Cmnd *SCpnt)
+{
+  return FAILED;
+}
 
-   return SCSI_RESET_WAKEUP;
+static int fdomain_16x0_device_reset(Scsi_Cmnd *SCpnt)
+{
+  return FAILED;
 }
 
 #include "sd.h"
 #include <scsi/scsi_ioctl.h>
 
-int fdomain_16x0_biosparam( Scsi_Disk *disk, struct block_device *bdev, int *info_array )
+static int fdomain_16x0_biosparam(Scsi_Disk *disk, struct block_device *bdev, int *info_array)
 {
    int              drive;
    unsigned char    buf[512 + sizeof (Scsi_Ioctl_Command)];
@@ -2036,7 +1855,7 @@
    return 0;
 }
 
-int fdomain_16x0_release(struct Scsi_Host *shpnt)
+static int fdomain_16x0_release(struct Scsi_Host *shpnt)
 {
 	if (shpnt->irq)
 		free_irq(shpnt->irq, shpnt);
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.2.5.41/drivers/scsi/fdomain.h linux.2.5.41-ac1/drivers/scsi/fdomain.h
--- linux.2.5.41/drivers/scsi/fdomain.h	2002-10-02 21:32:55.000000000 +0100
+++ linux.2.5.41-ac1/drivers/scsi/fdomain.h	2002-10-07 15:38:33.000000000 +0100
@@ -25,29 +25,34 @@
 #ifndef _FDOMAIN_H
 #define _FDOMAIN_H
 
-int        fdomain_16x0_detect( Scsi_Host_Template * );
-int        fdomain_16x0_command( Scsi_Cmnd * );
-int        fdomain_16x0_abort( Scsi_Cmnd * );
-const char *fdomain_16x0_info( struct Scsi_Host * );
-int        fdomain_16x0_reset( Scsi_Cmnd *, unsigned int ); 
-int        fdomain_16x0_queue( Scsi_Cmnd *, void (*done)(Scsi_Cmnd *) );
-int        fdomain_16x0_biosparam( Disk *, struct block_device *, int * );
-int        fdomain_16x0_proc_info( char *buffer, char **start, off_t offset,
+static int        fdomain_16x0_detect( Scsi_Host_Template *);
+static int        fdomain_16x0_command( Scsi_Cmnd *);
+static int        fdomain_16x0_abort(Scsi_Cmnd *);
+static const char *fdomain_16x0_info(struct Scsi_Host *);
+static int        fdomain_16x0_bus_reset(Scsi_Cmnd *); 
+static int        fdomain_16x0_host_reset(Scsi_Cmnd *); 
+static int        fdomain_16x0_device_reset(Scsi_Cmnd *); 
+static int        fdomain_16x0_queue(Scsi_Cmnd *, void (*done)(Scsi_Cmnd *));
+static int        fdomain_16x0_biosparam(Disk *, struct block_device *, int * );
+static int        fdomain_16x0_proc_info(char *buffer, char **start, off_t offset,
 				   int length, int hostno, int inout );
-int        fdomain_16x0_release( struct Scsi_Host *shpnt );
+static int        fdomain_16x0_release(struct Scsi_Host *shpnt);
 
-#define FDOMAIN_16X0 { proc_info:      fdomain_16x0_proc_info,           \
-		       detect:         fdomain_16x0_detect,              \
-		       info:           fdomain_16x0_info,                \
-		       command:        fdomain_16x0_command,             \
-		       queuecommand:   fdomain_16x0_queue,               \
-		       abort:          fdomain_16x0_abort,               \
-		       reset:          fdomain_16x0_reset,               \
-		       bios_param:     fdomain_16x0_biosparam,           \
-		       release:        fdomain_16x0_release,		 \
-		       can_queue:      1, 				 \
-		       this_id:        6, 				 \
-		       sg_tablesize:   64, 				 \
-		       cmd_per_lun:    1, 				 \
-		       use_clustering: DISABLE_CLUSTERING }
+#define FDOMAIN_16X0 { proc_info:      		fdomain_16x0_proc_info,           \
+		       detect:         		fdomain_16x0_detect,              \
+		       info:           		fdomain_16x0_info,                \
+		       command:        		fdomain_16x0_command,             \
+		       queuecommand:   		fdomain_16x0_queue,               \
+		       eh_abort_handler:	fdomain_16x0_abort,               \
+		       eh_bus_reset_handler:	fdomain_16x0_bus_reset,           \
+		       eh_device_reset_handler:	fdomain_16x0_device_reset,        \
+		       eh_host_reset_handler:	fdomain_16x0_host_reset,          \
+		       bios_param:		fdomain_16x0_biosparam,           \
+		       release:			fdomain_16x0_release,		  \
+		       can_queue:		1, 				  \
+		       this_id:  		6, 				  \
+		       sg_tablesize:		64, 				  \
+		       cmd_per_lun:		1, 				  \
+		       use_clustering:		DISABLE_CLUSTERING		  \
+}
 #endif
