Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965248AbWGKHY1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965248AbWGKHY1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 03:24:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965250AbWGKHY1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 03:24:27 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:57832 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S965248AbWGKHY0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 03:24:26 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] sysctl:  Scream if someone uses sys_sysctl
References: <m1u05pkruk.fsf@ebiederm.dsl.xmission.com>
	<20060710211951.7bf8320b.akpm@osdl.org>
Date: Tue, 11 Jul 2006 01:23:45 -0600
In-Reply-To: <20060710211951.7bf8320b.akpm@osdl.org> (Andrew Morton's message
	of "Mon, 10 Jul 2006 21:19:51 -0700")
Message-ID: <m1lkr0haf2.fsf_-_@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


As far as I can tell we never use sys_sysctl so I never expect to see
these messages.  But if we do see these it means that there are user
space applications that need to be fixed before we can safely
remove sys_sysctl.

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
---

Since this patch was trivial I just wipped up this incremental
version.  The code compiles is all I know.

 kernel/sysctl.c |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 42610e6..6e7f13a 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -1306,6 +1306,11 @@ asmlinkage long sys_sysctl(struct __sysc
 	struct __sysctl_args tmp;
 	int error;
 
+	if (printk_ratelimit())
+		printk(KERN_INFO
+			"warning: process `%s' used the obsolete sysctl "
+			"system call\n", current->comm);
+
 	if (copy_from_user(&tmp, args, sizeof(tmp)))
 		return -EFAULT;
 
@@ -2688,6 +2693,10 @@ #else /* CONFIG_SYSCTL_SYSCALL */
 
 asmlinkage long sys_sysctl(struct __sysctl_args __user *args)
 {
+	if (printk_ratelimit())
+		printk(KERN_INFO
+			"warning: process `%s' used the removed sysctl "
+			"system call\n", current->comm);
 	return -ENOSYS;
 }
 
-- 
1.4.1.gac83a

