Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266304AbUHMRnn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266304AbUHMRnn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Aug 2004 13:43:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266303AbUHMRnn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Aug 2004 13:43:43 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:727 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S266379AbUHMRl7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Aug 2004 13:41:59 -0400
Date: Fri, 13 Aug 2004 13:20:18 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Sylvain COUTANT <sylvain.coutant@illicom.com>
Cc: linux-kernel@vger.kernel.org, riel@redhat.com, andrea@suse.de
Subject: Re: High CPU usage (up to server hang) under heavy I/O load
Message-ID: <20040813162018.GB29292@logos.cnet>
References: <20040813140229.4F48B2FC2C@illicom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040813140229.4F48B2FC2C@illicom.com>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Sylvain, 

On Fri, Aug 13, 2004 at 04:01:35PM +0200, Sylvain COUTANT wrote:

> I have a problem with one server (DELL, 1 TB RAID5 + RAID0, Bi-Xeon, 8 GB
> RAM) which, sometimes, goes mad when the I/O pressure gets too high. We use
> this server as a VMWare server and as a backup server (200 GB are dedicated
> to the backup part). We have run full hardware diags and checked every
> software that runs on the system. We have been able to reproduce the problem
> once without having launched the VMWare server (so I believe this software
> is not responsible for the problem).
> 
> We have tested kernels 2.4.22 and 2.4.26. The server is running under Debian
> Woody.
> 
> The exact problem is the unix load sometimes goes _very high_ under I/O
> activity (mainly disk writes seem to cause this). Even having just two or
> three tar+gz processes running can cause the 15 minutes load average to get
> as high as 20 or 30 (where we would expect it being between 2 and 4). The
> load can go to so high value that we can't do anything anymore on the server
> during some delay (between a few seconds and a few days). Our Friday night
> backups often hang the server until we unplug the power to reboot on monday
> morning. From what we have seen, it can happen that kswapd and kupdated eats
> up to 70% of one CPU each. 

The algorithms used by v2.4's kswapd/kupdate are not the smartest ones. 

> Otherwise, it's very hard to tell what happens
> exactly because when the server is slowing down we have no possible
> monitoring, no log, no alerts, no automatic reboot (must power off/on to
> reboot), no console alert, ... Just, that it's still pingable !!

Not sure about the high system load. It might be whats expected actually.

The thing is, v2.4 is not the best kernel in the world with reference 
to highmem handling. v2.6 is much better improved in that area.

Anyway, the hang is a bug and must be fixed. I'm unable to reproduce 
such hang on a 16GB box, well...

It might be that you are hitting the deadlock which the following patch 
fixes.

Tasks which are not allowed to get into the memory reservations (which are
used by kswapd/kupdate to be able to free more memory) can do so, and the 
machine deadlocks. 

> We didn't found a way to reproduce this behaviour with a specific test case.
> Sometimes the server will be fine during a few days then slow down and hang.
> Sometimes it will hang just a few hours after having been booted.

You're not able to get sysrq output on the console? It will help if you can 
plug a serial cable and use try to get sysrq output (SysRQ+T 
and SysRQ+P). Have you tried the sysrq thing?

> I have spent hours searching for information and found our problem was very
> common in early 2.4.x kernels (virtual memory management) between 2000 and
> 2002 on servers with large RAM. Only recent information I found was some
> patches related to kernel hanging or something like, but symptoms described
> was never exactly the same as ours.

Those were common in 2.4.2x, but after 2.4.22 (which contains a VM merge
from Andrea's tree, with highmem balancing improvements), this should not
happen anymore. Except this one bug found by Rik.

> I tried to play a little with "/proc/sys/vm/*" settings (mainly bdflush) but
> I didn't found any major improvement (perhaps just because I didn't put in
> the good values). What I was trying to do was reducing the amount of memory
> the kernel could use for dirty buffers, thus having more regular flush to
> disks.
> 
> Hopefully, some people here could be of help ;-))

I'm willing to help and track it down.

You want to try this

# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2004/08/10 17:16:39-03:00 riel@redhat.com 
#   [PATCH] reserved buffers only for PF_MEMALLOC
#   
#   The buffer allocation path in 2.4 has a long standing bug,
#   where non-PF_MEMALLOC tasks can dig into the reserved pool
#   in get_unused_buffer_head().  The following patch makes the
#   reserved pool only accessible to PF_MEMALLOC tasks.
#   
#   Other processes will loop in create_buffers() - the only
#   function that calls get_unused_buffer_head() - and will call
#   try_to_free_pages(GFP_NOIO), freeing any buffer heads that
#   have become freeable due to IO completion.
#   
#   Note that PF_MEMALLOC tasks will NOT do anything inside
#   try_to_free_pages(), so it is needed that they are able to
#   dig into the reserved buffer heads while other tasks are
#   not.
#   
#   Signed-off-by:  Rik van Riel <riel@redhat.com>
# 
# fs/buffer.c
#   2004/08/10 12:34:54-03:00 riel@redhat.com +2 -1
#   reserved buffers only for PF_MEMALLOC
# 
diff -Nru a/fs/buffer.c b/fs/buffer.c
--- a/fs/buffer.c	2004-08-13 10:13:04 -07:00
+++ b/fs/buffer.c	2004-08-13 10:13:04 -07:00
@@ -1260,8 +1260,9 @@
 
 	/*
 	 * If we need an async buffer, use the reserved buffer heads.
+	 * Non-PF_MEMALLOC tasks can just loop in create_buffers().
 	 */
-	if (async) {
+	if (async && (current->flags & PF_MEMALLOC)) {
 		spin_lock(&unused_list_lock);
 		if (unused_list) {
 			bh = unused_list;

