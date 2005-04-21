Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261424AbVDUPb4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261424AbVDUPb4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Apr 2005 11:31:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261442AbVDUPb4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Apr 2005 11:31:56 -0400
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:14214 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S261424AbVDUPau (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Apr 2005 11:30:50 -0400
Date: Fri, 22 Apr 2005 00:30:09 +0900
From: Keiichiro Tokunaga <tokunaga.keiich@jp.fujitsu.com>
Subject: Re: [RFC/PATCH] unregister_node() for hotplug use
In-reply-to: <20050420173235.GA17775@kroah.com>
To: Greg KH <gregkh@suse.de>
Cc: tokunaga.keiich@jp.fujitsu.com, linux-kernel@vger.kernel.org,
       akpm@osdl.org
Message-id: <20050422003009.1b96f09c.tokunaga.keiich@jp.fujitsu.com>
Organization: FUJITSU LIMITED
MIME-version: 1.0
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
References: <20050420210744.4013b3f8.tokunaga.keiich@jp.fujitsu.com>
 <20050420173235.GA17775@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Apr 2005 10:32:35 -0700 Greg KH wrote:
> On Wed, Apr 20, 2005 at 09:07:44PM +0900, Keiichiro Tokunaga wrote:
> >   This is to add a generic function 'unregister_node()'.
> > It is used to remove objects of a node going away for
> > hotplug.  If CONFIG_HOTPLUG=y, it becomes available.
> > This is against 2.6.12-rc2-mm3.
> 
> Please CC: this kind of stuff to the driver core maintainer, otherwise
> it can get dropped...

  I will for sure CC appropriate maintainers next time...

> Anyway, comments below:
> 
> > diff -puN drivers/base/node.c~numa_hp_base drivers/base/node.c
> > --- linux-2.6.12-rc2-mm3/drivers/base/node.c~numa_hp_base	2005-04-14 20:49:37.000000000 +0900
> > +++ linux-2.6.12-rc2-mm3-kei/drivers/base/node.c	2005-04-14 20:49:37.000000000 +0900
> > @@ -136,7 +136,7 @@ static SYSDEV_ATTR(distance, S_IRUGO, no
> >   *
> >   * Initialize and register the node device.
> >   */
> > -int __init register_node(struct node *node, int num, struct node *parent)
> > +int __devinit register_node(struct node *node, int num, struct node *parent)
> >  {
> >  	int error;
> >  
> > @@ -145,6 +145,9 @@ int __init register_node(struct node *no
> >  	error = sysdev_register(&node->sysdev);
> >  
> >  	if (!error){
> > +		/*
> > +		 * If you add new object here, delete it when unregistering.
> > +		 */
> 
> Comment really isn't needed.

  I removed the comments.

> > +/*
> > + * unregister_node - Remove objects of a node going away from sysfs.
> > + * @node - node going away
> > + *
> > + * This is used only for hotplug.
> > + */
> 
> If you are going to create function comments, at least use the proper
> kerneldoc format.

  I removed it.  I thought about its necessity again and
it seems that the comments isn't really necessary because
the purpose of the function is obvious anyway.

> > +#ifdef CONFIG_HOTPLUG
> 
> You don't provide function prototype for when CONFIG_HOTPLUG is not
> enabled.
>
> > +void unregister_node(struct node *node)
> > +{
> > +	if (node == NULL)
> > +		return;
> 
> How can this happen?

  It's a redundant check, so I removed it.

> > +
> > +	sysdev_remove_file(&node->sysdev, &attr_cpumap);
> > +	sysdev_remove_file(&node->sysdev, &attr_meminfo);
> > +	sysdev_remove_file(&node->sysdev, &attr_numastat);
> > +	sysdev_remove_file(&node->sysdev, &attr_distance);
> > +
> > +	sysdev_unregister(&node->sysdev);
> > +}
> > +EXPORT_SYMBOL(register_node);
> > +EXPORT_SYMBOL(unregister_node);
> 
> All of sysfs and the driver core are EXPORT_SYMBOL_GPL().  Please follow
> that convention.

  OK, I made that change.

> > +#endif /* CONFIG_HOTPLUG */
> >  
> > -int __init register_node_type(void)
> > +static int __init register_node_type(void)
> 
> Are you sure no one calls this?

  Yes, no one calls this today.

> >  {
> >  	return sysdev_class_register(&node_class);
> >  }
> > diff -puN include/linux/node.h~numa_hp_base include/linux/node.h
> > --- linux-2.6.12-rc2-mm3/include/linux/node.h~numa_hp_base	2005-04-14 20:49:37.000000000 +0900
> > +++ linux-2.6.12-rc2-mm3-kei/include/linux/node.h	2005-04-14 20:49:37.000000000 +0900
> > @@ -21,12 +21,16 @@
> >  
> >  #include <linux/sysdev.h>
> >  #include <linux/cpumask.h>
> > +#include <linux/module.h>
> 
> Why?
> 
> >  
> >  struct node {
> >  	struct sys_device	sysdev;
> >  };
> >  
> > -extern int register_node(struct node *, int, struct node *);
> > +extern int __devinit register_node(struct node *, int, struct node *);
> 
> __devinit is not needed on a function prototype.
> 
> > +#ifdef CONFIG_HOTPLUG
> > +extern void unregister_node(struct node *node);
> > +#endif
> 
> Not needed for a function prototype.

  I corrected them.  Thanks for all the comments!
  I am attaching the updated patch.  Please take a look.

Thanks,
Keiichiro Tokunaga


Signed-off-by: Keiichiro Tokunaga <tokunaga.keiich@jp.fujitsu.com>
---

 linux-2.6.12-rc2-mm3-kei/drivers/base/node.c  |   21 +++++++++++++++++++--
 linux-2.6.12-rc2-mm3-kei/include/linux/node.h |    1 +
 2 files changed, 20 insertions(+), 2 deletions(-)

diff -puN drivers/base/node.c~numa_hp_base drivers/base/node.c
--- linux-2.6.12-rc2-mm3/drivers/base/node.c~numa_hp_base	2005-04-14 20:49:37.000000000 +0900
+++ linux-2.6.12-rc2-mm3-kei/drivers/base/node.c	2005-04-21 19:20:41.000000000 +0900
@@ -136,7 +136,7 @@ static SYSDEV_ATTR(distance, S_IRUGO, no
  *
  * Initialize and register the node device.
  */
-int __init register_node(struct node *node, int num, struct node *parent)
+int __devinit register_node(struct node *node, int num, struct node *parent)
 {
 	int error;
 
@@ -153,8 +153,25 @@ int __init register_node(struct node *no
 	return error;
 }
 
+#ifdef CONFIG_HOTPLUG
+void unregister_node(struct node *node)
+{
+	sysdev_remove_file(&node->sysdev, &attr_cpumap);
+	sysdev_remove_file(&node->sysdev, &attr_meminfo);
+	sysdev_remove_file(&node->sysdev, &attr_numastat);
+	sysdev_remove_file(&node->sysdev, &attr_distance);
+
+	sysdev_unregister(&node->sysdev);
+}
+EXPORT_SYMBOL_GPL(register_node);
+EXPORT_SYMBOL_GPL(unregister_node);
+#else /* !CONFIG_HOTPLUG */
+void unregister_node(struct node *node)
+{
+}
+#endif /* !CONFIG_HOTPLUG */
 
-int __init register_node_type(void)
+static int __init register_node_type(void)
 {
 	return sysdev_class_register(&node_class);
 }
diff -puN include/linux/node.h~numa_hp_base include/linux/node.h
--- linux-2.6.12-rc2-mm3/include/linux/node.h~numa_hp_base	2005-04-14 20:49:37.000000000 +0900
+++ linux-2.6.12-rc2-mm3-kei/include/linux/node.h	2005-04-21 13:48:58.000000000 +0900
@@ -27,6 +27,7 @@ struct node {
 };
 
 extern int register_node(struct node *, int, struct node *);
+extern void unregister_node(struct node *node);
 
 #define to_node(sys_device) container_of(sys_device, struct node, sysdev)
 

_
