Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131104AbQLNOvK>; Thu, 14 Dec 2000 09:51:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131150AbQLNOvB>; Thu, 14 Dec 2000 09:51:01 -0500
Received: from clever.visp-europe.psi.com ([212.222.105.4]:45544 "EHLO
	clever.visp-europe.psi.com") by vger.kernel.org with ESMTP
	id <S131104AbQLNOuk>; Thu, 14 Dec 2000 09:50:40 -0500
Message-ID: <01C065E1.44ACDBC0.nicog@snafu.de>
From: Nicolas GOUTTE <nicog@snafu.de>
To: "Linus TORVALDS (E-Mail)" <torvalds@transmeta.com>
Cc: "Gordon CHAFFEE (E-Mail)" <chaffee@cs.berkeley.edu>,
        "'LKML'" <linux-kernel@vger.kernel.org>
Subject: [PATCH] VFAT creates files with short names wrongly
Date: Thu, 14 Dec 2000 15:18:52 +0100
X-Mailer: Microsoft Internet E-Mail/MAPI - 8.0.0.4211
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Linus, please apply!

This patch fixes a bug in the VFAT code.
When creating files with short file names, the VFAT driver decides that a file name
starting with a lower case character is always a short (MSDOS style) name, despite any
other character of the file name that would need to be coded in a long (VFAT style) name.
This patch ensure that all characters are tested properly to be sure that it is really a short name.
(For a more details on the patch see below!)

The patch still apllies correctly on Linux 2.4.0-test12 final.
(test13-pre1 should not be a problem but I have not tested!)

I have still not received any critics about the patch.

To LKML readers: please CC me! Thank you in advance!

*Previous message:*
Date: Mon, 4 Dec 2000 15:05:00 +0100
Subject: [BUG] [PATCH] VFAT creates wrongly files with short names

Dear Linus, please apply!

I have sent a similar message to the maintainer Gordon Chaffee
<chaffee@cs.berkeley.edu> more than a week ago but I have not got any
reaction, even after I have sent another message.

As this patch is only a simple bug fix, I have chosen to send it directly to
you.

The patch still works with Linux 2.4.0-test12-pre4.



*Original message (corrected):*

Dear Maintainer,

I have found a bug in the VFAT code and I send you also a patch against it.
I hope you will find it worth to be applied.

*OS*
Linux 2.4.0-test11 (final, unpatched)

*Bug*
When VFAT creates files with short names (maximal 14 characters including the
dot), VFAT considers wrongly that the file name is a valid short name (in the
MSDOS sence). There are exceptions from this behaviour, but for most of these
file names it happen so.

*How To Trigger*
The bug can easily be triggered by touch(1) on any VFAT file system:
         touch bzImage.bz2
And with ls(1), you will be surprised to find:
         bzimage.bz2
The upper/lower case information is lost!

Note: Also other file names than "bzImage.bz2" can trigger this behaviour but
it is with this filename that I have found the bug.

One counter-example is any file name starting with an upper case character:
         touch TeSt
And ls(1) will give you as expected:
         TeSt

*Technical Description*
The bug is triggered by one bug in the function "vfat_valid_shortname" in the
file "fs/vfat/namei.c".

The problem is that in the first loop of this function the pointer "walk" is
never incremented, so only the first chacater is tested.
Therefore we do not test the other characters (at least the seven ones 
following the first) and if the dot is not the ninth character, it is not
recognised and so the second part of the function is not processed the way it
should.

While chasing this bug, I have seen another problem in the same function and
the patch fixes it also.

In the part treating the extension, the code tests if the result of the
function "vfat_uni2short" is negative. However by how the function
"vfat_uni2short" is implemented, it can never be negative, as this function
replaces negative values by zero! Therefore a character not mappable in the
current NLS is skipped, instead of triggering a return with -EINVAL .

*Comment On The Patch*
As the two changes made by the patch are similar, I have chosen to code them
in the same way to show the similarity of the code in both places. 

Therefore in the first part, I have put the assignement out of the "if"
statement, as it is coded so in most places of this file.

In the second part, I have chosen not to use the function "vfat_uni2short",
as in the worst case it would mean to test if a value is negative, change it
to zero and then testing if it is zero.

*Further Possible Enhancements*
The definition of the function "vfat_uni2short" (lines 197 to 206) can be
deleted, as it is not used anywhere else. This deletition is not included in
the following patch.

*Patch*

--- fs/vfat/namei.c.orig	Wed Nov  1 10:57:55 2000
+++ fs/vfat/namei.c	Tue Nov 21 15:35:25 2000
@@ -442,10 +442,9 @@
 	space = 1; /* disallow names starting with a dot */
 	for (walk = name; len && walk-name < 8;) {
 		len--;
-		if ( (chl = nls->uni2char(*walk, charbuf, NLS_MAX_CHARSET_SIZE)) < 0) {
-			walk++;
+		chl = nls->uni2char(*walk++, charbuf, NLS_MAX_CHARSET_SIZE);
+		if (chl < 0)
 			return -EINVAL;
-		}
 
 		for (chi = 0; chi < chl; chi++) {
 			c = vfat_getupper(nls, charbuf[chi]);
@@ -471,7 +470,7 @@
 		if (len >= 4) return -EINVAL;
 		while (len > 0) {
 			len--;
-			chl = vfat_uni2short(nls, *walk++, charbuf, NLS_MAX_CHARSET_SIZE);
+			chl = nls->uni2char(*walk++, charbuf, NLS_MAX_CHARSET_SIZE);
 			if (chl < 0)
 				return -EINVAL;
 			for (chi = 0; chi < chl; chi++) {

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
