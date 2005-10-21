Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965133AbVJUUsf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965133AbVJUUsf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Oct 2005 16:48:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965162AbVJUUsf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Oct 2005 16:48:35 -0400
Received: from smtp.osdl.org ([65.172.181.4]:7827 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965133AbVJUUse (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Oct 2005 16:48:34 -0400
Date: Fri, 21 Oct 2005 13:48:43 -0700
From: Andrew Morton <akpm@osdl.org>
To: Stefan Jones <stefan.jones@churchillrandoms.co.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [BUG][2.6.13.4] Memoryleak - idr_layer_cache slab - inotify?
Message-Id: <20051021134843.497921fd.akpm@osdl.org>
In-Reply-To: <43594CD6.3020308@churchillrandoms.co.uk>
References: <43593240.9020806@churchillrandoms.co.uk>
	<43594CD6.3020308@churchillrandoms.co.uk>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stefan Jones <stefan.jones@churchillrandoms.co.uk> wrote:
>
> Stefan Jones wrote:
> 
> Made a standalone testcase, run this and the kernel will eat up your
> memory (seen via slabtop):
> 
> [ creates a inotify_dev, and a watch and exits ; repeat via fork ... ]
> 
> Tracked it down me thinks:
> 
> struct inotify_device {
> ...
> 	struct idr		idr;		/* idr mapping wd -> watch */
> ...
> }
> 
> idr gets allocated each time inotify_init() is called:
> 
> asmlinkage long sys_inotify_init(void)
> {
> ..
> idr_init(&dev->idr);
> ..
> }
> 
> Looking in lib/idr.c you see:
> 
>   * You can release ids at any time. When all ids are released, most of
>   * the memory is returned (we keep IDR_FREE_MAX) in a local pool so we
>   * don't need to go to the memory "store" during an id allocate, just
>   * so you don't need to be too concerned about locking and conflicts
>   * with the slab allocator.
> 
> So even if you free all ids which create_watch->inotify_dev_get_wd 
> creates you will still have menory in your struct idr.
> 
> So when
> static inline void put_inotify_dev(struct inotify_device *dev)
> {
> 	if (atomic_dec_and_test(&dev->count)) {
> 		atomic_dec(&dev->user->inotify_devs);
> 		free_uid(dev->user);
> 		kfree(dev);
> 	}
> }
> 
> is called I think this is whre the memory gets lost. ( linux/idr.h has 
> not free function I see )
> 

That makes sense, thanks.

Something like this?


diff -puN lib/idr.c~inotify-idr-leak-fix lib/idr.c
--- 25/lib/idr.c~inotify-idr-leak-fix	Fri Oct 21 13:44:23 2005
+++ 25-akpm/lib/idr.c	Fri Oct 21 13:46:09 2005
@@ -346,6 +346,19 @@ void idr_remove(struct idr *idp, int id)
 EXPORT_SYMBOL(idr_remove);
 
 /**
+ * idr_destroy - release all cached layers within an idr tree
+ * idp: idr handle
+ */
+void idr_destroy(struct idr *idp)
+{
+	while (idp->id_free_cnt) {
+		struct idr_layer *p = alloc_layer(idp);
+		kmem_cache_free(idr_layer_cache, p);
+	}
+}
+EXPORT_SYMBOL(idr_destroy);
+
+/**
  * idr_find - return pointer for given id
  * @idp: idr handle
  * @id: lookup key
diff -puN include/linux/idr.h~inotify-idr-leak-fix include/linux/idr.h
--- 25/include/linux/idr.h~inotify-idr-leak-fix	Fri Oct 21 13:44:23 2005
+++ 25-akpm/include/linux/idr.h	Fri Oct 21 13:46:19 2005
@@ -75,4 +75,5 @@ int idr_pre_get(struct idr *idp, unsigne
 int idr_get_new(struct idr *idp, void *ptr, int *id);
 int idr_get_new_above(struct idr *idp, void *ptr, int starting_id, int *id);
 void idr_remove(struct idr *idp, int id);
+void idr_destroy(struct idr *idp);
 void idr_init(struct idr *idp);
diff -puN fs/inotify.c~inotify-idr-leak-fix fs/inotify.c
--- 25/fs/inotify.c~inotify-idr-leak-fix	Fri Oct 21 13:47:27 2005
+++ 25-akpm/fs/inotify.c	Fri Oct 21 13:47:38 2005
@@ -176,6 +176,7 @@ static inline void put_inotify_dev(struc
 	if (atomic_dec_and_test(&dev->count)) {
 		atomic_dec(&dev->user->inotify_devs);
 		free_uid(dev->user);
+		idr_destroy(&dev->idr);
 		kfree(dev);
 	}
 }
_

