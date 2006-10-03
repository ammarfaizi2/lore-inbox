Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030360AbWJCRdQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030360AbWJCRdQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Oct 2006 13:33:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030359AbWJCRbq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Oct 2006 13:31:46 -0400
Received: from e31.co.us.ibm.com ([32.97.110.149]:55695 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S1030360AbWJCRbD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Oct 2006 13:31:03 -0400
Date: Tue, 3 Oct 2006 13:15:31 -0400
From: Vivek Goyal <vgoyal@in.ibm.com>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Cc: Reloc Kernel List <fastboot@lists.osdl.org>, ebiederm@xmission.com,
       akpm@osdl.org, ak@suse.de, horms@verge.net.au, lace@jankratochvil.net,
       hpa@zytor.com, magnus.damm@gmail.com, lwang@redhat.com,
       dzickus@redhat.com, maneesh@in.ibm.com
Subject: [PATCH 6/12] i386: CONFIG_PHYSICAL_START cleanup
Message-ID: <20061003171531.GF3164@in.ibm.com>
Reply-To: vgoyal@in.ibm.com
References: <20061003170032.GA30036@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061003170032.GA30036@in.ibm.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Defining __PHYSICAL_START and __KERNEL_START in asm-i386/page.h works but
it triggers a full kernel rebuild for the silliest of reasons.  This
modifies the users to directly use CONFIG_PHYSICAL_START and linux/config.h
which prevents the full rebuild problem, which makes the code much
more maintainer and hopefully user friendly.

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
Signed-off-by: Vivek Goyal <vgoyal@in.ibm.com>
---

 arch/i386/boot/compressed/head.S |    7 +++----
 arch/i386/boot/compressed/misc.c |    8 ++++----
 arch/i386/kernel/vmlinux.lds.S   |    3 ++-
 include/asm-i386/page.h          |    3 ---
 4 files changed, 9 insertions(+), 12 deletions(-)

diff -puN arch/i386/boot/compressed/head.S~i386-CONFIG_PHYSICAL_START-cleanup arch/i386/boot/compressed/head.S
--- linux-2.6.18-git17/arch/i386/boot/compressed/head.S~i386-CONFIG_PHYSICAL_START-cleanup	2006-10-02 13:17:58.000000000 -0400
+++ linux-2.6.18-git17-root/arch/i386/boot/compressed/head.S	2006-10-02 14:33:44.000000000 -0400
@@ -25,7 +25,6 @@
 
 #include <linux/linkage.h>
 #include <asm/segment.h>
-#include <asm/page.h>
 
 	.globl startup_32
 	
@@ -75,7 +74,7 @@ startup_32:
 	popl %esi	# discard address
 	popl %esi	# real mode pointer
 	xorl %ebx,%ebx
-	ljmp $(__BOOT_CS), $__PHYSICAL_START
+	ljmp $(__BOOT_CS), $CONFIG_PHYSICAL_START
 
 /*
  * We come here, if we were loaded high.
@@ -100,7 +99,7 @@ startup_32:
 	popl %ecx	# lcount
 	popl %edx	# high_buffer_start
 	popl %eax	# hcount
-	movl $__PHYSICAL_START,%edi
+	movl $CONFIG_PHYSICAL_START,%edi
 	cli		# make sure we don't get interrupted
 	ljmp $(__BOOT_CS), $0x1000 # and jump to the move routine
 
@@ -125,5 +124,5 @@ move_routine_start:
 	movsl
 	movl %ebx,%esi	# Restore setup pointer
 	xorl %ebx,%ebx
-	ljmp $(__BOOT_CS), $__PHYSICAL_START
+	ljmp $(__BOOT_CS), $CONFIG_PHYSICAL_START
 move_routine_end:
diff -puN arch/i386/boot/compressed/misc.c~i386-CONFIG_PHYSICAL_START-cleanup arch/i386/boot/compressed/misc.c
--- linux-2.6.18-git17/arch/i386/boot/compressed/misc.c~i386-CONFIG_PHYSICAL_START-cleanup	2006-10-02 13:17:58.000000000 -0400
+++ linux-2.6.18-git17-root/arch/i386/boot/compressed/misc.c	2006-10-02 14:33:44.000000000 -0400
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
@@ -303,7 +303,7 @@ static void setup_normal_output_buffer(v
 #else
 	if ((RM_ALT_MEM_K > RM_EXT_MEM_K ? RM_ALT_MEM_K : RM_EXT_MEM_K) < 1024) error("Less than 2MB of memory");
 #endif
-	output_data = (unsigned char *)__PHYSICAL_START; /* Normally Points to 1M */
+	output_data = (unsigned char *)CONFIG_PHYSICAL_START; /* Normally Points to 1M */
 	free_mem_end_ptr = (long)real_mode;
 }
 
@@ -326,8 +326,8 @@ static void setup_output_buffer_if_we_ru
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
diff -puN arch/i386/kernel/vmlinux.lds.S~i386-CONFIG_PHYSICAL_START-cleanup arch/i386/kernel/vmlinux.lds.S
--- linux-2.6.18-git17/arch/i386/kernel/vmlinux.lds.S~i386-CONFIG_PHYSICAL_START-cleanup	2006-10-02 13:17:58.000000000 -0400
+++ linux-2.6.18-git17-root/arch/i386/kernel/vmlinux.lds.S	2006-10-02 14:33:13.000000000 -0400
@@ -4,6 +4,7 @@
 
 #define LOAD_OFFSET __PAGE_OFFSET
 
+#include <linux/config.h>
 #include <asm-generic/vmlinux.lds.h>
 #include <asm/thread_info.h>
 #include <asm/page.h>
@@ -21,7 +22,7 @@ PHDRS {
 }
 SECTIONS
 {
-  . = __KERNEL_START;
+  . = LOAD_OFFSET + CONFIG_PHYSICAL_START;
   phys_startup_32 = startup_32 - LOAD_OFFSET;
   /* read-only */
   .text : AT(ADDR(.text) - LOAD_OFFSET) {
diff -puN include/asm-i386/page.h~i386-CONFIG_PHYSICAL_START-cleanup include/asm-i386/page.h
--- linux-2.6.18-git17/include/asm-i386/page.h~i386-CONFIG_PHYSICAL_START-cleanup	2006-10-02 13:17:58.000000000 -0400
+++ linux-2.6.18-git17-root/include/asm-i386/page.h	2006-10-02 13:17:58.000000000 -0400
@@ -112,12 +112,9 @@ extern int page_is_ram(unsigned long pag
 
 #ifdef __ASSEMBLY__
 #define __PAGE_OFFSET		CONFIG_PAGE_OFFSET
-#define __PHYSICAL_START	CONFIG_PHYSICAL_START
 #else
 #define __PAGE_OFFSET		((unsigned long)CONFIG_PAGE_OFFSET)
-#define __PHYSICAL_START	((unsigned long)CONFIG_PHYSICAL_START)
 #endif
-#define __KERNEL_START		(__PAGE_OFFSET + __PHYSICAL_START)
 
 
 #define PAGE_OFFSET		((unsigned long)__PAGE_OFFSET)
_
