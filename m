Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262092AbUCOBbi (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Mar 2004 20:31:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262182AbUCOBbh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Mar 2004 20:31:37 -0500
Received: from pxy4allmi.all.mi.charter.com ([24.247.15.43]:15567 "EHLO
	proxy4.gha.chartermi.net") by vger.kernel.org with ESMTP
	id S262092AbUCOBbJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Mar 2004 20:31:09 -0500
Message-ID: <405507A6.60706@quark.didntduck.org>
Date: Sun, 14 Mar 2004 20:32:22 -0500
From: Brian Gerst <bgerst@didntduck.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040116
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: [PATCH] don't abuse empty_zero_page (x86)
Content-Type: multipart/mixed;
 boundary="------------020207000809090806090107"
X-Charter-MailScanner-Information: 
X-Charter-MailScanner: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020207000809090806090107
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Don't abuse empty_zero_page as temporary storage for boot parameters and 
command line.  This is a holdover from the days before discardable init 
sections.

--
				Brian Gerst

--------------020207000809090806090107
Content-Type: text/plain;
 name="empty_zero_page-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="empty_zero_page-1"

diff -urN linux-bk/arch/i386/boot/setup.S linux/arch/i386/boot/setup.S
--- linux-bk/arch/i386/boot/setup.S	2004-03-12 14:00:43.000000000 -0500
+++ linux/arch/i386/boot/setup.S	2004-03-12 15:32:55.000000000 -0500
@@ -612,7 +612,7 @@
 #    int 13h ah=08h "Legacy Get Device Parameters"
 #
 # A buffer of size EDDMAXNR*(EDDEXTSIZE+EDDPARMSIZE) is reserved for our use
-# in the empty_zero_page at EDDBUF.  The first four bytes of which are
+# in the boot_params at EDDBUF.  The first four bytes of which are
 # used to store the device number, interface support map and version
 # results from fn41.  The next four bytes are used to store the legacy
 # cylinders, heads, and sectors from fn08. The following 74 bytes are used to
@@ -625,9 +625,9 @@
 # the structure, and the fn41 and fn08 results are stored at offsets
 # from there.  This removes the need to increment the pointer for
 # every store, and leaves it ready for the fn48 call.
-# A second one-byte buffer, EDDNR, in the empty_zero_page stores
+# A second one-byte buffer, EDDNR, in boot_params stores
 # the number of BIOS devices which exist, up to EDDMAXNR.
-# In setup.c, copy_edd() stores both empty_zero_page buffers away
+# In setup.c, copy_edd() stores both boot_params buffers away
 # for later use, as they would get overwritten otherwise.
 # This code is sensitive to the size of the structs in edd.h
 edd_start:
diff -urN linux-bk/arch/i386/kernel/head.S linux/arch/i386/kernel/head.S
--- linux-bk/arch/i386/kernel/head.S	2004-03-12 14:00:43.000000000 -0500
+++ linux/arch/i386/kernel/head.S	2004-03-12 16:58:20.000000000 -0500
@@ -18,12 +18,7 @@
 #include <asm/cache.h>
 #include <asm/thread_info.h>
 #include <asm/asm_offsets.h>
-
-#define OLD_CL_MAGIC_ADDR	0x90020
-#define OLD_CL_MAGIC		0xA33F
-#define OLD_CL_BASE_ADDR	0x90000
-#define OLD_CL_OFFSET		0x90022
-#define NEW_CL_POINTER		0x228	/* Relative to real mode data */
+#include <asm/setup.h>
 
 /*
  * References to members of the new_cpu_data structure.
@@ -195,22 +190,15 @@
 	call setup_idt
 
 /*
- * Copy bootup parameters out of the way. First 2kB of
- * _empty_zero_page is for boot parameters, second 2kB
- * is for the command line.
- *
+ * Copy bootup parameters out of the way.
  * Note: %esi still has the pointer to the real-mode data.
  */
-	movl $empty_zero_page,%edi
-	movl $512,%ecx
+	movl $boot_params,%edi
+	movl $(PARAM_SIZE/4),%ecx
 	cld
 	rep
 	movsl
-	xorl %eax,%eax
-	movl $512,%ecx
-	rep
-	stosl
-	movl empty_zero_page+NEW_CL_POINTER,%esi
+	movl boot_params+NEW_CL_POINTER,%esi
 	andl %esi,%esi
 	jnz 2f			# New command line protocol
 	cmpw $(OLD_CL_MAGIC),OLD_CL_MAGIC_ADDR
@@ -218,8 +206,8 @@
 	movzwl OLD_CL_OFFSET,%esi
 	addl $(OLD_CL_BASE_ADDR),%esi
 2:
-	movl $empty_zero_page+2048,%edi
-	movl $512,%ecx
+	movl $saved_command_line,%edi
+	movl $(COMMAND_LINE_SIZE/4),%ecx
 	rep
 	movsl
 1:
diff -urN linux-bk/arch/i386/kernel/setup.c linux/arch/i386/kernel/setup.c
--- linux-bk/arch/i386/kernel/setup.c	2004-03-12 14:00:43.000000000 -0500
+++ linux/arch/i386/kernel/setup.c	2004-03-12 15:38:38.000000000 -0500
@@ -130,6 +130,8 @@
 static char command_line[COMMAND_LINE_SIZE];
        char saved_command_line[COMMAND_LINE_SIZE];
 
+unsigned char __initdata boot_params[PARAM_SIZE];
+
 static struct resource code_resource = { "Kernel code", 0x100000, 0 };
 static struct resource data_resource = { "Kernel data", 0, 0 };
 
@@ -456,7 +458,7 @@
 #endif
 /**
  * copy_edd() - Copy the BIOS EDD information
- *              from empty_zero_page into a safe place.
+ *              from boot_params into a safe place.
  *
  */
 static inline void copy_edd(void)
@@ -485,12 +487,11 @@
 
 static void __init parse_cmdline_early (char ** cmdline_p)
 {
-	char c = ' ', *to = command_line, *from = COMMAND_LINE;
+	char c = ' ', *to = command_line, *from = saved_command_line;
 	int len = 0;
 	int userdef = 0;
 
 	/* Save unparsed command line copy for /proc/cmdline */
-	memcpy(saved_command_line, COMMAND_LINE, COMMAND_LINE_SIZE);
 	saved_command_line[COMMAND_LINE_SIZE-1] = '\0';
 
 	for (;;) {
diff -urN linux-bk/arch/i386/mm/init.c linux/arch/i386/mm/init.c
--- linux-bk/arch/i386/mm/init.c	2004-02-15 00:41:30.000000000 -0500
+++ linux/arch/i386/mm/init.c	2004-03-12 15:41:51.000000000 -0500
@@ -474,9 +474,6 @@
 	high_memory = (void *) __va(max_low_pfn * PAGE_SIZE);
 #endif
 
-	/* clear the zero-page */
-	memset(empty_zero_page, 0, PAGE_SIZE);
-
 	/* this will put all low memory onto the freelists */
 	totalram_pages += __free_all_bootmem();
 
diff -urN linux-bk/Documentation/i386/zero-page.txt linux/Documentation/i386/zero-page.txt
--- linux-bk/Documentation/i386/zero-page.txt	2004-03-12 14:00:43.000000000 -0500
+++ linux/Documentation/i386/zero-page.txt	2004-03-12 17:38:15.000000000 -0500
@@ -1,7 +1,7 @@
-Summary of empty_zero_page layout (kernel point of view)
+Summary of boot_params layout (kernel point of view)
      ( collected by Hans Lermen and Martin Mares )
  
-The contents of empty_zero_page are used to pass parameters from the
+The contents of boot_params are used to pass parameters from the
 16-bit realmode code of the kernel to the 32-bit part. References/settings
 to it mainly are in:
 
@@ -76,9 +76,3 @@
 0x2d0 - 0x600		E820MAP
 0x600 - 0x7ff		EDDBUF (setup.S) for disk signature read sector
 0x600 - 0x7eb		EDDBUF (setup.S) for edd data
-
-0x800	string, 2K max	COMMAND_LINE, the kernel commandline as
-			copied using CL_OFFSET.
-			Note: this will be copied once more by setup.c
-			into a local buffer which is only 256 bytes long.
-			( #define COMMAND_LINE_SIZE 256 )
diff -urN linux-bk/include/asm-i386/setup.h linux/include/asm-i386/setup.h
--- linux-bk/include/asm-i386/setup.h	2004-02-18 01:37:26.000000000 -0500
+++ linux/include/asm-i386/setup.h	2004-03-12 15:44:17.000000000 -0500
@@ -16,10 +16,22 @@
 #define MAXMEM_PFN	PFN_DOWN(MAXMEM)
 #define MAX_NONPAE_PFN	(1 << 20)
 
+#define PARAM_SIZE 2048
+#define COMMAND_LINE_SIZE 256
+
+#define OLD_CL_MAGIC_ADDR	0x90020
+#define OLD_CL_MAGIC		0xA33F
+#define OLD_CL_BASE_ADDR	0x90000
+#define OLD_CL_OFFSET		0x90022
+#define NEW_CL_POINTER		0x228	/* Relative to real mode data */
+
+#ifndef __ASSEMBLY__
 /*
  * This is set up by the setup-routine at boot-time
  */
-#define PARAM	((unsigned char *)empty_zero_page)
+extern unsigned char boot_params[PARAM_SIZE];
+
+#define PARAM	(boot_params)
 #define SCREEN_INFO (*(struct screen_info *) (PARAM+0))
 #define EXT_MEM_K (*(unsigned short *) (PARAM+2))
 #define ALT_MEM_K (*(unsigned long *) (PARAM+0x1e0))
@@ -47,7 +59,7 @@
 #define DISK80_SIGNATURE (*(unsigned int*) (PARAM+DISK80_SIG_BUFFER))
 #define EDD_NR     (*(unsigned char *) (PARAM+EDDNR))
 #define EDD_BUF     ((struct edd_info *) (PARAM+EDDBUF))
-#define COMMAND_LINE ((char *) (PARAM+2048))
-#define COMMAND_LINE_SIZE 256
+
+#endif /* __ASSEMBLY__ */
 
 #endif /* _i386_SETUP_H */

--------------020207000809090806090107--
