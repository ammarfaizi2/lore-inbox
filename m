Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284664AbRLDAVL>; Mon, 3 Dec 2001 19:21:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284658AbRLDAOr>; Mon, 3 Dec 2001 19:14:47 -0500
Received: from smtp1.vol.cz ([195.250.128.73]:9223 "EHLO smtp1.vol.cz")
	by vger.kernel.org with ESMTP id <S284545AbRLCNGW>;
	Mon, 3 Dec 2001 08:06:22 -0500
Date: Mon, 3 Dec 2001 10:02:50 +0100
From: Stanislav Brabec <utx@penguin.cz>
To: linux-kernel@vger.kernel.org
Subject: isofs: truncated files on volume 2 of CD set
Message-ID: <20011203100250.A1043@utx.vol.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.23i
X-Accept-Language: cs, sk, en
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hallo,

I have created backup CD set. In respect to mkisofs manual, I have
numbered these volumes using -volset-seqno. I have been badly
surprised, that files with size >16MB on volume 2 were truncated.

I have looked at isofs source code and found reason:

For volume 2 and higher "cruft" option is auto activated.  Does anybody
know the reason for this behavior?  I am adding a patch.  I didn't
looked at ISO9660 specification to see upper limit of volume sequence
number, I don't also know, whether CD set is numbered from 0 or 1, so
please fix me, if I am wrong.

Included fix tests oddity of this number by its negativity.

There are two other possible tests:

Stronger test for highest byte non-zero (does anybody have more than
16777216 CD's in set?)
-	    (volume_seq_no != 0) && (volume_seq_no != 1)) {
+	    (volume_seq_no & 0xff000000)) {

Third posible test is checking, whether volume sequence number is <=
than volume set size (yet not included).

Please let me know, which test you consider as appropriate and I will
change the patch.

-volset-size #
       Sets the volume set size to #.  The volume set size
       is the number of CD's that are in a  CD  set.   The
       -volset-size option may be used to create CD's that
       are part of e.g. a  Operation  System  installation
       set of CD's.  The option -volset-size must be spec-
       ified before -volset-seqno on each command line.

-volset-seqno #
       Sets the volume set sequence number to #.  The vol-
       ume  set sequence number is the index number of the
       current CD in a CD set.   The  option  -volset-size
       must be specified before -volset-seqno on each com-
       mand line.


--- linux/fs/isofs/inode.c.orig	Thu Oct 25 23:53:53 2001
+++ linux/fs/isofs/inode.c	Sun Dec  2 16:38:59 2001
@@ -1284,13 +1284,13 @@
 	volume_seq_no = isonum_723 (de->volume_sequence_number) ;
 
 	/*
-	 * Disable checking if we see any volume number other than 0 or 1.
+	 * Disable checking if we see strange volume number.
 	 * We could use the cruft option, but that has multiple purposes, one
 	 * of which is limiting the file size to 16Mb.  Thus we silently allow
 	 * volume numbers of 0 to go through without complaining.
 	 */
 	if (inode->i_sb->u.isofs_sb.s_cruft == 'n' &&
-	    (volume_seq_no != 0) && (volume_seq_no != 1)) {
+	    (volume_seq_no < 0) && (volume_seq_no > 0x7FFFFFFE)) {
 		printk(KERN_WARNING "Warning: defective CD-ROM "
 		       "(volume sequence number %d). "
 		       "Enabling \"cruft\" mount option.\n", volume_seq_no);

-- 
Stanislav Brabec
