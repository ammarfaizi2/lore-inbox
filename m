Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266357AbUIIRVC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266357AbUIIRVC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 13:21:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266376AbUIIRVA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 13:21:00 -0400
Received: from holomorphy.com ([207.189.100.168]:43185 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S266357AbUIIRUF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 13:20:05 -0400
Date: Thu, 9 Sep 2004 10:19:54 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Anton Blanchard <anton@samba.org>
Cc: Zwane Mwaikambo <zwane@linuxpower.ca>, Paul Mackerras <paulus@samba.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Matt Mackall <mpm@selenic.com>,
       "Nakajima, Jun" <jun.nakajima@intel.com>
Subject: Re: [PATCH][5/8] Arch agnostic completely out of line locks / ppc64
Message-ID: <20040909171954.GW3106@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Anton Blanchard <anton@samba.org>,
	Zwane Mwaikambo <zwane@linuxpower.ca>,
	Paul Mackerras <paulus@samba.org>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
	Matt Mackall <mpm@selenic.com>,
	"Nakajima, Jun" <jun.nakajima@intel.com>
References: <Pine.LNX.4.58.0409021231570.4481@montezuma.fsmlabs.com> <16703.60725.153052.169532@cargo.ozlabs.ibm.com> <Pine.LNX.4.53.0409090810550.15087@montezuma.fsmlabs.com> <20040909154259.GE11358@krispykreme>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040909154259.GE11358@krispykreme>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At some point in the past, Zwane Mwaikambo wrote:
>> I think that bit is actually intentional since __preempt_spin_lock is also 
>> marked __sched so that it'll get charged as a scheduling function.

On Fri, Sep 10, 2004 at 01:43:00AM +1000, Anton Blanchard wrote:
> Yeah, its a bit unfortunate. In profiles with preempt on we end up with
> almost all our ticks inside __preempt_spin_lock and never get to use the
> nice profile_pc code. I ended up turning preempt off again.

Checking in_lock_functions() (not sure what the name in Zwane's code
was) for non-leaf functions in get_wchan() in addition to
in_sched_functions() should do. e.g.

Index: mm4-2.6.9-rc1/arch/ppc64/kernel/process.c
===================================================================
--- mm4-2.6.9-rc1.orig/arch/ppc64/kernel/process.c	2004-09-08 05:46:09.000000000 -0700
+++ mm4-2.6.9-rc1/arch/ppc64/kernel/process.c	2004-09-09 09:58:47.448326528 -0700
@@ -555,7 +555,8 @@
 			return 0;
 		if (count > 0) {
 			ip = *(unsigned long *)(sp + 16);
-			if (!in_sched_functions(ip))
+			if (!in_sched_functions(ip) &&
+					|| (!count || !in_lock_functions(ip)))
 				return ip;
 		}
 	} while (count++ < 16);
Index: mm4-2.6.9-rc1/include/linux/spinlock.h
===================================================================
--- mm4-2.6.9-rc1.orig/include/linux/spinlock.h	2004-09-08 05:46:18.000000000 -0700
+++ mm4-2.6.9-rc1/include/linux/spinlock.h	2004-09-09 09:57:33.529563888 -0700
@@ -46,6 +46,7 @@
 
 #define __lockfunc fastcall __attribute__((section(".lock.text")))
 
+int in_lock_functions(unsigned long);
 int __lockfunc _spin_trylock(spinlock_t *lock);
 int __lockfunc _write_trylock(rwlock_t *lock);
 void __lockfunc _spin_lock(spinlock_t *lock);
Index: mm4-2.6.9-rc1/kernel/spinlock.c
===================================================================
--- mm4-2.6.9-rc1.orig/kernel/spinlock.c	2004-09-08 05:46:04.000000000 -0700
+++ mm4-2.6.9-rc1/kernel/spinlock.c	2004-09-09 09:57:10.569054416 -0700
@@ -11,6 +11,12 @@
 #include <linux/interrupt.h>
 #include <linux/module.h>
 
+int in_lock_functions(unsigned long vaddr)
+{
+	return vaddr >= (unsigned long)&__lock_text_start
+			&& vaddr < (unsigned long)&__lock_text_end;
+}
+
 int __lockfunc _spin_trylock(spinlock_t *lock)
 {
 	preempt_disable();
