Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131154AbQKIWX0>; Thu, 9 Nov 2000 17:23:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131299AbQKIWXP>; Thu, 9 Nov 2000 17:23:15 -0500
Received: from [62.172.234.2] ([62.172.234.2]:63108 "EHLO saturn.homenet")
	by vger.kernel.org with ESMTP id <S131154AbQKIWXA>;
	Thu, 9 Nov 2000 17:23:00 -0500
Date: Thu, 9 Nov 2000 22:23:46 +0000 (GMT)
From: Tigran Aivazian <tigran@aivazian.fsnet.co.uk>
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel@vger.kernel.org
Subject: [patch-2.4.0-test11-pre1] broken comment around paging_init()
Message-ID: <Pine.LNX.4.21.0011092219450.827-100000@saturn.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

The comment above arch/i386/mm/init.c:paging_init() lies shamelessly -- we
set up two page tables in head.S which cover 0-8M and not 0-4M. Also, the
actual loop in head.S which does the job uses labels pg0 and
empty_zero_page so the pointer to the second page table (pg1) is
redundant.

(strictly speaking, the comment in asm/pgtable.h about pg0 covering 0-4M
only is confusing because it fails to mention the other one covering the
next 4M but it is correct so I left it as is).

Regards,
Tigran

diff -urN -X dontdiff linux/arch/i386/kernel/head.S work/arch/i386/kernel/head.S
--- linux/i386/kernel/head.S	Wed Jul  5 20:03:12 2000
+++ work/arch/i386/kernel/head.S	Thu Nov  9 22:12:18 2000
@@ -403,9 +403,6 @@
 .org 0x2000
 ENTRY(pg0)
 
-.org 0x3000
-ENTRY(pg1)
-
 /*
  * empty_zero_page must immediately follow the page tables ! (The
  * initialization loop counts until empty_zero_page)
diff -urN -X dontdiff linux/arch/i386/mm/init.c work/arch/i386/mm/init.c
--- linux/arch/i386/mm/init.c	Mon Oct 23 22:42:33 2000
+++ work/arch/i386/mm/init.c	Thu Nov  9 22:11:15 2000
@@ -437,7 +437,7 @@
 }
 
 /*
- * paging_init() sets up the page tables - note that the first 4MB are
+ * paging_init() sets up the page tables - note that the first 8MB are
  * already mapped by head.S.
  *
  * This routines also unmaps the page at virtual kernel address 0, so

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
