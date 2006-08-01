Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932616AbWHALFX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932616AbWHALFX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 07:05:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932627AbWHALFX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 07:05:23 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:51932 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S932616AbWHALFW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 07:05:22 -0400
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: <fastboot@osdl.org>
Cc: <linux-kernel@vger.kernel.org>, Horms <horms@verge.net.au>,
       Jan Kratochvil <lace@jankratochvil.net>,
       "H. Peter Anvin" <hpa@zytor.com>, Magnus Damm <magnus.damm@gmail.com>,
       Vivek Goyal <vgoyal@in.ibm.com>, Linda Wang <lwang@redhat.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>
Subject: [PATCH 4/33] i386: CONFIG_PHYSICAL_START cleanup
Date: Tue,  1 Aug 2006 05:03:19 -0600
Message-Id: <11544302312298-git-send-email-ebiederm@xmission.com>
X-Mailer: git-send-email 1.4.2.rc2.g5209e
In-Reply-To: <m1d5bk2046.fsf@ebiederm.dsl.xmission.com>
References: <m1d5bk2046.fsf@ebiederm.dsl.xmission.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Defining __PHYSICAL_START and __KERNEL_START in asm-i386/page.h works but
it triggers a full kernel rebuild for the silliest of reasons.  This
modifies the users to directly use CONFIG_PHYSICAL_START and linux/config.h
which prevents the full rebuild problem, which makes the code much
more maintainer and hopefully user friendly.

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
---
 arch/i386/boot/compressed/head.S |    8 ++++----
 arch/i386/boot/compressed/misc.c |    8 ++++----
 arch/i386/kernel/vmlinux.lds.S   |    3 ++-
 include/asm-i386/page.h          |    3 ---
 4 files changed, 10 insertions(+), 12 deletions(-)

diff --git a/arch/i386/boot/compressed/head.S b/arch/i386/boot/compressed/head.S
index b5893e4..8f28ecd 100644
--- a/arch/i386/boot/compressed/head.S
+++ b/arch/i386/boot/compressed/head.S
@@ -23,9 +23,9 @@
  */
 .text
 
+#include <linux/config.h>
 #include <linux/linkage.h>
 #include <asm/segment.h>
-#include <asm/page.h>
 
 	.globl startup_32
 	
@@ -75,7 +75,7 @@ startup_32:
 	popl %esi	# discard address
 	popl %esi	# real mode pointer
 	xorl %ebx,%ebx
-	ljmp $(__BOOT_CS), $__PHYSICAL_START
+	ljmp $(__BOOT_CS), $CONFIG_PHYSICAL_START
 
 /*
  * We come here, if we were loaded high.
@@ -100,7 +100,7 @@ startup_32:
 	popl %ecx	# lcount
 	popl %edx	# high_buffer_start
 	popl %eax	# hcount
-	movl $__PHYSICAL_START,%edi
+	movl $CONFIG_PHYSICAL_START,%edi
 	cli		# make sure we don't get interrupted
 	ljmp $(__BOOT_CS), $0x1000 # and jump to the move routine
 
@@ -125,5 +125,5 @@ move_routine_start:
 	movsl
 	movl %ebx,%esi	# Restore setup pointer
 	xorl %ebx,%ebx
-	ljmp $(__BOOT_CS), $__PHYSICAL_START
+	ljmp $(__BOOT_CS), $CONFIG_PHYSICAL_START
 move_routine_end:
diff --git a/arch/i386/boot/compressed/misc.c b/arch/i386/boot/compressed/misc.c
index b2ccd54..905c37e 100644
--- a/arch/i386/boot/compressed/misc.c
+++ b/arch/i386/boot/compressed/misc.c
@@ -9,11 +9,11 @@
  * High loaded stuff by Hans Lermen & Werner Almesberger, Feb. 1996
  */
 
+#include <linux/config.h>
 #include <linux/linkage.h>
 #include <linux/vmalloc.h>
 #include <linux/screen_info.h>
 #include <asm/io.h>
-#include <asm/page.h>
 
 /*
  * gzip declarations
@@ -303,7 +303,7 @@ #ifdef STANDARD_MEMORY_BIOS_CALL
 #else
 	if ((RM_ALT_MEM_K > RM_EXT_MEM_K ? RM_ALT_MEM_K : RM_EXT_MEM_K) < 1024) error("Less than 2MB of memory");
 #endif
-	output_data = (unsigned char *)__PHYSICAL_START; /* Normally Points to 1M */
+	output_data = (unsigned char *)CONFIG_PHYSICAL_START; /* Normally Points to 1M */
 	free_mem_end_ptr = (long)real_mode;
 }
 
@@ -326,8 +326,8 @@ #endif	
 	low_buffer_size = low_buffer_end - LOW_BUFFER_START;
 	high_loaded = 1;
 	free_mem_end_ptr = (long)high_buffer_start;
-	if ( (__PHYSICAL_START + low_buffer_size) > ((ulg)high_buffer_start)) {
-		high_buffer_start = (uch *)(__PHYSICAL_START + low_buffer_size);
+	if ( (CONFIG_PHYSICAL_START + low_buffer_size) > ((ulg)high_buffer_start)) {
+		high_buffer_start = (uch *)(CONFIG_PHYSICAL_START + low_buffer_size);
 		mv->hcount = 0; /* say: we need not to move high_buffer */
 	}
 	else mv->hcount = -1;
diff --git a/arch/i386/kernel/vmlinux.lds.S b/arch/i386/kernel/vmlinux.lds.S
index db0833b..8bcf0e1 100644
--- a/arch/i386/kernel/vmlinux.lds.S
+++ b/arch/i386/kernel/vmlinux.lds.S
@@ -4,6 +4,7 @@
 
 #define LOAD_OFFSET __PAGE_OFFSET
 
+#include <linux/config.h>
 #include <asm-generic/vmlinux.lds.h>
 #include <asm/thread_info.h>
 #include <asm/page.h>
@@ -15,7 +16,7 @@ ENTRY(phys_startup_32)
 jiffies = jiffies_64;
 SECTIONS
 {
-  . = __KERNEL_START;
+  . = LOAD_OFFSET + CONFIG_PHYSICAL_START;
   phys_startup_32 = startup_32 - LOAD_OFFSET;
   /* read-only */
   .text : AT(ADDR(.text) - LOAD_OFFSET) {
diff --git a/include/asm-i386/page.h b/include/asm-i386/page.h
index eceb7f5..1af9f6b 100644
--- a/include/asm-i386/page.h
+++ b/include/asm-i386/page.h
@@ -112,12 +112,9 @@ #endif /* __ASSEMBLY__ */
 
 #ifdef __ASSEMBLY__
 #define __PAGE_OFFSET		CONFIG_PAGE_OFFSET
-#define __PHYSICAL_START	CONFIG_PHYSICAL_START
 #else
 #define __PAGE_OFFSET		((unsigned long)CONFIG_PAGE_OFFSET)
-#define __PHYSICAL_START	((unsigned long)CONFIG_PHYSICAL_START)
 #endif
-#define __KERNEL_START		(__PAGE_OFFSET + __PHYSICAL_START)
 
 
 #define PAGE_OFFSET		((unsigned long)__PAGE_OFFSET)
-- 
1.4.2.rc2.g5209e

