Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261258AbVEWXbI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261258AbVEWXbI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 May 2005 19:31:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261245AbVEWX2I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 May 2005 19:28:08 -0400
Received: from fire.osdl.org ([65.172.181.4]:29829 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261220AbVEWXXq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 May 2005 19:23:46 -0400
Date: Mon, 23 May 2005 16:20:16 -0700
From: Chris Wright <chrisw@osdl.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Chuck Wolber <chuckw@quantumlinux.com>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk, cmm@us.ibm.com
Subject: [patch 04/16] ext3: fix race between ext3 make block reservation and reservation window discard
Message-ID: <20050523232016.GP27549@shell0.pdx.osdl.net>
References: <20050523231529.GL27549@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050523231529.GL27549@shell0.pdx.osdl.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixed a race between ext3_discard_reservation() and
ext3_try_to_allocate_with_rsv().

There is a window where ext3_discard_reservation will remove an already
unlinked reservation window node from the filesystem reservation tree:
It thinks the reservation is still linked in the filesystem reservation
tree, but it is actually temperately removed from the tree by
allocate_new_reservation() when it failed to make a new reservation from
the current group and try to make a new reservation from next block
group.

Here is how it could happen:

CPU 1
try to allocate a block in group1 with given reservation window my_rsv
ext3_try_to_allocate_with_rsv(group
	----copy reservation window my_rsv into local rsv_copy
	ext3_try_to_allocate(...rsv_copy)
		----no free block in existing reservation window,
		----need a new reservation window
	spin_lock(&rsv_lock);

CPU 2

ext3_discard_reservation
	if (!rsv_is_empty()
		----this is true
	spin_lock(&rsv_lock)
		----waiting for thread 1

CPU 1:

	allocate_new_reservation
		failed to reserve blocks in this group
		remove the window from the tree
		rsv_window_remove(my_rsv)
			----window node is unlinked from the tree here
		return -1
	spin_unlock(&rsv_lock)
ext3_try_to_allocate_with_rsv() failed in this group
group++

CPU 2
	spin_lock(&rsv_lock) succeed
	rsv_remove_window ()
		---------------break, trying to remove a unlinked node from the tree
	....


CPU 1:
ext3_try_to_allocate_with_rsv(group, my_rsv)
	rsv_is_empty is true, need a new reservation window
	spin_lock(&rsv_lock);
		^--------------- spinning forever

We need to re-check whether the reservation window is still linked to
the tree after grab the rsv_lock spin lock in ext3_discard_reservation,
to prevent panic in rsv_remove_window->rb_erase.

Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Linus Torvalds <torvalds@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 fs/ext3/balloc.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletion(-)

--- linux-2.6.11.10.orig/fs/ext3/balloc.c	2005-05-16 10:50:46.000000000 -0700
+++ linux-2.6.11.10/fs/ext3/balloc.c	2005-05-20 09:36:22.628733736 -0700
@@ -268,7 +268,8 @@
 
 	if (!rsv_is_empty(&rsv->rsv_window)) {
 		spin_lock(rsv_lock);
-		rsv_window_remove(inode->i_sb, rsv);
+		if (!rsv_is_empty(&rsv->rsv_window))
+			rsv_window_remove(inode->i_sb, rsv);
 		spin_unlock(rsv_lock);
 	}
 }
