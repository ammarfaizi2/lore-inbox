Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268637AbUILKpc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268637AbUILKpc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Sep 2004 06:45:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268650AbUILKpc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Sep 2004 06:45:32 -0400
Received: from holomorphy.com ([207.189.100.168]:47236 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S268637AbUILKp2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Sep 2004 06:45:28 -0400
Date: Sun, 12 Sep 2004 03:45:24 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Anton Blanchard <anton@samba.org>, linux-kernel@vger.kernel.org,
       viro@parcelfarce.linux.theplanet.co.uk
Subject: Re: /proc/sys/kernel/pid_max issues
Message-ID: <20040912104524.GO2660@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Ingo Molnar <mingo@elte.hu>, Anton Blanchard <anton@samba.org>,
	linux-kernel@vger.kernel.org,
	viro@parcelfarce.linux.theplanet.co.uk
References: <20040912085609.GK32755@krispykreme> <20040912093605.GJ2660@holomorphy.com> <20040912095805.GL2660@holomorphy.com> <20040912101350.GA13164@elte.hu> <20040912104314.GN2660@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040912104314.GN2660@holomorphy.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 12, 2004 at 03:43:14AM -0700, William Lee Irwin III wrote:
> I like the update. But I see other issues. For instance (also untested):
> pid wrapping doesn't honor RESERVED_PIDS.

Also:

last_pid is not honored because next_free_map(map - 1, ...) may return
the same map and so restart with a lesser offset.

Index: mm4-2.6.9-rc1/kernel/pid.c
===================================================================
--- mm4-2.6.9-rc1.orig/kernel/pid.c	2004-09-12 03:26:50.063164288 -0700
+++ mm4-2.6.9-rc1/kernel/pid.c	2004-09-12 03:32:11.501298264 -0700
@@ -120,10 +120,12 @@
 		last_pid = pid;
 		return pid;
 	}
-	
-	if (!offset || !atomic_read(&map->nr_free)) {
-		if (!offset)
-			map--;
+	if (!offset) {
+		if (!atomic_read(&map->nr_free))
+			goto next_map;
+		else
+			goto scan_more;
+	} else if (!atomic_read(&map->nr_free)) {
 next_map:
 		map = next_free_map(map, &max_steps);
 		if (!map)
