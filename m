Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263314AbTC0RU7>; Thu, 27 Mar 2003 12:20:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263323AbTC0RUx>; Thu, 27 Mar 2003 12:20:53 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:5871 "EHLO
	mtvmime02.veritas.com") by vger.kernel.org with ESMTP
	id <S263314AbTC0RUf>; Thu, 27 Mar 2003 12:20:35 -0500
Date: Thu, 27 Mar 2003 17:33:43 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Andrew Morton <akpm@digeo.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, <linux-kernel@vger.kernel.org>
Subject: wonderffffffffull ac filemap patch
Message-ID: <Pine.LNX.4.44.0303271656270.2483-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here's a patch I've stolen from 2.4-ac, which is clearly correct so
far as it goes.  I keep wanting to get this integrated into 2.4 and
2.5, then bring shmem.c into line (in 2.5 use generic_write_checks).

But each time I approach it, I get stuck on trying to understand the
code it's a good patch to.  I understand that there's a problem with
loff_t twice as wide as rlim, and that we need to trim count down near
the limit.  But I don't understand why 0xFFFFFFFFULL and (u32) rather
than RLIM_INFINITY and (unsigned long): are we really trying to
cripple 64-bit arches here?

Hugh

--- 2.5.66-mm1/mm/filemap.c	Wed Mar 26 11:50:36 2003
+++ linux/mm/filemap.c	Thu Mar 27 16:53:46 2003
@@ -1509,7 +1509,10 @@
 				send_sig(SIGXFSZ, current, 0);
 				return -EFBIG;
 			}
-			if (*pos > 0xFFFFFFFFULL || *count > limit-(u32)*pos) {
+			/* Fix this up when we got to rlimit64 */
+			if (*pos > 0xFFFFFFFFULL)
+				*count = 0;
+			else if (*count > limit - (u32)*pos) {
 				/* send_sig(SIGXFSZ, current, 0); */
 				*count = limit - (u32)*pos;
 			}

