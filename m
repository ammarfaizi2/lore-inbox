Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266743AbUGLHAP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266743AbUGLHAP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jul 2004 03:00:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266744AbUGLHAP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jul 2004 03:00:15 -0400
Received: from fw.osdl.org ([65.172.181.6]:31909 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266743AbUGLG77 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jul 2004 02:59:59 -0400
Date: Sun, 11 Jul 2004 23:58:46 -0700
From: Andrew Morton <akpm@osdl.org>
To: Con Kolivas <kernel@kolivas.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Instrumenting high latency
Message-Id: <20040711235846.35004c45.akpm@osdl.org>
In-Reply-To: <cone.1089614621.957671.28499.502@pc.kolivas.org>
References: <cone.1089613755.742689.28499.502@pc.kolivas.org>
	<20040711233750.2050c4b1.akpm@osdl.org>
	<cone.1089614621.957671.28499.502@pc.kolivas.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas <kernel@kolivas.org> wrote:
>
> It can trip 
>  over itself saying that it's own code paths are a problem too if it gets 
>  real busy.

This might fix it?

diff -puN arch/i386/kernel/traps.c~instrumenting-high-latency-fixes arch/i386/kernel/traps.c
--- 25/arch/i386/kernel/traps.c~instrumenting-high-latency-fixes	2004-07-11 23:47:51.007799680 -0700
+++ 25-akpm/arch/i386/kernel/traps.c	2004-07-11 23:57:58.726412408 -0700
@@ -1065,6 +1065,9 @@ void __dec_preempt_count(void)
 	if (preempt_count() == 1 && system_state == SYSTEM_RUNNING &&
 					__get_cpu_var(preempt_entry)) {
 		u64 exit;
+
+		preempt_count()++;	/* Prevent recursive warnings */
+
 		__get_cpu_var(preempt_exit)
 				= (unsigned long)__builtin_return_address(0);
 		rdtscll(exit);
@@ -1082,12 +1085,13 @@ void __dec_preempt_count(void)
 					preempt_thresh);
 				print_symbol("%s and ending at ",
 					__get_cpu_var(preempt_entry));
-				print_symbol("%s\n",
-					__get_cpu_var(preempt_exit));
+				print_symbol("%s", __get_cpu_var(preempt_exit));
+				printk("\n");
 				dump_stack();
 			}
 		}
 		__get_cpu_var(preempt_exit) = __get_cpu_var(preempt_entry) = 0;
+		preempt_count()--;
 	}
 	preempt_count()--;
 }
_

