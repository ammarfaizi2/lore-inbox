Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262534AbTCIQXU>; Sun, 9 Mar 2003 11:23:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262535AbTCIQXU>; Sun, 9 Mar 2003 11:23:20 -0500
Received: from mailout02.sul.t-online.com ([194.25.134.17]:708 "EHLO
	mailout02.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S262534AbTCIQXS>; Sun, 9 Mar 2003 11:23:18 -0500
Date: Sun, 9 Mar 2003 17:33:39 +0100
From: Andi Kleen <ak@muc.de>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Fix memory leak in copy_thread
Message-ID: <20030309163339.GA2346@averell>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Discovered on x86-64 and now ported.

copy_thread could leak memory if you had a io bitmap and passed wrong
arguments to the new clone flags.

-Andi

--- linux/arch/i386/kernel/process.c	2003-02-26 12:55:16.000000000 +0100
+++ linux-2.5.63-work/arch/i386/kernel/process.c	2003-03-04 22:28:20.000000000 +0100
@@ -281,6 +281,7 @@
 {
 	struct pt_regs * childregs;
 	struct task_struct *tsk;
+	int err;
 
 	childregs = ((struct pt_regs *) (THREAD_SIZE + (unsigned long) p->thread_info)) - 1;
 	struct_cpy(childregs, regs);
@@ -316,20 +317,27 @@
 		struct user_desc info;
 		int idx;
 
+		err = -EFAULT;
 		if (copy_from_user(&info, (void *)childregs->esi, sizeof(info)))
-			return -EFAULT;
+			goto out;
+		err = -EINVAL;
 		if (LDT_empty(&info))
-			return -EINVAL;
+			goto out;
 
 		idx = info.entry_number;
 		if (idx < GDT_ENTRY_TLS_MIN || idx > GDT_ENTRY_TLS_MAX)
-			return -EINVAL;
+			goto out;
 
 		desc = p->thread.tls_array + idx - GDT_ENTRY_TLS_MIN;
 		desc->a = LDT_entry_a(&info);
 		desc->b = LDT_entry_b(&info);
 	}
-	return 0;
+
+	err = 0;
+ out:
+	if (p->thread.ts_io_bitmap)
+		kfree(p->thread.ts_io_bitmap);
+	return err;
 }
 
 /*
