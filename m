Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261506AbSJHWQI>; Tue, 8 Oct 2002 18:16:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261566AbSJHWQH>; Tue, 8 Oct 2002 18:16:07 -0400
Received: from fw.openss7.com ([142.179.197.31]:14607 "EHLO gw.openss7.com")
	by vger.kernel.org with ESMTP id <S261506AbSJHWOh>;
	Tue, 8 Oct 2002 18:14:37 -0400
Date: Tue, 8 Oct 2002 16:20:17 -0600
From: "Brian F. G. Bidulock" <bidulock@openss7.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Re: export of sys_call_table
Message-ID: <20021008162017.A11261@openss7.org>
Reply-To: bidulock@openss7.org
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20021004131547.B2369@openss7.org> <20021004.152116.116611188.davem@redhat.com> <20021004164151.D2962@openss7.org> <20021004.153804.94857396.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20021004.153804.94857396.davem@redhat.com>; from davem@redhat.com on Fri, Oct 04, 2002 at 03:38:04PM -0700
Organization: http://www.openss7.org/
Dsn-Notification-To: <bidulock@openss7.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Following is a tested patch for i386 architecture for registration
of putpmsg and getpmsg system calls.  This version (courtesy of
Dave Grothe at GCOM) uses up/down semaphore instead of read/write
spinlocks.  The patch is against 2.4.19 but should apply up and
down a ways as well.

--brian

--- arch/i386/kernel/entry.S.orig	2002-09-04 10:54:01.000000000 -0500
+++ arch/i386/kernel/entry.S	2002-10-08 11:39:14.000000000 -0500
@@ -586,8 +586,8 @@
 	.long SYMBOL_NAME(sys_capset)           /* 185 */
 	.long SYMBOL_NAME(sys_sigaltstack)
 	.long SYMBOL_NAME(sys_sendfile)
-	.long SYMBOL_NAME(sys_ni_syscall)		/* streams1 */
-	.long SYMBOL_NAME(sys_ni_syscall)		/* streams2 */
+	.long SYMBOL_NAME(sys_getpmsg)		/* streams1 */
+	.long SYMBOL_NAME(sys_putpmsg)		/* streams2 */
 	.long SYMBOL_NAME(sys_vfork)            /* 190 */
 	.long SYMBOL_NAME(sys_getrlimit)
 	.long SYMBOL_NAME(sys_mmap2)
--- kernel/ksyms.c.orig	2002-09-04 10:54:06.000000000 -0500
+++ kernel/ksyms.c	2002-10-08 11:39:14.000000000 -0500
@@ -541,6 +541,11 @@
 EXPORT_SYMBOL(seq_lseek);
 extern int disable_all_usb;
 EXPORT_SYMBOL(disable_all_usb);
+extern void register_streams_calls(int (*putpmsg) (int,void *,void *,int,int),
+			    int (*getpmsg) (int,void *,void *,int,int));
+extern void unregister_streams_calls(void);
+EXPORT_SYMBOL(register_streams_calls);
+EXPORT_SYMBOL(unregister_streams_calls);
 
 /* Program loader interfaces */
 EXPORT_SYMBOL(setup_arg_pages);
--- kernel/sys.c.orig	2002-09-04 10:54:01.000000000 -0500
+++ kernel/sys.c	2002-10-08 11:39:14.000000000 -0500
@@ -168,6 +168,45 @@
 	return notifier_chain_unregister(&reboot_notifier_list, nb);
 }
 
+static int (*do_putpmsg) (int, void *, void *, int, int) = NULL;
+static int (*do_getpmsg) (int, void *, void *, int, int) = NULL;
+
+static rwlock_t streams_call_lock = RW_LOCK_UNLOCKED;
+
+long asmlinkage sys_putpmsg(int fd, void *ctlptr, void *datptr, int band, int flags)
+{
+	int ret = -ENOSYS;
+	read_lock(&streams_call_lock);
+	if (do_putpmsg)
+		ret = (*do_putpmsg) (fd, ctlptr, datptr, band, flags);
+	read_unlock(&streams_call_lock);
+	return ret;
+}
+
+long asmlinkage sys_getpmsg(int fd, void *ctlptr, void *datptr, int band, int flags)
+{
+	int ret = -ENOSYS;
+	read_lock(&streams_call_lock);
+	if (do_getpmsg)
+		ret = (*do_getpmsg) (fd, ctlptr, datptr, band, flags);
+	read_unlock(&streams_call_lock);
+	return ret;
+}
+
+void register_streams_calls(int (*putpmsg) (int, void *, void *, int, int),
+			    int (*getpmsg) (int, void *, void *, int, int))
+{
+	write_lock(&streams_call_lock);
+	do_putpmsg = putpmsg;
+	do_getpmsg = getpmsg;
+	write_unlock(&streams_call_lock);
+}
+
+void unregister_streams_calls(void)
+{
+	register_streams_calls(NULL, NULL);
+}
+
 asmlinkage long sys_ni_syscall(void)
 {
 	return -ENOSYS;

