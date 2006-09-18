Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965545AbWIRIMG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965545AbWIRIMG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Sep 2006 04:12:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965549AbWIRIMF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Sep 2006 04:12:05 -0400
Received: from nat-132.atmel.no ([80.232.32.132]:15060 "EHLO relay.atmel.no")
	by vger.kernel.org with ESMTP id S965545AbWIRIMC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Sep 2006 04:12:02 -0400
Date: Mon, 18 Sep 2006 10:12:24 +0200
From: Haavard Skinnemoen <hskinnemoen@atmel.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-mtd@lists.infradead.org,
       linux-kernel@vger.kernel.org
Subject: Re: [-mm patch 2/3] AVR32 MTD: Unlock flash if necessary (try 2)
Message-ID: <20060918101224.12508491@cad-250-152.norway.atmel.com>
In-Reply-To: <1158334346.24527.94.camel@pmac.infradead.org>
References: <20060915163102.73bf171d@cad-250-152.norway.atmel.com>
	<20060915163554.4f326bf6@cad-250-152.norway.atmel.com>
	<20060915163711.10d19763@cad-250-152.norway.atmel.com>
	<1158334346.24527.94.camel@pmac.infradead.org>
Organization: Atmel Norway
X-Mailer: Sylpheed-Claws 2.5.0-rc2 (GTK+ 2.8.20; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Sep 2006 16:32:26 +0100
David Woodhouse <dwmw2@infradead.org> wrote:

> On Fri, 2006-09-15 at 16:37 +0200, Haavard Skinnemoen wrote:
> > If a cfi_cmdset_0002 fixup installs an unlock() operation, use it
> > to unlock the whole flash after the erase regions have been set up.
> 
> There are cmdset_0001 chips which have this affliction too. I was
> thinking of having a flag MTD_STUPID_LOCK which you set when you
> determine that it's one of these chips, then add_mtd_device() can do
> the unlocking... or add_mtd_partitions() can do it but _only_ for
> writable partitions.

Ok, so how about something like this? Which other chips should be marked?

---

From: Haavard Skinnemoen <hskinnemoen@atmel.com>
Subject: [-mm patch 2/3] AVR32 MTD: Unlock flash if necessary

Introduce the MTD_STUPID_LOCK flag which indicates that the flash chip
is always locked after power-up, so all sectors need to be unlocked
before it is usable.

If this flag is set, and the chip provides an unlock() operation,
mtd_add_device will unlock the whole MTD device if it's writeable. This
means that non-writeable partitions will stay locked.

Set MTD_STUPID_LOCK in fixup_use_atmel_lock() so that these chips will
work as expected.

Signed-off-by: Haavard Skinnemoen <hskinnemoen@atmel.com>
---
 drivers/mtd/chips/cfi_cmdset_0002.c |    1 +
 drivers/mtd/mtdcore.c               |   10 ++++++++++
 include/mtd/mtd-abi.h               |    1 +
 3 files changed, 12 insertions(+)

Index: linux-2.6.18-rc6-mm2/drivers/mtd/chips/cfi_cmdset_0002.c
===================================================================
--- linux-2.6.18-rc6-mm2.orig/drivers/mtd/chips/cfi_cmdset_0002.c	2006-09-18 09:43:02.000000000 +0200
+++ linux-2.6.18-rc6-mm2/drivers/mtd/chips/cfi_cmdset_0002.c	2006-09-18 10:02:31.000000000 +0200
@@ -212,6 +212,7 @@ static void fixup_use_atmel_lock(struct 
 {
 	mtd->lock = cfi_atmel_lock;
 	mtd->unlock = cfi_atmel_unlock;
+	mtd->flags |= MTD_STUPID_LOCK;
 }
 
 static struct cfi_fixup cfi_fixup_table[] = {
Index: linux-2.6.18-rc6-mm2/drivers/mtd/mtdcore.c
===================================================================
--- linux-2.6.18-rc6-mm2.orig/drivers/mtd/mtdcore.c	2006-09-18 09:36:56.000000000 +0200
+++ linux-2.6.18-rc6-mm2/drivers/mtd/mtdcore.c	2006-09-18 10:03:24.000000000 +0200
@@ -57,6 +57,16 @@ int add_mtd_device(struct mtd_info *mtd)
 			mtd->index = i;
 			mtd->usecount = 0;
 
+			/* Some chips always power up locked. Unlock them now */
+			if ((mtd->flags & MTD_WRITEABLE)
+			    && (mtd->flags & MTD_STUPID_LOCK) && mtd->unlock) {
+				if (mtd->unlock(mtd, 0, mtd->size))
+					printk(KERN_WARNING
+					       "%s: unlock failed, "
+					       "writes may not work\n",
+					       mtd->name);
+			}
+
 			DEBUG(0, "mtd: Giving out device %d to %s\n",i, mtd->name);
 			/* No need to get a refcount on the module containing
 			   the notifier, since we hold the mtd_table_mutex */
Index: linux-2.6.18-rc6-mm2/include/mtd/mtd-abi.h
===================================================================
--- linux-2.6.18-rc6-mm2.orig/include/mtd/mtd-abi.h	2006-09-18 09:34:14.000000000 +0200
+++ linux-2.6.18-rc6-mm2/include/mtd/mtd-abi.h	2006-09-18 09:35:27.000000000 +0200
@@ -34,6 +34,7 @@ struct mtd_oob_buf {
 #define MTD_WRITEABLE		0x400	/* Device is writeable */
 #define MTD_BIT_WRITEABLE	0x800	/* Single bits can be flipped */
 #define MTD_NO_ERASE		0x1000	/* No erase necessary */
+#define MTD_STUPID_LOCK		0x2000	/* Always locked after reset */
 
 // Some common devices / combinations of capabilities
 #define MTD_CAP_ROM		0
