Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261512AbSJMMpW>; Sun, 13 Oct 2002 08:45:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261519AbSJMMpW>; Sun, 13 Oct 2002 08:45:22 -0400
Received: from [62.40.204.109] ([62.40.204.109]:63665 "EHLO
	banshee.dnsalias.org") by vger.kernel.org with ESMTP
	id <S261512AbSJMMpU> convert rfc822-to-8bit; Sun, 13 Oct 2002 08:45:20 -0400
Date: Sun, 13 Oct 2002 14:50:56 +0200 (CEST)
From: Walter Haidinger <walter.haidinger@gmx.at>
X-X-Sender: walter@banshee.dnsalias.org
To: "H. Peter Anvin" <hpa@zytor.com>
cc: linux-kernel@vger.kernel.org
Subject: isofs: cruft option with volume_seq_no? (patch included)
Message-ID: <Pine.LNX.4.44.0210131403580.25059-100000@banshee.dnsalias.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I'm mailing this to you because you're the only reference regarding
iso9660 in the "lk maintainers" post to the lkml.

If you create an iso image with mkisofs and use the -volset-seqno option,
any subsequent mount attempt will result in the following message:

kernel: Warning: defective CD-ROM (volume sequence number 2). Enabling
"cruft" mount option.

When digging through the lkml archives, I found a post regarding this
topic (appended below) dating back to 2002-02-14. There is even an older
post from Dec 2001 too.

Q: Why isn't this bug(?) fixed yet?

Regards, Walter

---- earlier post follows -----

[http://marc.theaimsgroup.com/?l=linux-kernel&m=101372394230489&w=2]

List:     linux-kernel
Subject:  [patch] Kernel uncorrectly forces cruft option when some options
          of mkisofs are used
From:     "Guillermo S. Romero / Familia Romero" <famrom@infernal-iceberg.com>
Date:     2002-02-14 21:55:03

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
                       "Enabling \"cruft\" mount option.\n",
volume_seq_no);
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
--- linux-2.4.17.orig/Documentation/filesystems/isofs.txt       Wed May 26
19:01:43 1999
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



