Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261899AbTDQTJQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Apr 2003 15:09:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261903AbTDQTJQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Apr 2003 15:09:16 -0400
Received: from [12.47.58.203] ([12.47.58.203]:46022 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S261899AbTDQTJO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Apr 2003 15:09:14 -0400
Date: Thu, 17 Apr 2003 12:21:42 -0700
From: Andrew Morton <akpm@digeo.com>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: [patch] Fix orlov allocator boundary case
Message-Id: <20030417122142.39d27f73.akpm@digeo.com>
In-Reply-To: <20030417111303.706d7246.shemminger@osdl.org>
References: <20030417111303.706d7246.shemminger@osdl.org>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 17 Apr 2003 19:21:05.0019 (UTC) FILETIME=[7D8B0CB0:01C30516]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Hemminger <shemminger@osdl.org> wrote:
>
> Recent (post 2.5.67) versions of the kernel break the creation
> of the initial ram disk.

OK, here be the fix.

I'm a bit peeved that this wasn't discovered until it hit Linus's tree. 
Weren't these patches in -mjb as well?





In the interests of SMP scalability the ext2 free blocks and free inodes
counters are "approximate".  But there is a piece of code in the Orlov
allocator which fails due to boundary conditions on really small
filesystems.

Fix that up via a final allocation pass which simply uses first-fit for
allocation of a directory inode.


 fs/ext2/ialloc.c |    9 +++++++++
 1 files changed, 9 insertions(+)

diff -puN fs/ext2/ialloc.c~orlov-approx-counter-fix fs/ext2/ialloc.c
--- 25/fs/ext2/ialloc.c~orlov-approx-counter-fix	2003-04-17 12:12:33.000000000 -0700
+++ 25-akpm/fs/ext2/ialloc.c	2003-04-17 12:14:09.000000000 -0700
@@ -410,6 +410,15 @@ fallback:
 			goto found;
 	}
 
+	if (avefreei) {
+		/*
+		 * The free-inodes counter is approximate, and for really small
+		 * filesystems the above test can fail to find any blockgroups
+		 */
+		avefreei = 0;
+		goto fallback;
+	}
+
 	return -1;
 
 found:

_

