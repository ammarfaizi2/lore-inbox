Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266816AbUHIShp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266816AbUHIShp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 14:37:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266863AbUHISeN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 14:34:13 -0400
Received: from fw.osdl.org ([65.172.181.6]:34955 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266830AbUHISbz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 14:31:55 -0400
Date: Mon, 9 Aug 2004 11:30:12 -0700
From: Andrew Morton <akpm@osdl.org>
To: Janet Morgan <janetmor@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, akiyama.nobuyuk@jp.fujitsu.com,
       janetmor@us.ibm.com
Subject: Re: 2.6.8-rc3-mm2:  compile error proc_unknown_nmi_panic ->
 proc_dointvec
Message-Id: <20040809113012.7bed43fe.akpm@osdl.org>
In-Reply-To: <41175326.8000303@us.ibm.com>
References: <41175326.8000303@us.ibm.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Janet Morgan <janetmor@us.ibm.com> wrote:
>
> I'm getting the following error compiling 2.6.8-rc3-mm2:
> 
>  arch/i386/kernel/nmi.c: In function `proc_unknown_nmi_panic':
>  arch/i386/kernel/nmi.c:558: too few arguments to function `proc_dointvec'
>  make[1]: *** [arch/i386/kernel/nmi.o] Error 1
>  make: *** [arch/i386/kernel] Error 2

yup, sorry about that.

diff -puN arch/i386/kernel/nmi.c~nmi-build-fix arch/i386/kernel/nmi.c
--- 25/arch/i386/kernel/nmi.c~nmi-build-fix	2004-08-08 16:17:11.177604608 -0700
+++ 25-akpm/arch/i386/kernel/nmi.c	2004-08-08 16:17:11.181604000 -0700
@@ -524,13 +524,13 @@ static int unknown_nmi_panic_callback(st
 /*
  * proc handler for /proc/sys/kernel/unknown_nmi_panic
  */
-int proc_unknown_nmi_panic(ctl_table *table, int write,
-                struct file *file, void __user *buffer, size_t *length)
+int proc_unknown_nmi_panic(ctl_table *table, int write, struct file *file,
+			void __user *buffer, size_t *length, loff_t *ppos)
 {
 	int old_state;
 
 	old_state = unknown_nmi_panic;
-	proc_dointvec(table, write, file, buffer, length);
+	proc_dointvec(table, write, file, buffer, length, ppos);
 	if (!!old_state == !!unknown_nmi_panic)
 		return 0;
 
diff -puN kernel/sysctl.c~nmi-build-fix kernel/sysctl.c
--- 25/kernel/sysctl.c~nmi-build-fix	2004-08-08 16:17:11.178604456 -0700
+++ 25-akpm/kernel/sysctl.c	2004-08-08 16:17:11.191602480 -0700
@@ -68,7 +68,7 @@ extern int printk_ratelimit_burst;
 #if defined(CONFIG_X86_LOCAL_APIC) && defined(__i386__)
 int unknown_nmi_panic;
 extern int proc_unknown_nmi_panic(ctl_table *, int, struct file *,
-				  void __user *, size_t *);
+				  void __user *, size_t *, loff_t *);
 #endif
 
 /* this is needed for the proc_dointvec_minmax for [fs_]overflow UID and GID */
_

