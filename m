Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932504AbWFUVgE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932504AbWFUVgE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 17:36:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932714AbWFUVgE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 17:36:04 -0400
Received: from mail2.sea5.speakeasy.net ([69.17.117.4]:15331 "EHLO
	mail2.sea5.speakeasy.net") by vger.kernel.org with ESMTP
	id S932504AbWFUVgC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 17:36:02 -0400
Date: Wed, 21 Jun 2006 17:36:00 -0400 (EDT)
From: James Morris <jmorris@namei.org>
X-X-Sender: jmorris@d.namei
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org, Stephen Smalley <sds@tycho.nsa.gov>,
       Eric Paris <eparis@redhat.com>, David Quigley <dpquigl@tycho.nsa.gov>,
       Chris Wright <chrisw@sous-sol.org>,
       Christoph Lameter <clameter@sgi.com>
Subject: [PATCH 2/3] SELinux: add security_task_movememory calls to mm code
In-Reply-To: <Pine.LNX.4.64.0606211730540.12872@d.namei>
Message-ID: <Pine.LNX.4.64.0606211734480.12872@d.namei>
References: <Pine.LNX.4.64.0606211517170.11782@d.namei>
 <Pine.LNX.4.64.0606211730540.12872@d.namei>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Quigley <dpquigl@tycho.nsa.gov>

This patch inserts security_task_movememory hook calls into memory
management code to enable security modules to mediate this operation
between tasks.

Since the last posting, the hook has been renamed following feedback from
Christoph Lameter.

This patch is aimed at 2.6.18 inclusion.

Please apply.

Signed-Off-By: David Quigley <dpquigl@tycho.nsa.gov>
Acked-by:  Stephen Smalley <sds@tycho.nsa.gov>
Signed-off-by: James Morris <jmorris@namei.org>


---

 mm/mempolicy.c |    5 +++++
 mm/migrate.c   |    6 ++++++
 2 files changed, 11 insertions(+)

diff -purN -X dontdiff linux-2.6.17-mm1.p/mm/mempolicy.c linux-2.6.17-mm1.w/mm/mempolicy.c
--- linux-2.6.17-mm1.p/mm/mempolicy.c	2006-06-21 11:54:12.000000000 -0400
+++ linux-2.6.17-mm1.w/mm/mempolicy.c	2006-06-21 17:18:00.000000000 -0400
@@ -88,6 +88,7 @@
 #include <linux/proc_fs.h>
 #include <linux/migrate.h>
 #include <linux/rmap.h>
+#include <linux/security.h>
 
 #include <asm/tlbflush.h>
 #include <asm/uaccess.h>
@@ -946,6 +947,10 @@ asmlinkage long sys_migrate_pages(pid_t 
 		goto out;
 	}
 
+	err = security_task_movememory(task);
+	if (err)
+		goto out;
+
 	err = do_migrate_pages(mm, &old, &new,
 		capable(CAP_SYS_NICE) ? MPOL_MF_MOVE_ALL : MPOL_MF_MOVE);
 out:
diff -purN -X dontdiff linux-2.6.17-mm1.p/mm/migrate.c linux-2.6.17-mm1.w/mm/migrate.c
--- linux-2.6.17-mm1.p/mm/migrate.c	2006-06-21 11:54:12.000000000 -0400
+++ linux-2.6.17-mm1.w/mm/migrate.c	2006-06-21 17:17:52.000000000 -0400
@@ -27,6 +27,7 @@
 #include <linux/writeback.h>
 #include <linux/mempolicy.h>
 #include <linux/vmalloc.h>
+#include <linux/security.h>
 
 #include "internal.h"
 
@@ -903,6 +904,11 @@ asmlinkage long sys_move_pages(pid_t pid
 		goto out2;
 	}
 
+ 	err = security_task_movememory(task);
+ 	if (err)
+ 		goto out2;
+ 	
+
 	task_nodes = cpuset_mems_allowed(task);
 
 	/* Limit nr_pages so that the multiplication may not overflow */
