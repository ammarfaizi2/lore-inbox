Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261506AbTLLRRT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Dec 2003 12:17:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261406AbTLLRRT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Dec 2003 12:17:19 -0500
Received: from cpe.atm2-0-1071046.0x50a5258e.abnxx8.customer.tele.dk ([80.165.37.142]:29607
	"EHLO starbattle.com") by vger.kernel.org with ESMTP
	id S261506AbTLLRRO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Dec 2003 12:17:14 -0500
From: Daniel Tram Lux <daniel@starbattle.com>
Date: Fri, 12 Dec 2003 18:17:11 +0100
To: linux-kernel@vger.kernel.org
Subject: Re: [patch] ide.c as a module
Message-ID: <20031212171711.GA15954@starbattle.com>
References: <20031211202536.GA10529@starbattle.com> <200312121430.36735.bzolnier@elka.pw.edu.pl> <20031212144246.GA15357@starbattle.com> <200312121646.04047.bzolnier@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200312121646.04047.bzolnier@elka.pw.edu.pl>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bartlomiej,

I applied your changes only, reverting all of mine...

moving the initializing=1 also solves the multiple init problem...thanks

here is how the patch looks like now:

--- ./linux-2.4.23.org/drivers/ide/ide.c        2003-11-28 19:26:20.000000000 +0100
+++ ./linux-2.4.23/drivers/ide/ide.c    2004-03-12 17:56:28.000000000 +0100
@@ -188,7 +188,6 @@
  */
 ide_module_t *ide_chipsets;
 ide_module_t *ide_modules;
-ide_module_t *ide_probe;
 
 /*
  * This is declared extern in ide.h, for access by other IDE modules:
@@ -307,6 +306,7 @@
                init_hwif_data(index);
 
        /* Add default hw interfaces */
+       initializing = 1;
        ide_init_default_hwifs();
 
        idebus_parameter = 0;
@@ -512,20 +512,6 @@
        }
 }
 
-void ide_probe_module (int revaldiate)
-{
-       if (!ide_probe) {
-#if  defined(CONFIG_BLK_DEV_IDE_MODULE)
-               (void) request_module("ide-probe-mod");
-#endif
-       } else {
-               (void) ide_probe->init();
-       }
-       revalidate_drives(revaldiate);
-}
-
-EXPORT_SYMBOL(ide_probe_module);
-
 void ide_driver_module (int revaldiate)
 {
        int index;
@@ -534,7 +520,8 @@
        for (index = 0; index < MAX_HWIFS; ++index)
                if (ide_hwifs[index].present)
                        goto search;
-       ide_probe_module(revaldiate);
+        ideprobe_init();
+        revalidate_drives(revaldiate);
 search:
        while (module) {
                (void) module->init();
@@ -1141,6 +1128,7 @@
 }
 
 EXPORT_SYMBOL(ide_setup_ports);
+extern int ideprobe_init_module (void);
 
 /*
  * Register an IDE interface, specifing exactly the registers etc
@@ -1181,7 +1169,10 @@
        hwif->chipset = hw->chipset;
 
        if (!initializing) {
-               ide_probe_module(1);
+#ifdef MODULE
+           if (ideprobe_init_module() == -EBUSY)
+#endif
+                ideprobe_init();
 #ifdef CONFIG_PROC_FS
                create_proc_ide_interfaces();
 #endif
@@ -2954,7 +2945,6 @@
  */
 devfs_handle_t ide_devfs_handle;
 
-EXPORT_SYMBOL(ide_probe);
 EXPORT_SYMBOL(ide_devfs_handle);
 
 static int ide_notify_reboot (struct notifier_block *this, unsigned long event, void *x)
@@ -3024,7 +3014,6 @@
        ide_init_builtin_subdrivers();
 #endif /* CLASSIC_BUILTINS_METHOD */
 
-       initializing = 1;
        ide_init_builtin_drivers();
        initializing = 0;



--- ./linux-2.4.23.org/drivers/ide/ide-probe.c  2003-11-28 19:26:20.000000000 +0100
+++ ./linux-2.4.23/drivers/ide/ide-probe.c      2004-03-12 17:56:37.000000000 +0100
@@ -1407,8 +1407,6 @@
                        probe_hwif_init(&ide_hwifs[index]);
 #endif /* HWIF_PROBE_CLASSIC_METHOD */
 
-       if (!ide_probe)
-               ide_probe = &ideprobe_module;
        MOD_DEC_USE_COUNT;
        return 0;
 }
@@ -1436,7 +1434,6 @@
 
 void ideprobe_cleanup_module (void)
 {
-       ide_probe = NULL;
        ide_xlate_1024_hook = 0;
 }
 EXPORT_SYMBOL(ideprobe_init_module);


Regards
   Daniel

On Fri, Dec 12, 2003 at 04:46:04PM +0100, Bartlomiej Zolnierkiewicz wrote:
> On Friday 12 of December 2003 15:42, Daniel Tram Lux wrote:
> > Hi,
> >
> > I tried with using only your suggested changes and removing the ide_probe
>                             ^^^^
> Your patch + changes or only changes?
> 
> > ptr, but due to (in include/asm-i386/ide.h) where CONFIG_BLK_DEV_IDEPCI is
> > indeed undefined:
> >
> > static __inline__ void ide_init_default_hwifs(void)
> > {
> > #ifndef CONFIG_BLK_DEV_IDEPCI
> > 	hw_regs_t hw;
> > 	int index;
> >
> > 	for(index = 0; index < MAX_HWIFS; index++) {
> > 		memset(&hw, 0, sizeof hw);
> > 		ide_init_hwif_ports(&hw, ide_default_io_base(index), 0, NULL);
> > 		hw.irq = ide_default_irq(ide_default_io_base(index));
> > 		ide_register_hw(&hw, NULL);
> > 	}
> > #endif /* CONFIG_BLK_DEV_IDEPCI */
> > }
> >
> > I get the following probing messages (I enabled a debug message which is
> > why there are so many messages):
> 
> "initializing = 1" must be moved from ide_init() to ide_init_data()
> (just before ide_init_default_hwifs() call).
> 
> --bart
