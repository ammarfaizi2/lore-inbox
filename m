Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263082AbVF3WhK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263082AbVF3WhK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Jun 2005 18:37:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263089AbVF3WhK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Jun 2005 18:37:10 -0400
Received: from ppsw-1.csi.cam.ac.uk ([131.111.8.131]:47264 "EHLO
	ppsw-1.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S263082AbVF3Wfv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Jun 2005 18:35:51 -0400
X-Cam-SpamDetails: Not scanned
X-Cam-AntiVirus: No virus found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Date: Thu, 30 Jun 2005 23:35:37 +0100 (BST)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: David =?utf-8?B?R8OzbWV6?= <david@pleyades.net>
cc: Robert Love <rml@novell.com>, John McCutchan <ttb@tentacle.dhs.org>,
       Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Problem with inotify
In-Reply-To: <20050630204832.GA3854@fargo>
Message-ID: <Pine.LNX.4.60.0506302158190.29755@hermes-1.csi.cam.ac.uk>
References: <20050630181824.GA1058@fargo> <1120156188.6745.103.camel@betsy>
 <20050630193320.GA1136@fargo> <Pine.LNX.4.60.0506302138230.29755@hermes-1.csi.cam.ac.uk>
 <20050630204832.GA3854@fargo>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="1870869256-566594861-1120169029=:29755"
Content-ID: <Pine.LNX.4.60.0506302317380.29755@hermes-1.csi.cam.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1870869256-566594861-1120169029=:29755
Content-Type: TEXT/PLAIN; CHARSET=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <Pine.LNX.4.60.0506302315231.29755@hermes-1.csi.cam.ac.uk>

On Thu, 30 Jun 2005, David [utf-8] G=F3mez wrote:
> On Jun 30 at 09:39:47, Anton Altaparmakov wrote:
> > > I tested it again, wchan says "inode_wait"...
> >=20
> > Do you have any ntfs volumes mounted by any chance?=20
>=20
> No, just ext2

Ok, the ntfs deadlock doesn't affect you then.

So there appears to be a change in the VFS which causes deadlocks=20
associated with both mounting and umounting of filesystems, and this is=20
either introduced by inotify or just made more likely (i.e. 100% of time)=
=20
by inotify but the change is elsewhere.

Given you see inode_wait it suggests it is a simillar problem to the one I=
=20
found in ntfs.  For a detailed description of how that deadlock comes=20
about see the patch fixing it (appended to end of this email).

So what we probably are somehow getting is that say we have a lock=20
(perhaps i_sem or inode_lock?) and an inode.  And we have two processes=20
which do:

Process 1=09=09=09Process 2
lock the inode (I_LOCK)
=09=09=09=09take the lock
try to take the lock -> block
=09=09=09=09wait_on_inode() -> block
Deadlock.

The question is how and where does that happen?

So far it was only triggering at umount time so it is very interesting=20
that you are seeing it at mount time as well.

ps. Of course it could actually be one single process which takes I_LOCK=20
and then ends up waiting on the inode later on which of course never=20
happens...

Best regards,

=09Anton
--=20
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/

--- This is the patch with description of the deadlock in ntfs. ---

From=20akpm@osdl.org Sun Jun 26 20:33:02 2005
Date: Sun, 26 Jun 2005 12:32:27 -0700
From: akpm@osdl.org
To: aia21@cam.ac.uk, aia21@cantab.net, mm-commits@vger.kernel.org
Subject: fix-soft-lockup-due-to-ntfs-vfs-part-and-explanation.patch added t=
o -mm tree


The patch titled

     Fix soft lockup due to NTFS: VFS part and explanation

has been added to the -mm tree.  Its filename is

     fix-soft-lockup-due-to-ntfs-vfs-part-and-explanation.patch

Patches currently in -mm which might be from aia21@cam.ac.uk are

fix-soft-lockup-due-to-ntfs-vfs-part-and-explanation.patch



From: Anton Altaparmakov <aia21@cam.ac.uk>

Something has changed in the core kernel such that we now get concurrent
inode write outs, one e.g via pdflush and one via sys_sync or whatever.=20
This causes a nasty deadlock in ntfs.  The only clean solution
unfortunately requires a minor vfs api extension.

First the deadlock analysis:

Prerequisive knowledge: NTFS has a file $MFT (inode 0) loaded at mount
time.  The NTFS driver uses the page cache for storing the file contents as
usual.  More interestingly this file contains the table of on-disk inodes
as a sequence of MFT_RECORDs.  Thus NTFS driver accesses the on-disk inodes
by accessing the MFT_RECORDs in the page cache pages of the loaded inode
$MFT.

The situation: VFS inode X on a mounted ntfs volume is dirty.  For same
inode X, the ntfs_inode is dirty and thus corresponding on-disk inode,
which is as explained above in a dirty PAGE_CACHE_PAGE belonging to the
table of inodes ($MFT, inode 0).

What happens:

Process 1: sys_sync()/umount()/whatever...  calls __sync_single_inode() for
$MFT -> do_writepages() -> write_page for the dirty page containing the
on-disk inode X, the page is now locked -> ntfs_write_mst_block() which
clears PageUptodate() on the page to prevent anyone else getting hold of it
whilst it does the write out (this is necessary as the on-disk inode needs
"fixups" applied before the write to disk which are removed again after the
write and PageUptodate is then set again).  It then analyses the page
looking for dirty on-disk inodes and when it finds one it calls
ntfs_may_write_mft_record() to see if it is safe to write this on-disk
inode.  This then calls ilookup5() to check if the corresponding VFS inode
is in icache().  This in turn calls ifind() which waits on the inode lock
via wait_on_inode whilst holding the global inode_lock.

Process 2: pdflush results in a call to __sync_single_inode for the same
VFS inode X on the ntfs volume.  This locks the inode (I_LOCK) then calls
write-inode -> ntfs_write_inode -> map_mft_record() -> read_cache_page() of
the page (in page cache of table of inodes $MFT, inode 0) containing the
on-disk inode.  This page has PageUptodate() clear because of Process 1
(see above) so read_cache_page() blocks when tries to take the page lock
for the page so it can call ntfs_read_page().

Thus Process 1 is holding the page lock on the page containing the on-disk
inode X and it is waiting on the inode X to be unlocked in ifind() so it
can write the page out and then unlock the page.

And Process 2 is holding the inode lock on inode X and is waiting for the=
=20
page to be unlocked so it can call ntfs_readpage() or discover that=20
Process 1 set PageUptodate() again and use the page.

Thus we have a deadlock due to ifind() waiting on the inode lock.

The only sensible solution: NTFS does not care whether the VFS inode is
locked or not when it calls ilookup5() (it doesn't use the VFS inode at
all, it just uses it to find the corresponding ntfs_inode which is of
course attached to the VFS inode (both are one single struct); and it uses
the ntfs_inode which is subject to its own locking so I_LOCK is irrelevant)
hence we want a modified ilookup5_nowait() which is the same as ilookup5()
but it does not wait on the inode lock.

Without such functionality I would have to keep my own ntfs_inode cache in
the NTFS driver just so I can find ntfs_inodes independent of their VFS
inodes which would be slow, memory and cpu cycle wasting, and incredibly
stupid given the icache already exists in the VFS.

Below is a patch that does the ilookup5_nowait() implementation in=20
fs/inode.c and exports it.


ilookup5_nowait.diff:

Introduce ilookup5_nowait() which is basically the same as ilookup5() but=
=20
it does not wait on the inode's lock (i.e. it omits the wait_on_inode()=20
done in ifind()).

This is needed to avoid a nasty deadlock in NTFS.

Signed-off-by: Anton Altaparmakov <aia21@cantab.net>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 fs/inode.c         |   45 +++++++++++++++++++++++++++++++++++++++------
 include/linux/fs.h |    3 +++
 2 files changed, 42 insertions(+), 6 deletions(-)

diff -puN fs/inode.c~fix-soft-lockup-due-to-ntfs-vfs-part-and-explanation f=
s/inode.c
--- 25/fs/inode.c~fix-soft-lockup-due-to-ntfs-vfs-part-and-explanation=0920=
05-06-26 12:32:21.000000000 -0700
+++ 25-akpm/fs/inode.c=092005-06-26 12:32:21.000000000 -0700
@@ -757,6 +757,7 @@ EXPORT_SYMBOL(igrab);
  * @head:       the head of the list to search
  * @test:=09callback used for comparisons between inodes
  * @data:=09opaque data pointer to pass to @test
+ * @wait:=09if true wait for the inode to be unlocked, if false do not
  *
  * ifind() searches for the inode specified by @data in the inode
  * cache. This is a generalized version of ifind_fast() for file systems w=
here
@@ -771,7 +772,7 @@ EXPORT_SYMBOL(igrab);
  */
 static inline struct inode *ifind(struct super_block *sb,
 =09=09struct hlist_head *head, int (*test)(struct inode *, void *),
-=09=09void *data)
+=09=09void *data, const int wait)
 {
 =09struct inode *inode;
=20
@@ -780,7 +781,8 @@ static inline struct inode *ifind(struct
 =09if (inode) {
 =09=09__iget(inode);
 =09=09spin_unlock(&inode_lock);
-=09=09wait_on_inode(inode);
+=09=09if (likely(wait))
+=09=09=09wait_on_inode(inode);
 =09=09return inode;
 =09}
 =09spin_unlock(&inode_lock);
@@ -820,7 +822,7 @@ static inline struct inode *ifind_fast(s
 }
=20
 /**
- * ilookup5 - search for an inode in the inode cache
+ * ilookup5_nowait - search for an inode in the inode cache
  * @sb:=09=09super block of file system to search
  * @hashval:=09hash value (usually inode number) to search for
  * @test:=09callback used for comparisons between inodes
@@ -832,7 +834,38 @@ static inline struct inode *ifind_fast(s
  * identification of an inode.
  *
  * If the inode is in the cache, the inode is returned with an incremented
- * reference count.
+ * reference count.  Note, the inode lock is not waited upon so you have t=
o be
+ * very careful what you do with the returned inode.  You probably should =
be
+ * using ilookup5() instead.
+ *
+ * Otherwise NULL is returned.
+ *
+ * Note, @test is called with the inode_lock held, so can't sleep.
+ */
+struct inode *ilookup5_nowait(struct super_block *sb, unsigned long hashva=
l,
+=09=09int (*test)(struct inode *, void *), void *data)
+{
+=09struct hlist_head *head =3D inode_hashtable + hash(sb, hashval);
+
+=09return ifind(sb, head, test, data, 0);
+}
+
+EXPORT_SYMBOL(ilookup5_nowait);
+
+/**
+ * ilookup5 - search for an inode in the inode cache
+ * @sb:=09=09super block of file system to search
+ * @hashval:=09hash value (usually inode number) to search for
+ * @test:=09callback used for comparisons between inodes
+ * @data:=09opaque data pointer to pass to @test
+ *
+ * ilookup5() uses ifind() to search for the inode specified by @hashval a=
nd
+ * @data in the inode cache. This is a generalized version of ilookup() fo=
r
+ * file systems where the inode number is not sufficient for unique
+ * identification of an inode.
+ *
+ * If the inode is in the cache, the inode lock is waited upon and the ino=
de is
+ * returned with an incremented reference count.
  *
  * Otherwise NULL is returned.
  *
@@ -843,7 +876,7 @@ struct inode *ilookup5(struct super_bloc
 {
 =09struct hlist_head *head =3D inode_hashtable + hash(sb, hashval);
=20
-=09return ifind(sb, head, test, data);
+=09return ifind(sb, head, test, data, 1);
 }
=20
 EXPORT_SYMBOL(ilookup5);
@@ -900,7 +933,7 @@ struct inode *iget5_locked(struct super_
 =09struct hlist_head *head =3D inode_hashtable + hash(sb, hashval);
 =09struct inode *inode;
=20
-=09inode =3D ifind(sb, head, test, data);
+=09inode =3D ifind(sb, head, test, data, 1);
 =09if (inode)
 =09=09return inode;
 =09/*
diff -puN include/linux/fs.h~fix-soft-lockup-due-to-ntfs-vfs-part-and-expla=
nation include/linux/fs.h
--- 25/include/linux/fs.h~fix-soft-lockup-due-to-ntfs-vfs-part-and-explanat=
ion=092005-06-26 12:32:21.000000000 -0700
+++ 25-akpm/include/linux/fs.h=092005-06-26 12:32:21.000000000 -0700
@@ -1442,6 +1442,9 @@ extern int inode_needs_sync(struct inode
 extern void generic_delete_inode(struct inode *inode);
 extern void generic_drop_inode(struct inode *inode);
=20
+extern struct inode *ilookup5_nowait(struct super_block *sb,
+=09=09unsigned long hashval, int (*test)(struct inode *, void *),
+=09=09void *data);
 extern struct inode *ilookup5(struct super_block *sb, unsigned long hashva=
l,
 =09=09int (*test)(struct inode *, void *), void *data);
 extern struct inode *ilookup(struct super_block *sb, unsigned long ino);
_
--1870869256-566594861-1120169029=:29755--
