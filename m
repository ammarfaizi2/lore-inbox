Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751737AbWCCW2J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751737AbWCCW2J (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Mar 2006 17:28:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751742AbWCCW2J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Mar 2006 17:28:09 -0500
Received: from smtp-out.google.com ([216.239.45.12]:47731 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP
	id S1751737AbWCCW2H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Mar 2006 17:28:07 -0500
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:message-id:date:from:user-agent:
	x-accept-language:mime-version:to:subject:content-type:content-transfer-encoding;
	b=Qp+Spweg962LZ4uy0GMAMIKnzbMJQXLbN7PIdPNPrOyX8vVQsdwlv1zMT0lB6LT76
	bvAG5b0Uep1GCmn3Bs7ng==
Message-ID: <4408C2E8.4010600@google.com>
Date: Fri, 03 Mar 2006 14:27:52 -0800
From: Daniel Phillips <phillips@google.com>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051011)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, ocfs2-devel@oss.oracle.com
Subject: Ocfs2 performance bugs of doom
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi ocfs2 guys,

Actually, ocfs2 is not doomed - far from it!  I just wanted to grab a few
more of those eyeballs that normally glaze over each time they see a
cluster mail run by on lkml[1].  Today's news: you are still not finished
with global lock systime badness, and I already have more performance bugs
for you.

For interested observers, the story so far:

A couple of days ago I reported a bug to the ocfs2 team via irc[2].  If I
untar a kernel tree several times, each into its own directory, ocfs2
system time (already four times higher than ext3 to start with) increases
linearly on each successive iteration, up to a very silly amount where it
finally stabilizes.

This is with ocfs2 running uniprocessor on a single node with a local disk.
The same performance bug also bites on a cluster of course.

In a dazzling display of developer studlyness, the ocfs2 team found the hash
table bottleneck while I was still trying to figure out how to make oprofile
behave.

    http://sosdg.org/~coywolf/lxr/source/fs/ocfs2/dlm/dlmdomain.c?v=2.6.16-rc3#L102

So the ocfs2 guys switched from double word to single word hash table heads
and quadrupled the size of the hash table.  Problem solved, right?  No!

I got the patch from Git (note to Gitweb devs: could "plain" please be
_really plain_ just like marc's "raw" instead of colorless html?).  While
system is indeed reduced, it still sucks chamber pot juice:

    CPU: P4 / Xeon, speed 2793.41 MHz (estimated)
    samples  %        image name               app name                 symbol name
    -------------------------------------------------------------------------------
    4399778  64.0568  libbz2.so.1.0.2          libbz2.so.1.0.2          (no symbols)
      4399778  100.000  libbz2.so.1.0.2          libbz2.so.1.0.2          (no symbols) [self]
    -------------------------------------------------------------------------------
    1410173  20.5308  vmlinux                  vmlinux                  __dlm_lookup_lockres
      1410173  100.000  vmlinux                  vmlinux                  __dlm_lookup_lockres [self]
    -------------------------------------------------------------------------------
    82840     1.2061  oprofiled                oprofiled                (no symbols)
      82840    100.000  oprofiled                oprofiled                (no symbols) [self]
    -------------------------------------------------------------------------------
    68368     0.9954  vmlinux                  vmlinux                  ocfs2_local_alloc_count_bits
      68368    100.000  vmlinux                  vmlinux                  ocfs2_local_alloc_count_bits [self]
    -------------------------------------------------------------------------------
    47639     0.6936  tar                      tar                      (no symbols)
      47639    100.000  tar                      tar                      (no symbols) [self]
    -------------------------------------------------------------------------------
      1         0.0488  vmlinux                  vmlinux                  ide_build_sglist
      6         0.2925  vmlinux                  vmlinux                  ide_do_request
      70        3.4130  vmlinux                  vmlinux                  __ide_dma_test_irq
      128       6.2409  vmlinux                  vmlinux                  ata_vlb_sync
      134       6.5334  vmlinux                  vmlinux                  proc_ide_read_imodel
      147       7.1672  vmlinux                  vmlinux                  ide_dma_verbose
      1565     76.3042  vmlinux                  vmlinux                  ide_do_rw_disk
    20390     0.2969  vmlinux                  vmlinux                  ide_dma_speed
      20390    100.000  vmlinux                  vmlinux                  ide_dma_speed [self]
    -------------------------------------------------------------------------------

Hash probe cleanup and hand optimization
----------------------------------------

I included two patches below.  The first vmallocs a megabyte hash table
instead of a single page.  This definitively squishes away the global
lock hash table overhead so that systime stays about twice as high as
ext3 instead of starting at three times and increasing to four times
with the (new improved) 4K hash table.

Re vmalloc... even with the extra tlb load, this is better than
kmallocing a smaller vector and running the very high risk that the
allocation will fail or be forced to fall back because of our lame
fragmentation handling.  Of course the Right Think To Do is kmalloc a
vector of pages and mask the hash into it, but as a lazy person I
would rather sink the time into writing this deathless prose.

The second patch is a rewrite of __dlm_lookup_lockres to get rid of the
bogus clearing of tmpres on every loop iteration.  I also threw in a
little hand optimization, which gcc really ought to be doing but isn't.
Comparing the first character of the string before doing the full
memcmp seems to help measurably.  I also tried to provide some more
optimization guidance for the compiler, though I do fear it will fall
on deaf ears.  Finally, I cleaned up some stylistic oddities[3].  I
also left one screaming lindent violation intact.  Executive summary:
could you please install some editors that show whitespace?  And what
is it with this one line per function parameter?   After a few edits
of the function name you end up with a mess anyway so why not do as
the romans do and stick to lindent style?

The __dlm_lookup_lockres rewrite shows a measurable improvement in
hash chain traversal overhead.  Every little bit helps.  I failed to
quantify the improvement precisely because there are other glitchy
things going on that interfere with accurate measurement.  So now we
get to...

How fast is it now?
-------------------

Here is ocfs2 from yesterday's git:

	       Untar                Sync
    Trial   Real  User  Sys     Real  User  Sys
      1.    31.42 24.90 3.81
      2.    31.97 25.15 5.03   (similar to below)
      3.    94.72 25.29 5.79
      4.    26.27  0.28 4.43
      5.    34.24 25.21 6.41
      6.    50.71 25.26 7.23
      7.    33.73 25.44 6.83

Here is what happens with the shiny new patches:

	       Untar                Sync
    Trial   Real  User  Sys     Real  User  Sys

      1.    34.12 24.92 3.17    46.70 0.00 0.17
      2.    29.63 24.96 3.36    47.25 0.00 0.16
      3.   141.18 25.06 3.11    28.43 0.00 0.12
      4.    45.20 25.38 3.07    49.04 0.00 0.18
      5.   160.70 25.11 3.24    21.74 0.00 0.07
      6.    31.65 24.99 3.34    46.30 0.00 0.19
      7.   145.45 25.28 3.16    27.26 0.00 0.12
      8.    30.87 25.16 3.29    44.60 0.00 0.20
      9.    58.31 25.32 3.20    22.82 0.00 0.09
     10.    31.01 25.29 3.09    43.93 0.00 0.22

Things to notice: with the still-teensy hash table, systime for global
lock lookups is still way too high, eventually stabilizing when lock
purging kicks in at about 4 times ext3's systime.  Not good (but indeed,
not as excruciatingly painful as two days ago).

With the attached patches we kill the hash table overhead dead, dead,
dead.  But look at real time for the untar and sync!

   A) We have huge swings in idle time during the untar

   B) We have great whacks of dirty memory sitting around after the
      untar

So that brings us to...

More performance bugs
---------------------

Ocfs2 starts little or no writeout during the untar itself.  Ext3 does.
Solution: check ext3 to see what secret incantations Andrew conjured up
to fiddle it into doing something reasonable.

Ocfs2 sometimes sits and gazes at its navel for minutes at a time, doing
nothing at all.  Timer bug?  A quick glance at SysRq-t shows ocfs2 waiting
in io_schedule.  Waiting for io that never happens?  This needs more
investigation.

You also might want to look at more fine grained lock purging instead of
the current burn the inbox approach.  One can closely approximate the
performance of a LRU without paying the penalty of a separate per-lock lru
field by treating each hash chain as a LRU list.  Here is the equation:
either the hash chains are short in which case you don't care about poor
LRU behavior because you are not purging locks, or they are long and you
do care.  Luckily, the longer the hash chains get, the more closely they
approximate the behavior of a dedicated LRU list.  Amazing.

Delete performance remains horrible, even with a 256 meg journal[4] which
is unconscionably big anyway.  Compare to ext3, which deletes kernel trees
at a steady 2 seconds per, with a much smaller journal.  Ocfs2 takes more
like a minute.

I would chase down these glitches too, except that I really need to get
back to my cluster block devices, without which we cannot fully bake
our cluster cake.  After all, there are six of you and only one of me, I
had better go work on the thing nobody else is working on.

[1] People would be much more interested in ocfs2 if they could get it
running in less than a day, right?  Well, you can, or at least you could
if Oracle's startup scripts were ever so slightly less user hostile.  For
example, how about scripts/ocfs2 instead of vendor/common/o2cb.init?  And
it would be nice to expunge the evil of using lsmod to see if a subsystem
is available.  Also, an actual shared disk is not recommended for your
first run.  That way you avoid the pain of iscsi, nbd, fiber channel,
etc al. (At least for a little while.)  Once you get the init script
insanity under control, ocfs2 comes up just like a normal filesystem on
each node: mount -tocfs2.

[2] It is high time we pried loose the ocfs2 design process from secret
irc channels and dark tunnels running deep beneath Oracle headquarters,
and started sharing the squishy goodness of filesystem clustering
development with some more of the smart people lurking here.

[3] Aha! I hear you cry, he wrote an 83 character line!  Actually, I am
going to blame the person who invented the name DLM_HASH_BUCKETS.  Can
you spot the superfluous redundancy?  (Hint: name three other kinds of
kernel objects that have buckets.)

[4] Could you please have fsck.ocfs2 report the size of the journal?

Patches apply to current linux-git.

Regards,

Daniel

[PATCH] Vmalloc ocfs global lock hash table and make it way bigger

Signed-Off-By: Daniel "the wayward" Phillips <phillips@google.com>

diff -urp 2.6.16.clean/fs/ocfs2/dlm/dlmcommon.h 2.6.16/fs/ocfs2/dlm/dlmcommon.h
--- 2.6.16.clean/fs/ocfs2/dlm/dlmcommon.h	2006-03-02 19:05:13.000000000 -0800
+++ 2.6.16/fs/ocfs2/dlm/dlmcommon.h	2006-03-03 09:52:54.000000000 -0800
@@ -36,8 +36,8 @@
  #define DLM_LOCK_RES_OWNER_UNKNOWN     O2NM_MAX_NODES
  #define DLM_THREAD_SHUFFLE_INTERVAL    5     // flush everything every 5 passes
  #define DLM_THREAD_MS                  200   // flush at least every 200 ms
-
-#define DLM_HASH_BUCKETS     (PAGE_SIZE / sizeof(struct hlist_head))
+#define DLM_HASH_SIZE		(1 << 20)
+#define DLM_HASH_BUCKETS	(DLM_HASH_SIZE / sizeof(struct hlist_head))

  enum dlm_ast_type {
  	DLM_AST = 0,
diff -urp 2.6.16.clean/fs/ocfs2/dlm/dlmdomain.c 2.6.16/fs/ocfs2/dlm/dlmdomain.c
--- 2.6.16.clean/fs/ocfs2/dlm/dlmdomain.c	2006-03-02 16:47:47.000000000 -0800
+++ 2.6.16/fs/ocfs2/dlm/dlmdomain.c	2006-03-03 09:53:21.000000000 -0800
@@ -194,7 +191,7 @@ static int dlm_wait_on_domain_helper(con
  static void dlm_free_ctxt_mem(struct dlm_ctxt *dlm)
  {
  	if (dlm->lockres_hash)
-		free_page((unsigned long) dlm->lockres_hash);
+		vfree(dlm->lockres_hash);

  	if (dlm->name)
  		kfree(dlm->name);
@@ -1191,7 +1188,7 @@ static struct dlm_ctxt *dlm_alloc_ctxt(c
  		goto leave;
  	}

-	dlm->lockres_hash = (struct hlist_head *) __get_free_page(GFP_KERNEL);
+	dlm->lockres_hash = (struct hlist_head *)vmalloc(DLM_HASH_SIZE);
  	if (!dlm->lockres_hash) {
  		mlog_errno(-ENOMEM);
  		kfree(dlm->name);
@@ -1200,7 +1197,7 @@ static struct dlm_ctxt *dlm_alloc_ctxt(c
  		goto leave;
  	}

-	for (i=0; i<DLM_HASH_BUCKETS; i++)
+	for (i = 0; i < DLM_HASH_BUCKETS; i++)
  		INIT_HLIST_HEAD(&dlm->lockres_hash[i]);

  	strcpy(dlm->name, domain);

[PATCH] Clean up ocfs2 hash probe and make it faster

Signed-Off-By: Daniel "He's Baaaaack" Phillips <phillips@google.com>

diff -urp 2.6.16.clean/fs/ocfs2/dlm/dlmdomain.c 2.6.16/fs/ocfs2/dlm/dlmdomain.c
--- 2.6.16.clean/fs/ocfs2/dlm/dlmdomain.c	2006-03-02 16:47:47.000000000 -0800
+++ 2.6.16/fs/ocfs2/dlm/dlmdomain.c	2006-03-03 09:53:21.000000000 -0800
@@ -103,31 +103,28 @@ struct dlm_lock_resource * __dlm_lookup_
  					 const char *name,
  					 unsigned int len)
  {
-	unsigned int hash;
-	struct hlist_node *iter;
-	struct dlm_lock_resource *tmpres=NULL;
  	struct hlist_head *bucket;
+	struct hlist_node *list;

  	mlog_entry("%.*s\n", len, name);

  	assert_spin_locked(&dlm->spinlock);
+	bucket = dlm->lockres_hash + full_name_hash(name, len) % DLM_HASH_BUCKETS;

-	hash = full_name_hash(name, len);
+	hlist_for_each(list, bucket) {
+		struct dlm_lock_resource *res = hlist_entry(list,
+			struct dlm_lock_resource, hash_node);

-	bucket = &(dlm->lockres_hash[hash % DLM_HASH_BUCKETS]);
-
-	/* check for pre-existing lock */
-	hlist_for_each(iter, bucket) {
-		tmpres = hlist_entry(iter, struct dlm_lock_resource, hash_node);
-		if (tmpres->lockname.len == len &&
-		    memcmp(tmpres->lockname.name, name, len) == 0) {
-			dlm_lockres_get(tmpres);
-			break;
-		}
-
-		tmpres = NULL;
+		if (likely(res->lockname.name[0] != name[0]))
+			continue;
+		if (likely(res->lockname.len != len))
+			continue;
+		if (likely(memcmp(res->lockname.name + 1, name + 1, len - 1)))
+			continue;
+		dlm_lockres_get(res);
+		return res;
  	}
-	return tmpres;
+	return NULL;
  }

  struct dlm_lock_resource * dlm_lookup_lockres(struct dlm_ctxt *dlm,

