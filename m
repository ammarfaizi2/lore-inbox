Return-Path: <linux-kernel-owner+w=401wt.eu-S1751877AbXAVCZT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751877AbXAVCZT (ORCPT <rfc822;w@1wt.eu>);
	Sun, 21 Jan 2007 21:25:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751878AbXAVCZT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Jan 2007 21:25:19 -0500
Received: from topsns2.toshiba-tops.co.jp ([202.230.225.126]:12039 "EHLO
	topsns2.toshiba-tops.co.jp" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751877AbXAVCZS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Jan 2007 21:25:18 -0500
Date: Mon, 22 Jan 2007 11:25:09 +0900 (JST)
Message-Id: <20070122.112509.55511116.nemoto@toshiba-tops.co.jp>
To: linux-kernel@vger.kernel.org
Cc: david-b@pacbell.net, dbrownell@users.sourceforge.net, hcegtvedt@atmel.com,
       akpm@osdl.org
Subject: Re: [PATCH 2.6.20-rc5] SPI: alternative fix for
 spi_busnum_to_master
From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20070118.202849.70477632.nemoto@toshiba-tops.co.jp>
References: <20070118.202849.70477632.nemoto@toshiba-tops.co.jp>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 21.3 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Jan 2007 20:28:49 +0900 (JST), Atsushi Nemoto <anemo@mba.ocn.ne.jp> wrote:
> The commit was to fix spi_busnum_to_master().  Here is a patch fixes
> this function in other way, just searching children list of
> class_device.

Here is a revised version.  The children list of spi_master_class
contains only spi_master class so we can just compare bus_num member
instead of class_id string.


Subject: SPI: alternative fix for spi_busnum_to_master

If a SPI master device exists, udev (udevtrigger) causes kernel crash,
due to wrong kobj pointer in kobject_uevent_env().  This problem was
not in 2.6.19.

The backtrace (on MIPS) was:
[<8024db6c>] kobject_uevent_env+0x54c/0x5e8
[<802a8264>] store_uevent+0x1c/0x3c  (in drivers/class.c)
[<801cb14c>] subsys_attr_store+0x2c/0x50
[<801cb80c>] flush_write_buffer+0x38/0x5c
[<801cb900>] sysfs_write_file+0xd0/0x190
[<80181444>] vfs_write+0xc4/0x1a0
[<80181cdc>] sys_write+0x54/0xa0
[<8010dae4>] stack_done+0x20/0x3c

flush_write_buffer() passes kobject of spi_master_class.subsys to
subsys_addr_store(), then subsys_addr_store() passes a pointer to a
struct subsystem to store_uevent() which expects a pointer to a struct
class_device.  The problem seems subsys_attr_store() called instead of
class_device_attr_store().

This mismatch was caused by commit
3bd0f6943520e459659d10f3282285e43d3990f1, which overrides kset of
master class.  This made spi_master_class.subsys.kset.ktype NULL so
subsys_sysfs_ops is used instead of class_dev_sysfs_ops.

The commit was to fix spi_busnum_to_master().  Here is a patch fixes
this function in other way, just searching children list of
class_device.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
---
diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 270e621..88c945b 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -366,7 +366,6 @@ spi_alloc_master(struct device *dev, uns
 
 	class_device_initialize(&master->cdev);
 	master->cdev.class = &spi_master_class;
-	kobj_set_kset_s(&master->cdev, spi_master_class.subsys);
 	master->cdev.dev = get_device(dev);
 	spi_master_set_devdata(master, &master[1]);
 
@@ -466,14 +465,22 @@ EXPORT_SYMBOL_GPL(spi_unregister_master)
  */
 struct spi_master *spi_busnum_to_master(u16 bus_num)
 {
-	char			name[9];
-	struct kobject		*bus;
-
-	snprintf(name, sizeof name, "spi%u", bus_num);
-	bus = kset_find_obj(&spi_master_class.subsys.kset, name);
-	if (bus)
-		return container_of(bus, struct spi_master, cdev.kobj);
-	return NULL;
+	struct class_device	*cdev;
+	struct spi_master	*master = NULL;
+
+	down(&spi_master_class.sem);
+	list_for_each_entry(cdev, &spi_master_class.children, node) {
+		cdev = class_device_get(cdev);
+		if (!cdev)
+			continue;
+		master = container_of(cdev, struct spi_master, cdev);
+		if (master->bus_num == bus_num)
+			break;
+		master = NULL;
+		class_device_put(cdev);
+	}
+	up(&spi_master_class.sem);
+	return master;
 }
 EXPORT_SYMBOL_GPL(spi_busnum_to_master);
 
