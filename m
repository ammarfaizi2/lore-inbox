Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268000AbTBVXmG>; Sat, 22 Feb 2003 18:42:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268001AbTBVXmG>; Sat, 22 Feb 2003 18:42:06 -0500
Received: from [212.156.4.132] ([212.156.4.132]:60359 "EHLO fep02.ttnet.net.tr")
	by vger.kernel.org with ESMTP id <S268000AbTBVXmF>;
	Sat, 22 Feb 2003 18:42:05 -0500
Date: Sun, 23 Feb 2003 01:52:10 +0200
From: Faik Uygur <faikuygur@ttnet.net.tr>
To: torben.mathiasen@hp.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.5.62: /proc/ide/triflex returns incomplete data [17/17]
Message-ID: <20030222235210.GQ2996@ttnet.net.tr>
Mail-Followup-To: torben.mathiasen@hp.com,
	linux-kernel@vger.kernel.org
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

This patch fixes the incomplete data return problem of /proc/ide/triflex.
When the number of consecutive read bytes are smaller than the total
data in triflex_get_info(), the second read() returns 0.

--- linux-2.5.62-vanilla/drivers/ide/pci/triflex.c	Sun Feb 23 00:08:33 2003
+++ linux-2.5.62/drivers/ide/pci/triflex.c	Sat Feb 22 23:52:14 2003
@@ -49,6 +49,7 @@
 static int triflex_get_info(char *buf, char **addr, off_t offset, int count)
 {
 	char *p = buf;
+	int len;
 
 	struct pci_dev *dev	= triflex_dev;
 	unsigned long bibma = pci_resource_start(dev, 4);
@@ -85,8 +86,11 @@
 
 	p += sprintf(p, "DMA\n");
 	p += sprintf(p, "PIO\n");
+
+	len = (p - buf) - offset;
+	*addr = buf + offset;
 	
-	return p-buf;
+	return len > count ? count : len;
 }
 
 static int triflex_tune_chipset(ide_drive_t *drive, u8 xferspeed)





