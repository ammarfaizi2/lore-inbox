Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932476AbWEMQHE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932476AbWEMQHE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 May 2006 12:07:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932470AbWEMQGo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 May 2006 12:06:44 -0400
Received: from mta07-winn.ispmail.ntl.com ([81.103.221.47]:20493 "EHLO
	mtaout01-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S932469AbWEMQGc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 May 2006 12:06:32 -0400
From: Catalin Marinas <catalin.marinas@gmail.com>
Subject: [PATCH 2.6.17-rc4 6/6] Remove some of the kmemleak false positives
Date: Sat, 13 May 2006 17:06:25 +0100
To: linux-kernel@vger.kernel.org
Message-Id: <20060513160625.8848.76947.stgit@localhost.localdomain>
In-Reply-To: <20060513155757.8848.11980.stgit@localhost.localdomain>
References: <20060513155757.8848.11980.stgit@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Catalin Marinas <catalin.marinas@arm.com>

There are allocations for which the main pointer cannot be found but they
are not memory leaks. This patch fixes some of them.

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
---

 ipc/util.c      |   13 +++++++++++++
 kernel/params.c |    9 ++++++++-
 2 files changed, 21 insertions(+), 1 deletions(-)

diff --git a/ipc/util.c b/ipc/util.c
index 8193299..788db50 100644
--- a/ipc/util.c
+++ b/ipc/util.c
@@ -31,6 +31,11 @@ #include <linux/seq_file.h>
 #include <linux/proc_fs.h>
 #include <linux/audit.h>
 
+#ifdef CONFIG_DEBUG_MEMLEAK
+#include <linux/memleak.h>
+#endif
+
+
 #include <asm/unistd.h>
 
 #include "util.h"
@@ -389,6 +394,10 @@ void* ipc_rcu_alloc(int size)
 	 */
 	if (rcu_use_vmalloc(size)) {
 		out = vmalloc(HDRLEN_VMALLOC + size);
+#ifdef CONFIG_DEBUG_MEMLEAK
+		/* avoid a false alarm. That's not a memory leak */
+		memleak_free(out);
+#endif
 		if (out) {
 			out += HDRLEN_VMALLOC;
 			container_of(out, struct ipc_rcu_hdr, data)->is_vmalloc = 1;
@@ -396,6 +405,10 @@ void* ipc_rcu_alloc(int size)
 		}
 	} else {
 		out = kmalloc(HDRLEN_KMALLOC + size, GFP_KERNEL);
+#ifdef CONFIG_DEBUG_MEMLEAK
+		/* avoid a false alarm. That's not a memory leak */
+		memleak_free(out);
+#endif
 		if (out) {
 			out += HDRLEN_KMALLOC;
 			container_of(out, struct ipc_rcu_hdr, data)->is_vmalloc = 0;
diff --git a/kernel/params.c b/kernel/params.c
index af43ecd..fb268e8 100644
--- a/kernel/params.c
+++ b/kernel/params.c
@@ -548,6 +548,7 @@ static void __init kernel_param_sysfs_se
 					    unsigned int name_skip)
 {
 	struct module_kobject *mk;
+	struct module_param_attrs *mp;
 
 	mk = kzalloc(sizeof(struct module_kobject), GFP_KERNEL);
 	BUG_ON(!mk);
@@ -557,11 +558,17 @@ static void __init kernel_param_sysfs_se
 	kobject_set_name(&mk->kobj, name);
 	kobject_register(&mk->kobj);
 
+	mp = param_sysfs_setup(mk, kparam, num_params, name_skip);
 	/* no need to keep the kobject if no parameter is exported */
-	if (!param_sysfs_setup(mk, kparam, num_params, name_skip)) {
+	if (!mp) {
 		kobject_unregister(&mk->kobj);
 		kfree(mk);
 	}
+#ifdef CONFIG_DEBUG_MEMLEAK
+	/* avoid a false alarm. That's not a memory leak */
+	else
+		memleak_free(mp);
+#endif
 }
 
 /*
