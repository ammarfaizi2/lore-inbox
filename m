Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262667AbTHZVJ5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Aug 2003 17:09:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262791AbTHZVJ5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Aug 2003 17:09:57 -0400
Received: from fw.osdl.org ([65.172.181.6]:3720 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262667AbTHZVJ0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Aug 2003 17:09:26 -0400
Date: Tue, 26 Aug 2003 13:53:23 -0700
From: Andrew Morton <akpm@osdl.org>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: cijoml@volny.cz, linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test4: CONFIG_KCORE_AOUT doesn't compile
Message-Id: <20030826135323.2c33e697.akpm@osdl.org>
In-Reply-To: <20030826105145.GC7038@fs.tum.de>
References: <200308252332.46101.cijoml@volny.cz>
	<20030826105145.GC7038@fs.tum.de>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk <bunk@fs.tum.de> wrote:
>
> Is there any specific reason to keep CONFIG_KCORE_AOUT or is it time to 
> remove this option?

Time to kill it I suspect.

This fixes the linkage problem:


diff -puN include/linux/proc_fs.h~kcore-aout-build-fix include/linux/proc_fs.h
--- 25/include/linux/proc_fs.h~kcore-aout-build-fix	Tue Aug 26 13:29:07 2003
+++ 25-akpm/include/linux/proc_fs.h	Tue Aug 26 13:29:07 2003
@@ -182,12 +182,6 @@ static inline void proc_net_remove(const
 	remove_proc_entry(name,proc_net);
 }
 
-/*
- * fs/proc/kcore.c
- */
-extern void kclist_add(struct kcore_list *, void *, size_t);
-extern struct kcore_list *kclist_del(void *);
-
 #else
 
 #define proc_root_driver NULL
@@ -223,6 +217,9 @@ static inline void proc_tty_unregister_d
 
 extern struct proc_dir_entry proc_root;
 
+#endif /* CONFIG_PROC_FS */
+
+#if !defined(CONFIG_PROC_FS) || defined(CONFIG_KCORE_AOUT)
 static inline void kclist_add(struct kcore_list *new, void *addr, size_t size)
 {
 }
@@ -230,8 +227,10 @@ static inline struct kcore_list * kclist
 {
 	return NULL;
 }
-
-#endif /* CONFIG_PROC_FS */
+#else
+extern void kclist_add(struct kcore_list *, void *, size_t);
+extern struct kcore_list *kclist_del(void *);
+#endif
 
 struct proc_inode {
 	struct task_struct *task;

_

