Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266536AbRG1KCS>; Sat, 28 Jul 2001 06:02:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266544AbRG1KCA>; Sat, 28 Jul 2001 06:02:00 -0400
Received: from aeon.tvd.be ([195.162.196.20]:60666 "EHLO aeon.tvd.be")
	by vger.kernel.org with ESMTP id <S266536AbRG1KBn>;
	Sat, 28 Jul 2001 06:01:43 -0400
Date: Sat, 28 Jul 2001 11:57:42 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: =?ISO-8859-1?Q?G=E9rard_Roudier?= <groudier@free.fr>
cc: =?ISO-8859-1?Q?G=E9rard_Roudier?= <groudier@club-internet.fr>,
        Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: SCSI Tape corruption - update
In-Reply-To: <20010727221848.F1554-100000@gerard>
Message-ID: <Pine.LNX.4.05.10107281155360.5093-100000@callisto.of.borg>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Fri, 27 Jul 2001, Gérard Roudier wrote:
> On Fri, 27 Jul 2001, Geert Uytterhoeven wrote:
> > On Fri, 20 Jul 2001, Gérard Roudier wrote:
> > > On Fri, 20 Jul 2001, Geert Uytterhoeven wrote:
> > > > The problem is indeed introduced by the changes to the Sym53c8xx in 2.2.18-pre1.
> > > > I managed to find some intermediate versions in the 2.3.x series, and here are the
> > > > results:
> > > >   - sym53c8xx-1.3g (from BK linuxppc_2_2): OK
> > > >   - sym53c8xx-1.5e: crash in SCSI interrupt during driver init
> > > >   - sym53c8xx-1.5f: lock up during driver init
> > > >   - sym53c8xx-1.5g: random 32-byte error bursts when writing to tape
> > >
> > > That's an interesting result. But 1.5g - 1.3g diffs are probably very
> > > large. Patches available from ftp.tux.org should allow to resurrect
> > > driver versions 1.4, 1.5, 1.5a, 1.5b, 1.5c, 1.5d.
> > >
> > > ftp://ftp.tux.org/pub/roudier/drivers/linux/sym53c8xx/README
> > >
> > > You may, for example, apply incremental patches that address kernel 2.2.5
> > > to a fresh kernel 2.2.5 tree and extract driver files accordingly.
> >
> > Thanks!
> >
> > With some small modifications, I made 1.5a to work fine. No error burst. So the
> > problem is introduced between 1.5a and 1.5g.
> 
> Fine! But diffs between 1.5a and 1.5g are still large. :(
> Results with 1.5c would have divided the diffs by about 2. :(
> 
> > Unfortunately my DDS-1 drive seems to have died for real after this test :-(
> > I don't know yet whether I will replace it with a new tape drive or with a
> > CD-RW. Which means I may never find out which change caused the problem...
> 
> I expect the problem to pong again to me. For now, I plan to look into the
> 1.5g-1.5a source diffs and inspect each change. But as I will be in
> vacation for the next two weeks, I will not be able to work on this
> problem immediately.

Just in case the fix is in the changes between the official 1.5a and the 1.5a
in my tree, here are the diffs. But I doubt it.

Good luck!

diff -ur sym53c8xx-s01-d07-2.2.5-1.5a/drivers/scsi/Config.in longtrail-2.2.18-pre1/drivers/scsi/Config.in
--- sym53c8xx-s01-d07-2.2.5-1.5a/drivers/scsi/Config.in	Thu Jul 26 20:14:50 2001
+++ longtrail-2.2.18-pre1/drivers/scsi/Config.in	Thu Jul 26 20:07:03 2001
@@ -18,6 +18,9 @@
 mainmenu_option next_comment
 comment 'SCSI low-level drivers'
 
+if [ "$CONFIG_EXPERIMENTAL" = "y" ]; then
+   dep_tristate '3ware Hardware ATA-RAID support (EXPERIMENTAL)' CONFIG_BLK_DEV_3W_XXXX_RAID $CONFIG_SCSI
+fi
 dep_tristate '7000FASST SCSI support' CONFIG_SCSI_7000FASST $CONFIG_SCSI
 dep_tristate 'ACARD SCSI support' CONFIG_SCSI_ACARD $CONFIG_SCSI
 dep_tristate 'Adaptec AHA152X/2825 support' CONFIG_SCSI_AHA152X $CONFIG_SCSI
@@ -25,13 +28,12 @@
 dep_tristate 'Adaptec AHA1740 support' CONFIG_SCSI_AHA1740 $CONFIG_SCSI
 dep_tristate 'Adaptec AIC7xxx support' CONFIG_SCSI_AIC7XXX $CONFIG_SCSI
 if [ "$CONFIG_SCSI_AIC7XXX" != "n" ]; then
-    bool '   Override driver defaults for commands per LUN' CONFIG_OVERRIDE_CMDS N
-    if [ "$CONFIG_OVERRIDE_CMDS" != "n" ]; then
-      int  '   Maximum number of commands per LUN' CONFIG_AIC7XXX_CMDS_PER_LUN 24
-    fi
+    bool '   Enable Tagged Command Queueing (TCQ) by default' CONFIG_AIC7XXX_TCQ_ON_BY_DEFAULT
+    int  '   Maximum number of TCQ commands per device' CONFIG_AIC7XXX_CMDS_PER_DEVICE 8
     bool '   Collect statistics to report in /proc' CONFIG_AIC7XXX_PROC_STATS N
     int  '   Delay in seconds after SCSI bus reset' CONFIG_AIC7XXX_RESET_DELAY 5
 fi
+dep_tristate 'IBM ServeRAID support' CONFIG_SCSI_IPS $CONFIG_SCSI
 dep_tristate 'AdvanSys SCSI support' CONFIG_SCSI_ADVANSYS $CONFIG_SCSI
 dep_tristate 'Always IN2000 SCSI support' CONFIG_SCSI_IN2000 $CONFIG_SCSI
 dep_tristate 'AM53/79C974 PCI SCSI support' CONFIG_SCSI_AM53C974 $CONFIG_SCSI
@@ -52,9 +54,7 @@
 dep_tristate 'EATA-PIO (old DPT PM2001, PM2012A) support' CONFIG_SCSI_EATA_PIO $CONFIG_SCSI
 dep_tristate 'Future Domain 16xx SCSI/AHA-2920A support' CONFIG_SCSI_FUTURE_DOMAIN $CONFIG_SCSI
 if [ "$CONFIG_MCA" = "y" ]; then
-  if [ "$CONFIG_SCSI" = "y" ]; then
-    bool 'Future Domain MCS-600/700 SCSI support' CONFIG_SCSI_FD_MCS
-  fi
+    dep_tristate 'Future Domain MCS-600/700 SCSI support' CONFIG_SCSI_FD_MCS $CONFIG_SCSI
 fi
 dep_tristate 'GDT SCSI Disk Array Controller support' CONFIG_SCSI_GDTH $CONFIG_SCSI
 dep_tristate 'Generic NCR5380/53c400 SCSI support' CONFIG_SCSI_GENERIC_NCR5380 $CONFIG_SCSI
@@ -78,6 +78,7 @@
 fi
 dep_tristate 'NCR53c406a SCSI support' CONFIG_SCSI_NCR53C406A $CONFIG_SCSI
 dep_tristate 'symbios 53c416 SCSI support' CONFIG_SCSI_SYM53C416 $CONFIG_SCSI
+dep_tristate 'Simple 53c710 SCSI support (Compaq, NCR machines)' CONFIG_SCSI_SIM710 $CONFIG_SCSI
 if [ "$CONFIG_PCI" = "y" ]; then
   dep_tristate 'NCR53c7,8xx SCSI support'  CONFIG_SCSI_NCR53C7xx $CONFIG_SCSI
   if [ "$CONFIG_SCSI_NCR53C7xx" != "n" ]; then
@@ -95,8 +96,9 @@
     int  '  synchronous transfers frequency in MHz' CONFIG_SCSI_NCR53C8XX_SYNC 20
     bool '  enable profiling' CONFIG_SCSI_NCR53C8XX_PROFILE
     bool '  use normal IO' CONFIG_SCSI_NCR53C8XX_IOMAPPED
-    bool '  include support for the NCR PQS/PDS SCSI card' CONFIG_SCSI_NCR53C8XX_PQS_PDS
-    bool '  enable immediate arbitration' CONFIG_SCSI_NCR53C8XX_IARB
+    if [ "$CONFIG_SCSI_SYM53C8XX" != "n" ]; then
+      bool '  include support for the NCR PQS/PDS SCSI card' CONFIG_SCSI_NCR53C8XX_PQS_PDS
+    fi
     if [ "$CONFIG_SCSI_NCR53C8XX_DEFAULT_TAGS" = "0" ]; then
       bool '  not allow targets to disconnect' CONFIG_SCSI_NCR53C8XX_NO_DISCONNECT
     fi
diff -ur sym53c8xx-s01-d07-2.2.5-1.5a/drivers/scsi/sym53c8xx.c longtrail-2.2.18-pre1/drivers/scsi/sym53c8xx.c
--- sym53c8xx-s01-d07-2.2.5-1.5a/drivers/scsi/sym53c8xx.c	Thu Jul 26 20:14:05 2001
+++ longtrail-2.2.18-pre1/drivers/scsi/sym53c8xx.c	Thu Jul 26 22:43:12 2001
@@ -73,6 +73,7 @@
 **		53C895	  (Wide,   Fast 40,	 on-board rom BIOS)
 **		53C895A	  (Wide,   Fast 40,	 on-board rom BIOS)
 **		53C896	  (Wide,   Fast 40 Dual, on-board rom BIOS)
+**		53C1510D	  (Wide,   Fast 40 Dual, on-board rom BIOS)
 **
 **	Other features:
 **		Memory mapped IO
@@ -558,10 +559,11 @@
 #endif
 
 #ifdef __sparc__
+#  include <asm/irq.h>
 #  define remap_pci_mem(base, size)	((u_long) __va(base))
 #  define unmap_pci_mem(vaddr, size)
 #  define pcivtobus(p)			((p) & pci_dvma_mask)
-#  define memcpy_to_pci(a, b, c)	memcpy_toio((u_long) (a), (b), (c))
+#  define memcpy_to_pci(a, b, c)	memcpy_toio((void *) (a), (b), (c))
 #elif defined(__alpha__)
 #  define pcivtobus(p)			((p) & 0xfffffffful)
 #  define memcpy_to_pci(a, b, c)	memcpy_toio((a), (b), (c))
@@ -1808,6 +1810,8 @@
 	*/
 	u_short		device_id;	/* PCI device id		*/
 	u_char		revision_id;	/* PCI device revision id	*/
+	u_char		pci_bus;	/* PCI bus number		*/
+	u_char		pci_devfn;	/* PCI device and function	*/
 	u_int		features;	/* Chip features map		*/
 	u_char		myaddr;		/* SCSI id of the adapter	*/
 	u_char		maxburst;	/* log base 2 of dwords burst	*/
@@ -4582,7 +4586,7 @@
 	**	64 bit (53C895A or 53C896) ?
 	*/
 	if (np->features & FE_64BIT)
-#if BITS_PER_LONG > 32
+#ifdef SCSI_NCR_USE_64BIT_DAC
 		np->rv_ccntl1	|= (XTIMOD | EXTIBMV);
 #else
 		np->rv_ccntl1	|= (DDAC);
@@ -4955,6 +4959,8 @@
 	sprintf(np->inst_name, NAME53C "%s-%d", np->chip_name, np->unit);
 	np->device_id	= device->chip.device_id;
 	np->revision_id	= device->chip.revision_id;
+	np->pci_bus	= device->slot.bus;
+	np->pci_devfn	= device->slot.device_fn;
 	np->features	= device->chip.features;
 	np->clock_divn	= device->chip.nr_divisor;
 	np->maxoffs	= device->chip.offset_max;
@@ -5088,7 +5094,7 @@
 	**	the clock doubler.
 	*/
 	i = (int) ncr_getpciclock(np);
-	if (i > 37000) {
+	if (0 && i > 37000) {
 		printk(KERN_ERR "%s: PCI clock seems too high (%u KHz).\n",
 		       ncr_name(np), i);
 		goto attach_error;
@@ -10091,7 +10097,7 @@
 **	code will get more complex later).
 */
 
-#if BITS_PER_LONG > 32
+#ifdef SCSI_NCR_USE_64BIT_DAC
 #define SCATTER_ONE(data, badd, len)					\
 	(data)->addr = cpu_to_scr(badd);				\
 	(data)->size = cpu_to_scr((((badd) >> 8) & 0xff000000) + len);
@@ -10531,6 +10537,8 @@
 	u_int f1, f2;
 	int gen = 11;
 
+	OUTB(nc_istat, SRST); UDELAY (5); OUTB(nc_istat, 0);
+
 	(void) ncrgetfreq (np, gen);	/* throw away first result */
 	f1 = ncrgetfreq (np, gen);
 	f2 = ncrgetfreq (np, gen);
@@ -11290,7 +11298,7 @@
 	**	Ignore Symbios chips controlled by SISL RAID controller.
 	**	This controller sets value 0x52414944 at RAM end - 16.
 	*/
-#ifndef SCSI_NCR_PCI_MEM_NOT_SUPPORTED
+#if defined(__i386__) && !defined(SCSI_NCR_PCI_MEM_NOT_SUPPORTED)
 	if (chip && (base_2 & PCI_BASE_ADDRESS_MEM_MASK)) {
 		unsigned int ram_size, ram_val;
 		u_long ram_ptr;
@@ -11379,6 +11387,8 @@
 	if (!cache_line_size)
 		suggested_cache_line_size = 16;
 
+	driver_setup.pci_fix_up |= 0x7;
+
 #endif	/* __sparc__ */
 
 #if defined(__i386__) && !defined(MODULE)
@@ -11692,7 +11702,15 @@
 */
 const char *sym53c8xx_info (struct Scsi_Host *host)
 {
+#ifdef __sparc__
+	/* Ok to do this on all archs? */
+	static char buffer[80];
+	ncb_p np = ((struct host_data *) host->hostdata)->ncb;
+	sprintf (buffer, "%s\nPCI bus %02x device %02x", SCSI_NCR_DRIVER_NAME, np->pci_bus, np->pci_devfn);
+	return buffer;
+#else
 	return SCSI_NCR_DRIVER_NAME;
+#endif
 }
 
 /*
@@ -12274,7 +12292,13 @@
 	copy_info(&info, "revision id 0x%x\n",	np->revision_id);
 
 	copy_info(&info, "  IO port address 0x%lx, ", (u_long) np->base_io);
+#ifdef __sparc__
+	copy_info(&info, "IRQ number %s\n", __irq_itoa(np->irq));
+	/* Ok to do this on all archs? */
+	copy_info(&info, "PCI bus %02x device %02x\n", np->pci_bus, np->pci_devfn);
+#else
 	copy_info(&info, "IRQ number %d\n", (int) np->irq);
+#endif
 
 #ifndef NCR_IOMAPPED
 	if (np->reg)
diff -ur sym53c8xx-s01-d07-2.2.5-1.5a/drivers/scsi/sym53c8xx_defs.h longtrail-2.2.18-pre1/drivers/scsi/sym53c8xx_defs.h
--- sym53c8xx-s01-d07-2.2.5-1.5a/drivers/scsi/sym53c8xx_defs.h	Thu Jul 26 20:14:05 2001
+++ longtrail-2.2.18-pre1/drivers/scsi/sym53c8xx_defs.h	Thu Jul 26 22:42:44 2001
@@ -66,8 +66,9 @@
 #endif
 #include <linux/config.h>
 
+#ifndef LinuxVersionCode
 #define LinuxVersionCode(v, p, s) (((v)<<16)+((p)<<8)+(s))
-
+#endif
 /*
  * NCR PQS/PDS special device support.
  */
@@ -182,6 +183,13 @@
 #endif
 
 /*
+ * Should we enable DAC cycles on this platform?
+ * Until further investigation we do not enable it
+ * anywhere at the moment.
+ */
+#undef SCSI_NCR_USE_64BIT_DAC
+
+/*
  * Sync transfer frequency at startup.
  * Allow from 5Mhz to 40Mhz default 20 Mhz.
  */
@@ -395,6 +403,10 @@
 #define PCI_DEVICE_ID_NCR_53C895A 0x12
 #endif
 
+#ifndef PCI_DEVICE_ID_NCR_53C1510D
+#define PCI_DEVICE_ID_NCR_53C1510D 0xa
+#endif
+
 /*
 **   NCR53C8XX devices features table.
 */
@@ -482,6 +494,9 @@
  {PCI_DEVICE_ID_NCR_53C875, 0x2f, "875E",  6, 16, 5,			\
  FE_WIDE|FE_ULTRA|FE_DBLR|FE_CACHE0_SET|FE_BOF|FE_DFS|FE_LDSTR|FE_PFEN|FE_RAM}\
  ,									\
+ {PCI_DEVICE_ID_NCR_53C875, 0xff, "876",  6, 16, 5,			\
+ FE_WIDE|FE_ULTRA|FE_DBLR|FE_CACHE0_SET|FE_BOF|FE_DFS|FE_LDSTR|FE_PFEN|FE_RAM}\
+ ,									\
  {PCI_DEVICE_ID_NCR_53C875J,0xff, "875J", 6, 16, 5,			\
  FE_WIDE|FE_ULTRA|FE_DBLR|FE_CACHE0_SET|FE_BOF|FE_DFS|FE_LDSTR|FE_PFEN|FE_RAM}\
  ,									\
@@ -498,6 +513,10 @@
  {PCI_DEVICE_ID_NCR_53C895A, 0xff, "895a",  6, 31, 7,			\
  FE_WIDE|FE_ULTRA2|FE_QUAD|FE_CACHE_SET|FE_BOF|FE_DFS|FE_LDSTR|FE_PFEN|FE_RAM|\
  FE_RAM8K|FE_64BIT|FE_IO256|FE_NOPM|FE_LEDC}\
+ ,									\
+ {PCI_DEVICE_ID_NCR_53C1510D, 0xff, "1510D",  7, 31, 7,			\
+ FE_WIDE|FE_ULTRA2|FE_QUAD|FE_CACHE_SET|FE_BOF|FE_DFS|FE_LDSTR|FE_PFEN|FE_RAM|\
+ FE_IO256}\
 }
 
 /*
@@ -515,7 +534,8 @@
 	PCI_DEVICE_ID_NCR_53C885,	\
 	PCI_DEVICE_ID_NCR_53C895,	\
 	PCI_DEVICE_ID_NCR_53C896,	\
-	PCI_DEVICE_ID_NCR_53C895A	\
+	PCI_DEVICE_ID_NCR_53C895A,	\
+	PCI_DEVICE_ID_NCR_53C1510D	\
 }
 
 /*


Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

