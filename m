Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262087AbUK3OXh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262087AbUK3OXh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 09:23:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262090AbUK3OXh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 09:23:37 -0500
Received: from 84-72-27-39.dclient.hispeed.ch ([84.72.27.39]:11784 "EHLO
	dastardly.newsbastards.org.72.27.172.IN-addr.ARPA.NOSPAM.dyndns.dk")
	by vger.kernel.org with ESMTP id S262087AbUK3OX0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 09:23:26 -0500
Date: Tue, 30 Nov 2004 15:23:21 +0100 (CET)
Message-Id: <200411301423.iAUENK601275@Mail.NOSPAM.DynDNS.dK>
Subject: UFS1 filesystem compatibility problem under Linux
To: Linux Kernel mailing list <linux-kernel@vger.kernel.org>
From: Barry Bouwsma <linuxbugs@remove-NOSPAM-to-reply.NOSPAM.dyndns.dk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[NOTE:  This address is IPv6-only, but can be made IPv4-aware by
 dropping ONLY the hostname part -- though you are welcome to drop
 me from any replies so that I catch up from some list archive.
 I'm not a subscriber to this list; merely posing a question.]


Moin, moin!

A few days ago, I had the need to mount one of my (Free/Net)BSD UFS1
filesystems under Linux, but this failed.  I was too tired at the
time to see why it failed, but I've since downloaded recent kernel
source in order to read through the UFS code and see if I can
identify the problem.

(I should note that I'm a *BSD user, and have not finished the
installation of Linux that I started, so I haven't actually built
a hacked kernel to see whether what I write below is relevant to
the problem, or that other problems are revealed.  My questions
are based only on *reading* the source code.  Sorry.)

Anyway, a search for this problem turned up old code in which the
filesystem blocksize was limited to a small selection of values,
otherwise an error would be thrown.  This code was missing from
the recent kernel source, but I did notice a hardcoded upper
bound on the allowable fragment size, which certainly did not
match the non-standard values I had selected when creating my
filesystem for the purpose of holding a handful of very large
(multi-gigabyte) data files.

The source code in question is in linux-2.6.10-rc2/fs/ufs/super.c
and is as follows:

     798         if (uspi->s_fsize > 4096) {
     799                 printk(KERN_ERR "ufs_read_super: fragment size %u is to
     799 o large\n",
     800                         uspi->s_fsize);
     801                 goto failed;
     802         }

I've had absolutely no problems under FreeBSD (apart from possibly
finding one or two bits of code that needed to be fixed) when I've
made regular use of fragment sizes up to and including the block
size (as large as 65536 bytes), so long as fsize is within the range
of bsize/8 to bsize.

Question:  Is there a reason that the Linux UFS code would be unable
to handle frag sizes larger than 4k, or is this simply an arbitrary
sanity check, similar to the old block size check that I unearthed
which restricted allowable values to one of three or so, that should
be corrected to be able to handle all allowable cases?

(The *BSD man pages do not recommend fragment sizes other than in a
ratio of 1/8 the block size, but I've experienced no problems, and
the desired effect -- pruning the number of inodes to speed fsck and
better match the disk contents -- has been achieved.)


Here follows a dump of the BSD UFS1 superblock of the filesystem I
had created, which gave difficulties.  This is made with the `dumpfs'
program under FreeBSD 4.x.  Following is the directory listing from
this filesystem, to lead to my next question about file sizes.


** disklabel:
#        size   offset    fstype   [fsize bsize bps/cpg]
  c: 488397106        0    unused        0     0        # (Cyl.    0 - 30401*)
  e: 488397106        0    4.2BSD    32768 65536  4664  # (Cyl.    0 - 30401*)

** dumpfs:
magic   11954   time    Sun Nov 28 08:56:33 2004
id      [ 419de1cd 66a4512a ]
cylgrp  dynamic inodes  4.4BSD
nbfree  2892221 ndir    1       nifree  13295   nffree  1
ncg     26      ncyl    119238  size    7631204 blocks  7631045
bsize   65536   shift   16      mask    0xffff0000
fsize   32768   shift   15      mask    0xffff8000
frag    2       shift   1       fsbtodb 6
cpg     4664    bpg     149248  fpg     298496  ipg     512
minfree 8%      optim   time    maxcontig 1     maxbpg  16384
rotdelay 0ms    rps     60
ntrak   1       nsect   4096    npsect  4096    spc     4096
symlinklen 60   trackskew 0     interleave 1    contigsumsize 0
nindir  16384   inopb   512     nspf    64      maxfilesize     288247969412284415
sblkno  2       cblkno  4       iblkno  6       dblkno  8
sbsize  8192    cgsize  65536   cgoffset 64     cgmask  0xffffffff
csaddr  8       cssize  32768   shift   12      mask    0xfffff000
cgrotor 10      fmod    0       ronly   0       clean   1
flags   none
(no rotational position table)
  [ snip ]

** df:
Filesystem   1K-blocks     Used    Avail Capacity iused   ifree  %iused
/dev/da2s1c  244193440 59091264 165566720    26%      15   13295     0%

** ls:
total 59091266
drwxr-xr-x  26 root  wheel        1536 Nov 15 16:48 ..
-rw-r--r--   1 beer  wheel  4666687532 Nov 20 04:15 FM4-Fri-19.11-1.wav
-rw-r--r--   1 beer  wheel  1036800044 Nov 20 05:45 flowmotion-Fri-19.11.wav
-rw-r--r--   1 root  wheel   351404076 Nov 20 17:26 test.wav
-rw-r--r--   1 beer  wheel  7833600044 Nov 21 05:28 pb-Sat-20.11.wav
-rw-r--r--   1 beer  wheel  9031680044 Nov 21 08:02 xxl-Sat-20.11.wav
-rw-r--r--   1 beer  wheel  3571200044 Nov 22 02:07 xxl-Sun-21.11.wav
-rw-r--r--   1 beer  wheel  6278400044 Nov 22 06:02 fm4-Sun-21.11.wav
-rw-r--r--   1 beer  wheel  4838400044 Nov 23 04:59 metissages-Mon-22.11.wav
-rw-r--r--   1 beer  wheel  3168000044 Nov 23 05:00 flowmotion-Mon-22.11.wav
-rw-r--r--   1 beer  wheel  5886720044 Nov 24 06:30 metissages-Tue-23.11.wav
-rw-r--r--   1 beer  wheel    74711084 Nov 26 21:08 club.wav
-rw-r--r--   1 beer  wheel  5932800044 Nov 27 06:02 FM4-Fri-26.11.wav
-rw-r--r--   1 beer  wheel          44 Nov 27 17:59 xxl-Sat-27.11.wav
drwxr-xr-x   2 beer  wheel         512 Nov 27 17:59 .
-rw-r--r--   1 beer  wheel  7833600044 Nov 28 05:19 pb-Sat-27.11.wav


So here's my second question:  The Linux kernel UFS code makes some
reference to a 2GB filesize limit, which, as the above directory
listing shows, is not a problem with BSD UFS.
        /* Keep 2Gig file limit. Some UFS variants need to override
           this but as I don't know which I'll let those in the know loosen
           the rules */
So can it be that even after fixing the fragment size check, that
I'll still have problems with Linux accessing the above larger
files?  The FAQ implies otherwise, maybe:
          + (REG) Maximum file size depends on the block size on your
            filesystem. For ext2 (and UFS, SysVFS and similar
            filesystems), the limits are:
Block size      Maximum file size (GiBytes)
512 B           2
1   kiB         16
2   kiB         128
4   kiB         1024
8   kiB         8192   (PAGE_SIZE must be >= 8 kiB)

Hmmm, this reference to PAGE_SIZE is interesting -- the reason
I'm asking all these stupid questions is to know whether some
out-of-the-box on-CD-or-similar Linux could be expected to be
able to handle my UFS1 filesystem as described above, with no
need for a custom or tweaked kernel.


The above `dumpfs' output is provided for anyone who is familiar
with the code and would be able to identify right away that certain
values might be out of the range that Linux expects to handle.  Like
appears to be the case with the fragment size.


thanks
barry bouwsma

