Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263209AbSJIAPm>; Tue, 8 Oct 2002 20:15:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263321AbSJIAPm>; Tue, 8 Oct 2002 20:15:42 -0400
Received: from gw.openss7.com ([142.179.199.224]:2320 "EHLO gw.openss7.com")
	by vger.kernel.org with ESMTP id <S263209AbSJIAPk>;
	Tue, 8 Oct 2002 20:15:40 -0400
Date: Tue, 8 Oct 2002 18:21:19 -0600
From: "Brian F. G. Bidulock" <bidulock@openss7.org>
To: "David S. Miller" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org, LiS <linux-streams@gsyc.escet.urjc.es>
Subject: Re: [PATCH] Re: export of sys_call_table
Message-ID: <20021008182119.A17372@openss7.org>
Reply-To: bidulock@openss7.org
Mail-Followup-To: "David S. Miller" <davem@redhat.com>,
	linux-kernel@vger.kernel.org,
	LiS <linux-streams@gsyc.escet.urjc.es>
References: <20021004164151.D2962@openss7.org> <20021004.153804.94857396.davem@redhat.com> <20021008162017.A11261@openss7.org> <20021008.161838.15299897.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20021008.161838.15299897.davem@redhat.com>; from davem@redhat.com on Tue, Oct 08, 2002 at 04:18:38PM -0700
Organization: http://www.openss7.org/
Dsn-Notification-To: <bidulock@openss7.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David,

On Tue, 08 Oct 2002, David S. Miller wrote:

> Oh really?

Many apologies.  Of course it is the wrong patch...
(My excuse: Finger trouble late in the day.)

Here is the correct patch:

--- arch/i386/kernel/entry.S.orig	2002-08-02 19:39:42.000000000 -0500
+++ arch/i386/kernel/entry.S	2002-10-08 15:43:08.000000000 -0500
@@ -584,8 +584,8 @@
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
--- kernel/ksyms.c.orig	2002-08-02 19:39:46.000000000 -0500
+++ kernel/ksyms.c	2002-10-08 15:44:37.000000000 -0500
@@ -497,6 +497,11 @@
 EXPORT_SYMBOL(seq_release);
 EXPORT_SYMBOL(seq_read);
 EXPORT_SYMBOL(seq_lseek);
+extern void register_streams_calls(int (*putpmsg) (int,void *,void *,int,int),
+				   int (*getpmsg) (int,void *,void *,int,int));
+extern void unregister_streams_calls(void);
+EXPORT_SYMBOL(register_streams_calls);
+EXPORT_SYMBOL(unregister_streams_calls);
 
 /* Program loader interfaces */
 EXPORT_SYMBOL(setup_arg_pages);
--- kernel/sys.c.orig	2002-08-02 19:39:46.000000000 -0500
+++ kernel/sys.c	2002-10-08 16:46:55.000000000 -0500
@@ -167,6 +167,45 @@
 	return notifier_chain_unregister(&reboot_notifier_list, nb);
 }
 
+static int (*do_putpmsg) (int, void *, void *, int, int) = NULL;
+static int (*do_getpmsg) (int, void *, void *, int, int) = NULL;
+
+static DECLARE_RWSEM(streams_call_sem) ;
+
+long asmlinkage sys_putpmsg(int fd, void *ctlptr, void *datptr, int band, int flags)
+{
+	int ret = -ENOSYS;
+	down_read(&streams_call_sem);
+	if (do_putpmsg)
+		ret = (*do_putpmsg) (fd, ctlptr, datptr, band, flags);
+	up_read(&streams_call_sem);
+	return ret;
+}
+
+long asmlinkage sys_getpmsg(int fd, void *ctlptr, void *datptr, int band, int flags)
+{
+	int ret = -ENOSYS;
+	down_read(&streams_call_sem);
+	if (do_getpmsg)
+		ret = (*do_getpmsg) (fd, ctlptr, datptr, band, flags);
+	up_read(&streams_call_sem);
+	return ret;
+}
+
+void register_streams_calls(int (*putpmsg) (int, void *, void *, int, int),
+			    int (*getpmsg) (int, void *, void *, int, int))
+{
+	down_write(&streams_call_sem);
+	do_putpmsg = putpmsg;
+	do_getpmsg = getpmsg;
+	up_write(&streams_call_sem);
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


-- 
Brian F. G. Bidulock    ¦ The reasonable man adapts himself to the ¦
bidulock@openss7.org    ¦ world; the unreasonable one persists in  ¦
http://www.openss7.org/ ¦ trying  to adapt the  world  to himself. ¦
                        ¦ Therefore  all  progress  depends on the ¦
                        ¦ unreasonable man. -- George Bernard Shaw ¦
