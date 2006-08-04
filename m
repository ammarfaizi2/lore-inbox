Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161073AbWHDHGK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161073AbWHDHGK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Aug 2006 03:06:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161075AbWHDHGK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Aug 2006 03:06:10 -0400
Received: from 1wt.eu ([62.212.114.60]:23565 "EHLO 1wt.eu")
	by vger.kernel.org with ESMTP id S1161073AbWHDHGI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Aug 2006 03:06:08 -0400
Date: Fri, 4 Aug 2006 08:56:23 +0200
From: Willy Tarreau <w@1wt.eu>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Jukka Partanen <jspartanen@gmail.com>, kkeil@suse.de,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.4.32] Fix AVM C4 ISDN card init problems with newer CPUs
Message-ID: <20060804065623.GA24404@1wt.eu>
References: <d50597c30608030953l41e8661dg1c10faeac31cc87f@mail.gmail.com> <1154627776.23655.106.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1154627776.23655.106.camel@localhost.localdomain>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 03, 2006 at 06:56:15PM +0100, Alan Cox wrote:
> Ar Iau, 2006-08-03 am 19:53 +0300, ysgrifennodd Jukka Partanen:
> > AVM C4 ISDN NIC: Add three memory barriers, taken from 2.6.7,
> > (they are there in 2.6.17.7 too), to fix module initialization
> > problems appearing with at least some newer Celerons and
> > Pentium III.
> 
> Should be using cpu_relax() I think. Its a polled busy loop so you want
> other CPU threads to run if possible.

You mean like this ? Here's the patch for 2.6, I'll queue the same for 2.4
if it's alright.

> Alan

Regards,
Willy

>From 512d12bd7ce9c0a15dfd91a6f7c2970c92b3abdd Mon Sep 17 00:00:00 2001
From: Willy Tarreau <w@1wt.eu>
Date: Fri, 4 Aug 2006 08:50:10 +0200
Subject: [PATCH] AVM C4 ISDN card : use cpu_relax() in busy loops

As suggested by Alan, use cpu_relax() in 3 busy loops : "It's a
polled busy loop so you want other CPU threads to run if possible".

Signed-off-by: Willy Tarreau <w@1wt.eu>
---
 drivers/isdn/hardware/avm/c4.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/drivers/isdn/hardware/avm/c4.c b/drivers/isdn/hardware/avm/c4.c
index f7253b2..aee278e 100644
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
@@ -150,6 +151,7 @@ static inline int wait_for_doorbell(avmc
 		if (!time_before(jiffies, stop))
 			return -1;
 		mb();
+		cpu_relax();
 	}
 	return 0;
 }
@@ -303,6 +305,7 @@ static void c4_reset(avmcard *card)
 			return;
 		c4outmeml(card->mbase+DOORBELL, DBELL_ADDR);
 		mb();
+		cpu_relax();
 	}
 
 	c4_poke(card, DC21285_ARMCSR_BASE + CHAN_1_CONTROL, 0);
@@ -327,6 +330,7 @@ static int c4_detect(avmcard *card)
 			return 2;
 		c4outmeml(card->mbase+DOORBELL, DBELL_ADDR);
 		mb();
+		cpu_relax();
 	}
 
 	c4_poke(card, DC21285_ARMCSR_BASE + CHAN_1_CONTROL, 0);
-- 
1.4.1

