Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268101AbUIWQkL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268101AbUIWQkL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 12:40:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266457AbUIWQiv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 12:38:51 -0400
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:8836 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S268135AbUIWQg4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 12:36:56 -0400
Date: Fri, 24 Sep 2004 01:32:55 +0900
From: Keiichiro Tokunaga <tokunaga.keiich@jp.fujitsu.com>
To: anil.s.keshavamurthy@intel.com
Cc: len.brown@intel.com, acpi-devel@lists.sourceforge.net,
       lhns-devel@lists.sourceforge.net, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org,
       Keiichiro Tokunaga <tokunaga.keiich@jp.fujitsu.com>
Subject: [PATCH][3/4] Add hotplug support to drivers/acpi/numa.c
Message-Id: <20040924013255.00000337.tokunaga.keiich@jp.fujitsu.com>
In-Reply-To: <20040924012301.000007c6.tokunaga.keiich@jp.fujitsu.com>
References: <20040920092520.A14208@unix-os.sc.intel.com>
	<20040920094719.H14208@unix-os.sc.intel.com>
	<20040924012301.000007c6.tokunaga.keiich@jp.fujitsu.com>
Organization: FUJITSU LIMITED
X-Mailer: Sylpheed version 0.8.7 (GTK+ 1.3.0; Win32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Name: acpi_numa_hp.patch
Status: Tested on 2.6.9-rc2
Signed-off-by: Keiichiro Tokunaga <tokunaga.keiich@jp.fujitsu.com>
Description:
Add hotplug support to drivers/acpi/numa.c.

Thanks,
Keiichiro Tokunaga
---

 linux-2.6.9-rc2-fix-kei/drivers/acpi/numa.c |  267 ++++++++++++++++++++++++++++
 linux-2.6.9-rc2-fix-kei/include/acpi/numa.h |   30 +++
 2 files changed, 297 insertions(+)

diff -puN drivers/acpi/numa.c~acpi_numa_hp drivers/acpi/numa.c
--- linux-2.6.9-rc2-fix/drivers/acpi/numa.c~acpi_numa_hp	2004-09-24 00:14:56.382611368 +0900
+++ linux-2.6.9-rc2-fix-kei/drivers/acpi/numa.c	2004-09-24 00:44:58.135989078 +0900
@@ -31,6 +31,7 @@
 #include <linux/acpi.h>
 #include <acpi/acpi_bus.h>
 #include <acpi/acmacros.h>
+#include <acpi/numa.h>
 
 #define ACPI_NUMA	0x80000000
 #define _COMPONENT	ACPI_NUMA
@@ -214,3 +215,269 @@ acpi_get_pxm(acpi_handle h)
 	return -1;
 }
 EXPORT_SYMBOL(acpi_get_pxm);
+
+
+#if ( defined(CONFIG_ACPI_CONTAINER_MODULE) || defined(CONFIG_ACPI_CONTAINER) ) && defined(CONFIG_HOTPLUG)
+
+static int nid2pxm(int nid)
+{
+	int i;
+
+	if ((nid < 0) || (nid >= MAX_NUMNODES))
+		return -1;
+
+	for(i=0; i < MAX_PXM_DOMAINS; i++) {
+		if ( pxm_to_nid_map[i] == nid )
+			return i;
+	}
+
+	return -1;
+}
+
+void
+acpi_numa_data_handler(acpi_handle handle, u32 function, void *context)
+{
+    return;
+}
+
+int is_numa_node_device(acpi_handle handle)
+{
+	acpi_status status;
+	struct acpi_numa_node *data=NULL;
+
+	status = acpi_get_data(handle, acpi_numa_data_handler, (void **)&data);
+	if (ACPI_FAILURE(status))
+		return 0;
+	else
+		return 1;
+}
+
+int acpi_get_numa_nodeid(int pxm)
+{
+	if (pxm < 0 || pxm >= MAX_PXM_DOMAINS)
+		return -EINVAL;
+
+	return pxm_to_nid_map[pxm];
+}
+EXPORT_SYMBOL(acpi_get_numa_nodeid);
+
+static void
+set_nodeid(int pxm, int nid)
+{
+	if (pxm_to_nid_map[pxm] >= 0) {
+		printk(KERN_INFO"PXM <%d> already has a nid <%d>.\n",
+		       pxm_to_nid_map[pxm], pxm);
+		return ;
+	}
+
+	if (nid >= MAX_NUMNODES) {
+		printk(KERN_ERR"nid <%d> is too big. Range: 0-%d\n",
+		       nid, MAX_NUMNODES-1);
+		return ;
+	}
+
+	pxm_to_nid_map[pxm] = nid;
+}
+
+static void unget_nodeid(int nid)
+{
+#ifdef PXM_FIX_NODEID
+	int pxm = nid2pxm(nid);
+	if (pxm < 0)
+		return;
+	pxm_to_nid_map[pxm] = -1;
+#endif
+}
+
+static int
+allocate_nodeid(int pxm)
+{
+	int i;
+
+#ifndef PXM_FIX_NODEID
+	if (pxm_to_nid_map[pxm] >= 0)
+		return pxm_to_nid_map[pxm];
+#endif
+	for(i=0 ;i < MAX_NUMNODES; i++) {
+		if (nid2pxm(i) < 0)
+			return i;
+	}
+
+	printk(KERN_ERR"Failed to allocate nid for PXM <%d>\n", pxm);
+	return -1;
+}
+
+static acpi_status
+find_processor(acpi_handle handle, u32 lvl, void *context, void **rv)
+{
+	int **cntp = (int **)rv;
+
+	ACPI_FUNCTION_TRACE("find_processor");
+
+	++(**cntp);
+
+	return_ACPI_STATUS(AE_OK);
+}
+
+void acpi_numa_node_add(acpi_handle handle)
+{
+	acpi_status status;
+	struct acpi_numa_node *data=NULL;
+
+	ACPI_FUNCTION_TRACE("acpi_numa_node_add");
+
+	status = acpi_get_data(handle, acpi_numa_data_handler, (void **)&data);
+	if (ACPI_FAILURE(status))
+		return_VOID;
+
+	if (data->pxm < 0) {
+		printk(KERN_ERR"Container does not have PXM.\n");
+		return_VOID;
+	}
+
+	arch_register_node(data->nid);
+
+	return_VOID;
+}
+
+void acpi_numa_node_remove(acpi_handle handle)
+{
+	acpi_status status;
+	struct acpi_numa_node *data=NULL;
+	int nid;
+
+	ACPI_FUNCTION_TRACE("acpi_numa_node_remove");
+
+	status = acpi_get_data(handle, acpi_numa_data_handler, (void **)&data);
+	if (ACPI_FAILURE(status) || !data)
+		return_VOID;
+
+	nid = data->nid;
+	if (nid < 0) {
+		printk(KERN_ERR"Invalid nid %d\n", nid);
+		return_VOID;
+	}
+
+	arch_unregister_node(nid);
+	unget_nodeid(nid);
+	acpi_numa_node_data_detach(handle);
+
+	return_VOID;
+}
+
+void acpi_numa_node_data_detach(acpi_handle handle)
+{
+	struct acpi_numa_node *data=NULL;
+	acpi_status status;
+
+	ACPI_FUNCTION_TRACE("acpi_numa_node_data_detach");
+
+	status = acpi_get_data(handle, acpi_numa_data_handler, (void **)&data);
+	if (ACPI_FAILURE(status) || (data == NULL))
+		return_VOID;
+
+	status = acpi_detach_data(handle, acpi_numa_data_handler);
+	if (ACPI_FAILURE(status)) {
+		printk(KERN_ERR"Failed to detach NUMA node data.\n");
+		return_VOID;
+	}
+
+	kfree(data);
+	ACPI_DEBUG_PRINT((ACPI_DB_INFO, "NUMA node data is detached.\n"));
+	return_VOID;
+}
+
+void acpi_numa_node_init(acpi_handle handle)
+{
+	int pxm;
+	acpi_status status;
+	struct acpi_numa_node *data;
+	int _cnt=0;
+	int *cnt=&_cnt;
+	struct acpi_device *node_dev=NULL;
+
+	ACPI_FUNCTION_TRACE("acpi_numa_node_init");
+
+	if (acpi_bus_get_device(handle, &node_dev)) {
+		printk(KERN_ERR"Unknown handle.\n");
+		return_VOID;
+	}
+
+	pxm = acpi_get_pxm(handle);
+	if (pxm < 0) {
+		ACPI_DEBUG_PRINT((ACPI_DB_WARN, "PXM was not found.\n"));
+		return_VOID;
+	}
+
+	data = kmalloc(sizeof(struct acpi_numa_node), GFP_KERNEL);
+	if (!data) {
+		printk(KERN_ERR"Not enough memory.\n");
+		return_VOID;
+	}
+
+	data->handle = handle;
+	data->pxm = pxm;
+	data->nid = -1;
+
+	acpi_walk_namespace(ACPI_TYPE_PROCESSOR,
+			    handle,
+			    (u32) 1,
+			    find_processor,
+			    data,
+			    (void **)&cnt);
+	/*
+	 * TBD: Check nid of memory object
+	 *      paddr_to_node[] (include/asm-ia64/numa.h)
+	 */
+	if (! _cnt) {
+		ACPI_DEBUG_PRINT((ACPI_DB_INFO,
+				  "nid of <%s> is not detected.\n",
+				  acpi_device_bid(node_dev)));
+		goto cancel;
+	}
+
+	if (pxm_to_nid_map[pxm] < 0) {
+		int nid = allocate_nodeid(pxm);
+		ACPI_DEBUG_PRINT((ACPI_DB_INFO,
+				  "nid <%d> is allocated for PXM <%d>.\n",
+				  nid, data->pxm));
+		if (nid < 1) {
+			/* "node 0" is a fixed ID. */
+			printk(KERN_ERR"Cannot get nid.\n");
+			return_VOID;
+		}
+		data->nid = nid;
+		set_nodeid(pxm, nid);
+	} else {
+		data->nid = pxm_to_nid_map[pxm];
+	}
+
+
+	status = acpi_attach_data(handle, acpi_numa_data_handler, data);
+	if (ACPI_FAILURE(status)) {
+		printk(KERN_ERR"Failed to attach NUMA data for <%s>.\n",
+		       acpi_device_bid(node_dev));
+		goto cancel;
+	}
+
+	printk(KERN_INFO"Container <%s> is NUMA node.\n",
+	       acpi_device_bid(node_dev));
+	ACPI_DEBUG_PRINT((ACPI_DB_INFO,
+			  "Initialized: Container<%s> PXM=%d nid=%d\n",
+			  acpi_device_bid(node_dev), pxm, data->nid));
+	return_VOID;
+
+cancel:
+	if (data)
+		kfree(data);
+	return_VOID;
+}
+
+EXPORT_SYMBOL(acpi_numa_node_init);
+EXPORT_SYMBOL(acpi_numa_node_add);
+EXPORT_SYMBOL(acpi_numa_node_remove);
+EXPORT_SYMBOL(acpi_numa_node_data_detach);
+EXPORT_SYMBOL(acpi_numa_data_handler);
+EXPORT_SYMBOL(is_numa_node_device);
+
+#endif /* defined(CONFIG_ACPI_CONTAINER) && defined(CONFIG_HOTPLUG) */
diff -puN /dev/null include/acpi/numa.h
--- /dev/null	2003-08-16 05:19:42.000000000 +0900
+++ linux-2.6.9-rc2-fix-kei/include/acpi/numa.h	2004-09-24 00:14:56.386517641 +0900
@@ -0,0 +1,30 @@
+#ifndef _ACPI_NUMA_H_
+#define _ACPI_NUMA_H_
+
+#include <linux/config.h>
+#include <linux/kernel.h>
+#include <linux/acpi.h>
+#include <asm/acpi.h>
+#include <acpi/acpixf.h>
+
+#if defined(CONFIG_ACPI_CONTAINER) || defined(CONFIG_ACPI_CONTAINER_MODULE)
+#include <linux/numa.h>
+struct acpi_numa_node {
+	acpi_handle handle;
+	int pxm;
+	int nid;
+};
+
+#ifndef MAX_PXM_DOMAINS
+#define MAX_PXM_DOMAINS (256)
+#endif
+extern void acpi_numa_node_init(acpi_handle handle);
+extern void acpi_numa_node_add(acpi_handle handle);
+extern void acpi_numa_node_remove(acpi_handle handle);
+extern void acpi_numa_data_handler ( acpi_handle handle, u32 function, void *context);
+extern void acpi_numa_node_data_detach(acpi_handle handle);
+extern int  is_numa_node_device(acpi_handle handle);
+extern int acpi_numa_node_add_post(acpi_handle handle);
+extern int acpi_numa_node_remove_request(acpi_handle handle);
+#endif	/* CONFIG_ACPI_CONTAINER */
+#endif

_
