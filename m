Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281063AbRKOVJt>; Thu, 15 Nov 2001 16:09:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281062AbRKOVJj>; Thu, 15 Nov 2001 16:09:39 -0500
Received: from h24-64-71-161.cg.shawcable.net ([24.64.71.161]:34032 "EHLO
	lynx.adilger.int") by vger.kernel.org with ESMTP id <S281059AbRKOVJ0>;
	Thu, 15 Nov 2001 16:09:26 -0500
Date: Thu, 15 Nov 2001 14:09:17 -0700
From: Andreas Dilger <adilger@turbolabs.com>
To: Helge Hafting <helgehaf@idb.hist.no>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        viro@math.psu.edu
Subject: Re: generic_file_llseek() broken?
Message-ID: <20011115140917.Q5739@lynx.no>
Mail-Followup-To: Helge Hafting <helgehaf@idb.hist.no>,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	viro@math.psu.edu
In-Reply-To: <20011114165147.S5739@lynx.no> <Pine.LNX.4.33.0111150235330.782-100000@fargo> <20011114222429.Y5739@lynx.no> <3BF38CFB.21998301@idb.hist.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <3BF38CFB.21998301@idb.hist.no>; from helgehaf@idb.hist.no on Thu, Nov 15, 2001 at 10:38:03AM +0100
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Nov 15, 2001  10:38 +0100, Helge Hafting wrote:
> > On Nov 15, 2001  02:47 +0100, David Gomez wrote:
> > > I did 'dd if=/dev/zero of=test bs=1024k seek=2G' in a 10Gb ide disk, and
> > > guess what ?
> > >
> > > $ ls -l test
> > > -rw-r--r--    1 huma     huma     2251799813685248 Nov 15 02:39 test
> > > $ ls -lh test
> > > -rw-r--r--    1 huma     huma         2.0P Nov 15 02:39 test
> > 
> > No, that in itself is fine - it is a sparse file, with a single 1MB block
> > at 2PB offset.  If you were to "du" this file, it would say 1MB of allocated
> > space.  The problem is that this _should_ be impossible to create on ext2,
> > because the write would be way past the allowed file size limit.
> >
> > > After that, i unmounted the partition and did an fsck, lots of errors and
> > > several files corrupted that fsck ask me to delete because some inodes had
> > > illegal blocks.
> > 
> > That is really bad, I don't know how it would happen.  Maybe there is
> > overflow internal to ext2, which causes it to write elsewhere in the fs?
> > When was the last time (previous to this problem) you fsck'd this fs?
> 
> If he's _allowed_ to create a sparse file with impossible offset - what
> happens to the file's index blocks?  I guess that's where something
> overflowed.

I think the problem is not coming from the llseek+write, but maybe from
ftruncate?  Strace doesn't show any writes for me (only failed llseek +
lots of reads), yet when trying to create files > 4TB I get "block > big"
and > 8TB I get "block < 0" messages, which come from ext2_block_to_path().

In a couple of places (iblock, offsets) we are using an int/long to
store the block counts, don't know why we want to use a signed value
here instead of an unsigned (long).  Looks like changing block numbers
to be unsigned longs goes into the guts of getblk and such.  Ugh.

Maybe also sys_truncate should disallow truncating to a size larger
than s_maxbytes.  Al? For now, returning EOVERFLOW from do_truncate()
when (length > inode->i_sb->s_maxbytes) should be OK.

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

