Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750892AbWDXPGP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750892AbWDXPGP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 11:06:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750886AbWDXPGF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 11:06:05 -0400
Received: from mtagate3.de.ibm.com ([195.212.29.152]:45135 "EHLO
	mtagate3.de.ibm.com") by vger.kernel.org with ESMTP
	id S1750888AbWDXPGB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 11:06:01 -0400
Date: Mon, 24 Apr 2006 17:06:03 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: linux-kernel@vger.kernel.org, akpm@osdl.org, cborntra@de.ibm.com
Subject: [patch 12/13] s390: add read_mostly optimization.
Message-ID: <20060424150603.GM15613@skybase>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christian Borntraeger <cborntra@de.ibm.com>

[patch 12/13] s390: add read_mostly optimization.

Add a read_mostly section and define __read_mostly to prevent cache
line pollution due to writes for mostly read variables. In addition
fix the incorrect alignment of the cache_line_aligned data section.
s390 has a cacheline size of 256 bytes.

Signed-off-by: Christian Borntraeger <cborntra@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/s390/kernel/vmlinux.lds.S |    4 +++-
 include/asm-s390/cache.h       |    2 ++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff -urpN linux-2.6/arch/s390/kernel/vmlinux.lds.S linux-2.6-patched/arch/s390/kernel/vmlinux.lds.S
--- linux-2.6/arch/s390/kernel/vmlinux.lds.S	2006-03-20 06:53:29.000000000 +0100
+++ linux-2.6-patched/arch/s390/kernel/vmlinux.lds.S	2006-04-24 16:47:29.000000000 +0200
@@ -58,9 +58,11 @@ SECTIONS
   . = ALIGN(4096);
   .data.page_aligned : { *(.data.idt) }
 
-  . = ALIGN(32);
+  . = ALIGN(256);
   .data.cacheline_aligned : { *(.data.cacheline_aligned) }
 
+  . = ALIGN(256);
+  .data.read_mostly : { *(.data.read_mostly) }
   _edata = .;			/* End of data section */
 
   . = ALIGN(8192);		/* init_task */
diff -urpN linux-2.6/include/asm-s390/cache.h linux-2.6-patched/include/asm-s390/cache.h
--- linux-2.6/include/asm-s390/cache.h	2006-03-20 06:53:29.000000000 +0100
+++ linux-2.6-patched/include/asm-s390/cache.h	2006-04-24 16:47:29.000000000 +0200
@@ -16,4 +16,6 @@
 
 #define ARCH_KMALLOC_MINALIGN	8
 
+#define __read_mostly __attribute__((__section__(".data.read_mostly")))
+
 #endif
