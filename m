Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264927AbTLTSUx (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Dec 2003 13:20:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264935AbTLTSUx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Dec 2003 13:20:53 -0500
Received: from dbl.q-ag.de ([80.146.160.66]:34271 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S264927AbTLTSUs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Dec 2003 13:20:48 -0500
Message-ID: <3FE492EF.2090202@colorfullife.com>
Date: Sat, 20 Dec 2003 19:20:31 +0100
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.1) Gecko/20031030
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: lse-tech@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [RFC,PATCH] use rcu for fasync_lock
Content-Type: multipart/mixed;
 boundary="------------050709040509080109020000"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050709040509080109020000
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

kill_fasync and fasync_helper were intended for mice and similar, rare 
users, thus it uses a simple rwlock for the locking. This is not true 
anymore: e.g. every pipe read and write operation calls kill_fasync, 
which must acquire the rwlock before handling the fasync list.
What about switching to rcu? I did a reaim run on a 4-way pIII with STP, 
and it reduced the time within kill_fasync by 80%:

diffprofile reaim_End_stock reaim_End_rcu          
     21166     1.2% default_idle
     18882     0.9% total
       290    12.8% page_address
       269    23.5% group_send_sig_info
       259    41.1% do_brk
       244     6.3% current_kernel_time
[ delta < 200: skipped]
      -205   -16.1% get_signal_to_deliver
      -240    -3.7% page_add_rmap
      -364    -4.7% __might_sleep
      -369    -8.4% page_remove_rmap
      -975   -81.2% kill_fasync

What do you think? Patch against 2.6.0 is attached.

--
    Manfred


--------------050709040509080109020000
Content-Type: text/plain;
 name="patch-fasync-rcu"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-fasync-rcu"

--- 2.6/fs/fcntl.c	2003-12-04 19:44:38.000000000 +0100
+++ build-2.6/fs/fcntl.c	2003-12-20 10:56:23.344256035 +0100
@@ -537,9 +537,19 @@
 	return ret;
 }
 
-static rwlock_t fasync_lock = RW_LOCK_UNLOCKED;
+static spinlock_t fasync_lock = SPIN_LOCK_UNLOCKED;
 static kmem_cache_t *fasync_cache;
 
+struct fasync_rcu_struct {
+	struct fasync_struct data;
+	struct rcu_head rcu;
+};
+
+static void fasync_free(void *data)
+{
+	kmem_cache_free(fasync_cache, data);
+}
+
 /*
  * fasync_helper() is used by some character device drivers (mainly mice)
  * to set up the fasync queue. It returns negative on error, 0 if it did
@@ -548,7 +558,7 @@
 int fasync_helper(int fd, struct file * filp, int on, struct fasync_struct **fapp)
 {
 	struct fasync_struct *fa, **fp;
-	struct fasync_struct *new = NULL;
+	struct fasync_rcu_struct *new = NULL;
 	int result = 0;
 
 	if (on) {
@@ -556,15 +566,23 @@
 		if (!new)
 			return -ENOMEM;
 	}
-	write_lock_irq(&fasync_lock);
+	spin_lock(&fasync_lock);
 	for (fp = fapp; (fa = *fp) != NULL; fp = &fa->fa_next) {
 		if (fa->fa_file == filp) {
 			if(on) {
+				/* RCU violation:
+				 * We are modifying a struct that's visible by
+				 * readers. If there is a fasync notification
+				 * right now, then it could go to either the
+				 * old or the new fd. Shouldn't matter.
+				 * 	Manfred <manfred@colorfullife.com>
+				 */
 				fa->fa_fd = fd;
 				kmem_cache_free(fasync_cache, new);
 			} else {
 				*fp = fa->fa_next;
-				kmem_cache_free(fasync_cache, fa);
+				new = container_of(fa, struct fasync_rcu_struct, data);
+				call_rcu(&new->rcu, fasync_free, new);
 				result = 1;
 			}
 			goto out;
@@ -572,15 +590,16 @@
 	}
 
 	if (on) {
-		new->magic = FASYNC_MAGIC;
-		new->fa_file = filp;
-		new->fa_fd = fd;
-		new->fa_next = *fapp;
-		*fapp = new;
+		new->data.magic = FASYNC_MAGIC;
+		new->data.fa_file = filp;
+		new->data.fa_fd = fd;
+		new->data.fa_next = *fapp;
+		smp_wmb();
+		*fapp = &new->data;
 		result = 1;
 	}
 out:
-	write_unlock_irq(&fasync_lock);
+	spin_unlock(&fasync_lock);
 	return result;
 }
 
@@ -590,7 +609,8 @@
 {
 	while (fa) {
 		struct fown_struct * fown;
-		if (fa->magic != FASYNC_MAGIC) {
+		read_barrier_depends();
+		if (unlikely(fa->magic != FASYNC_MAGIC)) {
 			printk(KERN_ERR "kill_fasync: bad magic number in "
 			       "fasync_struct!\n");
 			return;
@@ -609,9 +629,9 @@
 
 void kill_fasync(struct fasync_struct **fp, int sig, int band)
 {
-	read_lock(&fasync_lock);
+	rcu_read_lock();
 	__kill_fasync(*fp, sig, band);
-	read_unlock(&fasync_lock);
+	rcu_read_unlock();
 }
 
 EXPORT_SYMBOL(kill_fasync);
@@ -619,7 +639,7 @@
 static int __init fasync_init(void)
 {
 	fasync_cache = kmem_cache_create("fasync_cache",
-		sizeof(struct fasync_struct), 0, 0, NULL, NULL);
+		sizeof(struct fasync_rcu_struct), 0, 0, NULL, NULL);
 	if (!fasync_cache)
 		panic("cannot create fasync slab cache");
 	return 0;

--------------050709040509080109020000--

