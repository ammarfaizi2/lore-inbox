Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285417AbSALIFb>; Sat, 12 Jan 2002 03:05:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285424AbSALIFW>; Sat, 12 Jan 2002 03:05:22 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:29196 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S285417AbSALIFI>; Sat, 12 Jan 2002 03:05:08 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: initramfs buffer spec -- second draft
Date: 12 Jan 2002 00:04:38 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <a1oqmm$is3$1@cesium.transmeta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2002 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an update to the initramfs buffer format spec I posted
earlier.  The changes are as follows:

a) Move the PAD() declarations around.  It is now required that the
   cpio header is aligned on a multiple of 4 bytes, thereby removing a
   potential ambiguity in the previous specification.

b) Clearly specify that the data can be attached to any member of a
   hard link set.

As always, comments appreciated...

		       initramfs buffer format
		       -----------------------

		       Al Viro, H. Peter Anvin
		      Last revision: 2002-01-11

       ** DRAFT ** DRAFT ** DRAFT ** DRAFT ** DRAFT ** DRAFT **

Starting with kernel 2.5.x, the old "initial ramdisk" protocol is
getting {replaced/complemented} with the new "initial ramfs"
(initramfs) protocol.  The initramfs contents is passed using the same
memory buffer protocol used by the initrd protocol, but the contents
is different.  The initramfs buffer contains an archive which is
expanded into a ramfs filesystem; this document details the format of
the initramfs buffer format.

The initramfs buffer format is based around the "newc" CPIO format,
and can be created with the cpio(1) utility.  The cpio archive can be
compressed using gzip(1).  The simplest form of the initramfs buffer
is thus a single .cpio.gz file.

The full format of the initramfs buffer is defined by the following
grammar, where:
	*	is used to indicate "0 or more occurrences of"
	(|)	indicates alternatives
	+	indicates concatenation
	GZIP()	indicates the gzip(1) of the operand
	PAD(n)	means padding with null bytes to an n-byte boundary
	[QUESTION: is the padding relative to the start of the
	previous header, or is it an absolute address?  Is it at all
	legal to have a header start on a non-multiple of 4?]

	initramfs  := ("\0" | cpio_archive | cpio_gzip_archive)*

	cpio_gzip_archive := GZIP(cpio_archive)

	cpio_archive := cpio_file* + (<nothing> | cpio_trailer)

	cpio_file := PAD(4) + cpio_header + filename + "\0" + PAD(4) + data

	cpio_trailer := PAD(4) + cpio_header + "TRAILER!!!\0" + PAD(4)


In human terms, the initramfs buffer contains a collection of
compressed and/or uncompressed cpio archives (in the "newc" format);
arbitrary amounts zero bytes (for padding) can be added between
members.

The cpio "TRAILER!!!" entry (cpio end of file) is optional, but is not
ignored; see "handling of hard links" below.

The structure of the cpio_header is as follows (all 8-byte entries
contain 32-bit hexadecimal ASCII numbers):

Field name    Field size	 Meaning
c_magic	      6 bytes		 The string "070701" or "070702"
c_ino	      8 bytes		 File inode number
c_mode	      8 bytes		 File mode and permissions
c_uid	      8 bytes		 File uid
c_gid	      8 bytes		 File gid
c_nlink	      8 bytes		 Number of links
c_mtime	      8 bytes		 Modification time
c_filesize    8 bytes		 Size of data field
c_maj	      8 bytes		 Major part of file device number
c_min	      8 bytes		 Minor part of file device number
c_rmaj	      8 bytes		 Major part of device node reference
c_rmin	      8 bytes		 Minor part of device node reference
c_namesize    8 bytes		 Length of filename, including final \0
c_chksum      8 bytes		 CRC of data field if c_magic is 070702

The c_mode field matches the contents of st_mode returned by stat(2)
on Linux, and encodes the file type and file permissions.

The c_filesize should be zero for any non-regular file.

If the filename is "TRAILER!!!" this is actually an end-of-file
marker; the c_filesize for an end-of-file marker must be zero.


*** Handling of hard links

When a nondirectory with c_nlink > 1 is seen, the (c_maj,c_min,c_ino)
tuple is looked up in a tuple buffer.  If not found, it is entered in
the tuple buffer and the entry is created as usual; if found, a hard
link rather than a second copy of the file is created.  It is not
necessary (but permitted) to include a second copy of the file
contents; if the file contents is not included, the c_filesize field
should be set to zero to indicate no data section follows.  If data is
present, the previous instance of the file is overwritten; this allows
the data-carrying instance of a file to occur anywhere in the sequence
(GNU cpio is reported to attach the data to the last instance of a
file only.)

When a "TRAILER!!!" end-of-file marker is seen, the tuple buffer is
reset.  This permits archives which are generated independently to be
concatenated.

To combine file data from different sources (without having to
regenerate the (c_maj,c_min,c_ino) fields), therefore, either one of
the following techniques can be used:

a) Separate the different file data sources with a "TRAILER!!!"
   end-of-file marker, or

b) Make sure c_nlink == 1 for all nondirectory entries.

-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
