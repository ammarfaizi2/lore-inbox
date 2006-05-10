Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964870AbWEJJ0W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964870AbWEJJ0W (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 May 2006 05:26:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964871AbWEJJ0W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 May 2006 05:26:22 -0400
Received: from mga01.intel.com ([192.55.52.88]:10117 "EHLO
	fmsmga101-1.fm.intel.com") by vger.kernel.org with ESMTP
	id S964870AbWEJJ0V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 May 2006 05:26:21 -0400
X-IronPort-AV: i="4.05,108,1146466800"; 
   d="scan'208"; a="35027702:sNHT32533571"
From: "bibo,mao" <bibo.mao@intel.com>
To: akpm@osdl.org
Subject: [PATCH]x86_64 debug_stack nested patch (again)
Date: Wed, 10 May 2006 17:26:07 +0800
User-Agent: KMail/1.9.1
Cc: Andi Kleen <ak@suse.de>, Jan Beulich <jbeulich@novell.com>,
       Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
       linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605101726.08338.bibo.mao@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
In x86_64 platform, INT1 and INT3 trap stack is IST stack called DEBUG_STACK,
when INT1/INT3 trap happens, system will switch to DEBUG_STACK by hardware. 
Current DEBUG_STACK size is 4K, when int1/int3 trap happens, kernel will 
minus current DEBUG_STACK IST value by 4k. But if int3/int1 trap is nested, 
it will destroy other vector's IST stack. This patch modifies this, it sets 
DEBUG_STACK size as 8K and allows two level of nested int1/int3 trap.

Kprobe DEBUG_STACK may be nested, because kprobe hanlder may be probed 
by other kprobes. This patch is against 2.6.17-rc3. Thanks jbeulich for pointing out error in the first patch.

Signed-Off-By: bibo, mao <bibo.mao@intel.com>

--- 2.6.17-rc3.org/include/asm-x86_64/page.h	2006-05-10 12:07:18.000000000 +0800
+++ 2.6.17-rc3/include/asm-x86_64/page.h	2006-05-10 12:19:24.000000000 +0800
@@ -20,7 +20,7 @@
 #define EXCEPTION_STACK_ORDER 0
 #define EXCEPTION_STKSZ (PAGE_SIZE << EXCEPTION_STACK_ORDER)
 
-#define DEBUG_STACK_ORDER EXCEPTION_STACK_ORDER
+#define DEBUG_STACK_ORDER (EXCEPTION_STACK_ORDER + 1)
 #define DEBUG_STKSZ (PAGE_SIZE << DEBUG_STACK_ORDER)
 
 #define IRQSTACK_ORDER 2


Thanks
bibo,mao
