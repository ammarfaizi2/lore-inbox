Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262492AbSLZGku>; Thu, 26 Dec 2002 01:40:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262500AbSLZGku>; Thu, 26 Dec 2002 01:40:50 -0500
Received: from dp.samba.org ([66.70.73.150]:54730 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S262492AbSLZGkt>;
	Thu, 26 Dec 2002 01:40:49 -0500
Date: Thu, 26 Dec 2002 17:48:21 +1100
From: Anton Blanchard <anton@samba.org>
To: torvalds@transmeta.com
Cc: manfred@colorfullife.com, linux-kernel@vger.kernel.org
Subject: [PATCH] 2.5 fast poll on ppc64
Message-ID: <20021226064821.GA21628@krispykreme>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

I was unable to boot 2.5-BK on ppc64 and narrowed it down to the fast
poll patch.  I found:

offsetof(struct poll_list, entries) == 12 but
sizeof(struct poll_list) == 16

This means pp+1 did not match up with pp->entries. Im not sure what the
alignment requirements are for a zero length struct (ie is this a
compiler bug) but the following patch fixes the problem and also changes
->len to a long to ensure 8 byte alignment of ->entries on 64bit archs.

Anton

===== fs/select.c 1.15 vs edited =====
--- 1.15/fs/select.c	Sat Dec 21 20:42:41 2002
+++ edited/fs/select.c	Thu Dec 26 17:31:16 2002
@@ -362,7 +362,7 @@
 
 struct poll_list {
 	struct poll_list *next;
-	int len;
+	long len;
 	struct pollfd entries[0];
 };
 
@@ -471,7 +471,7 @@
 			walk->next = pp;
 
 		walk = pp;
-		if (copy_from_user(pp+1, ufds + nfds-i, 
+		if (copy_from_user(pp->entries, ufds + nfds-i, 
 				sizeof(struct pollfd)*pp->len)) {
 			err = -EFAULT;
 			goto out_fds;
