Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932515AbVINSbj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932515AbVINSbj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 14:31:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932526AbVINSbj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 14:31:39 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:60357
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S932515AbVINSbi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 14:31:38 -0400
Date: Wed, 14 Sep 2005 11:31:33 -0700 (PDT)
Message-Id: <20050914.113133.78024310.davem@davemloft.net>
To: linux-kernel@vger.kernel.org
CC: torvalds@osdl.org, akpm@osdl.org
Subject: [PATCH]: Brown paper bag in fs/file.c?
From: "David S. Miller" <davem@davemloft.net>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


While tracking down a sparc64 bug, I spotted what seems to be a bug in
__free_fdtable().  (the sparc64 bug is that a user page gets
corrupted, and it's full of kernel filp pointers, I've verified that
the page mapped there is no longer in the SLAB cache, but the filp's
are still active in the SLAB, I've also ruled out cache aliasing and
tlb flushing bugs)

The bug is that free_fd_array() takes a "num" argument, but when
calling it from __free_fdtable() we're instead passing in the size in
bytes (ie. "num * sizeof(struct file *)").

How come this doesn't crash things for people?  Perhaps I'm missing
something.  fs/vmalloc.c should bark very loudly if we call it with a
non-vmalloc area address, since that is what would happen if we pass a
kmalloc() SLAB object address to vfree().

I think I know what might be happening.  If the miscalculation means
that we kfree() the embedded fdarray, that would actually work just
fine, and free up the fdtable.  I guess if the SLAB redzone stuff were
enabled for these caches, it would trigger when something like this
happens.

BTW, in mm/slab.c for FORCED_DEBUG we have:

	if ((size < 4096 || fls(size-1) == fls(size-1+3*BYTES_PER_WORD)))
		flags |= SLAB_RED_ZONE|SLAB_STORE_USER;

Isn't PAGE_SIZE intended here, not the constant "4096"?  Just curious.

I'm about to reboot to see if this fixes the sparc64 problem, with my
luck it probably won't :-)

diff --git a/fs/file.c b/fs/file.c
--- a/fs/file.c
+++ b/fs/file.c
@@ -75,7 +75,7 @@ static void __free_fdtable(struct fdtabl
 	fdarray_size = fdt->max_fds * sizeof(struct file *);
 	free_fdset(fdt->open_fds, fdset_size);
 	free_fdset(fdt->close_on_exec, fdset_size);
-	free_fd_array(fdt->fd, fdarray_size);
+	free_fd_array(fdt->fd, fdt->max_fds);
 	kfree(fdt);
 }
 
