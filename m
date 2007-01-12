Return-Path: <linux-kernel-owner+w=401wt.eu-S1030316AbXALUp6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030316AbXALUp6 (ORCPT <rfc822;w@1wt.eu>);
	Fri, 12 Jan 2007 15:45:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030311AbXALUp6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Jan 2007 15:45:58 -0500
Received: from mx1.redhat.com ([66.187.233.31]:52131 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030197AbXALUp5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Jan 2007 15:45:57 -0500
Message-ID: <45A7F384.3050303@redhat.com>
Date: Fri, 12 Jan 2007 14:45:56 -0600
From: Eric Sandeen <sandeen@redhat.com>
User-Agent: Thunderbird 1.5.0.9 (X11/20061219)
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ext4 development <linux-ext4@vger.kernel.org>
Subject: [PATCH] [RFC] remove ext3 inode from orphan list when link and unlink
 race
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've been looking at a case where many threads are opening, unlinking, and
hardlinking files on ext3 .  At unmount time I see an oops, because the superblock's
orphan list points to a freed inode.

I did some tracing of the inodes, and it looks like this:

  ext3_unlink():[/src/linux-2.6.18/fs/ext3/namei.c:2123] adding orphan
      i_state:0x7 cpu:1 i_count:2 i_nlink:0

  ext3_orphan_add():[/src/linux-2.6.18/fs/ext3/namei.c:1890] ext3_orphan_add
      i_state:0x7 cpu:1 i_count:2 i_nlink:0

  iput():[/src/linux-2.6.18/fs/inode.c:1139] iput enter
      i_state:0x7 cpu:1 i_count:2 i_nlink:0

  ext3_link():[/src/linux-2.6.18/fs/ext3/namei.c:2202] ext3_link enter
      i_state:0x7 cpu:3 i_count:1 i_nlink:0

  ext3_inc_count():[/src/linux-2.6.18/fs/ext3/namei.c:1627] done
      i_state:0x7 cpu:3 i_count:1 i_nlink:1

The unlink gets there first, finds i_count > 0 (in use) but nlink goes to 0, so
it puts it on the orphan inode list.  Then link comes along, and bumps the link
back up to 1.  So now we are on the orphan inode list, but we are not unlinked.

Eventually when count goes to 0, and we still have 1 link, again no action is
taken to remove the inode from the orphan list, because it is still linked (i.e.
we don't go through ext3_delete())

When this inode is eventually freed, the sb orphan list gets corrupted, because 
we have freed it without first removing it from the orphan list.

I think the simple solution is to remove the inode from the orphan list
when we bump the link back up from 0 to 1.  I put that test in there because
there are other potential reasons that we might be on the list (truncates,
direct IO).

Comments?

Thanks,
-Eric

p.s. ext3_inc_count and ext3_dec_count seem misnamed, have an unused
arg, and are very infrequently called.  I'll probably submit a patch
to just put the single line of code into the caller, too.

---

Remove inode from the orphan list in ext3_link() if we might have
raced with ext3_unlink(), which potentially put it on the list.
If we're on the list with nlink > 0, we'll never get cleaned up
properly and eventually may corrupt the list.

Signed-off-by: Eric Sandeen <sandeen@redhat.com>

Index: linux-2.6.19/fs/ext3/namei.c
===================================================================
--- linux-2.6.19.orig/fs/ext3/namei.c
+++ linux-2.6.19/fs/ext3/namei.c
@@ -2204,6 +2204,9 @@ retry:
 	inode->i_ctime = CURRENT_TIME_SEC;
 	ext3_inc_count(handle, inode);
 	atomic_inc(&inode->i_count);
+	/* did we race w/ unlink? */
+	if (inode->i_nlink == 1)
+		ext3_orphan_del(handle, inode);
 
 	err = ext3_add_nondir(handle, dentry, inode);
 	ext3_journal_stop(handle);


