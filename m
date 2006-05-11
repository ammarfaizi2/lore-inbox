Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030216AbWEKLUG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030216AbWEKLUG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 May 2006 07:20:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030228AbWEKLUG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 May 2006 07:20:06 -0400
Received: from smtp.osdl.org ([65.172.181.4]:10119 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030216AbWEKLUE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 May 2006 07:20:04 -0400
Date: Thu, 11 May 2006 04:17:00 -0700
From: Andrew Morton <akpm@osdl.org>
To: "bibo,mao" <bibo.mao@intel.com>
Cc: ak@suse.de, jbeulich@novell.com, anil.s.keshavamurthy@intel.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH]x86_64 debug_stack nested patch (again)
Message-Id: <20060511041700.49c3bab0.akpm@osdl.org>
In-Reply-To: <200605101726.08338.bibo.mao@intel.com>
References: <200605101726.08338.bibo.mao@intel.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"bibo,mao" <bibo.mao@intel.com> wrote:
>
> Hi,
> In x86_64 platform, INT1 and INT3 trap stack is IST stack called DEBUG_STACK,
> when INT1/INT3 trap happens, system will switch to DEBUG_STACK by hardware. 
> Current DEBUG_STACK size is 4K, when int1/int3 trap happens, kernel will 
> minus current DEBUG_STACK IST value by 4k. But if int3/int1 trap is nested, 
> it will destroy other vector's IST stack. This patch modifies this, it sets 
> DEBUG_STACK size as 8K and allows two level of nested int1/int3 trap.
> 
> Kprobe DEBUG_STACK may be nested, because kprobe hanlder may be probed 
> by other kprobes. This patch is against 2.6.17-rc3. Thanks jbeulich for pointing out error in the first patch.
> 
> Signed-Off-By: bibo, mao <bibo.mao@intel.com>
> 
> --- 2.6.17-rc3.org/include/asm-x86_64/page.h	2006-05-10 12:07:18.000000000 +0800
> +++ 2.6.17-rc3/include/asm-x86_64/page.h	2006-05-10 12:19:24.000000000 +0800
> @@ -20,7 +20,7 @@
>  #define EXCEPTION_STACK_ORDER 0
>  #define EXCEPTION_STKSZ (PAGE_SIZE << EXCEPTION_STACK_ORDER)
>  
> -#define DEBUG_STACK_ORDER EXCEPTION_STACK_ORDER
> +#define DEBUG_STACK_ORDER (EXCEPTION_STACK_ORDER + 1)
>  #define DEBUG_STKSZ (PAGE_SIZE << DEBUG_STACK_ORDER)
>  
>  #define IRQSTACK_ORDER 2

So....   why not do it this way?



--- devel/include/asm-x86_64/page.h~x86_64-kprobes-debug_stack-nesting-fix	2006-05-11 04:15:12.000000000 -0700
+++ devel-akpm/include/asm-x86_64/page.h	2006-05-11 04:16:07.000000000 -0700
@@ -20,7 +20,15 @@
 #define EXCEPTION_STACK_ORDER 0
 #define EXCEPTION_STKSZ (PAGE_SIZE << EXCEPTION_STACK_ORDER)
 
+#ifdef CONFIG_KPROBES
+/*
+ * kprobes uses an 8k stack because int1/int3 exceptions can nest
+ */
+#define DEBUG_STACK_ORDER (EXCEPTION_STACK_ORDER + 1)
+#else
 #define DEBUG_STACK_ORDER EXCEPTION_STACK_ORDER
+#endif
+
 #define DEBUG_STKSZ (PAGE_SIZE << DEBUG_STACK_ORDER)
 
 #define IRQSTACK_ORDER 2
_

