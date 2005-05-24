Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262164AbVEXQjO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262164AbVEXQjO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 May 2005 12:39:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262163AbVEXQjG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 May 2005 12:39:06 -0400
Received: from wproxy.gmail.com ([64.233.184.204]:22993 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262165AbVEXQff (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 May 2005 12:35:35 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:cc:user-agent:content-type:references:in-reply-to:subject:message-id:date;
        b=LZyoBtEB91mck3my1YlzfE9e05Flr2GrmwFwHH7UgoFg1yL5V3NY7AkZTrR1D/9b/HXRpCLtZWgZCmOCJ7OXRylFogQqnS7bHbV/kkCWn8lfhQ7KS7BeqeBHoVDihe3v4nMUVjVublztIUolCvf+cZUrslktgnCld3KcidqY0u8=
From: Tejun Heo <htejun@gmail.com>
To: axboe@suse.de
Cc: linux-kernel@vger.kernel.org
User-Agent: lksp 0.3
Content-Type: text/plain; charset=US-ASCII
References: <20050524163518.0DA61D6C@htj.dyndns.org>
In-Reply-To: <20050524163518.0DA61D6C@htj.dyndns.org>
Subject: Re: [PATCH Linux 2.6.12-rc4-mm2 02/03] cfq: cfq_io_context leak fix
Message-ID: <20050524163518.233BF525@htj.dyndns.org>
Date: Wed, 25 May 2005 01:35:29 +0900 (KST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

02_cfq_ioc_leak_fix.patch

	When a process has more than one cic's associated with it,
	only the first one was kmem_cache_free'd in the original code.
	This patch frees all cic's in cfq_free_io_context().

	While at it, remove unnecessary refcounting from cic's to ioc.
	This reference is created when each cic is created and removed
	altogether when the ioc is exited, and, thus, serves no
	purpose.

Signed-off-by: Tejun Heo <htejun@gmail.com>

 cfq-iosched.c |   19 ++++++++++---------
 1 files changed, 10 insertions(+), 9 deletions(-)

Index: blk-fixes/drivers/block/cfq-iosched.c
===================================================================
--- blk-fixes.orig/drivers/block/cfq-iosched.c	2005-05-25 01:35:16.000000000 +0900
+++ blk-fixes/drivers/block/cfq-iosched.c	2005-05-25 01:35:16.000000000 +0900
@@ -1238,6 +1238,14 @@ cfq_find_cfq_hash(struct cfq_data *cfqd,
 
 static void cfq_free_io_context(struct cfq_io_context *cic)
 {
+	struct cfq_io_context *__cic;
+	struct list_head *entry, *next;
+
+	list_for_each_safe(entry, next, &cic->list) {
+		__cic = list_entry(entry, struct cfq_io_context, list);
+		kmem_cache_free(cfq_ioc_pool, __cic);
+	}
+
 	kmem_cache_free(cfq_ioc_pool, cic);
 }
 
@@ -1260,7 +1268,6 @@ static void cfq_exit_single_io_context(s
 
 	cfq_put_queue(cic->cfqq);
 	cic->cfqq = NULL;
-	put_io_context(cic->ioc);
 	spin_unlock(q->queue_lock);
 }
 
@@ -1271,7 +1278,7 @@ static void cfq_exit_single_io_context(s
 static void cfq_exit_io_context(struct cfq_io_context *cic)
 {
 	struct cfq_io_context *__cic;
-	struct list_head *entry, *nxt;
+	struct list_head *entry;
 	unsigned long flags;
 
 	local_irq_save(flags);
@@ -1279,10 +1286,8 @@ static void cfq_exit_io_context(struct c
 	/*
 	 * put the reference this task is holding to the various queues
 	 */
-	list_for_each_safe(entry, nxt, &cic->list) {
+	list_for_each(entry, &cic->list) {
 		__cic = list_entry(entry, struct cfq_io_context, list);
-
-		list_del(&__cic->list);
 		cfq_exit_single_io_context(__cic);
 	}
 
@@ -1471,8 +1476,6 @@ cfq_get_io_context(struct cfq_data *cfqd
 		ioc->cic = cic;
 		ioc->set_ioprio = cfq_ioc_set_ioprio;
 		cic->ioc = ioc;
-		atomic_inc(&ioc->refcount);
-
 		cic->key = cfqd;
 		atomic_inc(&cfqd->ref);
 	} else {
@@ -1509,8 +1512,6 @@ cfq_get_io_context(struct cfq_data *cfqd
 			goto err;
 
 		__cic->ioc = ioc;
-		atomic_inc(&ioc->refcount);
-
 		__cic->key = cfqd;
 		atomic_inc(&cfqd->ref);
 		list_add(&__cic->list, &cic->list);

