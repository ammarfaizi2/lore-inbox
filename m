Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314556AbSEDQVE>; Sat, 4 May 2002 12:21:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314584AbSEDQVD>; Sat, 4 May 2002 12:21:03 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.176.19]:8666 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S314556AbSEDQVB>; Sat, 4 May 2002 12:21:01 -0400
Date: Sat, 4 May 2002 18:16:29 +0200 (CEST)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: Dave Jones <davej@suse.de>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.13-dj2
In-Reply-To: <20020504114119.GA17853@suse.de>
Message-ID: <Pine.NEB.4.44.0205041809410.283-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dave,

I got the following compile error in cpqfcTSinit.c:

<--  snip  -->

...
gcc -D__KERNEL__ -I/home/bunk/linux/kernel-2.5/linux-2.5.13/include -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common
-pipe -mpreferred-stack-boundary=2 -march=k6   -nostdinc -I
/usr/lib/gcc-lib/i386-linux/2.95.4/include -DKBUILD_BASENAME=cpqfcTSinit
-c -o cpqfcTSinit.o cpqfcTSinit.c
cpqfcTSinit.c: In function `cpqfcTS_ioctl':
cpqfcTSinit.c:535: `CAP_RAW_IO' undeclared (first use in this function)
cpqfcTSinit.c:535: (Each undeclared identifier is reported only once
cpqfcTSinit.c:535: for each function it appears in.)
cpqfcTSinit.c: At top level:
cpqfcTSinit.c:1979: unknown field `reset' specified in initializer
cpqfcTSinit.c:1979: duplicate initializer
cpqfcTSinit.c:1979: (near initialization for
`driver_template.eh_device_reset_handler')
cpqfcTSinit.c:1979: unknown field `abort' specified in initializer
make[3]: *** [cpqfcTSinit.o] Error 1
make[3]: Leaving directory `/home/bunk/linux/kernel-2.5/linux-2.5.13/drivers/scsi'

<--  snip  -->


The first part of the error message is strange. 2.5.13-dj2 does exactly
the following change to this file:


--- linux-2.5.13/drivers/scsi/cpqfcTSinit.c	Fri May  3 01:22:40 2002
+++ linux-2.5/drivers/scsi/cpqfcTSinit.c	Fri May  3 12:28:12 2002
@@ -532,7 +532,7 @@

 	// must be super user to send stuff directly to the
 	// controller and/or physical drives...
-	if( !capable(CAP_SYS_ADMIN) )
+	if( !capable(CAP_RAW_IO) )
 	  return -EPERM;

 	// copy the caller's struct to our space.



This is the only place in the 2.5.13-dj2 patch where CAP_RAW_IO is
mentioned and a grep showed that it's the only occurence of CAP_RAW_IO in
the whole 2.5.13-dj2 kernel sources:

<--  snip  -->

~/linux/kernel-2.5/linux-2.5.13$ grep -r CAP_RAW_IO *
drivers/scsi/cpqfcTSinit.c:     if( !capable(CAP_RAW_IO) )
~/linux/kernel-2.5/linux-2.5.13$

<--  snip  -->


cu
Adrian

-- 

You only think this is a free country. Like the US the UK spends a lot of
time explaining its a free country because its a police state.
								Alan Cox

