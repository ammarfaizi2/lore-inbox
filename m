Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267859AbUIGLqZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267859AbUIGLqZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 07:46:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267860AbUIGLqZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 07:46:25 -0400
Received: from mail.fh-wedel.de ([213.39.232.194]:58532 "EHLO mail.fh-wedel.de")
	by vger.kernel.org with ESMTP id S267859AbUIGLqT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 07:46:19 -0400
Date: Tue, 7 Sep 2004 13:45:36 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Gunnar Ritter <Gunnar.Ritter@pluto.uni-freiburg.de>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Steve French <smfltc@us.ibm.com>
Subject: Re: [PATCH 1/3] copyfile: generic_sendpage
Message-ID: <20040907114536.GA26630@wohnheim.fh-wedel.de>
References: <20040904165733.GC8579@wohnheim.fh-wedel.de> <20040904153902.6ac075ea.akpm@osdl.org> <413C5BF2.nail2RA1138AG@pluto.uni-freiburg.de> <20040906133523.GC25429@wohnheim.fh-wedel.de> <413C74E6.nail3YF11Y0TT@pluto.uni-freiburg.de> <20040907110913.GA25802@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20040907110913.GA25802@wohnheim.fh-wedel.de>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 September 2004 13:09:13 +0200, Jörn Engel wrote:
> 
> I did the loop inside the kernel, so the syscall overhead is less of
> an issue.  4k is a safe bet for _really_ slow devices and if people
> want to increase it, hey, it's just a single constant to touch.

And a stupid bug I missed.  Call sendfile with count>filesize and the
loop doesn't terminate.  Fixed patch below.

Jörn

-- 
Premature optimization is the root of all evil.
-- Donald Knuth


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
