Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264172AbTKKAgi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Nov 2003 19:36:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264176AbTKKAgh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Nov 2003 19:36:37 -0500
Received: from fw.osdl.org ([65.172.181.6]:44698 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264172AbTKKAge (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Nov 2003 19:36:34 -0500
Date: Mon, 10 Nov 2003 16:40:30 -0800
From: Andrew Morton <akpm@osdl.org>
To: Jeff Bowden <jlb@houseofdistraction.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: percpu_counter_mod not getting into SMP kernel image when
 ext2/3 compiled as modules
Message-Id: <20031110164030.30233f48.akpm@osdl.org>
In-Reply-To: <3FB01F7E.7090100@houseofdistraction.com>
References: <3FB01F7E.7090100@houseofdistraction.com>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Bowden <jlb@houseofdistraction.com> wrote:
>
> In 2.6.9-test9 (also tried with bk15) I have ext2 and ext3 both 
>  configured as modules.  When I do "modprobe ext3" it says:
> 
>    FATAL: Error inserting ext3 
>  (/lib/modules/2.6.0-test9-bug-t1/kernel/fs/ext3/ext3.ko): Unknown symbol 
>  in module, or unknown parameter (see dmesg)
> 
>  and dmesg says:
> 
>    ext3: Unknown symbol percpu_counter_mod

You'll be needing this:

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
--- 25/lib/Makefile~percpu-counter-linkage-fix	2003-11-07 20:36:48.000000000 -0800
+++ 25-akpm/lib/Makefile	2003-11-07 20:36:48.000000000 -0800
@@ -9,7 +9,6 @@ lib-y := errno.o ctype.o string.o vsprin
 
 lib-$(CONFIG_RWSEM_GENERIC_SPINLOCK) += rwsem-spinlock.o
 lib-$(CONFIG_RWSEM_XCHGADD_ALGORITHM) += rwsem.o
-lib-$(CONFIG_SMP) += percpu_counter.o
 
 ifneq ($(CONFIG_HAVE_DEC_LOCK),y) 
   lib-y += dec_and_lock.o
diff -puN mm/swap.c~percpu-counter-linkage-fix mm/swap.c
--- 25/mm/swap.c~percpu-counter-linkage-fix	2003-11-07 20:36:48.000000000 -0800
+++ 25-akpm/mm/swap.c	2003-11-07 20:36:48.000000000 -0800
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

