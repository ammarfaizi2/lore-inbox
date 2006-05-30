Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932284AbWE3OHr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932284AbWE3OHr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 10:07:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932283AbWE3OHq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 10:07:46 -0400
Received: from cam-admin0.cambridge.arm.com ([193.131.176.58]:5783 "EHLO
	cam-admin0.cambridge.arm.com") by vger.kernel.org with ESMTP
	id S932286AbWE3OHe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 10:07:34 -0400
From: Catalin Marinas <catalin.marinas@arm.com>
Reply-To: catalin.marinas@gmail.com
Subject: [PATCH 2.6.17-rc5 6/7] Remove some of the kmemleak false positives
Date: Tue, 30 May 2006 15:07:32 +0100
To: linux-kernel@vger.kernel.org
Message-Id: <20060530140732.21491.50139.stgit@localhost.localdomain>
In-Reply-To: <20060530135016.21491.34817.stgit@localhost.localdomain>
References: <20060530135016.21491.34817.stgit@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
X-OriginalArrivalTime: 30 May 2006 14:07:33.0117 (UTC) FILETIME=[6547DAD0:01C683F2]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Catalin Marinas <catalin.marinas@arm.com>

There are allocations for which the main pointer cannot be found but they
are not memory leaks. This patch fixes some of them.

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
---

 arch/i386/kernel/setup.c |    1 +
 ipc/util.c               |    2 ++
 kernel/module.c          |    2 ++
 kernel/params.c          |    7 +++++--
 4 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/i386/kernel/setup.c b/arch/i386/kernel/setup.c
index 846e163..a6407f6 100644
--- a/arch/i386/kernel/setup.c
+++ b/arch/i386/kernel/setup.c
@@ -1323,6 +1323,7 @@ legacy_init_iomem_resources(struct resou
 		if (e820.map[i].addr + e820.map[i].size > 0x100000000ULL)
 			continue;
 		res = kzalloc(sizeof(struct resource), GFP_ATOMIC);
+		memleak_debug_not_leak(res);
 		switch (e820.map[i].type) {
 		case E820_RAM:	res->name = "System RAM"; break;
 		case E820_ACPI:	res->name = "ACPI Tables"; break;
diff --git a/ipc/util.c b/ipc/util.c
index 8193299..40014a4 100644
--- a/ipc/util.c
+++ b/ipc/util.c
@@ -389,6 +389,7 @@ void* ipc_rcu_alloc(int size)
 	 */
 	if (rcu_use_vmalloc(size)) {
 		out = vmalloc(HDRLEN_VMALLOC + size);
+		memleak_debug_not_leak(out);
 		if (out) {
 			out += HDRLEN_VMALLOC;
 			container_of(out, struct ipc_rcu_hdr, data)->is_vmalloc = 1;
@@ -396,6 +397,7 @@ void* ipc_rcu_alloc(int size)
 		}
 	} else {
 		out = kmalloc(HDRLEN_KMALLOC + size, GFP_KERNEL);
+		memleak_debug_not_leak(out);
 		if (out) {
 			out += HDRLEN_KMALLOC;
 			container_of(out, struct ipc_rcu_hdr, data)->is_vmalloc = 0;
diff --git a/kernel/module.c b/kernel/module.c
index 9b400dc..1c9f04e 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -1576,6 +1576,7 @@ #endif
 
 	/* Do the allocs. */
 	ptr = module_alloc(mod->core_size);
+	memleak_debug_not_leak(ptr);
 	if (!ptr) {
 		err = -ENOMEM;
 		goto free_percpu;
@@ -1584,6 +1585,7 @@ #endif
 	mod->module_core = ptr;
 
 	ptr = module_alloc(mod->init_size);
+	memleak_debug_ignore(ptr);
 	if (!ptr && mod->init_size) {
 		err = -ENOMEM;
 		goto free_core;
diff --git a/kernel/params.c b/kernel/params.c
index af43ecd..6c04a68 100644
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
+		memleak_debug_not_leak(mp);
 }
 
 /*
