Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261486AbTJMFdA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Oct 2003 01:33:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261492AbTJMFdA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Oct 2003 01:33:00 -0400
Received: from thebsh.namesys.com ([212.16.7.65]:27855 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP id S261486AbTJMFc5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Oct 2003 01:32:57 -0400
Message-ID: <3F8A3908.50908@namesys.com>
Date: Mon, 13 Oct 2003 09:32:56 +0400
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alex Adriaanse <alex_a@caltech.edu>
CC: linux-kernel@vger.kernel.org, vs@thebsh.namesys.com
Subject: Re: ReiserFS patch for updating ctimes of renamed files
References: <JIEIIHMANOCFHDAAHBHOIELODAAA.alex_a@caltech.edu>
In-Reply-To: <JIEIIHMANOCFHDAAHBHOIELODAAA.alex_a@caltech.edu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vladimir will look at this and get back to you.  Thanks kindly for this.

Hans

Alex Adriaanse wrote:

>Hi,
>
>I ran into some trouble trying to do incremental backups with GNU tar
>(using --listed-incremental) where renaming a file in between backups would
>cause the file to disappear upon restoration.  When investigating the issue
>I discovered that this doesn't happen on ext2, ext3, and tmpfs filesystems
>but only on ReiserFS filesystems.  I also noticed that for example ext3
>updates the affected file's ctime upon rename whereas ReiserFS doesn't, so
>I'm thinking this causes tar to believe that the file existed before the
>first backup was taking under the new name, and as a result it doesn't back
>it up during the second backup.  So I believe ReiserFS needs to update
>ctimes for renamed files in order for incremental GNU tar backups to work
>reliably.
>
>I made some changes to the reiserfs_rename function that I *think* should
>fix the problem.  However, I don't know much about ReiserFS's internals, and
>I haven't been able to test them out to see if things work now since I can't
>afford to deal with potential FS corruption with my current Linux box.
>
>I included a patch below against the 2.4.22 kernel with my changes.  Would
>somebody mind taking a look at this to see if I did things right here (and
>perhaps wouldn't mind testing it out either)?  If it works then I (and I'm
>sure others who've experienced the same problem) would like to see the
>changes applied to the next 2.4.x (and 2.6.x?) release.
>
>Thanks a lot.
>
>Alex
>
>--- fs/reiserfs/namei.c.orig    Mon Aug 25 06:44:43 2003
>+++ fs/reiserfs/namei.c Sun Oct 12 00:39:05 2003
>@@ -1207,6 +1207,8 @@
>     journal_mark_dirty (&th, old_dir->i_sb, old_de.de_bh);
>     old_dir->i_ctime = old_dir->i_mtime = CURRENT_TIME;
>     new_dir->i_ctime = new_dir->i_mtime = CURRENT_TIME;
>+    old_inode->i_ctime = CURRENT_TIME;
>+    reiserfs_update_sd (&th, old_inode);
>
>     if (new_dentry_inode) {
>        // adjust link number of the victim
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>
>  
>


-- 
Hans


