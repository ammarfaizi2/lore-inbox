Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262183AbVCBFdF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262183AbVCBFdF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 00:33:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262184AbVCBFdF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 00:33:05 -0500
Received: from fire.osdl.org ([65.172.181.4]:1260 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262183AbVCBFdA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 00:33:00 -0500
Date: Tue, 1 Mar 2005 21:17:54 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: ecashin@coraid.com
Cc: akpm <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH] aoe: fix printk warning (sparc64)
Message-Id: <20050301211754.5e968c2f.rddunlap@osdl.org>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.8a (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


aoeblk: mac_addr() returns u64, coerce to unsigned long long to printk it:
(sparc64 build warning)

drivers/block/aoe/aoeblk.c:245: warning: long long unsigned int format, u64 arg (arg 2)
drivers/block/aoe/aoeblk.c:31: warning: long long unsigned int format, u64 arg (arg 4)

cross-compile results:
https://www.osdl.org/plm-cgi/plm?module=patch_info&patch_id=4239

Signed-off-by: Randy Dunlap <rddunlap@osdl.org>

diffstat:=
 drivers/block/aoe/aoeblk.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff -Naurp ./drivers/block/aoe/aoeblk.c~aoe_printk ./drivers/block/aoe/aoeblk.c
--- ./drivers/block/aoe/aoeblk.c~aoe_printk	2005-02-25 10:54:42.000000000 -0800
+++ ./drivers/block/aoe/aoeblk.c	2005-03-01 17:22:29.735503376 -0800
@@ -28,7 +28,8 @@ static ssize_t aoedisk_show_mac(struct g
 {
 	struct aoedev *d = disk->private_data;
 
-	return snprintf(page, PAGE_SIZE, "%012llx\n", mac_addr(d->addr));
+	return snprintf(page, PAGE_SIZE, "%012llx\n",
+			(unsigned long long)mac_addr(d->addr));
 }
 static ssize_t aoedisk_show_netif(struct gendisk * disk, char *page)
 {
@@ -241,7 +242,8 @@ aoeblk_gdalloc(void *vp)
 	aoedisk_add_sysfs(d);
 	
 	printk(KERN_INFO "aoe: %012llx e%lu.%lu v%04x has %llu "
-		"sectors\n", mac_addr(d->addr), d->aoemajor, d->aoeminor,
+		"sectors\n", (unsigned long long)mac_addr(d->addr),
+		d->aoemajor, d->aoeminor,
 		d->fw_ver, (long long)d->ssize);
 }
 

---
