Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750916AbWDQXLZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750916AbWDQXLZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Apr 2006 19:11:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750964AbWDQXLZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Apr 2006 19:11:25 -0400
Received: from xproxy.gmail.com ([66.249.82.195]:28800 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750898AbWDQXLY convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Apr 2006 19:11:24 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=GDlaIVfYQex9yj5yWV0q4kVJquLt2oodoi93vtxb0HW4kHiGZoSVT7X2r3ogUJa5gNCWD/oa2PKpEzYdbZaYIV7vf47liY+AE+aw/kuElgmIwDf6ZBg0R8hDqxJQ8zx1EDy5LrDRpcMz08vDuDfDrRWUmvbY/qqEOLQwPNc9rFo=
Message-ID: <b79f23070604171611j784cc9afpd1bc6660cd25eed5@mail.gmail.com>
Date: Mon, 17 Apr 2006 16:11:22 -0700
From: "James Ausmus" <james.ausmus@gmail.com>
To: "Bartlomiej Zolnierkiewicz" <B.Zolnierkiewicz@elka.pw.edu.pl>
Subject: [PATCH 1/1] ide: Allow disabling of UDMA for Compact Flash devices
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Some IDE -> Compact Flash media adapters are not capable of supporting
UDMA, which can cause very slow boot times when the CF media itself
reports as capable of UDMA transfer speeds. Create Kconfig option to
turn off the UDMA capability bit when media is identified as Compact
Flash.

Signed-off-by: James Ausmus <james.ausmus@gmail.com>

---

diff -uprN -X linux-2.6.16.5/Documentation/dontdiff
linux-2.6.16.5.orig/drivers/ide/Kconfig
linux-2.6.16.5/drivers/ide/Kconfig
--- linux-2.6.16.5.orig/drivers/ide/Kconfig     2006-04-17
13:37:47.000000000 -0700
+++ linux-2.6.16.5/drivers/ide/Kconfig  2006-04-17 13:43:37.000000000 -0700
@@ -447,6 +447,18 @@ config IDEDMA_ONLYDISK

          Generally say N here.

+config IDE_COMPACT_FLASH_NO_UDMA
+       bool "Disable UDMA for Compact Flash Devices"
+       help
+         This turns off the UDMA capability flag bit for any IDE device
+         that identifies as Compact Flash - This is a workaround for
+         cheap Compact Flash -> IDE adapters that don't support UDMA
+         transfer speeds even if the CF card does.
+
+         Enable this if you are using a Compact Flash card as an IDE
+         device and you see re-occuring 0x41 DMA Timeout errors from
+         your IDE driver.
+
 config BLK_DEV_AEC62XX
        tristate "AEC62XX chipset support"
        help
diff -uprN -X linux-2.6.16.5/Documentation/dontdiff
linux-2.6.16.5.orig/drivers/ide/ide-probe.c
linux-2.6.16.5/drivers/ide/ide-probe.c
--- linux-2.6.16.5.orig/drivers/ide/ide-probe.c 2006-04-17
13:37:48.000000000 -0700
+++ linux-2.6.16.5/drivers/ide/ide-probe.c      2006-04-17
13:44:45.000000000 -0700
@@ -248,6 +248,11 @@ static inline void do_identify (ide_driv
        if ((id->config != 0x848a) && (id->config & (1<<7)))
                drive->removable = 1;

+#if defined(CONFIG_IDE_COMPACT_FLASH_NO_UDMA)
+       if (id->config == 0x848a)
+               id->capability &= ~1;
+#endif
+
        drive->media = ide_disk;
        printk("%s DISK drive\n", (id->config == 0x848a) ? "CFA" : "ATA" );
        QUIRK_LIST(drive);
