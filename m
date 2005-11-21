Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932377AbVKURPw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932377AbVKURPw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 12:15:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932385AbVKURPv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 12:15:51 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:25100 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S932377AbVKURPv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 12:15:51 -0500
Date: Mon, 21 Nov 2005 17:15:46 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: akpm@osdl.org
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: [PATCH] Shut up warnings in ipc/shm.c
Message-ID: <20051121171545.GE21032@flint.arm.linux.org.uk>
Mail-Followup-To: akpm@osdl.org,
	Linux Kernel List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix two warnings in ipc/shm.c

ipc/shm.c:122: warning: statement with no effect
ipc/shm.c:560: warning: statement with no effect

by converting the macros to empty inline functions.  For safety, let's
do all three.  This also has the advantage that typechecking gets
performed even without CONFIG_SHMEM enabled.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

diff --git a/include/linux/mm.h b/include/linux/mm.h
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -651,9 +651,24 @@ struct mempolicy *shmem_get_policy(struc
 int shmem_lock(struct file *file, int lock, struct user_struct *user);
 #else
 #define shmem_nopage filemap_nopage
-#define shmem_lock(a, b, c) 	({0;})	/* always in memory, no need to lock */
-#define shmem_set_policy(a, b)	(0)
-#define shmem_get_policy(a, b)	(NULL)
+
+static inline int shmem_lock(struct file *file, int lock,
+			     struct user_struct *user)
+{
+	return 0;
+}
+
+static inline int shmem_set_policy(struct vm_area_struct *vma,
+				   struct mempolicy *new)
+{
+	return 0;
+}
+
+static inline struct mempolicy *shmem_get_policy(struct vm_area_struct *vma,
+						 unsigned long addr)
+{
+	return NULL;
+}
 #endif
 struct file *shmem_file_setup(char *name, loff_t size, unsigned long flags);
 

-- 
Russell King
