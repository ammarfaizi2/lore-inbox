Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266805AbTCDXrQ>; Tue, 4 Mar 2003 18:47:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267008AbTCDXrQ>; Tue, 4 Mar 2003 18:47:16 -0500
Received: from ore.jhcloos.com ([64.240.156.239]:34820 "EHLO ore.jhcloos.com")
	by vger.kernel.org with ESMTP id <S266805AbTCDXrO>;
	Tue, 4 Mar 2003 18:47:14 -0500
To: ext2-devel@lists.sf.net
Cc: ext3-users@redhat.com, linux-kernel@vger.kernel.org
Subject: ext3 htree brelse problems look to be fixed!
From: "James H. Cloos Jr." <cloos@jhcloos.com>
Date: 04 Mar 2003 18:57:26 -0500
Message-ID: <m3of4q4rdl.fsf@lugabout.jhcloos.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I just booted 2.5-bk current as of last night with the below patch¹
(which was recently posted to ext3-users) that un-static-ifies a 
struct dx_frame in namei.c.

I then did my best torture test for the brelse bug:  starting gnus
(3600+ nnmh folders² with a total of XXX messages; it does a readdir
on each of those folders) while doing bk consistancy checks in 2.5
and/or 2.4 kernel trees.  All while fetchmail+procmail+spamd processes
a stream of incoming mail.

That load had never failed to generate a brelse in the syslog; each
occurance of brelse in the syslog correlated to a short readdir.  In
gnus the short readdir would result in temporarily missing mail; in bk
the consistancy check would fail.  If the bk check was the result of a
pull, a manual bk resync would be required to fix the tree.  (Or one
could remove the RESYNC and PENDING dirs and re-pull.)

The bug did not occur during the torture test.  Even with three bk
checks in parallel (2.5 current, 2.4 current and a clone of a clone of
2.5 as of yesterday.)

I beleive (with this patch) htree is now ready for prime time.

-JimC

² one message per file in seq(1) order, ala old-style usenet spools

¹ the patch as posted by Andreas Dilger <adilger@clusterfs.com> is:

===== namei.c 1.15 vs edited =====
--- 1.15/fs/ext3/namei.c        Wed Oct  2 01:24:11 2002
+++ edited/namei.c      Sun Mar  2 00:05:03 2003
@@ -530,7 +530,7 @@
        struct dx_hash_info hinfo;
        struct buffer_head *bh;
        struct ext3_dir_entry_2 *de, *top;
-       static struct dx_frame frames[2], *frame;
+       struct dx_frame frames[2], *frame;
        struct inode *dir;
        int block, err;
        int count = 0;

