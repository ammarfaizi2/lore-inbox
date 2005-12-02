Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750708AbVLBVAd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750708AbVLBVAd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Dec 2005 16:00:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750751AbVLBVAc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Dec 2005 16:00:32 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.142]:63705 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750708AbVLBVAc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Dec 2005 16:00:32 -0500
Message-ID: <4390B6CA.2090006@vnet.ibm.com>
Date: Fri, 02 Dec 2005 15:04:10 -0600
From: Thomas Gall <tom_gall@vnet.ibm.com>
User-Agent: Mozilla Thunderbird 1.0.2 (Macintosh/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: MTD: fix possible starvation in cfi_cmdset_0001.c
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below fixes a potential starvation issue that can arise when
there is contention on a chip during a period when a process is
currently writing to it.  The starvation is avoided by conditionally
rescheduling when the chip is left in a state usable by other processes.

Please CC Josh and myself and replies.  Thanks!

Signed-off-by: Josh Boyer <jdub@us.ibm.com>
Signed-off-by: Tom Gall <tom_gall@vnet.ibm.com>

 drivers/mtd/chips/cfi_cmdset_0001.c |    5 +++++
 1 files changed, 5 insertions(+)

Index: mtd/drivers/mtd/chips/cfi_cmdset_0001.c
===================================================================
--- mtd.orig/drivers/mtd/chips/cfi_cmdset_0001.c	2005-11-07 15:04:33.000000000 -0600
+++ mtd/drivers/mtd/chips/cfi_cmdset_0001.c	2005-11-08 08:54:54.000000000 -0600
@@ -1695,6 +1695,11 @@ static int cfi_intelext_writev (struct m
 			if (chipnum == cfi->numchips)
 				return 0;
 		}
+
+		/* Be nice and reschedule with the chip in a usable state for other
+		   processes. */
+		cond_resched();
+
 	} while (len);

 	return 0;

-- 
Linux Technology Center
Senior Software Engineer, - Embedded Linux                                              
w) tom_gall@vnet.ibm.com    553-4558
h) tgall@uberh4x0r.org
"We want great men who, when fortune frowns, will not be discouraged." 
-- Colonel Henry Knox

