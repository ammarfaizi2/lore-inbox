Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261356AbUJXC6f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261356AbUJXC6f (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Oct 2004 22:58:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261359AbUJXC6d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Oct 2004 22:58:33 -0400
Received: from pxy7allmi.all.mi.charter.com ([24.247.15.58]:11670 "EHLO
	proxy7-grandhaven.chartermi.net") by vger.kernel.org with ESMTP
	id S261356AbUJXC6b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Oct 2004 22:58:31 -0400
Message-ID: <417B1A48.2000903@quark.didntduck.org>
Date: Sat, 23 Oct 2004 22:58:16 -0400
From: Brian Gerst <bgerst@quark.didntduck.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20041020
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH] mem leak in tty_io.c
Content-Type: multipart/mixed;
 boundary="------------020906020403020301050300"
X-Charter-Information: 
X-Charter-Scan: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020906020403020301050300
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

The recent patch to clean up user accesses introduced a memory leak.  If 
write_buf is reallocated, the old buffer isn't freed.  Also, since kfree 
can take nulls, I removed the if from the other kfree.

--
				Brian Gerst

--------------020906020403020301050300
Content-Type: text/plain;
 name="tty-kfree"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="tty-kfree"

diff -urN linux-2.6.9-bk/drivers/char/tty_io.c linux/drivers/char/tty_io.c
--- linux-2.6.9-bk/drivers/char/tty_io.c	2004-10-22 09:53:21.373263820 -0400
+++ linux/drivers/char/tty_io.c	2004-10-22 10:36:10.753679871 -0400
@@ -168,8 +168,7 @@
 
 static inline void free_tty_struct(struct tty_struct *tty)
 {
-	if (tty->write_buf)
-		kfree(tty->write_buf);
+	kfree(tty->write_buf);
 	kfree(tty);
 }
 
@@ -1060,6 +1059,7 @@
 			up(&tty->atomic_write);
 			return -ENOMEM;
 		}
+		kfree(tty->write_buf);
 		tty->write_cnt = chunk;
 		tty->write_buf = buf;
 	}

--------------020906020403020301050300--
