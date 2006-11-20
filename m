Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966615AbWKTT7O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966615AbWKTT7O (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 14:59:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966610AbWKTT7O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 14:59:14 -0500
Received: from smtp.osdl.org ([65.172.181.25]:10936 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S966615AbWKTT7M (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 14:59:12 -0500
Date: Mon, 20 Nov 2006 11:57:07 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Ingo Molnar <mingo@elte.hu>
cc: Thomas Gleixner <tglx@timesys.com>, Alan Stern <stern@rowland.harvard.edu>,
       LKML <linux-kernel@vger.kernel.org>, john stultz <johnstul@us.ibm.com>,
       David Miller <davem@davemloft.net>,
       Arjan van de Ven <arjan@infradead.org>, Andrew Morton <akpm@osdl.org>,
       Andi Kleen <ak@suse.de>
Subject: Re: [patch] cpufreq: mark cpufreq_tsc() as core_initcall_sync
In-Reply-To: <20061116201531.GA31469@elte.hu>
Message-ID: <Pine.LNX.4.64.0611201156380.3338@woody.osdl.org>
References: <1163707250.10333.24.camel@localhost.localdomain>
 <20061116201531.GA31469@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



I decided to go with this instead, for now.

Please holler if you see problems with it.

		Linus

---
commit b3438f8266cb1f5010085ac47d7ad6a36a212164
Author: Linus Torvalds <torvalds@woody.osdl.org>
Date:   Mon Nov 20 11:47:18 2006 -0800

    Add "pure_initcall" for static variable initialization
    
    This is a quick hack to overcome the fact that SRCU currently does not
    allow static initializers, and we need to sometimes initialize those
    things before any other initializers (even "core" ones) can do so.
    
    Currently we don't allow this at all for modules, and the only user that
    needs is right now is cpufreq. As reported by Thomas Gleixner:
    
       "Commit b4dfdbb3c707474a2254c5b4d7e62be31a4b7da9 ("[PATCH] cpufreq:
        make the transition_notifier chain use SRCU breaks cpu frequency
        notification users, which register the callback > on core_init
        level."
    
    Cc: Thomas Gleixner <tglx@timesys.com>
    Cc: Ingo Molnar <mingo@elte.hu>
    Cc: Arjan van de Ven <arjan@infradead.org>
    Cc: Andrew Morton <akpm@osdl.org>,
    Signed-off-by: Linus Torvalds <torvalds@osdl.org>

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 86e69b7..dd0c262 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -59,7 +59,7 @@ static int __init init_cpufreq_transitio
 	srcu_init_notifier_head(&cpufreq_transition_notifier_list);
 	return 0;
 }
-core_initcall(init_cpufreq_transition_notifier_list);
+pure_initcall(init_cpufreq_transition_notifier_list);
 
 static LIST_HEAD(cpufreq_governor_list);
 static DEFINE_MUTEX (cpufreq_governor_mutex);
diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 9d87316..e60d6f2 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -215,6 +215,8 @@
 		.notes : { *(.note.*) } :note
 
 #define INITCALLS							\
+  	*(.initcall0.init)						\
+  	*(.initcall0s.init)						\
   	*(.initcall1.init)						\
   	*(.initcall1s.init)						\
   	*(.initcall2.init)						\
diff --git a/include/linux/init.h b/include/linux/init.h
index ff40ea1..5eb5d24 100644
--- a/include/linux/init.h
+++ b/include/linux/init.h
@@ -93,6 +93,14 @@ extern void setup_arch(char **);
 	static initcall_t __initcall_##fn##id __attribute_used__ \
 	__attribute__((__section__(".initcall" level ".init"))) = fn
 
+/*
+ * A "pure" initcall has no dependencies on anything else, and purely
+ * initializes variables that couldn't be statically initialized.
+ *
+ * This only exists for built-in code, not for modules.
+ */
+#define pure_initcall(fn)		__define_initcall("0",fn,1)
+
 #define core_initcall(fn)		__define_initcall("1",fn,1)
 #define core_initcall_sync(fn)		__define_initcall("1s",fn,1s)
 #define postcore_initcall(fn)		__define_initcall("2",fn,2)
