Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317436AbSHCDZG>; Fri, 2 Aug 2002 23:25:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317444AbSHCDZG>; Fri, 2 Aug 2002 23:25:06 -0400
Received: from h-64-105-137-93.SNVACAID.covad.net ([64.105.137.93]:1665 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S317436AbSHCDZF>; Fri, 2 Aug 2002 23:25:05 -0400
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Fri, 2 Aug 2002 20:28:03 -0700
Message-Id: <200208030328.UAA06724@baldur.yggdrasil.com>
To: linux-kernel@vger.kernel.org
Subject: Re: A new ide warning message
Cc: akpm@zip.com.au, axboe@suse.de, B.Zolnierkiewicz@elka.pw.edu.pl,
       martin@dalecki.de
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>On Fri, Aug 02 2002, Bartlomiej Zolnierkiewicz wrote:
>This case also shows limits of BIO_MAX_SECTORS again (Adam worked on
>generic solution, but I don't know current state).

	In case this information is helpful to anyone, here is
the current status of three different variants of it.

	1. bio_max_iovecs() version - This just replaced BIO_MAX_SECTORS.
It was simple.  It worked, but everyone got more ambitious about making
more sweeping changes.  Jens wanted a boolean one_more_bvec(bio, bvec)
interface.  I made a void bio_append(bio, bvec) interface that would submit
bio that could not hold another bvec and always succeed.  I beleve that
the bio_max_iovecs should have gone in while we worked on other changes
and I still believe that they should go in in the meantime.  People's
systems are crashing while we argue about more ambitious solutions.
I do not have a patch against 2.5.30 handy, but I would be happy to
generate a patch for this again if there is interest in getting it
into Linus's tree while we await future changes that might replace
this code.

	2. bio_append + mpage.c changes - This changed mpage.c to be
able to handle all IO requests that are thrown at it (i.e., it never
punts to fs/buffer.c) .  However, since 2.5.27(?) it corrupts the
disk on an ext2 file system with a 1024-byte block size (I have only
tried it on ext2 file systems and with block sizes of 1024 or 4096 bytes).

	3. bio_append + mpage.c changes + fs/buffer.c shrink - Same as
above, but had fs/mpage.c routines replace the fs/buffer.c routines
entirely, deleting a bunch of buffer_head oriented code from fs/buffer.c.
These changes corrupt the disk when the device is opened with a block
size of 1024 (as opposed ot 4096).  This is probably related to the
bug described in the previous paragraph.

	#2 and #3 are closely related.  Perhaps I will stare at
the code for #2 some more and try to find that @#$Q@#$ bug.

Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."
`e
