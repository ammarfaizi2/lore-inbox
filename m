Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268501AbUJPFD5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268501AbUJPFD5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Oct 2004 01:03:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268497AbUJPFD4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Oct 2004 01:03:56 -0400
Received: from ozlabs.org ([203.10.76.45]:11666 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S268488AbUJPFDx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Oct 2004 01:03:53 -0400
Date: Sat, 16 Oct 2004 15:03:34 +1000
From: Anton Blanchard <anton@samba.org>
To: akpm@osdl.org
Cc: benh@kernel.crashing.org, paulus@samba.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ppc64: fix some issues with mem_reserve
Message-ID: <20041016050334.GA4005@krispykreme.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

I found a couple of issues with reserve_mem:

- If we try and mem_reserve something of zero length, everything
  reserved after it would get ignored. This is because early_reserve_mem 
  sees a zero length as a terminator.
- The code rounded the top down instead of up.

Signed-off-by: Anton Blanchard <anton@samba.org>

===== prom_init.c 1.2 vs edited =====
--- 1.2/arch/ppc64/kernel/prom_init.c	2004-09-27 19:12:49 +10:00
+++ edited/prom_init.c	2004-09-30 22:19:56 +10:00
@@ -587,17 +587,19 @@
 static void reserve_mem(unsigned long base, unsigned long size)
 {
 	unsigned long offset = reloc_offset();
-	unsigned long top = base + size;
 	unsigned long cnt = RELOC(mem_reserve_cnt);
 
-	/* We need to always keep one empty entry so that we
+	if (!size)
+		return;
+
+	base = _ALIGN_DOWN(base, PAGE_SIZE);
+	size = _ALIGN_UP(size, PAGE_SIZE);
+
+	/*
+	 * We need to always keep one empty entry so that we
 	 * have our terminator with "size" set to 0 since we are
 	 * dumb and just copy this entire array to the boot params
 	 */
-	base = _ALIGN_DOWN(base, PAGE_SIZE);
-	top = _ALIGN_DOWN(top, PAGE_SIZE);
-	size = top - base;
-
 	if (cnt >= (MEM_RESERVE_MAP_SIZE - 1))
 		prom_panic("Memory reserve map exhausted !\n");
 	RELOC(mem_reserve_map)[cnt].base = base;
