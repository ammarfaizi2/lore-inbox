Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261505AbVCCGSr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261505AbVCCGSr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 01:18:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261470AbVCCGPt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 01:15:49 -0500
Received: from fire.osdl.org ([65.172.181.4]:44752 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261505AbVCCGKJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 01:10:09 -0500
Date: Wed, 2 Mar 2005 21:48:28 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: lkml <linux-kernel@vger.kernel.org>
Cc: akpm <akpm@osdl.org>, viro <viro@parcelfarce.linux.theplanet.co.uk>
Subject: [PATCH] procfs: fix printk arg type warning
Message-Id: <20050302214828.5ff52893.rddunlap@osdl.org>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On sparc32 build, there is a printk format arg-type warning:
fs/proc/proc_misc.c:195: warning: long unsigned int format, unsigned int arg (arg 23)

I tried to fix it with a change to asm-sparc/vaddrs.h:
-#define VMALLOC_START          0xfe600000
+#define VMALLOC_START          0xfe600000UL
-#define VMALLOC_END            0xffc00000
+#define VMALLOC_END            0xffc00000UL

but that won't fly because the #defines are used in asm code
and asm doesn't like the UL suffixes (reported by Bill Irwin).

Signed-off-by: Randy Dunlap <rddunlap@osdl.org>

diffstat:=
 fs/proc/proc_misc.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -Naurp ./fs/proc/proc_misc.c~proc_misc_printk ./fs/proc/proc_misc.c
--- ./fs/proc/proc_misc.c~proc_misc_printk	2005-03-01 23:37:49.000000000 -0800
+++ ./fs/proc/proc_misc.c	2005-03-02 20:47:33.305279976 -0800
@@ -189,7 +189,7 @@ static int meminfo_read_proc(char *page,
 		K(allowed),
 		K(committed),
 		K(ps.nr_page_table_pages),
-		VMALLOC_TOTAL >> 10,
+		(unsigned long)VMALLOC_TOTAL >> 10,
 		vmi.used >> 10,
 		vmi.largest_chunk >> 10
 		);

---
