Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263466AbUAEKFJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jan 2004 05:05:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263609AbUAEKFJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jan 2004 05:05:09 -0500
Received: from fmr99.intel.com ([192.55.52.32]:34503 "EHLO
	hermes-pilot.fm.intel.com") by vger.kernel.org with ESMTP
	id S263466AbUAEKFD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jan 2004 05:05:03 -0500
Date: Mon, 5 Jan 2004 17:59:26 +0800 (CST)
From: "Zhu, Yi" <yi.zhu@intel.com>
X-X-Sender: chuyee@mazda.sh.intel.com
Reply-To: "Zhu, Yi" <yi.zhu@intel.com>
To: linux-kernel@vger.kernel.org
Subject: [Bugfix] Set more than 32K pid_max
Message-ID: <Pine.LNX.4.44.0401051745020.23895-100000@mazda.sh.intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I found this is a bug in alloc_pidmap(). If one sets
/proc/sys/kernel/pid_max more than 32768, "map" will
increases 1 at (pid from 32767 to 32768)

110: map = pidmap_array + pid / BITS_PER_PAGE;

But at

126: map = next_free_map(map, &max_steps);

"map" will increase 1 again, because offset == 0.

This is not correct, but only happens when pid_max > 32k.



--- pid.c.old   2004-01-05 14:53:03.000000000 +0800
+++ pid.c       2004-01-05 17:27:53.000000000 +0800
@@ -122,6 +122,8 @@
        }

        if (!offset || !atomic_read(&map->nr_free)) {
+               if (!offset)
+                       map--;
 next_map:
                map = next_free_map(map, &max_steps);
                if (!map)


-- 
-----------------------------------------------------------------
Opinions expressed are those of the author and do not represent
Intel Corp.

Zhu Yi (Chuyee)

GnuPG v1.0.6 (GNU/Linux)
http://cn.geocities.com/chewie_chuyee/gpg.txt or
$ gpg --keyserver wwwkeys.pgp.net --recv-keys 71C34820
1024D/71C34820 C939 2B0B FBCE 1D51 109A  55E5 8650 DB90 71C3 4820

