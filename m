Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268021AbRHFL6w>; Mon, 6 Aug 2001 07:58:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268042AbRHFL6m>; Mon, 6 Aug 2001 07:58:42 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:35288 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S268021AbRHFL6a>;
	Mon, 6 Aug 2001 07:58:30 -0400
Date: Mon, 6 Aug 2001 07:58:37 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Richard Gooch <rgooch@ras.ucalgary.ca>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: [PATCH] one of $BIGNUM devfs races
Message-ID: <Pine.GSO.4.21.0108060723110.13716-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	OK, folks - that's it.  By all reasonable standards a year _is_
sufficient time to fix an obvious race.  One in devfs/base.c::create_entry()
had been described to Richard more than a year ago.  While I respect the
"I'll do it myself, don't spoil the fun" stance, it's clearly over the
bleedin' top.  Patch for that one is in the end of posting.  Linus, see
if it looks sane for you.

	Richard, _please_, stop adding features and spend some of the
freed time fixing the long-standing security holes.  E.g., readlink()
on devfs is a big "boys, come and get some" sign on the kernel's arse.
_Anyone_ can crash the box with devfs mounted on it as soon as rmmod
removes a symlink.  Yes, that one had been pointed out to you only
a couple of months ago.  It's less than a year, but could we please
get it fixed in some reasonable time?  By the end of December or
something...

	When devfs went into the tree, the word was "at least it will
make people look at the code".  Well, it did.  Veni, vidi, vomere.
There are tons of bad races in devfs/base.c.  Reported to you many times -
just look through your mailbox.  Richard, please, either fix the crap
yourself or step down and admit that devfs is unmaintained.  Saying
that you'll fix it yourself is nice, but there's a point when it gets
really old.  And that point had been crossed _way_ back.

--- S8-pre4/fs/devfs/base.c	Sun Jul 29 01:54:47 2001
+++ /tmp/base.c	Mon Aug  6 07:14:09 2001
@@ -789,47 +789,70 @@
 static struct devfs_entry *create_entry (struct devfs_entry *parent,
 					 const char *name,unsigned int namelen)
 {
-    struct devfs_entry *new, **table;
+	struct devfs_entry *new;
 
-    /*  First ensure table size is enough  */
-    if (fs_info.num_inodes >= fs_info.table_size)
-    {
-	if ( ( table = kmalloc (sizeof *table *
-				(fs_info.table_size + INODE_TABLE_INC),
-				GFP_KERNEL) ) == NULL ) return NULL;
-	fs_info.table_size += INODE_TABLE_INC;
+	if (name && namelen<1)
+		namelen = strlen (name);
+
+	new = kmalloc(sizeof(*new) + namelen, GFP_KERNEL);
+
+	if (!new)
+		return NULL;
+
+	/*
+	 * Magic: this will set the ctime to zero, thus subsequent lookups
+	 * will trigger the call to <update_devfs_inode_from_entry>
+	 */
+	memset (new, 0, sizeof *new + namelen);
+	new->parent = parent;
+	if (name)
+		memcpy (new->name, name, namelen);
+	new->namelen = namelen;
+	new->inode.nlink = 1;
+
+	/*  Ensure table size is enough  */
+	while (fs_info.num_inodes >= fs_info.table_size) {
+		unsigned new_size = fs_info.table_size + INODE_TABLE_INC;
+		struct devfs_entry **table;
+
+		table = kmalloc(sizeof(*table) * new_size, GFP_KERNEL);
+
+		if (new_size <= fs_info.table_size) {
+			kfree(table);
+			continue;
+		}
+		if (!table) {
+			kfree(new);
+			return NULL;
+		}
+		fs_info.table_size = new_size;
+		if (!fs_info.table) {
+			fs_info.table = table;
+			break;
+		}
+		memcpy(table, fs_info.table, sizeof(*table)*fs_info.num_inodes);
+		kfree (fs_info.table);
+		fs_info.table = table;
 #ifdef CONFIG_DEVFS_DEBUG
-	if (devfs_debug & DEBUG_I_CREATE)
-	    printk ("%s: create_entry(): grew inode table to: %u entries\n",
-		    DEVFS_NAME, fs_info.table_size);
+		if (devfs_debug & DEBUG_I_CREATE)
+			printk("%s: create_entry(): grew inode table to:"
+				"%u entries\n", DEVFS_NAME, new_size);
 #endif
-	if (fs_info.table)
-	{
-	    memcpy (table, fs_info.table, sizeof *table *fs_info.num_inodes);
-	    kfree (fs_info.table);
 	}
-	fs_info.table = table;
-    }
-    if ( name && (namelen < 1) ) namelen = strlen (name);
-    if ( ( new = kmalloc (sizeof *new + namelen, GFP_KERNEL) ) == NULL )
-	return NULL;
-    /*  Magic: this will set the ctime to zero, thus subsequent lookups will
-	trigger the call to <update_devfs_inode_from_entry>  */
-    memset (new, 0, sizeof *new + namelen);
-    new->parent = parent;
-    if (name) memcpy (new->name, name, namelen);
-    new->namelen = namelen;
-    new->inode.ino = fs_info.num_inodes + FIRST_INODE;
-    new->inode.nlink = 1;
-    fs_info.table[fs_info.num_inodes] = new;
-    ++fs_info.num_inodes;
-    if (parent == NULL) return new;
-    new->prev = parent->u.dir.last;
-    /*  Insert into the parent directory's list of children  */
-    if (parent->u.dir.first == NULL) parent->u.dir.first = new;
-    else parent->u.dir.last->next = new;
-    parent->u.dir.last = new;
-    return new;
+
+	new->inode.ino = fs_info.num_inodes + FIRST_INODE;
+	fs_info.table[fs_info.num_inodes++] = new;
+
+	if (parent) {
+		new->prev = parent->u.dir.last;
+		/*  Insert into the parent directory's list of children  */
+		if (parent->u.dir.first)
+			parent->u.dir.last->next = new;
+		else
+			parent->u.dir.first = new;
+		parent->u.dir.last = new;
+	}
+	return new;
 }   /*  End Function create_entry  */
 
 static void update_devfs_inode_from_entry (struct devfs_entry *de)

