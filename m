Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263607AbRFNSY5>; Thu, 14 Jun 2001 14:24:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263669AbRFNSYr>; Thu, 14 Jun 2001 14:24:47 -0400
Received: from mail.missioncriticallinux.com ([208.51.139.18]:28424 "EHLO
	missioncriticallinux.com") by vger.kernel.org with ESMTP
	id <S263607AbRFNSYe>; Thu, 14 Jun 2001 14:24:34 -0400
Date: Thu, 14 Jun 2001 14:24:27 -0400
From: "Pat O'Rourke" <orourke@missioncriticallinux.com>
Message-Id: <200106141824.OAA21231@missioncriticallinux.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Let modules register for panics, kernel 2.4.6-pre3
Cc: torvalds@transmeta.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below permits a loadable module / driver to add itself to
the panic_notifier_list.  Previously only code compiled directly into
the kernel was able to register for panic notification.

Thanks,

Pat

--
Patrick O'Rourke
orourke@missioncriticallinux.com

diff -u --new-file --recursive linux-2.4.6-pre3-orig/include/linux/kernel.h linux-2.4.6-pre3/include/linux/kernel.h
--- linux-2.4.6-pre3-orig/include/linux/kernel.h	Thu Jun 14 11:38:25 2001
+++ linux-2.4.6-pre3/include/linux/kernel.h	Thu Jun 14 11:50:21 2001
@@ -48,6 +48,8 @@
 struct semaphore;
 
 extern struct notifier_block *panic_notifier_list;
+extern int register_panic_notifier(struct notifier_block *);
+extern int unregister_panic_notifier(struct notifier_block *);
 NORET_TYPE void panic(const char * fmt, ...)
 	__attribute__ ((NORET_AND format (printf, 1, 2)));
 NORET_TYPE void do_exit(long error_code)
diff -u --new-file --recursive linux-2.4.6-pre3-orig/kernel/ksyms.c linux-2.4.6-pre3/kernel/ksyms.c
--- linux-2.4.6-pre3-orig/kernel/ksyms.c	Thu Jun 14 11:38:26 2001
+++ linux-2.4.6-pre3/kernel/ksyms.c	Thu Jun 14 11:41:18 2001
@@ -468,6 +468,8 @@
 EXPORT_SYMBOL(cap_bset);
 EXPORT_SYMBOL(daemonize);
 EXPORT_SYMBOL(csum_partial); /* for networking and md */
+EXPORT_SYMBOL(register_panic_notifier);
+EXPORT_SYMBOL(unregister_panic_notifier);
 
 /* Program loader interfaces */
 EXPORT_SYMBOL(setup_arg_pages);
diff -u --new-file --recursive linux-2.4.6-pre3-orig/kernel/panic.c linux-2.4.6-pre3/kernel/panic.c
--- linux-2.4.6-pre3-orig/kernel/panic.c	Mon Oct 16 15:58:51 2000
+++ linux-2.4.6-pre3/kernel/panic.c	Thu Jun 14 13:05:00 2001
@@ -101,3 +101,33 @@
 		CHECK_EMERGENCY_SYNC
 	}
 }
+
+/**
+ *	register_panic_notifier - Register a function to be called on panic
+ *	@nb: Info about notifier function to be called
+ *
+ *	Registers a function with the list of functions to be called at
+ *	the time of a system panic.
+ *
+ *	Currently always returns zero, as notifier_chain_register
+ *	always returns zero.
+ */
+
+int register_panic_notifier(struct notifier_block *nb)
+{
+	return notifier_chain_register(&panic_notifier_list, nb);
+}
+
+/**
+ *	unregister_panic_notifier - Unregister a panic notifier
+ *	@nb:	Hook to be unregistered
+ *
+ *	Unregisters a previously registered panic notifier function.
+ *
+ *	Returns zero on success, or %-ENOENT on failure.
+ */
+
+int unregister_panic_notifier(struct notifier_block *nb)
+{
+	return notifier_chain_unregister(&panic_notifier_list, nb);
+}
