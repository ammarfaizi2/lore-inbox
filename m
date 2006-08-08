Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932168AbWHHLaF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932168AbWHHLaF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 07:30:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932226AbWHHLaF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 07:30:05 -0400
Received: from mailhub.sw.ru ([195.214.233.200]:39745 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S932168AbWHHLaD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 07:30:03 -0400
Message-ID: <44D87611.7070705@sw.ru>
Date: Tue, 08 Aug 2006 15:31:29 +0400
From: Kirill Korotaev <dev@sw.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.13) Gecko/20060417
X-Accept-Language: en-us, en, ru
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, xemul@sw.ru,
       hch@infradead.org, dada1@cosmosbay.com
Subject: [PATCH] unserialized task->files changing (v2)
Content-Type: multipart/mixed;
 boundary="------------090502000109070400070404"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090502000109070400070404
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Fixed race on put_files_struct on exec with proc.
Restoring files on current on error path may lead
to proc having a pointer to already kfree-d files_struct.

->files changing at exit.c and khtread.c are safe as
exit_files() makes all things under lock.

v2 patch changes:
- introduced reset_files_struct() as Christoph Hellwig suggested

Found during OpenVZ stress testing.

Signed-Off-By: Pavel Emelianov <xemul@openvz.org>
Signed-Off-By: Kirill Korotaev <dev@openvz.org>


--------------090502000109070400070404
Content-Type: text/plain;
 name="diff-ms-files-race-fix-200600808"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="diff-ms-files-race-fix-200600808"

--- ./fs/binfmt_elf.c.rfs	2006-08-08 15:01:44.000000000 +0400
+++ ./fs/binfmt_elf.c	2006-08-08 15:07:49.000000000 +0400
@@ -1037,10 +1037,8 @@ out_free_interp:
 out_free_file:
 	sys_close(elf_exec_fileno);
 out_free_fh:
-	if (files) {
-		put_files_struct(current->files);
-		current->files = files;
-	}
+	if (files)
+		reset_files_struct(current, files);
 out_free_ph:
 	kfree(elf_phdata);
 	goto out;
--- ./fs/binfmt_misc.c.rfs	2006-08-08 15:01:44.000000000 +0400
+++ ./fs/binfmt_misc.c	2006-08-08 15:09:46.000000000 +0400
@@ -215,10 +215,8 @@ _error:
 	bprm->interp_flags = 0;
 	bprm->interp_data = 0;
 _unshare:
-	if (files) {
-		put_files_struct(current->files);
-		current->files = files;
-	}
+	if (files)
+		reset_files_struct(current, files);
 	goto _ret;
 }
 
--- ./fs/exec.c.rfs	2006-08-08 15:01:44.000000000 +0400
+++ ./fs/exec.c	2006-08-08 15:10:09.000000000 +0400
@@ -903,8 +903,7 @@ int flush_old_exec(struct linux_binprm *
 	return 0;
 
 mmap_failed:
-	put_files_struct(current->files);
-	current->files = files;
+	reset_files_struct(current, files);
 out:
 	return retval;
 }
--- ./include/linux/file.h.rfs	2006-04-21 11:59:36.000000000 +0400
+++ ./include/linux/file.h	2006-08-08 15:08:19.000000000 +0400
@@ -112,5 +112,6 @@ struct task_struct;
 
 struct files_struct *get_files_struct(struct task_struct *);
 void FASTCALL(put_files_struct(struct files_struct *fs));
+void reset_files_struct(struct task_struct *, struct files_struct *);
 
 #endif /* __LINUX_FILE_H */
--- ./kernel/exit.c.rfs	2006-08-08 15:01:44.000000000 +0400
+++ ./kernel/exit.c	2006-08-08 15:13:40.000000000 +0400
@@ -487,6 +487,17 @@ void fastcall put_files_struct(struct fi
 
 EXPORT_SYMBOL(put_files_struct);
 
+void reset_files_struct(struct task_struct *tsk, struct files_struct *files)
+{
+	struct files_struct *old;
+
+	old = tsk->files;
+	task_lock(tsk);
+	tsk->files = files;
+	task_unlock(tsk);
+	put_files_struct(old);
+}
+
 static inline void __exit_files(struct task_struct *tsk)
 {
 	struct files_struct * files = tsk->files;

--------------090502000109070400070404--
