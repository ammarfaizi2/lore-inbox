Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135671AbRD2CKK>; Sat, 28 Apr 2001 22:10:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135672AbRD2CKA>; Sat, 28 Apr 2001 22:10:00 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:47824 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S135671AbRD2CJn>;
	Sat, 28 Apr 2001 22:09:43 -0400
Date: Sat, 28 Apr 2001 22:09:40 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] prune_icache() fix
Message-ID: <Pine.GSO.4.21.0104282201130.321-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Look and enjoy. If prune_icache() doesn't shoot its goal, it
tries to sync some dirty inodes and look for freeable ones one more
time. The sad thing being, counter is not reset on the second pass.
I.e. you end up with nr_unused decremented by 2 * freed_at_the_first_pass +
freed_at_the_second_pass.
	Result: underestimated nr_unused. Since that's what we use for
determining the pressure on icache...

	Seeing negative number in /proc/sys/fs/inode-nr is... well, an
interesting experience.
 
	Please, apply the patch below.
								Al
PS: _Ouch_. 6 hours of hunting for this one.

diff -urN S4/fs/inode.c S4-prune_icache/fs/inode.c
--- S4/fs/inode.c	Sat Apr 28 02:12:56 2001
+++ S4-prune_icache/fs/inode.c	Sat Apr 28 21:37:25 2001
@@ -612,12 +612,13 @@
 {
 	LIST_HEAD(list);
 	struct list_head *entry, *freeable = &list;
-	int count = 0, synced = 0;
+	int count, synced = 0;
 	struct inode * inode;
 
 	spin_lock(&inode_lock);
 
 free_unused:
+	count = 0;
 	entry = inode_unused.prev;
 	while (entry != &inode_unused)
 	{

