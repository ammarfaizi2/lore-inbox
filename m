Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291930AbSBNVz3>; Thu, 14 Feb 2002 16:55:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291934AbSBNVzT>; Thu, 14 Feb 2002 16:55:19 -0500
Received: from 48-MAD2-X65.libre.retevision.es ([62.83.170.48]:22400 "EHLO
	blitzkrieg.battleship") by vger.kernel.org with ESMTP
	id <S291930AbSBNVzK>; Thu, 14 Feb 2002 16:55:10 -0500
Date: Thu, 14 Feb 2002 22:55:03 +0100
From: "Guillermo S. Romero / Familia Romero" <famrom@infernal-iceberg.com>
To: linux-kernel@vger.kernel.org
Subject: [patch] Kernel uncorrectly forces cruft option when some options of mkisofs are used
Message-ID: <20020214225503.A1538@blitzkrieg.battleship>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[Please CC the replies, I am not subscribed to lkml, thanks.]

Hi:

I have been using some options in mkisofs to group CD images (-volset
"string" -volset-size N -volset-seqno n). I read the man page and
thought they where a good idea to store the relation among CDs. I also
read the following docs (to check other docs, just in case):
http://www.y-adagio.com/public/standards/iso_cdromr/tocont.htm
ftp://ftp.ecma.ch/ecma-st/Ecma-119.pdf

Now the fun, when I mount a CD with seqno above 1 (this one had number
3 recorded... it is the third of a group of 3, I had to store over
1.5GB in one row), I get in the logs something like:

kernel: Warning: defective CD-ROM (volume sequence number 3). Enabling
"cruft" mount option.

I am currently using RH71, mkisofs is 1.13 (i686-pc-linux-gnu) and
kernel is 2.4.2-2. I scanned the Linux src I have and found in
fs/isofs/inode.c around line 1251:

        /*
         * Disable checking if we see any volume number other than 0 or 1.
         * We could use the cruft option, but that has multiple purposes, one
         * of which is limiting the file size to 16Mb.  Thus we silently allow
         * volume numbers of 0 to go through without complaining.
         */
        if (inode->i_sb->u.isofs_sb.s_cruft == 'n' &&
            (volume_seq_no != 0) && (volume_seq_no != 1)) {
                printk(KERN_WARNING "Warning: defective CD-ROM "
                       "(volume sequence number %d). "
                       "Enabling \"cruft\" mount option.\n", volume_seq_no);
                inode->i_sb->u.isofs_sb.s_cruft = 'y';

In 2.4.17 the line is 1286, but the situation is the same, if sequence
number not 0 or 1, cruft. Some other things are fixed, like ISO images
of 2GB (my 2.4.2 allows 1GB, and some older version I found while
investigating, a magic 800MB) so I believe that the file is a nest of
unsupported (by docs or good reasoning) decissions, being seqno
another example that has to be fixed, like the 2GB one was.

cruft option is described in include/linux/iso_fs_sb.h as "Broken
disks with high byte of length containing junk", not a magical
solution for everything. And that description is wrong as the comment
in 2.4.17 demostrates, size is a 32 bit number thus size can be 2GB
like other 32 bit based systems. The PDF in pages 3 and 8 describes
volume sets (it is not multisession, it is just about tags in the
header so machines "get eyes and can read the feltmarker").

Proposed solutions:

- remove the test in inode.c, it is wrong by spec. cdrecord package
coder Jörg Schilling thinks the same when I asked. See thread in
http://www.mail-archive.com/cdwrite@other.debian.org/msg02725.html

- add http://www.y-adagio.com/public/standards/iso_cdromr/tocont.htm
and specially ftp://ftp.ecma.ch/ecma-st/Ecma-119.pdf to the
documentation file.

- review all the isofs files with the spec on the side and make sure
they are right. The IGNORE_WRONG_MULTI_VOLUME_SPECS define looks wrong
to me and makes me think, multi volume is hint info for applications,
not a hard requirement, and has nothing to do with multisession or
similar things. It is like volume ID (used by Windows and Mac for the
icon, they could also use something like "volsetid - seqno/setsize"),
the files are fine whatever these header fields have. So I guess
someone read the wrong specs (the comment above the define does not
match, it says something about no support for multi volume... again
madness).

Patch against a clean 2.4.17 for document and inode.c follow. I made
it with "diff -uraN linux-2.4.17.orig linux". Third thing... well, I
am trying to understand the rest of the file, I am completly new to
this, if I manage to get something that works I will post it.

Documentation:
---8<---
--- linux-2.4.17.orig/Documentation/filesystems/isofs.txt       Wed May 26 19:01:43 1999
+++ linux/Documentation/filesystems/isofs.txt   Mon Feb 11 19:37:36 2002
@@ -29,3 +29,7 @@
   unhide        Show hidden files.
   session=x     Select number of session on multisession CD
   sbsector=xxx  Session begins from sector xxx
+
+Recommended documents about ISO 9660 standard are located at:
+http://www.y-adagio.com/public/standards/iso_cdromr/tocont.htm
+ftp://ftp.ecma.ch/ecma-st/Ecma-119.pdf
--->8---

inode.c
---8<---
--- linux-2.4.17.orig/fs/isofs/inode.c  Thu Oct 25 22:53:53 2001
+++ linux/fs/isofs/inode.c      Mon Feb 11 19:46:23 2002
@@ -1283,20 +1283,6 @@
        /* get the volume sequence number */
        volume_seq_no = isonum_723 (de->volume_sequence_number) ;
 
-       /*
-        * Disable checking if we see any volume number other than 0 or 1.
-        * We could use the cruft option, but that has multiple purposes, one
-        * of which is limiting the file size to 16Mb.  Thus we silently allow
-        * volume numbers of 0 to go through without complaining.
-        */
-       if (inode->i_sb->u.isofs_sb.s_cruft == 'n' &&
-           (volume_seq_no != 0) && (volume_seq_no != 1)) {
-               printk(KERN_WARNING "Warning: defective CD-ROM "
-                      "(volume sequence number %d). "
-                      "Enabling \"cruft\" mount option.\n", volume_seq_no);
-               inode->i_sb->u.isofs_sb.s_cruft = 'y';
-       }
-
        /* Install the inode operations vector */
 #ifndef IGNORE_WRONG_MULTI_VOLUME_SPECS
        if (inode->i_sb->u.isofs_sb.s_cruft != 'y' &&
--->8---

GSR
 
PS: Remember to CC me, thanks.
 
