Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265236AbTLKUZm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Dec 2003 15:25:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265240AbTLKUZm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Dec 2003 15:25:42 -0500
Received: from cpe.atm2-0-1071046.0x50a5258e.abnxx8.customer.tele.dk ([80.165.37.142]:62624
	"EHLO starbattle.com") by vger.kernel.org with ESMTP
	id S265236AbTLKUZj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Dec 2003 15:25:39 -0500
From: Daniel Tram Lux <daniel@starbattle.com>
Date: Thu, 11 Dec 2003 21:25:36 +0100
To: linux-kernel@vger.kernel.org
Subject: [patch] ide.c as a module
Message-ID: <20031211202536.GA10529@starbattle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I needed the ide-subsytem as a module on 2.4.23 and noticed (due to the missing modprobe on the embedded linux system)
that ide.c tries to load the module ide-probe-mod which is called ide-detect now.
The patch also get's rid of the need for ide-probe-mini alias ide-detect, but I don't know if that is desired? (it was in my case).

Regards

Daniel Lux

P.S.
please c/c me for comments. 

--- linux-2.4.23.org/drivers/ide/ide.c  2003-11-28 19:26:20.000000000 +0100
+++ linux-2.4.23/drivers/ide/ide.c      2004-03-11 20:31:51.000000000 +0100
@@ -514,11 +514,7 @@

 void ide_probe_module (int revaldiate)
 {
-       if (!ide_probe) {
-#if  defined(CONFIG_BLK_DEV_IDE_MODULE)
-               (void) request_module("ide-probe-mod");
-#endif
-       } else {
+       if (ide_probe) {
                (void) ide_probe->init();
        }
        revalidate_drives(revaldiate);
@@ -3018,13 +3014,13 @@
                banner_printed = 1;
        }

+       initializing = 1;
        init_ide_data();

 #ifndef CLASSIC_BUILTINS_METHOD
        ide_init_builtin_subdrivers();
 #endif /* CLASSIC_BUILTINS_METHOD */

-       initializing = 1;
        ide_init_builtin_drivers();
        initializing = 0;

@@ -3043,6 +3039,9 @@
 MODULE_PARM(options,"s");
 MODULE_LICENSE("GPL");

+extern int ideprobe_init_module();
+extern void ideprobe_cleanup_module (void);
+
 static void __init parse_options (char *line)
 {
        char *next = line;
@@ -3059,14 +3058,19 @@

 int init_module (void)
 {
+        int res;
+
        parse_options(options);
-       return ide_init();
+       res = ide_init();
+       ideprobe_init_module();
+       return(res);
 }

 void cleanup_module (void)
 {
        int index;
-
+
+       ideprobe_cleanup_module();
        unregister_reboot_notifier(&ide_notifier);
        for (index = 0; index < MAX_HWIFS; ++index) {
                ide_unregister(index);

