Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267568AbUIXDXa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267568AbUIXDXa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 23:23:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267548AbUIXDT2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 23:19:28 -0400
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:5523 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S267662AbUIXDPz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 23:15:55 -0400
Date: Fri, 24 Sep 2004 12:12:03 +0900
From: Keiichiro Tokunaga <tokunaga.keiich@jp.fujitsu.com>
Subject: Re: [Lhns-devel] [PATCH][1/4] Add unregister_node() to
 drivers/base/node.c
In-reply-to: <1095957796.21153.94.camel@localhost>
To: Dave Hansen <haveblue@us.ibm.com>, anil.s.keshavamurthy@intel.com
Cc: tokunaga.keiich@jp.fujitsu.com, len.brown@intel.com,
       acpi-devel@lists.sourceforge.net, lhns-devel@lists.sourceforge.net,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Message-id: <20040924121203.4862d0e9.tokunaga.keiich@jp.fujitsu.com>
Organization: FUJITSU LIMITED
MIME-version: 1.0
X-Mailer: Sylpheed version 0.9.9 (GTK+ 1.2.10; i686-pc-linux-gnu)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
References: <20040920092520.A14208@unix-os.sc.intel.com>
 <20040920094719.H14208@unix-os.sc.intel.com>
 <20040924012301.000007c6.tokunaga.keiich@jp.fujitsu.com>
 <20040924013123.000067cd.tokunaga.keiich@jp.fujitsu.com>
 <1095957796.21153.94.camel@localhost>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Sep 2004 09:43:16 -0700 Dave Hansen wrote:
> On Thu, 2004-09-23 at 09:31, Keiichiro Tokunaga wrote:
> > -int __init register_node(struct node *node, int num, struct node *parent)
> > +int register_node(struct node *node, int num, struct node *parent)
> 
> __devinit, please.

Exactly.  Thanks for looking.

I have refreshed the patch.  Anil, please replace the old one with this.

Thanks,
Keiichiro Tokunaga


Name: numa_hp_base.patch
Status: Tested on 2.6.9-rc2
Signed-off-by: Keiichiro Tokunaga <tokunaga.keiich@jp.fujitsu.com>
Description:
Create unregister_node() to remove corresponding sysfs directory and files
from /sys/devices/system/node/.


---

 linux-2.6.9-rc2-fix-kei/drivers/base/node.c  |   19 +++++++++++++++++--
 linux-2.6.9-rc2-fix-kei/include/linux/node.h |    3 ++-
 linux-2.6.9-rc2-fix-kei/mm/page_alloc.c      |    2 ++
 3 files changed, 21 insertions(+), 3 deletions(-)

diff -puN drivers/base/node.c~numa_hp_base drivers/base/node.c
--- linux-2.6.9-rc2-fix/drivers/base/node.c~numa_hp_base	2004-09-24 00:14:55.000000000 +0900
+++ linux-2.6.9-rc2-fix-kei/drivers/base/node.c	2004-09-24 10:03:38.898061522 +0900
@@ -117,7 +117,7 @@ static SYSDEV_ATTR(numastat, S_IRUGO, no
  *
  * Initialize and register the node device.
  */
-int __init register_node(struct node *node, int num, struct node *parent)
+int __devinit register_node(struct node *node, int num, struct node *parent)
 {
 	int error;
 
@@ -133,9 +133,24 @@ int __init register_node(struct node *no
 	return error;
 }
 
+void __devexit unregister_node(struct node *node, struct node *parent)
+{
+	if (node == NULL) {
+		printk("unregister_node: node is null.");
+		return;
+	}
+	sysdev_remove_file(&node->sysdev, &attr_cpumap);
+	sysdev_remove_file(&node->sysdev, &attr_meminfo);
+	sysdev_unregister(&node->sysdev);
+}
 
-int __init register_node_type(void)
+
+static int __init register_node_type(void)
 {
 	return sysdev_class_register(&node_class);
 }
 postcore_initcall(register_node_type);
+
+
+EXPORT_SYMBOL(register_node);
+EXPORT_SYMBOL(unregister_node);
diff -puN include/linux/node.h~numa_hp_base include/linux/node.h
--- linux-2.6.9-rc2-fix/include/linux/node.h~numa_hp_base	2004-09-24 00:14:55.000000000 +0900
+++ linux-2.6.9-rc2-fix-kei/include/linux/node.h	2004-09-24 11:29:57.267562810 +0900
@@ -26,7 +26,8 @@ struct node {
 	struct sys_device	sysdev;
 };
 
-extern int register_node(struct node *, int, struct node *);
+extern int __devinit register_node(struct node *, int, struct node *);
+extern void __devexit unregister_node(struct node *node, struct node *parent);
 
 #define to_node(sys_device) container_of(sys_device, struct node, sysdev)
 
diff -puN mm/page_alloc.c~numa_hp_base mm/page_alloc.c
--- linux-2.6.9-rc2-fix/mm/page_alloc.c~numa_hp_base	2004-09-24 00:14:55.000000000 +0900
+++ linux-2.6.9-rc2-fix-kei/mm/page_alloc.c	2004-09-24 00:14:55.000000000 +0900
@@ -14,6 +14,7 @@
  *          (lots of bits borrowed from Ingo Molnar & Andrew Morton)
  */
 
+#include <linux/module.h>
 #include <linux/config.h>
 #include <linux/stddef.h>
 #include <linux/mm.h>
@@ -44,6 +45,7 @@ int sysctl_lower_zone_protection = 0;
 
 EXPORT_SYMBOL(totalram_pages);
 EXPORT_SYMBOL(nr_swap_pages);
+EXPORT_SYMBOL(node_online_map);
 
 /*
  * Used by page_zone() to look up the address of the struct zone whose

_
