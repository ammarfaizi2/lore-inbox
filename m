Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262570AbSJBSpf>; Wed, 2 Oct 2002 14:45:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262572AbSJBSpe>; Wed, 2 Oct 2002 14:45:34 -0400
Received: from 213-84-216-119.adsl.xs4all.nl ([213.84.216.119]:51718 "EHLO
	morannon.frodo.local") by vger.kernel.org with ESMTP
	id <S262570AbSJBSpY>; Wed, 2 Oct 2002 14:45:24 -0400
From: frodol@dds.nl
Message-Id: <200210021850.g92IolI11367@shire.frodo.local>
Subject: [PATCH] FAT spurious directory entries
To: chaffee@cs.berkeley.edu
Date: Wed, 2 Oct 2002 20:50:47 +0200 (CEST)
Cc: linux-7110-psion@lists.sourceforge.net, linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="%--multipart-mixed-boundary-1.11295.1033584647--%"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--%--multipart-mixed-boundary-1.11295.1033584647--%
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hi folks,

my Psion 5MX uses a (V)FAT filesystem on its CompactFlash card. Mounting
and reading it under Linux poses no problem, except that sometimes there
are spurious directory entries.

A Microsoft document specifying FAT:
http://www.nondot.org/sabre/os/files/FileSystems/FatFormat.pdf says:

    If DIR_Name[0]==0x00, then the directory entry is free (same as for
    0xE5) and there are no allocated directory entries after this one (all
    of the DIR_Name[0] bytes in all of the entries after this one are also
    set to 0).

    The special 0 value, rather than the 0xE5 value, indicates to FAT
    file system driver code that the rest of the entries in this
    directory do not need to be examined because they are all free.

It seems that this is not completely true in the Psion world: when it
marks an entry having DIR_Name[0] as 0x00, it does not erase anything 
which comes after it. So in this case you must stop scanning after finding
such a 0x00 entry, or you will have old and/or random entries (in one case,
the sector seems to have been used before for a data file, which gives
quite extraordinairy file names listed!).

According to the above specification (and presuming that it is valid),
it should be safe to stop reading after a 0x00 entry anyway. The below
patch implements that, and also fixes the case in which a new directory
entry is added after or on top of such a marker.

I can imagine that this patch is seen as too dangerous, in which case I hope
that a new mount flag would be acceptable. A new patch could be made quite
easily for this.

The PsiLinux FAQ:
http://linux-7110.sourceforge.net/cgi-bin/index.cgi?url=faqs/backup_msdosfs.htm
claims:
    The technical reason for the misbehaving msdos filesystem is that any
    directory created by EPOC or to which EPOC has added a cluster is
    affected by this behavior. EPOC (like ancient DOS) ignores any
    directory entries following a directory entry starting with a byte
    of zeros. Linux and Windows don't and therefore see extra "files".
If this is true, really ancient floppies would exhibit the same problem.

The patch is against 2.4.19, but should apply against 2.5 kernels without
any real trouble.

Thanks,
  Frodo

-- 
Frodo Looijaard <frodol@dds.nl>  PGP key and more: http://huizen.dds.nl/~frodol
Defenestration n. (formal or joc.):
  The act of removing Windows from your computer in disgust, usually followed
  by the installation of Linux or some other Unix-like operating system.

--%--multipart-mixed-boundary-1.11295.1033584647--%
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Description: C program text
Content-Disposition: attachment; filename="linux-2.4.19-FAT-entries.patch"

--- /usr/src/linux-2.4.19-1/fs/fat/dir.c	Fri Oct 12 22:48:42 2001
+++ linux-2.4.19-1/fs/fat/dir.c	Wed Oct  2 19:47:38 2002
@@ -201,4 +201,5 @@
 	int ino, chl, i, j, last_u, res = 0;
 	loff_t cpos = 0;
+	int last_entry=0;
 
 	while(1) {
@@ -207,4 +208,8 @@
 parse_record:
 		long_slots = 0;
+		if (de->name[0] == 0)
+			last_entry=1;
+		if (last_entry)
+			continue;
 		if (de->name[0] == (__s8) DELETED_FLAG)
 			continue;
@@ -268,4 +273,8 @@
 			if (de->name[0] == (__s8) DELETED_FLAG)
 				continue;
+			if (de->name[0] == 0) 
+				last_entry=1;
+			if (last_entry)
+				continue;
 			if (de->attr ==  ATTR_EXT)
 				goto parse_long;
@@ -370,4 +379,5 @@
 	unsigned short opt_shortname = MSDOS_SB(sb)->options.shortname;
 	int ino, inum, chi, chl, i, i2, j, last, last_u, dotoffset = 0;
+	int last_entry=0;
 	loff_t cpos;
 
@@ -396,4 +406,8 @@
 		goto EODir;
 	/* Check for long filename entry */
+	if (de->name[0] == 0) 
+		last_entry = 1;
+	if (last_entry)
+		goto RecEnd;
 	if (isvfat) {
 		if (de->name[0] == (__s8) DELETED_FLAG)
@@ -464,4 +478,8 @@
 		if (de->name[0] == (__s8) DELETED_FLAG)
 			goto RecEnd;
+		if (de->name[0] == 0)
+			last_entry = 1;
+		if (last_entry)
+			goto RecEnd;
 		if (de->attr ==  ATTR_EXT)
 			goto ParseLong;
@@ -708,4 +726,6 @@
 			break;
 		}
+		if (de->name[0] == 0) 
+			break;
 	}
 	if (bh)
@@ -722,5 +742,5 @@
 	struct super_block *sb = dir->i_sb;
 	loff_t offset, curr;
-	int row;
+	int row,last_entry = 0;
 	struct buffer_head *new_bh;
 
@@ -729,7 +749,16 @@
 	row = 0;
 	while (fat_get_entry(dir,&curr,bh,de,ino) > -1) {
-		if (IS_FREE((*de)->name)) {
-			if (++row == slots)
+		if ((*de)->name[0] == 0)
+			last_entry = 1;
+		if (last_entry || IS_FREE((*de)->name)) {
+			if (++row == slots) {
+				if (last_entry) { 
+					if (fat_get_entry(dir,&curr,bh,de,ino) > -1) {
+						(*de)->name[0] = 0;
+						mark_inode_dirty(dir);
+					}
+				}
 				return offset;
+			}
 		} else {
 			row = 0;

--%--multipart-mixed-boundary-1.11295.1033584647--%--
