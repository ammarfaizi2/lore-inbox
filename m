Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262518AbULDBsk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262518AbULDBsk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Dec 2004 20:48:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262520AbULDBsk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Dec 2004 20:48:40 -0500
Received: from sullivan.realtime.net ([205.238.132.76]:7437 "EHLO
	sullivan.realtime.net") by vger.kernel.org with ESMTP
	id S262518AbULDBsg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Dec 2004 20:48:36 -0500
Date: Fri, 3 Dec 2004 19:47:19 -0600 (CST)
Message-Id: <200412040147.iB41lIlK031974@sullivan.realtime.net>
To: klibc@zytor.com, linux-kernel@vger.kernel.org
Cc: hpa@zytor.com, viro@parcelfarce.linux.theplanet.co.uk, akpm@osdl.org
Subject: INITRAMFS: allow no trailer
From: Milton Miller <miltonm@bga.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

According to "initramfs buffer format -- third draft"
http://lwn.net/2002/0117/a/initramfs-buffer-format.php3
"the cpio "TRAILER!!!" entry (cpio end-of-archive) is optional, but is
not ignored"

The kernel handling does not follow this spec.   If you add null padding
after an uncompressed cpio without TRAILER!!! the kernel complains "no
cpio magic".  In a gzipped archive one gets "junk in gzipped archive"
without the TRAILER!!!

This patch changes the state transitions so the kernel will follow the spec.

Tested: padded uncompressed, padded compressed, unpadded compressed (error)
and trailing junk in compressed (error).

---
I have a boot loader that knows how to load files, determine their size,
and advance to the next 4-byte boundary and reports the total size of 
the files loaded.  It doesn't understand about converting this number
to some ASCII representation.

With this patch I can embed the contents of a file padded with NULs
with out knowing the exact size of the file with the following files:

1) file containing cpio header & file name, padded to 4 bytes
2) contents of file
3) pad file of zeros, the size at least as large as the that specified
   for the file.

hpa points out that you should be careful with the headers, use unique
inode numbers and/or add a cpio header with just TRAILER!!! to reset
the inode hash table to avoid unwanted hard links.  I just put this
sequence as the last files loaded.

---

 gr_work-miltonm/init/initramfs.c |    9 ++++++---
 1 files changed, 6 insertions(+), 3 deletions(-)

diff -puN init/initramfs.c~allow-no-trailer init/initramfs.c
--- gr_work/init/initramfs.c~allow-no-trailer	2004-12-03 16:54:02.778579302 -0600
+++ gr_work-miltonm/init/initramfs.c	2004-12-03 16:54:02.789577561 -0600
@@ -241,10 +241,9 @@ static __initdata int wfd;
 static int __init do_name(void)
 {
 	state = SkipIt;
-	next_state = Start;
+	next_state = Reset;
 	if (strcmp(collected, "TRAILER!!!") == 0) {
 		free_hash();
-		next_state = Reset;
 		return 0;
 	}
 	if (dry_run)
@@ -295,7 +294,7 @@ static int __init do_symlink(void)
 	sys_symlink(collected + N_ALIGN(name_len), collected);
 	sys_lchown(collected, uid, gid);
 	state = SkipIt;
-	next_state = Start;
+	next_state = Reset;
 	return 0;
 }
 
@@ -331,6 +330,10 @@ static void __init flush_buffer(char *bu
 			buf += written;
 			len -= written;
 			state = Start;
+		} else if (c == 0) {
+			buf += written;
+			len -= written;
+			state = Reset;
 		} else
 			error("junk in compressed archive");
 	}
_
