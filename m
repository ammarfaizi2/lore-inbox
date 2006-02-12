Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751445AbWBLUqU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751445AbWBLUqU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Feb 2006 15:46:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751447AbWBLUqU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Feb 2006 15:46:20 -0500
Received: from ishtar.tlinx.org ([64.81.245.74]:37078 "EHLO ishtar.tlinx.org")
	by vger.kernel.org with ESMTP id S1751445AbWBLUqU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Feb 2006 15:46:20 -0500
Message-ID: <43EF9E96.109@tlinx.org>
Date: Sun, 12 Feb 2006 12:46:14 -0800
From: Linda Walsh <lkml@tlinx.org>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
CC: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] Use one constant to control MAX SYMLINKS in a name
References: <43ED5A7B.7040908@tlinx.org> <Pine.LNX.4.61.0602121126410.25363@yvahk01.tjqt.qr>
In-Reply-To: <Pine.LNX.4.61.0602121126410.25363@yvahk01.tjqt.qr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Engelhardt wrote:
> # grep 40 fs/namei.c
> namei.c: * limiting consecutive symlinks to 40.
> namei.c:        if (current->total_link_count >= 40)
>   
---
    I believe that is the case of appending successive path entries for
sequential case of case "a->b->c->d..." where successive entries
can replace previous entries.  I hit the nested symlink amount
where a symlink contains two or more path components with a symlink in the
non-terminal position, i.e.in the dir-component of a dir/target.
I had something like "./symdir1/myfile"; with a symlink chain extending
along the directory chain.  Not the end file.

    Here are the lines in question:


include/linux/namei.h:14:enum { MAX_NESTED_LINKS = 5 };
&&
fs/namei.c:

590: * This limits recursive symlink follows to 8, while
591: * limiting consecutive symlinks to 40.
592: *
593: * Without that kind of total limit, nasty chains of consecutive
594: * symlinks can cause almost arbitrarily long lookups.
595: */
596:static inline int do_follow_link(struct path *path, struct nameidata
 *nd)

599:    if (current->link_count >= MAX_NESTED_LINKS)
600:            goto loop;
601:    if (current->total_link_count >= 40)
602:            goto loop;
----------
    The comment on line 590 refers to the "enum", MAX_NESTED_LINKS
on line 599 defined as "5" in namei.h, line 14.

    My original post showed the nesting via the gnu namei command, which
appears  to correctly expand the symlink even though the OS fails.

    I'd suggest changing the number in line 14 in namei.h to 40
as well, thus using the same limit in both cases and clearing up
such confusion.

The following patch (against 2.6.15.4) seems to make this change and fixes
up the comments:
-----------------------

--- include/linux/namei.h       2006-01-02 19:21:10.000000000 -0800
+++ include/linux/namei.h       2006-02-12 12:25:37.500504876 -0800
@@ -11,7 +11,7 @@
        struct file *file;
 };
 
-enum { MAX_NESTED_LINKS = 5 };
+enum { MAX_PATH_SYMLINKS = 40 };
 
 struct nameidata {
        struct dentry   *dentry;
@@ -20,7 +20,7 @@
        unsigned int    flags;
        int             last_type;
        unsigned        depth;
-       char *saved_names[MAX_NESTED_LINKS + 1];
+       char *saved_names[MAX_PATH_SYMLINKS + 1];
 
        /* Intent data */
        union {


--- fs/namei.c.orig     2006-01-02 19:21:10.000000000 -0800
+++ fs/namei.c  2006-02-12 12:20:45.382792407 -0800
@@ -587,8 +587,7 @@
 }
 
 /*
- * This limits recursive symlink follows to 8, while
- * limiting consecutive symlinks to 40.
+ * This limits max symlinks in a pathname to "MAX_PATH_SYMLINKS"
  *
  * Without that kind of total limit, nasty chains of consecutive
  * symlinks can cause almost arbitrarily long lookups.
@@ -596,11 +595,11 @@
 static inline int do_follow_link(struct path *path, struct nameidata *nd)
 {
        int err = -ELOOP;
-       if (current->link_count >= MAX_NESTED_LINKS)
+       if (current->link_count >= MAX_PATH_SYMLINKS ||
+               current->total_link_count >= MAX_PATH_SYMLINKS)
                goto loop;
-       if (current->total_link_count >= 40)
-               goto loop;
-       BUG_ON(nd->depth >= MAX_NESTED_LINKS);
+       /* Not sure next BUG_ON statement is ever needed */
+       BUG_ON(nd->depth >= MAX_PATH_SYMLINKS);
        cond_resched();
        err = security_inode_follow_link(path->dentry, nd);
        if (err)
