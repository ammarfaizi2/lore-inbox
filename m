Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263245AbTCSW0t>; Wed, 19 Mar 2003 17:26:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263261AbTCSW0t>; Wed, 19 Mar 2003 17:26:49 -0500
Received: from mail-2.tiscali.it ([195.130.225.148]:5286 "EHLO mail.tiscali.it")
	by vger.kernel.org with ESMTP id <S263245AbTCSWZq>;
	Wed, 19 Mar 2003 17:25:46 -0500
Date: Wed, 19 Mar 2003 23:36:25 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: David Mansfield <david@cobite.com>
Cc: David Mansfield <lkml@dm.cobite.com>, linux-kernel@vger.kernel.org,
       Larry McVoy <lm@bitmover.com>
Subject: Re: [ANNOUNCE] cvsps support for parsing BK->CVS kernel tree logs
Message-ID: <20030319223625.GS30541@dualathlon.random>
References: <20030319201101.GQ30541@dualathlon.random> <Pine.LNX.4.44.0303191600150.19298-200000@admin> <20030319213738.GR30541@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030319213738.GR30541@dualathlon.random>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43
X-PGP-Key: 1024R/CB4660B9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 19, 2003 at 10:37:38PM +0100, Andrea Arcangeli wrote:
> But really, any kind of way you implement the 'multiple file' thing is
> fine as far as I can specify more than 1 file ;).

well never mind I implemented it myself, please apply:

--- cvsps-2.0b5/cvsps.c.~1~	2003-03-19 22:39:07.000000000 +0100
+++ cvsps-2.0b5/cvsps.c	2003-03-19 23:20:34.000000000 +0100
@@ -83,7 +83,8 @@ static int do_diff;
 static const char * restrict_author;
 static int have_restrict_log;
 static regex_t restrict_log;
-static const char * restrict_file;
+static int have_restrict_file;
+static regex_t restrict_file;
 static time_t restrict_date_start;
 static time_t restrict_date_end;
 static const char * restrict_branch;
@@ -113,7 +114,7 @@ static int compare_patch_sets_bk(const v
 static int compare_patch_sets(const void *, const void *);
 static int compare_patch_sets_bytime(const void *, const void *);
 static int is_revision_metadata(const char *);
-static int patch_set_contains_member(PatchSet *, const char *);
+static int patch_set_contains_member(PatchSet *, regex_t);
 static int patch_set_affects_branch(PatchSet *, const char *);
 static void do_cvs_diff(PatchSet *);
 static PatchSet * create_patch_set();
@@ -565,7 +566,7 @@ static void parse_args(int argc, char *a
 	    if (++i >= argc)
 		usage("argument to -l missing", "");
 
-	    if ((err = regcomp(&restrict_log, argv[i++], REG_NOSUB)) != 0)
+	    if ((err = regcomp(&restrict_log, argv[i++], REG_NOSUB|REG_EXTENDED)) != 0)
 	    {
 		char errbuf[256];
 		regerror(err, &restrict_log, errbuf, 256);
@@ -579,10 +580,20 @@ static void parse_args(int argc, char *a
 
 	if (strcmp(argv[i], "-f") == 0)
 	{
+	    int err;
+
 	    if (++i >= argc)
 		usage("argument to -f missing", "");
 
-	    restrict_file = argv[i++];
+	    if ((err = regcomp(&restrict_file, argv[i++], REG_NOSUB|REG_EXTENDED)) != 0)
+	    {
+		char errbuf[256];
+		regerror(err, &restrict_file, errbuf, 256);
+		usage("bad regex to -f", errbuf);
+	    }
+
+	    have_restrict_file = 1;
+
 	    continue;
 	}
 	
@@ -1085,7 +1096,7 @@ static void check_print_patch_set(PatchS
     if (have_restrict_log && regexec(&restrict_log, ps->descr, 0, NULL, 0) != 0)
 	return;
 
-    if (restrict_file && !patch_set_contains_member(ps, restrict_file))
+    if (have_restrict_file && !patch_set_contains_member(ps, restrict_file))
 	return;
 
     if (restrict_branch && !patch_set_affects_branch(ps, restrict_branch))
@@ -1332,7 +1343,7 @@ static int is_revision_metadata(const ch
     return 0;
 }
 
-static int patch_set_contains_member(PatchSet * ps, const char * file)
+static int patch_set_contains_member(PatchSet * ps, regex_t restrict_file)
 {
     struct list_head * next = ps->members.next;
 
@@ -1340,7 +1351,7 @@ static int patch_set_contains_member(Pat
     {
 	PatchSetMember * psm = list_entry(next, PatchSetMember, link);
 	
-	if (strstr(psm->file->filename, file))
+	if (!regexec(&restrict_file, psm->file->filename, 0, NULL, 0))
 	    return 1;
 
 	next = next->next;


here the exmaple of output on the linux-2.4 CVS tree:

	cvsps -g -r v2_4_21-pre5 -f '^fs/ext|^drivers/md'

---------------------
PatchSet 2797 
Date: 2003/03/13 18:07:28
Author: marcelo
Branch: HEAD
Tag: (none) 
Log:
Merge bk://thebsh.namesys.com/bk/reiser3-linux-2.4-trivial
into freak.distro.conectiva:/home/marcelo/bk/linux-2.4

2003/03/13 00:26:14-03:00 neilb
[PATCH] md - 1 of 3 - Fix small bug in md.c

We cannot de-reference rdev->sb if rdev->faulty....

 ----------- Diffstat output ------------
 ./drivers/md/md.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

2003/03/12 21:26:20-03:00 alan
[PATCH] PATCH: fix ethernet pad in example driver


BKrev: 3e70c8e041iavxyktSM_Wx9xaQU_iw

Members: 
	ChangeSet:1.2797->1.2798 
	drivers/md/md.c:1.39->1.40 
	drivers/net/pci-skeleton.c:1.18->1.19 

Index: linux-2.4/drivers/md/md.c
diff -u linux-2.4/drivers/md/md.c:1.39 linux-2.4/drivers/md/md.c:1.40
--- linux-2.4/drivers/md/md.c:1.39	Tue Jan 21 13:40:06 2003
+++ linux-2.4/drivers/md/md.c	Thu Mar 13 10:07:28 2003
@@ -1048,7 +1048,7 @@
 			printk("(skipping faulty ");
 		if (rdev->alias_device)
 			printk("(skipping alias ");
-		if (disk_faulty(&rdev->sb->this_disk)) {
+		if (!rdev->faulty && disk_faulty(&rdev->sb->this_disk)) {
 			printk("(skipping new-faulty %s )\n",
 			       partition_name(rdev->dev));
 			continue;
Index: linux-2.4/drivers/net/pci-skeleton.c
diff -u linux-2.4/drivers/net/pci-skeleton.c:1.18 linux-2.4/drivers/net/pci-skeleton.c:1.19
--- linux-2.4/drivers/net/pci-skeleton.c:1.18	Mon Dec  2 06:02:19 2002
+++ linux-2.4/drivers/net/pci-skeleton.c	Thu Mar 13 10:07:28 2003
@@ -1348,6 +1348,16 @@
 	void *ioaddr = tp->mmio_addr;
 	int entry;
 
+	/* If we don't have auto-pad remember not to send random
+	   memory! */
+	   
+	if (skb->len < ETH_ZLEN)
+	{
+		skb = skb_padto(skb, ETH_ZLEN);
+		if(skb == NULL)
+			return 0;
+	}
+	
 	/* Calculate the next Tx descriptor entry. */
 	entry = atomic_read (&tp->cur_tx) % NUM_TX_DESC;
 
@@ -1358,9 +1368,8 @@
 	/* tp->tx_info[entry].mapping = 0; */
 	memcpy (tp->tx_buf[entry], skb->data, skb->len);
 
-	/* Note: the chip doesn't have auto-pad! */
 	NETDRV_W32 (TxStatus0 + (entry * sizeof(u32)),
-		 tp->tx_flag | (skb->len >= ETH_ZLEN ? skb->len : ETH_ZLEN));
+		 tp->tx_flag | skb->len);
 
 	dev->trans_start = jiffies;
 	atomic_inc (&tp->cur_tx);
---------------------
PatchSet 2798 
Date: 2003/03/13 18:56:53
Author: tytso
Branch: HEAD
Tag: (none) 
Log:
[PATCH] Ext2/3: noatime ignored for newly created inodes

I recently noticed a bug in ext2/3; newly created inodes which inherit
the noatime flag from their containing directory do not respect noatime
until the inode is flushed from the inode cache and then re-read later.
This is because the code which checks the ext2 no-atime attribute and
then sets the S_NOATIME in inode->i_flags is present in
ext2_read_inode(), but not in ext2_new_inode().

This patch centralizes the code which translates the ext2 flags in the
raw ext2 inode to the appropriate flag values in inode->i_flags in a
single location.  This fixes the bug, and also removes 30 lines of code
and 128 bytes of compiled x86 text in the bargain.

						- Ted

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
#
# fs/ext2/ialloc.c        |    3 +--
# fs/ext2/inode.c         |   32 ++++++++++++++++---------------
# fs/ext2/ioctl.c         |   17 +----------------
# fs/ext3/ialloc.c        |    3 +--
# fs/ext3/inode.c         |   34 +++++++++++++++++--------------
# fs/ext3/ioctl.c         |   17 +----------------
# include/linux/ext2_fs.h |    1 +
# include/linux/ext3_fs.h |    1 +
# 8 files changed, 39 insertions(+), 69 deletions(-)
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/03/12	tytso@think.thunk.org	1.1016
# Centralize ext23->inode flags setting.
#
# This fixes a bug where the noatime flag not being honored in inodes
# which inherited noatime from their directory flag (at least not until
# inode was flushed out of the inode cache and then re-read into the inode
# cache later on), and also saves code because the common code has all been
# factored out.
# --------------------------------------------
#

BKrev: 3e70d475qOytBWLa8QU7B_3YDkcciA

Members: 
	ChangeSet:1.2798->1.2799 
	fs/ext2/ialloc.c:1.10->1.11 
	fs/ext2/inode.c:1.17->1.18 
	fs/ext2/ioctl.c:1.3->1.4 
	fs/ext3/ialloc.c:1.6->1.7 
	fs/ext3/inode.c:1.14->1.15 
	fs/ext3/ioctl.c:1.3->1.4 
	include/linux/ext2_fs.h:1.7->1.8 
	include/linux/ext3_fs.h:1.6->1.7 

Index: linux-2.4/fs/ext2/ialloc.c
diff -u linux-2.4/fs/ext2/ialloc.c:1.10 linux-2.4/fs/ext2/ialloc.c:1.11
--- linux-2.4/fs/ext2/ialloc.c:1.10	Wed Nov 13 05:59:44 2002
+++ linux-2.4/fs/ext2/ialloc.c	Thu Mar 13 10:56:53 2003
@@ -390,8 +390,7 @@
 	if (S_ISLNK(mode))
 		inode->u.ext2_i.i_flags &= ~(EXT2_IMMUTABLE_FL|EXT2_APPEND_FL);
 	inode->u.ext2_i.i_block_group = group;
-	if (inode->u.ext2_i.i_flags & EXT2_SYNC_FL)
-		inode->i_flags |= S_SYNC;
+	ext2_set_inode_flags(inode);
 	insert_inode_hash(inode);
 	inode->i_generation = event++;
 	mark_inode_dirty(inode);
Index: linux-2.4/fs/ext2/inode.c
diff -u linux-2.4/fs/ext2/inode.c:1.17 linux-2.4/fs/ext2/inode.c:1.18
--- linux-2.4/fs/ext2/inode.c:1.17	Wed Nov 20 04:55:10 2002
+++ linux-2.4/fs/ext2/inode.c	Thu Mar 13 10:56:53 2003
@@ -877,6 +877,21 @@
 	}
 }
 
+void ext2_set_inode_flags(struct inode *inode)
+{
+	unsigned int flags = inode->u.ext2_i.i_flags;
+
+	inode->i_flags &= ~(S_SYNC|S_APPEND|S_IMMUTABLE|S_NOATIME);
+	if (flags & EXT2_SYNC_FL)
+		inode->i_flags |= S_SYNC;
+	if (flags & EXT2_APPEND_FL)
+		inode->i_flags |= S_APPEND;
+	if (flags & EXT2_IMMUTABLE_FL)
+		inode->i_flags |= S_IMMUTABLE;
+	if (flags & EXT2_NOATIME_FL)
+		inode->i_flags |= S_NOATIME;
+}
+
 void ext2_read_inode (struct inode * inode)
 {
 	struct buffer_head * bh;
@@ -997,22 +1012,7 @@
 				   le32_to_cpu(raw_inode->i_block[0]));
 	brelse (bh);
 	inode->i_attr_flags = 0;
-	if (inode->u.ext2_i.i_flags & EXT2_SYNC_FL) {
-		inode->i_attr_flags |= ATTR_FLAG_SYNCRONOUS;
-		inode->i_flags |= S_SYNC;
-	}
-	if (inode->u.ext2_i.i_flags & EXT2_APPEND_FL) {
-		inode->i_attr_flags |= ATTR_FLAG_APPEND;
-		inode->i_flags |= S_APPEND;
-	}
-	if (inode->u.ext2_i.i_flags & EXT2_IMMUTABLE_FL) {
-		inode->i_attr_flags |= ATTR_FLAG_IMMUTABLE;
-		inode->i_flags |= S_IMMUTABLE;
-	}
-	if (inode->u.ext2_i.i_flags & EXT2_NOATIME_FL) {
-		inode->i_attr_flags |= ATTR_FLAG_NOATIME;
-		inode->i_flags |= S_NOATIME;
-	}
+	ext2_set_inode_flags(inode);
 	return;
 	
 bad_inode:
Index: linux-2.4/fs/ext2/ioctl.c
diff -u linux-2.4/fs/ext2/ioctl.c:1.3 linux-2.4/fs/ext2/ioctl.c:1.4
--- linux-2.4/fs/ext2/ioctl.c:1.3	Wed Aug  7 14:52:19 2002
+++ linux-2.4/fs/ext2/ioctl.c	Thu Mar 13 10:56:53 2003
@@ -53,22 +53,7 @@
 		flags |= oldflags & ~EXT2_FL_USER_MODIFIABLE;
 		inode->u.ext2_i.i_flags = flags;
 
-		if (flags & EXT2_SYNC_FL)
-			inode->i_flags |= S_SYNC;
-		else
-			inode->i_flags &= ~S_SYNC;
-		if (flags & EXT2_APPEND_FL)
-			inode->i_flags |= S_APPEND;
-		else
-			inode->i_flags &= ~S_APPEND;
-		if (flags & EXT2_IMMUTABLE_FL)
-			inode->i_flags |= S_IMMUTABLE;
-		else
-			inode->i_flags &= ~S_IMMUTABLE;
-		if (flags & EXT2_NOATIME_FL)
-			inode->i_flags |= S_NOATIME;
-		else
-			inode->i_flags &= ~S_NOATIME;
+		ext2_set_inode_flags(inode);
 		inode->i_ctime = CURRENT_TIME;
 		mark_inode_dirty(inode);
 		return 0;
Index: linux-2.4/fs/ext3/ialloc.c
diff -u linux-2.4/fs/ext3/ialloc.c:1.6 linux-2.4/fs/ext3/ialloc.c:1.7
--- linux-2.4/fs/ext3/ialloc.c:1.6	Mon Jan  6 09:47:17 2003
+++ linux-2.4/fs/ext3/ialloc.c	Thu Mar 13 10:56:53 2003
@@ -500,8 +500,7 @@
 #endif
 	inode->u.ext3_i.i_block_group = i;
 	
-	if (inode->u.ext3_i.i_flags & EXT3_SYNC_FL)
-		inode->i_flags |= S_SYNC;
+	ext3_set_inode_flags(inode);
 	if (IS_SYNC(inode))
 		handle->h_sync = 1;
 	insert_inode_hash(inode);
Index: linux-2.4/fs/ext3/inode.c
diff -u linux-2.4/fs/ext3/inode.c:1.14 linux-2.4/fs/ext3/inode.c:1.15
--- linux-2.4/fs/ext3/inode.c:1.14	Wed Feb  5 15:15:33 2003
+++ linux-2.4/fs/ext3/inode.c	Thu Mar 13 10:56:53 2003
@@ -2068,6 +2068,22 @@
 	return -EIO;
 }
 
+void ext3_set_inode_flags(struct inode *inode)
+{
+	unsigned int flags = inode->u.ext3_i.i_flags;
+
+	inode->i_flags &= ~(S_SYNC|S_APPEND|S_IMMUTABLE|S_NOATIME);
+	if (flags & EXT3_SYNC_FL)
+		inode->i_flags |= S_SYNC;
+	if (flags & EXT3_APPEND_FL)
+		inode->i_flags |= S_APPEND;
+	if (flags & EXT3_IMMUTABLE_FL)
+		inode->i_flags |= S_IMMUTABLE;
+	if (flags & EXT3_NOATIME_FL)
+		inode->i_flags |= S_NOATIME;
+}
+
+
 void ext3_read_inode(struct inode * inode)
 {
 	struct ext3_iloc iloc;
@@ -2165,23 +2181,7 @@
 	} else 
 		init_special_inode(inode, inode->i_mode,
 				   le32_to_cpu(iloc.raw_inode->i_block[0]));
-	/* inode->i_attr_flags = 0;				unused */
-	if (inode->u.ext3_i.i_flags & EXT3_SYNC_FL) {
-		/* inode->i_attr_flags |= ATTR_FLAG_SYNCRONOUS; unused */
-		inode->i_flags |= S_SYNC;
-	}
-	if (inode->u.ext3_i.i_flags & EXT3_APPEND_FL) {
-		/* inode->i_attr_flags |= ATTR_FLAG_APPEND;	unused */
-		inode->i_flags |= S_APPEND;
-	}
-	if (inode->u.ext3_i.i_flags & EXT3_IMMUTABLE_FL) {
-		/* inode->i_attr_flags |= ATTR_FLAG_IMMUTABLE;	unused */
-		inode->i_flags |= S_IMMUTABLE;
-	}
-	if (inode->u.ext3_i.i_flags & EXT3_NOATIME_FL) {
-		/* inode->i_attr_flags |= ATTR_FLAG_NOATIME;	unused */
-		inode->i_flags |= S_NOATIME;
-	}
+	ext3_set_inode_flags(inode);
 	return;
 	
 bad_inode:
Index: linux-2.4/fs/ext3/ioctl.c
diff -u linux-2.4/fs/ext3/ioctl.c:1.3 linux-2.4/fs/ext3/ioctl.c:1.4
--- linux-2.4/fs/ext3/ioctl.c:1.3	Wed Aug  7 14:52:19 2002
+++ linux-2.4/fs/ext3/ioctl.c	Thu Mar 13 10:56:53 2003
@@ -81,22 +81,7 @@
 		flags |= oldflags & ~EXT3_FL_USER_MODIFIABLE;
 		inode->u.ext3_i.i_flags = flags;
 
-		if (flags & EXT3_SYNC_FL)
-			inode->i_flags |= S_SYNC;
-		else
-			inode->i_flags &= ~S_SYNC;
-		if (flags & EXT3_APPEND_FL)
-			inode->i_flags |= S_APPEND;
-		else
-			inode->i_flags &= ~S_APPEND;
-		if (flags & EXT3_IMMUTABLE_FL)
-			inode->i_flags |= S_IMMUTABLE;
-		else
-			inode->i_flags &= ~S_IMMUTABLE;
-		if (flags & EXT3_NOATIME_FL)
-			inode->i_flags |= S_NOATIME;
-		else
-			inode->i_flags &= ~S_NOATIME;
+		ext3_set_inode_flags(inode);
 		inode->i_ctime = CURRENT_TIME;
 
 		err = ext3_mark_iloc_dirty(handle, inode, &iloc);
Index: linux-2.4/include/linux/ext2_fs.h
diff -u linux-2.4/include/linux/ext2_fs.h:1.7 linux-2.4/include/linux/ext2_fs.h:1.8
--- linux-2.4/include/linux/ext2_fs.h:1.7	Tue Feb  5 12:23:54 2002
+++ linux-2.4/include/linux/ext2_fs.h	Thu Mar 13 10:56:53 2003
@@ -587,6 +587,7 @@
 extern int ext2_sync_inode (struct inode *);
 extern void ext2_discard_prealloc (struct inode *);
 extern void ext2_truncate (struct inode *);
+extern void ext2_set_inode_flags(struct inode *inode);
 
 /* ioctl.c */
 extern int ext2_ioctl (struct inode *, struct file *, unsigned int,
Index: linux-2.4/include/linux/ext3_fs.h
diff -u linux-2.4/include/linux/ext3_fs.h:1.6 linux-2.4/include/linux/ext3_fs.h:1.7
--- linux-2.4/include/linux/ext3_fs.h:1.6	Mon Jan  6 09:47:17 2003
+++ linux-2.4/include/linux/ext3_fs.h	Thu Mar 13 10:56:53 2003
@@ -642,6 +642,7 @@
 extern void ext3_dirty_inode(struct inode *);
 extern int ext3_change_inode_journal_flag(struct inode *, int);
 extern void ext3_truncate (struct inode *);
+extern void ext3_set_inode_flags(struct inode *);
 
 /* ioctl.c */
 extern int ext3_ioctl (struct inode *, struct file *, unsigned int,


this is a critical feature for me, note that if Larry agreed of tagging
the tree with the atomic-date of the patchset extracting those patchset
would be an order of magnitude faster, I would pay for the RTT latency 1
per patchset, not once per file and it would be possible to teach cvsps
to learn diffing against the tag if it matches. Anyways stuff works now
so I'll just wait for the RTT all the time w/o being able to use the
real bandwidth provided by my link. As soon as the CVS tarball is
available I'll use it for the large patch extractions.

One more feature wish (besides the python inteface for a quick gui) is
the C^c killing cvsps too during a -g patch extraction, you probably
should check the return code of cvs when extracting the patches. Right
now I press C^z and then I killall cvsps ;)

BTW, I think cvsps should be shipped together with cvs and integrated
over time in the unstable branch, this is a major feature for any cvs
user. Storing metadata locally is the way to go, over time the whole
tree should be cached local (as an option). This is actually the major
cvs improvement I seen since years. And I'm glad I can contribute to it
unlike many kernel developers out there.

Andrea
