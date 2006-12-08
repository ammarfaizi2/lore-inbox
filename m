Return-Path: <linux-kernel-owner+w=401wt.eu-S1425557AbWLHPWK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1425557AbWLHPWK (ORCPT <rfc822;w@1wt.eu>);
	Fri, 8 Dec 2006 10:22:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1425556AbWLHPWJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Dec 2006 10:22:09 -0500
Received: from mtagate4.de.ibm.com ([195.212.29.153]:41144 "EHLO
	mtagate4.de.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1425557AbWLHPWI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Dec 2006 10:22:08 -0500
Date: Fri, 8 Dec 2006 16:22:01 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: linux-kernel@vger.kernel.org, heiko.carstens@de.ibm.com
Subject: [S390] Poison init section before freeing it.
Message-ID: <20061208152201.GC15860@skybase>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Heiko Carstens <heiko.carstens@de.ibm.com>

[S390] Poison init section before freeing it.

The data patterns should allow us to easily tell if somebody accesses
initdata/code after it was freed. Same code as on various other
architectures.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/s390/mm/init.c |    2 ++
 1 files changed, 2 insertions(+)

diff -urpN linux-2.6/arch/s390/mm/init.c linux-2.6-patched/arch/s390/mm/init.c
--- linux-2.6/arch/s390/mm/init.c	2006-12-08 15:53:05.000000000 +0100
+++ linux-2.6-patched/arch/s390/mm/init.c	2006-12-08 15:53:05.000000000 +0100
@@ -24,6 +24,7 @@
 #include <linux/pagemap.h>
 #include <linux/bootmem.h>
 #include <linux/pfn.h>
+#include <linux/poison.h>
 
 #include <asm/processor.h>
 #include <asm/system.h>
@@ -187,6 +188,7 @@ void free_initmem(void)
         for (; addr < (unsigned long)(&__init_end); addr += PAGE_SIZE) {
 		ClearPageReserved(virt_to_page(addr));
 		init_page_count(virt_to_page(addr));
+		memset((void *)addr, POISON_FREE_INITMEM, PAGE_SIZE);
 		free_page(addr);
 		totalram_pages++;
         }
