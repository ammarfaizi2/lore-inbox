Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261630AbUCBMyR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Mar 2004 07:54:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261631AbUCBMyQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Mar 2004 07:54:16 -0500
Received: from pxy1allmi.all.mi.charter.com ([24.247.15.38]:34020 "EHLO
	proxy1.gha.chartermi.net") by vger.kernel.org with ESMTP
	id S261630AbUCBMyF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Mar 2004 07:54:05 -0500
Message-ID: <404483CF.3020808@quark.didntduck.org>
Date: Tue, 02 Mar 2004 07:53:35 -0500
From: Brian Gerst <bgerst@didntduck.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040116
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "H. Peter Anvin" <hpa@zytor.com>
CC: linux-kernel@vger.kernel.org, ebiederm@xmission.com
Subject: [PATCH] Clean up empty_zero_page abuse
References: <m1vflp81kq.fsf@ebiederm.dsl.xmission.com> <c21amp$769$1@terminus.zytor.com>
In-Reply-To: <c21amp$769$1@terminus.zytor.com>
Content-Type: multipart/mixed;
 boundary="------------090400020908030400050509"
X-Charter-MailScanner-Information: 
X-Charter-MailScanner: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090400020908030400050509
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

H. Peter Anvin wrote:
> Oh yes, with this change you should probably just move swapper_pg_dir
> (and empty_zero_page?) into .bss like anything else that should be
> zero after boot.

This patch (against EWB's boot segment patch) fixes the abuse of 
empty_zero_page for storing boot parameters.  This usage is an artifact 
from before we had discardable init sections.

- Move some constants to setup.h
- Copy the command line directly to saved_command_line
- Add boot_params as temporary storage of the parameters block
- Move empty_zero_page to .bss

--
				Brian Gerst

--------------090400020908030400050509
Content-Type: text/plain;
 name="empty_zero_page-B1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="empty_zero_page-B1"

diff -urN linux-bootseg/arch/i386/boot/setup.S linux/arch/i386/boot/setup.S
--- linux-bootseg/arch/i386/boot/setup.S	2004-02-28 23:35:03.000000000 -0500
+++ linux/arch/i386/boot/setup.S	2004-03-01 16:09:04.000000000 -0500
@@ -605,7 +605,7 @@
 #    int 13h ah=48h "Get Device Parameters"
 #
 # A buffer of size EDDMAXNR*(EDDEXTSIZE+EDDPARMSIZE) is reserved for our use
-# in the empty_zero_page at EDDBUF.  The first four bytes of which are
+# in boot_params at EDDBUF.  The first four bytes of which are
 # used to store the device number, interface support map and version
 # results from fn41.  The following 74 bytes are used to store
 # the results from fn48.  Starting from device 80h, fn41, then fn48
@@ -617,9 +617,9 @@
 # the structure, and the fn41 results are stored at offsets
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
diff -urN linux-bootseg/arch/i386/kernel/head.S linux/arch/i386/kernel/head.S
--- linux-bootseg/arch/i386/kernel/head.S	2004-03-01 16:12:47.000000000 -0500
+++ linux/arch/i386/kernel/head.S	2004-03-01 16:12:18.000000000 -0500
@@ -17,13 +17,7 @@
 #include <asm/desc.h>
 #include <asm/cache.h>
 #include <asm/thread_info.h>
-
-
-#define OLD_CL_MAGIC_ADDR	0x90020
-#define OLD_CL_MAGIC		0xA33F
-#define OLD_CL_BASE_ADDR	0x90000
-#define OLD_CL_OFFSET		0x90022
-#define NEW_CL_POINTER		0x228	/* Relative to real mode data */
+#include <asm/setup.h>
 
 /*
  * References to members of the new_cpu_data structure.
@@ -93,23 +87,16 @@
  */
 	call setup_idt
 /*
- * Copy bootup parameters out of the way. First 2kB of
- * _empty_zero_page is for boot parameters, second 2kB
- * is for the command line.
- *
+ * Copy bootup parameters out of the way.
  * Note: %esi still has the pointer to the real-mode data.
  * No need to cld as DF is already clear from above...
  */
 	addl $__PAGE_OFFSET, %esi	/* Make %esi virtual */
-	movl $empty_zero_page,%edi
-	movl $512,%ecx
+	movl $boot_params,%edi
+	movl $(PARAM_SIZE/4),%ecx
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
 	cmpw $(OLD_CL_MAGIC),OLD_CL_MAGIC_ADDR+__PAGE_OFFSET
@@ -118,8 +105,8 @@
 	addl $(OLD_CL_BASE_ADDR),%esi
 2:
 	addl $__PAGE_OFFSET, %esi	/* Make %esi virtual */
-	movl $empty_zero_page+2048,%edi
-	movl $512,%ecx
+	movl $saved_command_line,%edi
+	movl $(COMMAND_LINE_SIZE/4),%ecx
 	rep
 	movsl
 1:
@@ -399,10 +386,6 @@
 ENTRY(swapper_pg_dir)
 	.fill 1024,4,0
 
-.balign 4096
-ENTRY(empty_zero_page)
-	.fill 4096,1,0
-
 /*
  * Real beginning of normal "text" segment
  */
diff -urN linux-bootseg/arch/i386/kernel/setup.c linux/arch/i386/kernel/setup.c
--- linux-bootseg/arch/i386/kernel/setup.c	2004-02-28 23:35:03.000000000 -0500
+++ linux/arch/i386/kernel/setup.c	2004-03-01 16:15:48.000000000 -0500
@@ -126,6 +126,8 @@
 static char command_line[COMMAND_LINE_SIZE];
        char saved_command_line[COMMAND_LINE_SIZE];
 
+unsigned char __initdata boot_params[PARAM_SIZE] = { 0, };
+
 static struct resource code_resource = { "Kernel code", 0x100000, 0 };
 static struct resource data_resource = { "Kernel data", 0, 0 };
 
@@ -452,7 +454,7 @@
 #endif
 /**
  * copy_edd() - Copy the BIOS EDD information
- *              from empty_zero_page into a safe place.
+ *              from boot_param into a safe place.
  *
  */
 static inline void copy_edd(void)
@@ -481,12 +483,11 @@
 
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
diff -urN linux-bootseg/arch/i386/kernel/vmlinux.lds.S linux/arch/i386/kernel/vmlinux.lds.S
--- linux-bootseg/arch/i386/kernel/vmlinux.lds.S	2003-12-17 21:58:18.000000000 -0500
+++ linux/arch/i386/kernel/vmlinux.lds.S	2004-03-01 16:09:04.000000000 -0500
@@ -104,7 +104,12 @@
   /* freed after init ends here */
 	
   __bss_start = .;		/* BSS */
-  .bss : { *(.bss) }
+  .bss : {
+	. = ALIGN(4096);
+	empty_zero_page = .;
+	. = . + 4096;
+	*(.bss)
+  }
   __bss_stop = .; 
 
   _end = . ;
diff -urN linux-bootseg/arch/i386/mm/init.c linux/arch/i386/mm/init.c
--- linux-bootseg/arch/i386/mm/init.c	2004-03-01 16:12:47.000000000 -0500
+++ linux/arch/i386/mm/init.c	2004-03-01 16:09:04.000000000 -0500
@@ -476,9 +476,6 @@
 	high_memory = (void *) __va(max_low_pfn * PAGE_SIZE);
 #endif
 
-	/* clear the zero-page */
-	memset(empty_zero_page, 0, PAGE_SIZE);
-
 	/* this will put all low memory onto the freelists */
 	totalram_pages += __free_all_bootmem();
 
diff -urN linux-bootseg/include/asm-i386/setup.h linux/include/asm-i386/setup.h
--- linux-bootseg/include/asm-i386/setup.h	2004-02-18 01:37:26.000000000 -0500
+++ linux/include/asm-i386/setup.h	2004-03-01 16:09:04.000000000 -0500
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

--------------090400020908030400050509--
