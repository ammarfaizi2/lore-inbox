Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964777AbWHHKGT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964777AbWHHKGT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 06:06:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964779AbWHHKGT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 06:06:19 -0400
Received: from mailhub.sw.ru ([195.214.233.200]:61503 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S964777AbWHHKGR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 06:06:17 -0400
Message-ID: <44D86275.2080406@sw.ru>
Date: Tue, 08 Aug 2006 14:07:49 +0400
From: Kirill Korotaev <dev@sw.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.13) Gecko/20060417
X-Accept-Language: en-us, en, ru
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] unserialized task->files changing
Content-Type: multipart/mixed;
 boundary="------------050606080208080401080705"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050606080208080401080705
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Fixed race on put_files_struct on exec with proc.
Restoring files on current on error path may lead
to proc having a pointer to already kfree-d files_struct.

Found during OpenVZ stress testing.

Signed-Off-By: Pavel Emelianov <xemul@openvz.org>
Signed-Off-By: Kirill Korotaev <dev@openvz.org>

--------------050606080208080401080705
Content-Type: text/plain;
 name="diff-ms-files-race-fix"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="diff-ms-files-race-fix"

--- ./fs/binfmt_elf.c.fsfix	2006-03-27 14:25:59.000000000 +0400
+++ ./fs/binfmt_elf.c	2006-03-28 13:26:16.000000000 +0400
@@ -1027,8 +1027,13 @@ out_free_file:
 	sys_close(elf_exec_fileno);
 out_free_fh:
 	if (files) {
-		put_files_struct(current->files);
+		struct files_struct *old;
+
+		old = current->files;
+		task_lock(current);
 		current->files = files;
+		task_unlock(current);
+		put_files_struct(old);
 	}
 out_free_ph:
 	kfree(elf_phdata);
--- ./fs/binfmt_misc.c.fsfix	2006-03-27 14:25:59.000000000 +0400
+++ ./fs/binfmt_misc.c	2006-03-28 13:27:06.000000000 +0400
@@ -216,8 +216,13 @@ _error:
 	bprm->interp_data = 0;
 _unshare:
 	if (files) {
-		put_files_struct(current->files);
+		struct files_struct *old;
+
+		old = current->files;
+		task_lock(current);
 		current->files = files;
+		task_unlock(current);
+		put_files_struct(old);
 	}
 	goto _ret;
 }
--- ./fs/exec.c.fsfix	2006-03-27 14:25:59.000000000 +0400
+++ ./fs/exec.c	2006-03-28 13:28:10.000000000 +0400
@@ -865,7 +865,7 @@ int flush_old_exec(struct linux_binprm *
 {
 	char * name;
 	int i, ch, retval;
-	struct files_struct *files;
+	struct files_struct *files, *old;
 	char tcomm[sizeof(current->comm)];
 
 	/*
@@ -946,8 +946,11 @@ int flush_old_exec(struct linux_binprm *
 	return 0;
 
 mmap_failed:
-	put_files_struct(current->files);
+	old = current->files;
+	task_lock(current);
 	current->files = files;
+	task_unlock(current);
+	put_files_struct(old);
 out:
 	return retval;
 }

--------------050606080208080401080705--
