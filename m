Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751227AbWDQTXl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751227AbWDQTXl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Apr 2006 15:23:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751230AbWDQTXl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Apr 2006 15:23:41 -0400
Received: from smtp-out.google.com ([216.239.33.17]:12197 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP
	id S1751227AbWDQTXk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Apr 2006 15:23:40 -0400
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:to:subject:cc:message-id:from:date;
	b=aUTrPBOq56WUTQdLG2o80LeLhUFHje10nnLwePPez3WlxKk5bz/QAD8ZNQGaEChp+
	DEzl5MYwT4l9t1cgHBLCQ==
To: akpm@osdl.org
Subject: [PATCH] dup fd error
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Message-Id: <E1FVZJQ-0004fB-6z@blr-eng3.blr.corp.google.com>
From: Prasanna Meda <mlp@google.com>
Date: Tue, 18 Apr 2006 00:53:04 +0530
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


set errorp in dup_fd, it will be used in sys_unshare also.

Signed-off-by: Prasanna Meda

--- a/kernel/fork.c	2006-04-17 22:38:09.000000000 +0530
+++ b/kernel/fork.c	2006-04-18 00:38:37.000000000 +0530
@@ -629,6 +629,7 @@ out:
 /*
  * Allocate a new files structure and copy contents from the
  * passed in files structure.
+ * errorp will be valid only when the returned files_struct is NULL.
  */
 static struct files_struct *dup_fd(struct files_struct *oldf, int *errorp)
 {
@@ -637,6 +638,7 @@ static struct files_struct *dup_fd(struc
 	int open_files, size, i, expand;
 	struct fdtable *old_fdt, *new_fdt;
 
+	*errorp = -ENOMEM;
 	newf = alloc_files();
 	if (!newf)
 		goto out;
@@ -750,7 +752,6 @@ static int copy_files(unsigned long clon
 	 * break this.
 	 */
 	tsk->files = NULL;
-	error = -ENOMEM;
 	newf = dup_fd(oldf, &error);
 	if (!newf)
 		goto out;
