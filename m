Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270565AbRHITjH>; Thu, 9 Aug 2001 15:39:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270566AbRHITi6>; Thu, 9 Aug 2001 15:38:58 -0400
Received: from orion.it.luc.edu ([147.126.59.65]:40366 "EHLO orion.it.luc.edu")
	by vger.kernel.org with ESMTP id <S270565AbRHITil>;
	Thu, 9 Aug 2001 15:38:41 -0400
Date: Thu, 9 Aug 2001 14:38:52 -0500 (CDT)
From: "B. Galliart" <bgallia@orion.it.luc.edu>
Reply-To: <bgallia@luc.edu>
To: <linux-kernel@vger.kernel.org>
Subject: raw device library to provide block alignment
Message-ID: <Pine.A41.4.31.0108091157240.59224-100000@orion.it.luc.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  I have been using the Linux v2.2 and the non-standard rawfs module[1]
with great success for a while for running INN[2].  I would like to be
able to upgrade to Linux v2.4 and raw devices.  However, I have run into
the following limitation as stated in the raw man page:

       All I/Os must be correctly aligned in memory and on  disk:
       they  must  start at a sector offset on disk, they must be
       an exact number of sectors long, and the  data  buffer  in
       virtual  memory  must also be aligned to a multiple of the
       sector size.  The  sector  size  is  512  bytes  for  most
       devices.

  Is anyone working on an user space library to making porting programs to
Linux raw devices easier?  RAWfs did not require data alignment and INN's
current CNFS implimentation does not attempt to do data alignment.  I
wondered if there is something that would allow for a quick and dirty
port.

  Take for example the following code:

  fd = open("/dev/raw/raw1", O_RDWR);
  lseek(fd, 700, SEEK_SET);
  read(fd, buf1, 1200);
  write(fd, buf2, 1500);
  close(fd);

  I would like to be able to replace open, seek, read, write and close
with calls to rawopen, rawseek, rawread, rawwrite and rawclose where the
arguments are left the same and the drop in replacements handle data align
such that the resulting system calls would become something along the
lines of:

  lseek(fd, 512, SEEK_SET);
    // additional 188 byte offset kept in a variable
  read(fd, alternatebuf, 1536);
    // discard first 188 bytes, discard last 148 bytes and copy into buf1
  lseek(fd, 1536, SEEK_SET);
  read(fd, rewritebuffer, 512);
    // copy 148 bytes of buf2 into the end of rewritebuffer
  lseek(fd, 1536, SEEK_SET);
  write(fd, rewritebuffer, 512);
    // skip 148 bytes and copy 1024 bytes of buf2 into alternatebuf
  write(fd, alternatebuf, 1024);
  read(fd, rewritebuffer, 512);
    // copy last 328 bytes of buf2 into beginning of rewritebuffer
  lseek(fd, 3072, SEEK_SET);
  write(fd, rewritebuffer, 512);

  Is anyone working on such a library as I described above?  Or is there
an easier method?

Thanks

In-Reply-To:
[1] ftp://ftp.cistron.nl/pub/people/miquels/kernel/
[2] http://www.isc.org/products/INN/

