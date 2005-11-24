Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030567AbVKXHwQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030567AbVKXHwQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Nov 2005 02:52:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030565AbVKXHwQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Nov 2005 02:52:16 -0500
Received: from silver.veritas.com ([143.127.12.111]:47912 "EHLO
	silver.veritas.com") by vger.kernel.org with ESMTP id S1030568AbVKXHwQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Nov 2005 02:52:16 -0500
Date: Thu, 24 Nov 2005 07:52:26 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Bob Gill <gillb4@telusplanet.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.15-rc2-git3 build fails at mtrr/ipi_handler undeclared
In-Reply-To: <43856925.1020704@telusplanet.net>
Message-ID: <Pine.LNX.4.61.0511240751280.5688@goblin.wat.veritas.com>
References: <43856925.1020704@telusplanet.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 24 Nov 2005 07:52:15.0818 (UTC) FILETIME=[FCAD72A0:01C5F0CB]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Nov 2005, Bob Gill wrote:
> Hi. I am trying to build 2.6.15-rc2-git3, but it fails with an error:
> make: *** [arch/i386/kernel] Error 2
> CHK     include/linux/version.h
> CHK     include/linux/compile.h
> CHK     usr/initramfs_list
> CC      arch/i386/kernel/cpu/mtrr/main.o
> arch/i386/kernel/cpu/mtrr/main.c: In function `set_mtrr':
> arch/i386/kernel/cpu/mtrr/main.c:225: error: `ipi_handler' undeclared (first
> use in this function)
> arch/i386/kernel/cpu/mtrr/main.c:225: error: (Each undeclared identifier is
> reported only once
> arch/i386/kernel/cpu/mtrr/main.c:225: error: for each function it appears in.)
> make[3]: *** [arch/i386/kernel/cpu/mtrr/main.o] Error 1
> make[2]: *** [arch/i386/kernel/cpu/mtrr] Error 2
> make[1]: *** [arch/i386/kernel/cpu] Error 2
> make: *** [arch/i386/kernel] Error 2
>  CHK     include/linux/version.h

That's one of the things fixed by Andrew's patch below
(though Linus fixed it differently in the end).
Or you could just wait for 2.6.15-rc2-git4, should be along soon.

Hugh

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
 
