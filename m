Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263031AbTHVFNG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Aug 2003 01:13:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263033AbTHVFNG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Aug 2003 01:13:06 -0400
Received: from dsl092-013-071.sfo1.dsl.speakeasy.net ([66.92.13.71]:37555 "EHLO
	pelerin.serpentine.com") by vger.kernel.org with ESMTP
	id S263031AbTHVFMx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Aug 2003 01:12:53 -0400
Subject: [PATCH] Documentation for initramfs and early userspace
From: "Bryan O'Sullivan" <bos@serpentine.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1061529172.1983.14.camel@camp4.serpentine.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 21 Aug 2003 22:12:52 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, please pull from

  http://klibc.bkbits.net/early_userspace

This adds some documentation of the initramfs file format and a brief
overview of early userspace.

 00-INDEX                          |    2
 early-userspace/README            |   75 +++++++++++++++++++++++++
 early-userspace/buffer-format.txt |  112 ++++++++++++++++++++++++++++++++++++++ 3 files changed, 189 insertions(+)

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1135  -> 1.1136 
#	Documentation/00-INDEX	1.9     -> 1.10   
#	               (new)	        -> 1.1     Documentation/early-userspace/README
#	               (new)	        -> 1.1     Documentation/early-userspace/buffer-format.txt
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/08/21	bos@camp4.serpentine.com	1.1136
# Documentation for initramfs, klibc, and early userspace.
# --------------------------------------------
#
diff -Nru a/Documentation/00-INDEX b/Documentation/00-INDEX
--- a/Documentation/00-INDEX	Thu Aug 21 22:03:20 2003
+++ b/Documentation/00-INDEX	Thu Aug 21 22:03:20 2003
@@ -70,6 +70,8 @@
 	- info about directory notification in Linux.
 driver-model.txt
 	- info about Linux driver model.
+early-userspace/
+	- info about initramfs, klibc, and userspace early during boot.
 exception.txt
 	- how Linux v2.2 handles exceptions without verify_area etc.
 fb/
diff -Nru a/Documentation/early-userspace/README b/Documentation/early-userspace/README
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/Documentation/early-userspace/README	Thu Aug 21 22:03:20 2003
@@ -0,0 +1,75 @@
+Early userspace support
+=======================
+
+Last update: 2003-08-21
+
+
+"Early userspace" is a set of libraries and programs that provide
+various pieces of functionality that are important enough to be
+available while a Linux kernel is coming up, but that don't need to be
+run inside the kernel itself.
+
+It consists of several major infrastructure components:
+
+- gen_init_cpio, a program that builds a cpio-format archive
+  containing a root filesystem image.  This archive is compressed, and
+  the compressed image is linked into the kernel image.
+- initramfs, a chunk of code that unpacks the compressed cpio image
+  midway through the kernel boot process.
+- klibc, a userspace C library, currently packaged separately, that is
+  optimised for correctness and small size.
+
+The cpio file format used by initramfs is the "newc" (aka "cpio -c")
+format, and is documented in the file "buffer-format.txt".  If you
+want to generate your own cpio files directly instead of hacking on
+gen_init_cpio, you will need to short-circuit the build process in
+usr/ so that gen_init_cpio does not get run, then simply pop your own
+initramfs_data.cpio.gz file into place.
+
+
+Where's this all leading?
+=========================
+
+The klibc distribution contains some of the necessary software to make
+early userspace useful.  The klibc distribution is currently
+maintained separately from the kernel, but this may change early in
+the 2.7 era (it missed the boat for 2.5).
+
+You can obtain somewhat infrequent snapshots of klibc from
+ftp://ftp.kernel.org/pub/linux/libs/klibc/
+
+For active users, you are better off using the klibc BitKeeper
+repositories, at http://klibc.bkbits.net/
+
+The standalone klibc distribution currently provides three components,
+in addition to the klibc library:
+
+- ipconfig, a program that configures network interfaces.  It can
+  configure them statically, or use DHCP to obtain information
+  dynamically (aka "IP autoconfiguration").
+- nfsmount, a program that can mount an NFS filesystem.
+- kinit, the "glue" that uses ipconfig and nfsmount to replace the old
+  support for IP autoconfig, mount a filesystem over NFS, and continue
+  system boot using that filesystem as root.
+
+kinit is built as a single statically linked binary to save space.
+
+Eventually, several more chunks of kernel functionality will hopefully
+move to early userspace:
+
+- Almost all of init/do_mounts* (the beginning of this is already in
+  place)
+- ACPI table parsing
+- Insert unwieldy subsystem that doesn't really need to be in kernel
+  space here
+
+If kinit doesn't meet your current needs and you've got bytes to burn,
+the klibc distribution includes a small Bourne-compatible shell (ash)
+and a number of other utilities, so you can replace kinit and build
+custom initramfs images that meet your needs exactly.
+
+For questions and help, you can sign up for the early userspace
+mailing list at http://www.zytor.com/mailman/listinfo/klibc
+
+
+Bryan O'Sullivan <bos@serpentine.com>
diff -Nru a/Documentation/early-userspace/buffer-format.txt b/Documentation/early-userspace/buffer-format.txt
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/Documentation/early-userspace/buffer-format.txt	Thu Aug 21 22:03:20 2003
@@ -0,0 +1,112 @@
+		       initramfs buffer format
+		       -----------------------
+
+		       Al Viro, H. Peter Anvin
+		      Last revision: 2002-01-13
+
+Starting with kernel 2.5.x, the old "initial ramdisk" protocol is
+getting {replaced/complemented} with the new "initial ramfs"
+(initramfs) protocol.  The initramfs contents is passed using the same
+memory buffer protocol used by the initrd protocol, but the contents
+is different.  The initramfs buffer contains an archive which is
+expanded into a ramfs filesystem; this document details the format of
+the initramfs buffer format.
+
+The initramfs buffer format is based around the "newc" or "crc" CPIO
+formats, and can be created with the cpio(1) utility.  The cpio
+archive can be compressed using gzip(1).  One valid version of an
+initramfs buffer is thus a single .cpio.gz file.
+
+The full format of the initramfs buffer is defined by the following
+grammar, where:
+	*	is used to indicate "0 or more occurrences of"
+	(|)	indicates alternatives
+	+	indicates concatenation
+	GZIP()	indicates the gzip(1) of the operand
+	ALGN(n)	means padding with null bytes to an n-byte boundary
+
+	initramfs  := ("\0" | cpio_archive | cpio_gzip_archive)*
+
+	cpio_gzip_archive := GZIP(cpio_archive)
+
+	cpio_archive := cpio_file* + (<nothing> | cpio_trailer)
+
+	cpio_file := ALGN(4) + cpio_header + filename + "\0" + ALGN(4) + data
+
+	cpio_trailer := ALGN(4) + cpio_header + "TRAILER!!!\0" + ALGN(4)
+
+
+In human terms, the initramfs buffer contains a collection of
+compressed and/or uncompressed cpio archives (in the "newc" or "crc"
+formats); arbitrary amounts zero bytes (for padding) can be added
+between members.
+
+The cpio "TRAILER!!!" entry (cpio end-of-archive) is optional, but is
+not ignored; see "handling of hard links" below.
+
+The structure of the cpio_header is as follows (all fields contain
+hexadecimal ASCII numbers fully padded with '0' on the left to the
+full width of the field, for example, the integer 4780 is represented
+by the ASCII string "000012ac"):
+
+Field name    Field size	 Meaning
+c_magic	      6 bytes		 The string "070701" or "070702"
+c_ino	      8 bytes		 File inode number
+c_mode	      8 bytes		 File mode and permissions
+c_uid	      8 bytes		 File uid
+c_gid	      8 bytes		 File gid
+c_nlink	      8 bytes		 Number of links
+c_mtime	      8 bytes		 Modification time
+c_filesize    8 bytes		 Size of data field
+c_maj	      8 bytes		 Major part of file device number
+c_min	      8 bytes		 Minor part of file device number
+c_rmaj	      8 bytes		 Major part of device node reference
+c_rmin	      8 bytes		 Minor part of device node reference
+c_namesize    8 bytes		 Length of filename, including final \0
+c_chksum      8 bytes		 Checksum of data field if c_magic is 070702;
+				 otherwise zero
+
+The c_mode field matches the contents of st_mode returned by stat(2)
+on Linux, and encodes the file type and file permissions.
+
+The c_filesize should be zero for any file which is not a regular file
+or symlink.
+
+The c_chksum field contains a simple 32-bit unsigned sum of all the
+bytes in the data field.  cpio(1) refers to this as "crc", which is
+clearly incorrect (a cyclic redundancy check is a different and
+significantly stronger integrity check), however, this is the
+algorithm used.
+
+If the filename is "TRAILER!!!" this is actually an end-of-archive
+marker; the c_filesize for an end-of-archive marker must be zero.
+
+
+*** Handling of hard links
+
+When a nondirectory with c_nlink > 1 is seen, the (c_maj,c_min,c_ino)
+tuple is looked up in a tuple buffer.  If not found, it is entered in
+the tuple buffer and the entry is created as usual; if found, a hard
+link rather than a second copy of the file is created.  It is not
+necessary (but permitted) to include a second copy of the file
+contents; if the file contents is not included, the c_filesize field
+should be set to zero to indicate no data section follows.  If data is
+present, the previous instance of the file is overwritten; this allows
+the data-carrying instance of a file to occur anywhere in the sequence
+(GNU cpio is reported to attach the data to the last instance of a
+file only.)
+
+c_filesize must not be zero for a symlink.
+
+When a "TRAILER!!!" end-of-archive marker is seen, the tuple buffer is
+reset.  This permits archives which are generated independently to be
+concatenated.
+
+To combine file data from different sources (without having to
+regenerate the (c_maj,c_min,c_ino) fields), therefore, either one of
+the following techniques can be used:
+
+a) Separate the different file data sources with a "TRAILER!!!"
+   end-of-archive marker, or
+
+b) Make sure c_nlink == 1 for all nondirectory entries.


