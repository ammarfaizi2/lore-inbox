Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271905AbRH2Nv0>; Wed, 29 Aug 2001 09:51:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271889AbRH2NvS>; Wed, 29 Aug 2001 09:51:18 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:25098 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S271965AbRH2NvG>; Wed, 29 Aug 2001 09:51:06 -0400
Date: Wed, 29 Aug 2001 06:48:26 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Andreas Bombe <andreas.bombe@munich.netsurf.de>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] yenta resource allocation fix
In-Reply-To: <20010829013318.A16910@storm.local>
Message-ID: <Pine.LNX.4.33.0108290645140.8173-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 29 Aug 2001, Andreas Bombe wrote:
>
> I have no idea why the 0xfff was in place.  Or, on second thought, this
> might be to allocate memory space behind official end as slack?  This
> would defy the end > start check then, anyway.  Linus?

I've looked more at the issue.

0xfff is definitely right for memory windows and is generally right for
PCI-PCI bridges too - they cannot have IO or memory windows that are
anything but 4kB aligned.

But it turns out that the Yenta specification actually expanded on the
PCI-PCI bridge window specs for IO space - a Yenta bridge is supposed to
be able to handle IO windows at 4-byte granularity, not the 4kB a regular
PCI bridge does.

Does this alternate patch work for you?

		Linus

------
diff -u --recursive --new-file pre2/linux/drivers/pcmcia/yenta.c linux/drivers/pcmcia/yenta.c
--- pre2/linux/drivers/pcmcia/yenta.c	Wed Aug 29 06:20:01 2001
+++ linux/drivers/pcmcia/yenta.c	Wed Aug 29 06:13:40 2001
@@ -702,6 +702,12 @@
 	u32 start, end;
 	u32 align, size, min, max;
 	unsigned offset;
+	unsigned mask;
+
+	/* The granularity of the memory limit is 4kB, on IO it's 4 bytes */
+	mask = ~0xfff;
+	if (type & IORESOURCE_IO)
+		mask = ~3;

 	offset = 0x1c + 8*nr;
 	bus = socket->dev->subordinate;
@@ -715,8 +721,8 @@
 	if (!root)
 		return;

-	start = config_readl(socket, offset);
-	end = config_readl(socket, offset+4) | 0xfff;
+	start = config_readl(socket, offset) & mask;
+	end = config_readl(socket, offset+4) | ~mask;
 	if (start && end > start) {
 		res->start = start;
 		res->end = end;
diff -u --recursive --new-file pre2/linux/mm/vmscan.c linux/mm/vmscan.c
--- pre2/linux/mm/vmscan.c	Wed Aug 15 02:37:07 2001
+++ linux/mm/vmscan.c	Wed Aug 29 06:02:46 2001
@@ -818,10 +818,12 @@
 #define GENERAL_SHORTAGE 4
 static int do_try_to_free_pages(unsigned int gfp_mask, int user)
 {
-	/* Always walk at least the active queue when called */
-	int shortage = INACTIVE_SHORTAGE;
+	int shortage = 0;
 	int maxtry;

+	/* Always walk at least the active queue when called */
+	refill_inactive_scan(DEF_PRIORITY);
+
 	maxtry = 1 << DEF_PRIORITY;
 	do {
 		/*
@@ -872,7 +874,8 @@
 			break;
 	} while (shortage);

-	return !shortage;
+	/* Return success if we're not "totally short" */
+	return shortage != FREE_SHORTAGE | INACTIVE_SHORTAGE | GENERAL_SHORTAGE;
 }

 DECLARE_WAIT_QUEUE_HEAD(kswapd_wait);

