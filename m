Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267943AbTBVXNP>; Sat, 22 Feb 2003 18:13:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267947AbTBVXNP>; Sat, 22 Feb 2003 18:13:15 -0500
Received: from [212.156.4.132] ([212.156.4.132]:39934 "EHLO fep02.ttnet.net.tr")
	by vger.kernel.org with ESMTP id <S267943AbTBVXNO>;
	Sat, 22 Feb 2003 18:13:14 -0500
Date: Sun, 23 Feb 2003 01:23:29 +0200
From: Faik Uygur <faikuygur@ttnet.net.tr>
To: mlord@pobox.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.5.62: /proc/ide/sc1200 returns incomplete data [12/17]
Message-ID: <20030222232329.GK2996@ttnet.net.tr>
Mail-Followup-To: mlord@pobox.com, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-9
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-PGP-Fingerprint: 15 C0 AA 31 59 F9 DE 4F 7D A6 C7 D8 A0 D5 67 73
X-PGP-Key-ID: 0x5C447959
X-PGP-Key-Size: 2048 bits
X-Editor: GNU Emacs 21.2.1
X-Operating-System: Debian GNU/Linux
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes the incomplete data return problem of /proc/ide/sc1200.
When the number of consecutive read bytes are smaller than the total
data in sc1200_get_info(), the second read() returns 0.

--- linux-2.5.62-vanilla/drivers/ide/pci/sc1200.c	Sat Feb 22 23:00:43 2003
+++ linux-2.5.62/drivers/ide/pci/sc1200.c	Sat Feb 22 23:38:40 2003
@@ -84,6 +84,7 @@
 {
 	char *p = buffer;
 	unsigned long bibma = pci_resource_start(bmide_dev, 4);
+	int len;
 	u8  c0 = 0, c1 = 0;
 
 	/*
@@ -108,7 +109,10 @@
 	p += sprintf(p, "DMA\n");
 	p += sprintf(p, "PIO\n");
 
-	return p-buffer;
+	len = (p - buffer) - offset;
+	*addr = buffer + offset;
+	
+	return len > count ? count : len;
 }
 #endif /* DISPLAY_SC1200_TIMINGS && CONFIG_PROC_FS */


