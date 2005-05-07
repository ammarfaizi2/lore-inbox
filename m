Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263060AbVEGMMe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263060AbVEGMMe (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 May 2005 08:12:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263062AbVEGMMd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 May 2005 08:12:33 -0400
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:40366 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S263060AbVEGMMW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 May 2005 08:12:22 -0400
Date: Sat, 07 May 2005 21:11:41 +0900
From: Keiichiro Tokunaga <tokunaga.keiich@jp.fujitsu.com>
Subject: Re: [RFC/PATCH] unregister_node() for hotplug use
In-reply-to: <20050426065431.GB5889@suse.de>
To: Greg KH <gregkh@suse.de>
Cc: tokunaga.keiich@jp.fujitsu.com, linux-kernel@vger.kernel.org,
       akpm@osdl.org
Message-id: <20050507211141.4829d4c0.tokunaga.keiich@jp.fujitsu.com>
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
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Apr 2005 23:54:32 -0700 Greg KH wrote:
> On Mon, Apr 25, 2005 at 11:03:33PM +0900, Keiichiro Tokunaga wrote:
> > On Fri, 22 Apr 2005 11:32:11 +0900 Keiichiro Tokunaga wrote:
> > > On Thu, 21 Apr 2005 17:39:20 -0700 Greg KH wrote:
> > > > On Fri, Apr 22, 2005 at 12:30:09AM +0900, Keiichiro Tokunaga wrote:
> > > > > +#ifdef CONFIG_HOTPLUG
> > > > > +void unregister_node(struct node *node)
> > > > > +{
> > > > > +	sysdev_remove_file(&node->sysdev, &attr_cpumap);
> > > > > +	sysdev_remove_file(&node->sysdev, &attr_meminfo);
> > > > > +	sysdev_remove_file(&node->sysdev, &attr_numastat);
> > > > > +	sysdev_remove_file(&node->sysdev, &attr_distance);
> > > > > +
> > > > > +	sysdev_unregister(&node->sysdev);
> > > > > +}
> > > > > +EXPORT_SYMBOL_GPL(register_node);
> > > > > +EXPORT_SYMBOL_GPL(unregister_node);
> > > > > +#else /* !CONFIG_HOTPLUG */
> > > > > +void unregister_node(struct node *node)
> > > > > +{
> > > > > +}
> > > > > +#endif /* !CONFIG_HOTPLUG */
> > <snip>
> > > > And hey, what's the real big deal here, why not always have this
> > > > function no matter if CONFIG_HOTPLUG is enabled or not?  I really want
> > > > to just make that an option that is always enabled anyway, but changable
> > > > if you are using CONFIG_TINY or something...
> > > 
> > >   I put the #ifdef there for users who don't need hotplug
> > > stuffs, but I want to make the option always enabled, too.
> > > Also a good side effect, the code would be cleaner:)  I
> > > will be updating my patch without the #ifdef and sending
> > > it here.
> > 
> >   Here is the patch.  Please apply.
> 
> Care to resend it with a proper change log description that I can use?

  I updated the patch for 2.6.12-rc3-mm3 based on my
previous comments.  Please apply.

Thanks,
Keiichiro Tokunaga



This adds a generic function 'unregister_node()'.
It is used to remove objects of a node going away
for hotplug.

Signed-off-by: Keiichiro Tokunaga <tokunaga.keiich@jp.fujitsu.com>
---

 linux-2.6.12-rc3-mm3-kei/drivers/base/node.c  |   15 +++++++++++++--
 linux-2.6.12-rc3-mm3-kei/include/linux/node.h |    1 +
 2 files changed, 14 insertions(+), 2 deletions(-)

diff -puN drivers/base/node.c~numa_hp_base drivers/base/node.c
--- linux-2.6.12-rc3-mm3/drivers/base/node.c~numa_hp_base	2005-05-07 19:58:15.000000000 +0900
+++ linux-2.6.12-rc3-mm3-kei/drivers/base/node.c	2005-05-07 19:58:15.000000000 +0900
@@ -136,7 +136,7 @@ static SYSDEV_ATTR(distance, S_IRUGO, no
  *
  * Initialize and register the node device.
  */
-int __init register_node(struct node *node, int num, struct node *parent)
+int register_node(struct node *node, int num, struct node *parent)
 {
 	int error;
 
@@ -153,8 +153,19 @@ int __init register_node(struct node *no
 	return error;
 }
 
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
