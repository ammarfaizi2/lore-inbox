Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261737AbULBT0x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261737AbULBT0x (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Dec 2004 14:26:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261738AbULBT0x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Dec 2004 14:26:53 -0500
Received: from linux.us.dell.com ([143.166.224.162]:60781 "EHLO
	lists.us.dell.com") by vger.kernel.org with ESMTP id S261737AbULBT0J
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Dec 2004 14:26:09 -0500
Date: Thu, 2 Dec 2004 13:25:13 -0600
From: Matt Domsch <Matt_Domsch@dell.com>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org,
       Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2004@gmx.net>,
       jgarzik@pobox.com, alan@redhat.com, david.balazic@hermes.si,
       hpa@zytor.com, ak@suse.de
Subject: [PATCH 2.6] EDD: add edd=off and edd=skipmbr options
Message-ID: <20041202192513.GA27020@lists.us.dell.com>
References: <20041123230001.GE30452@lists.us.dell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041123230001.GE30452@lists.us.dell.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

EDD: add edd=off and edd=skipmbr command line options
    
New command line options
edd=off     (or edd=of)
edd=skipmbr (or edd=sk)
 
runtime options for disabling all EDD int13 calls completely, or for
skipping the int13 READ SECTOR calls, respectively.

These are provided to allow Linux distributions to include CONFIG_EDD=m, yet
allow end-users to disable parts of EDD which may not work well with their
system's BIOS.

I incorporated comments from Randy Dunlap, and got an ack from Andi Kleen.

Signed-off-by: Matt Domsch <Matt_Domsch@dell.com>
  
 Documentation/kernel-parameters.txt |    5 ++++
 arch/i386/boot/edd.S                |   42 ++++++++++++++++++++++++++++++++++--
 include/linux/edd.h                 |    4 +++
 3 files changed, 49 insertions, 2 deletions

-- 
Matt Domsch
Sr. Software Engineer, Lead Engineer
Dell Linux Solutions linux.dell.com & www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com


--- ../linux-2.6/arch/i386/boot/edd.S	Sat Nov 13 20:22:44 2004
+++ linux-2.6-edd-options/arch/i386/boot/edd.S	Tue Nov 23 15:26:28 2004
@@ -1,5 +1,6 @@
 /*
  * BIOS Enhanced Disk Drive support
+ * Copyright (C) 2002, 2003, 2004 Dell, Inc.
  * by Matt Domsch <Matt_Domsch@dell.com> October 2002
  * conformant to T13 Committee www.t13.org
  *   projects 1572D, 1484D, 1386D, 1226DT
@@ -7,14 +8,52 @@
  *	and Andrew Wilks <Andrew_Wilks@dell.com> September 2003, June 2004
  * legacy CHS retreival by Patrick J. LoPresti <patl@users.sourceforge.net>
  *      March 2004
+ * Command line option parsing, Matt Domsch, November 2004
  */
 
 #include <linux/edd.h>
+#include <asm/setup.h>
 
 #if defined(CONFIG_EDD) || defined(CONFIG_EDD_MODULE)
+	movb	$0, (EDD_MBR_SIG_NR_BUF)
+	movb	$0, (EDDNR)
+
+# Check the command line for two options:
+# edd=of  disables EDD completely  (edd=off)
+# edd=sk  skips the MBR test    (edd=skipmbr)
+	pushl	%esi
+    	cmpl	$0, %cs:cmd_line_ptr
+	jz	done_cl
+	movl	%cs:(cmd_line_ptr), %esi
+# ds:esi has the pointer to the command line now
+	movl	$(COMMAND_LINE_SIZE-7), %ecx
+# loop through kernel command line one byte at a time
+cl_loop:
+	cmpl	$EDD_CL_EQUALS, (%si)
+	jz	found_edd_equals
+	incl	%esi
+	loop	cl_loop
+	jmp	done_cl
+found_edd_equals:
+# only looking at first two characters after equals
+    	addl	$4, %esi
+	cmpw	$EDD_CL_OFF, (%si)	# edd=of
+	jz	do_edd_off
+	cmpw	$EDD_CL_SKIP, (%si)	# edd=sk
+	jz	do_edd_skipmbr
+	jmp	done_cl
+do_edd_skipmbr:
+    	popl	%esi
+	jmp	edd_start
+do_edd_off:
+	popl	%esi
+	jmp	edd_done
+done_cl:
+	popl	%esi
+
+    
 # Read the first sector of each BIOS disk device and store the 4-byte signature
 edd_mbr_sig_start:
-	movb	$0, (EDD_MBR_SIG_NR_BUF)	# zero value at EDD_MBR_SIG_NR_BUF
 	movb	$0x80, %dl			# from device 80
 	movw	$EDD_MBR_SIG_BUF, %bx		# store buffer ptr in bx
 edd_mbr_sig_read:
@@ -76,7 +115,6 @@ edd_start:
        						# result buffer for fn48
 	movw	$EDDBUF+EDDEXTSIZE, %si		# in ds:si, fn41 results
 						# kept just before that
-	movb	$0, (EDDNR)			# zero value at EDDNR
 	movb	$0x80, %dl			# BIOS device 0x80
 
 edd_check_ext:
--- ../linux-2.6/include/linux/edd.h	Sat Nov 13 20:22:46 2004
+++ linux-2.6-edd-options/include/linux/edd.h	Tue Nov 23 15:03:51 2004
@@ -49,6 +49,10 @@
 #define EDD_MBR_SIG_MAX 16        /* max number of signatures to store */
 #define EDD_MBR_SIG_NR_BUF 0x1ea  /* addr of number of MBR signtaures at EDD_MBR_SIG_BUF
 				     in boot_params - treat this as 1 byte  */
+#define EDD_CL_EQUALS   0x3d646465     /* "edd=" */
+#define EDD_CL_OFF      0x666f         /* "of" for off  */
+#define EDD_CL_SKIP     0x6b73         /* "sk" for skipmbr */
+
 #ifndef __ASSEMBLY__
 
 #define EDD_EXT_FIXED_DISK_ACCESS           (1 << 0)
--- ../linux-2.6/Documentation/kernel-parameters.txt	Tue Nov 23 10:56:18 2004
+++ linux-2.6-edd-options/Documentation/kernel-parameters.txt	Tue Nov 23 16:28:53 2004
@@ -29,6 +29,7 @@ restrictions referred to are that the re
 	CD	Appropriate CD support is enabled.
 	DEVFS	devfs support is enabled. 
 	DRM	Direct Rendering Management support is enabled. 
+	EDD	BIOS Enhanced Disk Drive Services (EDD) is enabled
 	EFI	EFI Partitioning (GPT) is enabled
 	EIDE	EIDE/ATAPI support is enabled.
 	FB	The frame buffer device is enabled.
@@ -407,6 +408,10 @@ running once the system is up.
 	eda=		[HW,PS2]
 
 	edb=		[HW,PS2]
+
+	edd=		[EDD]
+			Format: {"of[f]" | "sk[ipmbr]"}
+			See comment in arch/i386/boot/edd.S
 
 	eicon=		[HW,ISDN] 
 			Format: <id>,<membase>,<irq>
