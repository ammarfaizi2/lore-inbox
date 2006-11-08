Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423796AbWKHVjJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423796AbWKHVjJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 16:39:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423794AbWKHVjJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 16:39:09 -0500
Received: from smtp.osdl.org ([65.172.181.4]:16261 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1423797AbWKHVjH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 16:39:07 -0500
Date: Wed, 8 Nov 2006 13:38:59 -0800
From: Andrew Morton <akpm@osdl.org>
To: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
       LHMS <lhms-devel@lists.sourceforge.net>
Subject: Re: [PATHC] [2.6.19-rc4-mm2] driver/base/memory.c :: remove
 warnings of sysfs_create_file()
Message-Id: <20061108133859.cdaa8127.akpm@osdl.org>
In-Reply-To: <20061108155921.62f9a68f.kamezawa.hiroyu@jp.fujitsu.com>
References: <20061108155921.62f9a68f.kamezawa.hiroyu@jp.fujitsu.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 Nov 2006 15:59:21 +0900
KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com> wrote:

> I got following messages at compile time.
> ==
> drivers/base/memory.c: In function `memory_dev_init':
> drivers/base/memory.c:293: warning: ignoring return value of `sysfs_create_file'
> , declared with attribute warn_unused_result
> ==
> 
> This patch adds tests for returned value from sysfs_create_file().
> This patch just prints warning if failed.
> 
> Signed-Off-By: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
> 
> Index: linux-2.6.19-rc4-mm2/drivers/base/memory.c
> ===================================================================
> --- linux-2.6.19-rc4-mm2.orig/drivers/base/memory.c	2006-11-08 15:15:59.000000000 +0900
> +++ linux-2.6.19-rc4-mm2/drivers/base/memory.c	2006-11-08 15:26:52.000000000 +0900
> @@ -290,8 +290,14 @@
>  
>  static int block_size_init(void)
>  {
> -	sysfs_create_file(&memory_sysdev_class.kset.kobj,
> -		&class_attr_block_size_bytes.attr);
> +	int ret;
> +	ret = sysfs_create_file(&memory_sysdev_class.kset.kobj,
> +				&class_attr_block_size_bytes.attr);
> +	if (ret < 0) {
> +		/* We failed to init memory-hotplug infrastructure.
> +		   But don't panic here */
> +		printk(KERN_WARNING "cannot create memory hotplug interface\n");
> +	}
>  	return 0;
>  }
>  
> @@ -323,8 +329,14 @@
>  
>  static int memory_probe_init(void)
>  {
> -	sysfs_create_file(&memory_sysdev_class.kset.kobj,
> +	int ret;
> +	ret = sysfs_create_file(&memory_sysdev_class.kset.kobj,
>  		&class_attr_probe.attr);
> +	if (ret < 0) {
> +		/* we failed to init memory hotplug infrastructure.
> +		   But don't panic here */
> +		printk(KERN_WARNING "cannot create memory hotplug interface\n");
> +	}
>  	return 0;
>  }
>  #else

I think the below is better?

From: Andrew Morton <akpm@osdl.org>

Do proper error-checking and propagation in drivers/base/memory.c, hence fix
__must_check warnings.

Cc: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 drivers/base/memory.c |   34 +++++++++++++++++++++++-----------
 1 files changed, 23 insertions(+), 11 deletions(-)

diff -puN drivers/base/memory.c~driver-base-memoryc-remove-warnings-of drivers/base/memory.c
--- a/drivers/base/memory.c~driver-base-memoryc-remove-warnings-of
+++ a/drivers/base/memory.c
@@ -290,9 +290,8 @@ static CLASS_ATTR(block_size_bytes, 0444
 
 static int block_size_init(void)
 {
-	sysfs_create_file(&memory_sysdev_class.kset.kobj,
-		&class_attr_block_size_bytes.attr);
-	return 0;
+	return sysfs_create_file(&memory_sysdev_class.kset.kobj,
+				&class_attr_block_size_bytes.attr);
 }
 
 /*
@@ -323,12 +322,14 @@ static CLASS_ATTR(probe, 0700, NULL, mem
 
 static int memory_probe_init(void)
 {
-	sysfs_create_file(&memory_sysdev_class.kset.kobj,
-		&class_attr_probe.attr);
-	return 0;
+	return sysfs_create_file(&memory_sysdev_class.kset.kobj,
+				&class_attr_probe.attr);
 }
 #else
-#define memory_probe_init(...)	do {} while (0)
+static inline int memory_probe_init(void)
+{
+	return 0;
+}
 #endif
 
 /*
@@ -431,9 +432,12 @@ int __init memory_dev_init(void)
 {
 	unsigned int i;
 	int ret;
+	int err;
 
 	memory_sysdev_class.kset.uevent_ops = &memory_uevent_ops;
 	ret = sysdev_class_register(&memory_sysdev_class);
+	if (ret)
+		goto out;
 
 	/*
 	 * Create entries for memory sections that were found
@@ -442,11 +446,19 @@ int __init memory_dev_init(void)
 	for (i = 0; i < NR_MEM_SECTIONS; i++) {
 		if (!valid_section_nr(i))
 			continue;
-		add_memory_block(0, __nr_to_section(i), MEM_ONLINE, 0);
+		err = add_memory_block(0, __nr_to_section(i), MEM_ONLINE, 0);
+		if (!ret)
+			ret = err;
 	}
 
-	memory_probe_init();
-	block_size_init();
-
+	err = memory_probe_init();
+	if (!ret)
+		ret = err;
+	err = block_size_init();
+	if (!ret)
+		ret = err;
+out:
+	if (ret)
+		printk(KERN_ERR "%s() failed: %d\n", __FUNCTION__, ret);
 	return ret;
 }
_

