Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261188AbVEKPRW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261188AbVEKPRW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 May 2005 11:17:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261195AbVEKPRW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 May 2005 11:17:22 -0400
Received: from mailhub.sw.ru ([195.214.233.200]:59008 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S261188AbVEKPQp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 May 2005 11:16:45 -0400
Message-ID: <428221D1.1010800@sw.ru>
Date: Wed, 11 May 2005 19:16:33 +0400
From: Kirill Korotaev <dev@sw.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; ru-RU; rv:1.2.1) Gecko/20030426
X-Accept-Language: ru-ru, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: [PATCH] Fix of bogus file max limit messages
Content-Type: multipart/mixed;
 boundary="------------000206010609070702000902"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000206010609070702000902
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

This patch fixes incorrect and bogus kernel messages
that file-max limit reached when the allocation fails

Signed-Off-By: Kirill Korotaev <dev@sw.ru>
Signed-Off-By: Denis Lunev <den@sw.ru>

Kirill

--------------000206010609070702000902
Content-Type: text/plain;
 name="diff-mainstream-filemax-20050216"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="diff-mainstream-filemax-20050216"

--- ./fs/file_table.c.filemax	2005-03-02 10:37:47.000000000 +0300
+++ ./fs/file_table.c	2005-05-10 17:37:43.000000000 +0400
@@ -63,42 +63,45 @@ static inline void file_free(struct file
  */
 struct file *get_empty_filp(void)
 {
-static int old_max;
+	static int old_max;
 	struct file * f;
 
 	/*
 	 * Privileged users can go above max_files
 	 */
-	if (files_stat.nr_files < files_stat.max_files ||
-				capable(CAP_SYS_ADMIN)) {
-		f = kmem_cache_alloc(filp_cachep, GFP_KERNEL);
-		if (f) {
-			memset(f, 0, sizeof(*f));
-			if (security_file_alloc(f)) {
-				file_free(f);
-				goto fail;
-			}
-			eventpoll_init_file(f);
-			atomic_set(&f->f_count, 1);
-			f->f_uid = current->fsuid;
-			f->f_gid = current->fsgid;
-			rwlock_init(&f->f_owner.lock);
-			/* f->f_version: 0 */
-			INIT_LIST_HEAD(&f->f_list);
-			f->f_maxcount = INT_MAX;
-			return f;
-		}
-	}
+	if (files_stat.nr_files >= files_stat.max_files &&
+				!capable(CAP_SYS_ADMIN))
+		goto over;
+
+	f = kmem_cache_alloc(filp_cachep, GFP_KERNEL);
+	if (f == NULL)
+		goto fail;
+
+	memset(f, 0, sizeof(*f));
+	if (security_file_alloc(f))
+		goto fail_sec;
+
+	eventpoll_init_file(f);
+	atomic_set(&f->f_count, 1);
+	f->f_uid = current->fsuid;
+	f->f_gid = current->fsgid;
+	rwlock_init(&f->f_owner.lock);
+	/* f->f_version: 0 */
+	INIT_LIST_HEAD(&f->f_list);
+	f->f_maxcount = INT_MAX;
+	return f;
 
+over:
 	/* Ran out of filps - report that */
-	if (files_stat.max_files >= old_max) {
+	if (files_stat.nr_files > old_max) {
 		printk(KERN_INFO "VFS: file-max limit %d reached\n",
 					files_stat.max_files);
-		old_max = files_stat.max_files;
-	} else {
-		/* Big problems... */
-		printk(KERN_WARNING "VFS: filp allocation failed\n");
+		old_max = files_stat.nr_files;
 	}
+	goto fail;
+
+fail_sec:
+	file_free(f);
 fail:
 	return NULL;
 }

--------------000206010609070702000902--

