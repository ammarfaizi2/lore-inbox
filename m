Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261522AbUARNEv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jan 2004 08:04:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261539AbUARNEv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jan 2004 08:04:51 -0500
Received: from dbl.q-ag.de ([213.172.117.3]:20137 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S261522AbUARNEt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jan 2004 08:04:49 -0500
Message-ID: <400A846A.6000003@colorfullife.com>
Date: Sun, 18 Jan 2004 14:04:42 +0100
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.1) Gecko/20031030
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sendfile calls lock_verify_area with wrong parameters
References: <400A7DF5.4060704@colorfullife.com>
In-Reply-To: <400A7DF5.4060704@colorfullife.com>
Content-Type: multipart/mixed;
 boundary="------------040506030808040505000805"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040506030808040505000805
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Manfred Spraul wrote:

>+	if (!ppos)
>+		ppos = &in_file->f_pos;
>  
>
Too early - in_file not yet initialized.

An updated (and tested with 2.6.1-mm4) patch is attached - sorry for the 
noise.

--
    Manfred

--------------040506030808040505000805
Content-Type: text/plain;
 name="patch-locks-sendfile"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-locks-sendfile"

--- 2.6/fs/read_write.c	2004-01-17 12:19:38.000000000 +0100
+++ build-2.6/fs/read_write.c	2004-01-18 13:42:11.000000000 +0100
@@ -559,7 +559,9 @@
 		goto fput_in;
 	if (!in_file->f_op || !in_file->f_op->sendfile)
 		goto fput_in;
-	retval = locks_verify_area(FLOCK_VERIFY_READ, in_inode, in_file, in_file->f_pos, count);
+	if (!ppos)
+		ppos = &in_file->f_pos;
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
 

--------------040506030808040505000805--

