Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262146AbUKQCjg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262146AbUKQCjg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Nov 2004 21:39:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262163AbUKQCjg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Nov 2004 21:39:36 -0500
Received: from siaar2aa.compuserve.com ([149.174.40.137]:7844 "EHLO
	siaar2aa.compuserve.com") by vger.kernel.org with ESMTP
	id S262146AbUKQCiL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Nov 2004 21:38:11 -0500
Date: Tue, 16 Nov 2004 21:32:31 -0500
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: [POSSIBLE-BUG] telldir() broken on ext3
To: r6144 <rainy6144@gmail.cm>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200411162137_MC3-1-8ED7-97B5@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

r6144 wrote:
> telldir() broken on large ext3 dir_index'd directories because
> getdents() gives d_off==0 for the first entry

Does this patch fix your problem?

# ext3_readdir.patch
#       fs/ext3/dir.c -5 +8
#
#       2004/11/07 20:08:01-08:00 akpm@osdl.org 
#       [PATCH] Fix ext3_dx_readdir
#   
#       When there are more than one entry in fname linked list, the current
#       implementation of ext3_dx_readdir() can not traverse all entries correctly
#       in the case that call_filldir() fails.
#   
#       If we use system call readdir() to read entries in a directory which
#       happens that "." and ".." in the same fname linked list.  Each time we call
#       readdir(), it will return the "." entry and never returns 0 which indicates
#       that all entries are read.
#   
#       Although chances that more than one entry are in one fname linked list are
#       very slim, it does exist.
#   
#       Signed-off-by: Andrew Morton <akpm@osdl.org>
#       Signed-off-by: Linus Torvalds <torvalds@osdl.org>
# 
--- 2.6.9/fs/ext3/dir.c
+++ 2.6.9.1/fs/ext3/dir.c
@@ -418,7 +418,7 @@
                                get_dtype(sb, fname->file_type));
                if (error) {
                        filp->f_pos = curr_pos;
-                       info->extra_fname = fname->next;
+                       info->extra_fname = fname;
                        return error;
                }
                fname = fname->next;
@@ -457,9 +457,12 @@
         * If there are any leftover names on the hash collision
         * chain, return them first.
         */
-       if (info->extra_fname &&
-           call_filldir(filp, dirent, filldir, info->extra_fname))
-               goto finished;
+       if (info->extra_fname) {
+               if (call_filldir(filp, dirent, filldir, info->extra_fname))
+                       goto finished;
+               else
+                       goto next_entry;
+       }
 
        if (!info->curr_node)
                info->curr_node = rb_first(&info->root);
@@ -492,7 +495,7 @@
                info->curr_minor_hash = fname->minor_hash;
                if (call_filldir(filp, dirent, filldir, fname))
                        break;
-
+next_entry:
                info->curr_node = rb_next(info->curr_node);
                if (!info->curr_node) {
                        if (info->next_hash == ~0) {

--Chuck Ebbert  16-Nov-04  18:22:33
