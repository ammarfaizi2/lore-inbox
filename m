Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264351AbTH2B3F (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Aug 2003 21:29:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264362AbTH2B3F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Aug 2003 21:29:05 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:43976
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S264351AbTH2B2y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Aug 2003 21:28:54 -0400
Date: Fri, 29 Aug 2003 03:30:17 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: linux-kernel@vger.kernel.org
Subject: vmalloc allocations in ipc needs smp initialized (and vm must be allowed to schedule in 2.6)
Message-ID: <20030829013017.GQ24409@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcelo,

I submit you this patch for 2.4.23 merging. In short if you change
SEMMNI to 8192 the kernel will crash at boot, beause it tries to call
vmalloc before the smp is initialized. The reason is that vmalloc calls
into the pte alloc code, and the fast pte alloc is tried first, but that
reads into the pte_quicklist, that requires the cpu_data to be
initialized (and that happens in smp_init()).

the patch is obviously safe, since no piece of kernel (especially the
code in the check_bugs and smp_init paths ;) calls into the ipc
subsystem.

The reason this started to trigger wasn't really that we increased
SEMMNI, but what happend is that some IPC data structure grown, and for
some reason the corruption due the uninitalized pte_quicklist
triggers only for smp boxes with less than 1G (not very common anymore
;). So it wasn't immediatly reproducible on all setups.

2.6 doesn't suffer from the same problem, simply because 2.6 isn't using
the quicklist anymore, but I think it would be much more correct to make
the same change in 2.6 too, since whatever cond_resched() in the vm
paths (and they're definitely allowed to call it), will lead to a crash
since the init task isn't initialized and the scheduler can't be invoked
yet. (and 2.6 already has the bigger data structures that should trigger
the vmalloc all the time on all setups)

--- x/init/main.c.~1~	2003-08-26 00:13:17.000000000 +0200
+++ x/init/main.c	2003-08-29 03:20:46.000000000 +0200
@@ -424,9 +424,6 @@ asmlinkage void __init start_kernel(void
 #ifdef CONFIG_PROC_FS
 	proc_root_init();
 #endif
-#if defined(CONFIG_SYSVIPC)
-	ipc_init();
-#endif
 	check_bugs();
 	printk("POSIX conformance testing by UNIFIX\n");
 
@@ -436,6 +433,9 @@ asmlinkage void __init start_kernel(void
 	 *	make syscalls (and thus be locked).
 	 */
 	smp_init();
+#if defined(CONFIG_SYSVIPC)
+	ipc_init();
+#endif
 	rest_init();
 }
 
Andrea
