Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030512AbWJJVqo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030512AbWJJVqo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 17:46:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030506AbWJJVqL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 17:46:11 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:22715 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1030509AbWJJVqI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 17:46:08 -0400
To: torvalds@osdl.org
Subject: [PATCH] __user annotations: futex
Cc: linux-kernel@vger.kernel.org
Message-Id: <E1GXPQN-0007Lu-88@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Tue, 10 Oct 2006 22:46:07 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 include/linux/compat.h   |    2 +-
 include/linux/syscalls.h |    2 +-
 kernel/futex.c           |   15 ++++++++-------
 kernel/futex_compat.c    |   12 ++++++------
 4 files changed, 16 insertions(+), 15 deletions(-)

diff --git a/include/linux/compat.h b/include/linux/compat.h
index ef5cd19..f4ebf96 100644
--- a/include/linux/compat.h
+++ b/include/linux/compat.h
@@ -163,7 +163,7 @@ asmlinkage long
 compat_sys_set_robust_list(struct compat_robust_list_head __user *head,
 			   compat_size_t len);
 asmlinkage long
-compat_sys_get_robust_list(int pid, compat_uptr_t *head_ptr,
+compat_sys_get_robust_list(int pid, compat_uptr_t __user *head_ptr,
 			   compat_size_t __user *len_ptr);
 
 long compat_sys_semctl(int first, int second, int third, void __user *uptr);
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index 3efcfc7..b0ace3f 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -593,7 +593,7 @@ asmlinkage long sys_tee(int fdin, int fd
 asmlinkage long sys_sync_file_range(int fd, loff_t offset, loff_t nbytes,
 					unsigned int flags);
 asmlinkage long sys_get_robust_list(int pid,
-				    struct robust_list_head __user **head_ptr,
+				    struct robust_list_head __user * __user *head_ptr,
 				    size_t __user *len_ptr);
 asmlinkage long sys_set_robust_list(struct robust_list_head __user *head,
 				    size_t len);
diff --git a/kernel/futex.c b/kernel/futex.c
index 4aaf919..b364e00 100644
--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -1612,10 +1612,10 @@ sys_set_robust_list(struct robust_list_h
  * @len_ptr: pointer to a length field, the kernel fills in the header size
  */
 asmlinkage long
-sys_get_robust_list(int pid, struct robust_list_head __user **head_ptr,
+sys_get_robust_list(int pid, struct robust_list_head __user * __user *head_ptr,
 		    size_t __user *len_ptr)
 {
-	struct robust_list_head *head;
+	struct robust_list_head __user *head;
 	unsigned long ret;
 
 	if (!pid)
@@ -1694,14 +1694,15 @@ retry:
  * Fetch a robust-list pointer. Bit 0 signals PI futexes:
  */
 static inline int fetch_robust_entry(struct robust_list __user **entry,
-				     struct robust_list __user **head, int *pi)
+				     struct robust_list __user * __user *head,
+				     int *pi)
 {
 	unsigned long uentry;
 
-	if (get_user(uentry, (unsigned long *)head))
+	if (get_user(uentry, (unsigned long __user *)head))
 		return -EFAULT;
 
-	*entry = (void *)(uentry & ~1UL);
+	*entry = (void __user *)(uentry & ~1UL);
 	*pi = uentry & 1;
 
 	return 0;
@@ -1739,7 +1740,7 @@ void exit_robust_list(struct task_struct
 		return;
 
 	if (pending)
-		handle_futex_death((void *)pending + futex_offset, curr, pip);
+		handle_futex_death((void __user *)pending + futex_offset, curr, pip);
 
 	while (entry != &head->list) {
 		/*
@@ -1747,7 +1748,7 @@ void exit_robust_list(struct task_struct
 		 * don't process it twice:
 		 */
 		if (entry != pending)
-			if (handle_futex_death((void *)entry + futex_offset,
+			if (handle_futex_death((void __user *)entry + futex_offset,
 						curr, pi))
 				return;
 		/*
diff --git a/kernel/futex_compat.c b/kernel/futex_compat.c
index c5cca3f..50f24ee 100644
--- a/kernel/futex_compat.c
+++ b/kernel/futex_compat.c
@@ -18,7 +18,7 @@ #include <asm/uaccess.h>
  */
 static inline int
 fetch_robust_entry(compat_uptr_t *uentry, struct robust_list __user **entry,
-		   compat_uptr_t *head, int *pi)
+		   compat_uptr_t __user *head, int *pi)
 {
 	if (get_user(*uentry, head))
 		return -EFAULT;
@@ -62,7 +62,7 @@ void compat_exit_robust_list(struct task
 			       &head->list_op_pending, &pip))
 		return;
 	if (upending)
-		handle_futex_death((void *)pending + futex_offset, curr, pip);
+		handle_futex_death((void __user *)pending + futex_offset, curr, pip);
 
 	while (compat_ptr(uentry) != &head->list) {
 		/*
@@ -70,7 +70,7 @@ void compat_exit_robust_list(struct task
 		 * dont process it twice:
 		 */
 		if (entry != pending)
-			if (handle_futex_death((void *)entry + futex_offset,
+			if (handle_futex_death((void __user *)entry + futex_offset,
 						curr, pi))
 				return;
 
@@ -78,7 +78,7 @@ void compat_exit_robust_list(struct task
 		 * Fetch the next entry in the list:
 		 */
 		if (fetch_robust_entry(&uentry, &entry,
-				       (compat_uptr_t *)&entry->next, &pi))
+				       (compat_uptr_t __user *)&entry->next, &pi))
 			return;
 		/*
 		 * Avoid excessively long or circular lists:
@@ -103,10 +103,10 @@ compat_sys_set_robust_list(struct compat
 }
 
 asmlinkage long
-compat_sys_get_robust_list(int pid, compat_uptr_t *head_ptr,
+compat_sys_get_robust_list(int pid, compat_uptr_t __user *head_ptr,
 			   compat_size_t __user *len_ptr)
 {
-	struct compat_robust_list_head *head;
+	struct compat_robust_list_head __user *head;
 	unsigned long ret;
 
 	if (!pid)
-- 
1.4.2.GIT


