Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261464AbTL1O3k (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Dec 2003 09:29:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261492AbTL1O3k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Dec 2003 09:29:40 -0500
Received: from smtp.hccnet.nl ([62.251.0.13]:27787 "EHLO smtp.hccnet.nl")
	by vger.kernel.org with ESMTP id S261464AbTL1O3e (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Dec 2003 09:29:34 -0500
Message-ID: <3FEEE8C1.9080102@iae.nl>
Date: Sun, 28 Dec 2003 15:29:21 +0100
From: Jan Evert van Grootheest <janevert@iae.nl>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031107 Debian/1.5-3
X-Accept-Language: en-us, en, nl, ru
MIME-Version: 1.0
To: andre@linux-ide.org, linux-kernel@vger.kernel.org,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Subject: ht6560b patch for 2.4 (and 2.6?)
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andre,

You're listed as the IDE maintainer for 2.4.
I'm one of the few people that own one of those Holtek 6560B VLB IDE 
interfaces.

Here's a patch against 2.4.23 that at least allows the kernel to boot 
when using the driver. Without this patch it simply hangs somewhere 
during early initialisation.

I won't be surprised if a comparable patch is required for 2.6, although 
I have not checked whether it applies. (I have no 2.6 sources yet)

This is my first kernel patch so if there is something not in order 
please let me know.

Thanks,
Jan Evert van Grootheest
janevert@iae.nl

--- 
../../pristine/kernel-source-2.4.23-fswan-lmsens/drivers/ide/legacy/ht6560b.c 
       2003-06-13 16:51:33.000000000 +0200
+++ drivers/ide/legacy/ht6560b.c        2003-12-28 15:03:01.000000000 +0100
@@ -23,6 +23,20 @@
   *                      "Prefetch" mode bit OFF for ide disks and
   *                      ON for anything else.
   *
+ *  version 8          (dropped useless 0. from version)
+ *                     Jan Evert van Grootheest   <janevert@iae.nl>
+ *                     - Removed Mikko as maintainer; he admits to no 
longer
+ *                       having the proper hardware. Also the URL no longer
+ *                       works.
+ *                     - Fix things for 2.4 kernels.
+ *                     - Rename probe_ht6560b to setup_ht6560b; there's np
+ *                       probing there because that's done in try_to_init.
+ *                       So that one's been renamed to probe_
+ *                     - Remove the use of check_region(); patch from 
William
+ *                       Stinson that he made as part of kernel 
janitors for
+ *                       2.6
+ *                     - this driver is not tested (by me) as module!
+ *
   *
   *  HT-6560B EIDE-controller support
   *  To activate controller support use kernel parameter "ide0=ht6560b".
@@ -30,11 +44,9 @@
   *
   *  Author:    Mikko Ala-Fossi            <maf@iki.fi>
   *             Jan Evert van Grootheest   <janevert@iae.nl>
- *
- *  Try:  http://www.maf.iki.fi/~maf/ht6560b/
   */

-#define HT6560B_VERSION "v0.07"
+#define HT6560B_VERSION "v8"

  #undef REALLY_SLOW_IO          /* most systems can safely undef this */

@@ -173,7 +185,7 @@
  /*
   * Autodetection and initialization of ht6560b
   */
-static int __init try_to_init_ht6560b(void)
+static int __init probe_ht6560b(void)
  {
         u8 orig_value;
         int i;
@@ -194,6 +206,7 @@
                 outb(orig_value, HT_CONFIG_PORT);
                 return 0;
         }
+
         /*
          * Ht6560b autodetected
          */
@@ -312,11 +325,10 @@
  #endif
  }

-void __init probe_ht6560b (void)
+void __init setup_ht6560b (void)
  {
         int t;

-       request_region(HT_CONFIG_PORT, 1, ide_hwifs[0].name);
         ide_hwifs[0].chipset = ide_ht6560b;
         ide_hwifs[1].chipset = ide_ht6560b;
         ide_hwifs[0].selectproc = &ht6560b_selectproc;
@@ -371,6 +383,36 @@
         release_region(HT_CONFIG_PORT, 1);
  }

+
+#ifndef MODULE
+void __init ide_probe_for_ht6560b(void)
+#else
+int ide_probe_for_ht6560b(void)
+#endif
+{
+       if (!request_region(HT_CONFIG_PORT, 1, ide_hwifs[0].name)) {
+               printk(KERN_NOTICE "%s: HT_CONFIG_PORT not found\n", 
__FUNCTION__);
+       }
+       else if (!probe_ht6560b()) {
+               release_region(HT_CONFIG_PORT, 1);
+                printk(KERN_NOTICE "%s: HBA not found\n", __FUNCTION__);
+       }
+       else {
+               printk("\ndebug %d", __LINE__);
+               setup_ht6560b();
+               printk("\ndebug %d", __LINE__);
+#ifdef MODULE
+               return 1;
+#endif
+       }
+
+#ifdef MODULE
+       return 0;
+#endif
+}
+
+
+
  #ifndef MODULE
  /*
   * init_ht6560b:
@@ -380,16 +422,7 @@

  void __init init_ht6560b (void)
  {
-       if (check_region(HT_CONFIG_PORT,1)) {
-               printk(KERN_NOTICE "%s: HT_CONFIG_PORT not found\n",
-                       __FUNCTION__);
-               return;
-       }
-       if (!try_to_init_ht6560b()) {
-                printk(KERN_NOTICE "%s: HBA not found\n", __FUNCTION__);
-               return;
-       }
-       probe_ht6560b();
+       ide_register_driver(ide_probe_for_ht6560b);
  }

  #else
@@ -400,23 +433,15 @@

  int __init ht6560b_mod_init(void)
  {
-       if (check_region(HT_CONFIG_PORT,1)) {
-               printk(KERN_NOTICE "%s: HT_CONFIG_PORT not found\n",
-                       __FUNCTION__);
+       if (!ide_probe_for_ht6560b())
                 return -ENODEV;
-       }
-
-       if (!try_to_init_ht6560b()) {
-               printk(KERN_NOTICE "%s: HBA not found\n", __FUNCTION__);
-               return -ENODEV;
-       }
-
-       probe_ht6560b();
+
          if (ide_hwifs[0].chipset != ide_ht6560b &&
              ide_hwifs[1].chipset != ide_ht6560b) {
                  ht6560b_release();
                  return -ENODEV;
-        }
+       }
+
          return 0;
  }
  module_init(ht6560b_mod_init);

