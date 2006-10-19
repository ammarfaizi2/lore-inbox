Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030280AbWJSEnM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030280AbWJSEnM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 00:43:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030294AbWJSEnM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 00:43:12 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:41645 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1030280AbWJSEnM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 00:43:12 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Andrew Morton <akpm@osdl.org>
Cc: Cal Peake <cp@absolutedigital.net>, Linus Torvalds <torvalds@osdl.org>,
       Albert Cahalan <acahalan@gmail.com>,
       linux-kernel <linux-kernel@vger.kernel.org>, ebiederm@xmission.com
Subject: [RFC] [PATCH] Improve the remove sysctl warnings.
References: <787b0d920610181123q1848693ajccf7a91567e54227@mail.gmail.com>
	<Pine.LNX.4.64.0610181129090.3962@g5.osdl.org>
	<Pine.LNX.4.64.0610181443170.7303@lancer.cnet.absolutedigital.net>
	<20061018124415.e45ece22.akpm@osdl.org>
Date: Wed, 18 Oct 2006 22:41:29 -0600
In-Reply-To: <20061018124415.e45ece22.akpm@osdl.org> (Andrew Morton's message
	of "Wed, 18 Oct 2006 12:44:15 -0700")
Message-ID: <m17iyw7w92.fsf_-_@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Andrew how does this look?

Don't warn about libpthread's access to kernel.version.
When it receives -ENOSYS it will read /proc/sys/kernel/version.

If anything else shows up print the sysctl number string.

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
---
 kernel/sysctl.c |   22 +++++++++++++++++++++-
 1 files changed, 21 insertions(+), 1 deletions(-)

diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 8020fb2..19124ee 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -2676,13 +2676,33 @@ #else /* CONFIG_SYSCTL_SYSCALL */
 asmlinkage long sys_sysctl(struct __sysctl_args __user *args)
 {
 	static int msg_count;
+	struct __sysctl_args tmp;
+	int name[CTL_MAXNAME];
+	int i;
+
+	/* Read in the sysctl name for better debug message logging */
+	if (copy_from_user(&tmp, args, sizeof(tmp)))
+		return -EFAULT;
+	if (tmp.nlen <= 0 || tmp.nlen >= CTL_MAXNAME)
+		return -ENOTDIR;
+	for (i = 0; i < tmp.nlen; i++)
+		if (get_user(name[i], tmp.name + i))
+			return -EFAULT;
 
+	/* Ignore accesses to kernel.version */
+	if ((tmp.nlen == 2) && (name[0] == CTL_KERN) && (name[1] == KERN_VERSION))
+		goto out;
+	
 	if (msg_count < 5) {
 		msg_count++;
 		printk(KERN_INFO
 			"warning: process `%s' used the removed sysctl "
-			"system call\n", current->comm);
+			"system call with ", current->comm);
+		for (i = 0; i < tmp.nlen; i++)
+			printk("%d.", name[i]);
+		printk("\n");
 	}
+out:
 	return -ENOSYS;
 }
 
-- 
1.4.2.rc3.g7e18e-dirty

