Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268577AbUILJ6M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268577AbUILJ6M (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Sep 2004 05:58:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268588AbUILJ6M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Sep 2004 05:58:12 -0400
Received: from holomorphy.com ([207.189.100.168]:31876 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S268577AbUILJ6I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Sep 2004 05:58:08 -0400
Date: Sun, 12 Sep 2004 02:58:05 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Anton Blanchard <anton@samba.org>
Cc: linux-kernel@vger.kernel.org, mingo@elte.hu,
       viro@parcelfarce.linux.theplanet.co.uk
Subject: Re: /proc/sys/kernel/pid_max issues
Message-ID: <20040912095805.GL2660@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Anton Blanchard <anton@samba.org>, linux-kernel@vger.kernel.org,
	mingo@elte.hu, viro@parcelfarce.linux.theplanet.co.uk
References: <20040912085609.GK32755@krispykreme> <20040912093605.GJ2660@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040912093605.GJ2660@holomorphy.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 12, 2004 at 02:36:05AM -0700, William Lee Irwin III wrote:
> +		if (map > &pidmap_array[pid_max/BITS_PER_PAGE])
> +			map = pidmap_array;
>  		if (unlikely(!map->page)) {
>  			unsigned long page = get_zeroed_page(GFP_KERNEL);

If pid_max == BITS_PER_PAGE*n, none of &pidmap_array[pid_max/BITS_PER_PAGE]
is usable, so if we must complete a full revolution around pidmap_array[]
to discover a free pid slightly less than last_pid we will miss it. Hence:


-- wli

Index: mm4-2.6.9-rc1/kernel/pid.c
===================================================================
--- mm4-2.6.9-rc1.orig/kernel/pid.c	2004-09-08 05:46:18.000000000 -0700
+++ mm4-2.6.9-rc1/kernel/pid.c	2004-09-12 02:46:17.426981200 -0700
@@ -75,6 +75,8 @@
 	while (--*max_steps) {
 		if (++map == map_limit)
 			map = pidmap_array;
+		if (map > &pidmap_array[(pid_max-1)/BITS_PER_PAGE])
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
