Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932226AbVKWTNO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932226AbVKWTNO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 14:13:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932228AbVKWTNO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 14:13:14 -0500
Received: from xproxy.gmail.com ([66.249.82.206]:48785 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932243AbVKWTNM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 14:13:12 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=l/glZNvKaKL6Sn8rtXCt/jaPsZd965Ggn0H17luoeG8jyqh2lfFqb4EzcVwsElXJYI4R0NyJmnxfTuGFfI7+VOdocXdl18Rs6ZlbLyhn1KFTsXUhNhsRgbl+UR4cXxI3+ansB1AH33OCfEl5l5OWX+/rPPkNL+rPyjGps6h6cEk=
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [BUG] 2.6.15-rc1, soft lockup detected while probing IDE devices on AMD7441
Date: Wed, 23 Nov 2005 20:17:51 +0100
User-Agent: KMail/1.8.92
Cc: Andrew Morton <akpm@osdl.org>, shurick@sectorb.msk.ru,
       linux-kernel@vger.kernel.org, Jesper Juhl <jesper.juhl@gmail.com>
References: <20051120204656.GA17242@shurick.s2s.msu.ru> <20051120172915.31754054.akpm@osdl.org> <1132605524.11842.38.camel@localhost.localdomain>
In-Reply-To: <1132605524.11842.38.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511232017.52788.jesper.juhl@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 21 November 2005 21:38, Alan Cox wrote:
> On Sul, 2005-11-20 at 17:29 -0800, Andrew Morton wrote:
> > Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> > > Quite normal. The old IDE probe code takes a long time and it makes the
> > > soft lockup code believe a lockup occurred - rememeber its a debugging
> > > tool not a 100% reliable detector of failures.
> > > 
> > 
> > We could put a touch_softlockup_watchdog() in there.
> 
> Would make sense. Spin up and probe can take over 30 seconds worst case
> and is polled in the IDE world. The loop will eventually exit and a true
> lockup caused by a stuck IORDY line will hang forever in an inb/outb so
> neither softlockup or even nmi lockup would save you.
> 

How about something like the patch below?

The  if (!(timeout % 128))  bit is a guess that since 
touch_softlockup_watchdog() is a per_cpu thing it will be cheaper to do the
modulo calculation than calling the function every time through the loop,
especially as the nr of CPU's go up. But it's purely a guess, so I may very 
well be wrong - also, 128 is an arbitrarily chosen value, it's just a nice 
number that'll give us <10 function calls pr second.

<disclaimer>patch is completely un-tested</disclaimer>


From: Jesper Juhl <jesper.juhl@gmail.com>
Subject: touch softlockup watchdog in ide_wait_not_busy

Make sure we touch the softlockup watchdog in 
ide_wait_not_busy() since it may cause the watchdog to trigger, but
there's really no point in that since the loop will eventually return, and
triggering the watchdog won't do us any good anyway.

Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
---

 drivers/ide/ide-iops.c |    8 ++++++++
 1 files changed, 8 insertions(+)

--- linux-2.6.15-rc2-orig/drivers/ide/ide-iops.c	2005-11-20 22:25:24.000000000 +0100
+++ linux-2.6.15-rc2/drivers/ide/ide-iops.c	2005-11-23 19:46:11.000000000 +0100
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


