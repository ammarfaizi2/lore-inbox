Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261163AbVBGPwS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261163AbVBGPwS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Feb 2005 10:52:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261155AbVBGPwS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Feb 2005 10:52:18 -0500
Received: from relay.muni.cz ([147.251.4.35]:60644 "EHLO tirith.ics.muni.cz")
	by vger.kernel.org with ESMTP id S261167AbVBGPwJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Feb 2005 10:52:09 -0500
Date: Mon, 7 Feb 2005 16:52:02 +0100
From: Jan Kasprzak <kas@fi.muni.cz>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Jens Axboe <axboe@suse.de>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Memory leak in 2.6.11-rc1?
Message-ID: <20050207155202.GY24513@fi.muni.cz>
References: <20050121161959.GO3922@fi.muni.cz> <20050207110030.GI24513@fi.muni.cz> <Pine.LNX.4.58.0502070728280.2165@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0502070728280.2165@ppc970.osdl.org>
User-Agent: Mutt/1.4.1i
X-Muni-Envelope-From: kas@fi.muni.cz
X-Muni-Virus-Test: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
: Jan - can you give Jens a bit of an idea of what drivers and/or schedulers 
: you're using?

	I have a Tyan S2882 dual Opteron, network is on-board tg3,
there are 8 P-ATA HDDs hooked on 3ware 7506-8 controller (no HW RAID
there, but the drives are partitioned and partition grouped to form
software RAID-0, 1, 5, and 10 volumes - the main fileserving traffic
is on a RAID-5 volume, and /var is on RAID-10 volume.

	Filesystems are XFS for that RAID-5 volume, ext3 for the rest
of the system. I have compiled-in the following I/O schedulers (according
to my /var/log/dmesg :-)

io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered

I have not changed the scheduler by hand, so I suppose the anticipatory
is the default.

	No X, just serial console. The server does FTP serving mostly
(ProFTPd with sendfile() compiled in), sending mail via qmail (cca
100-200k mails a day), and bits of other work (rsync, Apache, ...).
Fedora core 3 with all relevant updates.

	My fstab (physical devices only):
/dev/md0                /                       ext3    defaults        1 1
/dev/md1                /home                   ext3    defaults        1 2
/dev/md6                /var                    ext3    defaults        1 2
/dev/md4                /fastraid               xfs     noatime         1 3
/dev/md5                /export                 xfs     noatime         1 4
/dev/sde4               swap                    swap    pri=10          0 0
/dev/sdf4               swap                    swap    pri=10          0 0
/dev/sdg4               swap                    swap    pri=10          0 0
/dev/sdh4               swap                    swap    pri=10          0 0

	My mdstat:

Personalities : [raid0] [raid1] [raid5]
md6 : active raid0 md3[0] md2[1]
      19550720 blocks 64k chunks

md1 : active raid1 sdd1[1] sdc1[0]
      14659200 blocks [2/2] [UU]

md2 : active raid1 sdf1[1] sde1[0]
      9775424 blocks [2/2] [UU]

md3 : active raid1 sdh1[1] sdg1[0]
      9775424 blocks [2/2] [UU]

md4 : active raid0 sdh2[7] sdg2[6] sdf2[5] sde2[4] sdd2[3] sdc2[2] sdb2[1] sda2[0]
      39133184 blocks 256k chunks

md5 : active raid5 sdh3[7] sdg3[6] sdf3[5] sde3[4] sdd3[3] sdc3[2] sdb3[1] sda3[0]
      1572512256 blocks level 5, 256k chunk, algorithm 2 [8/8] [UUUUUUUU]

md0 : active raid1 sdb1[1] sda1[0]
      14659200 blocks [2/2] [UU]

unused devices: <none>

	Anything else you want to know? Thanks,

-Yenya

-- 
| Jan "Yenya" Kasprzak  <kas at {fi.muni.cz - work | yenya.net - private}> |
| GPG: ID 1024/D3498839      Fingerprint 0D99A7FB206605D7 8B35FCDE05B18A5E |
| http://www.fi.muni.cz/~kas/   Czech Linux Homepage: http://www.linux.cz/ |
> Whatever the Java applications and desktop dances may lead to, Unix will <
> still be pushing the packets around for a quite a while.      --Rob Pike <
