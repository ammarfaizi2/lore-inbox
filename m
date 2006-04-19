Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751070AbWDSRzE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751070AbWDSRzE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Apr 2006 13:55:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751074AbWDSRzA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Apr 2006 13:55:00 -0400
Received: from mx1.suse.de ([195.135.220.2]:27345 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751060AbWDSRy6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Apr 2006 13:54:58 -0400
From: Tony Jones <tonyj@suse.de>
To: linux-kernel@vger.kernel.org
Cc: chrisw@sous-sol.org, Tony Jones <tonyj@suse.de>,
       linux-security-module@vger.kernel.org
Date: Wed, 19 Apr 2006 10:50:34 -0700
Message-Id: <20060419175034.29149.94306.sendpatchset@ermintrude.int.wirex.com>
In-Reply-To: <20060419174905.29149.67649.sendpatchset@ermintrude.int.wirex.com>
References: <20060419174905.29149.67649.sendpatchset@ermintrude.int.wirex.com>
Subject: [RFC][PATCH 11/11] security: AppArmor - Export namespace semaphore
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch exports the namespace_sem semaphore.

The shared subtree patches which went into 2.6.15-rc1 replaced the old
namespace semaphore which used to be per namespace (and visible) with a
new single static semaphore.

The reason for this change is that currently visibility of vfsmount information
to the LSM hooks is fairly patchy.  Either there is no passed parameter or
it can be NULL.  For the case of the former,  several LSM hooks that we
require to mediate have no vfsmount/nameidata passed.  We previously (mis)used
the visibility of the old per namespace semaphore to walk the processes 
namespace looking for vfsmounts with a root dentry matching the dentry we were 
trying to mediate.  

Clearly this is not viable long term strategy and changes working towards 
passing a vfsmount to all relevant LSM hooks would seem necessary (and also 
useful for other users of LSM). Alternative suggestions and ideas are welcomed.

Signed-off-by: Tony Jones <tonyj@suse.de>

---
 fs/namespace.c            |    3 ++-
 include/linux/namespace.h |    2 ++
 2 files changed, 4 insertions(+), 1 deletion(-)

--- linux-2.6.17-rc1.orig/fs/namespace.c
+++ linux-2.6.17-rc1/fs/namespace.c
@@ -46,7 +46,8 @@
 static struct list_head *mount_hashtable __read_mostly;
 static int hash_mask __read_mostly, hash_bits __read_mostly;
 static kmem_cache_t *mnt_cache __read_mostly;
-static struct rw_semaphore namespace_sem;
+struct rw_semaphore namespace_sem;
+EXPORT_SYMBOL_GPL(namespace_sem);
 
 /* /sys/fs */
 decl_subsys(fs, NULL, NULL);
--- linux-2.6.17-rc1.orig/include/linux/namespace.h
+++ linux-2.6.17-rc1/include/linux/namespace.h
@@ -5,6 +5,8 @@
 #include <linux/mount.h>
 #include <linux/sched.h>
 
+extern struct rw_semaphore namespace_sem;
+
 struct namespace {
 	atomic_t		count;
 	struct vfsmount *	root;
