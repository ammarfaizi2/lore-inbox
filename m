Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267364AbUITVT6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267364AbUITVT6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Sep 2004 17:19:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267363AbUITVT6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Sep 2004 17:19:58 -0400
Received: from mail.dif.dk ([193.138.115.101]:17056 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S267364AbUITVTz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Sep 2004 17:19:55 -0400
Date: Mon, 20 Sep 2004 23:26:38 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: David Woodhouse <dwmw2@redhat.com>
Cc: linux-mtd <linux-mtd@lists.infradead.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] attempt to fix warnings in dilnetpc.c
Message-ID: <Pine.LNX.4.61.0409202320270.2729@dragon.hygekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

I see these warnings when building 2.6.9-rc2-bk5 allyesconfig :

  CC      drivers/mtd/maps/dilnetpc.o
drivers/mtd/maps/dilnetpc.c: In function `init_dnpc':
drivers/mtd/maps/dilnetpc.c:406: warning: assignment makes pointer from integer without a cast
drivers/mtd/maps/dilnetpc.c:416: warning: long unsigned int format, pointer arg (arg 2)
drivers/mtd/maps/dilnetpc.c:416: warning: long unsigned int format, pointer arg (arg 2)

Here's a patch to attempt to fix those. I don't have the hardware, so all 
I could do was read the code, think about it and then compile test my 
changes. I hope I got it right.

Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>

diff -up linux-2.6.9-rc2-bk5-orig/drivers/mtd/maps/dilnetpc.c linux-2.6.9-rc2-bk5/drivers/mtd/maps/dilnetpc.c
--- linux-2.6.9-rc2-bk5-orig/drivers/mtd/maps/dilnetpc.c	2004-08-14 07:36:32.000000000 +0200
+++ linux-2.6.9-rc2-bk5/drivers/mtd/maps/dilnetpc.c	2004-09-20 23:19:34.000000000 +0200
@@ -403,7 +403,7 @@ static int __init init_dnpc(void)
 	printk(KERN_NOTICE "DIL/Net %s flash: 0x%lx at 0x%lx\n", 
 		is_dnp ? "DNPC" : "ADNP", dnpc_map.size, dnpc_map.phys);
 
-	dnpc_map.virt = (unsigned long)ioremap_nocache(dnpc_map.phys, dnpc_map.size);
+	dnpc_map.virt = (unsigned long *)ioremap_nocache(dnpc_map.phys, dnpc_map.size);
 
 	dnpc_map_flash(dnpc_map.phys, dnpc_map.size);
 
@@ -413,7 +413,7 @@ static int __init init_dnpc(void)
 	}
 	simple_map_init(&dnpc_map);
 
-	printk("FLASH virtual address: 0x%lx\n", dnpc_map.virt);
+	printk("FLASH virtual address: 0x%lx\n", (unsigned long)dnpc_map.virt);
 
 	mymtd = do_map_probe("jedec_probe", &dnpc_map);
 


Please CC me on replies.


