Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263938AbTICXwf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 19:52:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264256AbTICXwf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 19:52:35 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:23806 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S263938AbTICXwS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 19:52:18 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: admin@brien.com
Subject: Re: SATA probe delay on boot
Date: Thu, 4 Sep 2003 01:53:07 +0200
User-Agent: KMail/1.5
References: <20030903161848.2109.h004.c000.wm@mail.brien.com.criticalpath.net>
In-Reply-To: <20030903161848.2109.h004.c000.wm@mail.brien.com.criticalpath.net>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200309040153.07931.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thursday 04 of September 2003 01:18, admin@brien.com wrote:
> Hi,

Hi,

> I have a Sil3112A SATA controller, which linux works OK
> with. It supports RAID (up to 4 devices), but I'm using
> BASE option -- only 1 hard drive.
>
> My question is regarding a 15-20 second delay which
> normally occurs every time I boot, unless I pass the

Please try attached patch and send dmesg output (with patch applied).
Patch is against current 2.6-bk tree, but should apply to any recent
2.4.x or 2.6.x kernels.

diff -puN drivers/ide/ide-probe.c~ide-siimage-wait drivers/ide/ide-probe.c
--- linux-2.6.0-test4-bk5/drivers/ide/ide-probe.c~ide-siimage-wait	2003-09-04 01:34:02.285489272 +0200
+++ linux-2.6.0-test4-bk5-root/drivers/ide/ide-probe.c	2003-09-04 01:47:58.145419248 +0200
@@ -56,6 +56,8 @@
 #include <asm/uaccess.h>
 #include <asm/io.h>
 
+#define DEBUG
+
 /**
  *	generic_id		-	add a generic drive id
  *	@drive:	drive to make an ID block for
@@ -345,7 +347,16 @@ static int actual_try_to_identify (ide_d
 		}
 		/* give drive a breather */
 		ide_delay_50ms();
-	} while ((hwif->INB(hd_status)) & BUSY_STAT);
+		s = hwif->INB(hd_status);
+		if (s == 0xff) {
+#ifdef DEBUG
+			printk("%s: status == 0xff\n", drive->name);
+#endif
+			return 1;
+		}
+		if ((s & BUSY_STAT) == 0)
+			break;
+	} while (1);
 
 	/* wait for IRQ and DRQ_STAT */
 	ide_delay_50ms();

_

> options ide3=0 - ide9=0 to fill up the device table. I
> think I have to do this because if I do only ide3=0
> (where the device would be), it uses ide4, and so on. I
> have GRUB set up to do this automatically, but it's not
> exactly adequate (,is it?). So I was wondering if
> there're any other ways to get the same affect. Is or
> could there be an option to simply disable the probing
> of the one specific device/channel every time?

"ide3=noprobe" doesnt work?

--bartlomiej

