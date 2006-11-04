Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965722AbWKDWZ3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965722AbWKDWZ3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Nov 2006 17:25:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965723AbWKDWZ3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Nov 2006 17:25:29 -0500
Received: from a222036.upc-a.chello.nl ([62.163.222.36]:15590 "EHLO
	laptopd505.fenrus.org") by vger.kernel.org with ESMTP
	id S965722AbWKDWZ2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Nov 2006 17:25:28 -0500
Subject: [patch] Make initramfs printk a warning on incorrect cpio type
From: Arjan van de Ven <arjan@linux.intel.com>
To: linux-kernel@vger.kernel.org
Cc: viro@zeniv.linux.org.uk, akpm@osdl.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Sat, 04 Nov 2006 23:25:15 +0100
Message-Id: <1162679115.3160.64.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1.1 (2.8.1.1-3.fc6) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It turns out that the "-c" option of cpio is highly unportable even
between distros let alone unix variants, and may actually make the wrong
type of cpio archive. I just wasted quite some time on this, and the
kernel can detect this and warn about it (it's __init memory so it gets
thrown away and thus there is no runtime overhead)

Signed-off-by: Arjan van de Ven <arjan@linux.intel.com>

--- linux-2.6.18/init/initramfs.c.old	2006-11-04 23:18:30.000000000 +0100
+++ linux-2.6.18/init/initramfs.c	2006-11-04 23:19:19.000000000 +0100
@@ -182,6 +182,10 @@ static int __init do_collect(void)
 
 static int __init do_header(void)
 {
+	if (memcmp(collected, "070707", 6)==0) {
+		error("incorrect cpio method used: use -H newc option");
+		return 1;
+	}
 	if (memcmp(collected, "070701", 6)) {
 		error("no cpio magic");
 		return 1;

