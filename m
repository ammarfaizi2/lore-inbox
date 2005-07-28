Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261423AbVG1MQT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261423AbVG1MQT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Jul 2005 08:16:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261436AbVG1MOF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Jul 2005 08:14:05 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:51172 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S261423AbVG1MNB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Jul 2005 08:13:01 -0400
Date: Thu, 28 Jul 2005 17:43:05 +0530
From: Vivek Goyal <vgoyal@in.ibm.com>
To: Morton Andrew Morton <akpm@osdl.org>,
       "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Fastboot mailing list <fastboot@lists.osdl.org>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH] kdump: Save parameter segment in protected mode (x86)
Message-ID: <20050728121305.GB4962@in.ibm.com>
Reply-To: vgoyal@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



o With introduction of kexec as boot-loader, the assumption that parameter
  segment will always be loaded at lower address than kernel and will be 
  addressable by early bootup page tables is no longer valid. In kexec on 
  panic case parameter segment might well be loaded beyond kernel image and 
  might not be addressable by early boot page tables.
o This case might hit in the scenario where user has reserved a chunk of
  memory for second kernel, for example 16MB to 64MB, and has also built 
  second kernel for physical memory location 16MB. In this case kexec has no 
  choice but to load the parameter segment at a higher address than new kernel 
  image at safe location where new kernel does not stomp it. 
o Though problem should automatically go away once relocatable kernel for i386 
  is in place and kexec can determine the location of new kernel at run time
  and load parameter segment at lower address than kernel image. But till then
  this patch can go in (assuming it does not break something else). 
o This patch moves up the boot parameter saving code. Now boot parameters
  are copied out in protected mode before page tables are initialized. This
  will ensure that parameter segment is always addressable irrespective of
  its physical location.


Signed-off-by: Vivek Goyal <vgoyal@in.ibm.com>
---

 linux-2.6.13-rc3-test-vivek/arch/i386/kernel/head.S |   48 ++++++++++----------
 1 files changed, 26 insertions(+), 22 deletions(-)

diff -puN arch/i386/kernel/head.S~kdump-x86-copy-parameters-in-protected-mode arch/i386/kernel/head.S
--- linux-2.6.13-rc3-test/arch/i386/kernel/head.S~kdump-x86-copy-parameters-in-protected-mode	2005-07-28 16:57:41.276572856 +0530
+++ linux-2.6.13-rc3-test-vivek/arch/i386/kernel/head.S	2005-07-28 16:57:41.283571792 +0530
@@ -77,6 +77,32 @@ ENTRY(startup_32)
 	subl %edi,%ecx
 	shrl $2,%ecx
 	rep ; stosl
+/*
+ * Copy bootup parameters out of the way.
+ * Note: %esi still has the pointer to the real-mode data.
+ * With the kexec as boot loader, parameter segment might be loaded beyond
+ * kernel image and might not even be addressable by early boot page tables.
+ * (kexec on panic case). Hence copy out the parameters before initializing
+ * page tables.
+ */
+	movl $(boot_params - __PAGE_OFFSET),%edi
+	movl $(PARAM_SIZE/4),%ecx
+	cld
+	rep
+	movsl
+	movl boot_params - __PAGE_OFFSET + NEW_CL_POINTER,%esi
+	andl %esi,%esi
+	jnz 2f			# New command line protocol
+	cmpw $(OLD_CL_MAGIC),OLD_CL_MAGIC_ADDR
+	jne 1f
+	movzwl OLD_CL_OFFSET,%esi
+	addl $(OLD_CL_BASE_ADDR),%esi
+2:
+	movl $(saved_command_line - __PAGE_OFFSET),%edi
+	movl $(COMMAND_LINE_SIZE/4),%ecx
+	rep
+	movsl
+1:
 
 /*
  * Initialize page tables.  This creates a PDE and a set of page
@@ -214,28 +240,6 @@ ENTRY(startup_32_smp)
  */
 	call setup_idt
 
-/*
- * Copy bootup parameters out of the way.
- * Note: %esi still has the pointer to the real-mode data.
- */
-	movl $boot_params,%edi
-	movl $(PARAM_SIZE/4),%ecx
-	cld
-	rep
-	movsl
-	movl boot_params+NEW_CL_POINTER,%esi
-	andl %esi,%esi
-	jnz 2f			# New command line protocol
-	cmpw $(OLD_CL_MAGIC),OLD_CL_MAGIC_ADDR
-	jne 1f
-	movzwl OLD_CL_OFFSET,%esi
-	addl $(OLD_CL_BASE_ADDR),%esi
-2:
-	movl $saved_command_line,%edi
-	movl $(COMMAND_LINE_SIZE/4),%ecx
-	rep
-	movsl
-1:
 checkCPUtype:
 
 	movl $-1,X86_CPUID		#  -1 for no CPUID initially
_
