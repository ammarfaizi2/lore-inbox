Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267730AbUJRWxs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267730AbUJRWxs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Oct 2004 18:53:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267725AbUJRWxr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Oct 2004 18:53:47 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:438 "EHLO e31.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S267683AbUJRWxX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Oct 2004 18:53:23 -0400
Subject: [PATCH 1/3] ext3 reservation remove stale window fix
From: Mingming Cao <cmm@us.ibm.com>
To: akpm@osdl.org, "Stephen C. Tweedie" <sct@redhat.com>
Cc: Badari Pulavarty <pbadari@us.ibm.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       "ext2-devel@lists.sourceforge.net" <ext2-devel@lists.sourceforge.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 18 Oct 2004 15:55:04 -0700
Message-Id: <1098140107.8803.1062.camel@w-ming2.beaverton.ibm.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following patches(3) are one ext3 reservation bug fix and two improvements. (Note this does not include the bug fix we discussed last Friday.) 

Thoughts?

Thanks,
Mingming


Before we changed the per-filesystem reservations from a linked list to a red-black tree, in order to speed up the linear search from the list head, we keep the current(stale) reservation window as a reference pointer to skip the nodes prior to the current/stale window node, when failed to allocate a new window in current group and try to do allocation in next group. 

With the red-black tree change, searching from the root is fast enough so we don't need to keep the current window as a reference pointer to speed up the search.Also, keep the curret/stale window in the tree while try to allocate block in the rest groups could cause the window size being possibly doubled incorrectly: currently the hit ratio bit was not cleared until we find a new window, so when we continue to search a new window in the next group, the current/stale window hit ratio bit is checked again, and window size could be doubled again(wrong!).

This will cause too early to back to block allocation without reservation. This probably explain why we saw random write performance issue when the filesystem is really full before: for every new block in request, we do exaust the whole filesystem with wrong window size, and back to non-reservation block allocation at last.


---

 linux-2.6.9-rc4-mm1-ming/fs/ext3/balloc.c |    7 +++++++
 1 files changed, 7 insertions(+)

diff -puN fs/ext3/balloc.c~ext3_reservation_remove_stale_window fs/ext3/balloc.c
--- linux-2.6.9-rc4-mm1/fs/ext3/balloc.c~ext3_reservation_remove_stale_window	2004-10-18 22:26:44.108077296 -0700
+++ linux-2.6.9-rc4-mm1-ming/fs/ext3/balloc.c	2004-10-18 22:34:55.571363520 -0700
@@ -951,6 +951,13 @@ found_rsv_window:
 	}
 	return 0;		/* succeed */
 failed:
+	/*
+	 * failed to find a new reservation window in the current
+	 * group, remove the current(stale) reservation window
+	 * if there is any
+	 */
+	if (!rsv_is_empty(&my_rsv->rsv_window))
+		rsv_window_remove(sb, my_rsv);
 	return -1;		/* failed */
 }
 

_

