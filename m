Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262398AbUFJS4t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262398AbUFJS4t (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jun 2004 14:56:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262434AbUFJS4l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jun 2004 14:56:41 -0400
Received: from fmr12.intel.com ([134.134.136.15]:11398 "EHLO
	orsfmr001.jf.intel.com") by vger.kernel.org with ESMTP
	id S262391AbUFJS4B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jun 2004 14:56:01 -0400
Date: Thu, 10 Jun 2004 13:45:13 -0700
From: long <tlnguyen@snoqualmie.dp.intel.com>
Message-Id: <200406102045.i5AKjDJo017156@snoqualmie.dp.intel.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org, wli@holomorphy.com
Subject: [PATCH]Re:2.6.7-rc3-mm1
Cc: tom.l.nguyen@intel.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed. June 09, 2004 William Lee Irwin III wrote:
> The MSI writers have a lot to answer for. Could you test this?

Hi William,

The MSI patch has existed in the kernel since 2.6.3 and has been
validated in both UP and SMP environments. It appears another patch 
(don't know which one) redefined the value of TARGET_CPU, which is 
used by the function msi_address_init() to configure logical
target CPU. The redefinition of TARGET_CPU without checking its 
usage by other kernel code broke the build.

Your patch fixes the build but breaks the devices using MSI in 
different architectures supported by the function msi_address_init().
I have attached a patch that fixes the build and maintains cross
architecture support for MSI.

Thanks,
Long

------------------------------------------------------------------ 
diff -urN linux-2.6.7-rc3-mm1/include/asm-i386/msi.h 2.6.7-rc3-mm1-fix/include/asm-i386/msi.h
--- linux-2.6.7-rc3-mm1/include/asm-i386/msi.h	2004-05-09 22:32:52.000000000 -0400
+++ 2.6.7-rc3-mm1-fix/include/asm-i386/msi.h	2004-06-09 17:21:07.000000000 -0400
@@ -16,7 +16,7 @@
 #ifdef CONFIG_SMP
 #define MSI_TARGET_CPU		logical_smp_processor_id()
 #else
-#define MSI_TARGET_CPU		TARGET_CPUS
+#define MSI_TARGET_CPU	cpu_to_logical_apicid(first_cpu(cpu_online_map))
 #endif
 
 #endif /* ASM_MSI_H */
