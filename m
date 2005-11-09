Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030459AbVKIWqj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030459AbVKIWqj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 17:46:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030463AbVKIWqi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 17:46:38 -0500
Received: from tetsuo.zabbo.net ([207.173.201.20]:21636 "EHLO tetsuo.zabbo.net")
	by vger.kernel.org with ESMTP id S1030459AbVKIWqi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 17:46:38 -0500
From: Zach Brown <zach.brown@oracle.com>
To: linux-aio@kvack.org, linux-kernel@vger.kernel.org
Cc: Benjamin LaHaise <bcrl@kvack.org>, Andrew Morton <akpm@osdl.org>
Message-Id: <20051109224910.6624.98414.sendpatchset@volauvent.pdx.zabbo.net>
Subject: [PATCH] aio: don't ref kioctx after decref in put_ioctx
Date: Wed,  9 Nov 2005 14:46:18 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

aio: don't ref kioctx after decref in put_ioctx

put_ioctx's refcount debugging was doing an atomic_read after dropping its
reference when it wasn't the last ref, leaving a tiny race for another freeing
thread to sneak into.  This shifts the debugging before the ops, uses BUG_ON,
and reformats the defines a little.  Sadly, moving to inlines increased the
code size but this change decreases the code size by a whole 9 bytes :)

  Signed-off-by: Zach Brown <zach.brown@oracle.com>
---

 aio.h |   11 +++++++++--
 1 files changed, 9 insertions(+), 2 deletions(-)

Index: 2.6.14-mm1-aio-cleanups/include/linux/aio.h
===================================================================
--- 2.6.14-mm1-aio-cleanups.orig/include/linux/aio.h	2005-11-09 14:25:00.848063628 -0800
+++ 2.6.14-mm1-aio-cleanups/include/linux/aio.h	2005-11-09 14:29:44.469674748 -0800
@@ -210,8 +210,15 @@
 int FASTCALL(io_submit_one(struct kioctx *ctx, struct iocb __user *user_iocb,
 				  struct iocb *iocb));
 
-#define get_ioctx(kioctx)	do { if (unlikely(atomic_read(&(kioctx)->users) <= 0)) BUG(); atomic_inc(&(kioctx)->users); } while (0)
-#define put_ioctx(kioctx)	do { if (unlikely(atomic_dec_and_test(&(kioctx)->users))) __put_ioctx(kioctx); else if (unlikely(atomic_read(&(kioctx)->users) < 0)) BUG(); } while (0)
+#define get_ioctx(kioctx) do {						\
+	BUG_ON(unlikely(atomic_read(&(kioctx)->users) <= 0));		\
+	atomic_inc(&(kioctx)->users);					\
+} while (0)			
+#define put_ioctx(kioctx) do {						\
+	BUG_ON(unlikely(atomic_read(&(kioctx)->users) <= 0));		\
+	if (unlikely(atomic_dec_and_test(&(kioctx)->users))) 		\
+		__put_ioctx(kioctx);					\
+} while (0)
 
 #define in_aio() !is_sync_wait(current->io_wait)
 /* may be used for debugging */
