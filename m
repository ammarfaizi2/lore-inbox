Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268260AbRG3BFh>; Sun, 29 Jul 2001 21:05:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268257AbRG3BF3>; Sun, 29 Jul 2001 21:05:29 -0400
Received: from SSH.ChaoticDreams.ORG ([64.162.95.164]:7556 "EHLO
	ssh.chaoticdreams.org") by vger.kernel.org with ESMTP
	id <S268261AbRG3BFM>; Sun, 29 Jul 2001 21:05:12 -0400
Date: Sun, 29 Jul 2001 18:04:49 -0700
From: Paul Mundt <lethal@ChaoticDreams.ORG>
To: Steven Walter <srwalter@yahoo.com>
Cc: linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net,
        linux-fbdev-users@lists.sourceforge.net
Subject: Re: [PATCH] Port tdfxfb to new-style PCI API
Message-ID: <20010729180449.A12644@ChaoticDreams.ORG>
In-Reply-To: <20010728162117.A9266@hapablap.dyn.dhs.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="VS++wcV0S1rZb1Fb"
Content-Disposition: inline
User-Agent: Mutt/1.3.13i
In-Reply-To: <20010728162117.A9266@hapablap.dyn.dhs.org>; from srwalter@yahoo.com on Sat, Jul 28, 2001 at 04:21:17PM -0500
Organization: Chaotic Dreams Development Team
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing


--VS++wcV0S1rZb1Fb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Jul 28, 2001 at 04:21:17PM -0500, Steven Walter wrote:
> I have created a patch that changes the 3dfx framebuffer driver so that
> it uses the new-style PCI api.  Additionally, it adds the ability to
> pass parameters to the module (previously these were only availible when
> built into the kernel) and makes the indention conformant to
> Coding-Style.
> 
> I've tested it myself as both module and built-in with no problems, but
> you can never test too much.  I'd like to ask adventuresome users of
> this driver to try out my patch, with the hopeful end result of
> inclusion into the kernel.
> 
> The patch is availible from:
> http://www.apex.net/users/trwalter/tdfxfb-patch.gz
> Its 22k compressed (large because of style/indention changes), so I was
> hesitant to post it to the list.
> 
Looks good for the most part, but maybe we could do without the excessive
white space changes?

How about something more like the attached patch?

Regards,

-- 
Paul Mundt <lethal@chaoticdreams.org>


--VS++wcV0S1rZb1Fb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="tdfxfb-pci.diff"

--- linux.orig/drivers/video/tdfxfb.c	Wed Jul  4 11:50:39 2001
+++ linux/drivers/video/tdfxfb.c	Sun Jul 29 17:58:23 2001
@@ -19,6 +19,11 @@
  * (proper acceleration, 24 bpp, hardware cursor) and bug fixes by Attila
  * Kesmarki. Thanks guys!
  * 
+ * Voodoo1 and Voodoo2 support aren't relevant to this driver as they
+ * behave very differently from the Voodoo3/4/5. For anyone wanting to
+ * use frame buffer on the Voodoo1/2, see the sstfb driver (which is
+ * located at http://www.sourceforge.net/projects/sstfb).
+ *
  * While I _am_ grateful to 3Dfx for releasing the specs for Banshee,
  * I do wish the next version is a bit more complete. Without the XF86
  * patches I couldn't have gotten even this far... for instance, the
@@ -32,9 +37,6 @@
  * TODO:
  * - support for 16/32 bpp needs fixing (funky bootup penguin)
  * - multihead support (basically need to support an array of fb_infos)
- * - banshee and voodoo3 now supported -- any others? afaik, the original
- *   voodoo was a 3d-only card, so we won't consider that. what about
- *   voodoo2?
  * - support other architectures (PPC, Alpha); does the fact that the VGA
  *   core can be accessed only thru I/O (not memory mapped) complicate
  *   things?
@@ -385,12 +387,6 @@
 			   int kspc, 
 			   int con,
 			   struct fb_info* info);
-static int tdfxfb_ioctl(struct inode* inode, 
-			struct file* file, 
-			u_int cmd,
-			u_long arg, 
-			int con, 
-			struct fb_info* info);
 
 /*
  *  Interface to the low level console driver
@@ -464,6 +460,12 @@
 void tdfxfb_setup(char *options, 
 		  int *ints);
 
+/*
+ * PCI driver prototypes
+ */
+static int tdfxfb_probe(struct pci_dev *pdev, const struct pci_device_id *id);
+static void tdfxfb_remove(struct pci_dev *pdev);
+
 static int currcon = 0;
 
 static struct fb_ops tdfxfb_ops = {
@@ -474,9 +476,30 @@
 	fb_get_cmap:	tdfxfb_get_cmap,
 	fb_set_cmap:	tdfxfb_set_cmap,
 	fb_pan_display:	tdfxfb_pan_display,
-	fb_ioctl:	tdfxfb_ioctl,
 };
 
+static struct pci_device_id tdfxfb_id_table[] __devinitdata = {
+	{ PCI_VENDOR_ID_3DFX, PCI_DEVICE_ID_3DFX_BANSHEE,
+	  PCI_ANY_ID, PCI_ANY_ID, PCI_BASE_CLASS_DISPLAY << 16,
+	  0xff0000, 0 },
+	{ PCI_VENDOR_ID_3DFX, PCI_DEVICE_ID_3DFX_VOODOO3,
+	  PCI_ANY_ID, PCI_ANY_ID, PCI_BASE_CLASS_DISPLAY << 16,
+	  0xff0000, 0 },
+	{ PCI_VENDOR_ID_3DFX, PCI_DEVICE_ID_3DFX_VOODOO5,
+	  PCI_ANY_ID, PCI_ANY_ID, PCI_BASE_CLASS_DISPLAY << 16,
+	  0xff0000, 0 },
+	{ 0, }
+};
+
+static struct pci_driver tdfxfb_driver = {
+	name:		"tdfxfb",
+	id_table:	tdfxfb_id_table,
+	probe:		tdfxfb_probe,
+	remove:		tdfxfb_remove,
+};
+
+MODULE_DEVICE_TABLE(pci, tdfxfb_id_table);
+
 struct mode {
   char* name;
   struct fb_var_screeninfo var;
@@ -1865,170 +1888,160 @@
    return 0;
 }
 
-static int tdfxfb_ioctl(struct inode *inode, 
-			struct file *file, 
-			u_int cmd,
-			u_long arg, 
-			int con, 
-			struct fb_info *fb) {
-/* These IOCTLs ar just for testing only... 
-   switch (cmd) {
-    case 0x4680: 
-      nowrap=nopan=0;
-      return 0;
-    case 0x4681:
-      nowrap=nopan=1;
-      return 0;
-   }*/
-   return -EINVAL;
-}
+/**
+ * 	tdfxfb_probe - Device Initializiation
+ * 	
+ * 	@pdev:	PCI Device to initialize
+ * 	@id:	PCI Device ID
+ *
+ * 	Initializes and allocates resources for PCI device @pdev.
+ *
+ */
+static int __devinit tdfxfb_probe(struct pci_dev *pdev,
+				  const struct pci_device_id *id)
+{
+	struct fb_var_screeninfo var;
+	char *name = NULL;
 
-int __init tdfxfb_init(void) {
-  struct pci_dev *pdev = NULL;
-  struct fb_var_screeninfo var;
-  
-  while ((pdev = pci_find_device(PCI_VENDOR_ID_3DFX, PCI_ANY_ID, pdev))) {
-    if(((pdev->class >> 16) == PCI_BASE_CLASS_DISPLAY) &&
-       ((pdev->device == PCI_DEVICE_ID_3DFX_BANSHEE) ||
-	(pdev->device == PCI_DEVICE_ID_3DFX_VOODOO3) ||
-	(pdev->device == PCI_DEVICE_ID_3DFX_VOODOO5))) {
-      char *name = NULL;
-
-      fb_info.dev   = pdev->device;
-      switch (pdev->device) {
-      case PCI_DEVICE_ID_3DFX_BANSHEE:
-	fb_info.max_pixclock = BANSHEE_MAX_PIXCLOCK;
-	name = "Banshee";
-	break;
-      case PCI_DEVICE_ID_3DFX_VOODOO3:
-	fb_info.max_pixclock = VOODOO3_MAX_PIXCLOCK;
-	name = "Voodoo3";
-	break;
-      case PCI_DEVICE_ID_3DFX_VOODOO5:
-	fb_info.max_pixclock = VOODOO5_MAX_PIXCLOCK;
-	name = "Voodoo5";
-	break;
-      }
-      fb_info.regbase_phys = pci_resource_start(pdev, 0);
-      fb_info.regbase_size = 1 << 24;
-      fb_info.regbase_virt = ioremap_nocache(fb_info.regbase_phys, 1 << 24);
-      if(!fb_info.regbase_virt) {
-	printk("fb: Can't remap %s register area.\n", name);
-	return -ENXIO;
-      }
+	fb_info.dev = pdev->device;
+	
+	switch (pdev->device) {
+		case PCI_DEVICE_ID_3DFX_BANSHEE:
+			fb_info.max_pixclock = BANSHEE_MAX_PIXCLOCK;
+			name = "Banshee";
+			break;
+		case PCI_DEVICE_ID_3DFX_VOODOO3:
+			fb_info.max_pixclock = VOODOO3_MAX_PIXCLOCK;
+			name = "Voodoo3";
+			break;
+		case PCI_DEVICE_ID_3DFX_VOODOO5:
+			fb_info.max_pixclock = VOODOO5_MAX_PIXCLOCK;
+			name = "Voodoo5";
+			break;
+	}
+	
+	fb_info.regbase_phys = pci_resource_start(pdev, 0);
+	fb_info.regbase_size = 1 << 24;
+	fb_info.regbase_virt = ioremap_nocache(fb_info.regbase_phys, 1 << 24);
+	
+	if (!fb_info.regbase_virt) {
+		printk(KERN_WARNING "fb: Can't remap %s register area.\n", name);
+		return -ENXIO;
+	}
       
-      fb_info.bufbase_phys = pci_resource_start (pdev, 1);
-      if(!(fb_info.bufbase_size = do_lfb_size())) {
-	iounmap(fb_info.regbase_virt);
-	printk("fb: Can't count %s memory.\n", name);
-	return -ENXIO;
-      }
-      fb_info.bufbase_virt = ioremap_nocache(fb_info.bufbase_phys, fb_info.bufbase_size);
-      if(!fb_info.regbase_virt) {
-	printk("fb: Can't remap %s framebuffer.\n", name);
-	iounmap(fb_info.regbase_virt);
-	return -ENXIO;
-      }
+	fb_info.bufbase_phys = pci_resource_start (pdev, 1);
+	
+	if (!(fb_info.bufbase_size = do_lfb_size())) {
+		iounmap(fb_info.regbase_virt);
+		printk(KERN_WARNING "fb: Can't count %s memory.\n", name);
+		return -ENXIO;
+	}
+	
+	fb_info.bufbase_virt = ioremap_nocache(fb_info.bufbase_phys,
+					       fb_info.bufbase_size);
+					       
+	if (!fb_info.regbase_virt) {
+		printk(KERN_WARNING "fb: Can't remap %s framebuffer.\n", name);
+		iounmap(fb_info.regbase_virt);
+		return -ENXIO;
+	}
 
-      fb_info.iobase = pci_resource_start (pdev, 2);
+	fb_info.iobase = pci_resource_start (pdev, 2);
       
-      printk("fb: %s memory = %ldK\n", name, fb_info.bufbase_size >> 10);
+	printk("fb: %s memory = %ldK\n", name, fb_info.bufbase_size >> 10);
 
 #ifdef CONFIG_MTRR
-       if (!nomtrr) {
-          fb_info.mtrr_idx = mtrr_add(fb_info.bufbase_phys, fb_info.bufbase_size,
-	  			      MTRR_TYPE_WRCOMB, 1);
-	    printk("fb: MTRR's  turned on\n");
-       }
+	if (!nomtrr) {
+		fb_info.mtrr_idx = mtrr_add(fb_info.bufbase_phys,
+					    fb_info.bufbase_size,
+					    MTRR_TYPE_WRCOMB, 1);
+		printk(KERN_INFO "fb: MTRR's turned on\n");
+	}
 #endif
 
-      /* clear framebuffer memory */
-      memset_io(fb_info.bufbase_virt, 0, fb_info.bufbase_size);
-      currcon = -1;
-      if (!nohwcursor) tdfxfb_hwcursor_init();
+	/* clear framebuffer memory */
+	memset_io(fb_info.bufbase_virt, 0, fb_info.bufbase_size);
+	currcon = -1;
+
+	if (!nohwcursor)
+		tdfxfb_hwcursor_init();
        
-      init_timer(&fb_info.cursor.timer);
-      fb_info.cursor.timer.function = do_flashcursor; 
-      fb_info.cursor.timer.data = (unsigned long)(&fb_info);
-      fb_info.cursor.state = CM_ERASE;
-      spin_lock_init(&fb_info.DAClock);
+	init_timer(&fb_info.cursor.timer);
+	fb_info.cursor.timer.function = do_flashcursor; 
+	fb_info.cursor.timer.data = (unsigned long)(&fb_info);
+	fb_info.cursor.state = CM_ERASE;
+	spin_lock_init(&fb_info.DAClock);
        
-      strcpy(fb_info.fb_info.modename, "3Dfx "); 
-      strcat(fb_info.fb_info.modename, name);
-      fb_info.fb_info.changevar  = NULL;
-      fb_info.fb_info.node       = -1;
-      fb_info.fb_info.fbops      = &tdfxfb_ops;
-      fb_info.fb_info.disp       = &fb_info.disp;
-      strcpy(fb_info.fb_info.fontname, fontname);
-      fb_info.fb_info.switch_con = &tdfxfb_switch_con;
-      fb_info.fb_info.updatevar  = &tdfxfb_updatevar;
-      fb_info.fb_info.blank      = &tdfxfb_blank;
-      fb_info.fb_info.flags      = FBINFO_FLAG_DEFAULT;
-      
-      memset(&var, 0, sizeof(var));
-      if(!mode_option || 
-	 !fb_find_mode(&var, &fb_info.fb_info, mode_option, NULL, 0, NULL, 8))
-	var = default_mode[0].var;
-      
-      if(noaccel) var.accel_flags &= ~FB_ACCELF_TEXT;
-      else var.accel_flags |= FB_ACCELF_TEXT;
-      
-      if(tdfxfb_decode_var(&var, &fb_info.default_par, &fb_info)) {
-	/* ugh -- can't use the mode from the mode db. (or command line),
-	   so try the default */
-
-	printk("tdfxfb: "
-	       "can't decode the supplied video mode, using default\n");
-
-	var = default_mode[0].var;
-	if(noaccel) var.accel_flags &= ~FB_ACCELF_TEXT;
-	else var.accel_flags |= FB_ACCELF_TEXT;
+	strcpy(fb_info.fb_info.modename, "3Dfx "); 
+	strcat(fb_info.fb_info.modename, name);
+	fb_info.fb_info.changevar  = NULL;
+	fb_info.fb_info.node       = -1;
+	fb_info.fb_info.fbops      = &tdfxfb_ops;
+	fb_info.fb_info.disp       = &fb_info.disp;
+	strcpy(fb_info.fb_info.fontname, fontname);
+	fb_info.fb_info.switch_con = &tdfxfb_switch_con;
+	fb_info.fb_info.updatevar  = &tdfxfb_updatevar;
+	fb_info.fb_info.blank      = &tdfxfb_blank;
+	fb_info.fb_info.flags      = FBINFO_FLAG_DEFAULT;
       
-	if(tdfxfb_decode_var(&var, &fb_info.default_par, &fb_info)) {
-	  /* this is getting really bad!... */
-	  printk("tdfxfb: can't decode default video mode\n");
-	  return -ENXIO;
+	memset(&var, 0, sizeof(var));
+	
+	if (!mode_option || !fb_find_mode(&var, &fb_info.fb_info,
+					  mode_option, NULL, 0, NULL, 8))
+		var = default_mode[0].var;
+
+	noaccel ? (var.accel_flags &= ~FB_ACCELF_TEXT) :
+		  (var.accel_flags |=  FB_ACCELF_TEXT) ;
+
+	if (tdfxfb_decode_var(&var, &fb_info.default_par, &fb_info)) {
+		/* 
+		 * ugh -- can't use the mode from the mode db. (or command
+		 * line), so try the default
+		 */
+
+		printk(KERN_NOTICE "tdfxfb: can't decode the supplied video mode, using default\n");
+
+		var = default_mode[0].var;
+
+		noaccel ? (var.accel_flags &= ~FB_ACCELF_TEXT) :
+			  (var.accel_flags |=  FB_ACCELF_TEXT) ;
+
+		if (tdfxfb_decode_var(&var, &fb_info.default_par, &fb_info)) {
+			/* this is getting really bad!... */
+			printk(KERN_WARNING "tdfxfb: can't decode default video mode\n");
+			return -ENXIO;
+		}
 	}
-      }
-      
-      fb_info.disp.screen_base    = fb_info.bufbase_virt;
-      fb_info.disp.var            = var;
-      
-      if(tdfxfb_set_var(&var, -1, &fb_info.fb_info)) {
-	printk("tdfxfb: can't set default video mode\n");
-	return -ENXIO;
-      }
-      
-      if(register_framebuffer(&fb_info.fb_info) < 0) {
-	printk("tdfxfb: can't register framebuffer\n");
-	return -ENXIO;
-      }
 
-      printk("fb%d: %s frame buffer device\n", 
-	     GET_FB_IDX(fb_info.fb_info.node),
-	     fb_info.fb_info.modename);
+	fb_info.disp.screen_base = fb_info.bufbase_virt;
+	fb_info.disp.var         = var;
       
-      /* FIXME: module cannot be unloaded */
-      /* verify tdfxfb_exit before removing this */
-      MOD_INC_USE_COUNT;
-      
-      return 0;
-    }
-  }
+	if (tdfxfb_set_var(&var, -1, &fb_info.fb_info)) {
+		printk(KERN_WARNING "tdfxfb: can't set default video mode\n");
+		return -ENXIO;
+	}
 
-  /* hmm, no frame suitable buffer found ... */
-  return -ENXIO;
+	if (register_framebuffer(&fb_info.fb_info) < 0) {
+		printk(KERN_WARNING "tdfxfb: can't register framebuffer\n");
+		return -ENXIO;
+	}
+
+	printk(KERN_INFO "fb%d: %s frame buffer device\n", 
+	     GET_FB_IDX(fb_info.fb_info.node), fb_info.fb_info.modename);
+      
+  	return 0;
 }
 
 /**
- *	tdfxfb_exit - Driver cleanup
+ *	tdfxfb_remove - Device removal
+ *
+ * 	@pdev:	PCI Device to cleanup
  *
- *	Releases all resources allocated during the
- *	course of the driver's lifetime.
+ *	Releases all resources allocated during the course of the driver's
+ *	lifetime for the PCI device @pdev.
  *
- *	FIXME - do results of fb_alloc_cmap need disposal?
  */
-static void __exit tdfxfb_exit (void)
+static void __devexit tdfxfb_remove(struct pci_dev *pdev)
 {
 	unregister_framebuffer(&fb_info.fb_info);
 	del_timer_sync(&fb_info.cursor.timer);
@@ -2036,7 +2049,7 @@
 #ifdef CONFIG_MTRR
        if (!nomtrr) {
           mtrr_del(fb_info.mtrr_idx, fb_info.bufbase_phys, fb_info.bufbase_size);
-	    printk("fb: MTRR's  turned off\n");
+	    printk("fb: MTRR's turned off\n");
        }
 #endif
 
@@ -2044,6 +2057,16 @@
 	iounmap(fb_info.bufbase_virt);
 }
 
+int __init tdfxfb_init(void)
+{
+	return pci_module_init(&tdfxfb_driver);
+}
+
+static void __exit tdfxfb_exit(void)
+{
+	pci_unregister_driver(&tdfxfb_driver);
+}
+
 MODULE_AUTHOR("Hannu Mallat <hmallat@cc.hut.fi>");
 MODULE_DESCRIPTION("3Dfx framebuffer device driver");
 
@@ -2212,7 +2235,9 @@
 			    unsigned        transp,
 			    struct fb_info* info) {
    struct fb_info_tdfx* i = (struct fb_info_tdfx*)info;
+#ifdef FBCON_HAS_CFB8   
    u32 rgbcol;
+#endif
    if (regno >= i->current_par.cmap_len) return 1;
    
    i->palette[regno].red    = red;

--VS++wcV0S1rZb1Fb--
