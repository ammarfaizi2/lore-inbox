Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751368AbVK2Ozd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751368AbVK2Ozd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Nov 2005 09:55:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751369AbVK2Ozd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Nov 2005 09:55:33 -0500
Received: from wproxy.gmail.com ([64.233.184.204]:57207 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751368AbVK2Ozc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Nov 2005 09:55:32 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=kPyGt/h0lXWL7gYDxa+97QG1whD5EaOgSmUpnvJU0l0XtUADxprUHW6IRD5VkODysg5xlvI0tY+LyO+FMutIVOV7kbLW5L4XqxMyB6Z9aHlmocrbtgv5PKmBpNd4eJfh3SPxJLNuuuDCs8pGKmW7VSiwFI4CWAcafhHC6xCilfo=
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] touch softlockup watchdog in ide_wait_not_busy
Date: Tue, 29 Nov 2005 15:55:26 +0100
User-Agent: KMail/1.8.92
Cc: Andrew Morton <akpm@osdl.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       "Alexander V. Inyukhin" <shurick@sectorb.msk.ru>,
       Jesper Juhl <jesper.juhl@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511291555.27202.jesper.juhl@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This is a resend of a patch I proposed in the 
"[BUG] 2.6.15-rc1, soft lockup detected while probing IDE devices on AMD7441"
thread.
I recieved no ACK/NACK or other feedback on the patch, so I'm resending it in
the hope of getting some comments :)


From: Jesper Juhl <jesper.juhl@gmail.com>

Make sure we touch the softlockup watchdog in 
ide_wait_not_busy() since it may cause the watchdog to trigger, but
there's really no point in that since the loop will eventually return, and
triggering the watchdog won't do us any good anyway.

The  if (!(timeout % 128))  bit is a guess that since 
touch_softlockup_watchdog() is a per_cpu thing it will be cheaper to do the
modulo calculation than calling the function every time through the loop,
especially as the nr of CPU's go up. But it's purely a guess, so I may very 
well be wrong - also, 128 is an arbitrarily chosen value, it's just a nice 
number that'll give us <10 function calls pr second.

Since I have no IDE devices in my box I'm unable to test this beyond making
sure it compiles without warnings or errors (which it does).

Let me know what you think.

Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
---

 drivers/ide/ide-iops.c |    8 ++++++++
 1 files changed, 8 insertions(+)

diff -up linux-2.6.15-rc3-orig/drivers/ide/ide-iops.c linux-2.6.15-rc3/drivers/ide/ide-iops.c
--- linux-2.6.15-rc3-orig/drivers/ide/ide-iops.c	2005-11-29 15:30:32.000000000 +0100
+++ linux-2.6.15-rc3/drivers/ide/ide-iops.c	2005-11-29 15:44:23.000000000 +0100
@@ -24,6 +24,7 @@
 #include <linux/hdreg.h>
 #include <linux/ide.h>
 #include <linux/bitops.h>
+#include <linux/sched.h>
 
 #include <asm/byteorder.h>
 #include <asm/irq.h>
@@ -1243,6 +1244,13 @@ int ide_wait_not_busy(ide_hwif_t *hwif, 
 		 */
 		if (stat == 0xff)
 			return -ENODEV;
+
+		/* 
+		 * We risk triggering the soft lockup detector, but we don't
+		 * want that, so better poke it a bit once in a while.
+		 */
+		if (!(timeout % 128))
+			touch_softlockup_watchdog();
 	}
 	return -EBUSY;
 }


