Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282229AbRLEGmX>; Wed, 5 Dec 2001 01:42:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282927AbRLEGmG>; Wed, 5 Dec 2001 01:42:06 -0500
Received: from leeloo.zip.com.au ([203.12.97.48]:35856 "EHLO
	mangalore.zipworld.com.au") by vger.kernel.org with ESMTP
	id <S282229AbRLEGmC>; Wed, 5 Dec 2001 01:42:02 -0500
Message-ID: <3C0DC1AA.E653D425@zip.com.au>
Date: Tue, 04 Dec 2001 22:41:46 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.17-pre1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Josh McKinney <forming@home.com>, linux-kernel@vger.kernel.org,
        Jeff Garzik <jgarzik@mandrakesoft.com>
Subject: Re: Fwd: binutils in debian unstable is broken.
In-Reply-To: <20011205050513.GD1442@cy599856-a.home.com> <3C0DB3D6.9C86B865@zip.com.au>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> 
> 3) Something else.  HJ's #ifdef MODULE works OK.  It has a rather
>    internecine relationship with the workings of __devexit though.

OK, here's a piece of speed-editing.  Fixed a few other __devexit
bugs on the way as well.

I didn't touch ISDN - the __devexit handling there is a bit complex,
and it needs a maintainer to go through it with the latest binutils.
They need to test with CONFIG_HOTPLUG on and off, modular and static.

All the rest of the kernel is done.  Could someone who has the
new binutils installed please test?

For older kernels the easiest fix is to edit your platform's
vmlinux.lds and just delete the /DISCARD/ section.



--- linux-2.4.17-pre2/include/linux/init.h	Tue Oct 23 21:59:05 2001
+++ linux-akpm/include/linux/init.h	Tue Dec  4 22:40:55 2001
@@ -111,7 +111,7 @@ extern struct kernel_param __setup_start
  */
 #define module_exit(x)	__exitcall(x);
 
-#else
+#else	/* MODULE */
 
 #define __init
 #define __exit
@@ -141,7 +141,7 @@ typedef void (*__cleanup_module_func_t)(
 
 #define __setup(str,func) /* nothing */
 
-#endif
+#endif	/* MODULE */
 
 #ifdef CONFIG_HOTPLUG
 #define __devinit
@@ -153,6 +153,16 @@ typedef void (*__cleanup_module_func_t)(
 #define __devinitdata __initdata
 #define __devexit __exit
 #define __devexitdata __exitdata
+#endif
+
+/*
+ * DEVEXIT_LINKED is defined if sections marked __devexit will appear
+ * in the final kernel image.  If DEVEXIT_LINKED is not defined, the
+ * linker may end up removing __devexit sections, and so other sections
+ * are not allowed to refer to __devexit symbols.
+ */
+#if defined(MODULE) || defined(CONFIG_HOTPLUG)
+#define DEVEXIT_LINKED
 #endif
 
 #endif /* _LINUX_INIT_H */
--- linux-2.4.17-pre2/drivers/atm/eni.c	Thu Nov 22 23:02:57 2001
+++ linux-akpm/drivers/atm/eni.c	Tue Dec  4 22:13:52 2001
@@ -2310,7 +2310,9 @@ static struct pci_driver eni_driver = {
 	name:		DEV_LABEL,
 	id_table:	eni_pci_tbl,
 	probe:		eni_init_one,
+#ifdef DEVEXIT_LINKED
 	remove:		eni_remove_one,
+#endif
 };
 
 
--- linux-2.4.17-pre2/drivers/atm/firestream.c	Thu Nov 22 23:02:57 2001
+++ linux-akpm/drivers/atm/firestream.c	Tue Dec  4 22:14:04 2001
@@ -2102,7 +2102,9 @@ static struct pci_driver firestream_driv
 	name:           "firestream",
 	id_table:       firestream_pci_tbl,
 	probe:          firestream_init_one,
-	remove:         firestream_remove_one,
+#ifdef DEVEXIT_LINKED
+	remove:		firestream_remove_one,
+#endif
 };
 
 static int __init firestream_init_module (void)
--- linux-2.4.17-pre2/drivers/block/cciss.c	Thu Nov 22 23:02:57 2001
+++ linux-akpm/drivers/block/cciss.c	Tue Dec  4 22:14:14 2001
@@ -2019,7 +2019,9 @@ static void __devexit cciss_remove_one (
 static struct pci_driver cciss_pci_driver = {
 	 name:   "cciss",
 	probe:  cciss_init_one,
-	remove:  cciss_remove_one,
+#ifdef DEVEXIT_LINKED
+	remove:	cciss_remove_one,
+#endif
 	id_table:  cciss_pci_device_id, /* id_table */
 };
 
@@ -2046,7 +2048,7 @@ static int __init init_cciss_module(void
 	return ( cciss_init());
 }
 
-static void __exit cleanup_cciss_module(void)
+static void __devexit cleanup_cciss_module(void)
 {
 	int i;
 
--- linux-2.4.17-pre2/drivers/char/joystick/cs461x.c	Thu Nov 22 23:02:57 2001
+++ linux-akpm/drivers/char/joystick/cs461x.c	Tue Dec  4 22:14:23 2001
@@ -313,7 +313,9 @@ static struct pci_driver cs461x_pci_driv
         name:           "PCI Gameport",
         id_table:       cs461x_pci_tbl,
         probe:          cs461x_pci_probe,
-        remove:         cs461x_pci_remove,
+#ifdef DEVEXIT_LINKED
+	remove: cs461x_pci_remove,
+#endif
 };
 
 int __init js_cs461x_init(void)
--- linux-2.4.17-pre2/drivers/char/joystick/emu10k1-gp.c	Thu Nov 22 23:02:57 2001
+++ linux-akpm/drivers/char/joystick/emu10k1-gp.c	Tue Dec  4 22:14:33 2001
@@ -108,7 +108,9 @@ static struct pci_driver emu_driver = {
         name:           "Emu10k1 Gameport",
         id_table:       emu_tbl,
         probe:          emu_probe,
-        remove:         emu_remove,
+#ifdef DEVEXIT_LINKED
+	remove:		emu_remove,
+#endif
 };
 
 int __init emu_init(void)
--- linux-2.4.17-pre2/drivers/char/joystick/pcigame.c	Thu Nov 22 23:02:57 2001
+++ linux-akpm/drivers/char/joystick/pcigame.c	Tue Dec  4 22:14:42 2001
@@ -180,7 +180,9 @@ static struct pci_driver pcigame_driver 
 	name:		"pcigame",
 	id_table:	pcigame_id_table,
 	probe:		pcigame_probe,
+#ifdef DEVEXIT_LINKED
 	remove:		pcigame_remove,
+#endif
 };
 
 int __init pcigame_init(void)
--- linux-2.4.17-pre2/drivers/char/serial.c	Fri Nov 30 14:32:14 2001
+++ linux-akpm/drivers/char/serial.c	Tue Dec  4 22:14:51 2001
@@ -4892,7 +4892,9 @@ MODULE_DEVICE_TABLE(pci, serial_pci_tbl)
 static struct pci_driver serial_pci_driver = {
        name:           "serial",
        probe:          serial_init_one,
-       remove:	       serial_remove_one,
+#ifdef DEVEXIT_LINKED
+	remove:		serial_remove_one,
+#endif
        id_table:       serial_pci_tbl,
 };
 
--- linux-2.4.17-pre2/drivers/char/sonypi.c	Mon Oct 15 08:38:31 2001
+++ linux-akpm/drivers/char/sonypi.c	Tue Dec  4 22:08:44 2001
@@ -685,7 +685,7 @@ static int __init sonypi_init_module(voi
 		return -ENODEV;
 }
 
-static void __exit sonypi_cleanup_module(void) {
+static void __devexit sonypi_cleanup_module(void) {
 	sonypi_remove();
 }
 
--- linux-2.4.17-pre2/drivers/ieee1394/ohci1394.c	Fri Nov 30 14:32:14 2001
+++ linux-akpm/drivers/ieee1394/ohci1394.c	Tue Dec  4 22:15:07 2001
@@ -2374,7 +2374,9 @@ static struct pci_driver ohci1394_driver
 	name:		OHCI1394_DRIVER_NAME,
 	id_table:	ohci1394_pci_tbl,
 	probe:		ohci1394_add_one,
+#ifdef DEVEXIT_LINKED
 	remove:		ohci1394_remove_one,
+#endif
 };
 
 static void __exit ohci1394_cleanup (void)
--- linux-2.4.17-pre2/drivers/media/radio/radio-gemtek-pci.c	Sun Sep 30 12:26:06 2001
+++ linux-akpm/drivers/media/radio/radio-gemtek-pci.c	Tue Dec  4 22:15:37 2001
@@ -421,10 +421,12 @@ static void __devexit gemtek_pci_remove(
 
 static struct pci_driver gemtek_pci_driver =
 {
-    name:	"gemtek_pci",
-id_table:	gemtek_pci_id,
-   probe:	gemtek_pci_probe,
-  remove:	gemtek_pci_remove
+	name:		"gemtek_pci",
+	id_table:	gemtek_pci_id,
+	probe:		gemtek_pci_probe,
+#ifdef DEVEXIT_LINKED
+	remove:		gemtek_pci_remove,
+#endif
 };
 
 static int __init gemtek_pci_init_module( void )
--- linux-2.4.17-pre2/drivers/media/radio/radio-maxiradio.c	Sun Sep 30 12:26:06 2001
+++ linux-akpm/drivers/media/radio/radio-maxiradio.c	Tue Dec  4 22:15:50 2001
@@ -376,7 +376,9 @@ static struct pci_driver maxiradio_drive
 	name:		"radio-maxiradio",
 	id_table:	maxiradio_pci_tbl,
 	probe:		maxiradio_init_one,
+#ifdef DEVEXIT_LINKED
 	remove:		maxiradio_remove_one,
+#endif
 };
 
 int __init maxiradio_radio_init(void)
--- linux-2.4.17-pre2/drivers/media/video/bttv-driver.c	Wed Oct 17 14:19:20 2001
+++ linux-akpm/drivers/media/video/bttv-driver.c	Tue Dec  4 22:08:44 2001
@@ -2820,7 +2820,7 @@ static void bttv_irq(int irq, void *dev_
  *	Scan for a Bt848 card, request the irq and map the io memory 
  */
 
-static void __devexit bttv_remove(struct pci_dev *pci_dev)
+static void bttv_remove(struct pci_dev *pci_dev)
 {
         u8 command;
         int j;
--- linux-2.4.17-pre2/drivers/media/video/meye.c	Mon Nov  5 21:01:11 2001
+++ linux-akpm/drivers/media/video/meye.c	Tue Dec  4 22:16:04 2001
@@ -1460,7 +1460,9 @@ static struct pci_driver meye_driver = {
 	name:		"meye",
 	id_table:	meye_pci_tbl,
 	probe:		meye_probe,
+#ifdef DEVEXIT_LINKED
 	remove:		meye_remove,
+#endif
 };
 
 static int __init meye_init_module(void) {
--- linux-2.4.17-pre2/drivers/net/3c59x.c	Thu Nov 22 23:02:57 2001
+++ linux-akpm/drivers/net/3c59x.c	Tue Dec  4 22:16:15 2001
@@ -2919,7 +2919,9 @@ static void __devexit vortex_remove_one 
 static struct pci_driver vortex_driver = {
 	name:		"3c59x",
 	probe:		vortex_init_one,
+#ifdef DEVEXIT_LINKED
 	remove:		vortex_remove_one,
+#endif
 	id_table:	vortex_pci_tbl,
 #ifdef CONFIG_PM
 	suspend:	vortex_suspend,
--- linux-2.4.17-pre2/drivers/net/8139cp.c	Thu Nov 22 23:02:57 2001
+++ linux-akpm/drivers/net/8139cp.c	Tue Dec  4 22:16:25 2001
@@ -1313,7 +1313,9 @@ static struct pci_driver cp_driver = {
 	name:		DRV_NAME,
 	id_table:	cp_pci_tbl,
 	probe:		cp_init_one,
+#ifdef DEVEXIT_LINKED
 	remove:		cp_remove_one,
+#endif
 };
 
 static int __init cp_init (void)
--- linux-2.4.17-pre2/drivers/net/8139too.c	Mon Nov 26 11:52:07 2001
+++ linux-akpm/drivers/net/8139too.c	Tue Dec  4 22:16:35 2001
@@ -2493,7 +2493,9 @@ static struct pci_driver rtl8139_pci_dri
 	name:		DRV_NAME,
 	id_table:	rtl8139_pci_tbl,
 	probe:		rtl8139_init_one,
+#ifdef DEVEXIT_LINKED
 	remove:		rtl8139_remove_one,
+#endif
 #ifdef CONFIG_PM
 	suspend:	rtl8139_suspend,
 	resume:		rtl8139_resume,
--- linux-2.4.17-pre2/drivers/net/arcnet/com20020.c	Mon Nov  5 21:01:11 2001
+++ linux-akpm/drivers/net/arcnet/com20020.c	Tue Dec  4 22:08:44 2001
@@ -341,7 +341,7 @@ static void com20020_set_mc_list(struct 
 	}
 }
 
-void __devexit com20020_remove(struct net_device *dev)
+void com20020_remove(struct net_device *dev)
 {
 	unregister_netdev(dev);
 	free_irq(dev->irq, dev);
--- linux-2.4.17-pre2/drivers/net/arcnet/com20020-pci.c	Thu Nov 22 23:02:57 2001
+++ linux-akpm/drivers/net/arcnet/com20020-pci.c	Tue Dec  4 22:16:50 2001
@@ -160,7 +160,9 @@ static struct pci_driver com20020pci_dri
 	name:		"com20020",
 	id_table:	com20020pci_id_table,
 	probe:		com20020pci_probe,
-	remove:		com20020pci_remove
+#ifdef DEVEXIT_LINKED
+	remove:		com20020pci_remove,
+#endif
 };
 
 static int __init com20020pci_init(void)
--- linux-2.4.17-pre2/drivers/net/defxx.c	Sun Sep 30 12:26:06 2001
+++ linux-akpm/drivers/net/defxx.c	Tue Dec  4 22:08:44 2001
@@ -3333,7 +3333,7 @@ static void dfx_xmt_flush( DFX_board_t *
 	bp->cons_block_virt->xmt_rcv_data = prod_cons;
 	}
 
-static void __devexit dfx_remove_one_pci_or_eisa(struct pci_dev *pdev, struct net_device *dev)
+static void dfx_remove_one_pci_or_eisa(struct pci_dev *pdev, struct net_device *dev)
 {
 	DFX_board_t	  *bp = dev->priv;
 
@@ -3343,7 +3343,7 @@ static void __devexit dfx_remove_one_pci
 	kfree(dev);
 }
 
-static void __devexit dfx_remove_one (struct pci_dev *pdev)
+static void dfx_remove_one (struct pci_dev *pdev)
 {
 	struct net_device *dev = pci_get_drvdata(pdev);
 
@@ -3368,7 +3368,7 @@ static int dfx_have_pci;
 static int dfx_have_eisa;
 
 
-static void __exit dfx_eisa_cleanup(void)
+static void dfx_eisa_cleanup(void)
 {
 	struct net_device *dev = root_dfx_eisa_dev;
 
@@ -3402,7 +3402,7 @@ static int __init dfx_init(void)
 	return ((rc_eisa < 0) ? 0 : rc_eisa)  + ((rc_pci < 0) ? 0 : rc_pci); 
 }
 
-static void __exit dfx_cleanup(void)
+static void dfx_cleanup(void)
 {
 	if (dfx_have_pci)
 		pci_unregister_driver(&dfx_driver);
--- linux-2.4.17-pre2/drivers/net/dl2k.c	Thu Nov 22 23:02:57 2001
+++ linux-akpm/drivers/net/dl2k.c	Tue Dec  4 22:17:03 2001
@@ -1671,7 +1671,9 @@ static struct pci_driver rio_driver = {
 	name:"dl2k",
 	id_table:rio_pci_tbl,
 	probe:rio_probe1,
+#ifdef DEVEXIT_LINKED
 	remove:rio_remove1,
+#endif
 };
 
 static int __init
--- linux-2.4.17-pre2/drivers/net/eepro100.c	Thu Nov 22 23:02:57 2001
+++ linux-akpm/drivers/net/eepro100.c	Tue Dec  4 22:17:17 2001
@@ -2281,7 +2281,9 @@ static struct pci_driver eepro100_driver
 	name:		"eepro100",
 	id_table:	eepro100_pci_tbl,
 	probe:		eepro100_init_one,
+#ifdef DEVEXIT_LINKED
 	remove:		eepro100_remove_one,
+#endif
 #ifdef CONFIG_PM
 	suspend:	eepro100_suspend,
 	resume:		eepro100_resume,
--- linux-2.4.17-pre2/drivers/net/epic100.c	Sun Sep 30 12:26:06 2001
+++ linux-akpm/drivers/net/epic100.c	Tue Dec  4 22:17:26 2001
@@ -1507,7 +1507,9 @@ static struct pci_driver epic_driver = {
 	name:		DRV_NAME,
 	id_table:	epic_pci_tbl,
 	probe:		epic_init_one,
+#ifdef DEVEXIT_LINKED
 	remove:		epic_remove_one,
+#endif
 #ifdef CONFIG_PM
 	suspend:	epic_suspend,
 	resume:		epic_resume,
--- linux-2.4.17-pre2/drivers/net/fealnx.c	Thu Nov 22 23:02:57 2001
+++ linux-akpm/drivers/net/fealnx.c	Tue Dec  4 22:17:34 2001
@@ -1858,7 +1858,9 @@ static struct pci_driver fealnx_driver =
 	name:		"fealnx",
 	id_table:	fealnx_pci_tbl,
 	probe:		fealnx_init_one,
-	remove:		fealnx_remove_one,
+#ifdef DEVEXIT_LINKED
+	remove: 	fealnx_remove_one,
+#endif
 };
 
 static int __init fealnx_init(void)
--- linux-2.4.17-pre2/drivers/net/ioc3-eth.c	Tue Oct 16 21:56:29 2001
+++ linux-akpm/drivers/net/ioc3-eth.c	Tue Dec  4 22:17:42 2001
@@ -1515,7 +1515,9 @@ static struct pci_driver ioc3_driver = {
 	name:		"ioc3-eth",
 	id_table:	ioc3_pci_tbl,
 	probe:		ioc3_probe,
+#ifdef DEVEXIT_LINKED
 	remove:		ioc3_remove_one,
+#endif
 };
 
 static int __init ioc3_init_module(void)
--- linux-2.4.17-pre2/drivers/net/irda/vlsi_ir.c	Fri Nov 30 14:32:14 2001
+++ linux-akpm/drivers/net/irda/vlsi_ir.c	Tue Dec  4 22:17:51 2001
@@ -1291,7 +1291,9 @@ static struct pci_driver vlsi_irda_drive
 	name:           drivername,
 	id_table:       vlsi_irda_table,
 	probe:          vlsi_irda_probe,
-	remove:         vlsi_irda_remove,
+#ifdef DEVEXIT_LINKED
+	remove:		vlsi_irda_remove,
+#endif
 	suspend:        vlsi_irda_suspend,
 	resume:         vlsi_irda_resume,
 };
--- linux-2.4.17-pre2/drivers/net/natsemi.c	Thu Nov 22 23:02:58 2001
+++ linux-akpm/drivers/net/natsemi.c	Tue Dec  4 22:18:01 2001
@@ -2518,7 +2518,9 @@ static struct pci_driver natsemi_driver 
 	name:		DRV_NAME,
 	id_table:	natsemi_pci_tbl,
 	probe:		natsemi_probe1,
+#ifdef DEVEXIT_LINKED
 	remove:		natsemi_remove1,
+#endif
 #ifdef CONFIG_PM
 	suspend:	natsemi_suspend,
 	resume:		natsemi_resume,
--- linux-2.4.17-pre2/drivers/net/ne2k-pci.c	Sun Sep 30 12:26:07 2001
+++ linux-akpm/drivers/net/ne2k-pci.c	Tue Dec  4 22:18:10 2001
@@ -642,7 +642,9 @@ static void __devexit ne2k_pci_remove_on
 static struct pci_driver ne2k_driver = {
 	name:		DRV_NAME,
 	probe:		ne2k_pci_init_one,
+#ifdef DEVEXIT_LINKED
 	remove:		ne2k_pci_remove_one,
+#endif
 	id_table:	ne2k_pci_tbl,
 };
 
--- linux-2.4.17-pre2/drivers/net/ns83820.c	Thu Nov 22 23:02:58 2001
+++ linux-akpm/drivers/net/ns83820.c	Tue Dec  4 22:18:18 2001
@@ -1455,7 +1455,9 @@ static struct pci_driver driver = {
 	name:		"ns83820",
 	id_table:	ns83820_pci_tbl,
 	probe:		ns83820_init_one,
+#ifdef DEVEXIT_LINKED
 	remove:		ns83820_remove_one,
+#endif
 #if 0	/* FIXME: implement */
 	suspend:	,
 	resume:		,
--- linux-2.4.17-pre2/drivers/net/pci-skeleton.c	Tue Oct 16 21:56:29 2001
+++ linux-akpm/drivers/net/pci-skeleton.c	Tue Dec  4 22:18:26 2001
@@ -1980,7 +1980,9 @@ static struct pci_driver netdrv_pci_driv
 	name:		MODNAME,
 	id_table:	netdrv_pci_tbl,
 	probe:		netdrv_init_one,
+#ifdef DEVEXIT_LINKED
 	remove:		netdrv_remove_one,
+#endif
 #ifdef CONFIG_PM
 	suspend:	netdrv_suspend,
 	resume:		netdrv_resume,
--- linux-2.4.17-pre2/drivers/net/pcmcia/xircom_cb.c	Thu Nov 22 23:02:58 2001
+++ linux-akpm/drivers/net/pcmcia/xircom_cb.c	Tue Dec  4 22:18:41 2001
@@ -170,7 +170,9 @@ static struct pci_driver xircom_ops = {
 	name:		"xircom_cb", 
 	id_table:	xircom_pci_table, 
 	probe:		xircom_probe, 
-	remove:		xircom_remove, 
+#ifdef DEVEXIT_LINKED
+	remove:		xircom_remove,
+#endif
 };
 
 
--- linux-2.4.17-pre2/drivers/net/pcmcia/xircom_tulip_cb.c	Thu Nov 22 23:02:58 2001
+++ linux-akpm/drivers/net/pcmcia/xircom_tulip_cb.c	Tue Dec  4 22:18:48 2001
@@ -1748,7 +1748,9 @@ static struct pci_driver xircom_driver =
 	name:		DRV_NAME,
 	id_table:	xircom_pci_table,
 	probe:		xircom_init_one,
+#ifdef DEVEXIT_LINKED
 	remove:		xircom_remove_one,
+#endif
 #ifdef CONFIG_PM
 	suspend:	xircom_suspend,
 	resume:		xircom_resume
--- linux-2.4.17-pre2/drivers/net/sis900.c	Tue Oct  9 15:13:03 2001
+++ linux-akpm/drivers/net/sis900.c	Tue Dec  4 22:18:57 2001
@@ -2098,7 +2098,9 @@ static struct pci_driver sis900_pci_driv
 	name:		SIS900_MODULE_NAME,
 	id_table:	sis900_pci_tbl,
 	probe:		sis900_probe,
+#ifdef DEVEXIT_LINKED
 	remove:		sis900_remove,
+#endif
 };
 
 static int __init sis900_init_module(void)
--- linux-2.4.17-pre2/drivers/net/starfire.c	Sun Sep 30 12:26:07 2001
+++ linux-akpm/drivers/net/starfire.c	Tue Dec  4 22:19:05 2001
@@ -1963,7 +1963,9 @@ static void __devexit starfire_remove_on
 static struct pci_driver starfire_driver = {
 	name:		DRV_NAME,
 	probe:		starfire_init_one,
+#ifdef DEVEXIT_LINKED
 	remove:		starfire_remove_one,
+#endif
 	id_table:	starfire_pci_tbl,
 };
 
--- linux-2.4.17-pre2/drivers/net/sundance.c	Fri Oct 19 08:32:28 2001
+++ linux-akpm/drivers/net/sundance.c	Tue Dec  4 22:19:13 2001
@@ -1474,7 +1474,9 @@ static struct pci_driver sundance_driver
 	name:		DRV_NAME,
 	id_table:	sundance_pci_tbl,
 	probe:		sundance_probe1,
+#ifdef DEVEXIT_LINKED
 	remove:		sundance_remove1,
+#endif
 };
 
 static int __init sundance_init(void)
--- linux-2.4.17-pre2/drivers/net/sungem.c	Sun Oct 21 10:36:54 2001
+++ linux-akpm/drivers/net/sungem.c	Tue Dec  4 22:19:21 2001
@@ -2140,7 +2140,9 @@ static struct pci_driver gem_driver = {
 	name:		GEM_MODULE_NAME,
 	id_table:	gem_pci_tbl,
 	probe:		gem_init_one,
+#ifdef DEVEXIT_LINKED
 	remove:		gem_remove_one,
+#endif
 };
 
 static int __init gem_init(void)
--- linux-2.4.17-pre2/drivers/net/tlan.c	Sun Sep 30 12:26:08 2001
+++ linux-akpm/drivers/net/tlan.c	Tue Dec  4 22:19:34 2001
@@ -430,7 +430,9 @@ static struct pci_driver tlan_driver = {
 	name:		"tlan",
 	id_table:	tlan_pci_tbl,
 	probe:		tlan_init_one,
-	remove:		tlan_remove_one,	
+#ifdef DEVEXIT_LINKED
+	remove:		tlan_remove_one,
+#endif
 };
 
 static int __init tlan_probe(void)
--- linux-2.4.17-pre2/drivers/net/tokenring/lanstreamer.c	Thu Nov 22 23:02:58 2001
+++ linux-akpm/drivers/net/tokenring/lanstreamer.c	Tue Dec  4 22:19:44 2001
@@ -1812,7 +1812,9 @@ static struct pci_driver streamer_pci_dr
   name:       "lanstreamer",
   id_table:   streamer_pci_tbl,
   probe:      streamer_init_one,
+#ifdef DEVEXIT_LINKED
   remove:     streamer_remove_one,
+#endif
 };
 
 static int __init streamer_init_module(void) {
--- linux-2.4.17-pre2/drivers/net/tokenring/olympic.c	Thu Nov 22 23:02:58 2001
+++ linux-akpm/drivers/net/tokenring/olympic.c	Tue Dec  4 22:19:53 2001
@@ -1705,7 +1705,9 @@ static struct pci_driver olympic_driver 
 	name:		"olympic",
 	id_table:	olympic_pci_tbl,
 	probe:		olympic_probe,
-	remove:		olympic_remove_one
+#ifdef DEVEXIT_LINKED
+    remove: olympic_remove_one,
+#endif
 };
 
 static int __init olympic_pci_init(void) 
--- linux-2.4.17-pre2/drivers/net/tulip/tulip_core.c	Thu Nov 22 23:02:58 2001
+++ linux-akpm/drivers/net/tulip/tulip_core.c	Tue Dec  4 22:20:02 2001
@@ -1889,7 +1889,9 @@ static struct pci_driver tulip_driver = 
 	name:		DRV_NAME,
 	id_table:	tulip_pci_tbl,
 	probe:		tulip_init_one,
+#ifdef DEVEXIT_LINKED
 	remove:		tulip_remove_one,
+#endif
 #ifdef CONFIG_PM
 	suspend:	tulip_suspend,
 	resume:		tulip_resume,
--- linux-2.4.17-pre2/drivers/net/via-rhine.c	Thu Nov 22 23:02:58 2001
+++ linux-akpm/drivers/net/via-rhine.c	Tue Dec  4 22:20:10 2001
@@ -1667,7 +1667,9 @@ static struct pci_driver via_rhine_drive
 	name:		"via-rhine",
 	id_table:	via_rhine_pci_tbl,
 	probe:		via_rhine_init_one,
+#ifdef DEVEXIT_LINKED
 	remove:		via_rhine_remove_one,
+#endif
 };
 
 
--- linux-2.4.17-pre2/drivers/net/wan/farsync.c	Thu Nov 22 23:02:58 2001
+++ linux-akpm/drivers/net/wan/farsync.c	Tue Dec  4 22:20:19 2001
@@ -1810,7 +1810,9 @@ static struct pci_driver fst_driver = {
         name:           FST_NAME,
         id_table:       fst_pci_dev_id,
         probe:          fst_add_one,
-        remove:         fst_remove_one,
+#ifdef DEVEXIT_LINKED
+	remove:		fst_remove_one,
+#endif
         suspend:        NULL,
         resume:         NULL,
 };
--- linux-2.4.17-pre2/drivers/net/winbond-840.c	Tue Oct  9 15:13:02 2001
+++ linux-akpm/drivers/net/winbond-840.c	Tue Dec  4 22:20:27 2001
@@ -1697,7 +1697,9 @@ static struct pci_driver w840_driver = {
 	name:		DRV_NAME,
 	id_table:	w840_pci_tbl,
 	probe:		w840_probe1,
+#ifdef DEVEXIT_LINKED
 	remove:		w840_remove1,
+#endif
 #ifdef CONFIG_PM
 	suspend:	w840_suspend,
 	resume:		w840_resume,
--- linux-2.4.17-pre2/drivers/net/wireless/airo.c	Thu Nov 22 23:02:58 2001
+++ linux-akpm/drivers/net/wireless/airo.c	Tue Dec  4 22:20:37 2001
@@ -64,7 +64,9 @@ static struct pci_driver airo_driver = {
 	name:     "airo",
 	id_table: card_ids,
 	probe:    airo_pci_probe,
-	remove:   airo_pci_remove,
+#ifdef DEVEXIT_LINKED
+	remove:	airo_pci_remove,
+#endif
 };
 #endif /* CONFIG_PCI */
 
--- linux-2.4.17-pre2/drivers/net/wireless/orinoco_plx.c	Tue Oct  9 15:13:03 2001
+++ linux-akpm/drivers/net/wireless/orinoco_plx.c	Tue Dec  4 22:20:53 2001
@@ -279,9 +279,9 @@ static struct pci_driver orinoco_plx_dri
 	name:"orinoco_plx",
 	id_table:orinoco_plx_pci_id_table,
 	probe:orinoco_plx_init_one,
+#ifdef DEVEXIT_LINKED
 	remove:orinoco_plx_remove_one,
-	suspend:0,
-	resume:0
+#endif
 };
 
 static int __init orinoco_plx_init(void)
--- linux-2.4.17-pre2/drivers/net/yellowfin.c	Fri Oct 19 08:32:28 2001
+++ linux-akpm/drivers/net/yellowfin.c	Tue Dec  4 22:21:02 2001
@@ -1506,7 +1506,9 @@ static struct pci_driver yellowfin_drive
 	name:		DRV_NAME,
 	id_table:	yellowfin_pci_tbl,
 	probe:		yellowfin_init_one,
+#ifdef DEVEXIT_LINKED
 	remove:		yellowfin_remove_one,
+#endif
 };
 
 
--- linux-2.4.17-pre2/drivers/parport/parport_serial.c	Thu Nov 22 23:02:58 2001
+++ linux-akpm/drivers/parport/parport_serial.c	Tue Dec  4 22:21:09 2001
@@ -331,7 +331,9 @@ static struct pci_driver parport_serial_
 	name:		"parport_serial",
 	id_table:	parport_serial_pci_tbl,
 	probe:		parport_serial_pci_probe,
+#ifdef DEVEXIT_LINKED
 	remove:		parport_serial_pci_remove,
+#endif
 };
 
 
--- linux-2.4.17-pre2/drivers/pcmcia/pci_socket.c	Thu Nov 22 23:02:58 2001
+++ linux-akpm/drivers/pcmcia/pci_socket.c	Tue Dec  4 22:21:17 2001
@@ -249,7 +249,9 @@ static struct pci_driver pci_cardbus_dri
 	name:		"cardbus",
 	id_table:	cardbus_table,
 	probe:		cardbus_probe,
+#ifdef DEVEXIT_LINKED
 	remove:		cardbus_remove,
+#endif
 	suspend:	cardbus_suspend,
 	resume:		cardbus_resume,
 };
--- linux-2.4.17-pre2/drivers/sound/btaudio.c	Wed Oct 17 14:19:20 2001
+++ linux-akpm/drivers/sound/btaudio.c	Tue Dec  4 22:21:24 2001
@@ -1030,7 +1030,9 @@ static struct pci_driver btaudio_pci_dri
         name:     "btaudio",
         id_table: btaudio_pci_tbl,
         probe:    btaudio_probe,
-        remove:   btaudio_remove,
+#ifdef DEVEXIT_LINKED
+	remove: btaudio_remove,
+#endif
 };
 
 int btaudio_init_module(void)
--- linux-2.4.17-pre2/drivers/sound/emu10k1/main.c	Tue Oct  9 10:53:18 2001
+++ linux-akpm/drivers/sound/emu10k1/main.c	Tue Dec  4 22:21:33 2001
@@ -1127,7 +1127,9 @@ static struct pci_driver emu10k1_pci_dri
 	name:		"emu10k1",
 	id_table:	emu10k1_pci_tbl,
 	probe:		emu10k1_probe,
+#ifdef DEVEXIT_LINKED
 	remove:		emu10k1_remove,
+#endif
 };
 
 static int __init emu10k1_init_module(void)
--- linux-2.4.17-pre2/drivers/sound/ymfpci.c	Thu Nov 22 23:02:58 2001
+++ linux-akpm/drivers/sound/ymfpci.c	Tue Dec  4 22:21:42 2001
@@ -2547,7 +2547,9 @@ static struct pci_driver ymfpci_driver =
 	name:		"ymfpci",
 	id_table:	ymf_id_tbl,
 	probe:		ymf_probe_one,
-	remove:         ymf_remove_one,
+#ifdef DEVEXIT_LINKED
+	remove:		ymf_remove_one,
+#endif
 	suspend:	ymf_suspend,
 	resume:		ymf_resume
 };
--- linux-2.4.17-pre2/drivers/usb/uhci.c	Thu Nov 22 23:02:58 2001
+++ linux-akpm/drivers/usb/uhci.c	Tue Dec  4 22:21:50 2001
@@ -2990,7 +2990,9 @@ static struct pci_driver uhci_pci_driver
 	id_table:	uhci_pci_ids,
 
 	probe:		uhci_pci_probe,
+#ifdef DEVEXIT_LINKED
 	remove:		uhci_pci_remove,
+#endif
 
 #ifdef	CONFIG_PM
 	suspend:	uhci_pci_suspend,
--- linux-2.4.17-pre2/drivers/usb/usb-ohci.c	Thu Nov 22 23:02:58 2001
+++ linux-akpm/drivers/usb/usb-ohci.c	Tue Dec  4 22:21:58 2001
@@ -2860,7 +2860,9 @@ static struct pci_driver ohci_pci_driver
 	id_table:	&ohci_pci_ids [0],
 
 	probe:		ohci_pci_probe,
+#ifdef DEVEXIT_LINKED
 	remove:		ohci_pci_remove,
+#endif
 
 #ifdef	CONFIG_PM
 	suspend:	ohci_pci_suspend,
--- linux-2.4.17-pre2/drivers/usb/usb-uhci.c	Thu Nov 22 23:02:58 2001
+++ linux-akpm/drivers/usb/usb-uhci.c	Tue Dec  4 22:08:44 2001
@@ -2845,7 +2845,7 @@ _static void start_hc (uhci_t *s)
 	s->running = 1;
 }
 
-_static void __devexit
+_static void
 uhci_pci_remove (struct pci_dev *dev)
 {
 	uhci_t *s = pci_get_drvdata(dev);
--- linux-2.4.17-pre2/drivers/video/cyber2000fb.c	Mon Nov  5 21:01:12 2001
+++ linux-akpm/drivers/video/cyber2000fb.c	Tue Dec  4 22:22:12 2001
@@ -1683,7 +1683,9 @@ static struct pci_device_id cyberpro_pci
 static struct pci_driver cyberpro_driver = {
 	name:		"CyberPro",
 	probe:		cyberpro_probe,
+#ifdef DEVEXIT_LINKED
 	remove:		cyberpro_remove,
+#endif
 	suspend:	cyberpro_suspend,
 	resume:		cyberpro_resume,
 	id_table:	cyberpro_pci_table
--- linux-2.4.17-pre2/drivers/video/imsttfb.c	Thu Nov 22 23:02:58 2001
+++ linux-akpm/drivers/video/imsttfb.c	Tue Dec  4 22:22:22 2001
@@ -1643,7 +1643,9 @@ static struct pci_driver imsttfb_pci_dri
 	name:		"imsttfb",
 	id_table:	imsttfb_pci_tbl,
 	probe:		imsttfb_probe,
+#ifdef DEVEXIT_LINKED
 	remove:		imsttfb_remove,
+#endif
 };
 
 static struct fb_ops imsttfb_ops = {
--- linux-2.4.17-pre2/drivers/video/radeonfb.c	Thu Nov 22 23:02:58 2001
+++ linux-akpm/drivers/video/radeonfb.c	Tue Dec  4 22:22:32 2001
@@ -619,7 +619,9 @@ static struct pci_driver radeonfb_driver
 	name:		"radeonfb",
 	id_table:	radeonfb_pci_table,
 	probe:		radeonfb_pci_register,
+#ifdef DEVEXIT_LINKED
 	remove:		radeonfb_pci_unregister,
+#endif
 };
 
 
--- linux-2.4.17-pre2/drivers/video/riva/fbdev.c	Thu Nov 22 23:02:58 2001
+++ linux-akpm/drivers/video/riva/fbdev.c	Tue Dec  4 22:22:39 2001
@@ -2082,7 +2082,9 @@ static struct pci_driver rivafb_driver =
 	name:		"rivafb",
 	id_table:	rivafb_pci_tbl,
 	probe:		rivafb_init_one,
+#ifdef DEVEXIT_LINKED
 	remove:		rivafb_remove_one,
+#endif
 };
 
 
--- linux-2.4.17-pre2/drivers/video/tdfxfb.c	Thu Nov 22 23:02:58 2001
+++ linux-akpm/drivers/video/tdfxfb.c	Tue Dec  4 22:22:48 2001
@@ -495,7 +495,9 @@ static struct pci_driver tdfxfb_driver =
 	name:		"tdfxfb",
 	id_table:	tdfxfb_id_table,
 	probe:		tdfxfb_probe,
+#ifdef DEVEXIT_LINKED
 	remove:		tdfxfb_remove,
+#endif
 };
 
 MODULE_DEVICE_TABLE(pci, tdfxfb_id_table);
