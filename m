Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262498AbTEIMVt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 May 2003 08:21:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262499AbTEIMVt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 May 2003 08:21:49 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:44767 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id S262498AbTEIMVs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 May 2003 08:21:48 -0400
Subject: [PATCH] Fix for vma merging refcounting bug
From: "Stephen C. Tweedie" <sct@redhat.com>
To: linux-kernel <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>
Cc: Stephen Tweedie <sct@redhat.com>, Andrew Morton <akpm@digeo.com>,
       Andrea Arcangeli <andrea@suse.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1052483661.3642.16.camel@sisko.scot.redhat.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 09 May 2003 13:34:21 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When a new vma can be merged simultaneously with its two immediate
neighbours in both directions, vma_merge() extends the predecessor vma
and deletes the successor.  However, if the vma maps a file, it fails to
fput() when doing the delete, leaving the file's refcount inconsistent.

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1083  -> 1.1084 
#	           mm/mmap.c	1.79    -> 1.80   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/05/09	sct@sisko.scot.redhat.com	1.1084
# Fix vma merging problem leading to file refcount getting out of sync.
# --------------------------------------------
#
diff -Nru a/mm/mmap.c b/mm/mmap.c
--- a/mm/mmap.c	Fri May  9 13:26:53 2003
+++ b/mm/mmap.c	Fri May  9 13:26:53 2003
@@ -471,6 +471,8 @@
 			spin_unlock(lock);
 			if (need_up)
 				up(&inode->i_mapping->i_shared_sem);
+			if (file)
+				fput(file);
 
 			mm->map_count--;
 			kmem_cache_free(vm_area_cachep, next);


