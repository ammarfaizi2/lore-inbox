Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280059AbRKOBsv>; Wed, 14 Nov 2001 20:48:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279963AbRKOBsm>; Wed, 14 Nov 2001 20:48:42 -0500
Received: from [213.97.199.90] ([213.97.199.90]:4736 "HELO fargo")
	by vger.kernel.org with SMTP id <S279995AbRKOBs0> convert rfc822-to-8bit;
	Wed, 14 Nov 2001 20:48:26 -0500
From: "David Gomez" <davidge@jazzfree.com>
Date: Thu, 15 Nov 2001 02:47:49 +0100 (CET)
X-X-Sender: <huma@fargo>
To: Andreas Dilger <adilger@turbolabs.com>
cc: <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
Subject: Re: generic_file_llseek() broken?
In-Reply-To: <20011114165147.S5739@lynx.no>
Message-ID: <Pine.LNX.4.33.0111150235330.782-100000@fargo>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


After your message i tried to play a bit with dd. Bad idea.

I did 'dd if=/dev/zero of=test bs=1024k seek=2G' in a 10Gb ide disk, and
guess what ?

$ ls -l test
-rw-r--r--    1 huma     huma     2251799813685248 Nov 15 02:39 test
$ ls -lh test
-rw-r--r--    1 huma     huma         2.0P Nov 15 02:39 test

Yep, it says i have a 2 Petabyte file in a 10gb drive. Something is
_really_ broken here.
Deleting this file gave me some errors like this:

Nov 15 01:50:07 fargo kernel: EXT2-fs error (device ide3(34,1)):
ext2_free_blocks: Freeing blocks not in datazone - block = 161087505,
count = 1
Nov 15 01:50:07 fargo kernel: EXT2-fs error (device ide3(34,1)):
ext2_free_blocks: Freeing blocks not in datazone - block = 161153041,
count = 1

After that, i unmounted the partition and did an fsck, lots of errors and
several files corrupted that fsck ask me to delete because some inodes had
illegal blocks.

By the way, is a ext2 partition. Versions are: kernel 2.4.14, fileutils
4.1 and glibc 2.2.3.



> Hello,
> I was recently testing a bit with creating very large files on ext2/ext3
> (just to see if limits were what they should be).  Now, I know that ext2/3
> allows files just shy of 2TB right now, because of an issue with i_blocks
> being in units of 512-byte sectors, instead of fs blocks.
>
> I tried to create a (sparse!) file of 2TB size with:
>
> dd if=/dev/zero of=/tmp/tt bs=1k count=1 seek=2047M
>
> and it worked fine (finished immediately, don't try this with reiserfs...).
>
> When I tried to make it just a bit bigger, with:
>
> dd if=/dev/zero of=/tmp/tt bs=1k count=1 seek=2048M
>
> dd fails the "llseek(fd, 2T, SEEK_SET)" with -EINVAL, and then proceeds
> to loop "infinitely" reading from the file to try and manually advance
> the file descriptor offset to the desired offset.  That is bad.
>
> I _think_ there is a bug in generic_file_llseek(), with it returning -EINVAL
> instead of -EFBIG in the case where the offset is larger than the s_maxbytes.
> AFAICS, the return -EINVAL is for the case where "whence" is invalid, not the
> case where "offset" is too large for the underlying filesystem (I can see
> -EINVAL for seeking to a negative position).
>
> If I use:
>
> dd if=/dev/zero of=/tmp/tt bs=1k count=1025 seek=2097151k
>
> I correctly get "EFBIG (file too large)" and "SIGXFSZ" from write(2).
>
> Does anyone know the correct LFS interpretation on this?  From what I can
> see (I have not read the whole thing) lseek() should return EOVERFLOW if
> the resulting offset is too large to fit in the passed type.  It doesn't
> really say what should happen in this particular case - can someone try
> on a non-Linux system and see what the result is?
>
> Either way, I think the kernel is broken in this regard.
>
> Cheers, Andreas
> --
> Andreas Dilger
> http://sourceforge.net/projects/ext2resize/
> http://www-mddsp.enel.ucalgary.ca/People/adilger/
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>



David Gómez

"The question of whether computers can think is just like the question of
 whether submarines can swim." -- Edsger W. Dijkstra



