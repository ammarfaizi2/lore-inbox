Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932662AbWFVVby@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932662AbWFVVby (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 17:31:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932651AbWFVVbs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 17:31:48 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:6841 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932656AbWFVVbY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 17:31:24 -0400
Date: Thu, 22 Jun 2006 14:31:12 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: linux-kernel@vger.kernel.org
Cc: "Paul E. McKenney" <paulmck@us.ibm.com>, Jens Axboe <axboe@suse.de>,
       Dave Miller <davem@redhat.com>, Hugh Dickins <hugh@veritas.com>,
       linux-mm@kvack.org, Christoph Lameter <clameter@sgi.com>,
       Ingo Molnar <mingo@elte.hu>
Message-Id: <20060622213112.32391.816.sendpatchset@schroedinger.engr.sgi.com>
In-Reply-To: <20060622213102.32391.19996.sendpatchset@schroedinger.engr.sgi.com>
References: <20060622213102.32391.19996.sendpatchset@schroedinger.engr.sgi.com>
Subject: [PATCH 2/4] Remove duplication of fget()
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

files rcu optimization: Remove duplicated fget from fget_light.

The code for fget is contained in fget_light. So call fget
instead.

Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linux-2.6.17/fs/file_table.c
===================================================================
--- linux-2.6.17.orig/fs/file_table.c	2006-06-22 14:03:54.484771991 -0700
+++ linux-2.6.17/fs/file_table.c	2006-06-22 14:03:57.773630982 -0700
@@ -226,16 +226,9 @@ struct file fastcall *fget_light(unsigne
 	if (likely((atomic_read(&files->count) == 1))) {
 		file = fcheck_files(files, fd);
 	} else {
-		rcu_read_lock();
-		file = fcheck_files(files, fd);
-		if (file) {
-			if (atomic_inc_not_zero(&file->f_count))
-				*fput_needed = 1;
-			else
-				/* Didn't get the reference, someone's freed */
-				file = NULL;
-		}
-		rcu_read_unlock();
+		file = fget(fd);
+		if (file)
+			*fput_needed = 1;
 	}
 
 	return file;
