Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318112AbSFTEGD>; Thu, 20 Jun 2002 00:06:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318113AbSFTEGC>; Thu, 20 Jun 2002 00:06:02 -0400
Received: from goose.mail.pas.earthlink.net ([207.217.120.18]:56710 "EHLO
	goose.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id <S318112AbSFTEGB>; Thu, 20 Jun 2002 00:06:01 -0400
Date: Thu, 20 Jun 2002 00:07:49 -0400
To: davej@suse.de
Cc: linux-kernel@vger.kernel.org, ckulesa@as.arizona.edu,
       torvalds@transmeta.com
Subject: Re: [PATCH] (1/2) reverse mapping VM for 2.5.23 (rmap-13b)
Message-ID: <20020620040749.GA32177@rushmore>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
From: rwhron@earthlink.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Absolutely.  Maybe Randy Hron (added to Cc) can find some spare time
> to benchmark these sometime before the summit too[1]. It'll be very
> interesting to see where it fits in with the other benchmark results
> he's collected on varying workloads.

I'd like to start benchmarking 2.5 on the quad xeon.  You fixed the
aic7xxx driver in 2.5.23-dj1.  It also has a qlogic QLA2200.
You mentioned the qlogic driver in 2.5 may not have the new error handling yet.

I haven't been able to get a <SysRq showTasks> on it yet, 
but the reproducable scenerio for all the 2.5.x kernels I've tried 
has been:

mke2fs -q /dev/sdc1
mount -t ext2 -o defaults,noatime /dev/sdc1 /fs1
mkreiserfs /dev/sdc2
mount -t reiserfs -o defaults,noatime /dev/sdc2 /fs2
mke2fs -q -j -J size=400 /dev/sdc3
mount -t ext3 -o defaults,noatime,data=writeback /dev/sdc3 /fs3

for fs in /fs1 /fs2 /fs3
do	cpio a hundred megabytes of benchmarks into the 3 filesystems.
	sync;sync;sync
	umount $fs
done

In 2.5.x umount(1) hangs in uninteruptable sleep when
umounting the first or second filesystem.  In 2.5.23, the sync
was in uninteruptable sleep before umounting /fs2.

The compile error on 2.5.23-dj1 was:

gcc -Wp,-MD,./.qlogicisp.o.d -D__KERNEL__ -I/usr/src/linux-2.5.23-dj1/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=i686 -nostdinc -iwithprefix include    -DKBUILD_BASENAME=qlogicisp   -c -o qlogicisp.o qlogicisp.c
qlogicisp.c:2005: unknown field `abort' specified in initializer
qlogicisp.c:2005: warning: initialization from incompatible pointer type
qlogicisp.c:2005: unknown field `reset' specified in initializer
qlogicisp.c:2005: warning: initialization from incompatible pointer type
make[2]: *** [qlogicisp.o] Error 1
make[2]: Leaving directory `/usr/src/linux-2.5.23-dj1/drivers/scsi'
make[1]: *** [scsi] Error 2
make[1]: Leaving directory `/usr/src/linux-2.5.23-dj1/drivers'
make: *** [drivers] Error 2

Just in case someone with know-how and can do wants to[1].

> [1] I am master of subtle hints.

I'll put 2.5.x on top of the quad Xeon benchmark queue as soon as I can.

-- 
Randy Hron
http://home.earthlink.net/~rwhron/kernel/bigbox.html

