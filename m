Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263152AbTE0JWG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 05:22:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263150AbTE0JWG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 05:22:06 -0400
Received: from madrid10.amenworld.com ([217.174.194.138]:50701 "EHLO
	madrid10.amenworld.com") by vger.kernel.org with ESMTP
	id S263152AbTE0JVg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 05:21:36 -0400
Date: Mon, 21 Apr 2003 13:04:27 +0200
From: DervishD <raul@pleyades.net>
To: Linus Torvalds <torvalds@transmeta.com>
Subject: [RESEND][PATCH] against mmap.c (do_mmap_pgoff) and a note
Message-ID: <20030421110427.GA127@DervishD>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="vtzGhvizbBRQ85DL"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.4i
Organization: Pleyades
User-Agent: Mutt/1.4i <http://www.mutt.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--vtzGhvizbBRQ85DL
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

    Hi Linus :)

    I've noticed that in file 'mm/mmap.c', at the comments for
function 'can_vma_merge_before' this can be read:

<quote>
 * We don't check here for the merged mmap wrapping around the end of pagecache
 * indices (16TB on ia32) because do_mmap_pgoff() does not permit mmap's which
 * wrap, nor mmaps which cover the final page at index -1UL.
 */
</quote>

    Well, the patch I sent you against 2.5.60 and that I'm resending,
since it's not included at 2.5.68, fixed a mmap() corner case bug,
that made mmap() fail for large sizes (as did a previous patch that
you did apply) and that works even if 'TASK_SIZE' is the entire
address space (as seems the case at sparc64, for example). The
problem is that with the patch you already applied and with the new
patch I send, you cannot do a mmap that wraps, but you can mmap the
final page (not at index -1UL, there is not such index!, -1
unsigned?). In fact, you can mmap your entire address space if you
want.

    Without the patch you already applied any such 'big' mmap will
silently fail, and with the new, if the arch doesn't want such a big
mmap it will return EINVAL.

    I think the problem in 'can_vma_merge_before' is just the comment
(for me it sounds ambiguous), but the other problem, with archs like
sparc64, still is an issue. Dave Miller pointed this although I made
the patch. Please apply, the semantics of 'do_mmap_pgoff' doesn't
change a bit, is just that the current code will silently fail for
sparc64 and other archs where TASK_SIZE is the entire address space.

    Thanks a lot and happy coding :)

    Raúl Núñez de Arenas Coronado

-- 
Linux Registered User 88736
http://www.pleyades.net & http://raul.pleyades.net/

--vtzGhvizbBRQ85DL
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: attachment; filename="mmap.c.2.5.68.diff"

--- linux/mm/mmap.c.orig	2002-12-11 14:27:04.000000000 +0100
+++ linux/mm/mmap.c	2002-12-11 14:28:09.000000000 +0100
@@ -421,14 +421,14 @@
 	if (file && (!file->f_op || !file->f_op->mmap))
 		return -ENODEV;
 
-	if (!len)
+	if (len == 0)
 		return addr;
 
-	if (len > TASK_SIZE)
-		return -EINVAL;
-
 	len = PAGE_ALIGN(len);
 
+	if (len > TASK_SIZE || len == 0)
+		return -EINVAL;
+
 	/* offset overflow? */
 	if ((pgoff + (len >> PAGE_SHIFT)) < pgoff)
 		return -EINVAL;

--vtzGhvizbBRQ85DL--
