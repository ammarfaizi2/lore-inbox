Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751494AbWE0MYh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751494AbWE0MYh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 May 2006 08:24:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751502AbWE0MYW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 May 2006 08:24:22 -0400
Received: from mta08-winn.ispmail.ntl.com ([81.103.221.48]:28891 "EHLO
	mtaout02-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S1751494AbWE0MYA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 May 2006 08:24:00 -0400
From: Catalin Marinas <catalin.marinas@gmail.com>
Subject: [PATCH 2.6.17-rc5 6/7] Remove some of the kmemleak false positives
Date: Sat, 27 May 2006 13:23:57 +0100
To: linux-kernel@vger.kernel.org
Message-Id: <20060527122356.21451.75083.stgit@localhost.localdomain>
In-Reply-To: <20060527120709.21451.3187.stgit@localhost.localdomain>
References: <20060527120709.21451.3187.stgit@localhost.localdomain>
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

 ipc/util.c      |    2 ++
 kernel/params.c |    7 +++++--
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/ipc/util.c b/ipc/util.c
index 8193299..412b7f3 100644
--- a/ipc/util.c
+++ b/ipc/util.c
@@ -389,6 +389,7 @@ void* ipc_rcu_alloc(int size)
 	 */
 	if (rcu_use_vmalloc(size)) {
 		out = vmalloc(HDRLEN_VMALLOC + size);
+		memleak_debug_false_alarm(out);
 		if (out) {
 			out += HDRLEN_VMALLOC;
 			container_of(out, struct ipc_rcu_hdr, data)->is_vmalloc = 1;
@@ -396,6 +397,7 @@ void* ipc_rcu_alloc(int size)
 		}
 	} else {
 		out = kmalloc(HDRLEN_KMALLOC + size, GFP_KERNEL);
+		memleak_debug_false_alarm(out);
 		if (out) {
 			out += HDRLEN_KMALLOC;
 			container_of(out, struct ipc_rcu_hdr, data)->is_vmalloc = 0;
diff --git a/kernel/params.c b/kernel/params.c
index af43ecd..412c712 100644
--- a/kernel/params.c
+++ b/kernel/params.c
@@ -548,6 +548,7 @@ static void __init kernel_param_sysfs_se
 					    unsigned int name_skip)
 {
 	struct module_kobject *mk;
+	struct module_param_attrs *mp;
 
 	mk = kzalloc(sizeof(struct module_kobject), GFP_KERNEL);
 	BUG_ON(!mk);
@@ -557,11 +558,13 @@ static void __init kernel_param_sysfs_se
 	kobject_set_name(&mk->kobj, name);
 	kobject_register(&mk->kobj);
 
+	mp = param_sysfs_setup(mk, kparam, num_params, name_skip);
 	/* no need to keep the kobject if no parameter is exported */
-	if (!param_sysfs_setup(mk, kparam, num_params, name_skip)) {
+	if (!mp) {
 		kobject_unregister(&mk->kobj);
 		kfree(mk);
-	}
+	} else
+		memleak_debug_false_alarm(mp);
 }
 
 /*
