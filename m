Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266117AbUI1KYY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266117AbUI1KYY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Sep 2004 06:24:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267806AbUI1KYS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Sep 2004 06:24:18 -0400
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:38554 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S267588AbUI1KX1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Sep 2004 06:23:27 -0400
Date: Tue, 28 Sep 2004 19:19:25 +0900
From: Keiichiro Tokunaga <tokunaga.keiich@jp.fujitsu.com>
Subject: Re: [PATCH][1/4] Add unregister_node() to drivers/base/node.c
In-reply-to: <20040927115244.A30443@unix-os.sc.intel.com>
To: Keshavamurthy Anil S <anil.s.keshavamurthy@intel.com>
Cc: tokunaga.keiich@jp.fujitsu.com, len.brown@intel.com,
       acpi-devel@lists.sourceforge.net, lhns-devel@lists.sourceforge.net,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Message-id: <20040928191925.531aa3c6.tokunaga.keiich@jp.fujitsu.com>
Organization: FUJITSU LIMITED
MIME-version: 1.0
X-Mailer: Sylpheed version 0.9.9 (GTK+ 1.2.10; i686-pc-linux-gnu)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
References: <20040920092520.A14208@unix-os.sc.intel.com>
 <20040920094719.H14208@unix-os.sc.intel.com>
 <20040924012301.000007c6.tokunaga.keiich@jp.fujitsu.com>
 <20040924013123.000067cd.tokunaga.keiich@jp.fujitsu.com>
 <20040927115244.A30443@unix-os.sc.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Sep 2004 11:52:44 -0700 Keshavamurthy Anil S wrote:
> On Fri, Sep 24, 2004 at 01:31:23AM +0900, Keiichiro Tokunaga wrote:

Thanks for the comments!

> > -int __init register_node(struct node *node, int num, struct node *parent)
> > +int register_node(struct node *node, int num, struct node *parent)
> 
> __devinit please

Oh, yes.   I got the same comments from Dave and posted an updated
patch fixing the issue.

> > +void  unregister_node(struct node *node, struct node *parent)
> 
> unregister_node is required only for hotplug case. Please hide this function
> under suitable #ifdef's, say this is only required if CONFIG_HOTPLUG is enabled.

That's right.  I enclosed the function with #ifdef CONFIG_HOTPLUG.

> > +	sysdev_remove_file(&node->sysdev, &attr_cpumap);
> > +	sysdev_remove_file(&node->sysdev, &attr_meminfo);
> 
> add sysdev_remove_file(&node->sysdev, &attr_numastat);

I added.

> > +EXPORT_SYMBOL(node_online_map);
> Why do you need this in this patch?

Sorry, it's a stuff that I forgot to remove... so it's not needed.
I removed it.

I am attaching an updated patch.  Please see it below.

Thanks!
Keiichiro Tokunaga



Name: numa_hp_base.patch
Status: Tested on 2.6.9-rc2
Signed-off-by: Keiichiro Tokunaga <tokunaga.keiich@jp.fujitsu.com>
Description:
Create unregister_node() to remove corresponding sysfs directory and files
from /sys/devices/system/node/.
---

 linux-2.6.9-rc2-092704-kei/drivers/base/node.c  |   21 +++++++++++++++++++--
 linux-2.6.9-rc2-092704-kei/include/linux/node.h |    4 +++-
 2 files changed, 22 insertions(+), 3 deletions(-)

diff -puN drivers/base/node.c~numa_hp_base drivers/base/node.c
--- linux-2.6.9-rc2-092704/drivers/base/node.c~numa_hp_base	2004-09-28 18:57:21.225343043 +0900
+++ linux-2.6.9-rc2-092704-kei/drivers/base/node.c	2004-09-28 18:57:21.228272741 +0900
@@ -117,7 +117,7 @@ static SYSDEV_ATTR(numastat, S_IRUGO, no
  *
  * Initialize and register the node device.
  */
-int __init register_node(struct node *node, int num, struct node *parent)
+int __devinit register_node(struct node *node, int num, struct node *parent)
 {
 	int error;
 
@@ -133,9 +133,26 @@ int __init register_node(struct node *no
 	return error;
 }
 
+#ifdef CONFIG_HOTPLUG
+void __devexit unregister_node(struct node *node, struct node *parent)
+{
+	if (node == NULL) {
+		printk("unregister_node: node is null.");
+		return;
+	}
+	sysdev_remove_file(&node->sysdev, &attr_cpumap);
+	sysdev_remove_file(&node->sysdev, &attr_meminfo);
+	sysdev_remove_file(&node->sysdev, &attr_numastat);
+	sysdev_unregister(&node->sysdev);
+}
+#endif /* CONFIG_HOTPLUG */
 
-int __init register_node_type(void)
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
--- linux-2.6.9-rc2-092704/include/linux/node.h~numa_hp_base	2004-09-28 18:57:21.226319609 +0900
+++ linux-2.6.9-rc2-092704-kei/include/linux/node.h	2004-09-28 18:57:21.228272741 +0900
@@ -21,12 +21,14 @@
 
 #include <linux/sysdev.h>
 #include <linux/cpumask.h>
+#include <linux/module.h>
 
 struct node {
 	struct sys_device	sysdev;
 };
 
-extern int register_node(struct node *, int, struct node *);
+extern int __devinit register_node(struct node *, int, struct node *);
+extern void __devexit unregister_node(struct node *node, struct node *parent);
 
 #define to_node(sys_device) container_of(sys_device, struct node, sysdev)
 

_
