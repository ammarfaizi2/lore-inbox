Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262857AbVEHM3o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262857AbVEHM3o (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 May 2005 08:29:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262858AbVEHM3o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 May 2005 08:29:44 -0400
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:54474 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S262857AbVEHM3d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 May 2005 08:29:33 -0400
Date: Sun, 08 May 2005 21:28:53 +0900
From: Keiichiro Tokunaga <tokunaga.keiich@jp.fujitsu.com>
Subject: Re: [RFC/PATCH] unregister_node() for hotplug use
In-reply-to: <20050508002648.GD3614@otto>
To: Nathan Lynch <ntl@pobox.com>, gregkh@suse.de
Cc: tokunaga.keiich@jp.fujitsu.com, linux-kernel@vger.kernel.org,
       akpm@osdl.org
Message-id: <20050508212853.1e71e8a5.tokunaga.keiich@jp.fujitsu.com>
Organization: FUJITSU LIMITED
MIME-version: 1.0
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
References: <20050420210744.4013b3f8.tokunaga.keiich@jp.fujitsu.com>
 <20050420173235.GA17775@kroah.com>
 <20050422003009.1b96f09c.tokunaga.keiich@jp.fujitsu.com>
 <20050422003920.GD6829@kroah.com>
 <20050422113211.509005f1.tokunaga.keiich@jp.fujitsu.com>
 <20050425230333.6b8dfb33.tokunaga.keiich@jp.fujitsu.com>
 <20050426065431.GB5889@suse.de>
 <20050507211141.4829d4c0.tokunaga.keiich@jp.fujitsu.com>
 <20050508002648.GD3614@otto>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 07 May 2005 19:26:48 -0500 Nathan Lynch wrote:
> > This adds a generic function 'unregister_node()'.
> > It is used to remove objects of a node going away
> > for hotplug.
> > 
> > Signed-off-by: Keiichiro Tokunaga <tokunaga.keiich@jp.fujitsu.com>
> > ---
> > 
> >  linux-2.6.12-rc3-mm3-kei/drivers/base/node.c  |   15 +++++++++++++--
> >  linux-2.6.12-rc3-mm3-kei/include/linux/node.h |    1 +
> >  2 files changed, 14 insertions(+), 2 deletions(-)
> > 
> > diff -puN drivers/base/node.c~numa_hp_base drivers/base/node.c
> > --- linux-2.6.12-rc3-mm3/drivers/base/node.c~numa_hp_base	2005-05-07 19:58:15.000000000 +0900
> > +++ linux-2.6.12-rc3-mm3-kei/drivers/base/node.c	2005-05-07 19:58:15.000000000 +0900
> > @@ -136,7 +136,7 @@ static SYSDEV_ATTR(distance, S_IRUGO, no
> >   *
> >   * Initialize and register the node device.
> >   */
> > -int __init register_node(struct node *node, int num, struct node *parent)
> > +int register_node(struct node *node, int num, struct node *parent)
> >  {
> >  	int error;
> >  
> > @@ -153,8 +153,19 @@ int __init register_node(struct node *no
> >  	return error;
> >  }
> >  
> > +void unregister_node(struct node *node)
> > +{
> > +	sysdev_remove_file(&node->sysdev, &attr_cpumap);
> > +	sysdev_remove_file(&node->sysdev, &attr_meminfo);
> > +	sysdev_remove_file(&node->sysdev, &attr_numastat);
> > +	sysdev_remove_file(&node->sysdev, &attr_distance);
> > +
> > +	sysdev_unregister(&node->sysdev);
> > +}
> 
> Is it a bug to call unregister_node() if there are still cpus or
> memory present in the node?  Note that register_cpu() creates a
> symlink under the node directory to the cpu -- are you assuming that
> all the node's cpu sysdevs will have been unregistered by the time
> unregister_node is called?  If so, is it possible to enforce that, or
> at least document it?

  Yes, this code is assuming that.  I will document it in
a function description of unregister_node().

> > +EXPORT_SYMBOL_GPL(register_node);
> > +EXPORT_SYMBOL_GPL(unregister_node);
> 
> What module code needs to call these?  ACPI?

  Nobody today.  I thought it was necessary for my another
patch to support node hotplug, but I found out it's not.
My mistake...  I will remove them.

  I'm attaching an updated patch.

Thanks,
Keiichiro Tokunaga



This adds a generic function 'unregister_node()'.
It is used to remove objects of a node going away
for hotplug.  All the devices on the node must be
unregistered before calling this function.

Signed-off-by: Keiichiro Tokunaga <tokunaga.keiich@jp.fujitsu.com>
---

 linux-2.6.12-rc3-mm3-kei/drivers/base/node.c  |   20 ++++++++++++++++++--
 linux-2.6.12-rc3-mm3-kei/include/linux/node.h |    1 +
 2 files changed, 19 insertions(+), 2 deletions(-)

diff -puN drivers/base/node.c~numa_hp_base drivers/base/node.c
--- linux-2.6.12-rc3-mm3/drivers/base/node.c~numa_hp_base	2005-05-07 19:58:15.000000000 +0900
+++ linux-2.6.12-rc3-mm3-kei/drivers/base/node.c	2005-05-08 20:27:32.000000000 +0900
@@ -136,7 +136,7 @@ static SYSDEV_ATTR(distance, S_IRUGO, no
  *
  * Initialize and register the node device.
  */
-int __init register_node(struct node *node, int num, struct node *parent)
+int register_node(struct node *node, int num, struct node *parent)
 {
 	int error;
 
@@ -153,8 +153,24 @@ int __init register_node(struct node *no
 	return error;
 }
 
+/**
+ * unregister_node - unregister a node device
+ * @node: node going away
+ *
+ * Unregisters a node device @node.  All the devices on the node must be
+ * unregistered before calling this function.
+ */
+void unregister_node(struct node *node)
+{
+	sysdev_remove_file(&node->sysdev, &attr_cpumap);
+	sysdev_remove_file(&node->sysdev, &attr_meminfo);
+	sysdev_remove_file(&node->sysdev, &attr_numastat);
+	sysdev_remove_file(&node->sysdev, &attr_distance);
+
+	sysdev_unregister(&node->sysdev);
+}
 
-int __init register_node_type(void)
+static int __init register_node_type(void)
 {
 	return sysdev_class_register(&node_class);
 }
diff -puN include/linux/node.h~numa_hp_base include/linux/node.h
--- linux-2.6.12-rc3-mm3/include/linux/node.h~numa_hp_base	2005-05-07 19:58:15.000000000 +0900
+++ linux-2.6.12-rc3-mm3-kei/include/linux/node.h	2005-05-07 19:58:15.000000000 +0900
@@ -27,6 +27,7 @@ struct node {
 };
 
 extern int register_node(struct node *, int, struct node *);
+extern void unregister_node(struct node *node);
 
 #define to_node(sys_device) container_of(sys_device, struct node, sysdev)
 

_
