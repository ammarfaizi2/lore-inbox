Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751998AbWHNL1d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751998AbWHNL1d (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Aug 2006 07:27:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752000AbWHNL1d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Aug 2006 07:27:33 -0400
Received: from mail.suse.de ([195.135.220.2]:53168 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751998AbWHNL1c (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Aug 2006 07:27:32 -0400
From: Andi Kleen <ak@suse.de>
References: <20060814 127.183332000@suse.de>
In-Reply-To: <20060814 127.183332000@suse.de>
To: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: [PATCH] [2/3] Create call_usermodehelper_pipe()
Message-Id: <20060814112731.5A16213BD9@wotan.suse.de>
Date: Mon, 14 Aug 2006 13:27:31 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


A new member in the ever growing family of call_usermode* functions is born.
The new call_usermodehelper_pipe() function allows to pipe data to the stdin of the called
user mode progam and behaves otherwise like the normal call_usermodehelp()
(except that it always waits for the child to finish)

To be used in a follow up patch.

Signed-off-by: Andi Kleen <ak@suse.de>

Index: linux/kernel/kmod.c
===================================================================
--- linux.orig/kernel/kmod.c
+++ linux/kernel/kmod.c
@@ -122,6 +122,7 @@ struct subprocess_info {
 	struct key *ring;
 	int wait;
 	int retval;
+	struct file *stdin;
 };
 
 /*
@@ -145,12 +146,26 @@ static int ____call_usermodehelper(void 
 
 	key_put(old_session);
 
+	/* Install input pipe when needed */
+	if (sub_info->stdin) {
+		struct files_struct *f = current->files;
+		struct fdtable *fdt;
+		/* no races because files should be private here */
+		sys_close(0);
+		fd_install(0, sub_info->stdin);
+		spin_lock(&f->file_lock);
+		fdt = files_fdtable(f);
+		FD_SET(0, fdt->open_fds);
+		FD_CLR(0, fdt->close_on_exec);
+		spin_unlock(&f->file_lock);
+	}
+
 	/* We can run anywhere, unlike our parent keventd(). */
 	set_cpus_allowed(current, CPU_MASK_ALL);
 
 	retval = -EPERM;
 	if (current->fs->root)
-		retval = execve(sub_info->path, sub_info->argv,sub_info->envp);
+		retval = execve(sub_info->path, sub_info->argv, sub_info->envp);
 
 	/* Exec failed? */
 	sub_info->retval = retval;
@@ -257,6 +272,44 @@ int call_usermodehelper_keys(char *path,
 }
 EXPORT_SYMBOL(call_usermodehelper_keys);
 
+int call_usermodehelper_pipe(char *path, char **argv, char **envp,
+			     struct file **filp)
+{
+	DECLARE_COMPLETION(done);
+	struct subprocess_info sub_info = {
+		.complete	= &done,
+		.path		= path,
+		.argv		= argv,
+		.envp		= envp,
+		.retval		= 0,
+	};
+	struct file *f;
+	DECLARE_WORK(work, __call_usermodehelper, &sub_info);
+
+	if (!khelper_wq)
+		return -EBUSY;
+
+	if (path[0] == '\0')
+		return 0;
+
+	f = create_write_pipe();
+	if (!f)
+		return -ENOMEM;
+	*filp = f;
+
+	f = create_read_pipe(f);
+	if (!f) {
+		free_write_pipe(*filp);
+		return -ENOMEM;
+	}
+	sub_info.stdin = f;
+
+	queue_work(khelper_wq, &work);
+	wait_for_completion(&done);
+	return sub_info.retval;
+}
+EXPORT_SYMBOL(call_usermodehelper_pipe);
+
 void __init usermodehelper_init(void)
 {
 	khelper_wq = create_singlethread_workqueue("khelper");
Index: linux/include/linux/kmod.h
===================================================================
--- linux.orig/include/linux/kmod.h
+++ linux/include/linux/kmod.h
@@ -47,4 +47,8 @@ call_usermodehelper(char *path, char **a
 
 extern void usermodehelper_init(void);
 
+struct file;
+extern int call_usermodehelper_pipe(char *path, char *argv[], char *envp[],
+				    struct file **filp);
+
 #endif /* __LINUX_KMOD_H__ */
