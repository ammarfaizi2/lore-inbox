Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270141AbUJSXQw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270141AbUJSXQw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 19:16:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270109AbUJSXQp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 19:16:45 -0400
Received: from mail.kroah.org ([69.55.234.183]:23946 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S270177AbUJSWqo convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 18:46:44 -0400
X-Fake: the user-agent is fake
Subject: Re: [PATCH] PCI fixes for 2.6.9
User-Agent: Mutt/1.5.6i
In-Reply-To: <10982257392211@kroah.com>
Date: Tue, 19 Oct 2004 15:42:19 -0700
Message-Id: <1098225739969@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1997.37.61, 2004/10/06 14:07:54-07:00, greg@kroah.com

[PATCH] PCI: audit all callers of pci_register_driver() to work properly.

No, pci_register_driver() does not return the number of pci devices found, sorry.
No, if pci_register_driver() fails, you do not need to call pci_unregister_driver().

Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/atm/eni.c                   |    4 +---
 drivers/atm/firestream.c            |   12 ++----------
 drivers/atm/idt77252.c              |    6 +-----
 drivers/block/cpqarray.c            |    4 ++--
 drivers/char/epca.c                 |   13 +------------
 drivers/isdn/hisax/hisax_fcpcipnp.c |   12 +-----------
 drivers/misc/ibmasm/module.c        |    6 +++---
 drivers/net/dgrs.c                  |    4 ++--
 drivers/net/hamachi.c               |    5 +----
 drivers/net/irda/via-ircc.c         |   10 +---------
 drivers/net/tokenring/abyss.c       |    9 +--------
 drivers/net/tokenring/tmspci.c      |    9 +--------
 drivers/parport/parport_pc.c        |    8 ++++----
 drivers/video/i810/i810_main.c      |   10 ++--------
 drivers/video/riva/fbdev.c          |    5 +----
 sound/oss/ali5455.c                 |    6 +-----
 sound/oss/esssolo1.c                |    6 +-----
 sound/oss/forte.c                   |    7 +------
 sound/oss/i810_audio.c              |   10 ++++++----
 sound/oss/maestro3.c                |    3 +--
 sound/oss/trident.c                 |    6 +-----
 sound/oss/via82cxxx_audio.c         |    8 +++-----
 22 files changed, 38 insertions(+), 125 deletions(-)


diff -Nru a/drivers/atm/eni.c b/drivers/atm/eni.c
--- a/drivers/atm/eni.c	2004-10-19 15:21:57 -07:00
+++ b/drivers/atm/eni.c	2004-10-19 15:21:57 -07:00
@@ -2290,9 +2290,7 @@
 		    sizeof(skb->cb),sizeof(struct eni_skb_prv));
 		return -EIO;
 	}
-	if (pci_register_driver(&eni_driver) > 0) return 0;
-	pci_unregister_driver (&eni_driver);
-	return -ENODEV;
+	return pci_register_driver(&eni_driver);
 }
 
 
diff -Nru a/drivers/atm/firestream.c b/drivers/atm/firestream.c
--- a/drivers/atm/firestream.c	2004-10-19 15:21:57 -07:00
+++ b/drivers/atm/firestream.c	2004-10-19 15:21:57 -07:00
@@ -2045,7 +2045,6 @@
 int __init init_PCI (void)
 { /* Begin init_PCI */
 	
-	int pci_count;
 	printk ("init_PCI\n");
 	/*
 	  memset (&firestream_driver, 0, sizeof (firestream_driver));
@@ -2053,15 +2052,7 @@
 	  firestream_driver.id_table = firestream_pci_tbl;
 	  firestream_driver.probe = fs_register_and_init;
 	*/
-	pci_count = pci_register_driver (&firestream_driver);
-	
-	if (pci_count <= 0) {
-		pci_unregister_driver (&firestream_driver);
-		pci_count = 0;
-	}
-
-	return(pci_count);
-
+	return pci_register_driver(&firestream_driver);
 } /* End init_PCI */
 #endif
 #endif
@@ -2108,5 +2099,6 @@
 module_exit(firestream_cleanup_module);
 
 MODULE_LICENSE("GPL");
+
 
 
diff -Nru a/drivers/atm/idt77252.c b/drivers/atm/idt77252.c
--- a/drivers/atm/idt77252.c	2004-10-19 15:21:57 -07:00
+++ b/drivers/atm/idt77252.c	2004-10-19 15:21:57 -07:00
@@ -3841,11 +3841,7 @@
 		return -EIO;
 	}
 
-	if (pci_register_driver(&idt77252_driver) > 0)
-		return 0;
-
-	pci_unregister_driver(&idt77252_driver);
-	return -ENODEV;
+	return pci_register_driver(&idt77252_driver);
 }
 
 static void __exit idt77252_exit(void)
diff -Nru a/drivers/block/cpqarray.c b/drivers/block/cpqarray.c
--- a/drivers/block/cpqarray.c	2004-10-19 15:21:57 -07:00
+++ b/drivers/block/cpqarray.c	2004-10-19 15:21:57 -07:00
@@ -569,9 +569,9 @@
 
 	/* detect controllers */
 	printk(DRIVER_NAME "\n");
-/* TODO: If it's an eisa only system, will rc return negative? */
+
 	rc = pci_register_driver(&cpqarray_pci_driver);
-	if (rc < 0)
+	if (rc)
 		return rc;
 	cpqarray_eisa_detect();
 	
diff -Nru a/drivers/char/epca.c b/drivers/char/epca.c
--- a/drivers/char/epca.c	2004-10-19 15:21:57 -07:00
+++ b/drivers/char/epca.c	2004-10-19 15:21:57 -07:00
@@ -3933,23 +3933,12 @@
 
 int __init init_PCI (void)
 { /* Begin init_PCI */
-	
-	int pci_count;
-	
 	memset (&epca_driver, 0, sizeof (epca_driver));
 	epca_driver.name = "epca";
 	epca_driver.id_table = epca_pci_tbl;
 	epca_driver.probe = epca_init_one;
 
-	pci_count = pci_register_driver (&epca_driver);
-	
-	if (pci_count <= 0) {
-		pci_unregister_driver (&epca_driver);
-		pci_count = 0;
-	}
-
-	return(pci_count);
-
+	return pci_register_driver(&epca_driver);
 } /* End init_PCI */
 
 #endif /* ENABLE_PCI */
diff -Nru a/drivers/isdn/hisax/hisax_fcpcipnp.c b/drivers/isdn/hisax/hisax_fcpcipnp.c
--- a/drivers/isdn/hisax/hisax_fcpcipnp.c	2004-10-19 15:21:57 -07:00
+++ b/drivers/isdn/hisax/hisax_fcpcipnp.c	2004-10-19 15:21:57 -07:00
@@ -1001,22 +1001,12 @@
 	printk(KERN_INFO "hisax_fcpcipnp: Fritz!Card PCI/PCIv2/PnP ISDN driver v0.0.1\n");
 
 	retval = pci_register_driver(&fcpci_driver);
-	if (retval < 0)
+	if (retval)
 		goto out;
-	pci_nr_found = retval;
-	retval = 0;
-
 #ifdef __ISAPNP__
 	retval = pnp_register_driver(&fcpnp_driver);
 	if (retval < 0)
 		goto out_unregister_pci;
-#endif
-
-#if !defined(CONFIG_HOTPLUG) || defined(MODULE)
-	if (pci_nr_found + retval == 0) {
-		retval = -ENODEV;
-		goto out_unregister_isapnp;
-	}
 #endif
 	return 0;
 
diff -Nru a/drivers/misc/ibmasm/module.c b/drivers/misc/ibmasm/module.c
--- a/drivers/misc/ibmasm/module.c	2004-10-19 15:21:57 -07:00
+++ b/drivers/misc/ibmasm/module.c	2004-10-19 15:21:57 -07:00
@@ -209,10 +209,9 @@
 		return result;
 	}
 	result = pci_register_driver(&ibmasm_driver);
-	if (result <= 0) {
-		pci_unregister_driver(&ibmasm_driver);
+	if (result) {
 		ibmasmfs_unregister();
-		return -ENODEV;
+		return result;
 	}
 	ibmasm_register_panic_notifier();
 	info(DRIVER_DESC " version " DRIVER_VERSION " loaded");
@@ -225,3 +224,4 @@
 MODULE_AUTHOR(DRIVER_AUTHOR);
 MODULE_DESCRIPTION(DRIVER_DESC);
 MODULE_LICENSE("GPL");
+
diff -Nru a/drivers/net/dgrs.c b/drivers/net/dgrs.c
--- a/drivers/net/dgrs.c	2004-10-19 15:21:57 -07:00
+++ b/drivers/net/dgrs.c	2004-10-19 15:21:57 -07:00
@@ -1597,10 +1597,10 @@
 #endif
 #ifdef CONFIG_PCI
 	pcicount = pci_register_driver(&dgrs_pci_driver);
-	if (pcicount < 0)
+	if (pcicount)
 		return pcicount;
 #endif
-	return (eisacount + pcicount) == 0 ? -ENODEV : 0;
+	return 0;
 }
 
 static void __exit dgrs_cleanup_module (void)
diff -Nru a/drivers/net/hamachi.c b/drivers/net/hamachi.c
--- a/drivers/net/hamachi.c	2004-10-19 15:21:57 -07:00
+++ b/drivers/net/hamachi.c	2004-10-19 15:21:57 -07:00
@@ -2009,10 +2009,7 @@
 #ifdef MODULE
 	printk(version);
 #endif
-	if (pci_register_driver(&hamachi_driver) > 0)
-		return 0;
-	pci_unregister_driver(&hamachi_driver);
-	return -ENODEV;
+	return pci_register_driver(&hamachi_driver);
 }
 
 static void __exit hamachi_exit (void)
diff -Nru a/drivers/net/irda/via-ircc.c b/drivers/net/irda/via-ircc.c
--- a/drivers/net/irda/via-ircc.c	2004-10-19 15:21:57 -07:00
+++ b/drivers/net/irda/via-ircc.c	2004-10-19 15:21:57 -07:00
@@ -157,15 +157,7 @@
 #ifdef	HEADMSG
         DBG(printk(KERN_INFO "via_ircc_init :rc = %d......\n",rc));
 #endif
-	if (rc < 1) {
-#ifdef	HEADMSG
-        DBG(printk(KERN_INFO "via_ircc_init return -ENODEV......\n"));
-#endif
-		if (rc == 0)	pci_unregister_driver (&via_driver);
-		return -ENODEV;
-	}
-	return 0;
-
+	return rc;
 }
 
 static int __devinit via_init_one (struct pci_dev *pcidev, const struct pci_device_id *id)
diff -Nru a/drivers/net/tokenring/abyss.c b/drivers/net/tokenring/abyss.c
--- a/drivers/net/tokenring/abyss.c	2004-10-19 15:21:57 -07:00
+++ b/drivers/net/tokenring/abyss.c	2004-10-19 15:21:57 -07:00
@@ -457,14 +457,7 @@
 
 static int __init abyss_init (void)
 {
-	int rc = pci_register_driver (&abyss_driver);
-	if (rc < 0)
-		return rc;
-	if (rc == 0) {
-		pci_unregister_driver (&abyss_driver);
-		return -ENODEV;
-	}
-	return 0;
+	return pci_register_driver(&abyss_driver);
 }
 
 static void __exit abyss_rmmod (void)
diff -Nru a/drivers/net/tokenring/tmspci.c b/drivers/net/tokenring/tmspci.c
--- a/drivers/net/tokenring/tmspci.c	2004-10-19 15:21:57 -07:00
+++ b/drivers/net/tokenring/tmspci.c	2004-10-19 15:21:57 -07:00
@@ -243,14 +243,7 @@
 
 static int __init tms_pci_init (void)
 {
-	int rc = pci_register_driver (&tms_pci_driver);
-	if (rc < 0)
-		return rc;
-	if (rc == 0) {
-		pci_unregister_driver (&tms_pci_driver);
-		return -ENODEV;
-	}
-	return 0;
+	return pci_register_driver(&tms_pci_driver);
 }
 
 static void __exit tms_pci_rmmod (void)
diff -Nru a/drivers/parport/parport_pc.c b/drivers/parport/parport_pc.c
--- a/drivers/parport/parport_pc.c	2004-10-19 15:21:57 -07:00
+++ b/drivers/parport/parport_pc.c	2004-10-19 15:21:57 -07:00
@@ -3039,10 +3039,10 @@
 	count += parport_pc_find_nonpci_ports (autoirq, autodma);
 
 	r = pci_register_driver (&parport_pc_pci_driver);
-	if (r >= 0) {
-		pci_registered_parport = 1;
-		count += r;
-	}
+	if (r)
+		return r;
+	pci_registered_parport = 1;
+	count += 1;
 
 	return count;
 }
diff -Nru a/drivers/video/i810/i810_main.c b/drivers/video/i810/i810_main.c
--- a/drivers/video/i810/i810_main.c	2004-10-19 15:21:57 -07:00
+++ b/drivers/video/i810/i810_main.c	2004-10-19 15:21:57 -07:00
@@ -1995,10 +1995,7 @@
 		return -ENODEV;
 	i810fb_setup(option);
 
-	if (pci_register_driver(&i810fb_driver) > 0)
-		return 0;
-	pci_unregister_driver(&i810fb_driver);
-	return -ENODEV;
+	return pci_register_driver(&i810fb_driver);
 }
 #endif 
 
@@ -2013,10 +2010,7 @@
 	hsync1 *= 1000;
 	hsync2 *= 1000;
 
-	if (pci_register_driver(&i810fb_driver) > 0)
-		return 0;
-	pci_unregister_driver(&i810fb_driver);
-	return -ENODEV;
+	return pci_register_driver(&i810fb_driver);
 }
 
 MODULE_PARM(vram, "i");
diff -Nru a/drivers/video/riva/fbdev.c b/drivers/video/riva/fbdev.c
--- a/drivers/video/riva/fbdev.c	2004-10-19 15:21:57 -07:00
+++ b/drivers/video/riva/fbdev.c	2004-10-19 15:21:57 -07:00
@@ -2147,10 +2147,7 @@
 		return -ENODEV;
 	rivafb_setup(option);
 #endif
-	if (pci_register_driver(&rivafb_driver) > 0)
-		return 0;
-	pci_unregister_driver(&rivafb_driver);
-	return -ENODEV;
+	return pci_register_driver(&rivafb_driver);
 }
 
 
diff -Nru a/sound/oss/ali5455.c b/sound/oss/ali5455.c
--- a/sound/oss/ali5455.c	2004-10-19 15:21:57 -07:00
+++ b/sound/oss/ali5455.c	2004-10-19 15:21:57 -07:00
@@ -3713,11 +3713,7 @@
 			controller_pcmout_share_spdif_locked = 0;
 		}
 	}
-	if (!pci_register_driver(&ali_pci_driver)) {
-		pci_unregister_driver(&ali_pci_driver);
-		return -ENODEV;
-	}
-	return 0;
+	return pci_register_driver(&ali_pci_driver);
 }
 
 static void __exit ali_cleanup_module(void)
diff -Nru a/sound/oss/esssolo1.c b/sound/oss/esssolo1.c
--- a/sound/oss/esssolo1.c	2004-10-19 15:21:57 -07:00
+++ b/sound/oss/esssolo1.c	2004-10-19 15:21:57 -07:00
@@ -2451,11 +2451,7 @@
 static int __init init_solo1(void)
 {
 	printk(KERN_INFO "solo1: version v0.20 time " __TIME__ " " __DATE__ "\n");
-	if (!pci_register_driver(&solo1_driver)) {
-		pci_unregister_driver(&solo1_driver);
-                return -ENODEV;
-	}
-	return 0;
+	return pci_register_driver(&solo1_driver);
 }
 
 /* --------------------------------------------------------------------- */
diff -Nru a/sound/oss/forte.c b/sound/oss/forte.c
--- a/sound/oss/forte.c	2004-10-19 15:21:57 -07:00
+++ b/sound/oss/forte.c	2004-10-19 15:21:57 -07:00
@@ -2111,12 +2111,7 @@
 {
 	printk (KERN_INFO PFX DRIVER_VERSION "\n");
 
-	if (!pci_register_driver (&forte_pci_driver)) {
-		pci_unregister_driver (&forte_pci_driver);
-		return -ENODEV;
-	}
-
-	return 0;
+	return pci_register_driver (&forte_pci_driver);
 }
 
 
diff -Nru a/sound/oss/i810_audio.c b/sound/oss/i810_audio.c
--- a/sound/oss/i810_audio.c	2004-10-19 15:21:57 -07:00
+++ b/sound/oss/i810_audio.c	2004-10-19 15:21:57 -07:00
@@ -3483,13 +3483,15 @@
 
 static int __init i810_init_module (void)
 {
+	int retval;
+
 	printk(KERN_INFO "Intel 810 + AC97 Audio, version "
 	       DRIVER_VERSION ", " __TIME__ " " __DATE__ "\n");
 
-	if (!pci_register_driver(&i810_pci_driver)) {
-		pci_unregister_driver(&i810_pci_driver);
-                return -ENODEV;
-	}
+	retval = pci_register_driver(&i810_pci_driver);
+	if (retval)
+		return retval;
+
 	if(ftsodell != 0) {
 		printk("i810_audio: ftsodell is now a deprecated option.\n");
 	}
diff -Nru a/sound/oss/maestro3.c b/sound/oss/maestro3.c
--- a/sound/oss/maestro3.c	2004-10-19 15:21:57 -07:00
+++ b/sound/oss/maestro3.c	2004-10-19 15:21:57 -07:00
@@ -2940,8 +2940,7 @@
         return -ENODEV; /* ? */
     }
 
-    if (!pci_register_driver(&m3_pci_driver)) {
-        pci_unregister_driver(&m3_pci_driver);
+    if (pci_register_driver(&m3_pci_driver)) {
         unregister_reboot_notifier(&m3_reboot_nb);
         return -ENODEV;
     }
diff -Nru a/sound/oss/trident.c b/sound/oss/trident.c
--- a/sound/oss/trident.c	2004-10-19 15:21:57 -07:00
+++ b/sound/oss/trident.c	2004-10-19 15:21:57 -07:00
@@ -4594,11 +4594,7 @@
 	       "5050 PCI Audio, version " DRIVER_VERSION ", " __TIME__ " " 
 	       __DATE__ "\n");
 
-	if (!pci_register_driver(&trident_pci_driver)) {
-		pci_unregister_driver(&trident_pci_driver);
-		return -ENODEV;
-	}
-	return 0;
+	return pci_register_driver(&trident_pci_driver);
 }
 
 static void __exit
diff -Nru a/sound/oss/via82cxxx_audio.c b/sound/oss/via82cxxx_audio.c
--- a/sound/oss/via82cxxx_audio.c	2004-10-19 15:21:57 -07:00
+++ b/sound/oss/via82cxxx_audio.c	2004-10-19 15:21:57 -07:00
@@ -3622,12 +3622,10 @@
 	}
 
 	rc = pci_register_driver (&via_driver);
-	if (rc < 1) {
-		if (rc == 0)
-			pci_unregister_driver (&via_driver);
+	if (rc) {
 		via_cleanup_proc ();
-		DPRINTK ("EXIT, returning -ENODEV\n");
-		return -ENODEV;
+		DPRINTK ("EXIT, returning %d\n", rc);
+		return rc;
 	}
 
 	DPRINTK ("EXIT, returning 0\n");

