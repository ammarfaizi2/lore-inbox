Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262187AbVDMDTL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262187AbVDMDTL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 23:19:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262609AbVDLTc5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 15:32:57 -0400
Received: from fire.osdl.org ([65.172.181.4]:10185 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262189AbVDLKcO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 06:32:14 -0400
Message-Id: <200504121032.j3CAW38F005489@shell0.pdx.osdl.net>
Subject: [patch 090/198] x86_64: Remove excessive stack allocation in MCE code with large NR_CPUS
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, ak@suse.de
From: akpm@osdl.org
Date: Tue, 12 Apr 2005 03:31:57 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: "Andi Kleen" <ak@suse.de>

Remove excessive stack allocation in MCE code with large NR_CPUS

Signed-off-by: Andi Kleen <ak@suse.de>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 25-akpm/arch/x86_64/kernel/mce.c |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletion(-)

diff -puN arch/x86_64/kernel/mce.c~x86_64-remove-excessive-stack-allocation-in-mce-code arch/x86_64/kernel/mce.c
--- 25/arch/x86_64/kernel/mce.c~x86_64-remove-excessive-stack-allocation-in-mce-code	2005-04-12 03:21:24.658388256 -0700
+++ 25-akpm/arch/x86_64/kernel/mce.c	2005-04-12 03:21:24.661387800 -0700
@@ -379,18 +379,23 @@ static void collect_tscs(void *data) 
 
 static ssize_t mce_read(struct file *filp, char __user *ubuf, size_t usize, loff_t *off)
 {
-	unsigned long cpu_tsc[NR_CPUS];
+	unsigned long *cpu_tsc;
 	static DECLARE_MUTEX(mce_read_sem);
 	unsigned next;
 	char __user *buf = ubuf;
 	int i, err;
 
+	cpu_tsc = kmalloc(NR_CPUS * sizeof(long), GFP_KERNEL);
+	if (!cpu_tsc)
+		return -ENOMEM;
+
 	down(&mce_read_sem); 
 	next = rcu_dereference(mcelog.next);
 
 	/* Only supports full reads right now */
 	if (*off != 0 || usize < MCE_LOG_LEN*sizeof(struct mce)) { 
 		up(&mce_read_sem);
+		kfree(cpu_tsc);
 		return -EINVAL;
 	}
 
@@ -421,6 +426,7 @@ static ssize_t mce_read(struct file *fil
 		}
 	} 	
 	up(&mce_read_sem);
+	kfree(cpu_tsc);
 	return err ? -EFAULT : buf - ubuf; 
 }
 
_
