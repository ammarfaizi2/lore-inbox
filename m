Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269304AbUIYKtD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269304AbUIYKtD (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Sep 2004 06:49:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269309AbUIYKtD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Sep 2004 06:49:03 -0400
Received: from [203.124.158.219] ([203.124.158.219]:6817 "EHLO
	ganesha.intranet.calsoftinc.com") by vger.kernel.org with ESMTP
	id S269304AbUIYKs7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Sep 2004 06:48:59 -0400
Subject: Performance of del_timer_sync
From: shobhit dayal <shobhit@calsoftinc.com>
Reply-To: shobhit@calsoftinc.com
To: linux-kernel@vger.kernel.org
Cc: geoff@linux.intel.com, akpm@osdl.org
Content-Type: text/plain
Message-Id: <1096110445.12409.86.camel@kuber>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sat, 25 Sep 2004 16:37:25 +0530
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is with reference to the del_timer_sync patch submitted by Geoff
Gustafson http://lwn.net/Articles/84839/.

I profiled a postgress load on a 8p( 4 nodes) NUMA machine. This
profiler logs functions that access memory on remote nodes, and
del_timer_sync was one of the top few functions doing this. The culprit
is the for loop in del_timer_sync that reads the running_timer field of
the per cpu tvec_bases_t structure on all nodes in the system. It gets
invoked most times from del_singleshot_timer_sync.

Andrew Morton had suggested a patch for this, when the top callers to
del_timer sync were schedule_timeout and clear_timeout, the fix being
the  del_single_shot_timer_sync patch,  with the knowledge that
schedule_timeout and clear_timeout do not create timers that re-add
themselves.

This may not be enough, the problem is that schedule_timeout at most
times will call del_single_shot_timer_sync after the timer has expired.
This will cause del_timer to asume that the handler is running on some
cpu and del_timer_sync will still get invoked.

Ofcourse, it also means that del_timer_sync will continue to be a
hotspot as far as taking up cpu time is concerned.

I tried Geoff's patch and it does seem to improve performance.

Has anyone else seen del_timer_sync as a hotspot after the
del_singleshot_timer_sync patch?

regards
Shobhit



				

