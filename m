Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318305AbSHKKrp>; Sun, 11 Aug 2002 06:47:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318312AbSHKKrp>; Sun, 11 Aug 2002 06:47:45 -0400
Received: from mail.parknet.co.jp ([210.134.213.6]:55048 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP
	id <S318305AbSHKKro>; Sun, 11 Aug 2002 06:47:44 -0400
To: Leopold Gouverneur <lgouv@pi.be>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.3[01] does not boot for me
References: <20020811081929.GA693@gouv>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Sun, 11 Aug 2002 19:51:21 +0900
In-Reply-To: <20020811081929.GA693@gouv>
Message-ID: <87it2h7jo6.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Leopold Gouverneur <lgouv@pi.be> writes:

> 2.5.31 hangs during boot after:
> 
> hde 60036480 sectors w/1916 KiB cache CHS=59560/16/63, UDMA(44)
> hde hde1 hde2 hde3 hde4 <
> 
> hde is a  IBM-DTLA-307030 on a HPT366 (Abit BP6) 2.5.29 boot OK
> Sorry if it is a known problem!

Sound like the same problem as me. If so, the following patch should
be solves this problem.

Can you try patch?
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>

--- tools/linux-2.5.31/drivers/ide/pcidma.c	2002-08-05 03:01:09.000000000 +0900
+++ ide_pcidma-2.5.31/drivers/ide/pcidma.c	2002-08-11 18:46:42.000000000 +0900
@@ -391,22 +391,20 @@
 	sg = ch->sg_table;
 	while (i--) {
 		u32 cur_addr = sg_dma_address(sg);
-		u32 cur_len = sg_dma_len(sg) & 0xffff;
+		u32 cur_len = sg_dma_len(sg);
 
 		/* Delete this test after linux ~2.5.35, as we care
 		   about performance in this loop. */
 		BUG_ON(cur_len > ch->max_segment_size);
 
 		*table++ = cpu_to_le32(cur_addr);
-		*table++ = cpu_to_le32(cur_len);
+		*table++ = cpu_to_le32(cur_len & 0xffff);
 
 		sg++;
 	}
 
-#ifdef CONFIG_BLK_DEV_TRM290
-	if (ch->chipset == ide_trm290)
+	if (ch->chipset != ide_trm290)
 		*--table |= cpu_to_le32(0x80000000);
-#endif
 
 	return ch->sg_nents;
 }
