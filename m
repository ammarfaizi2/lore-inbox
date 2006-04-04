Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750746AbWDDQiz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750746AbWDDQiz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Apr 2006 12:38:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750751AbWDDQiz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Apr 2006 12:38:55 -0400
Received: from relay.2ka.mipt.ru ([194.85.82.65]:14240 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S1750746AbWDDQiy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Apr 2006 12:38:54 -0400
Date: Tue, 4 Apr 2006 20:35:22 +0400
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, Greg Kroah-Hartman <gregkh@suse.de>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.17-mm1: drivers/w1/: patch undoes reasonable cleanups
Message-ID: <20060404163522.GA29486@2ka.mipt.ru>
References: <20060404014504.564bf45a.akpm@osdl.org> <20060404160223.GG6529@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <20060404160223.GG6529@stusta.de>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Tue, 04 Apr 2006 20:35:23 +0400 (MSD)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 04, 2006 at 06:02:23PM +0200, Adrian Bunk (bunk@stusta.de) wrote:
> On Tue, Apr 04, 2006 at 01:45:04AM -0700, Andrew Morton wrote:
> >...
> > Changes since 2.6.16-mm2:
> >...
> > +gregkh-i2c-w1-userspace-communication-protocol-over-connector.patch
> >...
> >  I2C tree.
> >...
> 
> Evgeniy Polyakov did ACK my patch 
> a9fb1c7b950bed4afe208c9d67e20f086bb6abbb, and I'm therefore really 
> pissed off seeing him silently reverting it for no good reason as part 
> of this patch.
> 
> Greg, please drop this patch.

I'm really sorry, Adrian, if you feel it this way.
I converted your patch to the new tree.

Peace? :)

----
Nice cleanup spotted by Adrian Bunk, which was lost due to moving to the
completely new functionality.
		Shame-shame-shame on me.

Signed-off-by: Evgeniy Polyakov <johnpol@2ka.mipt.ru>

diff --git a/drivers/w1/w1.c b/drivers/w1/w1.c
index 6c23b38..174ac2b 100644
--- a/drivers/w1/w1.c
+++ b/drivers/w1/w1.c
@@ -214,11 +214,12 @@ struct device w1_master_device = {
 	.release = &w1_master_release
 };
 
-struct device_driver w1_slave_driver = {
+static struct device_driver w1_slave_driver = {
 	.name = "w1_slave_driver",
 	.bus = &w1_bus_type,
 };
 
+#if 0
 struct device w1_slave_device = {
 	.parent = NULL,
 	.bus = &w1_bus_type,
@@ -226,6 +227,7 @@ struct device w1_slave_device = {
 	.driver = &w1_slave_driver,
 	.release = &w1_slave_release
 };
+#endif  /*  0  */
 
 static ssize_t w1_master_attribute_show_name(struct device *dev, struct device_attribute *attr, char *buf)
 {
@@ -383,7 +385,7 @@ int w1_create_master_attributes(struct w
 	return sysfs_create_group(&master->dev.kobj, &w1_master_defattr_group);
 }
 
-void w1_destroy_master_attributes(struct w1_master *master)
+static void w1_destroy_master_attributes(struct w1_master *master)
 {
 	sysfs_remove_group(&master->dev.kobj, &w1_master_defattr_group);
 }
diff --git a/drivers/w1/w1.h b/drivers/w1/w1.h
index f5ad81d..deb3c13 100644
--- a/drivers/w1/w1.h
+++ b/drivers/w1/w1.h
@@ -213,6 +213,16 @@ static inline struct w1_master* dev_to_w
 	return container_of(dev, struct w1_master, dev);
 }
 
+extern struct device_driver w1_master_driver;
+extern struct bus_type w1_bus_type;
+extern struct device w1_master_device;
+extern int w1_max_slave_count;
+extern int w1_max_slave_ttl;
+extern struct list_head w1_masters;
+extern struct mutex w1_mlock;
+
+extern int w1_process(void *);
+
 #endif /* __KERNEL__ */
 
 #endif /* __W1_H */
diff --git a/drivers/w1/w1_int.c b/drivers/w1/w1_int.c
index 24e7c10..475996c 100644
--- a/drivers/w1/w1_int.c
+++ b/drivers/w1/w1_int.c
@@ -30,16 +30,6 @@
 
 static u32 w1_ids = 1;
 
-extern struct device_driver w1_master_driver;
-extern struct bus_type w1_bus_type;
-extern struct device w1_master_device;
-extern int w1_max_slave_count;
-extern int w1_max_slave_ttl;
-extern struct list_head w1_masters;
-extern struct mutex w1_mlock;
-
-extern int w1_process(void *);
-
 static struct w1_master * w1_alloc_dev(u32 id, int slave_count, int slave_ttl,
 				       struct device_driver *driver,
 				       struct device *device)
@@ -96,7 +86,7 @@ static struct w1_master * w1_alloc_dev(u
 	return dev;
 }
 
-void w1_free_dev(struct w1_master *dev)
+static void w1_free_dev(struct w1_master *dev)
 {
 	device_unregister(&dev->dev);
 }

> cu
> Adrian

-- 
	Evgeniy Polyakov
