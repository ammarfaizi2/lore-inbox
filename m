Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312458AbSDDHwe>; Thu, 4 Apr 2002 02:52:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312453AbSDDHwZ>; Thu, 4 Apr 2002 02:52:25 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.176.19]:34291 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S312458AbSDDHwL>; Thu, 4 Apr 2002 02:52:11 -0500
Date: Thu, 4 Apr 2002 09:50:32 +0200 (CEST)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: Dave Jones <davej@suse.de>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.7-dj3
In-Reply-To: <20020404054923.A28437@suse.de>
Message-ID: <Pine.NEB.4.44.0204040946500.7845-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dave,

I got the following compile error:

<--  snip  -->

...
gcc -D__KERNEL__ -I/home/bunk/linux/kernel-2.5/linux-2.5.7/include -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer
-fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2
-march=k6   -DKBUILD_BASENAME=pdc4030  -c -o pdc4030.o pdc4030.c
pdc4030.c: In function `promise_multwrite':
pdc4030.c:447: warning: passing arg 2 of `bio_kmap_irq' makes pointer from
integer without a cast
pdc4030.c: In function `promise_rw_disk':
pdc4030.c:664: structure has no member named `channel'
make[3]: *** [pdc4030.o] Error 1
make[3]: Leaving directory
`/home/bunk/linux/kernel-2.5/linux-2.5.7/drivers/ide'
make[2]: *** [first_rule] Error 2
make[2]: Leaving directory
`/home/bunk/linux/kernel-2.5/linux-2.5.7/drivers/ide'
make[1]: *** [_subdir_ide] Error 2
make[1]: Leaving directory
`/home/bunk/linux/kernel-2.5/linux-2.5.7/drivers'
make: *** [_dir_drivers] Error 2

<--  snip  -->


The code that failed is the following part of -dj3 that s not in
2.5.8-pre1:


--- linux-2.5.7/drivers/ide/pdc4030.c	Mon Mar 18 20:37:08 2002
+++ linux-2.5/drivers/ide/pdc4030.c	Thu Apr  4 04:19:50 2002
@@ -645,6 +656,13 @@

 	memset(&taskfile, 0, sizeof(struct hd_drive_task_hdr));

+	/* The four drives on the two logical (one physical) interfaces
+	   are distinguished by writing the drive number (0-3) to the
+	   Feature register.
+	   FIXME: Is promise_selectproc now redundant??
+	*/
+	taskfile.feature	= (HWIF(drive)->channel << 1) + drive->select.b.unit;
+
 	taskfile.sector_count	= rq->nr_sectors;
 	taskfile.sector_number	= block;
 	taskfile.low_cylinder	= (block>>=8);


cu
Adrian


