Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932418AbWFYOEU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932418AbWFYOEU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jun 2006 10:04:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932419AbWFYOEU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jun 2006 10:04:20 -0400
Received: from mxout.hispeed.ch ([62.2.95.247]:47823 "EHLO smtp.hispeed.ch")
	by vger.kernel.org with ESMTP id S932418AbWFYOET (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jun 2006 10:04:19 -0400
From: Daniel Ritz <daniel.ritz-ml@swissonline.ch>
To: Shaohua Li <shaohua.li@intel.com>, Pavel Machek <pavel@ucw.cz>,
       "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH] swsuspend breakage in 2.6.17-git
Date: Sun, 25 Jun 2006 16:05:09 +0200
User-Agent: KMail/1.7.2
Cc: "linux-kernel" <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606251605.10956.daniel.ritz-ml@swissonline.ch>
X-DCC-spamcheck-01.tornado.cablecom.ch-Metrics: smtp-01.tornado.cablecom.ch 1377;
	Body=6 Fuz1=6 Fuz2=6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hello

commit b6370d96e09944c6e3ae8d5743ca8a8ab1f79f6c:
	[PATCH] swsusp: i386 mark special saveable/unsaveable pages
breaks swsusp for me with a page fault in kernel/power/snapshot.c:save_arch_mem()

the following patch makes suspend-resume working again, but some
problems still remain: fan goes on and stays on after resume (same as
in bug #5000). i guess this is a due to a change in ACPI which i still
have to track down along with the problem that acpi is not powering-off
my other laptop anymore...

comments?

rgds
-daniel


[PATCH] fix swsuspend breakage in 2.6.17-git

trying to save ACPI NVS pages leads to a pagefault on a toshiba
tecra 8000 notebook. back out saving those.

Signed-off-by: Daniel Ritz <daniel.ritz@gmx.ch>

diff --git a/arch/i386/kernel/setup.c b/arch/i386/kernel/setup.c
index e602397..c0bdf47 100644
--- a/arch/i386/kernel/setup.c
+++ b/arch/i386/kernel/setup.c
@@ -1490,7 +1490,7 @@ static void __init e820_save_acpi_pages(
 		end = ei->addr + ei->size;
 		if (start >= end)
 			continue;
-		if (ei->type != E820_ACPI && ei->type != E820_NVS)
+		if (ei->type != E820_ACPI)
 			continue;
 		/*
 		 * If the region is below max_low_pfn, it will be
