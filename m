Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161310AbWJSNnT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161310AbWJSNnT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 09:43:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030332AbWJSNnT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 09:43:19 -0400
Received: from pfx2.jmh.fr ([194.153.89.55]:19152 "EHLO pfx2.jmh.fr")
	by vger.kernel.org with ESMTP id S1030317AbWJSNnS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 09:43:18 -0400
From: Eric Dumazet <dada1@cosmosbay.com>
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH] account_system_vtime() should be a macro, not a function
Date: Thu, 19 Oct 2006 15:43:18 +0200
User-Agent: KMail/1.9.5
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
References: <200610171747.34177.cijoml@volny.cz> <200610191012.49544.cijoml@volny.cz> <20061019014446.36410c81.akpm@osdl.org>
In-Reply-To: <20061019014446.36410c81.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_2D4NFpZfI4zryY2"
Message-Id: <200610191543.18951.dada1@cosmosbay.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_2D4NFpZfI4zryY2
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

[PATCH] account_system_vtime() should be a macro, not a function

Because the way 'current' is implemented on some archs, it's better to use a 
null macro for account_system_vtime(current) 

I discovered that gcc was (correctly) issuing one useless instruction (to 
load %rax with current from pda) on x86_64 on irq_enter() and __irq_exit()

This saves few bytes in kernel size, on archs where current is 'asm volatile'

Sample of asm code :

<smp_apic_timer_interrupt>:    
...
    callq  <exit_idle>
    mov    %gs:0x0,%rax // useless load of pda.'pcurrent' into %rax
    mov    %gs:0x10,%rax
    addl   $0x10000,0xffffffffffffe044(%rax) // 
add_preempt_count(HARDIRQ_OFFSET);

Signed-off-by: Eric Dumazet <dada1@cosmosbay.com>

--Boundary-00=_2D4NFpZfI4zryY2
Content-Type: text/plain;
  charset="iso-8859-1";
  name="account_system_vtime.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename="account_system_vtime.patch"

--- linux/include/linux/hardirq.h	2006-10-19 15:13:34.000000000 +0200
+++ linux-ed/include/linux/hardirq.h	2006-10-19 15:15:58.000000000 +0200
@@ -95,9 +95,11 @@
 struct task_struct;
 
 #ifndef CONFIG_VIRT_CPU_ACCOUNTING
-static inline void account_system_vtime(struct task_struct *tsk)
-{
-}
+/*
+ * It's better to provide a macro and not a function
+ * because the way 'current' is implemented on some archs
+ */
+#define account_system_vtime(X) do {} while (0)
 #endif
 
 /*

--Boundary-00=_2D4NFpZfI4zryY2--
