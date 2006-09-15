Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751576AbWIOOjP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751576AbWIOOjP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Sep 2006 10:39:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751573AbWIOOjO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Sep 2006 10:39:14 -0400
Received: from nat-132.atmel.no ([80.232.32.132]:2796 "EHLO relay.atmel.no")
	by vger.kernel.org with ESMTP id S1751576AbWIOOjN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Sep 2006 10:39:13 -0400
Date: Fri, 15 Sep 2006 16:37:11 +0200
From: Haavard Skinnemoen <hskinnemoen@atmel.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
       David Woodhouse <dwmw2@infradead.org>
Subject: [-mm patch 2/3] AVR32 MTD: Unlock flash if necessary (try 2)
Message-ID: <20060915163711.10d19763@cad-250-152.norway.atmel.com>
In-Reply-To: <20060915163554.4f326bf6@cad-250-152.norway.atmel.com>
References: <20060915163102.73bf171d@cad-250-152.norway.atmel.com>
	<20060915163554.4f326bf6@cad-250-152.norway.atmel.com>
Organization: Atmel Norway
X-Mailer: Sylpheed-Claws 2.5.0-rc2 (GTK+ 2.8.20; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If a cfi_cmdset_0002 fixup installs an unlock() operation, use it
to unlock the whole flash after the erase regions have been set up.

I wanted to do this in the fixup itself, but it wouldn't work because
the erase regions hadn't been initialized, and mtd->size was zero.

Signed-off-by: Haavard Skinnemoen <hskinnemoen@atmel.com>
---
 drivers/mtd/chips/cfi_cmdset_0002.c |    9 +++++++++
 1 file changed, 9 insertions(+)

Index: linux-2.6.18-rc6-mm2/drivers/mtd/chips/cfi_cmdset_0002.c
===================================================================
--- linux-2.6.18-rc6-mm2.orig/drivers/mtd/chips/cfi_cmdset_0002.c	2006-09-15 14:39:40.000000000 +0200
+++ linux-2.6.18-rc6-mm2/drivers/mtd/chips/cfi_cmdset_0002.c	2006-09-15 15:45:41.000000000 +0200
@@ -416,6 +416,15 @@ static struct mtd_info *cfi_amdstd_setup
 	}
 #endif
 
+	/*
+	 * If an unlock() operation was installed by a fixup, use it
+	 * now to unlock the whole flash.
+	 */
+	if (mtd->unlock && mtd->unlock(mtd, 0, mtd->size))
+		printk(KERN_WARNING "%s: unlock failed, writes may not work\n",
+		       map->name);
+
+
 	/* FIXME: erase-suspend-program is broken.  See
 	   http://lists.infradead.org/pipermail/linux-mtd/2003-December/009001.html */
 	printk(KERN_NOTICE "cfi_cmdset_0002: Disabling erase-suspend-program due to code brokenness.\n");
