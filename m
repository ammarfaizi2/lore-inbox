Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264091AbUDRA22 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Apr 2004 20:28:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264097AbUDRA22
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Apr 2004 20:28:28 -0400
Received: from sphinx.mythic-beasts.com ([195.82.107.246]:40969 "EHLO
	sphinx.mythic-beasts.com") by vger.kernel.org with ESMTP
	id S264091AbUDRA2Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Apr 2004 20:28:25 -0400
Date: Sun, 18 Apr 2004 01:28:20 +0100 (BST)
From: chris@scary.beasts.org
X-X-Sender: cevans@sphinx.mythic-beasts.com
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org
Subject: Nasty 2.6 sendfile() bug / regression; affects vsftpd
Message-ID: <Pine.LNX.4.58.0404180026490.16486@sphinx.mythic-beasts.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew, linux-kernel,

Large-file download support with vsftpd and the 2.6 kernel is a broken
combination. After careful consideration, I'm pretty sure the bug is with
the 2.6 kernel. At the very least, behaviour has changed from 2.4. An
initial fix is included below.

vsftpd makes extensive use of sendfile to achieve high performance. When
vsftpd was first written, sendfile64 did not exist. So, in order to
transfer >2Gb files, multiple sendfile() calls are used [1]. The main
issue with sendfile() and >2Gb files is of course that the "offset" in/out
parameter cannot be used, because it is not 64-bit. The solution is
simple; use NULL for the offset parameter and keep track of the file
position in a purely user-space variable.
The above scheme works well with 2.4, but unfortunately fails with
EOVERFLOW in 2.6 at the 2Gb mark.
This failure seems to be a bug. I could be wrong here, but it seems the
intent of EOVERFLOW is to indicate to the user that a large 64-bit kernel
value cannot be stuffed into a 32-bit userspace return value. In the case
of using NULL as the offset paramter, userspace does not care about the
64-bit file offset and no truncation will ever occur.
The below patch fixes this up to restore 2.4 behaviour in the event of a
NULL offset parameter. It's currently under testing and looking good.

Any chance you can review this and sneak into 2.6.soon?

--- read_write.c.old	2004-04-17 18:39:11.000000000 +0100
+++ read_write.c	2004-04-17 23:38:04.000000000 +0100
@@ -545,6 +545,7 @@
 	loff_t pos;
 	ssize_t retval;
 	int fput_needed_in, fput_needed_out;
+	loff_t *orig_ppos = ppos;

 	/*
 	 * Get input file, and verify that it is ok..
@@ -599,7 +600,7 @@
 	retval = -EINVAL;
 	if (unlikely(pos < 0))
 		goto fput_out;
-	if (unlikely(pos + count > max)) {
+	if (unlikely(pos + count > max && orig_ppos != NULL)) {
 		retval = -EOVERFLOW;
 		if (pos >= max)
 			goto fput_out;
@@ -608,7 +609,7 @@

 	retval = in_file->f_op->sendfile(in_file, ppos, count, file_send_actor, out_file);

-	if (*ppos > max)
+	if (*ppos > max && orig_ppos != NULL)
 		retval = -EOVERFLOW;

 fput_out:

Cheers
Chris

[1] Note that I'm not inspired to use sendfile64, as it will STILL need
multiple sendfile64 calls - the "count" variabe is still 32-bit. The only
change from sendfile is that the offset parameter becomes 64-bit.
