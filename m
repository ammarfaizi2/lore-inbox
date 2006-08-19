Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751595AbWHSXv0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751595AbWHSXv0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Aug 2006 19:51:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751568AbWHSXvZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Aug 2006 19:51:25 -0400
Received: from mother.openwall.net ([195.42.179.200]:61837 "HELO
	mother.openwall.net") by vger.kernel.org with SMTP id S1751365AbWHSXvZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Aug 2006 19:51:25 -0400
Date: Sun, 20 Aug 2006 03:46:29 +0400
From: Solar Designer <solar@openwall.com>
To: Willy Tarreau <wtarreau@hera.kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] loop.c: kernel_thread() retval check
Message-ID: <20060819234629.GA16814@openwall.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="yrj/dFKFPuw6o+aM"
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--yrj/dFKFPuw6o+aM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Willy,

I propose the attached patch (extracted from 2.4.33-ow1) for inclusion
into 2.4.34-pre.  (Last time I checked, 2.6 needed an equivalent fix,
but I haven't produced one yet.)

Basically, the code in drivers/block/loop.c did not check the return
value from kernel_thread().  If kernel_thread() would fail, the code
would misbehave (IIRC, the invoking process would become unkillable).

An easy way to trigger the bug was to run losetup under strace (as
root), and this is also how I tested the error path added with this
patch.

This change has been a part of publicly released -ow patches for 8+
months.

There are more instances of kernel_thread() calls that do not check the
return value; some of the remaining ones might need to be fixed, too.

Thanks,

Alexander

--yrj/dFKFPuw6o+aM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="linux-2.4.33-ow1-loop-kernel_thread-check.diff"

diff -urpPX nopatch linux-2.4.33/drivers/block/loop.c linux/drivers/block/loop.c
--- linux-2.4.33/drivers/block/loop.c	Fri Jun  3 04:26:42 2005
+++ linux/drivers/block/loop.c	Sat Aug 12 08:51:47 2006
@@ -693,12 +693,23 @@ static int loop_set_fd(struct loop_devic
 	set_blocksize(dev, bs);
 
 	lo->lo_bh = lo->lo_bhtail = NULL;
-	kernel_thread(loop_thread, lo, CLONE_FS | CLONE_FILES | CLONE_SIGHAND);
-	down(&lo->lo_sem);
+	error = kernel_thread(loop_thread, lo,
+	    CLONE_FS | CLONE_FILES | CLONE_SIGHAND);
+	if (error < 0)
+		goto out_clr;
+	down(&lo->lo_sem); /* wait for the thread to start */
 
 	fput(file);
 	return 0;
 
+ out_clr:
+	lo->lo_backing_file = NULL;
+	lo->lo_device = 0;
+	lo->lo_flags = 0;
+	loop_sizes[lo->lo_number] = 0;
+	inode->i_mapping->gfp_mask = lo->old_gfp_mask;
+	lo->lo_state = Lo_unbound;
+	fput(file); /* yes, have to do it twice */
  out_putf:
 	fput(file);
  out:

--yrj/dFKFPuw6o+aM--
