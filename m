Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268591AbUILKNi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268591AbUILKNi (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Sep 2004 06:13:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268594AbUILKNh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Sep 2004 06:13:37 -0400
Received: from mx1.elte.hu ([157.181.1.137]:30674 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S268591AbUILKMf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Sep 2004 06:12:35 -0400
Date: Sun, 12 Sep 2004 12:13:50 +0200
From: Ingo Molnar <mingo@elte.hu>
To: William Lee Irwin III <wli@holomorphy.com>,
       Anton Blanchard <anton@samba.org>, linux-kernel@vger.kernel.org,
       viro@parcelfarce.linux.theplanet.co.uk
Subject: Re: /proc/sys/kernel/pid_max issues
Message-ID: <20040912101350.GA13164@elte.hu>
References: <20040912085609.GK32755@krispykreme> <20040912093605.GJ2660@holomorphy.com> <20040912095805.GL2660@holomorphy.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="SLDf9lqlvOQaIe6s"
Content-Disposition: inline
In-Reply-To: <20040912095805.GL2660@holomorphy.com>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--SLDf9lqlvOQaIe6s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


* William Lee Irwin III <wli@holomorphy.com> wrote:

> If pid_max == BITS_PER_PAGE*n, none of
> &pidmap_array[pid_max/BITS_PER_PAGE] is usable, so if we must complete
> a full revolution around pidmap_array[] to discover a free pid
> slightly less than last_pid we will miss it. Hence:

yeah. Patch needs testing ...

>  		if (++map == map_limit)
>  			map = pidmap_array;
> +		if (map > &pidmap_array[(pid_max-1)/BITS_PER_PAGE])
> +			map = pidmap_array;

in fact we can now merge the max_limit and pid_max checks - see the
attached updated patch.

	Ingo

--SLDf9lqlvOQaIe6s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="pid-max-fix.patch"


fix pid_max handling. Wrap around correctly.

Signed-off-by: William Lee Irwin III <wli@holomorphy.com>
Signed-off-by: Ingo Molnar <mingo@elte.hu>

--- linux/kernel/pid.c.orig	
+++ linux/kernel/pid.c	
@@ -53,8 +53,6 @@ typedef struct pidmap {
 static pidmap_t pidmap_array[PIDMAP_ENTRIES] =
 	 { [ 0 ... PIDMAP_ENTRIES-1 ] = { ATOMIC_INIT(BITS_PER_PAGE), NULL } };
 
-static pidmap_t *map_limit = pidmap_array + PIDMAP_ENTRIES;
-
 static spinlock_t pidmap_lock __cacheline_aligned_in_smp = SPIN_LOCK_UNLOCKED;
 
 fastcall void free_pidmap(int pid)
@@ -73,7 +71,9 @@ fastcall void free_pidmap(int pid)
 static inline pidmap_t *next_free_map(pidmap_t *map, int *max_steps)
 {
 	while (--*max_steps) {
-		if (++map == map_limit)
+		pidmap_t *map_limit = pidmap_array + (pid_max-1)/BITS_PER_PAGE;
+
+		if (++map > map_limit)
 			map = pidmap_array;
 		if (unlikely(!map->page)) {
 			unsigned long page = get_zeroed_page(GFP_KERNEL);
@@ -133,13 +133,12 @@ next_map:
 	 */
 scan_more:
 	offset = find_next_zero_bit(map->page, BITS_PER_PAGE, offset);
-	if (offset >= BITS_PER_PAGE)
+	pid = (map - pidmap_array) * BITS_PER_PAGE + offset;
+	if (offset >= BITS_PER_PAGE || pid >= pid_max)
 		goto next_map;
 	if (test_and_set_bit(offset, map->page))
 		goto scan_more;
-
 	/* we got the PID: */
-	pid = (map - pidmap_array) * BITS_PER_PAGE + offset;
 	goto return_pid;
 
 failure:

--SLDf9lqlvOQaIe6s--
