Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263117AbUEBQCi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263117AbUEBQCi (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 May 2004 12:02:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263124AbUEBQCi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 May 2004 12:02:38 -0400
Received: from dragnfire.mtl.istop.com ([66.11.160.179]:37620 "EHLO
	dsl.commfireservices.com") by vger.kernel.org with ESMTP
	id S263117AbUEBQCg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 May 2004 12:02:36 -0400
Date: Sun, 2 May 2004 12:02:38 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
To: Jurriaan <thunder7@xs4all.nl>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.6-rc3-mm1: some sort of deadlock occurs under heavy i/o
In-Reply-To: <20040502112756.GA1463@middle.of.nowhere>
Message-ID: <Pine.LNX.4.58.0405021201130.2332@montezuma.fsmlabs.com>
References: <20040502112756.GA1463@middle.of.nowhere>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2 May 2004, Jurriaan wrote:

> When I do a _lot_ of I/O in 2.6.6-rc3-mm1, I've seen some sort of
> deadlock multiple times now. pinging from outside still works, num-lock
> turns the led on/off, I can switch consoles but otherwise, nothing
> works. The lot of I/O is for example: expiring two large newsspools, and
> reading a large folder in mutt. This worked fine in 2.6.6-rc2-mm2 and
> kernels before that (except that pdflush sometimes started using 100%
> cpu. I've not seen that this time, but this is worse, unfortunately).
>
> This is a single P4, using hyperthreading. In use are reiserfs and ext3,
> raid-1 and linear raid. Alt-sysreq-t produced a large list of processes,
> where the last 3 each had:

Try the following patch from Andrew;

Index: linux-2.6.6-rc3-mm1/mm/vmscan.c
===================================================================
RCS file: /home/cvsroot/linux-2.6.6-rc3-mm1/mm/vmscan.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 vmscan.c
--- linux-2.6.6-rc3-mm1/mm/vmscan.c	1 May 2004 08:19:20 -0000	1.1.1.1
+++ linux-2.6.6-rc3-mm1/mm/vmscan.c	1 May 2004 21:39:36 -0000
@@ -156,7 +156,7 @@ static int shrink_slab(unsigned long sca
 			shrinker->nr = LONG_MAX;	/* It wrapped! */

 		if (shrinker->nr <= SHRINK_BATCH)
-			break;
+			continue;
 		while (shrinker->nr) {
 			long this_scan = shrinker->nr;
 			int shrink_ret;
