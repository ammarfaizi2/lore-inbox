Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261733AbUARMhW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jan 2004 07:37:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261779AbUARMhW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jan 2004 07:37:22 -0500
Received: from dbl.q-ag.de ([213.172.117.3]:8105 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S261733AbUARMhP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jan 2004 07:37:15 -0500
Message-ID: <400A7DF5.4060704@colorfullife.com>
Date: Sun, 18 Jan 2004 13:37:09 +0100
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.1) Gecko/20031030
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: [PATCH] sendfile calls lock_verify_area with wrong parameters
Content-Type: multipart/mixed;
 boundary="------------000903000401090908050001"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000903000401090908050001
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

sendfile supports reading from a given start offset for in_file, like 
pread. But for the locks_verify_area call, in_file->f_pos is always 
used, even if a start offset is used. Result: wrong area is checked for 
mandatory locks.

Fix attached.

--
    Manfred

--------------000903000401090908050001
Content-Type: text/plain;
 name="patch-locks-sendfile"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-locks-sendfile"

--- 2.6/fs/read_write.c	2004-01-17 12:19:38.000000000 +0100
+++ build-2.6/fs/read_write.c	2004-01-18 13:26:46.000000000 +0100
@@ -544,6 +544,8 @@
 	ssize_t retval;
 	int fput_needed_in, fput_needed_out;
 
+	if (!ppos)
+		ppos = &in_file->f_pos;
 	/*
 	 * Get input file, and verify that it is ok..
 	 */
@@ -559,7 +561,7 @@
 		goto fput_in;
 	if (!in_file->f_op || !in_file->f_op->sendfile)
 		goto fput_in;
-	retval = locks_verify_area(FLOCK_VERIFY_READ, in_inode, in_file, in_file->f_pos, count);
+	retval = locks_verify_area(FLOCK_VERIFY_READ, in_inode, in_file, *ppos, count);
 	if (retval)
 		goto fput_in;
 
@@ -588,9 +590,6 @@
 	if (retval)
 		goto fput_out;
 
-	if (!ppos)
-		ppos = &in_file->f_pos;
-
 	if (!max)
 		max = min(in_inode->i_sb->s_maxbytes, out_inode->i_sb->s_maxbytes);
 

--------------000903000401090908050001--

