Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030560AbVKXHpd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030560AbVKXHpd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Nov 2005 02:45:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030556AbVKXHpd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Nov 2005 02:45:33 -0500
Received: from silver.veritas.com ([143.127.12.111]:44071 "EHLO
	silver.veritas.com") by vger.kernel.org with ESMTP id S1030560AbVKXHpb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Nov 2005 02:45:31 -0500
Date: Thu, 24 Nov 2005 07:45:40 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Gene Heskett <gene.heskett@verizon.net>
cc: linux-kernel@vger.kernel.org, Michael Krufky <mkrufky@linuxtv.org>,
       Adrian Bunk <bunk@stusta.de>, Johannes Stezenbach <js@linuxtv.org>,
       Sam Ravnborg <sam@ravnborg.org>, Kirk Lapray <kirk.lapray@gmail.com>
Subject: Re: Linux 2.6.15-rc2
In-Reply-To: <200511231937.34206.gene.heskett@verizon.net>
Message-ID: <Pine.LNX.4.61.0511240741020.5619@goblin.wat.veritas.com>
References: <Pine.LNX.4.64.0511191934210.8552@g5.osdl.org>
 <200511231736.58204.gene.heskett@verizon.net>
 <Pine.LNX.4.61.0511232338100.4550@goblin.wat.veritas.com>
 <200511231937.34206.gene.heskett@verizon.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 24 Nov 2005 07:45:30.0858 (UTC) FILETIME=[0B4D74A0:01C5F0CB]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Nov 2005, Gene Heskett wrote:
> On Wednesday 23 November 2005 18:40, Hugh Dickins wrote:
> >
> >No git familiarity needed:
> >http://ftp.kernel.org/pub/linux/kernel/v2.6/snapshots/
> >contains the daily patches against recent -rcs
> 
> Unforch, using a 2.6.14 base, applying 2.6.15-rc2 followed by
> 2.6.15-rc2-git3 blows up about 24 seconds into my makeit script:
> 
>   CC      arch/i386/kernel/cpu/mtrr/main.o
> arch/i386/kernel/cpu/mtrr/main.c: In function `set_mtrr':
> arch/i386/kernel/cpu/mtrr/main.c:225: error: `ipi_handler' undeclared
> (first use in this function)
> arch/i386/kernel/cpu/mtrr/main.c:225: error: (Each undeclared identifier
> is reported only once
> arch/i386/kernel/cpu/mtrr/main.c:225: error: for each function it
> appears in.)
> make[3]: *** [arch/i386/kernel/cpu/mtrr/main.o] Error 1
> make[2]: *** [arch/i386/kernel/cpu/mtrr] Error 2
> make[1]: *** [arch/i386/kernel/cpu] Error 2
> make: *** [arch/i386/kernel] Error 2

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
 
