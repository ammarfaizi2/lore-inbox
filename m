Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129385AbQKVW1M>; Wed, 22 Nov 2000 17:27:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129434AbQKVW1B>; Wed, 22 Nov 2000 17:27:01 -0500
Received: from thalia.fm.intel.com ([132.233.247.11]:22546 "EHLO
        thalia.fm.intel.com") by vger.kernel.org with ESMTP
        id <S129150AbQKVW0p>; Wed, 22 Nov 2000 17:26:45 -0500
Message-ID: <9678C2B4D848D41187450090276D1FAE2999D6@FMSMSX32>
From: "Peel, Jeffery S" <jeffery.s.peel@intel.com>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: PROBLEM: Cruft mounting option incorrect in ISOFS code
Date: Wed, 22 Nov 2000 13:56:29 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
        charset="ISO-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

There is a pretty bad bug in the "/fs/isofs/inode.c" file under linux kernel
version 2.2.17.  Search the file for the word "dipshit" (not a joke) and
look at the cruft mounting code.  It assumes that the maximum size of a
dvd-rom file is 1 gigabyte.  This is certainly not a correct assumption when
talking about dvd-rom's with nothing but data on them as the maximum size of
an iso-9660 file is something like 2^32.  It is also incorrect if he is
referring to dvd movies as the maximum file size of any non title set file
is also only bounded by the iso-9660 file system limitations.  The dvd video
specification only limits title set files in the form of vts_0x_x.vob to
under 1 gig in size.  You can exhibit the problem by mounting the dvd movie
"The World is Not Enough" as it contains a video_ts.vob which is larger than
1 gigabyte.  You will see that most of the file lengths are incorrect due to
the "cruft mounting option" hacking off the high order byte.  There are
certainly many more movies out there that exhibit this problem so it would
be a good thing for someone to fix.

Here is the code in question.....

	/* There are defective discs out there - we do this to protect
	   ourselves.  A cdrom will never contain more than 800Mb 
	   .. but a DVD may be up to 1Gig (Ulrich Habel) */
	if((inode->i_size < 0 || inode->i_size > 1073741824) &&
	    inode->i_sb->u.isofs_sb.s_cruft == 'n') {
	  printk("Warning: defective cdrom.  Enabling \"cruft\" mount
option.\n");
	  inode->i_sb->u.isofs_sb.s_cruft = 'y';
	}

/* Some dipshit decided to store some other bit of information in the high
   byte of the file length.  Catch this and holler.  WARNING: this will make
   it impossible for a file to be > 16Mb on the CDROM!!!*/

	if(inode->i_sb->u.isofs_sb.s_cruft == 'y' &&
	   inode->i_size & 0xff000000){
/*	  printk("Illegal format on cdrom.  Pester manufacturer.\n"); */
	  inode->i_size &= 0x00ffffff;
	}

--> I am not subscribed to the mailing list so any reply will have to be
made to my e-mail address <--

Jeff Peel
<mailto:jeffery.s.peel@intel.com>
Senior Software Engineer
Intel IAL - Consumer Media Technology


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
