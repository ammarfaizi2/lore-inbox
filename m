Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265662AbTGLToU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Jul 2003 15:44:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265771AbTGLToU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Jul 2003 15:44:20 -0400
Received: from ns.suse.de ([213.95.15.193]:2565 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S265662AbTGLToS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Jul 2003 15:44:18 -0400
From: Andreas Gruenbacher <agruen@suse.de>
To: Stephen Smalley <sds@epoch.ncsc.mil>, Andrew Morton <akpm@osdl.org>
Subject: Re: BUG at fs/jbd/transaction.c:684 during setxattr on 2.5.75
Date: Sat, 12 Jul 2003 21:59:49 +0200
User-Agent: KMail/1.5.1
References: <1057956115.13738.522.camel@moss-huskers.epoch.ncsc.mil>
In-Reply-To: <1057956115.13738.522.camel@moss-huskers.epoch.ncsc.mil>
Cc: lkml <linux-kernel@vger.kernel.org>,
       James Morris <jmorris@intercode.com.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307122159.49778.agruen@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen and Andrew,

please find attached fixes for three bugs I found while looking into this. 
Andrew, could you please push these fixes to Linus? Thanks!

The bug Stephen has triggered is in fs/jbd/transaction.c:

Index: linux-2.5.75/fs/jbd/transaction.c
===================================================================
--- linux-2.5.75.orig/fs/jbd/transaction.c      2003-07-10 22:06:58.000000000 
+0200
+++ linux-2.5.75/fs/jbd/transaction.c   2003-07-12 21:31:31.000000000 +0200
@@ -747,7 +747,7 @@
        /* We do not want to get caught playing with fields which the
         * log thread also manipulates.  Make sure that the buffer
         * completes any outstanding IO before proceeding. */
-       rc = do_get_write_access(handle, jh, 0, NULL);
+       rc = do_get_write_access(handle, jh, 0, credits);
        journal_put_journal_head(jh);
        return rc;
 }

While looking into this issue I found two more bugs in fs/ext3/xattr.c. Fix 
below.
  - ext3_journal_get_write_access_credits failures break out of the loop in 
1058, so <ce> is not released properly.
  - <credits> must be reset after journal_release_buffer() in line 1072.

Index: linux-2.5.75/fs/ext3/xattr.c
===================================================================
--- linux-2.5.75.orig/fs/ext3/xattr.c   2003-07-12 13:36:51.000000000 +0200
+++ linux-2.5.75/fs/ext3/xattr.c        2003-07-12 21:35:57.000000000 +0200
@@ -1050,12 +1050,10 @@
                        ext3_error(inode->i_sb, "ext3_xattr_cache_find",
                                "inode %ld: block %ld read error",
                                inode->i_ino, (unsigned long) ce->e_block);
-               } else {
+               } else if (ext3_journal_get_write_access_credits(
+                               handle, bh, credits) == 0) {
                        /* ext3_journal_get_write_access() requires an 
unlocked
                         * bh, which complicates things here. */
-                       if (ext3_journal_get_write_access_credits(handle, bh,
-                                                                 credits) != 
0)
-                               return NULL;
                        lock_buffer(bh);
                        if (le32_to_cpu(HDR(bh)->h_refcount) >
                                   EXT3_XATTR_REFCOUNT_MAX) {
@@ -1070,6 +1068,7 @@
                        }
                        unlock_buffer(bh);
                        journal_release_buffer(handle, bh, *credits);
+                       *credits = 0;
                        brelse(bh);
                }
                ce = mb_cache_entry_find_next(ce, 0, inode->i_sb->s_bdev, 
hash);


On Friday 11 July 2003 22:41, Stephen Smalley wrote:
> I've encountered a kernel BUG in jbd during setxattr on 2.5.75, likely
> related to the recent xattr locking changes.  Originally encountered
> with SELinux enabled, but also occurs with SELinux disabled.  I have not
> been able to reproduce it with 2.5.74.
>
> [...]
>
> A command for reproducing the bug is:
> find . -exec setfattr -n security.selinux -v system_u:object_r:staff_home_t
> {} \;

I could reproduce with user.* attributes as well.


Cheers,
Andreas.

------------------------------------------------------------------
 Andreas Gruenbacher                     SuSE Labs, SuSE Linux AG
 mailto:agruen@suse.de                     Deutschherrnstr. 15-19
 http://www.suse.de/                   D-90429 Nuernberg, Germany

