Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750798AbWHGRmE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750798AbWHGRmE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 13:42:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750806AbWHGRmE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 13:42:04 -0400
Received: from e32.co.us.ibm.com ([32.97.110.150]:32168 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750798AbWHGRmD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 13:42:03 -0400
Subject: Re: [PATCH 9/10] hot-add-mem x86_64: use
	CONFIG_MEMORY_HOTPLUG_RESERVE
From: keith mannthey <kmannth@us.ibm.com>
Reply-To: kmannth@us.ibm.com
To: lkml <linux-kernel@vger.kernel.org>
Cc: andrew <akpm@osdl.org>, discuss <discuss@x86-64.org>,
       Andi Kleen <ak@suse.de>, lhms-devel <lhms-devel@lists.sourceforge.net>,
       kame <kamezawa.hiroyu@jp.fujitsu.com>
In-Reply-To: <20060804131439.21401.62864.sendpatchset@localhost.localdomain>
References: <20060804131351.21401.4877.sendpatchset@localhost.localdomain>
	 <20060804131439.21401.62864.sendpatchset@localhost.localdomain>
Content-Type: text/plain
Organization: Linux Technology Center IBM
Date: Mon, 07 Aug 2006 10:41:25 -0700
Message-Id: <1154972485.5790.3.camel@keithlap>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-08-04 at 07:14 -0600, Keith Mannthey wrote:
> From: Keith Mannthey <kmannth@us.ibm.com>
> 


Opps looks like I attached the wrong patch in the original email :( 
Here is the real patch...

From: Keith Mannthey <kmannth@us.ibm.com>

  Make CONFIG_MEMORY_HOTPLUG_RESERVE and CONFIG_MEMORY_HOTPLUG_SPARSE
build in the same tree. 

Signed-off-by: Keith Mannthey<kmannth@us.ibm.com>
---
 arch/x86_64/mm/init.c |   10 +++++---
 mm/memory_hotplug.c   |   60 ++++++++++++++++++++++++
+------------------------- 2 files changed, 36 insertions(+), 34
deletions(-)

diff -urN linux-2.6.17-stock/arch/x86_64/mm/init.c
linux-2.6.17/arch/x86_64/mm/init.c
--- linux-2.6.17-stock/arch/x86_64/mm/init.c	2006-08-04
08:03:44.000000000 -0400
+++ linux-2.6.17/arch/x86_64/mm/init.c	2006-08-04 08:04:40.000000000
-0400
@@ -529,12 +529,12 @@
 	unsigned long nr_pages = size >> PAGE_SHIFT;
 	int ret;
 
+	init_memory_mapping(start, (start + size -1));
+
 	ret = __add_pages(zone, start_pfn, nr_pages);
 	if (ret)
 		goto error;
 
-	init_memory_mapping(start, (start + size -1));
-
 	return ret;
 error:
 	printk("%s: Problem encountered in __add_pages!\n", __func__);
@@ -555,7 +555,9 @@
 }
 #endif 
 
-#else /* CONFIG_MEMORY_HOTPLUG */
+#endif /* CONFIG_MEMORY_HOTPLUG */
+
+#ifdef CONFIG_MEMORY_HOTPLUG_RESERVE 
 /*
  * Memory Hotadd without sparsemem. The mem_maps have been allocated in
advance,
  * just online the pages.
@@ -581,7 +583,7 @@
 	}
 	return err;
 }
-#endif /* CONFIG_MEMORY_HOTPLUG */
+#endif
 
 static struct kcore_list kcore_mem, kcore_vmalloc, kcore_kernel,
kcore_modules,
 			 kcore_vsyscall;
diff -urN linux-2.6.17-stock/mm/memory_hotplug.c
linux-2.6.17/mm/memory_hotplug.c
--- linux-2.6.17-stock/mm/memory_hotplug.c	2006-08-04 08:03:54.000000000
-0400
+++ linux-2.6.17/mm/memory_hotplug.c	2006-08-04 08:04:40.000000000 -0400
@@ -24,6 +24,36 @@
 
 #include <asm/tlbflush.h>
 
+/* add this memory to iomem resource */
+static struct resource *register_memory_resource(u64 start, u64 size)
+{
+	struct resource *res;
+	res = kzalloc(sizeof(struct resource), GFP_KERNEL);
+	BUG_ON(!res);
+
+	res->name = "System RAM";
+	res->start = start;
+	res->end = start + size - 1;
+	res->flags = IORESOURCE_MEM;
+	if (request_resource(&iomem_resource, res) < 0) {
+		printk("System RAM resource %llx - %llx cannot be added\n",
+		(unsigned long long)res->start, (unsigned long long)res->end);
+		kfree(res);
+		res = NULL;
+	}
+	return res;
+}
+
+static void release_memory_resource(struct resource *res)
+{
+	if (!res)
+		return;
+	release_resource(res);
+	kfree(res);
+	return;
+}
+
+
 #ifdef CONFIG_MEMORY_HOTPLUG_SPARSE
 static int __add_zone(struct zone *zone, unsigned long phys_start_pfn)
 {
@@ -220,36 +250,6 @@
 	return;
 }
 
-/* add this memory to iomem resource */
-static struct resource *register_memory_resource(u64 start, u64 size)
-{
-	struct resource *res;
-	res = kzalloc(sizeof(struct resource), GFP_KERNEL);
-	BUG_ON(!res);
-
-	res->name = "System RAM";
-	res->start = start;
-	res->end = start + size - 1;
-	res->flags = IORESOURCE_MEM;
-	if (request_resource(&iomem_resource, res) < 0) {
-		printk("System RAM resource %llx - %llx cannot be added\n",
-		(unsigned long long)res->start, (unsigned long long)res->end);
-		kfree(res);
-		res = NULL;
-	}
-	return res;
-}
-
-static void release_memory_resource(struct resource *res)
-{
-	if (!res)
-		return;
-	release_resource(res);
-	kfree(res);
-	return;
-}
-
-
 
 int add_memory(int nid, u64 start, u64 size)
 {


