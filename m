Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932352AbVISNQL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932352AbVISNQL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Sep 2005 09:16:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932314AbVISNQK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Sep 2005 09:16:10 -0400
Received: from verein.lst.de ([213.95.11.210]:5293 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S932352AbVISNQJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Sep 2005 09:16:09 -0400
Date: Mon, 19 Sep 2005 15:16:00 +0200
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@suse.de>, akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] move tasklist walk from cfq-iosched to elevator.c
Message-ID: <20050919131600.GA11806@lst.de>
References: <20050826114924.GA28166@lst.de> <20050826134509.GF4018@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050826134509.GF4018@suse.de>
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 26, 2005 at 03:45:10PM +0200, Jens Axboe wrote:
> On Fri, Aug 26 2005, Christoph Hellwig wrote:
> > We're trying to get rid of as much as possible tasklist walks, or at
> > least moving them to core code.  This patch falls into the second
> > category.
> > 
> > Instead of walking the tasklist in cfq-iosched move that into
> > elv_unregister.  The added benefit is that with this change the as
> > ioscheduler might be might unloadable more easily aswell.
> > 
> > The new code uses read_lock instead of read_lock_irq because the
> > tasklist_lock only needs irq disabling for writers.
> 
> Looks innocent enough, fine with me. 'as' will need additional work to
> be unloadable, but it wont break anything since it's running with an
> elevated module count right now anyways.

any chance to send this on to akpm?


Signed-off-by: Christoph Hellwig <hch@lst.de>

Index: linux-2.6/drivers/block/as-iosched.c
===================================================================
--- linux-2.6.orig/drivers/block/as-iosched.c	2005-08-11 16:45:55.000000000 +0200
+++ linux-2.6/drivers/block/as-iosched.c	2005-08-14 12:13:08.000000000 +0200
@@ -2119,8 +2119,8 @@
 
 static void __exit as_exit(void)
 {
-	kmem_cache_destroy(arq_pool);
 	elv_unregister(&iosched_as);
+	kmem_cache_destroy(arq_pool);
 }
 
 module_init(as_init);
Index: linux-2.6/drivers/block/cfq-iosched.c
===================================================================
--- linux-2.6.orig/drivers/block/cfq-iosched.c	2005-08-11 16:45:55.000000000 +0200
+++ linux-2.6/drivers/block/cfq-iosched.c	2005-08-14 12:09:17.000000000 +0200
@@ -2609,28 +2609,8 @@
 
 static void __exit cfq_exit(void)
 {
-	struct task_struct *g, *p;
-	unsigned long flags;
-
-	read_lock_irqsave(&tasklist_lock, flags);
-
-	/*
-	 * iterate each process in the system, removing our io_context
-	 */
-	do_each_thread(g, p) {
-		struct io_context *ioc = p->io_context;
-
-		if (ioc && ioc->cic) {
-			ioc->cic->exit(ioc->cic);
-			cfq_free_io_context(ioc->cic);
-			ioc->cic = NULL;
-		}
-	} while_each_thread(g, p);
-
-	read_unlock_irqrestore(&tasklist_lock, flags);
-
-	cfq_slab_kill();
 	elv_unregister(&iosched_cfq);
+	cfq_slab_kill();
 }
 
 module_init(cfq_init);
Index: linux-2.6/drivers/block/elevator.c
===================================================================
--- linux-2.6.orig/drivers/block/elevator.c	2005-08-11 16:45:55.000000000 +0200
+++ linux-2.6/drivers/block/elevator.c	2005-08-14 12:12:35.000000000 +0200
@@ -572,6 +572,27 @@
 
 void elv_unregister(struct elevator_type *e)
 {
+	struct task_struct *g, *p;
+
+	/*
+	 * Iterate every thread in the process to remove the io contexts.
+	 */
+	read_lock(&tasklist_lock);
+	do_each_thread(g, p) {
+		struct io_context *ioc = p->io_context;
+		if (ioc && ioc->cic) {
+			ioc->cic->exit(ioc->cic);
+			ioc->cic->dtor(ioc->cic);
+			ioc->cic = NULL;
+		}
+		if (ioc && ioc->aic) {
+			ioc->aic->exit(ioc->aic);
+			ioc->aic->dtor(ioc->aic);
+			ioc->aic = NULL;
+		}
+	} while_each_thread(g, p);
+	read_unlock(&tasklist_lock);
+
 	spin_lock_irq(&elv_list_lock);
 	list_del_init(&e->list);
 	spin_unlock_irq(&elv_list_lock);
