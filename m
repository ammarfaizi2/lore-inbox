Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289049AbSAFVNl>; Sun, 6 Jan 2002 16:13:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289040AbSAFVMW>; Sun, 6 Jan 2002 16:12:22 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:62470 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S289035AbSAFVKt>; Sun, 6 Jan 2002 16:10:49 -0500
Message-ID: <3C38BC19.72ECE86@zip.com.au>
Date: Sun, 06 Jan 2002 13:05:29 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.17-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Richard Gooch <rgooch@ras.ucalgary.ca>
CC: Ivan Passos <ivan@cyclades.com>, linux-kernel@vger.kernel.org
Subject: Re: Serial Driver Name Question (kernels 2.4.x)
In-Reply-To: <3C34024A.EDA31D24@zip.com.au>,
		<3C33E0D3.B6E932D6@zip.com.au>
		<3C33BCF3.20BE9E92@cyclades.com>
		<200201030637.g036bxe03425@vindaloo.ras.ucalgary.ca>
		<3C34024A.EDA31D24@zip.com.au> <200201062012.g06KCIu16158@vindaloo.ras.ucalgary.ca>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard Gooch wrote:
> 
> Andrew Morton writes:
> > Richard Gooch wrote:
> > >
> > > > Instead, it appears that someone broke tty_name().  Here's the
> > > > 2.2 kernel's version:
> > >
> > > That "someone" was me, and I changed it from broken to fixed.
> > >
> >
> > Look at serial.c:
> >
> > #if (LINUX_VERSION_CODE > 0x2032D && defined(CONFIG_DEVFS_FS))
> >         serial_driver.name = "tts/%d";
> > #else
> >         serial_driver.name = "ttyS";
> > #endif
> >
> > tty_name will just print "ttyS".   So the transition for this case
> > was fixed->broken.
> 
> Why exactly is just "ttyS" broken?
> 

umm..  Because it doesn't tell the user which serial port the
message pertains to?

Here's a first cut.  This is silly, and we don't want to do
it this way.  The "/%d" or "%d" concat, and the knowledge of devfs
should be contained in one place.  Please suggest something.

net/irda/ircomm/ircomm_tty.c doesn't have a "/" in the name for
the devfs case.  Please review that.


--- linux-2.4.18-pre1/net/irda/ircomm/ircomm_tty.c	Sun Sep 30 12:26:09 2001
+++ linux-akpm/net/irda/ircomm/ircomm_tty.c	Sun Jan  6 12:44:20 2002
@@ -103,7 +103,7 @@ int __init ircomm_tty_init(void)
 #ifdef CONFIG_DEVFS_FS
 	driver.name            = "ircomm%d";
 #else
-	driver.name            = "ircomm";
+	driver.name            = "ircomm%d";
 #endif
 	driver.major           = IRCOMM_TTY_MAJOR;
 	driver.minor_start     = IRCOMM_TTY_MINOR;
--- linux-2.4.18-pre1/drivers/net/wan/sdla_chdlc.c	Thu Sep 13 16:04:43 2001
+++ linux-akpm/drivers/net/wan/sdla_chdlc.c	Sun Jan  6 13:01:32 2002
@@ -4638,7 +4638,7 @@ int wanpipe_tty_init(sdla_t *card)
 		memset(&serial_driver, 0, sizeof(struct tty_driver));
 		serial_driver.magic = TTY_DRIVER_MAGIC;
 		serial_driver.driver_name = "wanpipe_tty"; 
-		serial_driver.name = "ttyW";
+		serial_driver.name = "ttyW%d";
 		serial_driver.major = WAN_TTY_MAJOR;
 		serial_driver.minor_start = WAN_TTY_MINOR;
 		serial_driver.num = NR_PORTS; 
--- linux-2.4.18-pre1/drivers/char/pty.c	Fri Dec 21 11:19:13 2001
+++ linux-akpm/drivers/char/pty.c	Sun Jan  6 12:47:10 2002
@@ -452,11 +452,7 @@ int __init pty_init(void)
 			init_waitqueue_head(&ptm_state[i][j].open_wait);
 		
 		pts_driver[i] = pty_slave_driver;
-#ifdef CONFIG_DEVFS_FS
 		pts_driver[i].name = "pts/%d";
-#else
-		pts_driver[i].name = "pts";
-#endif
 		pts_driver[i].proc_entry = 0;
 		pts_driver[i].major = UNIX98_PTY_SLAVE_MAJOR+i;
 		pts_driver[i].minor_start = 0;
--- linux-2.4.18-pre1/drivers/char/esp.c	Thu Nov 22 23:02:57 2001
+++ linux-akpm/drivers/char/esp.c	Sun Jan  6 13:02:00 2002
@@ -2547,7 +2547,7 @@ int __init espserial_init(void)
 	
 	memset(&esp_driver, 0, sizeof(struct tty_driver));
 	esp_driver.magic = TTY_DRIVER_MAGIC;
-	esp_driver.name = "ttyP";
+	esp_driver.name = "ttyP%d";
 	esp_driver.major = ESP_IN_MAJOR;
 	esp_driver.minor_start = 0;
 	esp_driver.num = NR_PORTS;
--- linux-2.4.18-pre1/drivers/char/serial.c	Wed Dec 26 11:47:40 2001
+++ linux-akpm/drivers/char/serial.c	Sun Jan  6 12:47:56 2002
@@ -5389,7 +5389,7 @@ static int __init rs_init(void)
 #if (LINUX_VERSION_CODE > 0x2032D && defined(CONFIG_DEVFS_FS))
 	serial_driver.name = "tts/%d";
 #else
-	serial_driver.name = "ttyS";
+	serial_driver.name = "ttyS%d";
 #endif
 	serial_driver.major = TTY_MAJOR;
 	serial_driver.minor_start = 64 + SERIAL_DEV_OFFSET;
--- linux-2.4.18-pre1/drivers/char/cyclades.c	Fri Sep 14 14:04:07 2001
+++ linux-akpm/drivers/char/cyclades.c	Sun Jan  6 12:48:34 2002
@@ -5496,7 +5496,7 @@ cy_init(void)
     memset(&cy_serial_driver, 0, sizeof(struct tty_driver));
     cy_serial_driver.magic = TTY_DRIVER_MAGIC;
     cy_serial_driver.driver_name = "cyclades";
-    cy_serial_driver.name = "ttyC";
+    cy_serial_driver.name = "ttyC%d";
     cy_serial_driver.major = CYCLADES_MAJOR;
     cy_serial_driver.minor_start = 0;
     cy_serial_driver.num = NR_PORTS;
--- linux-2.4.18-pre1/drivers/char/rocket.c	Fri Sep 21 10:55:22 2001
+++ linux-akpm/drivers/char/rocket.c	Sun Jan  6 12:48:48 2002
@@ -2189,7 +2189,7 @@ int __init rp_init(void)
 #ifdef CONFIG_DEVFS_FS
 	rocket_driver.name = "tts/R%d";
 #else
-	rocket_driver.name = "ttyR";
+	rocket_driver.name = "ttyR%d";
 #endif
 	rocket_driver.major = TTY_ROCKET_MAJOR;
 	rocket_driver.minor_start = 0;
--- linux-2.4.18-pre1/drivers/char/istallion.c	Mon Nov  5 21:01:11 2001
+++ linux-akpm/drivers/char/istallion.c	Sun Jan  6 13:02:33 2002
@@ -171,9 +171,9 @@ static devfs_handle_t devfs_handle;
  *	all the local structures required by a serial tty driver.
  */
 static char	*stli_drvtitle = "Stallion Intelligent Multiport Serial Driver";
-static char	*stli_drvname = "istallion";
+static char	*stli_drvname = "istallion%d";
 static char	*stli_drvversion = "5.6.0";
-static char	*stli_serialname = "ttyE";
+static char	*stli_serialname = "ttyE%d";
 static char	*stli_calloutname = "cue";
 
 static struct tty_driver	stli_serial;
--- linux-2.4.18-pre1/drivers/char/pcxx.c	Thu Sep 13 15:21:32 2001
+++ linux-akpm/drivers/char/pcxx.c	Sun Jan  6 12:49:49 2002
@@ -1229,7 +1229,7 @@ int __init pcxe_init(void)
 
 	memset(&pcxe_driver, 0, sizeof(struct tty_driver));
 	pcxe_driver.magic = TTY_DRIVER_MAGIC;
-	pcxe_driver.name = "ttyD";
+	pcxe_driver.name = "ttyD%d";
 	pcxe_driver.major = DIGI_MAJOR; 
 	pcxe_driver.minor_start = 0;
 
--- linux-2.4.18-pre1/drivers/char/sh-sci.c	Mon Oct 15 13:36:48 2001
+++ linux-akpm/drivers/char/sh-sci.c	Sun Jan  6 13:02:56 2002
@@ -1025,7 +1025,7 @@ static int sci_init_drivers(void)
 #ifdef CONFIG_DEVFS_FS
 	sci_driver.name = "ttsc/%d";
 #else
-	sci_driver.name = "ttySC";
+	sci_driver.name = "ttySC%d";
 #endif
 	sci_driver.major = SCI_MAJOR;
 	sci_driver.minor_start = SCI_MINOR_START;
@@ -1064,7 +1064,7 @@ static int sci_init_drivers(void)
 #ifdef CONFIG_DEVFS_FS
 	sci_callout_driver.name = "cusc/%d";
 #else
-	sci_callout_driver.name = "cusc";
+	sci_callout_driver.name = "cusc%d";
 #endif
 	sci_callout_driver.major = SCI_MAJOR+1;
 	sci_callout_driver.subtype = SERIAL_TYPE_CALLOUT;
--- linux-2.4.18-pre1/drivers/char/riscom8.c	Thu Sep 13 15:21:32 2001
+++ linux-akpm/drivers/char/riscom8.c	Sun Jan  6 12:50:08 2002
@@ -1755,7 +1755,7 @@ static inline int rc_init_drivers(void)
 	memset(IRQ_to_board, 0, sizeof(IRQ_to_board));
 	memset(&riscom_driver, 0, sizeof(riscom_driver));
 	riscom_driver.magic = TTY_DRIVER_MAGIC;
-	riscom_driver.name = "ttyL";
+	riscom_driver.name = "ttyL%d";
 	riscom_driver.major = RISCOM8_NORMAL_MAJOR;
 	riscom_driver.num = RC_NBOARD * RC_NPORT;
 	riscom_driver.type = TTY_DRIVER_TYPE_SERIAL;
--- linux-2.4.18-pre1/drivers/char/specialix.c	Thu Nov 22 23:02:57 2001
+++ linux-akpm/drivers/char/specialix.c	Sun Jan  6 12:50:17 2002
@@ -2233,7 +2233,7 @@ static int sx_init_drivers(void)
 	init_bh(SPECIALIX_BH, do_specialix_bh);
 	memset(&specialix_driver, 0, sizeof(specialix_driver));
 	specialix_driver.magic = TTY_DRIVER_MAGIC;
-	specialix_driver.name = "ttyW";
+	specialix_driver.name = "ttyW%d";
 	specialix_driver.major = SPECIALIX_NORMAL_MAJOR;
 	specialix_driver.num = SX_NBOARD * SX_NPORT;
 	specialix_driver.type = TTY_DRIVER_TYPE_SERIAL;
--- linux-2.4.18-pre1/drivers/char/epca.c	Fri Oct 12 13:48:42 2001
+++ linux-akpm/drivers/char/epca.c	Sun Jan  6 12:50:27 2002
@@ -1718,7 +1718,7 @@ int __init pc_init(void)
 	memset(&pc_info, 0, sizeof(struct tty_driver));
 
 	pc_driver.magic = TTY_DRIVER_MAGIC;
-	pc_driver.name = "ttyD"; 
+	pc_driver.name = "ttyD%d"; 
 	pc_driver.major = DIGI_MAJOR; 
 	pc_driver.minor_start = 0;
 	pc_driver.num = MAX_ALLOC;
--- linux-2.4.18-pre1/drivers/char/sx.c	Thu Nov 22 23:02:57 2001
+++ linux-akpm/drivers/char/sx.c	Sun Jan  6 12:50:38 2002
@@ -2222,7 +2222,7 @@ static int sx_init_drivers(void)
 	memset(&sx_driver, 0, sizeof(sx_driver));
 	sx_driver.magic = TTY_DRIVER_MAGIC;
 	sx_driver.driver_name = "specialix_sx";
-	sx_driver.name = "ttyX";
+	sx_driver.name = "ttyX%d";
 	sx_driver.major = SX_NORMAL_MAJOR;
 	sx_driver.num = sx_nports;
 	sx_driver.type = TTY_DRIVER_TYPE_SERIAL;
--- linux-2.4.18-pre1/drivers/char/serial_amba.c	Sun Sep 16 21:23:14 2001
+++ linux-akpm/drivers/char/serial_amba.c	Sun Jan  6 12:51:16 2002
@@ -1776,7 +1776,7 @@ int __init ambauart_init(void)
 
 	ambanormal_driver.magic = TTY_DRIVER_MAGIC;
 	ambanormal_driver.driver_name = "serial_amba";
-	ambanormal_driver.name = SERIAL_AMBA_NAME;
+	ambanormal_driver.name = SERIAL_AMBA_NAME "%d";
 	ambanormal_driver.major = SERIAL_AMBA_MAJOR;
 	ambanormal_driver.minor_start = SERIAL_AMBA_MINOR;
 	ambanormal_driver.num = SERIAL_AMBA_NR;
--- linux-2.4.18-pre1/drivers/char/dz.c	Sun Sep  9 10:43:02 2001
+++ linux-akpm/drivers/char/dz.c	Sun Jan  6 13:03:32 2002
@@ -1338,7 +1338,7 @@ int __init dz_init(void)
 	memset(&serial_driver, 0, sizeof(struct tty_driver));
 	serial_driver.magic = TTY_DRIVER_MAGIC;
 #if (LINUX_VERSION_CODE > 0x2032D && defined(CONFIG_DEVFS_FS))
-	serial_driver.name = "ttyS";
+	serial_driver.name = "ttyS%d";
 #else
 	serial_driver.name = "tts/%d";
 #endif
@@ -1379,7 +1379,7 @@ int __init dz_init(void)
 	 */
 	callout_driver = serial_driver;
 #if (LINUX_VERSION_CODE > 0x2032D && defined(CONFIG_DEVFS_FS))
-	callout_driver.name = "cua";
+	callout_driver.name = "cua%d";
 #else
 	callout_driver.name = "cua/%d";
 #endif
--- linux-2.4.18-pre1/drivers/char/isicom.c	Thu Nov 22 23:02:57 2001
+++ linux-akpm/drivers/char/isicom.c	Sun Jan  6 12:51:37 2002
@@ -1718,7 +1718,7 @@ static int register_drivers(void)
 	/* tty driver structure initialization */
 	memset(&isicom_normal, 0, sizeof(struct tty_driver));
 	isicom_normal.magic	= TTY_DRIVER_MAGIC;
-	isicom_normal.name 	= "ttyM";
+	isicom_normal.name 	= "ttyM%d";
 	isicom_normal.major	= ISICOM_NMAJOR;
 	isicom_normal.minor_start	= 0;
 	isicom_normal.num	= PORT_COUNT;
--- linux-2.4.18-pre1/drivers/char/synclink.c	Fri Dec 21 11:19:13 2001
+++ linux-akpm/drivers/char/synclink.c	Sun Jan  6 12:51:45 2002
@@ -4587,7 +4587,7 @@ int mgsl_init_tty()
 	memset(&serial_driver, 0, sizeof(struct tty_driver));
 	serial_driver.magic = TTY_DRIVER_MAGIC;
 	serial_driver.driver_name = "synclink";
-	serial_driver.name = "ttySL";
+	serial_driver.name = "ttySL%d";
 	serial_driver.major = ttymajor;
 	serial_driver.minor_start = 64;
 	serial_driver.num = mgsl_device_count;
--- linux-2.4.18-pre1/drivers/char/mxser.c	Mon Nov  5 21:01:11 2001
+++ linux-akpm/drivers/char/mxser.c	Sun Jan  6 12:51:53 2002
@@ -523,7 +523,7 @@ int mxser_init(void)
 	 * major number and the subtype code.
 	 */
 	mxvar_cdriver = mxvar_sdriver;
-	mxvar_cdriver.name = "cum";
+	mxvar_cdriver.name = "cum%d";
 	mxvar_cdriver.major = calloutmajor;
 	mxvar_cdriver.subtype = SERIAL_TYPE_CALLOUT;
 
--- linux-2.4.18-pre1/drivers/char/serial167.c	Sun Sep 16 21:23:07 2001
+++ linux-akpm/drivers/char/serial167.c	Sun Jan  6 12:51:59 2002
@@ -2395,7 +2395,7 @@ scrn[1] = '\0';
     
     memset(&cy_serial_driver, 0, sizeof(struct tty_driver));
     cy_serial_driver.magic = TTY_DRIVER_MAGIC;
-    cy_serial_driver.name = "ttyS";
+    cy_serial_driver.name = "ttyS%d";
     cy_serial_driver.major = TTY_MAJOR;
     cy_serial_driver.minor_start = 64;
     cy_serial_driver.num = NR_PORTS;
--- linux-2.4.18-pre1/drivers/char/ip2main.c	Mon Nov  5 21:01:11 2001
+++ linux-akpm/drivers/char/ip2main.c	Sun Jan  6 12:52:46 2002
@@ -235,7 +235,7 @@ static char *pcDriver_name   = "ip2";
 static char *pcTty    		 = "tts/F%d";
 static char *pcCallout		 = "cua/F%d";
 #else
-static char *pcTty    		 = "ttyF";
+static char *pcTty    		 = "ttyF%d";
 static char *pcCallout		 = "cuf";
 #endif
 static char *pcIpl    		 = "ip2ipl";
--- linux-2.4.18-pre1/drivers/char/vme_scc.c	Sun Sep 16 21:22:50 2001
+++ linux-akpm/drivers/char/vme_scc.c	Sun Jan  6 12:52:57 2002
@@ -131,7 +131,7 @@ static int scc_init_drivers(void)
 	memset(&scc_driver, 0, sizeof(scc_driver));
 	scc_driver.magic = TTY_DRIVER_MAGIC;
 	scc_driver.driver_name = "scc";
-	scc_driver.name = "ttyS";
+	scc_driver.name = "ttyS%d";
 	scc_driver.major = TTY_MAJOR;
 	scc_driver.minor_start = SCC_MINOR_BASE;
 	scc_driver.num = 2;
--- linux-2.4.18-pre1/drivers/char/stallion.c	Fri Sep 21 10:55:23 2001
+++ linux-akpm/drivers/char/stallion.c	Sun Jan  6 12:53:17 2002
@@ -143,7 +143,7 @@ static char	*stl_drvversion = "5.6.0";
 static char	*stl_serialname = "tts/E%d";
 static char	*stl_calloutname = "cua/E%d";
 #else
-static char	*stl_serialname = "ttyE";
+static char	*stl_serialname = "ttyE%d";
 static char	*stl_calloutname = "cue";
 #endif
 
--- linux-2.4.18-pre1/drivers/char/rio/rio_linux.c	Mon Nov  5 21:01:11 2001
+++ linux-akpm/drivers/char/rio/rio_linux.c	Sun Jan  6 12:53:40 2002
@@ -912,7 +912,7 @@ static int rio_init_drivers(void)
   memset(&rio_driver, 0, sizeof(rio_driver));
   rio_driver.magic = TTY_DRIVER_MAGIC;
   rio_driver.driver_name = "specialix_rio";
-  rio_driver.name = "ttySR";
+  rio_driver.name = "ttySR%d";
   rio_driver.major = RIO_NORMAL_MAJOR0;
   rio_driver.num = 256;
   rio_driver.type = TTY_DRIVER_TYPE_SERIAL;
--- linux-2.4.18-pre1/drivers/char/moxa.c	Mon Nov  5 21:01:11 2001
+++ linux-akpm/drivers/char/moxa.c	Sun Jan  6 12:53:51 2002
@@ -344,7 +344,7 @@ int moxa_init(void)
 	memset(&moxaDriver, 0, sizeof(struct tty_driver));
 	memset(&moxaCallout, 0, sizeof(struct tty_driver));
 	moxaDriver.magic = TTY_DRIVER_MAGIC;
-	moxaDriver.name = "ttya";
+	moxaDriver.name = "ttya%d";
 	moxaDriver.major = ttymajor;
 	moxaDriver.minor_start = 0;
 	moxaDriver.num = MAX_PORTS + 1;
--- linux-2.4.18-pre1/drivers/char/serial_21285.c	Thu Sep 13 15:21:32 2001
+++ linux-akpm/drivers/char/serial_21285.c	Sun Jan  6 12:54:09 2002
@@ -299,7 +299,7 @@ static int __init rs285_init(void)
 
 	rs285_driver.magic = TTY_DRIVER_MAGIC;
 	rs285_driver.driver_name = "serial_21285";
-	rs285_driver.name = SERIAL_21285_NAME;
+	rs285_driver.name = SERIAL_21285_NAME "%d";
 	rs285_driver.major = SERIAL_21285_MAJOR;
 	rs285_driver.minor_start = SERIAL_21285_MINOR;
 	rs285_driver.num = 1;
--- linux-2.4.18-pre1/drivers/char/amiserial.c	Sun Sep 16 21:22:56 2001
+++ linux-akpm/drivers/char/amiserial.c	Sun Jan  6 12:54:20 2002
@@ -2129,7 +2129,7 @@ static int __init rs_init(void)
 	memset(&serial_driver, 0, sizeof(struct tty_driver));
 	serial_driver.magic = TTY_DRIVER_MAGIC;
 	serial_driver.driver_name = "amiserial";
-	serial_driver.name = "ttyS";
+	serial_driver.name = "ttyS%d";
 	serial_driver.major = TTY_MAJOR;
 	serial_driver.minor_start = 64;
 	serial_driver.num = 1;
--- linux-2.4.18-pre1/drivers/char/ser_a2232.c	Thu Sep 13 15:21:32 2001
+++ linux-akpm/drivers/char/ser_a2232.c	Sun Jan  6 12:54:27 2002
@@ -716,7 +716,7 @@ static int a2232_init_drivers(void)
 	memset(&a2232_driver, 0, sizeof(a2232_driver));
 	a2232_driver.magic = TTY_DRIVER_MAGIC;
 	a2232_driver.driver_name = "commodore_a2232";
-	a2232_driver.name = "ttyY";
+	a2232_driver.name = "ttyY%d";
 	a2232_driver.major = A2232_NORMAL_MAJOR;
 	a2232_driver.num = NUMLINES * nr_a2232;
 	a2232_driver.type = TTY_DRIVER_TYPE_SERIAL;
--- linux-2.4.18-pre1/drivers/char/serial_tx3912.c	Thu Nov 22 23:02:57 2001
+++ linux-akpm/drivers/char/serial_tx3912.c	Sun Jan  6 12:54:35 2002
@@ -841,7 +841,7 @@ static int rs_init_drivers(void)
 	memset(&rs_driver, 0, sizeof(rs_driver));
 	rs_driver.magic = TTY_DRIVER_MAGIC;
 	rs_driver.driver_name = "serial";
-	rs_driver.name = "ttyS";
+	rs_driver.name = "ttyS%d";
 	rs_driver.major = TTY_MAJOR;
 	rs_driver.minor_start = 64;
 	rs_driver.num = TX3912_UART_NPORTS;
--- linux-2.4.18-pre1/drivers/isdn/isdn_tty.c	Fri Dec 21 11:19:13 2001
+++ linux-akpm/drivers/isdn/isdn_tty.c	Sun Jan  6 12:54:52 2002
@@ -44,7 +44,7 @@ static int isdn_tty_countDLE(unsigned ch
 static char *isdn_ttyname_ttyI = "isdn/ttyI%d";
 static char *isdn_ttyname_cui = "isdn/cui%d";
 #else
-static char *isdn_ttyname_ttyI = "ttyI";
+static char *isdn_ttyname_ttyI = "ttyI%d";
 static char *isdn_ttyname_cui = "cui";
 #endif
 
--- linux-2.4.18-pre1/drivers/sbus/char/zs.c	Mon Nov  5 21:01:11 2001
+++ linux-akpm/drivers/sbus/char/zs.c	Sun Jan  6 12:55:13 2002
@@ -2412,7 +2412,7 @@ int __init zs_init(void)
 #ifdef CONFIG_DEVFS_FS
 	serial_driver.name = "tts/%d";
 #else
-	serial_driver.name = "ttyS";
+	serial_driver.name = "ttyS%d";
 #endif
 	serial_driver.major = TTY_MAJOR;
 	serial_driver.minor_start = 64;
--- linux-2.4.18-pre1/drivers/sbus/char/sab82532.c	Wed Oct 17 14:16:39 2001
+++ linux-akpm/drivers/sbus/char/sab82532.c	Sun Jan  6 12:55:22 2002
@@ -2240,7 +2240,7 @@ int __init sab82532_init(void)
 #ifdef CONFIG_DEVFS_FS
 	serial_driver.name = "tts/%d";
 #else
-	serial_driver.name = "ttyS";
+	serial_driver.name = "ttyS%d";
 #endif
 	serial_driver.major = TTY_MAJOR;
 	serial_driver.minor_start = 64 + su_num_ports;
--- linux-2.4.18-pre1/drivers/sbus/char/su.c	Thu Nov 22 23:02:58 2001
+++ linux-akpm/drivers/sbus/char/su.c	Sun Jan  6 12:55:31 2002
@@ -2491,7 +2491,7 @@ int __init su_serial_init(void)
 #ifdef CONFIG_DEVFS_FS
 	serial_driver.name = "tts/%d";
 #else
-	serial_driver.name = "ttyS";
+	serial_driver.name = "ttyS%d";
 #endif
 	serial_driver.major = TTY_MAJOR;
 	serial_driver.minor_start = 64;
--- linux-2.4.18-pre1/drivers/sbus/char/aurora.c	Mon Nov  5 21:01:11 2001
+++ linux-akpm/drivers/sbus/char/aurora.c	Sun Jan  6 12:55:38 2002
@@ -2313,7 +2313,7 @@ static int aurora_init_drivers(void)
 /*	memset(IRQ_to_board, 0, sizeof(IRQ_to_board));*/
 	memset(&aurora_driver, 0, sizeof(aurora_driver));
 	aurora_driver.magic = TTY_DRIVER_MAGIC;
-	aurora_driver.name = "ttyA";
+	aurora_driver.name = "ttyA%d";
 	aurora_driver.major = AURORA_MAJOR;
 	aurora_driver.num = AURORA_TNPORTS;
 	aurora_driver.type = TTY_DRIVER_TYPE_SERIAL;
--- linux-2.4.18-pre1/drivers/macintosh/macserial.c	Wed Dec 26 11:47:40 2001
+++ linux-akpm/drivers/macintosh/macserial.c	Sun Jan  6 12:55:43 2002
@@ -2623,7 +2623,7 @@ no_dma:		
 #ifdef CONFIG_DEVFS_FS
 	callout_driver.name = "cua/%d";
 #else
-	callout_driver.name = "cua";
+	callout_driver.name = "cua%d";
 #endif /* CONFIG_DEVFS_FS */
 	callout_driver.major = TTYAUX_MAJOR;
 	callout_driver.subtype = SERIAL_TYPE_CALLOUT;
--- linux-2.4.18-pre1/drivers/sgi/char/sgiserial.c	Mon Aug 27 08:56:31 2001
+++ linux-akpm/drivers/sgi/char/sgiserial.c	Sun Jan  6 12:55:52 2002
@@ -1911,7 +1911,7 @@ int rs_init(void)
 	 * major number and the subtype code.
 	 */
 	callout_driver = serial_driver;
-	callout_driver.name = "cua";
+	callout_driver.name = "cua%d";
 	callout_driver.major = TTYAUX_MAJOR;
 	callout_driver.subtype = SERIAL_TYPE_CALLOUT;
 
--- linux-2.4.18-pre1/drivers/tc/zs.c	Mon Aug 27 08:56:31 2001
+++ linux-akpm/drivers/tc/zs.c	Sun Jan  6 12:56:12 2002
@@ -1877,7 +1877,7 @@ int __init zs_init(void)
 #if (LINUX_VERSION_CODE > 0x2032D && defined(CONFIG_DEVFS_FS))
 	serial_driver.name = "tts/%d";
 #else
-	serial_driver.name = "ttyS";
+	serial_driver.name = "ttyS%d";
 #endif
 	serial_driver.major = TTY_MAJOR;
 	serial_driver.minor_start = 64;
--- linux-2.4.18-pre1/drivers/s390/char/con3215.c	Wed Jul 25 14:12:02 2001
+++ linux-akpm/drivers/s390/char/con3215.c	Sun Jan  6 12:56:20 2002
@@ -1129,7 +1129,7 @@ void __init tty3215_init(void)
 	memset(&tty3215_driver, 0, sizeof(struct tty_driver));
 	tty3215_driver.magic = TTY_DRIVER_MAGIC;
 	tty3215_driver.driver_name = "tty3215";
-	tty3215_driver.name = "ttyS";
+	tty3215_driver.name = "ttyS%d";
 	tty3215_driver.name_base = 0;
 	tty3215_driver.major = TTY_MAJOR;
 	tty3215_driver.minor_start = 64;
--- linux-2.4.18-pre1/drivers/s390/char/hwc_tty.c	Wed Jul 25 14:12:02 2001
+++ linux-akpm/drivers/s390/char/hwc_tty.c	Sun Jan  6 12:56:29 2002
@@ -227,7 +227,7 @@ hwc_tty_init (void)
 	memset (&hwc_tty_data, 0, sizeof (hwc_tty_data_struct));
 	hwc_tty_driver.magic = TTY_DRIVER_MAGIC;
 	hwc_tty_driver.driver_name = "tty_hwc";
-	hwc_tty_driver.name = "ttyS";
+	hwc_tty_driver.name = "ttyS%d";
 	hwc_tty_driver.name_base = 0;
 	hwc_tty_driver.major = TTY_MAJOR;
 	hwc_tty_driver.minor_start = 64;
--- linux-2.4.18-pre1/drivers/s390/net/ctctty.c	Wed Jul 25 14:12:02 2001
+++ linux-akpm/drivers/s390/net/ctctty.c	Sun Jan  6 12:57:15 2002
@@ -111,7 +111,7 @@ static ctc_tty_driver *driver;
 #ifdef CONFIG_DEVFS_FS
 static char *ctc_ttyname = "ctc/" CTC_TTY_NAME "%d";
 #else
-static char *ctc_ttyname = CTC_TTY_NAME;
+static char *ctc_ttyname = CTC_TTY_NAME "%d";
 #endif
 
 char *ctc_tty_revision = "$Revision: 1.1.2.1 $";
--- linux-2.4.18-pre1/arch/mips/baget/vacserial.c	Sun Sep  9 10:43:01 2001
+++ linux-akpm/arch/mips/baget/vacserial.c	Sun Jan  6 12:57:26 2002
@@ -2359,7 +2359,7 @@ int __init rs_init(void)
 	memset(&serial_driver, 0, sizeof(struct tty_driver));
 	serial_driver.magic = TTY_DRIVER_MAGIC;
 	serial_driver.driver_name = "serial";
-	serial_driver.name = "ttyS";
+	serial_driver.name = "ttyS%d";
 	serial_driver.major = TTY_MAJOR;
 	serial_driver.minor_start = 64;
 	serial_driver.num = NR_PORTS;
--- linux-2.4.18-pre1/arch/mips/au1000/common/serial.c	Fri Oct  5 12:06:51 2001
+++ linux-akpm/arch/mips/au1000/common/serial.c	Sun Jan  6 12:57:34 2002
@@ -2635,7 +2635,7 @@ static int __init rs_init(void)
 #if (LINUX_VERSION_CODE > 0x2032D && defined(CONFIG_DEVFS_FS))
 	callout_driver.name = "cua/%d";
 #else
-	callout_driver.name = "cua";
+	callout_driver.name = "cua%d";
 #endif
 	callout_driver.major = TTYAUX_MAJOR;
 	callout_driver.subtype = SERIAL_TYPE_CALLOUT;
--- linux-2.4.18-pre1/arch/ppc/8xx_io/uart.c	Wed Dec 26 11:47:40 2001
+++ linux-akpm/arch/ppc/8xx_io/uart.c	Sun Jan  6 12:57:42 2002
@@ -2532,7 +2532,7 @@ int __init rs_8xx_init(void)
 #ifdef CONFIG_DEVFS_FS
 	serial_driver.name = "tts/%d";
 #else
-	serial_driver.name = "ttyS";
+	serial_driver.name = "ttyS%d";
 #endif
 	serial_driver.major = TTY_MAJOR;
 	serial_driver.minor_start = 64;
--- linux-2.4.18-pre1/arch/ppc/8260_io/uart.c	Wed Dec 26 11:47:40 2001
+++ linux-akpm/arch/ppc/8260_io/uart.c	Sun Jan  6 12:57:52 2002
@@ -2328,7 +2328,7 @@ int __init rs_8xx_init(void)
 #ifdef CONFIG_DEVFS_FS
 	serial_driver.name = "tts/%d";
 #else
-	serial_driver.name = "ttyS";
+	serial_driver.name = "ttyS%d";
 #endif
 	serial_driver.major = TTY_MAJOR;
 	serial_driver.minor_start = 64;
--- linux-2.4.18-pre1/arch/cris/drivers/serial.c	Thu Nov 22 23:02:57 2001
+++ linux-akpm/arch/cris/drivers/serial.c	Sun Jan  6 12:58:03 2002
@@ -3461,7 +3461,7 @@ rs_init(void)
 #if (LINUX_VERSION_CODE > 0x20100)
 	serial_driver.driver_name = "serial";
 #endif
-	serial_driver.name = "ttyS";
+	serial_driver.name = "ttyS%d";
 	serial_driver.major = TTY_MAJOR;
 	serial_driver.minor_start = 64;
 	serial_driver.num = NR_PORTS;       /* etrax100 has 4 serial ports */
