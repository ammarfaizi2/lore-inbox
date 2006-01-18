Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030219AbWARLP1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030219AbWARLP1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 06:15:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030222AbWARLP1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 06:15:27 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:4066 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1030219AbWARLP0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 06:15:26 -0500
Date: Wed, 18 Jan 2006 12:15:40 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: ntl@pobox.com, anton@au1.ibm.com, linux-kernel@vger.kernel.org,
       michael@ellerman.id.au, linuxppc64-dev@ozlabs.org, serue@us.ibm.com,
       paulus@au1.ibm.com, torvalds@osdl.org
Subject: [patch] make bug messages more consistent
Message-ID: <20060118111540.GA14023@elte.hu>
References: <20060118033239.GA621@cs.umn.edu> <20060118063732.GA21003@elte.hu> <20060117225304.4b6dd045.akpm@osdl.org> <20060118072815.GR2846@localhost.localdomain> <20060117233734.506c2f2e.akpm@osdl.org> <20060118080828.GA2324@elte.hu> <20060118002459.3bc8f75a.akpm@osdl.org> <20060118091834.GA21366@elte.hu> <20060118023509.50fe2701.akpm@osdl.org> <20060118104319.GB7885@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060118104319.GB7885@elte.hu>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

while we are changing debugging code. One problem is that we've got a 
hodgepodge of bug messages right now, and i frequently miss e.g.  
'Badness' messages from the kernel because they simply do not stick out 
visually. 'BUG' is much more apparent and also makes it obvious that 
there's a kernel bug here. Here's a patch that makes the messages more 
consistent:

--

consolidate all kernel bug printouts to begin with the "BUG: " string.  
Makes it easier to find them in large bootup logs.

Signed-off-by: Ingo Molnar <mingo@elte.hu>

----

 include/asm-generic/bug.h |    4 ++--
 kernel/sched.c            |    4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

Index: linux/include/asm-generic/bug.h
===================================================================
--- linux.orig/include/asm-generic/bug.h
+++ linux/include/asm-generic/bug.h
@@ -7,7 +7,7 @@
 #ifdef CONFIG_BUG
 #ifndef HAVE_ARCH_BUG
 #define BUG() do { \
-	printk("kernel BUG at %s:%d!\n", __FILE__, __LINE__); \
+	printk("BUG: failure at %s:%d/%s()!\n", __FILE__, __LINE__, __FUNCTION__); \
 	panic("BUG!"); \
 } while (0)
 #endif
@@ -19,7 +19,7 @@
 #ifndef HAVE_ARCH_WARN_ON
 #define WARN_ON(condition) do { \
 	if (unlikely((condition)!=0)) { \
-		printk("Badness in %s at %s:%d\n", __FUNCTION__, __FILE__, __LINE__); \
+		printk("BUG: warning at %s:%d/%s()\n", __FILE__, __LINE__, __FUNCTION__); \
 		dump_stack(); \
 	} \
 } while (0)
Index: linux/kernel/sched.c
===================================================================
--- linux.orig/kernel/sched.c
+++ linux/kernel/sched.c
@@ -2973,7 +2973,7 @@ asmlinkage void __sched schedule(void)
 	 */
 	if (likely(!current->exit_state)) {
 		if (unlikely(in_atomic())) {
-			printk(KERN_ERR "scheduling while atomic: "
+			printk(KERN_ERR "BUG: scheduling while atomic: "
 				"%s/0x%08x/%d\n",
 				current->comm, preempt_count(), current->pid);
 			dump_stack();
@@ -6293,7 +6293,7 @@ void __might_sleep(char *file, int line)
 		if (time_before(jiffies, prev_jiffy + HZ) && prev_jiffy)
 			return;
 		prev_jiffy = jiffies;
-		printk(KERN_ERR "Debug: sleeping function called from invalid"
+		printk(KERN_ERR "BUG: sleeping function called from invalid"
 				" context at %s:%d\n", file, line);
 		printk("in_atomic():%d, irqs_disabled():%d\n",
 			in_atomic(), irqs_disabled());
