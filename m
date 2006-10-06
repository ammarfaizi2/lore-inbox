Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751361AbWJFFfe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751361AbWJFFfe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 01:35:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751372AbWJFFfd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 01:35:33 -0400
Received: from mail01.verismonetworks.com ([164.164.99.228]:15286 "EHLO
	mail01.verismonetworks.com") by vger.kernel.org with ESMTP
	id S1751361AbWJFFfc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 01:35:32 -0400
Subject: [PATCH 2/9] sound/oss/dmasound/dmasound_awacs.c: ioremap balanced
	with iounmap
From: Amol Lad <amol@verismonetworks.com>
To: linux kernel <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>
Content-Type: text/plain
Date: Fri, 06 Oct 2006 11:08:53 +0530
Message-Id: <1160113133.19143.130.camel@amol.verismonetworks.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Amol Lad <amol@verismonetworks.com>
---
 dmasound_awacs.c |   39 +++++++++++++++++++++++++++++++++++----
 1 files changed, 35 insertions(+), 4 deletions(-)
---
diff -uprN -X linux-2.6.19-rc1-orig/Documentation/dontdiff linux-2.6.19-rc1-orig/sound/oss/dmasound/dmasound_awacs.c linux-2.6.19-rc1/sound/oss/dmasound/dmasound_awacs.c
--- linux-2.6.19-rc1-orig/sound/oss/dmasound/dmasound_awacs.c	2006-10-05 14:01:04.000000000 +0530
+++ linux-2.6.19-rc1/sound/oss/dmasound/dmasound_awacs.c	2006-10-05 17:34:42.000000000 +0530
@@ -3067,8 +3067,9 @@ printk("dmasound_pmac: Awacs/Screamer Co
 		udelay(1);
 
 	/* Initialize beep stuff */
-	if ((res=setup_beep()))
-		return res ;
+	res=setup_beep();
+	if (res)
+		goto out_unmap;
 
 #ifdef CONFIG_PM
 	pmu_register_sleep_notifier(&awacs_sleep_notifier);
@@ -3160,7 +3161,26 @@ printk("dmasound_pmac: Awacs/Screamer Co
 	 */
 	input_register_device(awacs_beep_dev);
 
-	return dmasound_init();
+	res = dmasound_init();
+	if (res)
+		goto out_unmap1;
+
+	return 0;
+	
+out_unmap1:
+	if (is_pbook_3X00)
+		iounmap(latch_base);
+	else if (is_pbook_g3)
+		iounmap(macio_base);
+out_unmap:
+	if (i2s_node)
+		iounmap(i2s);
+	else
+		iounmap(awacs);
+	iounmap(awacs_txdma);
+	iounmap(awacs_rxdma);
+
+	return res;
 }
 
 static void __exit dmasound_awacs_cleanup(void)
@@ -3177,8 +3197,19 @@ static void __exit dmasound_awacs_cleanu
 			daca_cleanup();
 			break;
 	}
-	dmasound_deinit();
 
+	if (is_pbook_3X00)
+		iounmap(latch_base);
+	else if (is_pbook_g3)
+		iounmap(macio_base);
+	if (i2s_node)
+		iounmap(i2s);
+	else
+		iounmap(awacs);
+	iounmap(awacs_txdma);
+	iounmap(awacs_rxdma);
+
+	dmasound_deinit();
 }
 
 MODULE_DESCRIPTION("PowerMac built-in audio driver.");


