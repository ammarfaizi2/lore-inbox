Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261930AbUDJUMf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Apr 2004 16:12:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262109AbUDJUMf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Apr 2004 16:12:35 -0400
Received: from fw.osdl.org ([65.172.181.6]:28807 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261930AbUDJUMY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Apr 2004 16:12:24 -0400
Date: Sat, 10 Apr 2004 13:11:37 -0700
From: Andrew Morton <akpm@osdl.org>
To: Greg KH <greg@kroah.com>
Cc: brking@us.ibm.com, linux-kernel@vger.kernel.org,
       linux-hotplug-devel@lists.sourceforge.net
Subject: Re: [PATCH] call_usermodehelper hang
Message-Id: <20040410131137.0eff0ae2.akpm@osdl.org>
In-Reply-To: <20040410165322.GG1317@kroah.com>
References: <4072F2B7.2070605@us.ibm.com>
	<20040406172903.186dd5f1.akpm@osdl.org>
	<20040407061146.GA10413@kroah.com>
	<407487A6.8020904@us.ibm.com>
	<20040408224713.GD15125@kroah.com>
	<40770AD0.4000402@us.ibm.com>
	<20040409205344.GA5236@kroah.com>
	<20040409141511.4e372554.akpm@osdl.org>
	<20040410165322.GG1317@kroah.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH <greg@kroah.com> wrote:
>
> > The deadlock opportunity occurs during the call_usermodehelper() handoff to
>  > keventd, which is synchronous.
>  > 
>  > 2-3 years back I did have a call_usermodehelper() which was fully async. 
>  > It was pretty unpleasant because of the need to atomically allocate
>  > arbitrary amounts of memory to hold the argv[] and endp[] arrays, to pass
>  > them between a couple of threads and to then correctly free it all up
>  > again.
> 
>  Ok, you've convinced me of the mess that would cause.  So what should we
>  do to help fix this?  Serialize call_usermodehelper()?

May as well bring back call_usermodehelper_async() I guess.


There are two patches here, and they are totally untested...




Add some generally-useful string replication functions which are required by
call_usermodehelper_async():

void *kzmalloc(size_t size, int gfp_flags);

	kmalloc() then bzero().

char *kstrdup(char *p, int gfp_flags);

	kmalloc() then strcpy()

char **kstrdup_vec(char **vec, int gfp_flags);

	duplicate an argv[]-style string array

void kfree_strvec(char **vec);

	free up the result of a previous kstrdup_vec()


---

 25-akpm/drivers/md/dm-ioctl.c |   17 ++----------
 25-akpm/include/linux/slab.h  |    5 +++
 25-akpm/mm/slab.c             |   57 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 65 insertions(+), 14 deletions(-)

diff -puN drivers/md/dm-ioctl.c~kstrdup-and-friends drivers/md/dm-ioctl.c
--- 25/drivers/md/dm-ioctl.c~kstrdup-and-friends	2004-04-10 12:50:59.324302648 -0700
+++ 25-akpm/drivers/md/dm-ioctl.c	2004-04-10 12:50:59.341300064 -0700
@@ -118,17 +118,6 @@ static struct hash_cell *__get_uuid_cell
 	return NULL;
 }
 
-/*-----------------------------------------------------------------
- * Inserting, removing and renaming a device.
- *---------------------------------------------------------------*/
-static inline char *kstrdup(const char *str)
-{
-	char *r = kmalloc(strlen(str) + 1, GFP_KERNEL);
-	if (r)
-		strcpy(r, str);
-	return r;
-}
-
 static struct hash_cell *alloc_cell(const char *name, const char *uuid,
 				    struct mapped_device *md)
 {
@@ -138,7 +127,7 @@ static struct hash_cell *alloc_cell(cons
 	if (!hc)
 		return NULL;
 
-	hc->name = kstrdup(name);
+	hc->name = kstrdup(name, GFP_KERNEL);
 	if (!hc->name) {
 		kfree(hc);
 		return NULL;
@@ -148,7 +137,7 @@ static struct hash_cell *alloc_cell(cons
 		hc->uuid = NULL;
 
 	else {
-		hc->uuid = kstrdup(uuid);
+		hc->uuid = kstrdup(uuid, GFP_KERNEL);
 		if (!hc->uuid) {
 			kfree(hc->name);
 			kfree(hc);
@@ -270,7 +259,7 @@ int dm_hash_rename(const char *old, cons
 	/*
 	 * duplicate new.
 	 */
-	new_name = kstrdup(new);
+	new_name = kstrdup(new, GFP_KERNEL);
 	if (!new_name)
 		return -ENOMEM;
 
diff -puN include/linux/slab.h~kstrdup-and-friends include/linux/slab.h
--- 25/include/linux/slab.h~kstrdup-and-friends	2004-04-10 12:50:59.326302344 -0700
+++ 25-akpm/include/linux/slab.h	2004-04-10 13:07:58.979291528 -0700
@@ -117,6 +117,11 @@ void ptrinfo(unsigned long addr);
 
 extern atomic_t slab_reclaim_pages;
 
+void *kzmalloc(size_t size, int gfp_flags);
+char *kstrdup(const char *p, int gfp_flags);
+char **kstrdup_vec(char **vec, int gfp_flags);
+void kfree_strvec(char **vec);
+
 #endif	/* __KERNEL__ */
 
 #endif	/* _LINUX_SLAB_H */
diff -puN mm/slab.c~kstrdup-and-friends mm/slab.c
--- 25/mm/slab.c~kstrdup-and-friends	2004-04-10 12:50:59.328302040 -0700
+++ 25-akpm/mm/slab.c	2004-04-10 13:08:05.602284680 -0700
@@ -3009,3 +3009,60 @@ void ptrinfo(unsigned long addr)
 
 	}
 }
+
+void *kzmalloc(size_t size, int gfp_flags)
+{
+	void *ret = kmalloc(size, gfp_flags);
+	if (ret)
+		memset(ret, 0, size);
+	return ret;
+}
+EXPORT_SYMBOL(kzmalloc);
+
+char *kstrdup(const char *p, int gfp_flags)
+{
+	char *ret = kmalloc(strlen(p) + 1, gfp_flags);
+	if (ret)
+		strcpy(ret, p);
+	return ret;
+}
+EXPORT_SYMBOL(kstrdup);
+
+char **kstrdup_vec(char **vec, int gfp_flags)
+{
+	char **ret;
+	int nr_strings;
+	int i;
+
+	for (nr_strings = 0; vec[nr_strings]; nr_strings++)
+		;
+	ret = kzmalloc((nr_strings + 1) * sizeof(*ret), gfp_flags);
+	if (ret == NULL)
+		goto enomem;
+	for (i = 0; i < nr_strings; i++) {
+		ret[i] = kstrdup(vec[i], gfp_flags);
+		if (ret[i] == NULL)
+			goto enomem;
+	}
+	ret[i] = NULL;
+	return ret;
+enomem:
+	kfree_strvec(ret);
+	return NULL;
+}
+EXPORT_SYMBOL(kstrdup_vec);
+
+void kfree_strvec(char **vec)
+{
+	char **p;
+
+	if (vec == NULL)
+		return;
+	p = vec;
+	while (*p) {
+		kfree(*p);
+		p++;
+	}
+	kfree(vec);
+}
+EXPORT_SYMBOL(kfree_strvec);

_



call_usermodehelper() has to synchronously wait until it has handed its local
variables off to keventd.  This can lead to deadlocks when the caller holds
semphores which keventd may also want.

To fix this we introduce call_usermodehelper_async(), which does not block on
a keventd response.


---

 25-akpm/include/linux/kmod.h |    5 ++-
 25-akpm/kernel/kmod.c        |   69 +++++++++++++++++++++++++++++++++++++------
 2 files changed, 64 insertions(+), 10 deletions(-)

diff -puN include/linux/kmod.h~call_usermodehelper_async include/linux/kmod.h
--- 25/include/linux/kmod.h~call_usermodehelper_async	2004-04-10 13:08:12.554227824 -0700
+++ 25-akpm/include/linux/kmod.h	2004-04-10 13:08:12.558227216 -0700
@@ -32,7 +32,10 @@ static inline int request_module(const c
 #endif
 
 #define try_then_request_module(x, mod...) ((x) ?: (request_module(mod), (x)))
-extern int call_usermodehelper(char *path, char *argv[], char *envp[], int wait);
+
+int call_usermodehelper(char *path, char **argv, char **envp, int wait);
+int call_usermodehelper_async(char *path, char **argv,
+				char **envp, int gfp_flags);
 
 #ifdef CONFIG_HOTPLUG
 extern char hotplug_path [];
diff -puN kernel/kmod.c~call_usermodehelper_async kernel/kmod.c
--- 25/kernel/kmod.c~call_usermodehelper_async	2004-04-10 13:08:12.555227672 -0700
+++ 25-akpm/kernel/kmod.c	2004-04-10 13:08:12.559227064 -0700
@@ -109,6 +109,7 @@ int request_module(const char *fmt, ...)
 	atomic_dec(&kmod_concurrent);
 	return ret;
 }
+EXPORT_SYMBOL(request_module);
 #endif /* CONFIG_KMOD */
 
 #ifdef CONFIG_HOTPLUG
@@ -140,7 +141,9 @@ struct subprocess_info {
 	char **argv;
 	char **envp;
 	int wait;
+	int async;
 	int retval;
+	struct work_struct async_work;
 };
 
 /*
@@ -197,6 +200,16 @@ static int wait_for_helper(void *data)
 	return 0;
 }
 
+static void destroy_subinfo(struct subprocess_info *sub_info)
+{
+	if (!sub_info)
+		return;
+	kfree_strvec(sub_info->argv);
+	kfree_strvec(sub_info->envp);
+	kfree(sub_info->path);
+	kfree(sub_info);
+}
+
 /*
  * This is run by keventd.
  */
@@ -215,11 +228,15 @@ static void __call_usermodehelper(void *
 		pid = kernel_thread(____call_usermodehelper, sub_info,
 				    CLONE_VFORK | SIGCHLD);
 
-	if (pid < 0) {
-		sub_info->retval = pid;
-		complete(sub_info->complete);
-	} else if (!sub_info->wait)
-		complete(sub_info->complete);
+	if (sub_info->async) {
+		destroy_subinfo(sub_info);
+	} else {
+		if (pid < 0) {
+			sub_info->retval = pid;
+			complete(sub_info->complete);
+		} else if (!sub_info->wait)
+			complete(sub_info->complete);
+	}
 }
 
 /**
@@ -265,10 +282,44 @@ int call_usermodehelper(char *path, char
 out:
 	return sub_info.retval;
 }
-
 EXPORT_SYMBOL(call_usermodehelper);
 
-#ifdef CONFIG_KMOD
-EXPORT_SYMBOL(request_module);
-#endif
+/**
+ * call_usermodehelper_async - start a usermode application
+ *
+ * Like call_usermodehelper(), except it is fully asynchronous.  Should only
+ * be used in extremis, such as when the caller unavoidably holds locks which
+ * keventd might block on.
+ */
+int call_usermodehelper_async(char *path, char **argv,
+				char **envp, int gfp_flags)
+{
+	struct subprocess_info *sub_info;
+
+	if (system_state != SYSTEM_RUNNING)
+		return -EBUSY;
+	if (path[0] == '\0')
+		goto out;
 
+	sub_info = kzmalloc(sizeof(*sub_info), gfp_flags);
+	if (!sub_info)
+		goto enomem;
+	sub_info->async = 1;
+	sub_info->path = kstrdup(path, gfp_flags);
+	if (!sub_info->path)
+		goto enomem;
+	sub_info->argv = kstrdup_vec(argv, gfp_flags);
+	if (!sub_info->argv)
+		goto enomem;
+	sub_info->envp = kstrdup_vec(envp, gfp_flags);
+	if (!sub_info->envp)
+		goto enomem;
+	INIT_WORK(&sub_info->async_work, __call_usermodehelper, sub_info);
+	schedule_work(&sub_info->async_work);
+out:
+	return 0;
+enomem:
+	destroy_subinfo(sub_info);
+	return -ENOMEM;
+}
+EXPORT_SYMBOL(call_usermodehelper_async);

_

