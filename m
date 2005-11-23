Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030360AbVKWIV4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030360AbVKWIV4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 03:21:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030361AbVKWIV4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 03:21:56 -0500
Received: from smtp.osdl.org ([65.172.181.4]:36786 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030360AbVKWIVz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 03:21:55 -0500
Date: Wed, 23 Nov 2005 00:21:34 -0800
From: Andrew Morton <akpm@osdl.org>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Russell King <rmk@arm.linux.org.uk>,
       "David S. Miller" <davem@davemloft.net>,
       Linus Torvalds <torvalds@osdl.org>, Andi Kleen <ak@muc.de>
Subject: Re: [NET]: Shut up warnings in net/core/flow.c
Message-Id: <20051123002134.287ff226.akpm@osdl.org>
In-Reply-To: <200511230159.jAN1xeMl003154@hera.kernel.org>
References: <200511230159.jAN1xeMl003154@hera.kernel.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linux Kernel Mailing List <linux-kernel@vger.kernel.org> wrote:
>
> tree e7ba0f1bc8764c36859e2cfa9421bb1d86f2e7f4
> parent b3a5225f31180322fd7d692fd4cf786702826b94
> author Russell King <rmk+kernel@arm.linux.org.uk> Wed, 23 Nov 2005 06:38:04 -0800
> committer David S. Miller <davem@davemloft.net> Wed, 23 Nov 2005 06:38:04 -0800
> 
> [NET]: Shut up warnings in net/core/flow.c
> 
> Not really a network problem, more a !SMP issue.
> 
> net/core/flow.c:295: warning: statement with no effect
> 
> flow.c:295:        smp_call_function(flow_cache_flush_per_cpu, &info, 1, 0);
> 
> Fix this by converting the macro to an inline function, which
> also increases the typechecking for !SMP builds.

Nope, this will break !CONFIG_SMP builds.  Quite a few places in the kernel
do not implement the ipi handler if !CONFIG_SMP.

diff -puN include/linux/smp.h~smp_call_function-must-be-a-macro include/linux/smp.h
--- devel/include/linux/smp.h~smp_call_function-must-be-a-macro	2005-11-23 00:14:19.000000000 -0800
+++ devel-akpm/include/linux/smp.h	2005-11-23 00:20:54.000000000 -0800
@@ -94,13 +94,7 @@ void smp_prepare_boot_cpu(void);
  */
 #define raw_smp_processor_id()			0
 #define hard_smp_processor_id()			0
-
-static inline int smp_call_function(void (*func) (void *info), void *info,
-				    int retry, int wait)
-{
-	return 0;
-}
-
+#define smp_call_function(func,info,retry,wait)	({ 0; })
 #define on_each_cpu(func,info,retry,wait)	({ func(info); 0; })
 static inline void smp_send_reschedule(int cpu) { }
 #define num_booting_cpus()			1
diff -puN net/core/flow.c~smp_call_function-must-be-a-macro net/core/flow.c
--- devel/net/core/flow.c~smp_call_function-must-be-a-macro	2005-11-23 00:17:40.000000000 -0800
+++ devel-akpm/net/core/flow.c	2005-11-23 00:17:47.000000000 -0800
@@ -292,7 +292,7 @@ void flow_cache_flush(void)
 	init_completion(&info.completion);
 
 	local_bh_disable();
-	smp_call_function(flow_cache_flush_per_cpu, &info, 1, 0);
+	(void)smp_call_function(flow_cache_flush_per_cpu, &info, 1, 0);
 	flow_cache_flush_tasklet((unsigned long)&info);
 	local_bh_enable();
 
_

