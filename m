Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265866AbUAFDGl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jan 2004 22:06:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265907AbUAFDGl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jan 2004 22:06:41 -0500
Received: from fmr02.intel.com ([192.55.52.25]:16830 "EHLO
	caduceus.fm.intel.com") by vger.kernel.org with ESMTP
	id S265866AbUAFDGj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jan 2004 22:06:39 -0500
Date: Tue, 6 Jan 2004 11:00:50 +0800 (CST)
From: "Zhu, Yi" <yi.zhu@intel.com>
X-X-Sender: chuyee@mazda.sh.intel.com
Reply-To: "Zhu, Yi" <yi.zhu@intel.com>
To: Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>
cc: linux-kernel@vger.kernel.org
Subject: [Bugfix] Set more than 32K pid_max (reformatted)
In-Reply-To: <Pine.LNX.4.44.0401051745020.23895-100000@mazda.sh.intel.com>
Message-ID: <Pine.LNX.4.44.0401061042580.26260-100000@mazda.sh.intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Andrew and Ingo,

Would any of you review the below patch? I think it is a bug and the fix
is obvious. The bug can be reproduced as follow:

$ echo 40000 > /proc/sys/kernel/pid_max
$ # suppose current latest pid is 2198
$ for((i=2199;i<32768;i++));do ps; done
$ ps
  PID TTY          TIME CMD
 2274 pts/0    00:00:00 bash
 65536 pts/0    00:00:00 ps
$ ps
  PID TTY          TIME CMD
 2274 pts/0    00:00:00 bash
 300 pts/0    00:00:00 ps


Thanks Petri Koistinen reformatted the patch as follow.

--- linux-2.5/kernel/pid.c.orig 2004-01-05 17:54:46.000000000 +0200
+++ linux-2.5/kernel/pid.c      2004-01-05 17:55:35.000000000 +0200
@@ -122,6 +122,8 @@
        }

        if (!offset || !atomic_read(&map->nr_free)) {
+               if (!offser)
+                       map--;
 next_map:
                map = next_free_map(map, &max_steps);
                if (!map)


On Mon, 5 Jan 2004, Zhu, Yi wrote:
> 
> I found this is a bug in alloc_pidmap(). If one sets
> /proc/sys/kernel/pid_max more than 32768, "map" will
> increases 1 at (pid from 32767 to 32768)
> 
> 110: map = pidmap_array + pid / BITS_PER_PAGE;
> 
> But at
> 
> 126: map = next_free_map(map, &max_steps);
> 
> "map" will increase 1 again, because offset == 0.
> 
> This is not correct, but only happens when pid_max > 32k.

-- 
-----------------------------------------------------------------
Opinions expressed are those of the author and do not represent
Intel Corp.

Zhu Yi (Chuyee)

GnuPG v1.0.6 (GNU/Linux)
http://cn.geocities.com/chewie_chuyee/gpg.txt or
$ gpg --keyserver wwwkeys.pgp.net --recv-keys 71C34820
1024D/71C34820 C939 2B0B FBCE 1D51 109A  55E5 8650 DB90 71C3 4820

