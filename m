Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315674AbSEIKGM>; Thu, 9 May 2002 06:06:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315676AbSEIKGL>; Thu, 9 May 2002 06:06:11 -0400
Received: from sj-msg-core-2.cisco.com ([171.69.24.11]:58501 "EHLO
	sj-msg-core-2.cisco.com") by vger.kernel.org with ESMTP
	id <S315674AbSEIKGJ>; Thu, 9 May 2002 06:06:09 -0400
Message-Id: <5.1.0.14.2.20020509193347.02ff6dc8@mira-sjcm-3.cisco.com>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Thu, 09 May 2002 20:05:05 +1000
To: Andrew Morton <akpm@zip.com.au>
From: Lincoln Dale <ltd@cisco.com>
Subject: Re: [PATCH] 2.5.14 IDE 56
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Martin Dalecki <dalecki@evision-ventures.com>,
        Linus Torvalds <torvalds@transmeta.com>,
        Padraig Brady <padraig@antefacto.com>,
        Anton Altaparmakov <aia21@cantab.net>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <3CD9E8A7.D524671D@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 08:10 PM 8/05/2002 -0700, Andrew Morton wrote:
> > whether the bottleneck was copy-from-kernel-to-userspace (ie. exhaustion of
> > Front-Side-Bus / memory bandwidth) or related to block-layer overhead and
> > scsi layer overheads, i haven't yet validated, but at a ~35% performance
> > difference is relatively significant nontheless.
>
>You need to be careful with this stuff.  Cache effects dominate.
...

i've validated that the performance difference is due to copy_to_user().
i created a hack in the tree where a read() on a file opened with the 
option O_NOCOPY causes no copy_to_user() to occur. (diff at the bottom of 
this email).

on this test machine (dual P3 Xeon / 256K L2 cache, 2G PC133 SDRAM, QLogic 
2300 FC HBA, 8 x 15K RPM disks).
maximum theoretical performance is 2gbit/s (~200mbyte/sec).  kernel is 2.4.18.

i get the following performance numbers with 256K reads syncronously from 
the disks:
         /dev/md0 raid-0 with O_DIRECT:          91847kbyte/sec (2781usec 
avg latency/read)
         /dev/md0 raid-0:                                129455kbyte/sec 
(1978usec avg latency/read)
         /dev/md0 raid-0 with O_NOCOPY:  195868kbyte/sec (1297usec avg 
latency/read)

         requests split evenly across /dev/sd[e-l] w/ O_DIRECT:
                                                 78279kbyte/sec (3276usec 
avg latency/read)
         requests split evenly across /dev/sd[e-l]:      105130kbyte/sec 
(2437usec avg latency/read)
         requests split evenly across /dev/sd[e-l] w/ O_NOCOPY:
                                                 123050kb/sec (2088usec avg 
latency/read)

there's some interesting numbers here.
  - given the performance difference between O_NOCOPY and pristine on
    /dev/md0 one can definitely point at that being the copy_to_user() 
overhead.
  - however, when requests are split across multiple block-devices 
(/dev/sd[e-l])
    the difference are significantly decreased -- and something wierdo is 
going on:
         - readahead?
         - scsi priorities?
    perhaps some form of async i/o is required to get the performance back.

i'll do some experiments with a 2.5.xx and see if the block-layer changes 
cause any significant changes.


         --- pristine/linux/include/asm-i386/fcntl.h     Tue Sep 18 
06:16:30 2001
         +++ linux/include/asm-i386/fcntl.h      Thu May  9 18:56:46 2002
         @@ -20,6 +20,7 @@
          #define O_LARGEFILE    0100000
          #define O_DIRECTORY    0200000 /* must be a directory */
          #define O_NOFOLLOW     0400000 /* don't follow links */
         +#define O_NOCOPY        04 /* LTD HACK: dont do copy_to_user */

          #define F_DUPFD                0       /* dup */
          #define F_GETFD                1       /* get close_on_exec */
         --- pristine/linux/mm/filemap.c Tue Feb 26 06:38:13 2002
         +++ linux/mm/filemap.c  Thu May  9 18:56:48 2002
         @@ -1544,6 +1544,19 @@
                 return retval;
          }

         +int file_read_nocopy_actor(read_descriptor_t * desc, struct page 
*page, unsigned long offset, unsigned long size)
         +{
         +       unsigned long count = desc->count;
         +
         +       if (size > count)
         +               size = count;
         +
         +       desc->count = count - size;
         +       desc->written += size;
         +       desc->buf += size;
         +       return size;
         +}
         +
          int file_read_actor(read_descriptor_t * desc, struct page *page, 
unsigned long offset, unsigned long size)
          {
                 char *kaddr;
@@ -1591,7 +1604,7 @@
                         desc.count = count;
                         desc.buf = buf;
                         desc.error = 0;
-                       do_generic_file_read(filp, ppos, &desc, 
file_read_actor);
+                       do_generic_file_read(filp, ppos, &desc, 
((filp->f_flags & O_NOCOPY) ? file_read_nocopy_actor : file_read_actor));

                         retval = desc.written;
                         if (!retval)

cheers,

lincoln.

