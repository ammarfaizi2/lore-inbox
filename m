Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132680AbRDUOy1>; Sat, 21 Apr 2001 10:54:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132682AbRDUOyS>; Sat, 21 Apr 2001 10:54:18 -0400
Received: from off.net ([64.39.30.25]:16136 "HELO erasmus.off.net")
	by vger.kernel.org with SMTP id <S132680AbRDUOyN>;
	Sat, 21 Apr 2001 10:54:13 -0400
Date: Sat, 21 Apr 2001 10:54:13 -0400
From: Zach Brown <zab@zabbo.net>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org, maestro-users@zabbo.net
Subject: [PATCH] maestro3 2.4.4-pre5 fixes
Message-ID: <20010421105413.B8818@erasmus.off.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The maestro3 driver has a error cleanup bug that would leave its reboot
notifier registerd after exiting init_module with an error.  Bayad.
It also had a minor bug where it didn't explicitly set the codec->id
before probing..

this patch vs 2.4.4-pre5 (I hope, its really vs jeff's cvs :)) fixes both.

Linus, please apply.

-- 
 zach

Index: maestro3.c
===================================================================
RCS file: /cvsroot/gkernel/linux_2_4/drivers/sound/maestro3.c,v
retrieving revision 1.1.1.24.6.1
diff -u -r1.1.1.24.6.1 maestro3.c
--- maestro3.c	2001/04/20 01:40:38	1.1.1.24.6.1
+++ maestro3.c	2001/04/21 14:36:21
@@ -2307,6 +2307,8 @@
     codec->private_data = card;
     codec->codec_read = m3_ac97_read;
     codec->codec_write = m3_ac97_write;
+    /* someday we should support secondary codecs.. */
+    codec->id = 0;
 
     if (ac97_probe_codec(codec) == 0) {
         printk(KERN_ERR PFX "codec probe failed\n");
@@ -2933,6 +2935,7 @@
 
     if (!pci_register_driver(&m3_pci_driver)) {
         pci_unregister_driver(&m3_pci_driver);
+        unregister_reboot_notifier(&m3_reboot_nb);
         return -ENODEV;
     }
     return 0;
