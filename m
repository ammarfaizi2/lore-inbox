Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132358AbRA2HSE>; Mon, 29 Jan 2001 02:18:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S145230AbRA2HRp>; Mon, 29 Jan 2001 02:17:45 -0500
Received: from h24-65-192-120.cg.shawcable.net ([24.65.192.120]:11515 "EHLO
	webber.adilger.net") by vger.kernel.org with ESMTP
	id <S132358AbRA2HRf>; Mon, 29 Jan 2001 02:17:35 -0500
From: Andreas Dilger <adilger@turbolinux.com>
Message-Id: <200101290717.f0T7HD126365@webber.adilger.net>
Subject: Re: Renaming lost+found
In-Reply-To: <9523bg$7dc$1@cesium.transmeta.com> from "H. Peter Anvin" at "Jan
 28, 2001 01:35:44 pm"
To: "H. Peter Anvin" <hpa@zytor.com>
Date: Mon, 29 Jan 2001 00:17:12 -0700 (MST)
CC: linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.4ME+ PL66 (25)]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

H. Peter Anvin writes:
> Hello people... the original question was: can lost+found be
> *renamed*, i.e. does the tools (e2fsck &c) use "/lost+found" by name,
> or by inode?  As far as I know it always uses the same inode number
> (11), but I don't know if that is anywhere enforced.

Bzzt.  /lost+found just happens to use inode 11 on 99.9% of filesystems
because it is the first inode available when mke2fs is creating the
filesystem.  If you check <linux/ext2_fs.h>, it has:

#define EXT2_GOOD_OLD_FIRST_INO 11

It is perfectly acceptable to delete lost+found, and create it again
with mklost+found, and chances are it will have a different inode...
Just tested it, and sure enough, I got inode 612 for lost+found this time.
I'm pretty sure that e2fsck looks for the name /lost+found, rather than
inode 11.

This means that with stock e2fsck, mke2fs, mklost+found, you can't rename
lost+found and expect anything to work.  However, I would imagine it isn't
_too_ hard to change these tools to create a different directory, and for
e2fsck to look for the standard or the new directory to put nameless inodes.

Looking at the e2fsck source, there only appears to be a single instance of
the string "lost+found", in e2fsck/pass3.c:get_lost_and_found():

	static const char name[] = "lost+found";

Same with misc/mke2fs.c:create_lost_and_found() and misc/mklost+found.

Cheers, Andreas

PS - don't blame me if you never find your files after a bad crash.  At
     least when it is called "lost+found" you occasionally have a look
     in there.
-- 
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
