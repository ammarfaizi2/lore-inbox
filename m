Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030270AbWFCILr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030270AbWFCILr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jun 2006 04:11:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030292AbWFCILq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jun 2006 04:11:46 -0400
Received: from cam-admin0.cambridge.arm.com ([193.131.176.58]:13003 "EHLO
	cam-admin0.cambridge.arm.com") by vger.kernel.org with ESMTP
	id S1030283AbWFCILi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jun 2006 04:11:38 -0400
From: Catalin Marinas <catalin.marinas@arm.com>
Reply-To: catalin.marinas@gmail.com
Subject: [PATCH 2.6.17-rc5 7/8] Remove some of the kmemleak false positives
Date: Sat, 03 Jun 2006 09:11:34 +0100
To: linux-kernel@vger.kernel.org
Message-Id: <20060603081134.31915.37367.stgit@localhost.localdomain>
In-Reply-To: <20060603081054.31915.4038.stgit@localhost.localdomain>
References: <20060603081054.31915.4038.stgit@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
X-OriginalArrivalTime: 03 Jun 2006 08:11:35.0124 (UTC) FILETIME=[5493C140:01C686E5]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Catalin Marinas <catalin.marinas@arm.com>

There are allocations for which the main pointer cannot be found but they
are not memory leaks. This patch fixes some of them.

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
---

 arch/i386/kernel/setup.c |    1 +
 ipc/util.c               |    2 ++
 kernel/params.c          |    7 +++++--
 mm/slab.c                |    1 +
 4 files changed, 9 insertions(+), 2 deletions(-)

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
diff --git a/mm/slab.c b/mm/slab.c
index 3494d9d..a2b82ed 100644
--- a/mm/slab.c
+++ b/mm/slab.c
@@ -3358,6 +3358,7 @@ void *__alloc_percpu(size_t size)
 		memset(pdata->ptrs[i], 0, size);
 	}
 
+	memleak_debug_not_leak(pdata);
 	/* Catch derefs w/o wrappers */
 	return (void *)(~(unsigned long)pdata);
 
