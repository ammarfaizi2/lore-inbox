Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423190AbWF1GkQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423190AbWF1GkQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 02:40:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423184AbWF1GkQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 02:40:16 -0400
Received: from smtp.osdl.org ([65.172.181.4]:50146 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030459AbWF1GkP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 02:40:15 -0400
Date: Tue, 27 Jun 2006 23:40:05 -0700
From: Andrew Morton <akpm@osdl.org>
To: Zou Nan hai <nanhai.zou@intel.com>
Cc: linux-kernel@vger.kernel.org, mingo@elte.hu
Subject: Re: [Patch] jbd commit code deadloop when installing Linux
Message-Id: <20060627234005.dda13686.akpm@osdl.org>
In-Reply-To: <1151470123.6052.17.camel@linux-znh>
References: <1151470123.6052.17.camel@linux-znh>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 28 Jun 2006 12:48:43 +0800
Zou Nan hai <nanhai.zou@intel.com> wrote:

> We see system hang in ext3 jbd code
> when Linux install program anaconda copying 
> packages. 
> 
> That is because anaconda is invoked from linuxrc 
> in initrd when system_state is still SYSTEM_BOOTING.
> 
> Thus the cond_resched checks in  journal_commit_transaction 
> will always return 1 without actually schedule, 
> then the system fall into deadloop.

That's a bug in cond_resched().

Something like this..


--- a/kernel/sched.c~cond_resched-fix
+++ a/kernel/sched.c
@@ -4454,7 +4454,7 @@ asmlinkage long sys_sched_yield(void)
 	return 0;
 }
 
-static inline void __cond_resched(void)
+static inline int __cond_resched(void)
 {
 #ifdef CONFIG_DEBUG_SPINLOCK_SLEEP
 	__might_sleep(__FILE__, __LINE__);
@@ -4465,22 +4465,21 @@ static inline void __cond_resched(void)
 	 * cond_resched() call.
 	 */
 	if (unlikely(preempt_count()))
-		return;
+		return 0;
 	if (unlikely(system_state != SYSTEM_RUNNING))
-		return;
+		return 0;
 	do {
 		add_preempt_count(PREEMPT_ACTIVE);
 		schedule();
 		sub_preempt_count(PREEMPT_ACTIVE);
 	} while (need_resched());
+	return 1;
 }
 
 int __sched cond_resched(void)
 {
-	if (need_resched()) {
-		__cond_resched();
-		return 1;
-	}
+	if (need_resched())
+		return __cond_resched();
 	return 0;
 }
 EXPORT_SYMBOL(cond_resched);
_

