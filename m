Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313938AbSDKBYu>; Wed, 10 Apr 2002 21:24:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313946AbSDKBYt>; Wed, 10 Apr 2002 21:24:49 -0400
Received: from u122-148.u61-70.giga.net.tw ([61.70.122.148]:34250 "EHLO matrix")
	by vger.kernel.org with ESMTP id <S313938AbSDKBYt>;
	Wed, 10 Apr 2002 21:24:49 -0400
Message-ID: <3CB4E3CA.7D108CBB@kalug.linux.org.tw>
Date: Thu, 11 Apr 2002 09:15:54 +0800
From: Rex Tsai <chihchun@kalug.linux.org.tw>
X-Mailer: Mozilla 4.77 [zh_TW] (X11; U; Linux 2.4.19-pre5-ac3 i686)
X-Accept-Language: zh-TW, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, "Kevin P. Fleming" <kevin@labsysgrp.com>
Subject: [PATCH] Lost interrupt with HPT372A patch
Content-Type: text/plain; charset=big5
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, I have a HighPoint RocketRAID 133 host adapter
with HPT372A chipset. (firmware revision is 2.31)

When booting with 2.4.19-pre5-ac3, I get "hde lost interrupt".
My HD drive is

  hde: ST380021A, ATA DISK drive
  hde: 156301488 sectors (80026 MB) w/2048KiB Cache, CHS=155061/16/63

The patch below turned out the problem.

--- linux/drivers/ide/hpt366.c.old      Thu Apr 11 08:50:45 2002
+++ linux/drivers/ide/hpt366.c  Thu Apr 11 08:57:18 2002
@@ -1326,7 +1326,11 @@
        int adjust, i;
        u16 freq;
        u32 pll;
-       byte reg5bh;
+       byte reg5bh, reg5ah;
+
+        /* turn on interrupts */
+       pci_read_config_byte(dev, 0x5a, &reg5ah);
+       pci_write_config_byte(dev, 0x5a, ( reg5ah & ~0x10));

        /*
         * default to pci clock. make sure MA15/16 are set to output
-Rex


