Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312850AbSDKTPU>; Thu, 11 Apr 2002 15:15:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312852AbSDKTPT>; Thu, 11 Apr 2002 15:15:19 -0400
Received: from h24-67-14-151.cg.shawcable.net ([24.67.14.151]:47610 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S312850AbSDKTPS>; Thu, 11 Apr 2002 15:15:18 -0400
From: Andreas Dilger <adilger@clusterfs.com>
Date: Thu, 11 Apr 2002 13:12:55 -0600
To: Frank Krauss <fmfkrauss@mindspring.com>
Cc: linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linus Torvalds <torvalds@transmeta.com>,
        Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: [PATCH] Re: Possible EXT2 File System Corruption in Kernel 2.4
Message-ID: <20020411191255.GK3509@turbolinux.com>
Mail-Followup-To: Frank Krauss <fmfkrauss@mindspring.com>,
	linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Linus Torvalds <torvalds@transmeta.com>,
	Marcelo Tosatti <marcelo@conectiva.com.br>
In-Reply-To: <E16vKwg-00056q-00@barry.mail.mindspring.net> <02041112492500.01786@sevencardstud.cable.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Apr 11, 2002  12:40 -0400, Frank Krauss wrote:
> I have a problem in the area of EXT2 File System Corruption.
> 
> I attempted originally to send this information to Remy Card as per the
> MAINTAINERS file at RemyCard@linux.org but I got the message about
> him being an unknown user.

This is a patch (after I don't know how many years of him not working on
it) to remove Remy Card as ext2 maintainer.  Since I'm not
comfortable adding other people's names as maintainers (and I don't
think Linus/Marcello/Alan would accept that anyways), I've just put
the ext2-devel mailing list.  All of the ext2 developers are on it.

Patch against 2.4.18, but should be fine for 2.4.current, 2.5.current,
but the ext3 part doesn't exist in 2.2.

=============================================================================
--- linux/MAINTAINERS.orig	Fri Dec 21 10:41:53 2001
+++ linux/MAINTAINERS	Thu Apr 11 12:57:13 2002
@@ -544,14 +544,12 @@
 S:      Maintained
 
 EXT2 FILE SYSTEM
-P:	Remy Card
-M:	Remy.Card@linux.org
-L:	linux-kernel@vger.kernel.org
+L:	ext2-devel@lists.sourceforge.net
 S:	Maintained
 
 EXT3 FILE SYSTEM
-P:	Remy Card, Stephen Tweedie
-M:	sct@redhat.com, akpm@zip.com.au, adilger@turbolinux.com
+P:	Stephen Tweedie, Andrew Morton
+M:	sct@redhat.com, akpm@zip.com.au, adilger@clusterfs.com
 L:	ext3-users@redhat.com
 S:	Maintained
 
=============================================================================

> > I got the following 10 Error Messages:
> > 
> > Apr  9 17:12:51 kernel: EXT2-fs error (device ide1(22,3)):
> >   ext2_new_block: Allocating block in system zone - block = 835885 
> > Apr  9 17:12:51 kernel: EXT2-fs error (device ide1(22,3)):
> >   ext2_new_block: Allocating block in system zone - block = 835886 
> > Apr  9 17:12:51 kernel: EXT2-fs error (device ide1(22,3)):
> >   ext2_new_block: Allocating block in system zone - block = 835894 

This is unfortunately only a symptom of a problem and not the original
cause.  There should have previously been errors saying "error - freeing
blocks in system zone".  There is a patch I posted a few months ago to
fix this symptom, but not the actual cause.

Rather than going ahead and allocating these blocks (which is surely a
bad thing, as it will further corrupt the filesystem) the patch marks
the blocks in-use, and continues looking for other blocks to allocate.
Similarly, on the "free" case, it does not mark the blocks as freed in
the bitmap, although it does deallocate it from the inode.  At worst
this will mean that you might have some unusable blocks if the
filesystem is using some feature that the kernel does not understand,
and e2fsck will clean it up for you because it is marked in error.

Cheers, Andreas
--
Andreas Dilger
http://www-mddsp.enel.ucalgary.ca/People/adilger/
http://sourceforge.net/projects/ext2resize/

