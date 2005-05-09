Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261534AbVEIVrV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261534AbVEIVrV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 May 2005 17:47:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261535AbVEIVrV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 May 2005 17:47:21 -0400
Received: from web50610.mail.yahoo.com ([206.190.38.249]:36239 "HELO
	web50610.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261534AbVEIVrL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 May 2005 17:47:11 -0400
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  b=GzQd8VrRtNv2TSsnqBxQIS6gSJfw2Mvm3MrY3iznKkx8sO1NGBGDj6ewpvJyolTLMW7WPrZ5PWZ6e27bMI35/s6kUR5brYI+dgU1/e2TlyWiTRwPUts2B2Ln32Uk/vFqIuKqUrMSLwDP/UBNydQ5W6yichE4YAcmtlYl7w+XZ6c=  ;
Message-ID: <20050509214710.419.qmail@web50610.mail.yahoo.com>
Date: Mon, 9 May 2005 14:47:10 -0700 (PDT)
From: Yoav Zach <yoav_zach@yahoo.com>
Subject: [PATCH]: Don't force O_LARGEFILE for 32 bit processes on ia64 - 2.6.12-rc3
To: torvalds@osdl.org
Cc: lkml <linux-kernel@vger.kernel.org>, Yoav Zach <yoav.zach@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In ia64 kernel, the O_LARGEFILE flag is forced when
opening a file. This is problematic for execution of
32 bit processes, which are not largefile aware, either
by SW emulation or by HW execution.
For such processes, the problem is two-fold:
1) When trying to open a file that is larger than 4G
   the operation should fail, but it's not
2) Writing to offset larger than 4G should fail, but
   it's not

The proposed patch takes advantage of the way 32 bit
processes are identified in ia64 systems. Such 
processes have PER_LINUX32 for their personality. With
the patch, the ia64 kernel will not enforce the O_LARGEFILE
flag if the current process has PER_LINUX32 set.
The behavior for all other architectures remains unchanged.

The patch is against 2.6.12-rc3.

Signed-off-by: Yoav Zach <yoav.zach@intel.com>
Acked-by: Tony Luck <tony.luck@intel.com>
============================================================================================
diff -r -U 3 -p -N linux-2.6.12-rc3/fs/open.c linux/fs/open.c
--- linux-2.6.12-rc3/fs/open.c	2005-04-21 03:03:15.000000000 +0300
+++ linux/fs/open.c	2005-05-09 23:50:08.000000000 +0300
@@ -21,6 +21,7 @@
 #include <linux/vfs.h>
 #include <asm/uaccess.h>
 #include <linux/fs.h>
+#include <linux/personality.h>
 #include <linux/pagemap.h>
 #include <linux/syscalls.h>
 
@@ -935,9 +936,9 @@ asmlinkage long sys_open(const char __us
 	char * tmp;
 	int fd, error;
 
-#if BITS_PER_LONG != 32
-	flags |= O_LARGEFILE;
-#endif
+	if (force_o_largefile())
+		flags |= O_LARGEFILE;
+
 	tmp = getname(filename);
 	fd = PTR_ERR(tmp);
 	if (!IS_ERR(tmp)) {
diff -r -U 3 -p -N linux-2.6.12-rc3/include/asm-ia64/fcntl.h linux/include/asm-ia64/fcntl.h
--- linux-2.6.12-rc3/include/asm-ia64/fcntl.h	2005-04-21 03:03:16.000000000 +0300
+++ linux/include/asm-ia64/fcntl.h	2005-05-09 23:51:53.000000000 +0300
@@ -81,4 +81,6 @@ struct flock {
 
 #define F_LINUX_SPECIFIC_BASE	1024
 
+#define force_o_largefile() ( ! (current->personality & PER_LINUX32) )
+
 #endif /* _ASM_IA64_FCNTL_H */
diff -r -U 3 -p -N linux-2.6.12-rc3/include/linux/fcntl.h linux/include/linux/fcntl.h
--- linux-2.6.12-rc3/include/linux/fcntl.h	2005-04-21 03:03:16.000000000 +0300
+++ linux/include/linux/fcntl.h	2005-05-09 23:51:46.000000000 +0300
@@ -25,6 +25,10 @@
 
 #ifdef __KERNEL__
 
+#ifndef force_o_largefile
+#define force_o_largefile() (BITS_PER_LONG != 32)
+#endif
+
 #if BITS_PER_LONG == 32
 #define IS_GETLK32(cmd)		((cmd) == F_GETLK)
 #define IS_SETLK32(cmd)		((cmd) == F_SETLK)
============================================================================================


Thanks,
Yoav.


Yoav Zach
IA-32 Execution Layer
Performance Tools Lab
Intel Corp.



		
__________________________________ 
Do you Yahoo!? 
Read only the mail you want - Yahoo! Mail SpamGuard. 
http://promotions.yahoo.com/new_mail 
