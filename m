Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288238AbSAMWi2>; Sun, 13 Jan 2002 17:38:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288245AbSAMWiS>; Sun, 13 Jan 2002 17:38:18 -0500
Received: from krusty.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:27150 "EHLO
	krusty.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id <S288234AbSAMWiG>; Sun, 13 Jan 2002 17:38:06 -0500
Date: Sun, 13 Jan 2002 23:38:03 +0100
From: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
To: feedback@suse.de, reiserfs-list@namesys.com, linux-kernel@vger.kernel.org
Cc: ewald.peiszer@gmx.at
Subject: Boot failure: msdos pushes in front of reiserfs
Message-ID: <20020113223803.GA28085@emma1.emma.line.org>
Mail-Followup-To: feedback@suse.de, reiserfs-list@namesys.com,
	linux-kernel@vger.kernel.org, ewald.peiszer@gmx.at
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I have been helping Ewald Peiszer (CC'd) to get his machine to boot.

My current analysis of his situation is this:

1. he junked some of his FAT16 partitions, joined two of them as hda13
   and uses hda11 ... hda13 for linux, formatted as ext2, swap,
   reiserfs, in that order

2. his boot fails after the initrd provided by SuSE's install process
   has loaded the reiserfs.o module, his boot logs reveal that the
   kernel mounts his hda13 (which is /) as msdos rather than msdos.

3. I presume that msdos is linked into the kernel, and is thus tried
   first as root file system, the kernel then panicks as it cannot find
   /sbin/init (of course, it's in ReiserFS format, not msdos).

4. I asked Ewald to boot with rootfstype=reiserfs, but he reported that
   this did not help, news:<a1sb7b$t2d2e$1@ID-47183.news.dfncis.de>
   (German-language).

5. It seems as though some traces of FAT16 shining through reiserfs
   still make msdos think it can actually mount the file system.

I see various points where this can be attacked:

1. SuSE and other distributors' installation tools, when formatting a
   partition with mkfs, should zero out the first couple of MBytes with
   dd if=/dev/zero of=/dev/hda13 bs=4096 count=1024 or something. I'm
   not exactly sure how much is needed to get rid of the msdos traces.

2. mkreiserfs could also zero out so much of old data on the FS so that
   the kernel reliably recognizes the FS as reiserfs and fails to mount
   that stuff as msdos

3. Distributors, when making their initrd stuff, should make sure that
   all Linux-native file systems are tried first.

4. rootfstype=reiserfs should be made work for the actual root fs, it
   may be broken through initrd mounts, can anyone verify this? (note: I
   did not verify it's not working, and I cannot currently tell the kernel
   version, Ewald can follow up).

Ewald has only recently migrated from Windows to Linux and direly wants
his installation to boot. For now, I asked him to recompile his kernel
to let msdos, umsdos and vfat be only modules rather than linked into
the kernel, rebuild his initrd with SuSE's mk_initrd and rerun lilo,
that should work around his problem, but it's certainly not good and may
turn away people from Linux who are less enduring and patient than
Ewald.

Thanks a lot in advance,

-- 
Matthias Andree

"They that can give up essential liberty to obtain a little temporary
safety deserve neither liberty nor safety."         Benjamin Franklin
