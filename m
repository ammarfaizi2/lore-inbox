Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264881AbUIMBrA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264881AbUIMBrA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Sep 2004 21:47:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264903AbUIMBrA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Sep 2004 21:47:00 -0400
Received: from holomorphy.com ([207.189.100.168]:20616 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S264881AbUIMBqv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Sep 2004 21:46:51 -0400
Date: Sun, 12 Sep 2004 18:46:44 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Anton Blanchard <anton@samba.org>, linux-kernel@vger.kernel.org,
       viro@parcelfarce.linux.theplanet.co.uk, akpm@osdl.org
Subject: [pidhashing] rewrite alloc_pidmap()
Message-ID: <20040913014644.GT2660@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Ingo Molnar <mingo@elte.hu>, Anton Blanchard <anton@samba.org>,
	linux-kernel@vger.kernel.org,
	viro@parcelfarce.linux.theplanet.co.uk, akpm@osdl.org
References: <20040912085609.GK32755@krispykreme> <20040912093605.GJ2660@holomorphy.com> <20040912095805.GL2660@holomorphy.com> <20040912101350.GA13164@elte.hu> <20040912104314.GN2660@holomorphy.com> <20040912104524.GO2660@holomorphy.com> <20040912110810.GQ2660@holomorphy.com> <20040912112026.GA16678@elte.hu> <20040912171319.GR2660@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040912171319.GR2660@holomorphy.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 12, 2004 at 10:13:19AM -0700, William Lee Irwin III wrote:
> Spaghetti may mean it's time to rewrite things. The following is a
> goto-less alloc_pidmap() vs. 2.6.9-rc1-mm4 addressing all stated
> concerns, but otherwise changing none of the semantics. Untested.

The original version was broken wrt. wrapping.

It needs to allow enough iterations to return to the same block as we
started to allow fallback to go as far as just behind last_pid in the
same bitmap block that covers last_pid when last_pid + 1 is
BITS_PER_PAGE-unaligned. Also remove redundant scanning by bounding the
loop according to pid_max, the saved last_pid, and the alignment of
offset, as such prevents rapid-fire pid reuse by avoiding scanning any
part of the bitmap more than once or out of cyclic order starting from
last_pid + 1, never reusing the last_pid seen in a given call in that
call. The corner cases aren't that easily reproducible, but it's best
to find glaring errors early, so I've compiled and booted this now that
I'm back at home, and checked that it boots okay, generates reasonable
pid lists, and doesn't fall over or allocate pids below RESERVED_PIDS
during pid wraps on x86-64.

vs. 2.6.9-rc1-mm4. Patch description follows signature.


-- wli

Rewrite alloc_pidmap() to clarify control flow by eliminating all usage
of goto, honor pid_max and first available pid after last_pid semantics,
make only a single pass over the used portion of the pid bitmap, and
update copyrights to reflect ongoing maintenance by Ingo and myself.

Signed-off-by: William Irwin <wli@holomorphy.com>

Index: mm4-2.6.9-rc1/kernel/pid.c
===================================================================
--- mm4-2.6.9-rc1.orig/kernel/pid.c	2004-09-08 05:46:18.000000000 -0700
+++ mm4-2.6.9-rc1/kernel/pid.c	2004-09-12 17:24:44.265323848 -0700
@@ -1,8 +1,8 @@
 /*
  * Generic pidhash and scalable, time-bounded PID allocator
  *
- * (C) 2002 William Irwin, IBM
- * (C) 2002 Ingo Molnar, Red Hat
+ * (C) 2002-2004 William Irwin, Oracle
+ * (C) 2002-2004 Ingo Molnar, Red Hat
  *
  * pid-structures are backing objects for tasks sharing a given ID to chain
  * against. There is very little to them aside from hashing them and
@@ -38,6 +38,9 @@
 #define PIDMAP_ENTRIES		(PID_MAX_LIMIT/PAGE_SIZE/8)
 #define BITS_PER_PAGE		(PAGE_SIZE*8)
 #define BITS_PER_PAGE_MASK	(BITS_PER_PAGE-1)
+#define mk_pid(map, off)	(((map) - pidmap_array)*BITS_PER_PAGE + (off))
+#define find_next_offset(map, off)					\
+		find_next_zero_bit((map)->page, BITS_PER_PAGE, off)
 
 /*
  * PID-map pages start out as NULL, they get allocated upon
@@ -53,8 +56,6 @@
 static pidmap_t pidmap_array[PIDMAP_ENTRIES] =
 	 { [ 0 ... PIDMAP_ENTRIES-1 ] = { ATOMIC_INIT(BITS_PER_PAGE), NULL } };
 
-static pidmap_t *map_limit = pidmap_array + PIDMAP_ENTRIES;
-
 static spinlock_t pidmap_lock __cacheline_aligned_in_smp = SPIN_LOCK_UNLOCKED;
 
 fastcall void free_pidmap(int pid)
@@ -66,15 +67,18 @@
 	atomic_inc(&map->nr_free);
 }
 
-/*
- * Here we search for the next map that has free bits left.
- * Normally the next map has free PIDs.
- */
-static inline pidmap_t *next_free_map(pidmap_t *map, int *max_steps)
+int alloc_pidmap(void)
 {
-	while (--*max_steps) {
-		if (++map == map_limit)
-			map = pidmap_array;
+	int i, offset, max_scan, pid, last = last_pid;
+	pidmap_t *map;
+
+	pid = last + 1;
+	if (pid >= pid_max)
+		pid = RESERVED_PIDS;
+	offset = pid & BITS_PER_PAGE_MASK;
+	map = &pidmap_array[pid/BITS_PER_PAGE];
+	max_scan = (pid_max + BITS_PER_PAGE - 1)/BITS_PER_PAGE - !offset;
+	for (i = 0; i <= max_scan; ++i) {
 		if (unlikely(!map->page)) {
 			unsigned long page = get_zeroed_page(GFP_KERNEL);
 			/*
@@ -87,64 +91,39 @@
 			else
 				map->page = (void *)page;
 			spin_unlock(&pidmap_lock);
-
-			if (!map->page)
+			if (unlikely(!map->page))
 				break;
 		}
-		if (atomic_read(&map->nr_free))
-			return map;
-	}
-	return NULL;
-}
-
-int alloc_pidmap(void)
-{
-	int pid, offset, max_steps = PIDMAP_ENTRIES + 1;
-	pidmap_t *map;
-
-	pid = last_pid + 1;
-	if (pid >= pid_max)
-		pid = RESERVED_PIDS;
-
-	offset = pid & BITS_PER_PAGE_MASK;
-	map = pidmap_array + pid / BITS_PER_PAGE;
-
-	if (likely(map->page && !test_and_set_bit(offset, map->page))) {
-		/*
-		 * There is a small window for last_pid updates to race,
-		 * but in that case the next allocation will go into the
-		 * slowpath and that fixes things up.
-		 */
-return_pid:
-		atomic_dec(&map->nr_free);
-		last_pid = pid;
-		return pid;
-	}
-	
-	if (!offset || !atomic_read(&map->nr_free)) {
-		if (!offset)
-			map--;
-next_map:
-		map = next_free_map(map, &max_steps);
-		if (!map)
-			goto failure;
-		offset = 0;
+		if (likely(atomic_read(&map->nr_free))) {
+			do {
+				if (!test_and_set_bit(offset, map->page)) {
+					atomic_dec(&map->nr_free);
+					last_pid = pid;
+					return pid;
+				}
+				offset = find_next_offset(map, offset);
+				pid = mk_pid(map, offset);
+			/*
+			 * find_next_offset() found a bit, the pid from it
+			 * is in-bounds, and if we fell back to the last
+			 * bitmap block and the final block was the same
+			 * as the starting point, pid is before last_pid.
+			 */
+			} while (offset < BITS_PER_PAGE && pid < pid_max &&
+					(i != max_scan || pid < last ||
+					    !((last+1) & BITS_PER_PAGE_MASK)));
+		}
+		if (map < &pidmap_array[(pid_max-1)/BITS_PER_PAGE]) {
+			++map;
+			offset = 0;
+		} else {
+			map = &pidmap_array[0];
+			offset = RESERVED_PIDS;
+			if (unlikely(last == offset))
+				break;
+		}
+		pid = mk_pid(map, offset);
 	}
-	/*
-	 * Find the next zero bit:
-	 */
-scan_more:
-	offset = find_next_zero_bit(map->page, BITS_PER_PAGE, offset);
-	if (offset >= BITS_PER_PAGE)
-		goto next_map;
-	if (test_and_set_bit(offset, map->page))
-		goto scan_more;
-
-	/* we got the PID: */
-	pid = (map - pidmap_array) * BITS_PER_PAGE + offset;
-	goto return_pid;
-
-failure:
 	return -1;
 }
 
