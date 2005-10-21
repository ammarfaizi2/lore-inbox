Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751180AbVJUVfV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751180AbVJUVfV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Oct 2005 17:35:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751219AbVJUVfV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Oct 2005 17:35:21 -0400
Received: from p4-7036.uk2net.com ([213.232.95.37]:8591 "EHLO
	churchillrandoms.co.uk") by vger.kernel.org with ESMTP
	id S1751180AbVJUVfV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Oct 2005 17:35:21 -0400
Message-ID: <43595F26.9010308@churchillrandoms.co.uk>
Date: Fri, 21 Oct 2005 14:35:34 -0700
From: Stefan Jones <stefan.jones@churchillrandoms.co.uk>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051003)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: [BUG][2.6.13.4] Memoryleak - idr_layer_cache slab - inotify?
References: <43593240.9020806@churchillrandoms.co.uk>	<43594CD6.3020308@churchillrandoms.co.uk> <20051021134843.497921fd.akpm@osdl.org>
In-Reply-To: <20051021134843.497921fd.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

>Something like this?
>
>  
>
Yep, that fixes it. The  idr_layer_cache slab is now stable. Thanks

>diff -puN lib/idr.c~inotify-idr-leak-fix lib/idr.c
>--- 25/lib/idr.c~inotify-idr-leak-fix	Fri Oct 21 13:44:23 2005
>+++ 25-akpm/lib/idr.c	Fri Oct 21 13:46:09 2005
>@@ -346,6 +346,19 @@ void idr_remove(struct idr *idp, int id)
> EXPORT_SYMBOL(idr_remove);
> 
> /**
>+ * idr_destroy - release all cached layers within an idr tree
>+ * idp: idr handle
>+ */
>+void idr_destroy(struct idr *idp)
>+{
>+	while (idp->id_free_cnt) {
>+		struct idr_layer *p = alloc_layer(idp);
>+		kmem_cache_free(idr_layer_cache, p);
>+	}
>+}
>+EXPORT_SYMBOL(idr_destroy);
>+
>+/**
>  * idr_find - return pointer for given id
>  * @idp: idr handle
>  * @id: lookup key
>diff -puN include/linux/idr.h~inotify-idr-leak-fix include/linux/idr.h
>--- 25/include/linux/idr.h~inotify-idr-leak-fix	Fri Oct 21 13:44:23 2005
>+++ 25-akpm/include/linux/idr.h	Fri Oct 21 13:46:19 2005
>@@ -75,4 +75,5 @@ int idr_pre_get(struct idr *idp, unsigne
> int idr_get_new(struct idr *idp, void *ptr, int *id);
> int idr_get_new_above(struct idr *idp, void *ptr, int starting_id, int *id);
> void idr_remove(struct idr *idp, int id);
>+void idr_destroy(struct idr *idp);
> void idr_init(struct idr *idp);
>diff -puN fs/inotify.c~inotify-idr-leak-fix fs/inotify.c
>--- 25/fs/inotify.c~inotify-idr-leak-fix	Fri Oct 21 13:47:27 2005
>+++ 25-akpm/fs/inotify.c	Fri Oct 21 13:47:38 2005
>@@ -176,6 +176,7 @@ static inline void put_inotify_dev(struc
> 	if (atomic_dec_and_test(&dev->count)) {
> 		atomic_dec(&dev->user->inotify_devs);
> 		free_uid(dev->user);
>+		idr_destroy(&dev->idr);
> 		kfree(dev);
> 	}
> }
>_
>
>
>  
>

