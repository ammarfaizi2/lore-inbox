Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751992AbWCJLR7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751992AbWCJLR7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Mar 2006 06:17:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752227AbWCJLR7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Mar 2006 06:17:59 -0500
Received: from smtp-out.google.com ([216.239.45.12]:39754 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP
	id S1750961AbWCJLR6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Mar 2006 06:17:58 -0500
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:message-id:date:from:user-agent:
	x-accept-language:mime-version:to:cc:subject:references:in-reply-to:
	content-type:content-transfer-encoding;
	b=mASzsTBZwZlkeoEBXHnkrByb44GCiHJt+gdcu+1/GS6JPfBK656PftHNzdE9mSZJh
	PdilaM+yqm74aSqUQXdFA==
Message-ID: <44116057.5060705@google.com>
Date: Fri, 10 Mar 2006 03:17:43 -0800
From: Daniel Phillips <phillips@google.com>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051011)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mark Fasheh <mark.fasheh@oracle.com>
CC: Andi Kleen <ak@suse.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, ocfs2-devel@oss.oracle.com
Subject: Re: [Ocfs2-devel] Ocfs2 performance
References: <4408C2E8.4010600@google.com> <20060303233617.51718c8e.akpm@osdl.org> <440B9035.1070404@google.com> <20060306025800.GA27280@ca-server1.us.oracle.com> <440BC1C6.1000606@google.com> <20060306195135.GB27280@ca-server1.us.oracle.com> <p733bhvgc7f.fsf@verdi.suse.de> <20060307045835.GF27280@ca-server1.us.oracle.com> <440FCA81.7090608@google.com> <20060310002121.GJ27280@ca-server1.us.oracle.com>
In-Reply-To: <20060310002121.GJ27280@ca-server1.us.oracle.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Fasheh wrote:
> Your hash sizes are still ridiculously large. All my data shows that we need
> to increase the hash size by much much less. At the following location you
> will find a series of files detailing the results of 10 untar runs with
> various hash allocations. The short story is that we really only need
> an allocation on the order of a few pages. 
> 
> http://oss.oracle.com/~mfasheh/dlm_hash/untar_timings/

There is a very obvious drop going from 16 to 32 pages, then you seem to
drop into the noise.  So if you agree that 32 is a "few" pages I think
we're in the right ballpark.  I've been testing with 64 pages lately, with
satisfactory results.

Funny your systimes are so much higher than mine.  You don't seem to have
the massive failure to start writeout that I see here.  Did you fix
something?  Also, I don't see that wildly flucuating real time.  Fixed
something else?  I'm still running 2.6.16-pre3.

> If you average up the untar times you'll get something close to this:
> 1 page:   23 seconds
> 2 pages:  18 seconds
> 4 pages:  16 seconds
> 6 pages:  15 seconds
> 8 pages:  14 seconds
> 16 pages: 14 seconds
> 32 pages: 14 seconds
> 64 pages: 14 seconds

Ahem, we were talking about systime.  Sure, I've noticed that systime often
gets buried by disk latency, but not always, and even when it does it still
generates heat and slows down other things that might be running at the same
time.  A database for example :-)

> PAGE_SIZE on this system is 4096
> 
> So our largest performance gain is by just adding a page, and things seem to
> top out at 6-8 pages. I will likely have a patch in the next few days or so
> which will allocate a small array of pages at dlm startup.

No need, here is a functioning patch, slice and dice to your heart's content.
I wrote this to test the theory I've often heard that vmallocs are more costly
to use than vectors full of pages because of tlb pressure.  Balderdash, I say.

With hashvec, (64K buckets)

      real user sys
    29.62 23.87 3.02
    28.80 24.16 3.07
    50.95 24.11 3.04
    28.17 23.95 3.20
    61.21 23.89 3.16
    28.61 23.88 3.30

With vmalloc (64K buckets)

      real user sys
    29.67 23.98 2.88
    28.35 23.96 3.13
    52.29 24.16 2.89
    28.39 24.07 2.97
    65.13 24.08 3.01
    28.08 24.02 3.16

Pretty close race - vmalloc is slightly faster if anything.  Note: I presume
that gcc has compiled shifts and masks for my table arithmetic but I did not
check.  Anyway, this patch does eliminate the possibility of running around on
vmalloc fragmentation.

>>Of course, if we take a critical look at your locking strategy we might
>>find some fat to cut there too. Could I possibly interest you in writing
>>up a tech note on your global locking strategy?
> 
> Sure, but it'll take a while. I've already got one OCFS2 related paper to
> write. Perhaps I'll be able to kill two birds with one stone.

We're not picky, how about some early notes?

> By the way, an interesting thing happened when I recently switched disk
> arrays - the fluctuations in untar times disappeared. The new array is much
> nicer, while the old one was basically Just A Bunch Of Disks. Also, sync
> times dropped dramatically.

Interesting, but maybe you'd better treat the bad old disk as a blessing
in disguise and let it help you find that bug.

Regards,

Daniel

diff -urp 2.6.16.clean/fs/ocfs2/dlm/dlmcommon.h 2.6.16/fs/ocfs2/dlm/dlmcommon.h
--- 2.6.16.clean/fs/ocfs2/dlm/dlmcommon.h	2006-03-02 19:05:13.000000000 -0800
+++ 2.6.16/fs/ocfs2/dlm/dlmcommon.h	2006-03-10 01:12:45.000000000 -0800
@@ -36,8 +36,10 @@
  #define DLM_LOCK_RES_OWNER_UNKNOWN     O2NM_MAX_NODES
  #define DLM_THREAD_SHUFFLE_INTERVAL    5     // flush everything every 5 passes
  #define DLM_THREAD_MS                  200   // flush at least every 200 ms
-
-#define DLM_HASH_BUCKETS     (PAGE_SIZE / sizeof(struct hlist_head))
+#define DLM_HASH_SIZE		(1 << 18)
+#define DLM_HASH_PAGES		(DLM_HASH_SIZE / PAGE_SIZE)
+#define DLM_BUCKETS_PER_PAGE	(PAGE_SIZE / sizeof(struct hlist_head))
+#define DLM_HASH_BUCKETS	(DLM_HASH_PAGES * DLM_BUCKETS_PER_PAGE)

  enum dlm_ast_type {
  	DLM_AST = 0,
@@ -85,7 +87,7 @@ enum dlm_ctxt_state {
  struct dlm_ctxt
  {
  	struct list_head list;
-	struct hlist_head *lockres_hash;
+	struct hlist_head **lockres_hash;
  	struct list_head dirty_list;
  	struct list_head purge_list;
  	struct list_head pending_asts;
@@ -132,6 +134,11 @@ struct dlm_ctxt
  	struct list_head	dlm_eviction_callbacks;
  };

+static inline struct hlist_head *lockres_hash(struct dlm_ctxt *dlm, unsigned i)
+{
+	return dlm->lockres_hash[(i / DLM_BUCKETS_PER_PAGE) % DLM_HASH_PAGES] + i % DLM_BUCKETS_PER_PAGE;
+}
+
  /* these keventd work queue items are for less-frequently
   * called functions that cannot be directly called from the
   * net message handlers for some reason, usually because
diff -urp 2.6.16.clean/fs/ocfs2/dlm/dlmdebug.c 2.6.16/fs/ocfs2/dlm/dlmdebug.c
--- 2.6.16.clean/fs/ocfs2/dlm/dlmdebug.c	2006-03-02 16:47:47.000000000 -0800
+++ 2.6.16/fs/ocfs2/dlm/dlmdebug.c	2006-03-10 00:31:26.000000000 -0800
@@ -130,7 +130,7 @@ void dlm_dump_lock_resources(struct dlm_

  	spin_lock(&dlm->spinlock);
  	for (i=0; i<DLM_HASH_BUCKETS; i++) {
-		bucket = &(dlm->lockres_hash[i]);
+		bucket = lockres_hash(dlm, i);
  		hlist_for_each_entry(res, iter, bucket, hash_node)
  			dlm_print_one_lock_resource(res);
  	}
diff -urp 2.6.16.clean/fs/ocfs2/dlm/dlmdomain.c 2.6.16/fs/ocfs2/dlm/dlmdomain.c
--- 2.6.16.clean/fs/ocfs2/dlm/dlmdomain.c	2006-03-02 16:47:47.000000000 -0800
+++ 2.6.16/fs/ocfs2/dlm/dlmdomain.c	2006-03-10 01:08:46.000000000 -0800
@@ -33,6 +33,7 @@
  #include <linux/spinlock.h>
  #include <linux/delay.h>
  #include <linux/err.h>
+#include <linux/vmalloc.h>

  #include "cluster/heartbeat.h"
  #include "cluster/nodemanager.h"
@@ -49,6 +50,33 @@
  #define MLOG_MASK_PREFIX (ML_DLM|ML_DLM_DOMAIN)
  #include "cluster/masklog.h"

+#include <linux/seq_file.h>
+#include <linux/proc_fs.h>
+
+void free_pagevec(void **vec, int pages)
+{
+	while (pages--)
+		free_page((unsigned long)vec[pages]);
+	kfree(vec);
+}
+
+void **alloc_pagevec(int pages)
+{
+	void **vec = kmalloc(pages * sizeof(void *), GFP_KERNEL);
+	int i;
+
+	if (!vec)
+		return NULL;
+
+	for (i = 0; i < pages; i++)
+		if (!(vec[i] = (void *)__get_free_page(GFP_KERNEL)))
+			goto lame;
+	return vec;
+lame:
+	free_pagevec(vec, i);
+	return NULL;
+}
+
  /*
   *
   * spinlock lock ordering: if multiple locks are needed, obey this ordering:
@@ -91,7 +119,7 @@ void __dlm_insert_lockres(struct dlm_ctx

  	q = &res->lockname;
  	q->hash = full_name_hash(q->name, q->len);
-	bucket = &(dlm->lockres_hash[q->hash % DLM_HASH_BUCKETS]);
+	bucket = lockres_hash(dlm, q->hash);

  	/* get a reference for our hashtable */
  	dlm_lockres_get(res);
@@ -114,7 +142,7 @@ struct dlm_lock_resource * __dlm_lookup_

  	hash = full_name_hash(name, len);

-	bucket = &(dlm->lockres_hash[hash % DLM_HASH_BUCKETS]);
+	bucket = lockres_hash(dlm, hash);

  	/* check for pre-existing lock */
  	hlist_for_each(iter, bucket) {
@@ -194,7 +222,7 @@ static int dlm_wait_on_domain_helper(con
  static void dlm_free_ctxt_mem(struct dlm_ctxt *dlm)
  {
  	if (dlm->lockres_hash)
-		free_page((unsigned long) dlm->lockres_hash);
+		free_pagevec((void **)dlm->lockres_hash, DLM_HASH_PAGES);

  	if (dlm->name)
  		kfree(dlm->name);
@@ -223,6 +251,7 @@ static void dlm_ctxt_release(struct kref

  	wake_up(&dlm_domain_events);

+	remove_proc_entry("ocfs2hash", NULL);
  	dlm_free_ctxt_mem(dlm);

  	spin_lock(&dlm_domain_lock);
@@ -304,8 +333,8 @@ static void dlm_migrate_all_locks(struct
  restart:
  	spin_lock(&dlm->spinlock);
  	for (i = 0; i < DLM_HASH_BUCKETS; i++) {
-		while (!hlist_empty(&dlm->lockres_hash[i])) {
-			res = hlist_entry(dlm->lockres_hash[i].first,
+		while (!hlist_empty(lockres_hash(dlm, i))) {
+			res = hlist_entry(lockres_hash(dlm, i)->first,
  					  struct dlm_lock_resource, hash_node);
  			/* need reference when manually grabbing lockres */
  			dlm_lockres_get(res);
@@ -1191,7 +1220,7 @@ static struct dlm_ctxt *dlm_alloc_ctxt(c
  		goto leave;
  	}

-	dlm->lockres_hash = (struct hlist_head *) __get_free_page(GFP_KERNEL);
+	dlm->lockres_hash = (struct hlist_head **)alloc_pagevec(DLM_HASH_PAGES);
  	if (!dlm->lockres_hash) {
  		mlog_errno(-ENOMEM);
  		kfree(dlm->name);
@@ -1200,8 +1229,8 @@ static struct dlm_ctxt *dlm_alloc_ctxt(c
  		goto leave;
  	}

-	for (i=0; i<DLM_HASH_BUCKETS; i++)
-		INIT_HLIST_HEAD(&dlm->lockres_hash[i]);
+	for (i = 0; i < DLM_HASH_BUCKETS; i++)
+		INIT_HLIST_HEAD(lockres_hash(dlm, i));

  	strcpy(dlm->name, domain);
  	dlm->key = key;
diff -urp 2.6.16.clean/fs/ocfs2/dlm/dlmrecovery.c 2.6.16/fs/ocfs2/dlm/dlmrecovery.c
--- 2.6.16.clean/fs/ocfs2/dlm/dlmrecovery.c	2006-03-02 19:05:13.000000000 -0800
+++ 2.6.16/fs/ocfs2/dlm/dlmrecovery.c	2006-03-10 00:30:58.000000000 -0800
@@ -1721,7 +1721,7 @@ static void dlm_finish_local_lockres_rec
  	 * the RECOVERING state and set the owner
  	 * if necessary */
  	for (i = 0; i < DLM_HASH_BUCKETS; i++) {
-		bucket = &(dlm->lockres_hash[i]);
+		bucket = lockres_hash(dlm, i);
  		hlist_for_each_entry(res, hash_iter, bucket, hash_node) {
  			if (res->state & DLM_LOCK_RES_RECOVERING) {
  				if (res->owner == dead_node) {
@@ -1879,7 +1879,7 @@ static void dlm_do_local_recovery_cleanu
  	 *    need to be fired as a result.
  	 */
  	for (i = 0; i < DLM_HASH_BUCKETS; i++) {
-		bucket = &(dlm->lockres_hash[i]);
+		bucket = lockres_hash(dlm, i);
  		hlist_for_each_entry(res, iter, bucket, hash_node) {
   			/* always prune any $RECOVERY entries for dead nodes,
   			 * otherwise hangs can occur during later recovery */
