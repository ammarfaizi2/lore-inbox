Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267953AbUIGMN4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267953AbUIGMN4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 08:13:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267976AbUIGMNz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 08:13:55 -0400
Received: from mail.fh-wedel.de ([213.39.232.194]:31145 "EHLO mail.fh-wedel.de")
	by vger.kernel.org with ESMTP id S267953AbUIGMMn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 08:12:43 -0400
Date: Tue, 7 Sep 2004 14:12:35 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 3/4] copyfile: sendfile_loop
Message-ID: <20040907121235.GB27297@wohnheim.fh-wedel.de>
References: <20040907120908.GB26630@wohnheim.fh-wedel.de> <20040907121118.GA27297@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20040907121118.GA27297@wohnheim.fh-wedel.de>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The new loop patch.  Tested on my machine, appears to work.

Jörn

-- 
But this is not to say that the main benefit of Linux and other GPL
software is lower-cost. Control is the main benefit--cost is secondary.
-- Bruce Perens

Linus and Andrew are rightfully concerned about local DoS via a large
file->file sendfile().  This patch turns large sendfile() calls into a
loop of 4k chunks.  After each chunk, it adds a cond_resched for
interactivity and a signal check to allow aborts etc. after the user
found out what a bad idea this may be.

Signed-off-by: Jörn Engel <joern@wohnheim.fh-wedel.de>
---

 read_write.c |   31 ++++++++++++++++++++++++++++++-
 1 files changed, 30 insertions(+), 1 deletion(-)


--- linux-2.6.8cow/fs/read_write.c~sendfile_loop	2004-09-05 12:06:39.000000000 +0200
+++ linux-2.6.8cow/fs/read_write.c	2004-09-07 13:27:30.000000000 +0200
@@ -561,6 +561,35 @@
 	return ret;
 }
 
+/**
+ * sendfile() of a 2GB file over usb1-attached hard drives can take a moment.
+ * This little loop is supposed to stop now and then to check for signals,
+ * reschedule and generally play nice with others.
+ */
+ssize_t inline __vfs_sendfile(struct file *in_file, loff_t *ppos, size_t count,
+		read_actor_t actor, struct file *out_file)
+{
+	ssize_t done = 0, ret;
+	while (count) {
+		size_t n = min(count, (size_t)4096);
+		ret = in_file->f_op->sendfile(in_file, ppos, n, actor,out_file);
+		if (ret < 0) {
+			if (done)
+				return done;
+			else
+				return ret;
+		}
+
+		done += ret;
+		count -= ret;
+
+		if ((ret == 0) || signal_pending(current))
+			break;
+		cond_resched();
+	}
+	return done;
+}
+
 ssize_t vfs_sendfile(struct file *out_file, struct file *in_file, loff_t *ppos,
 		     size_t count, loff_t max)
 {
@@ -608,7 +637,7 @@
 		count = max - pos;
 	}
 
-	ret = in_file->f_op->sendfile(in_file, ppos, count, file_send_actor, out_file);
+	ret = __vfs_sendfile(in_file, ppos, count, file_send_actor, out_file);
 
 	if (*ppos > max)
 		return -EOVERFLOW;
