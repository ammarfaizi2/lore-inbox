Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263443AbTHXLjw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Aug 2003 07:39:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263457AbTHXLjv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Aug 2003 07:39:51 -0400
Received: from mail2.sonytel.be ([195.0.45.172]:62349 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S263443AbTHXLjt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Aug 2003 07:39:49 -0400
Date: Sun, 24 Aug 2003 13:39:39 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Javier Achirica <achirica@telefonica.net>
cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: [PATCH] airo (was: Re: Linux 2.6.0-test4)
In-Reply-To: <Pine.LNX.4.44.0308221732170.4677-100000@home.osdl.org>
Message-ID: <Pine.GSO.4.21.0308241249210.14076-100000@waterleaf.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Aug 2003, Linus Torvalds wrote:
> Javier Achirica:
>   o [wireless airo] Fix PCI unregister code

This patch causes a regression: if CONFIG_PCI is not set, it doesn't compile
anymore. Here's a fix. I also killed a dead variable and its corresponding
warning:

--- linux-2.6.0-test4/drivers/net/wireless/airo.c	Sun Aug 24 09:49:30 2003
+++ linux-m68k-2.6.0-test4/drivers/net/wireless/airo.c	Sun Aug 24 13:03:56 2003
@@ -4156,7 +4156,7 @@
 
 static int __init airo_init_module( void )
 {
-	int i, rc = 0, have_isa_dev = 0;
+	int i, have_isa_dev = 0;
 
 	airo_entry = create_proc_entry("aironet",
 				       S_IFDIR | airo_perm,
@@ -4174,7 +4174,7 @@
 
 #ifdef CONFIG_PCI
 	printk( KERN_INFO "airo:  Probing for PCI adapters\n" );
-	rc = pci_module_init(&airo_driver);
+	pci_module_init(&airo_driver);
 	printk( KERN_INFO "airo:  Finished probing for PCI adapters\n" );
 #endif
 
@@ -4197,8 +4197,11 @@
 	}
 	remove_proc_entry("aironet", proc_root_driver);
 
-	if (is_pci)
+	if (is_pci) {
+#ifdef CONFIG_PCI
 		pci_unregister_driver(&airo_driver);
+#endif
+	}
 }
 
 #ifdef WIRELESS_EXT

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


