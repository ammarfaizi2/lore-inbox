Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261338AbSLAAFA>; Sat, 30 Nov 2002 19:05:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261339AbSLAAFA>; Sat, 30 Nov 2002 19:05:00 -0500
Received: from x101-201-249-dhcp.reshalls.umn.edu ([128.101.201.249]:12161
	"EHLO arashi.yi.org") by vger.kernel.org with ESMTP
	id <S261338AbSLAAE7>; Sat, 30 Nov 2002 19:04:59 -0500
Date: Sat, 30 Nov 2002 18:12:24 -0600
From: Matt Reppert <arashi@arashi.yi.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Unsafe MODULE_ usage in crc32.c
Message-Id: <20021130181224.4b4cddad.arashi@arashi.yi.org>
Organization: Yomerashi
X-Mailer: Sylpheed version 0.8.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-message-flag: : This mail sent from host minerva, please respond.
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Okay, I know, it's just a library module, doesn't need to ever be unloaded
anyway. But error noise in dmesg annoys me, hence this patch.

Matt

  Convert CRC32 to try_module_get; fixes an unsafe usage that
  prevents unloading.


 lib/crc32.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletion(-)

--- linux-2.5.50/lib/crc32.c~crc32-unsafe	2002-11-30 05:31:19.000000000 -0600
+++ linux-2.5.50-arashi/lib/crc32.c	2002-11-30 05:36:17.000000000 -0600
@@ -551,7 +551,10 @@ static int __init init_crc32(void)
 	rc1 = crc32init_le();
 	rc2 = crc32init_be();
 	rc = rc1 || rc2;
-	if (!rc) MOD_INC_USE_COUNT;
+	if (!rc) {
+		if (!try_module_get(THIS_MODULE))
+			rc = -1;
+	}
 	return rc;
 }
 

[patch ends]
