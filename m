Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262882AbTDAWPO>; Tue, 1 Apr 2003 17:15:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262883AbTDAWPO>; Tue, 1 Apr 2003 17:15:14 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:40471 "EHLO
	mtvmime01.veritas.com") by vger.kernel.org with ESMTP
	id <S262882AbTDAWPN>; Tue, 1 Apr 2003 17:15:13 -0500
Date: Tue, 1 Apr 2003 23:28:34 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Andrew Morton <akpm@digeo.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] filemap ffffffffull 
Message-ID: <Pine.LNX.4.44.0304012325370.1730-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When handling rlimit != RLIM_INFINITY, generic_write_checks tests file
position against 0xFFFFFFFFULL, and casts it to a u32.  This code is
carried forward from 2.4.4, and the 2.4-ac tree contains an apparently
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

--- 2.5.66-mm2/mm/filemap.c	Tue Apr  1 11:25:50 2003
+++ linux/mm/filemap.c	Tue Apr  1 19:22:30 2003
@@ -1523,9 +1523,8 @@
 				send_sig(SIGXFSZ, current, 0);
 				return -EFBIG;
 			}
-			if (*pos > 0xFFFFFFFFULL || *count > limit-(u32)*pos) {
-				/* send_sig(SIGXFSZ, current, 0); */
-				*count = limit - (u32)*pos;
+			if (*count > limit - (typeof(limit))*pos) {
+				*count = limit - (typeof(limit))*pos;
 			}
 		}
 	}
@@ -1539,9 +1538,8 @@
 			send_sig(SIGXFSZ, current, 0);
 			return -EFBIG;
 		}
-		if (*count > MAX_NON_LFS - (u32)*pos) {
-			/* send_sig(SIGXFSZ, current, 0); */
-			*count = MAX_NON_LFS - (u32)*pos;
+		if (*count > MAX_NON_LFS - (unsigned long)*pos) {
+			*count = MAX_NON_LFS - (unsigned long)*pos;
 		}
 	}
 

