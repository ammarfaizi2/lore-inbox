Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261758AbUKUSYo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261758AbUKUSYo (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Nov 2004 13:24:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261770AbUKUSYo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Nov 2004 13:24:44 -0500
Received: from mail.gootz.net ([66.160.141.176]:52741 "EHLO mail.gootz.net")
	by vger.kernel.org with ESMTP id S261758AbUKUSYf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Nov 2004 13:24:35 -0500
Message-ID: <41A0DCD2.8090803@gootz.net>
Date: Sun, 21 Nov 2004 19:22:10 +0100
From: Guillaume BINET <gbin-lkml@gootz.net>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041120)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: orinoco-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH] Correct the CIS recognition problem of orinoco_plx under
 x86_64 Kernel 2.6.10-rc1-mm2
X-Enigmail-Version: 0.89.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Gootz-MailScanner-Information: Please contact the ISP for more information
X-Gootz-MailScanner: Found to be clean
X-Gootz-MailScanner-SpamScore: s
X-MailScanner-From: gbin-lkml@gootz.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

---

This patch correct the orinoco_plx CIS magic number detection. This bug 
has been observed and corected under x84_64.

Output before the patch :
Nov 21 17:52:06 sal orinoco_plx: CIS: 
4E01:F403:2300:B000:2DFF:D017:1404:5467:465
A:2F08:19FF:5D1D:4005:B701:2E67:A85A:
Nov 21 17:52:06 sal orinoco_plx: The CIS value of Prism2 PC card is invalid.
Nov 21 17:52:06 sal orinoco_plx: init_one(), FAIL!


Signed-off-by: Guillaume BINET <gbin-lkml@gootz.net>

---

diff -Naur linux-2.6.10-rc2-mm2/drivers/net/wireless/orinoco_plx.c 
linux-2.6.10-rc2-mm2-gb1/drivers/net/wireless/orinoco_plx.c
--- linux-2.6.10-rc2-mm2/drivers/net/wireless/orinoco_plx.c    
2004-11-21 18:44:06.000000000 +0100
+++ linux-2.6.10-rc2-mm2-gb1/drivers/net/wireless/orinoco_plx.c    
2004-11-21 18:38:34.000000000 +0100
@@ -175,15 +175,22 @@
     if (!attr_mem)
         goto out;
 
+
+    /* Verify whether PC card is present */
+    /* FIXME: we probably need to be smarted about this */
+    memcpy_fromio(magic, attr_mem, 16);
+
+    /* only lower bits seem significant */
+    for (i = 0; i < 8; i++) {
+        magic[i] = magic[i] & 0x00ff;
+    }
+
     printk(KERN_DEBUG "orinoco_plx: CIS: ");
     for (i = 0; i < 16; i++) {
-        printk("%02X:", readw(attr_mem+i));
+        printk("%02X:", readw(magic+i));
     }
     printk("\n");
 
-    /* Verify whether PC card is present */
-    /* FIXME: we probably need to be smarted about this */
-    memcpy_fromio(magic, attr_mem, 16);
     if (memcmp(magic, cis_magic, 16) != 0) {
         printk(KERN_ERR "orinoco_plx: The CIS value of Prism2 PC card 
is invalid.\n");
         err = -EIO;

