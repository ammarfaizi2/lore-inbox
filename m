Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263789AbUCZAC2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Mar 2004 19:02:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263811AbUCYX65
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Mar 2004 18:58:57 -0500
Received: from waste.org ([209.173.204.2]:46233 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S263789AbUCYX54 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Mar 2004 18:57:56 -0500
From: Matt Mackall <mpm@selenic.com>
To: Andrew Morton <akpm@osdl.org>
X-PatchBomber: http://selenic.com/scripts/mailpatches
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3.524465763@selenic.com>
Message-Id: <4.524465763@selenic.com>
Subject: [PATCH 3/22] /dev/random: remove broken resizing sysctl
Date: Thu, 25 Mar 2004 17:57:42 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


/dev/random  remove broken resizing sysctl

Remove random pool resizing sysctl. It's racy in hard to fix ways and
doesn't really warrant fixing. 4kbits (512 bytes) of entropy pool
should be more than big enough and too small to be a memory concern.
It also doesn't adjust the other pool size(s).



 tiny-mpm/drivers/char/random.c  |   88 +---------------------------------------
 tiny-mpm/include/linux/sysctl.h |    1 
 2 files changed, 3 insertions(+), 86 deletions(-)

diff -puN drivers/char/random.c~kill-pool-resize drivers/char/random.c
--- tiny/drivers/char/random.c~kill-pool-resize	2004-03-20 13:35:17.000000000 -0600
+++ tiny-mpm/drivers/char/random.c	2004-03-20 13:35:17.000000000 -0600
@@ -550,14 +550,7 @@ static void clear_entropy_store(struct e
 	r->input_rotate = 0;
 	memset(r->pool, 0, r->poolinfo.POOLBYTES);
 }
-#ifdef CONFIG_SYSCTL
-static void free_entropy_store(struct entropy_store *r)
-{
-	if (r->pool)
-		kfree(r->pool);
-	kfree(r);
-}
-#endif
+
 /*
  * This function adds a byte into the entropy "pool".  It does not
  * update the entropy estimate.  The caller should call
@@ -1819,78 +1812,12 @@ EXPORT_SYMBOL(generate_random_uuid);
 
 #include <linux/sysctl.h>
 
-static int sysctl_poolsize;
 static int min_read_thresh, max_read_thresh;
 static int min_write_thresh, max_write_thresh;
 static char sysctl_bootid[16];
 
 /*
- * This function handles a request from the user to change the pool size 
- * of the primary entropy store.
- */
-static int change_poolsize(int poolsize)
-{
-	struct entropy_store	*new_store, *old_store;
-	int			ret;
-	
-	if ((ret = create_entropy_store(poolsize, &new_store)))
-		return ret;
-
-	add_entropy_words(new_store, random_state->pool,
-			  random_state->poolinfo.poolwords);
-	credit_entropy_store(new_store, random_state->entropy_count);
-
-	sysctl_init_random(new_store);
-	old_store = random_state;
-	random_state = batch_work.data = new_store;
-	free_entropy_store(old_store);
-	return 0;
-}
-
-static int proc_do_poolsize(ctl_table *table, int write, struct file *filp,
-			    void *buffer, size_t *lenp)
-{
-	int	ret;
-
-	sysctl_poolsize = random_state->poolinfo.POOLBYTES;
-
-	ret = proc_dointvec(table, write, filp, buffer, lenp);
-	if (ret || !write ||
-	    (sysctl_poolsize == random_state->poolinfo.POOLBYTES))
-		return ret;
-
-	return change_poolsize(sysctl_poolsize);
-}
-
-static int poolsize_strategy(ctl_table *table, int *name, int nlen,
-			     void *oldval, size_t *oldlenp,
-			     void *newval, size_t newlen, void **context)
-{
-	int	len;
-	
-	sysctl_poolsize = random_state->poolinfo.POOLBYTES;
-
-	/*
-	 * We only handle the write case, since the read case gets
-	 * handled by the default handler (and we don't care if the
-	 * write case happens twice; it's harmless).
-	 */
-	if (newval && newlen) {
-		len = newlen;
-		if (len > table->maxlen)
-			len = table->maxlen;
-		if (copy_from_user(table->data, newval, len))
-			return -EFAULT;
-	}
-
-	if (sysctl_poolsize != random_state->poolinfo.POOLBYTES)
-		return change_poolsize(sysctl_poolsize);
-
-	return 0;
-}
-
-/*
- * These functions is used to return both the bootid UUID, and random
+ * These functions are used to return both the bootid UUID, and random
  * UUID.  The difference is in whether table->data is NULL; if it is,
  * then a new UUID is generated and returned to the user.
  * 
@@ -1956,15 +1883,6 @@ static int uuid_strategy(ctl_table *tabl
 
 ctl_table random_table[] = {
 	{
-		.ctl_name	= RANDOM_POOLSIZE,
-		.procname	= "poolsize",
-		.data		= &sysctl_poolsize,
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= &proc_do_poolsize,
-		.strategy	= &poolsize_strategy,
-	},
-	{
 		.ctl_name	= RANDOM_ENTROPY_COUNT,
 		.procname	= "entropy_avail",
 		.maxlen		= sizeof(int),
@@ -2018,7 +1936,7 @@ static void sysctl_init_random(struct en
 	min_read_thresh = 8;
 	min_write_thresh = 0;
 	max_read_thresh = max_write_thresh = random_state->poolinfo.POOLBITS;
-	random_table[1].data = &random_state->entropy_count;
+	random_table[0].data = &random_state->entropy_count;
 }
 #endif 	/* CONFIG_SYSCTL */
 
diff -puN include/linux/sysctl.h~kill-pool-resize include/linux/sysctl.h
--- tiny/include/linux/sysctl.h~kill-pool-resize	2004-03-20 13:35:17.000000000 -0600
+++ tiny-mpm/include/linux/sysctl.h	2004-03-20 13:35:17.000000000 -0600
@@ -188,7 +188,6 @@ enum
 /* /proc/sys/kernel/random */
 enum
 {
-	RANDOM_POOLSIZE=1,
 	RANDOM_ENTROPY_COUNT=2,
 	RANDOM_READ_THRESH=3,
 	RANDOM_WRITE_THRESH=4,

_
