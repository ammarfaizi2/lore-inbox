Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313477AbSF3Vs4>; Sun, 30 Jun 2002 17:48:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313687AbSF3Vs4>; Sun, 30 Jun 2002 17:48:56 -0400
Received: from 16.Red-80-32-164.pooles.rima-tde.net ([80.32.164.16]:14464 "EHLO
	blitzkrieg.battleship") by vger.kernel.org with ESMTP
	id <S313477AbSF3Vsz>; Sun, 30 Jun 2002 17:48:55 -0400
Date: Sun, 30 Jun 2002 23:51:10 +0200
From: "Guillermo S. Romero" <gsromero@alumnos.euitt.upm.es>
To: marcelo@conectiva.com.br
Cc: linux-kernel@vger.kernel.org
Subject: Patch for ISO 9660 in 2.4.18 [~janitor]
Message-ID: <20020630235109.A18275@blitzkrieg.battleship>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi:

I discovered that the Linux ISO 9660 implementation had still some
problems with the bad multi volume specification afair (lots of
IGNORE_WRONG_MULTI_VOLUME_SPECS in the code). It has been bitting me
for some time, cos I use what the spec calls volume set to group CDs,
so programs can determine the relation by just looking at the header
of the CDs (in the spec a CD is a volume, see 4.17, they do not use
volume as in hard disk drives, nor they make any strong tie about
volume sets, other than the header and that data must form a group,
like 1 of X to X of X floppies).

The patch adds the links to the documentation I have used, ECMA 119
2nd edition (which is described as what later was named ISO 9660) and
what looks like a copy of the ISO doc in HTML. I think there should be
no problem at all with this part.

The code part is easy too, I just put the test that is wrong inside a
IGNORE_WRONG_MULTI_VOLUME_SPECS, like the rest of tests that check for
similar things. I have been using this solution since February, and it
works, cos the ID data in the header is just that, info in case a
program or person wants to look at it instead of at the imprint in the
top side of the CD (pretty useful for robots, they can read CDs but
not view them). A similar patch was in RedHat by my request, but I
think it is time to make the patch for everyone.

I think this file needs a cleanup, it gave me headaches when trying to
understand what was going, making me doubt if I was reading the
specification wrong or the file was wrong. The best cleanup I can
think is removing all the IGNORE_WRONG_MULTI_VOLUME_SPECS and put the
comments up to date with the code (sometimes they contradict code or
just do things without clear base), specially following the ECMA
documentation avaliable, but I think there must be first this simple
patch, then if people is interested, a total review of the file.

The patch:

---8<---
diff -ur linux-2.4.18-orig/Documentation/filesystems/isofs.txt linux/Documentation/filesystems/isofs.txt
--- linux-2.4.18-orig/Documentation/filesystems/isofs.txt	Wed May 26 19:01:43 1999
+++ linux/Documentation/filesystems/isofs.txt	Sun Jun 30 22:15:10 2002
@@ -29,3 +29,10 @@
   unhide        Show hidden files.
   session=x     Select number of session on multisession CD
   sbsector=xxx  Session begins from sector xxx
+
+Recommended documents about ISO 9660 standard are located at:
+http://www.y-adagio.com/public/standards/iso_cdromr/tocont.htm
+ftp://ftp.ecma.ch/ecma-st/Ecma-119.pdf
+Quoting from the PDF "This 2nd Edition of Standard ECMA-119 is technically 
+identical with ISO 9660.", so it is a valid and gratis substitute of the
+official ISO specification.
diff -ur linux-2.4.18-orig/fs/isofs/inode.c linux/fs/isofs/inode.c
--- linux-2.4.18-orig/fs/isofs/inode.c	Mon Feb 25 20:38:08 2002
+++ linux/fs/isofs/inode.c	Sun Jun 30 22:25:33 2002
@@ -1283,6 +1283,15 @@
 	/* get the volume sequence number */
 	volume_seq_no = isonum_723 (de->volume_sequence_number) ;
 
+    /*
+     * Multi volume means tagging a group of CDs with info in their headers.
+     * All CDs of a group must share the same vol set name and vol set size
+     * and have different vol set seq num. Deciding that data is wrong based
+     * in that three fields is wrong. The fields are informative, for
+     * cataloging purposes in a big jukebox, ie. Read sections 4.17, 4.18, 6.6
+     * of ftp://ftp.ecma.ch/ecma-st/Ecma-119.pdf (ECMA 119 2nd Ed = ISO 9660)
+     */
+#ifndef IGNORE_WRONG_MULTI_VOLUME_SPECS
 	/*
 	 * Disable checking if we see any volume number other than 0 or 1.
 	 * We could use the cruft option, but that has multiple purposes, one
@@ -1296,6 +1305,7 @@
 		       "Enabling \"cruft\" mount option.\n", volume_seq_no);
 		inode->i_sb->u.isofs_sb.s_cruft = 'y';
 	}
+#endif /*IGNORE_WRONG_MULTI_VOLUME_SPECS */
 
 	/* Install the inode operations vector */
 #ifndef IGNORE_WRONG_MULTI_VOLUME_SPECS
--->8---

I hope you like it. Interested in the clean up? Any comments?
Questions? The bug is not listed in kernel janitor tasks, but they
helped me about what to do with the patch.

[Note: I am not subscribed to lkml, so remember to send a copy
directly to me too]

GSR
 
