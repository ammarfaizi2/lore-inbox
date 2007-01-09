Return-Path: <linux-kernel-owner+w=401wt.eu-S1751320AbXAIMO3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751320AbXAIMO3 (ORCPT <rfc822;w@1wt.eu>);
	Tue, 9 Jan 2007 07:14:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751339AbXAIMO3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Jan 2007 07:14:29 -0500
Received: from brick.kernel.dk ([62.242.22.158]:3553 "EHLO kernel.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751320AbXAIMO2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Jan 2007 07:14:28 -0500
Date: Tue, 9 Jan 2007 13:15:03 +0100
From: Jens Axboe <jens.axboe@oracle.com>
To: Torsten Kaiser <kernel@bardioc.dyndns.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [BUG 2.6.20-rc3-mm1] raid1 mount blocks for ever
Message-ID: <20070109121501.GJ11203@kernel.dk>
References: <368051775.16914@ustc.edu.cn> <200701061130.07467.kernel@bardioc.dyndns.org> <20070108085245.GR11203@kernel.dk> <200701081911.46495.kernel@bardioc.dyndns.org> <20070109091858.GI11203@kernel.dk> <20070109120331.GA6108@mail.ustc.edu.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070109120331.GA6108@mail.ustc.edu.cn>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 09 2007, Fengguang Wu wrote:
> On Tue, Jan 09, 2007 at 10:19:00AM +0100, Jens Axboe wrote:
> > On Mon, Jan 08 2007, Torsten Kaiser wrote:
> > > On Monday 08 January 2007 09:52, Jens Axboe wrote:
> > > > --- a/block/ll_rw_blk.c
> > > > +++ b/block/ll_rw_blk.c
> > > > @@ -1542,7 +1542,7 @@ static inline void
> > > > -	blk_unplug_current();
> > > > +	blk_replug_current_nested();
> > > 
> > > Does not help. Dmesg follows:
> > 
> > [snip]
> > 
> > Strange, it works perfectly for me now. Not using -mm though, but the
> > plug branch. And it did hang before. Fengguang, any change for you?
> 
> 2.6.20-rc3-mm1 plus your patch works for me.
> 
> Lucky enough to found this before giving up:
> 
>         mount takes 39s, and umount takes 42s.

Do the finish quicker, if you cat /proc/mdstat after issuing the mount
or umount? I'm testing md right now and I'm seeing a few oddities wrt
that, looking further...

You probably also want this, at least if you ever shut down your arrays.

diff --git a/block/ll_rw_blk.c b/block/ll_rw_blk.c
index 4c8ac7e..34b7936 100644
--- a/block/ll_rw_blk.c
+++ b/block/ll_rw_blk.c
@@ -1745,6 +1745,11 @@ request_queue_t *blk_alloc_queue_node(gf
 
 	memset(q, 0, sizeof(*q));
 
+	if (init_qrcu_struct(&q->qrcu)) {
+		kmem_cache_free(requestq_cachep, q);
+		return NULL;
+	}
+
 	snprintf(q->kobj.name, KOBJ_NAME_LEN, "%s", "queue");
 	q->kobj.ktype = &queue_ktype;
 	kobject_init(&q->kobj);
@@ -1802,11 +1807,6 @@ blk_init_queue_node(request_fn_proc *rfn
 	if (!q)
 		return NULL;
 
-	if (init_qrcu_struct(&q->qrcu)) {
-		kmem_cache_free(requestq_cachep, q);
-		return NULL;
-	}
-
 	q->node = node_id;
 	if (blk_init_free_list(q)) {
 		cleanup_qrcu_struct(&q->qrcu);

-- 
Jens Axboe

