Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261613AbTKHEa6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Nov 2003 23:30:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261598AbTKHEa6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Nov 2003 23:30:58 -0500
Received: from fw.osdl.org ([65.172.181.6]:1767 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261613AbTKHEaz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Nov 2003 23:30:55 -0500
Date: Fri, 7 Nov 2003 20:34:19 -0800
From: Andrew Morton <akpm@osdl.org>
To: James Bottomley <James.Bottomley@steeleye.com>
Cc: linux-kernel@vger.kernel.org, rusty@rustcorp.com.au
Subject: Re: lib.a causing modules not to load
Message-Id: <20031107203419.7d0de676.akpm@osdl.org>
In-Reply-To: <1068222065.1894.21.camel@mulgrave>
References: <1068222065.1894.21.camel@mulgrave>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Bottomley <James.Bottomley@steeleye.com> wrote:
>
> I think this has been mentioned before, but I just ran across it again
>  recently.  The problem is that if the only reference to a routine in
>  lib.a is in a module, then it never gets compiled into the kernel, and
>  the module won't load.
> 
>  In 2.6.0-test9 this is shown by compiling both ext2 and ext3 as
>  modules.  Since they're the only things to refer to percpu_counter_mod
>  which is in lib.a in an SMP system.

How about we just link that function into the kernel and be done with it? 
We'll waste a few bytes on SMP machines which have neither ext2 nor ext3
linked-in or loaded as modules, but that doesn't sound very important...

(We don't have a kernel/random-support-stuff.c, but we have
mm/random-support-stuff.c which for some reason is called mm/swap.c, so
I put it there).



diff -puN -L lib/percpu_counter.c lib/percpu_counter.c~percpu-counter-linkage-fix /dev/null
--- 25/lib/percpu_counter.c
+++ /dev/null	2002-08-30 16:31:37.000000000 -0700
@@ -1,21 +0,0 @@
-#include <linux/module.h>
-#include <linux/percpu_counter.h>
-#include <linux/sched.h>
-
-void percpu_counter_mod(struct percpu_counter *fbc, long amount)
-{
-	int cpu = get_cpu();
-	long count = fbc->counters[cpu].count;
-
-	count += amount;
-	if (count >= FBC_BATCH || count <= -FBC_BATCH) {
-		spin_lock(&fbc->lock);
-		fbc->count += count;
-		spin_unlock(&fbc->lock);
-		count = 0;
-	}
-	fbc->counters[cpu].count = count;
-	put_cpu();
-}
-
-EXPORT_SYMBOL(percpu_counter_mod);
diff -puN lib/Makefile~percpu-counter-linkage-fix lib/Makefile
--- 25/lib/Makefile~percpu-counter-linkage-fix	2003-11-07 20:26:09.000000000 -0800
+++ 25-akpm/lib/Makefile	2003-11-07 20:26:24.000000000 -0800
@@ -9,7 +9,6 @@ lib-y := errno.o ctype.o string.o vsprin
 
 lib-$(CONFIG_RWSEM_GENERIC_SPINLOCK) += rwsem-spinlock.o
 lib-$(CONFIG_RWSEM_XCHGADD_ALGORITHM) += rwsem.o
-lib-$(CONFIG_SMP) += percpu_counter.o
 
 ifneq ($(CONFIG_HAVE_DEC_LOCK),y) 
   lib-y += dec_and_lock.o
diff -puN mm/swap.c~percpu-counter-linkage-fix mm/swap.c
--- 25/mm/swap.c~percpu-counter-linkage-fix	2003-11-07 20:26:09.000000000 -0800
+++ 25-akpm/mm/swap.c	2003-11-07 20:28:10.000000000 -0800
@@ -14,6 +14,7 @@
  */
 
 #include <linux/mm.h>
+#include <linux/sched.h>
 #include <linux/kernel_stat.h>
 #include <linux/swap.h>
 #include <linux/mman.h>
@@ -23,6 +24,8 @@
 #include <linux/module.h>
 #include <linux/mm_inline.h>
 #include <linux/buffer_head.h>	/* for try_to_release_page() */
+#include <linux/module.h>
+#include <linux/percpu_counter.h>
 #include <linux/percpu.h>
 
 /* How many pages do we try to swap or page in/out together? */
@@ -380,6 +383,24 @@ void vm_acct_memory(long pages)
 EXPORT_SYMBOL(vm_acct_memory);
 #endif
 
+#ifdef CONFIG_SMP
+void percpu_counter_mod(struct percpu_counter *fbc, long amount)
+{
+	int cpu = get_cpu();
+	long count = fbc->counters[cpu].count;
+
+	count += amount;
+	if (count >= FBC_BATCH || count <= -FBC_BATCH) {
+		spin_lock(&fbc->lock);
+		fbc->count += count;
+		spin_unlock(&fbc->lock);
+		count = 0;
+	}
+	fbc->counters[cpu].count = count;
+	put_cpu();
+}
+EXPORT_SYMBOL(percpu_counter_mod);
+#endif
 
 /*
  * Perform any setup for the swap system

_

