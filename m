Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278653AbRKNXwR>; Wed, 14 Nov 2001 18:52:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278665AbRKNXwI>; Wed, 14 Nov 2001 18:52:08 -0500
Received: from h24-64-71-161.cg.shawcable.net ([24.64.71.161]:28398 "EHLO
	lynx.adilger.int") by vger.kernel.org with ESMTP id <S278653AbRKNXwA>;
	Wed, 14 Nov 2001 18:52:00 -0500
Date: Wed, 14 Nov 2001 16:51:47 -0700
From: Andreas Dilger <adilger@turbolabs.com>
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: generic_file_llseek() broken?
Message-ID: <20011114165147.S5739@lynx.no>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
I was recently testing a bit with creating very large files on ext2/ext3
(just to see if limits were what they should be).  Now, I know that ext2/3
allows files just shy of 2TB right now, because of an issue with i_blocks
being in units of 512-byte sectors, instead of fs blocks.

I tried to create a (sparse!) file of 2TB size with:

dd if=/dev/zero of=/tmp/tt bs=1k count=1 seek=2047M

and it worked fine (finished immediately, don't try this with reiserfs...).

When I tried to make it just a bit bigger, with:

dd if=/dev/zero of=/tmp/tt bs=1k count=1 seek=2048M

dd fails the "llseek(fd, 2T, SEEK_SET)" with -EINVAL, and then proceeds
to loop "infinitely" reading from the file to try and manually advance
the file descriptor offset to the desired offset.  That is bad.

I _think_ there is a bug in generic_file_llseek(), with it returning -EINVAL
instead of -EFBIG in the case where the offset is larger than the s_maxbytes.
AFAICS, the return -EINVAL is for the case where "whence" is invalid, not the
case where "offset" is too large for the underlying filesystem (I can see
-EINVAL for seeking to a negative position).

If I use:

dd if=/dev/zero of=/tmp/tt bs=1k count=1025 seek=2097151k

I correctly get "EFBIG (file too large)" and "SIGXFSZ" from write(2).

Does anyone know the correct LFS interpretation on this?  From what I can
see (I have not read the whole thing) lseek() should return EOVERFLOW if
the resulting offset is too large to fit in the passed type.  It doesn't
really say what should happen in this particular case - can someone try
on a non-Linux system and see what the result is?

Either way, I think the kernel is broken in this regard.

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

