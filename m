Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262406AbTJTOMo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Oct 2003 10:12:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262572AbTJTOMo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Oct 2003 10:12:44 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:19068 "EHLO
	MTVMIME03.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S262406AbTJTOMl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Oct 2003 10:12:41 -0400
Date: Mon, 20 Oct 2003 15:12:40 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] filemap ffffffffull bogosity
Message-ID: <Pine.LNX.4.44.0310201508190.12575-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcelo,

Here's the 2.4.23-pre7 version of a fix we made in 2.5.67 at beginning
of April, following discussion with Alan on LKML.  Last week I verified
that current code indeed behaves very wrongly with "ulimit -f 5000000"
on ia64 (writes write more than the specified count).

When handling rlimit != RLIM_INFINITY, precheck_file_write tests file
position against 0xFFFFFFFFULL, and casts it to a u32.  This code is
carried forward from 2.4.4, and 2.4-ac tree used to have an apparently
obvious fix to one part of it (should set count to 0 not to a negative).
But when you think it through, it all turns out to be bogus.

On a 32-bit architecture: limit is a 32-bit unsigned long, we've
already handled *pos < 0 and *pos >= limit, so *pos here has no way
of being > 0xFFFFFFFFULL, and thus casting it to u32 won't truncate it.
And on a 64-bit architecture: limit is a 64-bit unsigned long, but this
code is disallowing file position beyond the 32 bits; or if there's some
userspace compatibility issue, with limit having to fit into 32 bits,
the 32-bit architecture argument applies and they're still irrelevant.

So just remove the 0xFFFFFFFFULL test; and in place of the u32, cast to
typeof(limit) so it's right even if rlimits get wider.  And there's no
way we'd want to send SIGXFSZ below the limit: remove send_sig comment.

There's a similarly suspicious u32 cast a little further down, when
checking MAX_NON_LFS.  Given its definition, that does no harm on any
arch: but it's better changed to unsigned long, the type of MAX_NON_LFS.

Hugh

--- 2.4.23-pre7/mm/filemap.c	2003-10-10 21:32:07.000000000 +0100
+++ linux/mm/filemap.c	2003-10-10 21:33:37.000000000 +0100
@@ -3031,9 +3031,8 @@
 			send_sig(SIGXFSZ, current, 0);
 			goto out;
 		}
-		if (pos > 0xFFFFFFFFULL || *count > limit - (u32)pos) {
-			/* send_sig(SIGXFSZ, current, 0); */
-			*count = limit - (u32)pos;
+		if (*count > limit - (typeof(limit))pos) {
+			*count = limit - (typeof(limit))pos;
 		}
 	}
 
@@ -3045,9 +3044,8 @@
 			send_sig(SIGXFSZ, current, 0);
 			goto out;
 		}
-		if (*count > MAX_NON_LFS - (u32)pos) {
-			/* send_sig(SIGXFSZ, current, 0); */
-			*count = MAX_NON_LFS - (u32)pos;
+		if (*count > MAX_NON_LFS - (unsigned long)pos) {
+			*count = MAX_NON_LFS - (unsigned long)pos;
 		}
 	}
 

