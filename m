Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261941AbSIYIe6>; Wed, 25 Sep 2002 04:34:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261942AbSIYIe6>; Wed, 25 Sep 2002 04:34:58 -0400
Received: from mx2.elte.hu ([157.181.151.9]:47051 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S261941AbSIYIe5>;
	Wed, 25 Sep 2002 04:34:57 -0400
Date: Wed, 25 Sep 2002 10:48:49 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: "David S. Miller" <davem@redhat.com>, <zaitcev@redhat.com>,
       Oleg Drokin <green@namesys.com>, <linux-kernel@vger.kernel.org>
Subject: [patch] pidhash-2.5.38-A0
In-Reply-To: <Pine.LNX.4.44.0209251024580.4690-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0209251047040.5857-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


the attached patch removes the cmpxchg from the PID allocator and replaces
it with a spinlock. This spinlock is hit only a couple of times per
bootup, so it's not a performance issue.

	Ingo

--- linux/kernel/pid.c.orig	Wed Sep 25 10:36:13 2002
+++ linux/kernel/pid.c	Wed Sep 25 10:38:55 2002
@@ -53,6 +53,8 @@
 
 static pidmap_t *map_limit = pidmap_array + PIDMAP_ENTRIES;
 
+static spinlock_t pidmap_lock __cacheline_aligned_in_smp = SPIN_LOCK_UNLOCKED;
+
 inline void free_pidmap(int pid)
 {
 	pidmap_t *map = pidmap_array + pid / BITS_PER_PAGE;
@@ -77,8 +79,13 @@
 			 * Free the page if someone raced with us
 			 * installing it:
 			 */
-			if (cmpxchg(&map->page, NULL, (void *) page))
+			spin_lock(&pidmap_lock);
+			if (map->page)
 				free_page(page);
+			else
+				map->page = (void *)page;
+			spin_unlock(&pidmap_lock);
+
 			if (!map->page)
 				break;
 		}

