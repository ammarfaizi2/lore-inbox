Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268753AbUILRN6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268753AbUILRN6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Sep 2004 13:13:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268754AbUILRN6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Sep 2004 13:13:58 -0400
Received: from holomorphy.com ([207.189.100.168]:21894 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S268753AbUILRN0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Sep 2004 13:13:26 -0400
Date: Sun, 12 Sep 2004 10:13:19 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Anton Blanchard <anton@samba.org>, linux-kernel@vger.kernel.org,
       viro@parcelfarce.linux.theplanet.co.uk
Subject: Re: /proc/sys/kernel/pid_max issues
Message-ID: <20040912171319.GR2660@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Ingo Molnar <mingo@elte.hu>, Anton Blanchard <anton@samba.org>,
	linux-kernel@vger.kernel.org,
	viro@parcelfarce.linux.theplanet.co.uk
References: <20040912085609.GK32755@krispykreme> <20040912093605.GJ2660@holomorphy.com> <20040912095805.GL2660@holomorphy.com> <20040912101350.GA13164@elte.hu> <20040912104314.GN2660@holomorphy.com> <20040912104524.GO2660@holomorphy.com> <20040912110810.GQ2660@holomorphy.com> <20040912112026.GA16678@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040912112026.GA16678@elte.hu>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* William Lee Irwin III <wli@holomorphy.com> wrote:
>> Forgot to check map->page in the first spin:
>> last_pid is not honored because next_free_map(map - 1, ...) may return
>> the same map and so restart with a lesser offset.

On Sun, Sep 12, 2004 at 01:20:26PM +0200, Ingo Molnar wrote:
> it's getting quite spaghetti ... do we really want to handle
> RESERVED_PID? There's no guarantee that any root daemon wont stray out
> of the 1...300 PID range anyway, so if it has an exploitable PID race
> bug then it's probably exploitable even without the RESERVED_PID
> protection.

I presumed it was merely cosmetic, so daemons around system startup
will get low pid numbers recognizable by sysadmins. Maybe filtering
process listings for pids < 300 is/was used to find daemons that may
have crashed? I'm not particularly attached to the feature, and have
never used it myself, but merely noticed its implementation was off.

Spaghetti may mean it's time to rewrite things. The following is a
goto-less alloc_pidmap() vs. 2.6.9-rc1-mm4 addressing all stated
concerns, but otherwise changing none of the semantics. Untested.


-- wli

Index: mm4-2.6.9-rc1/kernel/pid.c
===================================================================
--- mm4-2.6.9-rc1.orig/kernel/pid.c	2004-09-08 05:46:18.000000000 -0700
+++ mm4-2.6.9-rc1/kernel/pid.c	2004-09-12 09:44:52.586896544 -0700
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
@@ -66,15 +67,16 @@
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
+	int i, offset, pid = last_pid + 1;
+	pidmap_t *map;
+
+	if (pid >= pid_max)
+		pid = RESERVED_PIDS;
+	offset = pid & BITS_PER_PAGE_MASK;
+	map = &pidmap_array[pid/BITS_PER_PAGE];
+	for (i = 0; i < PIDMAP_ENTRIES; ++i) {
 		if (unlikely(!map->page)) {
 			unsigned long page = get_zeroed_page(GFP_KERNEL);
 			/*
@@ -87,64 +89,29 @@
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
+			} while (offset < BITS_PER_PAGE && pid < pid_max);
+		}
+		if (map < &pidmap_array[(pid_max-1)/BITS_PER_PAGE]) {
+			++map;
+			offset = 0;
+		} else {
+			map = &pidmap_array[0];
+			offset = RESERVED_PIDS;
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
 
