Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273213AbRI3JKL>; Sun, 30 Sep 2001 05:10:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273204AbRI3JKB>; Sun, 30 Sep 2001 05:10:01 -0400
Received: from ix.meyering.net ([212.234.50.122]:28043 "EHLO
	pixie.eng.ascend.com") by vger.kernel.org with ESMTP
	id <S273230AbRI3JJv>; Sun, 30 Sep 2001 05:09:51 -0400
To: Nilmoni Deb <ndeb@ece.cmu.edu>, viro@math.psu.edu
Cc: bug-fileutils@gnu.org, Remy.Card@linux.org, linux-kernel@vger.kernel.org
Subject: fs/ext2/namei.c: dir link/unlink bug? [Re: mv changes dir timestamp
In-Reply-To: <Pine.LNX.3.96L.1010929125713.27868A-100000@d-alg.ece.cmu.edu>
In-Reply-To: <Pine.LNX.3.96L.1010929125713.27868A-100000@d-alg.ece.cmu.edu>
 (Nilmoni Deb's message of "Sat, 29 Sep 2001 13:09:30 -0400 (EDT)")
From: Jim Meyering <jim@meyering.net>
Date: Sun, 30 Sep 2001 11:10:16 +0200
Message-ID: <87bsjt59jb.fsf@pixie.eng.ascend.com>
User-Agent: Gnus/5.090004 (Oort Gnus v0.04) Emacs/21.0.106
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nilmoni Deb <ndeb@ece.cmu.edu> wrote:
> When I move a directory its time stamp gets changed.
> I am using mv version 4.1 (with mandrake-8.1).

Thanks a lot for reporting that!
This appears to be a bug not in GNU mv, nor even in GNU libc, but
rather in the underlying implementation in the kernel ext2 file system
support.  The offending change seems to have come in with a rewrite
of fs/ext2/namei.c that happened sometime between 2.4.4 and 2.4.9.

That file begins with this new comment:

 * Rewrite to pagecache. Almost all code had been changed, so blame me
 * if the things go wrong. Please, send bug reports to viro@math.psu.edu

This demonstrates that the problem affects ext2, but not tmpfs
using a 2.4.10 kernel (notice that the timestamp doesn't change
in /t, but does in the ext2 /tmp):

  $ df -T /tmp /t
  Filesystem    Type    Size  Used Avail Use% Mounted on
  /dev/sda1     ext2    942M   52M  842M   6% /tmp
  tmpfs        tmpfs    250M  4.0k  250M   1% /t

  $ cd /t && bash /tmp/ext2-link-bug
  drwxr-xr-x    2        0 2001-09-30 10:49:38.000000000 +0200 a
  drwxr-xr-x    2        0 2001-09-30 10:49:38.000000000 +0200 b
  $ cd /tmp && bash /tmp/ext2-link-bug
  drwxr-xr-x    2     4096 2001-09-30 10:49:43.000000000 +0200 a
  drwxr-xr-x    2     4096 2001-09-30 10:49:45.000000000 +0200 b

  $ cat /tmp/ext2-link-bug
  #!/bin/sh
  t=rb-$$
  mkdir $t
  cd $t
  mkdir a
  ls -gold --full-time a
  sleep 2
  mv a b
  ls -gold --full-time b
  cd ..
  rm -rf $t

Jim

--------------------------------
Linux pixie 2.4.10 #1 SMP Fri Sep 28 11:50:55 CEST 2001 i686 unknown

Gnu C                  2.95.4
Gnu make               3.79.1
binutils               2.11.90.0.31
util-linux             2.11h
mount                  2.11h
modutils               2.4.8
e2fsprogs              1.25
Linux C Library        2.2.4
Dynamic linker (ldd)   2.2.4
Procps                 2.0.7
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               2.0.11
Modules Loaded         ppp_deflate ppp_async ppp_generic slhc parport_pc lp parport 3c59x
