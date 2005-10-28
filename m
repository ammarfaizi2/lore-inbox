Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030224AbVJ1Px0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030224AbVJ1Px0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Oct 2005 11:53:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030226AbVJ1Px0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Oct 2005 11:53:26 -0400
Received: from pne-smtpout1-sn1.fre.skanova.net ([81.228.11.98]:24573 "EHLO
	pne-smtpout1-sn1.fre.skanova.net") by vger.kernel.org with ESMTP
	id S1030222AbVJ1PxZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Oct 2005 11:53:25 -0400
Subject: [PATCH 1/2] VFS: update overview document
From: Pekka Enberg <penberg@cs.helsinki.fi>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain
Message-Id: <ip2uk2.6o93wd.e2lyonk8o6q05pejbwmnb41jo.beaver@cs.helsinki.fi>
Date: Fri, 28 Oct 2005 18:48:02 +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


(Andrew, sorry for the duplicate. The first batch was not sent to the
 list.)

This patch updates the Documentation/filesystems/vfs.txt document. I
rearranged and rewrote parts of the introduction chapter and added
better headings for each section. I also added a description for the
inode rename() operation which was missing and added links to some
useful external VFS documentation.

Signed-off-by: Pekka Enberg <penberg@cs.helsinki.fi>
---

 vfs.txt |  271 ++++++++++++++++++++++++++++++++++++----------------------------
 1 file changed, 153 insertions(+), 118 deletions(-)

Index: 2.6/Documentation/filesystems/vfs.txt
===================================================================
--- 2.6.orig/Documentation/filesystems/vfs.txt
+++ 2.6/Documentation/filesystems/vfs.txt
@@ -3,7 +3,7 @@
 
 	Original author: Richard Gooch <rgooch@atnf.csiro.au>
 
-		  Last updated on August 25, 2005
+		  Last updated on October 28, 2005
 
   Copyright (C) 1999 Richard Gooch
   Copyright (C) 2005 Pekka Enberg
@@ -11,62 +11,61 @@
   This file is released under the GPLv2.
 
 
-What is it?
-===========
+Introduction
+============
 
-The Virtual File System (otherwise known as the Virtual Filesystem
-Switch) is the software layer in the kernel that provides the
-filesystem interface to userspace programs. It also provides an
-abstraction within the kernel which allows different filesystem
-implementations to coexist.
-
-
-A Quick Look At How It Works
-============================
-
-In this section I'll briefly describe how things work, before
-launching into the details. I'll start with describing what happens
-when user programs open and manipulate files, and then look from the
-other view which is how a filesystem is supported and subsequently
-mounted.
-
-
-Opening a File
---------------
-
-The VFS implements the open(2), stat(2), chmod(2) and similar system
-calls. The pathname argument is used by the VFS to search through the
-directory entry cache (dentry cache or "dcache"). This provides a very
-fast look-up mechanism to translate a pathname (filename) into a
-specific dentry.
-
-An individual dentry usually has a pointer to an inode. Inodes are the
-things that live on disc drives, and can be regular files (you know:
-those things that you write data into), directories, FIFOs and other
-beasts. Dentries live in RAM and are never saved to disc: they exist
-only for performance. Inodes live on disc and are copied into memory
-when required. Later any changes are written back to disc. The inode
-that lives in RAM is a VFS inode, and it is this which the dentry
-points to. A single inode can be pointed to by multiple dentries
-(think about hardlinks).
-
-The dcache is meant to be a view into your entire filespace. Unlike
-Linus, most of us losers can't fit enough dentries into RAM to cover
-all of our filespace, so the dcache has bits missing. In order to
-resolve your pathname into a dentry, the VFS may have to resort to
-creating dentries along the way, and then loading the inode. This is
-done by looking up the inode.
-
-To look up an inode (usually read from disc) requires that the VFS
-calls the lookup() method of the parent directory inode. This method
-is installed by the specific filesystem implementation that the inode
-lives in. There will be more on this later.
-
-Once the VFS has the required dentry (and hence the inode), we can do
-all those boring things like open(2) the file, or stat(2) it to peek
-at the inode data. The stat(2) operation is fairly simple: once the
-VFS has the dentry, it peeks at the inode data and passes some of it
-back to userspace.
+The Virtual File System (also known as the Virtual Filesystem Switch)
+is the software layer in the kernel that provides the filesystem
+interface to userspace programs. It also provides an abstraction
+within the kernel which allows different filesystem implementations to
+coexist.
+
+VFS system calls open(2), stat(2), read(2), write(2), chmod(2) and so
+on are called from a process context. Filesystem locking is described
+in the document Documentation/filesystems/Locking.
+
+
+Directory Entry Cache (dcache)
+------------------------------
+
+The VFS implements the open(2), stat(2), chmod(2), and similar system
+calls. The pathname argument that is passed to them is used by the VFS
+to search through the directory entry cache (also known as the dentry
+cache or dcache). This provides a very fast look-up mechanism to
+translate a pathname (filename) into a specific dentry. Dentries live
+in RAM and are never saved to disc: they exist only for performance.
+
+The dentry cache is meant to be a view into your entire filespace. As
+most computers cannot fit all dentries in the RAM at the same time,
+some bits of the cache are missing. In order to resolve your pathname
+into a dentry, the VFS may have to resort to creating dentries along
+the way, and then loading the inode. This is done by looking up the
+inode.
+
+
+The Inode Object
+----------------
+
+An individual dentry usually has a pointer to an inode. Inodes are
+filesystem objects such as regular files, directories, FIFOs and other
+beasts.  They live either on the disc (for block device filesystems)
+or in the memory (for pseudo filesystems). Inodes that live on the
+disc are copied into the memory when required and changes to the inode
+are written back to disc. A single inode can be pointed to by multiple
+dentries (hard links, for example, do this).
+
+To look up an inode requires that the VFS calls the lookup() method of
+the parent directory inode. This method is installed by the specific
+filesystem implementation that the inode lives in. Once the VFS has
+the required dentry (and hence the inode), we can do all those boring
+things like open(2) the file, or stat(2) it to peek at the inode
+data. The stat(2) operation is fairly simple: once the VFS has the
+dentry, it peeks at the inode data and passes some of it back to
+userspace.
+
+
+The File Object
+---------------
 
 Opening a file requires another operation: allocation of a file
 structure (this is the kernel-side implementation of file
@@ -74,51 +73,39 @@ descriptors). The freshly allocated file
 a pointer to the dentry and a set of file operation member functions.
 These are taken from the inode data. The open() file method is then
 called so the specific filesystem implementation can do it's work. You
-can see that this is another switch performed by the VFS.
-
-The file structure is placed into the file descriptor table for the
-process.
+can see that this is another switch performed by the VFS. The file
+structure is placed into the file descriptor table for the process.
 
 Reading, writing and closing files (and other assorted VFS operations)
 is done by using the userspace file descriptor to grab the appropriate
-file structure, and then calling the required file structure method
-function to do whatever is required.
-
-For as long as the file is open, it keeps the dentry "open" (in use),
-which in turn means that the VFS inode is still in use.
-
-All VFS system calls (i.e. open(2), stat(2), read(2), write(2),
-chmod(2) and so on) are called from a process context. You should
-assume that these calls are made without any kernel locks being
-held. This means that the processes may be executing the same piece of
-filesystem or driver code at the same time, on different
-processors. You should ensure that access to shared resources is
-protected by appropriate locks.
+file structure, and then calling the required file structure method to
+do whatever is required. For as long as the file is open, it keeps the
+dentry in use, which in turn means that the VFS inode is still in use.
 
 
 Registering and Mounting a Filesystem
--------------------------------------
+=====================================
 
-If you want to support a new kind of filesystem in the kernel, all you
-need to do is call register_filesystem(). You pass a structure
-describing the filesystem implementation (struct file_system_type)
-which is then added to an internal table of supported filesystems. You
-can do:
+To register and unregister a filesystem, use the following API
+functions:
 
-% cat /proc/filesystems
+   #include <linux/fs.h>
 
-to see what filesystems are currently available on your system.
+   extern int register_filesystem(struct file_system_type *);
+   extern int unregister_filesystem(struct file_system_type *);
 
-When a request is made to mount a block device onto a directory in
-your filespace the VFS will call the appropriate method for the
-specific filesystem. The dentry for the mount point will then be
-updated to point to the root inode for the new filesystem.
+The passed struct file_system_type describes your filesystem. When a
+request is made to mount a device onto a directory in your filespace,
+the VFS will call the appropriate get_sb() method for the specific
+filesystem. The dentry for the mount point will then be updated to
+point to the root inode for the new filesystem.
 
-It's now time to look at things in more detail.
+You can see all filesystems that are registered to the kernel in the
+file /proc/filesystems.
 
 
 struct file_system_type
-=======================
+-----------------------
 
 This describes the filesystem. As of kernel 2.6.13, the following
 members are defined:
@@ -197,8 +184,14 @@ A fill_super() method implementation has
   int silent: whether or not to be silent on error
 
 
+The Superblock Object
+=====================
+
+A superblock object represents a mounted filesystem.
+
+
 struct super_operations
-=======================
+-----------------------
 
 This describes how the VFS can manipulate the superblock of your
 filesystem. As of kernel 2.6.13, the following members are defined:
@@ -286,9 +279,9 @@ or bottom half).
   	a superblock. The second parameter indicates whether the method
 	should wait until the write out has been completed. Optional.
 
-  write_super_lockfs: called when VFS is locking a filesystem and forcing
-  	it into a consistent state.  This function is currently used by the
-	Logical Volume Manager (LVM).
+  write_super_lockfs: called when VFS is locking a filesystem and
+  	forcing it into a consistent state.  This method is currently
+  	used by the Logical Volume Manager (LVM).
 
   unlockfs: called when VFS is unlocking a filesystem and making it writable
   	again.
@@ -317,8 +310,14 @@ field. This is a pointer to a "struct in
 describes the methods that can be performed on individual inodes.
 
 
+The Inode Object
+================
+
+An inode object represents an object within the filesystem.
+
+
 struct inode_operations
-=======================
+-----------------------
 
 This describes how the VFS can manipulate an inode in your
 filesystem. As of kernel 2.6.13, the following members are defined:
@@ -394,51 +393,62 @@ otherwise noted.
 	will probably need to call d_instantiate() just as you would
 	in the create() method
 
+  rename: called by the rename(2) system call to rename the object to
+	have the parent and name given by the second inode and dentry.
+
   readlink: called by the readlink(2) system call. Only required if
 	you want to support reading symbolic links
 
   follow_link: called by the VFS to follow a symbolic link to the
 	inode it points to.  Only required if you want to support
-	symbolic links.  This function returns a void pointer cookie
+	symbolic links.  This method returns a void pointer cookie
 	that is passed to put_link().
 
   put_link: called by the VFS to release resources allocated by
-  	follow_link().  The cookie returned by follow_link() is passed to
-	to this function as the last parameter.  It is used by filesystems
-	such as NFS where page cache is not stable (i.e. page that was
-	installed when the symbolic link walk started might not be in the
-	page cache at the end of the walk).
-
-  truncate: called by the VFS to change the size of a file.  The i_size
- 	field of the inode is set to the desired size by the VFS before
-	this function is called.  This function is called by the truncate(2)
-	system call and related functionality.
+  	follow_link().  The cookie returned by follow_link() is passed
+  	to to this method as the last parameter.  It is used by
+  	filesystems such as NFS where page cache is not stable
+  	(i.e. page that was installed when the symbolic link walk
+  	started might not be in the page cache at the end of the
+  	walk).
+
+  truncate: called by the VFS to change the size of a file.  The
+ 	i_size field of the inode is set to the desired size by the
+ 	VFS before this method is called.  This method is called by
+ 	the truncate(2) system call and related functionality.
 
   permission: called by the VFS to check for access rights on a POSIX-like
   	filesystem.
 
-  setattr: called by the VFS to set attributes for a file.  This function is
-  	called by chmod(2) and related system calls.
+  setattr: called by the VFS to set attributes for a file. This method
+  	is called by chmod(2) and related system calls.
 
-  getattr: called by the VFS to get attributes of a file.  This function is
-  	called by stat(2) and related system calls.
+  getattr: called by the VFS to get attributes of a file. This method
+  	is called by stat(2) and related system calls.
 
   setxattr: called by the VFS to set an extended attribute for a file.
-  	Extended attribute is a name:value pair associated with an inode. This
-	function is called by setxattr(2) system call.
+  	Extended attribute is a name:value pair associated with an
+  	inode. This method is called by setxattr(2) system call.
+
+  getxattr: called by the VFS to retrieve the value of an extended
+  	attribute name. This method is called by getxattr(2) function
+  	call.
+
+  listxattr: called by the VFS to list all extended attributes for a
+  	given file. This method is called by listxattr(2) system call.
+
+  removexattr: called by the VFS to remove an extended attribute from
+  	a file. This method is called by removexattr(2) system call.
 
-  getxattr: called by the VFS to retrieve the value of an extended attribute
-  	name.  This function is called by getxattr(2) function call.
 
-  listxattr: called by the VFS to list all extended attributes for a given
-  	file.  This function is called by listxattr(2) system call.
+The Address Space Object
+========================
 
-  removexattr: called by the VFS to remove an extended attribute from a file.
-  	This function is called by removexattr(2) system call.
+The address space object is used to identify pages in the page cache.
 
 
 struct address_space_operations
-===============================
+-------------------------------
 
 This describes how the VFS can manipulate mapping of a file to page cache in
 your filesystem. As of kernel 2.6.13, the following members are defined:
@@ -502,8 +512,14 @@ struct address_space_operations {
 	it.  An example implementation can be found in fs/ext2/xip.c.
 
 
+The File Object
+===============
+
+A file object represents a file opened by a process.
+
+
 struct file_operations
-======================
+----------------------
 
 This describes how the VFS can manipulate an open file. As of kernel
 2.6.13, the following members are defined:
@@ -661,7 +677,7 @@ of child dentries. Child dentries are ba
 directory.
 
 
-Directory Entry Cache APIs
+Directory Entry Cache API
 --------------------------
 
 There are a number of functions defined which permit a filesystem to
@@ -880,3 +896,22 @@ Papers and other documentation on dcache
 1. Scaling dcache with RCU (http://linuxjournal.com/article.php?sid=7124).
 
 2. http://lse.sourceforge.net/locking/dcache/dcache.html
+
+
+Resources
+=========
+
+(Note some of these resources are not up-to-date with the latest kernel
+ version.)
+
+Creating Linux virtual filesystems. 2002
+    <http://lwn.net/Articles/13325/>
+
+The Linux Virtual File-system Layer by Neil Brown. 1999
+    <http://www.cse.unsw.edu.au/~neilb/oss/linux-commentary/vfs.html>
+
+A tour of the Linux VFS by Michael K. Johnson. 1996
+    <http://www.tldp.org/LDP/khg/HyperNews/get/fs/vfstour.html>
+
+A small trail through the Linux kernel by Andries Brouwer. 2001
+    <http://www.win.tue.nl/~aeb/linux/vfs/trail.html>
