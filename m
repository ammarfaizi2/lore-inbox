Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261685AbREZCMU>; Fri, 25 May 2001 22:12:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261735AbREZCMK>; Fri, 25 May 2001 22:12:10 -0400
Received: from host154.207-175-42.redhat.com ([207.175.42.154]:16234 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S261685AbREZCL7>; Fri, 25 May 2001 22:11:59 -0400
Date: Fri, 25 May 2001 22:11:40 -0400 (EDT)
From: Ben LaHaise <bcrl@redhat.com>
X-X-Sender: <bcrl@toomuch.toronto.redhat.com>
To: Andrea Arcangeli <andrea@suse.de>
cc: Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Rik van Riel <riel@conectiva.com.br>, <linux-kernel@vger.kernel.org>
Subject: Re: Linux-2.4.5
In-Reply-To: <20010526035936.P9634@athlon.random>
Message-ID: <Pine.LNX.4.33.0105252206550.3806-100000@toomuch.toronto.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 26 May 2001, Andrea Arcangeli wrote:

> Now if you send some debugging info with deadlocks you gets with 2.4.5
> vanilla I will be certainly interested to found their source. Also Rik
> just said to have a fix for other bugs in that area, I didn't checked
> that part.

In the red hat tree, we fixed the problem by adding __GFP_FAIL to
GFP_BUFFER, as well as adding a yield to alloc_pages.  Think of what
happens when you try to allocate a buffer_head to swap out a page when
you're out of memory.  See below.

		-ben

diff -ur v2.4.4-ac9/include/linux/mm.h work/include/linux/mm.h
--- v2.4.4-ac9/include/linux/mm.h	Mon May 14 15:22:17 2001
+++ work/include/linux/mm.h	Mon May 14 18:33:21 2001
@@ -528,7 +528,7 @@


 #define GFP_BOUNCE	(__GFP_HIGH | __GFP_FAIL)
-#define GFP_BUFFER	(__GFP_HIGH | __GFP_WAIT)
+#define GFP_BUFFER	(__GFP_HIGH | __GFP_FAIL | __GFP_WAIT)
 #define GFP_ATOMIC	(__GFP_HIGH)
 #define GFP_USER	(             __GFP_WAIT | __GFP_IO)
 #define GFP_HIGHUSER	(             __GFP_WAIT | __GFP_IO | __GFP_HIGHMEM)
diff -ur v2.4.4-ac9/mm/vmscan.c work/mm/vmscan.c
--- v2.4.4-ac9/mm/vmscan.c	Mon May 14 14:57:00 2001
+++ work/mm/vmscan.c	Mon May 14 16:43:05 2001
@@ -636,6 +636,12 @@
 	 */
 	shortage = free_shortage();
 	if (can_get_io_locks && !launder_loop && shortage) {
+		if (gfp_mask & __GFP_WAIT) {
+			__set_current_state(TASK_RUNNING);
+			current->policy |= SCHED_YIELD;
+			schedule();
+		}
+
 		launder_loop = 1;

 		/*

