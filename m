Return-Path: <linux-kernel-owner+w=401wt.eu-S964920AbWLTGkb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964920AbWLTGkb (ORCPT <rfc822;w@1wt.eu>);
	Wed, 20 Dec 2006 01:40:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964922AbWLTGkb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Dec 2006 01:40:31 -0500
Received: from mail1.sea5.speakeasy.net ([69.17.117.3]:47449 "EHLO
	mail1.sea5.speakeasy.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964920AbWLTGka (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Dec 2006 01:40:30 -0500
X-Greylist: delayed 400 seconds by postgrey-1.27 at vger.kernel.org; Wed, 20 Dec 2006 01:40:30 EST
Subject: [PATCH] fdtable: Provide free_fdtable() wrapper.
From: Vadim Lobanov <vlobanov@speakeasy.net>
To: akpm@osdl.org, hch@lst.de, linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Tue, 19 Dec 2006 22:33:45 -0800
Message-Id: <1166596425.20073.2.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.2.1 (2.8.2.1-2.fc6) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Christoph Hellwig has expressed concerns that the recent fdtable changes
expose the details of the RCU methodology used to release no-longer-used
fdtable structures to the rest of the kernel. The trivial patch below
addresses these concerns by introducing the appropriate free_fdtable() calls,
which simply wrap the release RCU usage. Since free_fdtable() is a one-liner,
it makes sense to promote it to an inline helper.

Please apply.

Signed-off-by: Vadim Lobanov <vlobanov@speakeasy.net>

diff -pru old/fs/file.c new/fs/file.c
--- old/fs/file.c	2006-12-19 19:54:23.000000000 -0800
+++ new/fs/file.c	2006-12-19 20:04:02.000000000 -0800
@@ -206,7 +206,7 @@ static int expand_fdtable(struct files_s
 		copy_fdtable(new_fdt, cur_fdt);
 		rcu_assign_pointer(files->fdt, new_fdt);
 		if (cur_fdt->max_fds > NR_OPEN_DEFAULT)
-			call_rcu(&cur_fdt->rcu, free_fdtable_rcu);
+			free_fdtable(cur_fdt);
 	} else {
 		/* Somebody else expanded, so undo our attempt */
 		free_fdarr(new_fdt);
diff -pru old/include/linux/file.h new/include/linux/file.h
--- old/include/linux/file.h	2006-12-19 19:54:25.000000000 -0800
+++ new/include/linux/file.h	2006-12-19 20:03:19.000000000 -0800
@@ -80,6 +80,11 @@ extern int expand_files(struct files_str
 extern void free_fdtable_rcu(struct rcu_head *rcu);
 extern void __init files_defer_init(void);
 
+static inline void free_fdtable(struct fdtable *fdt)
+{
+	call_rcu(&fdt->rcu, free_fdtable_rcu);
+}
+
 static inline struct file * fcheck_files(struct files_struct *files, unsigned int fd)
 {
 	struct file * file = NULL;
diff -pru old/kernel/exit.c new/kernel/exit.c
--- old/kernel/exit.c	2006-12-19 19:54:52.000000000 -0800
+++ new/kernel/exit.c	2006-12-19 20:04:20.000000000 -0800
@@ -466,7 +466,7 @@ void fastcall put_files_struct(struct fi
 		fdt = files_fdtable(files);
 		if (fdt != &files->fdtab)
 			kmem_cache_free(files_cachep, files);
-		call_rcu(&fdt->rcu, free_fdtable_rcu);
+		free_fdtable(fdt);
 	}
 }
 


