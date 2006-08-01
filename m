Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932631AbWHALQv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932631AbWHALQv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 07:16:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932646AbWHALQW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 07:16:22 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:4573 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S932647AbWHALFs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 07:05:48 -0400
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: <fastboot@osdl.org>
Cc: <linux-kernel@vger.kernel.org>, Horms <horms@verge.net.au>,
       Jan Kratochvil <lace@jankratochvil.net>,
       "H. Peter Anvin" <hpa@zytor.com>, Magnus Damm <magnus.damm@gmail.com>,
       Vivek Goyal <vgoyal@in.ibm.com>, Linda Wang <lwang@redhat.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>
Subject: [PATCH 23/33] x86_64: cleanup segments
Date: Tue,  1 Aug 2006 05:03:38 -0600
Message-Id: <11544302413334-git-send-email-ebiederm@xmission.com>
X-Mailer: git-send-email 1.4.2.rc2.g5209e
In-Reply-To: <m1d5bk2046.fsf@ebiederm.dsl.xmission.com>
References: <m1d5bk2046.fsf@ebiederm.dsl.xmission.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Move __KERNEL32_CS up into the unused gdt entry.  __KERNEL32_CS is
used when entering the kernel so putting it first is useful when
trying to keep boot gdt sizes to a minimum.

Set the accessed bit on all gdt entries.  We don't care
so there is no need for the cpu to burn the extra cycles,
and it potentially allows the pages to be immutable.  Plus
it is confusing when debugging and your gdt entries mysteriously
change.

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
---
 arch/x86_64/kernel/head.S    |   14 +++++++-------
 include/asm-x86_64/segment.h |    4 ++--
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/x86_64/kernel/head.S b/arch/x86_64/kernel/head.S
index a9e34d9..d0e626e 100644
--- a/arch/x86_64/kernel/head.S
+++ b/arch/x86_64/kernel/head.S
@@ -352,16 +352,16 @@ #endif
 	
 ENTRY(cpu_gdt_table)
 	.quad	0x0000000000000000	/* NULL descriptor */
+	.quad	0x00cf9b000000ffff	/* __KERNEL32_CS */
+	.quad	0x00af9b000000ffff	/* __KERNEL_CS */
+	.quad	0x00cf93000000ffff	/* __KERNEL_DS */
+	.quad	0x00cffb000000ffff	/* __USER32_CS */
+	.quad	0x00cff3000000ffff	/* __USER_DS, __USER32_DS  */
+	.quad	0x00affb000000ffff	/* __USER_CS */
 	.quad	0x0			/* unused */
-	.quad	0x00af9a000000ffff	/* __KERNEL_CS */
-	.quad	0x00cf92000000ffff	/* __KERNEL_DS */
-	.quad	0x00cffa000000ffff	/* __USER32_CS */
-	.quad	0x00cff2000000ffff	/* __USER_DS, __USER32_DS  */		
-	.quad	0x00affa000000ffff	/* __USER_CS */
-	.quad	0x00cf9a000000ffff	/* __KERNEL32_CS */
 	.quad	0,0			/* TSS */
 	.quad	0,0			/* LDT */
-	.quad   0,0,0			/* three TLS descriptors */ 
+	.quad   0,0,0			/* three TLS descriptors */
 	.quad	0			/* unused */
 gdt_end:	
 	/* asm/segment.h:GDT_ENTRIES must match this */	
diff --git a/include/asm-x86_64/segment.h b/include/asm-x86_64/segment.h
index d4bed33..58d6715 100644
--- a/include/asm-x86_64/segment.h
+++ b/include/asm-x86_64/segment.h
@@ -6,7 +6,7 @@ #include <asm/cache.h>
 #define __KERNEL_CS	0x10
 #define __KERNEL_DS	0x18
 
-#define __KERNEL32_CS   0x38
+#define __KERNEL32_CS   0x08
 
 /* 
  * we cannot use the same code segment descriptor for user and kernel
@@ -20,7 +20,7 @@ #define __USER_DS     0x2b   /* 5*8+3 */
 #define __USER_CS     0x33   /* 6*8+3 */ 
 #define __USER32_DS	__USER_DS 
 
-#define GDT_ENTRY_TLS 1
+#define GDT_ENTRY_TLS 7
 #define GDT_ENTRY_TSS 8	/* needs two entries */
 #define GDT_ENTRY_LDT 10 /* needs two entries */
 #define GDT_ENTRY_TLS_MIN 12
-- 
1.4.2.rc2.g5209e

