Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268581AbUILJiN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268581AbUILJiN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Sep 2004 05:38:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268576AbUILJiM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Sep 2004 05:38:12 -0400
Received: from holomorphy.com ([207.189.100.168]:24708 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S268592AbUILJgJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Sep 2004 05:36:09 -0400
Date: Sun, 12 Sep 2004 02:36:05 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Anton Blanchard <anton@samba.org>
Cc: linux-kernel@vger.kernel.org, mingo@elte.hu,
       viro@parcelfarce.linux.theplanet.co.uk
Subject: Re: /proc/sys/kernel/pid_max issues
Message-ID: <20040912093605.GJ2660@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Anton Blanchard <anton@samba.org>, linux-kernel@vger.kernel.org,
	mingo@elte.hu, viro@parcelfarce.linux.theplanet.co.uk
References: <20040912085609.GK32755@krispykreme>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040912085609.GK32755@krispykreme>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 12, 2004 at 06:56:09PM +1000, Anton Blanchard wrote:
> I tried creating 100,000 threads just for the hell of it. I was
> surprised that it appears to have worked even with pid_max set at 32k.
> It seems if we are above pid_max we wrap back to RESERVED_PIDS at the
> start of alloc_pidmap but do not enforce this upper limit. I guess every
> call of alloc_pidmap above 32k was wrapping back to RESERVED_PIDS,
> walking the allocated space then allocating off the end.

Well, it looks like things blindly move to the next bitmap block and
don't check that the offset within it is valid, so the patch below
(not runtime or compile-time tested) may help. It relies on
next_free_map() returning NULL after having cycled through enough of
the bitmap blocks.


On Sun, Sep 12, 2004 at 06:56:09PM +1000, Anton Blanchard wrote:
> Just as an aside, does it make sense to remove the pidmap allocator and
> use the IDR allocator now its there?
> Now once I had managed to allocate those 100,000 threads, I noticed
> this:
> 18446744071725383682 dr-xr-xr-x   3 root root   0 Sep 12 08:10 100796
> Strange huh. Turns out we allocate inodes in proc via:
> #define fake_ino(pid,ino) (((pid)<<16)|(ino))
> With 32bit inodes we are screwed once pids go over 64k arent we?

The /proc/ code is rather messy around this area so I don't have any
immediate ideas there.


-- wli


Index: mm4-2.6.9-rc1/kernel/pid.c
===================================================================
--- mm4-2.6.9-rc1.orig/kernel/pid.c	2004-09-08 05:46:18.000000000 -0700
+++ mm4-2.6.9-rc1/kernel/pid.c	2004-09-12 02:25:37.679451472 -0700
@@ -75,6 +75,8 @@
 	while (--*max_steps) {
 		if (++map == map_limit)
 			map = pidmap_array;
+		if (map > &pidmap_array[pid_max/BITS_PER_PAGE])
+			map = pidmap_array;
 		if (unlikely(!map->page)) {
 			unsigned long page = get_zeroed_page(GFP_KERNEL);
 			/*
@@ -135,13 +137,12 @@
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
