Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265188AbUBEFXQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Feb 2004 00:23:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266013AbUBEFXQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Feb 2004 00:23:16 -0500
Received: from fw.osdl.org ([65.172.181.6]:19136 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265188AbUBEFXK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Feb 2004 00:23:10 -0500
Date: Wed, 4 Feb 2004 21:24:52 -0800
From: Andrew Morton <akpm@osdl.org>
To: mikem@beardog.cca.cpqcorp.net
Cc: axboe@suse.de, linux-kernel@vger.kernel.org
Subject: Re: cciss updates for 2.6 [9 of 11]
Message-Id: <20040204212452.64620e38.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0402041817280.18320@beardog.cca.cpqcorp.net>
References: <Pine.LNX.4.58.0402041817280.18320@beardog.cca.cpqcorp.net>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mikem@beardog.cca.cpqcorp.net wrote:
>
> +		vol_sz = drv->nr_blocks/ENG_GIG_FACTOR;
> +		vol_sz_frac = (drv->nr_blocks%ENG_GIG_FACTOR)*100/ENG_GIG_FACTOR;

This causes problems with CONFIG_LBD=y on ia32.

drivers/built-in.o: In function `cciss_proc_get_info':
/tmp/distcc_1108/drivers/block/cciss.c:217: undefined reference to `__udivdi3'
/tmp/distcc_1108/drivers/block/cciss.c:218: undefined reference to `__umoddi3'
/tmp/distcc_1108/drivers/block/cciss.c:218: undefined reference to `__udivdi3'

I'll include the below fix - could you please test it?  With both
CONFIG_LBD=y and CONFIG_LBD=n?

Thanks.


diff -puN drivers/block/cciss.c~cciss-64-bit-divide-fix drivers/block/cciss.c
--- 25/drivers/block/cciss.c~cciss-64-bit-divide-fix	2004-02-04 21:15:48.000000000 -0800
+++ 25-akpm/drivers/block/cciss.c	2004-02-04 21:15:48.000000000 -0800
@@ -211,11 +211,27 @@ static int cciss_proc_get_info(char *buf
         pos += size; len += size;
 	cciss_proc_tape_report(ctlr, buffer, &pos, &len);
 	for(i=0; i<h->highest_lun; i++) {
+		sector_t tmp;
+
                 drv = &h->drv[i];
 		if (drv->block_size == 0)
 			continue;
-		vol_sz = drv->nr_blocks/ENG_GIG_FACTOR;
-		vol_sz_frac = (drv->nr_blocks%ENG_GIG_FACTOR)*100/ENG_GIG_FACTOR;
+		vol_sz = drv->nr_blocks;
+		sector_div(vol_sz, ENG_GIG_FACTOR);
+
+		/*
+		 * Awkwardly do this:
+		 * vol_sz_frac =
+		 *     (drv->nr_blocks%ENG_GIG_FACTOR)*100/ENG_GIG_FACTOR;
+		 */
+		tmp = drv->nr_blocks;
+		vol_sz_frac = sector_div(tmp, ENG_GIG_FACTOR);
+
+		/* Now, vol_sz_frac = (drv->nr_blocks%ENG_GIG_FACTOR) */
+
+		vol_sz_frac *= 100;
+		sector_div(vol_sz_frac, ENG_GIG_FACTOR);
+
 		if (drv->raid_level > 5)
 			drv->raid_level = RAID_UNKNOWN;
 		size = sprintf(buffer+len, "cciss/c%dd%d:"

_

