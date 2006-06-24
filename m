Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751048AbWFXTSd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751048AbWFXTSd (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jun 2006 15:18:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751051AbWFXTSd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jun 2006 15:18:33 -0400
Received: from aun.it.uu.se ([130.238.12.36]:33513 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S1751047AbWFXTSc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jun 2006 15:18:32 -0400
Date: Sat, 24 Jun 2006 21:18:27 +0200 (MEST)
Message-Id: <200606241918.k5OJIRaX001033@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@it.uu.se>
To: hostmaster@ed-soft.at, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] Fix boot on efi 32 bit Machines [try #2]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Jun 2006 11:43:02 +0200, Edgar Hucek wrote:
>Fix EFI boot on 32 bit machines with pcie port.
>Efi machines does not have an e820 memory map.
>This bug makes native efi boots on Intel Mac's
>impossible.
>
>Signed-off-by: Edgar Hucek <hostmaster@ed-soft.at>
>
>--- a/arch/i386/kernel/setup.c	2006-06-19 09:12:09.000000000 +0200
>+++ b/arch/i386/kernel/setup.c	2006-06-19 09:12:24.000000000 +0200
>@@ -975,24 +975,28 @@
> 	u64 start = s;
> 	u64 end = e;
> 	int i;
>-	for (i = 0; i < e820.nr_map; i++) {
>-		struct e820entry *ei = &e820.map[i];
>-		if (type && ei->type != type)
>-			continue;
>-		/* is the region (part) in overlap with the current region ?*/
>-		if (ei->addr >= end || ei->addr + ei->size <= start)
>-			continue;
>-		/* if the region is at the beginning of <start,end> we move
>-		 * start to the end of the region since it's ok until there
>-		 */
>-		if (ei->addr <= start)
>-			start = ei->addr + ei->size;
>-		/* if start is now at or beyond end, we're done, full
>-		 * coverage */
>-		if (start >= end)
>-			return 1; /* we're done */
>+	if (!efi_enabled) {
>+		for (i = 0; i < e820.nr_map; i++) {
>+			struct e820entry *ei = &e820.map[i];
>+			if (type && ei->type != type)
>+				continue;
>+			/* is the region (part) in overlap with the current region ?*/
>+			if (ei->addr >= end || ei->addr + ei->size <= start)
>+				continue;
>+			/* if the region is at the beginning of <start,end> we move
>+			 * start to the end of the region since it's ok until there
>+			 */
>+			if (ei->addr <= start)
>+				start = ei->addr + ei->size;
>+			/* if start is now at or beyond end, we're done, full
>+			 * coverage */
>+			if (start >= end)
>+				return 1; /* we're done */
>+		}
>+		return 0;
>+	} else {
>+		return 1;
> 	}
>-	return 0;
> }

It looks like all this patch does is to put the existing
for() loop inside an "if (!efi_enabled)", changing its
indentation in the process. It would be MUCH cleaner to
just prefix the original e820 code with an

	if (efi_enabled)
		return 1;

statement. It reduces the size of the patch, and makes it
clear that none of the existing e820 code is altered.

/Mikael
