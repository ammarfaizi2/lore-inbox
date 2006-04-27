Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964982AbWD0IkX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964982AbWD0IkX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 04:40:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964984AbWD0IkX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 04:40:23 -0400
Received: from taurus.voltaire.com ([193.47.165.240]:47814 "EHLO
	taurus.voltaire.com") by vger.kernel.org with ESMTP id S964982AbWD0IkW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 04:40:22 -0400
Date: Thu, 27 Apr 2006 11:40:20 +0300 (IDT)
From: Or Gerlitz <ogerlitz@voltaire.com>
X-X-Sender: ogerlitz@zuben
To: linux-kernel@vger.kernel.org
cc: openib-general@openib.org, <open-iscsi@googlegroups.com>
Subject: possible bug in kmem_cache related code
Message-ID: <Pine.LNX.4.44.0604271138370.16357-101000@zuben>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="430728193-73137820-1146127220=:16363"
X-OriginalArrivalTime: 27 Apr 2006 08:40:20.0441 (UTC) FILETIME=[37A97C90:01C669D6]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--430728193-73137820-1146127220=:16363
Content-Type: TEXT/PLAIN; charset=US-ASCII

With 2.6.17-rc3 I'm running into something which seems as a bug related 
to kmem_cache. Doing some allocations/deallocations from a kmem_cache and 
later attempting to destroy it yields the following message and trace

============================================================================
slab error in kmem_cache_destroy(): cache `my_cache': Can't free all objects

Call Trace: <ffffffff8106e46b>{kmem_cache_destroy+150}
       <ffffffff88204033>{:my_kcache:kcache_cleanup_module+51}
       <ffffffff81044cd3>{sys_delete_module+415} <ffffffff8112fb5b>{__up_write+20}
       <ffffffff8105d42b>{sys_munmap+91} <ffffffff8100966a>{system_call+126}

Failed to destroy cache
============================================================================

I was hitting it as an Infiniband/iSCSI user as IB/iSCSI/SCSI code use 
kmem_caches, but since the failure happens on a code which works fine on 
2.6.16 i have decided to try it with a synthetic module and had this hit...

Below is a sample code that reproduces it, if i only do kmem_cache_create 
and later destroy it does not happen, attached is my .config please note
that some of the CONFIG_DEBUG_ options are open.

Please CC openib-general@openib.org at least with the resolution of the 
matter since it kind of hard to do testing over 2.6.17-rcX with this 
issue, the tests run fine but some modules are crashing on rmmod so a
reboot it needed...

thanks,

Or.

This is the related slab info line once the module is loaded

my_cache  256    264    328   12    1 : tunables   32   16    8 
: slabdata     22     22      0 : globalstat     264    264    22    0

--- /deb/null	1970-01-01 02:00:00.000000000 +0200
+++ kcache/kcache.c	2006-04-27 10:43:18.000000000 +0300
@@ -0,0 +1,61 @@
+#include <linux/module.h>
+#include <linux/slab.h>
+
+kmem_cache_t *cache;
+
+struct foo {
+	char bar[300];
+};
+
+
+#define TRIES 256
+
+struct foo *foo_arr[TRIES];
+
+static int __init kcache_init_module(void)
+{
+	int i, j;
+
+	cache = kmem_cache_create("my_cache",
+				  sizeof (struct foo),
+				  0,
+				  SLAB_HWCACHE_ALIGN,
+				  NULL,
+				  NULL);
+	if (!cache) {
+		printk(KERN_ERR "couldn't create cache\n");
+		goto error1;
+	}
+
+	for (i = 0; i < TRIES; i++) {
+		foo_arr[i] = kmem_cache_alloc(cache, GFP_KERNEL);
+		if (foo_arr[i] == NULL) {
+			printk(KERN_ERR "couldn't allocate from cache\n");
+			goto error2;
+		}
+	}
+
+	return 0;
+error2:
+	for (j = 0; j < i; j++)
+		kmem_cache_free(cache, foo_arr[j]);
+error1:
+	return -ENOMEM;
+}
+
+static void __exit kcache_cleanup_module(void)
+{
+	int i;
+
+	for (i = 0; i < TRIES; i++)
+		kmem_cache_free(cache, foo_arr[i]);
+
+	if (kmem_cache_destroy(cache)) {
+		printk(KERN_DEBUG "Failed to destroy cache\n");
+	}
+}
+
+MODULE_LICENSE("GPL");
+
+module_init(kcache_init_module);
+module_exit(kcache_cleanup_module);



--430728193-73137820-1146127220=:16363
Content-Type: APPLICATION/x-bzip2; name="kmem-cache-config.bz2"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.44.0604271140200.16363@zuben>
Content-Description: 
Content-Disposition: attachment; filename="kmem-cache-config.bz2"

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
--430728193-73137820-1146127220=:16363--
