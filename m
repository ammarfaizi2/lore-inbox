Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293232AbSB1KIZ>; Thu, 28 Feb 2002 05:08:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293223AbSB1KGQ>; Thu, 28 Feb 2002 05:06:16 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:30480 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S293230AbSB1KC5>; Thu, 28 Feb 2002 05:02:57 -0500
Date: Thu, 28 Feb 2002 10:59:55 +0100
From: Pavel Machek <pavel@ucw.cz>
To: kernel list <linux-kernel@vger.kernel.org>
Subject: Sync over loop devices takes ages? [2.4.17]
Message-ID: <20020228095955.GH774@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I have a script (attached). At one point it tries to do sync... That
sync take a long time, with disk mostly unused. vmstat says:

[Well, it actually finished in five minutes. 100MB file, 300 seconds,
that's 300kB per second. That disk can do 

root@amd:/proc/sys/kernel# hdparm -t /dev/hda

/dev/hda:
 Timing buffered disk reads:  64 MB in  9.49 seconds =  6.74 MB/sec
root@amd:/proc/sys/kernel#
]

256MB ram, athlon cpu.

root@amd:~# vmstat 1
   procs                      memory    swap          io     system         cpu
 r  b  w   swpd   free   buff  cache  si  so    bi    bo   in    cs  us  sy  id
 1  1  2      0   4384   8160 210048   0   0   244   483 1292   179   0   4  95
 0  1  2      0   4424   8160 210008   0   0   216   436 1406   129   0   1  99
 0  1  2      0   4464   8160 209968   0   0   216   432 1397   124   0   1  99
 0  1  2      0   4380   8160 210052   0   0   212   424 1373   124   0   1  99
 0  1  2      0   4428   8160 210008   0   0   212   424 1373   122   0   1  99
 0  1  2      0   4468   8160 209968   0   0   216   432 1397   127   0   3  97
 0  1  2      0   4380   8160 210060   0   0   220   448 1437   126   0   1  99
 0  1  2      0   4432   8160 210008   0   0   204   408 1325   118   0   0 100
 0  1  2      0   4344   8160 210096   0   0   216   432 1397   126   0   1  99
 0  1  2      0   4388   8160 210052   0   0   212   424 1373   122   0   1  99
 0  1  2      0   4416   8160 210020   0   0   224   448 1445   130   1   0  99
 0  1  2      0   4464   8156 209976   0   0   208   416 1428   274   0   2  98
 0  1  2      0   4376   8156 210064   0   0   216   432 1510   345   0   0 100
 0  1  2      0   4428   8156 210012   0   0   204   408 1420   299   0   2  98

2% cpu used, 2 blocks written? This is way too low. Is this known bug?
Script looks like this, to reproduce I did run it with -p:

#!/bin/bash
#
# fscktest
#
# Usage: 
#	 Make sure output is logged somewhere
#        First, run fscktest -p as root
#	 Then you can run fscktest as normal user...
#

prepare() {
	SIZE=100000
	echo "Creating file..."
	cat /dev/zero | head -c $[$SIZE*1024] > test
	echo "Making filesystem..."
	/sbin/mkfs.$FS test
	echo "Mounting..."
	mount test -o loop /mnt
	echo "Copying files..."
	cp -a /bin /mnt
	cp -a /usr/bin /mnt
	cp -a /usr/src/linux /mnt
	echo "Syncing..."
	sync
	echo "Unmounting..."
	umount /mnt
	echo "Moving..."
	mv test fsck.okay
	echo "All done."
}

FS=ext2
if [ .$1 == .-p ]; then
	prepare
	exit
	fi
RUN=0
while true; do
	RUN=$[$RUN+1]
	echo "Run #$RUN"
	echo Preparing...
	cp fsck.okay fsck.damaged
	echo Damaging...
	dd if=/dev/urandom of=fsck.damaged count=10240 seek=3 conv=notrunc
	cp fsck.damaged fsck.test
	echo First check...
	/sbin/fsck.$FS -fy fsck.damaged
	RESULT=$?
	if [ $RESULT != 1 -a $RESULT != 2 -a $RESULT != 0 ]; then
		echo "Fsck failed in bad way (result = $RESULT)"
		exit
		fi
	echo Second check...
	/sbin/fsck.$FS -fy fsck.damaged
	RESULT=$?
	if [ $RESULT != 0 ]; then
		echo "Fsck lied about its success (result = $RESULT)"
		exit
		fi
	done


Any comments, fixes, etc?
									Pavel
-- 
(about SSSCA) "I don't say this lightly.  However, I really think that the U.S.
no longer is classifiable as a democracy, but rather as a plutocracy." --hpa
