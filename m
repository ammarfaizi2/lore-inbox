Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267937AbTBVWqG>; Sat, 22 Feb 2003 17:46:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267943AbTBVWqG>; Sat, 22 Feb 2003 17:46:06 -0500
Received: from [212.156.4.132] ([212.156.4.132]:14070 "EHLO fep02.ttnet.net.tr")
	by vger.kernel.org with ESMTP id <S267937AbTBVWqF>;
	Sat, 22 Feb 2003 17:46:05 -0500
Date: Sun, 23 Feb 2003 00:56:20 +0200
From: Faik Uygur <faikuygur@ttnet.net.tr>
To: alan@lxorguk.ukuu.org.uk
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.5.62: /proc/ide/cs5520 returns incomplete data [5/17]
Message-ID: <20030222225620.GD2996@ttnet.net.tr>
Mail-Followup-To: alan@lxorguk.ukuu.org.uk,
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

This patch fixes the incomplete data return problem of /proc/ide/cs5520.
When the number of consecutive read bytes are smaller than the total
data in cs5520_get_info(), the second read() returns 0.

--- linux-2.5.62-vanilla/drivers/ide/pci/cs5520.c	Sat Feb 22 23:00:43 2003
+++ linux-2.5.62/drivers/ide/pci/cs5520.c	Sat Feb 22 23:28:28 2003
@@ -65,6 +65,7 @@
 {
 	char *p = buffer;
 	unsigned long bmiba = pci_resource_start(bmide_dev, 2);
+	int len;
 	u8 c0 = 0, c1 = 0;
 	u16 reg16;
 	u32 reg32;
@@ -94,7 +95,10 @@
 	pci_read_config_dword(bmide_dev, 0x68, &reg32);
 	p += sprintf(p, "16bit Secondary: %08x\n", reg32);
 	
-	return p-buffer;
+	len = (p - buffer) - offset;
+	*addr = buffer + offset;
+	
+	return len > count ? count : len;
 }
 
 #endif

