Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161399AbWHDUYy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161399AbWHDUYy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Aug 2006 16:24:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932622AbWHDUYy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Aug 2006 16:24:54 -0400
Received: from 1wt.eu ([62.212.114.60]:29709 "EHLO 1wt.eu")
	by vger.kernel.org with ESMTP id S932623AbWHDUYx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Aug 2006 16:24:53 -0400
Date: Fri, 4 Aug 2006 22:14:29 +0200
From: Willy Tarreau <w@1wt.eu>
To: Michael Buesch <mb@bu3sch.de>
Cc: Jukka Partanen <jspartanen@gmail.com>, kkeil@suse.de,
       linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 2.4.32] Fix AVM C4 ISDN card init problems with newer CPUs
Message-ID: <20060804201429.GA27529@1wt.eu>
References: <d50597c30608030953l41e8661dg1c10faeac31cc87f@mail.gmail.com> <1154627776.23655.106.camel@localhost.localdomain> <20060804065623.GA24404@1wt.eu> <200608041239.13260.mb@bu3sch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200608041239.13260.mb@bu3sch.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 04, 2006 at 12:39:12PM +0200, Michael Buesch wrote:
> On Friday 04 August 2006 08:56, Willy Tarreau wrote:
> > On Thu, Aug 03, 2006 at 06:56:15PM +0100, Alan Cox wrote:
> > > Ar Iau, 2006-08-03 am 19:53 +0300, ysgrifennodd Jukka Partanen:
> > > > AVM C4 ISDN NIC: Add three memory barriers, taken from 2.6.7,
> > > > (they are there in 2.6.17.7 too), to fix module initialization
> > > > problems appearing with at least some newer Celerons and
> > > > Pentium III.
> > > 
> > > Should be using cpu_relax() I think. Its a polled busy loop so you want
> > > other CPU threads to run if possible.
(...)
> cpu_relax() implies a memory barrier.

Ok, here's the updated patch for 2.6 using cpu_relax() instead of
mb(), as suggested by Alan and Michael.

Regards,
Willy

> Greetings Michael.

>From b76136dc1ac989081933d28ec958ecdd32d368e4 Mon Sep 17 00:00:00 2001
From: Willy Tarreau <w@1wt.eu>
Date: Fri, 4 Aug 2006 22:11:23 +0200
Subject: [PATCH] AVM C4 ISDN card : use cpu_relax() in busy loops

As suggested by Alan, use cpu_relax() in 3 busy loops : "It's a
polled busy loop so you want other CPU threads to run if possible".

Signed-off-by: Willy Tarreau <w@1wt.eu>
---
 drivers/isdn/hardware/avm/c4.c |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/isdn/hardware/avm/c4.c b/drivers/isdn/hardware/avm/c4.c
index f7253b2..8149dce 100644
--- a/drivers/isdn/hardware/avm/c4.c
+++ b/drivers/isdn/hardware/avm/c4.c
@@ -22,6 +22,7 @@ #include <linux/capi.h>
 #include <linux/kernelcapi.h>
 #include <linux/init.h>
 #include <asm/io.h>
+#include <asm/processor.h>
 #include <asm/uaccess.h>
 #include <linux/netdevice.h>
 #include <linux/isdn/capicmd.h>
@@ -149,7 +150,7 @@ static inline int wait_for_doorbell(avmc
 	while (c4inmeml(card->mbase+DOORBELL) != 0xffffffff) {
 		if (!time_before(jiffies, stop))
 			return -1;
-		mb();
+		cpu_relax();
 	}
 	return 0;
 }
@@ -302,7 +303,7 @@ static void c4_reset(avmcard *card)
 		if (!time_before(jiffies, stop))
 			return;
 		c4outmeml(card->mbase+DOORBELL, DBELL_ADDR);
-		mb();
+		cpu_relax();
 	}
 
 	c4_poke(card, DC21285_ARMCSR_BASE + CHAN_1_CONTROL, 0);
@@ -326,7 +327,7 @@ static int c4_detect(avmcard *card)
 		if (!time_before(jiffies, stop))
 			return 2;
 		c4outmeml(card->mbase+DOORBELL, DBELL_ADDR);
-		mb();
+		cpu_relax();
 	}
 
 	c4_poke(card, DC21285_ARMCSR_BASE + CHAN_1_CONTROL, 0);
-- 
1.4.1

