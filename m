Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750901AbWBQVDm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750901AbWBQVDm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Feb 2006 16:03:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751797AbWBQVDm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Feb 2006 16:03:42 -0500
Received: from mx1.redhat.com ([66.187.233.31]:58242 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750901AbWBQVDl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Feb 2006 16:03:41 -0500
Date: Fri, 17 Feb 2006 16:03:32 -0500 (EST)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@cuia.boston.redhat.com
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
cc: linux-kernel@vger.kernel.org, Larry Woodman <lwoodman@redhat.com>
Subject: [PATCH] fix overflow in inode.c
Message-ID: <Pine.LNX.4.63.0602171557210.16053@cuia.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following patch fixes an overflow in inode.c.  This overflow can
cause a system to stop reclaiming inodes, with a large amount of memory 
and zillions of inodes.  This has caused systems to run out of low
memory in real world situations.

Thanks go out to Larry Woodman, as well as the unnamed customer who
first tracked this problem down.  You know who you are.


Signed-off-by: Rik van Riel <riel@redhat.com>
Signed-off-by: Larry Woodman <lwoodman@redhat.com>

--- linux-2.4.32/fs/inode.c.overflow	2006-02-17 15:55:16.000000000 -0500
+++ linux-2.4.32/fs/inode.c	2006-02-17 15:56:37.000000000 -0500
@@ -854,8 +854,8 @@ void prune_icache(int goal)
 	 */
 	if (goal <= 0)
 		return;
-	if (inodes_stat.nr_unused * sizeof(struct inode) * 10 <
-				freeable_lowmem() * PAGE_SIZE)
+	if (inodes_stat.nr_unused <
+	    (freeable_lowmem() * PAGE_SIZE) / (sizeof(struct inode) * 10))
 		return;
 
 	wakeup_bdflush();
