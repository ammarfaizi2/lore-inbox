Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270026AbUIDDRO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270026AbUIDDRO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 23:17:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270028AbUIDDRO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 23:17:14 -0400
Received: from smtp-out.hotpop.com ([38.113.3.61]:8161 "EHLO
	smtp-out.hotpop.com") by vger.kernel.org with ESMTP id S270026AbUIDDMW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 23:12:22 -0400
From: "Antonino A. Daplas" <adaplas@hotpop.com>
Reply-To: adaplas@pol.net
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH 4/5][RFC] fbdev: Clean up framebuffer initialization
Date: Sat, 4 Sep 2004 11:08:40 +0800
User-Agent: KMail/1.5.4
Cc: Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org,
       Thomas Winischhofer <thomas@winischhofer.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200409041108.40276.adaplas@hotpop.com>
X-HotPOP: -----------------------------------------------
                   Sent By HotPOP.com FREE Email
             Get your FREE POP email at www.HotPOP.com
          -----------------------------------------------
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch probably deserves discussion among developers.

Currently, the framebuffer system is initialized in a roundabout manner.
First, drivers/char/mem.c calls fbmem_init().  fbmem_init() will then
iterate over an array of individual drivers' xxxfb_init(), then each driver
registers its presence back to fbmem.  During console_init(),
drivers/char/vt.c will call fb_console_init(). fbcon will check for
registered drivers, and if any are present, will call take_over_console() in
drivers/char/vt.c.

This patch changes the initialization sequence so it proceeds in this
manner: Each driver has its own module_init(). Each driver calls
register_framebuffer() in fbmem.c. fbmem.c will then notify fbcon of the
driver registration.  Upon notification, fbcon calls take_over_console() in
vt.c.

The following are the changes brought about by this patch:

1. Each subsystem (fbcon, fbmem, xxxfb) will have their own module_init.
Thus, explicit calls to each subsystem's init functions are eliminated.

2. The struct fb_drivers array in fbmem.c can be removed.  This slashes
around 400 lines in fbmem.c

3. Parsing of kernel boot options were done by fbmem.c calling each
driver's xxxfb_setup() function.  Because this is not possible with this
patch, drivers can choose to either:
	a. have their own __setup() routine
	b. call fb_get_options("xxxfb") and pass the return  value to
	 xxxfb_setup(). This is to maintain compatibility with the
	'video=xxxfb:<options>' semantics.

4. Getting a framebuffer console will occur a bit late during the boot
process since the initialization sequence will depend upon the link order.
So, 'video/' is moved up in drivers/Makefile, shortly after 'pci/'

5. Because driver initialization will be dependent on the link order,
hardware that depends on other subsystems (agpgart, usb, serial, etc) may
choose to initialize after the subsystems they depend on. 

Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

 drivers/Makefile              |    3
 drivers/char/mem.c            |    6
 drivers/char/vt.c             |    6
 drivers/video/Makefile        |   10
 drivers/video/console/fbcon.c |    3
 drivers/video/fbmem.c         |  471 ++++--------------------------------------
 include/linux/fb.h            |    1
 7 files changed, 57 insertions(+), 443 deletions(-)

diff -uprN linux-2.6.9-rc1-mm3-orig/drivers/char/mem.c linux-2.6.9-rc1-mm3/drivers/char/mem.c
--- linux-2.6.9-rc1-mm3-orig/drivers/char/mem.c	2004-09-04 08:51:51.299067816 +0800
+++ linux-2.6.9-rc1-mm3/drivers/char/mem.c	2004-09-04 09:02:38.932612552 +0800
@@ -31,9 +31,6 @@
 # include <linux/efi.h>
 #endif
 
-#ifdef CONFIG_FB
-extern void fbmem_init(void);
-#endif
 #if defined(CONFIG_S390_TAPE) && defined(CONFIG_S390_TAPE_CHAR)
 extern void tapechar_init(void);
 #endif
@@ -685,9 +682,6 @@ static int __init chr_dev_init(void)
 				S_IFCHR | devlist[i].mode, devlist[i].name);
 	}
 	
-#if defined (CONFIG_FB)
-	fbmem_init();
-#endif
 	return 0;
 }
 
diff -uprN linux-2.6.9-rc1-mm3-orig/drivers/char/vt.c linux-2.6.9-rc1-mm3/drivers/char/vt.c
--- linux-2.6.9-rc1-mm3-orig/drivers/char/vt.c	2004-09-04 08:52:05.216951976 +0800
+++ linux-2.6.9-rc1-mm3/drivers/char/vt.c	2004-09-04 09:02:38.936611944 +0800
@@ -136,9 +136,6 @@ extern void prom_con_init(void);
 #ifdef CONFIG_MDA_CONSOLE
 extern int mda_console_init(void);
 #endif
-#ifdef CONFIG_FRAMEBUFFER_CONSOLE
-extern int fb_console_init(void);
-#endif
 
 struct vc vc_cons [MAX_NR_CONSOLES];
 
@@ -2672,9 +2669,6 @@ int __init vty_init(void)
 #ifdef CONFIG_MDA_CONSOLE
 	mda_console_init();
 #endif
-#ifdef CONFIG_FRAMEBUFFER_CONSOLE
-	fb_console_init();
-#endif	
 	return 0;
 }
 
diff -uprN linux-2.6.9-rc1-mm3-orig/drivers/Makefile linux-2.6.9-rc1-mm3/drivers/Makefile
--- linux-2.6.9-rc1-mm3-orig/drivers/Makefile	2004-09-04 08:51:39.326887864 +0800
+++ linux-2.6.9-rc1-mm3/drivers/Makefile	2004-09-04 09:02:38.938611640 +0800
@@ -7,6 +7,7 @@
 
 obj-$(CONFIG_PCI)		+= pci/
 obj-$(CONFIG_PARISC)		+= parisc/
+obj-y				+= video/
 obj-$(CONFIG_ACPI_BOOT)		+= acpi/
 # PnP must come after ACPI since it will eventually need to check if acpi
 # was used and do nothing if so
@@ -29,7 +30,7 @@ obj-$(CONFIG_FC4)		+= fc4/
 obj-$(CONFIG_SCSI)		+= scsi/
 obj-$(CONFIG_FUSION)		+= message/
 obj-$(CONFIG_IEEE1394)		+= ieee1394/
-obj-y				+= cdrom/ video/
+obj-y				+= cdrom/
 obj-$(CONFIG_MTD)		+= mtd/
 obj-$(CONFIG_PCMCIA)		+= pcmcia/
 obj-$(CONFIG_DIO)		+= dio/
diff -uprN linux-2.6.9-rc1-mm3-orig/drivers/video/console/fbcon.c linux-2.6.9-rc1-mm3/drivers/video/console/fbcon.c
--- linux-2.6.9-rc1-mm3-orig/drivers/video/console/fbcon.c	2004-09-04 08:44:07.000000000 +0800
+++ linux-2.6.9-rc1-mm3/drivers/video/console/fbcon.c	2004-09-04 09:02:38.942611032 +0800
@@ -2860,6 +2860,8 @@ int __init fb_console_init(void)
 	return 0;
 }
 
+module_init(fb_console_init);
+
 #ifdef MODULE
 
 void __exit fb_console_exit(void)
@@ -2870,7 +2872,6 @@ void __exit fb_console_exit(void)
 	give_up_console(&fb_con);
 }	
 
-module_init(fb_console_init);
 module_exit(fb_console_exit);
 
 #endif
diff -uprN linux-2.6.9-rc1-mm3-orig/drivers/video/fbmem.c linux-2.6.9-rc1-mm3/drivers/video/fbmem.c
--- linux-2.6.9-rc1-mm3-orig/drivers/video/fbmem.c	2004-09-04 08:44:07.000000000 +0800
+++ linux-2.6.9-rc1-mm3/drivers/video/fbmem.c	2004-09-04 09:02:38.955609056 +0800
@@ -51,383 +51,12 @@
      *  Frame buffer device initialization and setup routines
      */
 
-extern int acornfb_init(void);
-extern int acornfb_setup(char*);
-extern int amba_clcdfb_init(void);
-extern int amifb_init(void);
-extern int amifb_setup(char*);
-extern int atafb_init(void);
-extern int atafb_setup(char*);
-extern int macfb_init(void);
-extern int macfb_setup(char*);
-extern int cyberfb_init(void);
-extern int cyberfb_setup(char*);
-extern int pm2fb_init(void);
-extern int pm2fb_setup(char*);
-extern int pm3fb_init(void);
-extern int pm3fb_setup(char*);
-extern int clps711xfb_init(void);
-extern int cyber2000fb_init(void);
-extern int cyber2000fb_setup(char*);
-extern int retz3fb_init(void);
-extern int retz3fb_setup(char*);
-extern int cirrusfb_init(void);
-extern int cirrusfb_setup(char*);
-extern int hitfb_init(void);
-extern int vfb_init(void);
-extern int vfb_setup(char*);
-extern int offb_init(void);
-extern int atyfb_init(void);
-extern int atyfb_setup(char*);
-extern int aty128fb_init(void);
-extern int aty128fb_setup(char*);
-extern int neofb_init(void);
-extern int neofb_setup(char*);
-extern int igafb_init(void);
-extern int igafb_setup(char*);
-extern int imsttfb_init(void);
-extern int imsttfb_setup(char*);
-extern int dnfb_init(void);
-extern int tgafb_init(void);
-extern int tgafb_setup(char*);
-extern int virgefb_init(void);
-extern int virgefb_setup(char*);
-extern int resolver_video_setup(char*);
-extern int s3triofb_init(void);
-extern int vesafb_init(void);
-extern int vesafb_setup(char*);
-extern int vga16fb_init(void);
-extern int vga16fb_setup(char*);
-extern int hgafb_init(void);
-extern int hgafb_setup(char*);
-extern int matroxfb_init(void);
-extern int matroxfb_setup(char*);
-extern int hpfb_init(void);
-extern int platinumfb_init(void);
-extern int platinumfb_setup(char*);
-extern int control_init(void);
-extern int control_setup(char*);
-extern int valkyriefb_init(void);
-extern int valkyriefb_setup(char*);
-extern int chips_init(void);
-extern int g364fb_init(void);
-extern int sa1100fb_init(void);
-extern int pxafb_init(void);
-extern int pxafb_setup(char*);
-extern int fm2fb_init(void);
-extern int fm2fb_setup(char*);
-extern int q40fb_init(void);
-extern int sun3fb_init(void);
-extern int sun3fb_setup(char *);
-extern int sgivwfb_init(void);
-extern int sgivwfb_setup(char*);
-extern int gbefb_init(void);
-extern int gbefb_setup(char*);
-extern int rivafb_init(void);
-extern int rivafb_setup(char*);
-extern int tdfxfb_init(void);
-extern int tdfxfb_setup(char*);
-extern int tridentfb_init(void);
-extern int tridentfb_setup(char*);
-extern int sisfb_init(void);
-extern int sisfb_setup(char*);
-extern int stifb_init(void);
-extern int stifb_setup(char*);
-extern int pmagbafb_init(void);
-extern int pmagbbfb_init(void);
-extern int maxinefb_init(void);
-extern int tx3912fb_init(void);
-extern int tx3912fb_setup(char*);
-extern int radeonfb_init(void);
-extern int radeonfb_setup(char*);
-extern int radeonfb_old_init(void);
-extern int radeonfb_old_setup(char*);
-extern int e1355fb_init(void);
-extern int e1355fb_setup(char*);
-extern int pvr2fb_init(void);
-extern int pvr2fb_setup(char*);
-extern int sstfb_init(void);
-extern int sstfb_setup(char*);
-extern int i810fb_init(void);
-extern int i810fb_setup(char*);
-extern int ffb_init(void);
-extern int ffb_setup(char*);
-extern int cg6_init(void);
-extern int cg6_setup(char*);
-extern int cg3_init(void);
-extern int cg3_setup(char*);
-extern int bw2_init(void);
-extern int bw2_setup(char*);
-extern int cg14_init(void);
-extern int cg14_setup(char*);
-extern int p9100_init(void);
-extern int p9100_setup(char*);
-extern int tcx_init(void);
-extern int tcx_setup(char*);
-extern int leo_init(void);
-extern int leo_setup(char*);
-extern int kyrofb_init(void);
-extern int kyrofb_setup(char*);
-extern int mc68x328fb_init(void);
-extern int mc68x328fb_setup(char *);
-extern int asiliantfb_init(void);
-
-static struct {
-	const char *name;
-	int (*init)(void);
-	int (*setup)(char*);
-} fb_drivers[] __initdata = {
-
-	/*
-	 * Chipset specific drivers that use resource management
-	 */
-#ifdef CONFIG_FB_RETINAZ3
-	{ "retz3fb", retz3fb_init, retz3fb_setup },
-#endif
-#ifdef CONFIG_FB_AMIGA
-	{ "amifb", amifb_init, amifb_setup },
-#endif
-#ifdef CONFIG_FB_CLPS711X
-	{ "clps711xfb", clps711xfb_init, NULL },
-#endif
-#ifdef CONFIG_FB_CYBER
-	{ "cyberfb", cyberfb_init, cyberfb_setup },
-#endif
-#ifdef CONFIG_FB_CYBER2000
-	{ "cyber2000fb", cyber2000fb_init, cyber2000fb_setup },
-#endif
-#ifdef CONFIG_FB_ARMCLCD
-	{ "ambaclcdfb", amba_clcdfb_init, NULL },
-#endif
-#ifdef CONFIG_FB_PM2
-	{ "pm2fb", pm2fb_init, pm2fb_setup },
-#endif
-#ifdef CONFIG_FB_PM3
-	{ "pm3fb", pm3fb_init, pm3fb_setup },
-#endif           
-#ifdef CONFIG_FB_CIRRUS
-	{ "cirrusfb", cirrusfb_init, cirrusfb_setup },
-#endif
-#ifdef CONFIG_FB_ATY
-	{ "atyfb", atyfb_init, atyfb_setup },
-#endif
-#ifdef CONFIG_FB_MATROX
-	{ "matroxfb", matroxfb_init, matroxfb_setup },
-#endif
-#ifdef CONFIG_FB_ATY128
-	{ "aty128fb", aty128fb_init, aty128fb_setup },
-#endif
-#ifdef CONFIG_FB_NEOMAGIC
-	{ "neofb", neofb_init, neofb_setup },
-#endif
-#ifdef CONFIG_FB_VIRGE
-	{ "virgefb", virgefb_init, virgefb_setup },
-#endif
-#ifdef CONFIG_FB_RIVA
-	{ "rivafb", rivafb_init, rivafb_setup },
-#endif
-#ifdef CONFIG_FB_3DFX
-	{ "tdfxfb", tdfxfb_init, tdfxfb_setup },
-#endif
-#ifdef CONFIG_FB_RADEON
-	{ "radeonfb", radeonfb_init, radeonfb_setup },
-#endif
-#ifdef CONFIG_FB_RADEON_OLD
-	{ "radeonfb_old", radeonfb_old_init, radeonfb_old_setup },
-#endif
-#ifdef CONFIG_FB_CONTROL
-	{ "controlfb", control_init, control_setup },
-#endif
-#ifdef CONFIG_FB_PLATINUM
-	{ "platinumfb", platinumfb_init, platinumfb_setup },
-#endif
-#ifdef CONFIG_FB_VALKYRIE
-	{ "valkyriefb", valkyriefb_init, valkyriefb_setup },
-#endif
-#ifdef CONFIG_FB_CT65550
-	{ "chipsfb", chips_init, NULL },
-#endif
-#ifdef CONFIG_FB_IMSTT
-	{ "imsttfb", imsttfb_init, imsttfb_setup },
-#endif
-#ifdef CONFIG_FB_S3TRIO
-	{ "s3triofb", s3triofb_init, NULL },
-#endif 
-#ifdef CONFIG_FB_FM2
-	{ "fm2fb", fm2fb_init, fm2fb_setup },
-#endif 
-#ifdef CONFIG_FB_SIS
-	{ "sisfb", sisfb_init, sisfb_setup },
-#endif
-#ifdef CONFIG_FB_TRIDENT
-	{ "tridentfb", tridentfb_init, tridentfb_setup },
-#endif
-#ifdef CONFIG_FB_I810
-	{ "i810fb", i810fb_init, i810fb_setup },
-#endif	
-#ifdef CONFIG_FB_STI
-	{ "stifb", stifb_init, stifb_setup },
-#endif
-#ifdef CONFIG_FB_FFB
-	{ "ffb", ffb_init, ffb_setup },
-#endif
-#ifdef CONFIG_FB_CG6
-	{ "cg6fb", cg6_init, cg6_setup },
-#endif
-#ifdef CONFIG_FB_CG3
-	{ "cg3fb", cg3_init, cg3_setup },
-#endif
-#ifdef CONFIG_FB_BW2
-	{ "bw2fb", bw2_init, bw2_setup },
-#endif
-#ifdef CONFIG_FB_CG14
-	{ "cg14fb", cg14_init, cg14_setup },
-#endif
-#ifdef CONFIG_FB_P9100
-	{ "p9100fb", p9100_init, p9100_setup },
-#endif
-#ifdef CONFIG_FB_TCX
-	{ "tcxfb", tcx_init, tcx_setup },
-#endif
-#ifdef CONFIG_FB_LEO
-	{ "leofb", leo_init, leo_setup },
-#endif
-
-	/*
-	 * Generic drivers that are used as fallbacks
-	 * 
-	 * These depend on resource management and must be initialized
-	 * _after_ all other frame buffer devices that use resource
-	 * management!
-	 */
-
-#ifdef CONFIG_FB_OF
-	{ "offb", offb_init, NULL },
-#endif
-#ifdef CONFIG_FB_VESA
-	{ "vesafb", vesafb_init, vesafb_setup },
-#endif 
-
-	/*
-	 * Chipset specific drivers that don't use resource management (yet)
-	 */
-
-#ifdef CONFIG_FB_SGIVW
-	{ "sgivwfb", sgivwfb_init, sgivwfb_setup },
-#endif
-#ifdef CONFIG_FB_GBE
-	{ "gbefb", gbefb_init, gbefb_setup },
-#endif
-#ifdef CONFIG_FB_ACORN
-	{ "acornfb", acornfb_init, acornfb_setup },
-#endif
-#ifdef CONFIG_FB_ATARI
-	{ "atafb", atafb_init, atafb_setup },
-#endif
-#ifdef CONFIG_FB_MAC
-	{ "macfb", macfb_init, macfb_setup },
-#endif
-#ifdef CONFIG_FB_HGA
-	{ "hgafb", hgafb_init, hgafb_setup },
-#endif 
-#ifdef CONFIG_FB_IGA
-	{ "igafb", igafb_init, igafb_setup },
-#endif
-#ifdef CONFIG_APOLLO
-	{ "apollofb", dnfb_init, NULL },
-#endif
-#ifdef CONFIG_FB_Q40
-	{ "q40fb", q40fb_init, NULL },
-#endif
-#ifdef CONFIG_FB_TGA
-	{ "tgafb", tgafb_init, tgafb_setup },
-#endif
-#ifdef CONFIG_FB_HP300
-	{ "hpfb", hpfb_init, NULL },
-#endif 
-#ifdef CONFIG_FB_G364
-	{ "g364fb", g364fb_init, NULL },
-#endif
-#ifdef CONFIG_FB_SA1100
-	{ "sa1100fb", sa1100fb_init, NULL },
-#endif
-#ifdef CONFIG_FB_PXA
-	{ "pxafb", pxafb_init, pxafb_setup },
-#endif
-#ifdef CONFIG_FB_SUN3
-	{ "sun3fb", sun3fb_init, sun3fb_setup },
-#endif
-#ifdef CONFIG_FB_HIT
-	{ "hitfb", hitfb_init, NULL },
-#endif
-#ifdef CONFIG_FB_TX3912
-	{ "tx3912fb", tx3912fb_init, tx3912fb_setup },
-#endif
-#ifdef CONFIG_FB_E1355
-	{ "e1355fb", e1355fb_init, e1355fb_setup },
-#endif
-#ifdef CONFIG_FB_PVR2
-	{ "pvr2fb", pvr2fb_init, pvr2fb_setup },
-#endif
-#ifdef CONFIG_FB_PMAG_BA
-	{ "pmagbafb", pmagbafb_init, NULL },
-#endif          
-#ifdef CONFIG_FB_PMAGB_B
-	{ "pmagbbfb", pmagbbfb_init, NULL },
-#endif
-#ifdef CONFIG_FB_MAXINE
-	{ "maxinefb", maxinefb_init, NULL },
-#endif            
-#ifdef CONFIG_FB_VOODOO1
-	{ "sstfb", sstfb_init, sstfb_setup },
-#endif
-#ifdef CONFIG_FB_KYRO
-	{ "kyrofb", kyrofb_init, kyrofb_setup },
-#endif
-#ifdef CONFIG_FB_68328
-	{ "68328fb", mc68x328fb_init, mc68x328fb_setup },
-#endif
-#ifdef CONFIG_FB_ASILIANT
-	{ "asiliantfb", asiliantfb_init, NULL },
-#endif
-
-	/*
-	 * Generic drivers that don't use resource management (yet)
-	 */
-
-#ifdef CONFIG_FB_VGA16
-	{ "vga16fb", vga16fb_init, vga16fb_setup },
-#endif 
-
-#ifdef CONFIG_GSP_RESOLVER
-	/* Not a real frame buffer device... */
-	{ "resolverfb", NULL, resolver_video_setup },
-#endif
-
-#ifdef CONFIG_FB_VIRTUAL
-	/*
-	 * Vfb must be last to avoid that it becomes your primary display if
-	 * other display devices are present
-	 */
-	{ "vfb", vfb_init, vfb_setup },
-#endif
-};
-
-#define NUM_FB_DRIVERS	(sizeof(fb_drivers)/sizeof(*fb_drivers))
 #define FBPIXMAPSIZE	16384
 
-extern const char *global_mode_option;
-
-static initcall_t pref_init_funcs[FB_MAX];
-static int num_pref_init_funcs __initdata = 0;
 static struct notifier_block *fb_notifier_list;
 struct fb_info *registered_fb[FB_MAX];
 int num_registered_fb;
 
-#ifdef CONFIG_FB_OF
-static int ofonly __initdata = 0;
-#endif
-
 /*
  * Helpers
  */
@@ -1637,11 +1266,9 @@ void fb_set_suspend(struct fb_info *info
  *
  */
 
-void __init 
+int __init
 fbmem_init(void)
 {
-	int i;
-
 	create_proc_read_entry("fb", 0, NULL, fbmem_read_proc, NULL);
 
 	devfs_mk_dir("fb");
@@ -1653,26 +1280,47 @@ fbmem_init(void)
 		printk(KERN_WARNING "Unable to create fb class; errno = %ld\n", PTR_ERR(fb_class));
 		fb_class = NULL;
 	}
+	return 0;
+}
+module_init(fbmem_init);
 
-#ifdef CONFIG_FB_OF
-	if (ofonly) {
-		offb_init();
-		return;
-	}
-#endif
-
-	/*
-	 *  Probe for all builtin frame buffer devices
-	 */
-	for (i = 0; i < num_pref_init_funcs; i++)
-		pref_init_funcs[i]();
+#define NR_FB_DRIVERS 64
+static char *video_options[NR_FB_DRIVERS];
 
-	for (i = 0; i < NUM_FB_DRIVERS; i++)
-		if (fb_drivers[i].init)
-			fb_drivers[i].init();
+/**
+ * fb_get_options - get kernel boot parameters
+ * @name - framebuffer name as it would appear in
+ *         the boot parameter line
+ *         (video=<name>:<options>)
+ *
+ * NOTE: Needed to maintain backwards compatibility
+ */
+char* fb_get_options(char *name)
+{
+	char *option = NULL;
+	char *opt;
+	int opt_len;
+	int name_len = strlen(name), i;
+
+	if (!name_len)
+		return option;
+
+	for (i = 0; i < NR_FB_DRIVERS; i++) {
+		if (video_options[i] == NULL)
+			continue;
+		opt_len = strlen(video_options[i]);
+		if (!opt_len)
+			continue;
+		opt = video_options[i];
+		if (!strncmp(name, opt, name_len) &&
+		    opt[name_len] == ':') {
+			option = opt + name_len + 1;
+			break;
+		}
+	}
+	return option;
 }
 
-
 /**
  *	video_setup - process command line options
  *	@options: string of options
@@ -1680,6 +1328,8 @@ fbmem_init(void)
  *	Process command line options for frame buffer subsystem.
  *
  *	NOTE: This function is a __setup and __init function.
+ *            It only stores the options.  Drivers have to call
+ *            fb_get_options() as necessary.
  *
  *	Returns zero.
  *
@@ -1687,48 +1337,20 @@ fbmem_init(void)
 
 int __init video_setup(char *options)
 {
-	int i, j;
+	int i;
 
 	if (!options || !*options)
 		return 0;
-	   
-#ifdef CONFIG_FB_OF
-	if (!strcmp(options, "ofonly")) {
-		ofonly = 1;
-		return 0;
-	}
-#endif
 
-	if (num_pref_init_funcs == FB_MAX)
-		return 0;
-
-	for (i = 0; i < NUM_FB_DRIVERS; i++) {
-		j = strlen(fb_drivers[i].name);
-		if (!strncmp(options, fb_drivers[i].name, j) &&
-			options[j] == ':') {
-			if (!strcmp(options+j+1, "off"))
-				fb_drivers[i].init = NULL;
-			else {
-				if (fb_drivers[i].init) {
-					pref_init_funcs[num_pref_init_funcs++] =
-						fb_drivers[i].init;
-					fb_drivers[i].init = NULL;
-				}
-				if (fb_drivers[i].setup)
-					fb_drivers[i].setup(options+j+1);
-			}
-			return 0;
+	for (i = 0; i < NR_FB_DRIVERS; i++) {
+		if (video_options[i] == NULL) {
+			video_options[i] = options;
+			break;
 		}
 	}
-
-	/*
-	 * If we get here no fb was specified.
-	 * We consider the argument to be a global video mode option.
-	 */
-	global_mode_option = options;
+
 	return 0;
 }
-
 __setup("video=", video_setup);
 
     /*
@@ -1753,5 +1375,6 @@ EXPORT_SYMBOL(fb_load_cursor_image);
 EXPORT_SYMBOL(fb_set_suspend);
 EXPORT_SYMBOL(fb_register_client);
 EXPORT_SYMBOL(fb_unregister_client);
+EXPORT_SYMBOL(fb_get_options);
 
 MODULE_LICENSE("GPL");
diff -uprN linux-2.6.9-rc1-mm3-orig/drivers/video/Makefile linux-2.6.9-rc1-mm3/drivers/video/Makefile
--- linux-2.6.9-rc1-mm3-orig/drivers/video/Makefile	2004-09-04 08:26:19.000000000 +0800
+++ linux-2.6.9-rc1-mm3/drivers/video/Makefile	2004-09-04 09:02:38.958608600 +0800
@@ -13,6 +13,7 @@ ifeq ($(CONFIG_FB),y)
 obj-$(CONFIG_PPC)                 += macmodes.o
 endif
 
+obj-$(CONFIG_FB_OF)               += offb.o cfbfillrect.o cfbimgblt.o cfbcopyarea.o
 obj-$(CONFIG_FB_ARMCLCD)	  += amba-clcd.o cfbfillrect.o cfbcopyarea.o cfbimgblt.o
 obj-$(CONFIG_FB_ACORN)            += acornfb.o cfbfillrect.o cfbcopyarea.o cfbimgblt.o
 obj-$(CONFIG_FB_AMIGA)            += amifb.o c2p.o
@@ -40,16 +41,12 @@ obj-$(CONFIG_FB_3DFX)             += cfb
 endif
 obj-$(CONFIG_FB_MAC)              += macfb.o macmodes.o cfbfillrect.o cfbcopyarea.o cfbimgblt.o 
 obj-$(CONFIG_FB_HP300)            += hpfb.o cfbfillrect.o cfbimgblt.o
-obj-$(CONFIG_FB_OF)               += offb.o cfbfillrect.o cfbimgblt.o cfbcopyarea.o
 obj-$(CONFIG_FB_IMSTT)            += imsttfb.o cfbimgblt.o
 obj-$(CONFIG_FB_RETINAZ3)         += retz3fb.o
 obj-$(CONFIG_FB_CIRRUS)		  += cirrusfb.o cfbfillrect.o cfbimgblt.o cfbcopyarea.o
 obj-$(CONFIG_FB_TRIDENT)	  += tridentfb.o cfbfillrect.o cfbimgblt.o cfbcopyarea.o
 obj-$(CONFIG_FB_S3TRIO)           += S3triofb.o
 obj-$(CONFIG_FB_TGA)              += tgafb.o cfbfillrect.o cfbcopyarea.o cfbimgblt.o 
-obj-$(CONFIG_FB_VESA)             += vesafb.o cfbfillrect.o cfbcopyarea.o cfbimgblt.o 
-obj-$(CONFIG_FB_VGA16)            += vga16fb.o cfbfillrect.o cfbcopyarea.o \
-	                             cfbimgblt.o vgastate.o 
 obj-$(CONFIG_FB_VIRGE)            += virgefb.o
 obj-$(CONFIG_FB_G364)             += g364fb.o cfbfillrect.o cfbcopyarea.o cfbimgblt.o
 obj-$(CONFIG_FB_FM2)              += fm2fb.o cfbfillrect.o cfbcopyarea.o cfbimgblt.o
@@ -71,7 +68,6 @@ obj-$(CONFIG_FB_I810)             += i81
 obj-$(CONFIG_FB_SUN3)             += sun3fb.o
 obj-$(CONFIG_FB_HGA)              += hgafb.o cfbfillrect.o cfbcopyarea.o cfbimgblt.o 
 obj-$(CONFIG_FB_SA1100)           += sa1100fb.o cfbfillrect.o cfbcopyarea.o cfbimgblt.o
-obj-$(CONFIG_FB_VIRTUAL)          += vfb.o cfbfillrect.o cfbcopyarea.o cfbimgblt.o 
 obj-$(CONFIG_FB_HIT)              += hitfb.o cfbfillrect.o cfbimgblt.o
 obj-$(CONFIG_FB_EPSON1355)	  += epson1355fb.o cfbfillrect.o cfbcopyarea.o cfbimgblt.o
 obj-$(CONFIG_FB_PVR2)             += pvr2fb.o cfbfillrect.o cfbcopyarea.o cfbimgblt.o
@@ -94,3 +90,7 @@ obj-$(CONFIG_FB_TCX)               += tc
 obj-$(CONFIG_FB_LEO)               += leo.o sbuslib.o cfbimgblt.o cfbcopyarea.o \
 				      cfbfillrect.o
 obj-$(CONFIG_FB_PXA)		   += pxafb.o cfbimgblt.o cfbcopyarea.o cfbfillrect.o
+obj-$(CONFIG_FB_VGA16)            += vga16fb.o cfbfillrect.o cfbcopyarea.o \
+	                             cfbimgblt.o vgastate.o
+obj-$(CONFIG_FB_VESA)             += vesafb.o cfbfillrect.o cfbcopyarea.o cfbimgblt.o
+obj-$(CONFIG_FB_VIRTUAL)          += vfb.o cfbfillrect.o cfbcopyarea.o cfbimgblt.o
diff -uprN linux-2.6.9-rc1-mm3-orig/include/linux/fb.h linux-2.6.9-rc1-mm3/include/linux/fb.h
--- linux-2.6.9-rc1-mm3-orig/include/linux/fb.h	2004-09-04 08:44:07.000000000 +0800
+++ linux-2.6.9-rc1-mm3/include/linux/fb.h	2004-09-04 09:02:38.960608296 +0800
@@ -708,6 +708,7 @@ extern void fb_sysmove_buf_aligned(struc
 extern void fb_load_cursor_image(struct fb_info *);
 extern void fb_set_suspend(struct fb_info *info, int state);
 extern int fb_get_color_depth(struct fb_info *info);
+extern char* fb_get_options(char *name);
 
 extern struct fb_info *registered_fb[FB_MAX];
 extern int num_registered_fb;

		



