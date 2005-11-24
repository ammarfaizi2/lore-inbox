Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751396AbVKXUOP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751396AbVKXUOP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Nov 2005 15:14:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751398AbVKXUOP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Nov 2005 15:14:15 -0500
Received: from outbound01.telus.net ([199.185.220.220]:56462 "EHLO
	priv-edtnes56.telusplanet.net") by vger.kernel.org with ESMTP
	id S1751396AbVKXUOP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Nov 2005 15:14:15 -0500
Message-ID: <43862036.4060706@telusplanet.net>
Date: Thu, 24 Nov 2005 13:19:02 -0700
From: Bob Gill <gillb4@telusplanet.net>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Hugh Dickins <hugh@veritas.com>
CC: Linux kernel Mailing list <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.15-rc2-git3 build fails at mtrr/ipi_handler undeclared
References: <43856925.1020704@telusplanet.net> <Pine.LNX.4.61.0511240751280.5688@goblin.wat.veritas.com>
In-Reply-To: <Pine.LNX.4.61.0511240751280.5688@goblin.wat.veritas.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hugh Dickins wrote:

>
>That's one of the things fixed by Andrew's patch below
>(though Linus fixed it differently in the end).
>Or you could just wait for 2.6.15-rc2-git4, should be along soon.
>
>Hugh
>
>diff -puN include/linux/smp.h~smp_call_function-must-be-a-macro include/linux/smp.h
>--- devel/include/linux/smp.h~smp_call_function-must-be-a-macro	2005-11-23 00:14:19.000000000 -0800
>+++ devel-akpm/include/linux/smp.h	2005-11-23 00:20:54.000000000 -0800
>@@ -94,13 +94,7 @@ void smp_prepare_boot_cpu(void);
>  */
> #define raw_smp_processor_id()			0
> #define hard_smp_processor_id()			0
>-
>-static inline int smp_call_function(void (*func) (void *info), void *info,
>-				    int retry, int wait)
>-{
>-	return 0;
>-}
>-
>+#define smp_call_function(func,info,retry,wait)	({ 0; })
> #define on_each_cpu(func,info,retry,wait)	({ func(info); 0; })
> static inline void smp_send_reschedule(int cpu) { }
> #define num_booting_cpus()			1
>diff -puN net/core/flow.c~smp_call_function-must-be-a-macro net/core/flow.c
>--- devel/net/core/flow.c~smp_call_function-must-be-a-macro	2005-11-23 00:17:40.000000000 -0800
>+++ devel-akpm/net/core/flow.c	2005-11-23 00:17:47.000000000 -0800
>@@ -292,7 +292,7 @@ void flow_cache_flush(void)
> 	init_completion(&info.completion);
> 
> 	local_bh_disable();
>-	smp_call_function(flow_cache_flush_per_cpu, &info, 1, 0);
>+	(void)smp_call_function(flow_cache_flush_per_cpu, &info, 1, 0);
> 	flow_cache_flush_tasklet((unsigned long)&info);
> 	local_bh_enable();
> 
>
>  
>
Done!  Thanks for your reply.  I built 2.6.15-rc2-git4 and its running 
it as I type this.  Linus' final looks very much like the patch above, 
except for the void typecast in smp_call_funciton.
Thanks again,
Bob
