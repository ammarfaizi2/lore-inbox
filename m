Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284178AbRLKXaf>; Tue, 11 Dec 2001 18:30:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284182AbRLKXa1>; Tue, 11 Dec 2001 18:30:27 -0500
Received: from www3.aname.net ([62.119.28.103]:51384 "EHLO www3.aname.net")
	by vger.kernel.org with ESMTP id <S284178AbRLKXaJ>;
	Tue, 11 Dec 2001 18:30:09 -0500
From: "Johan Ekenberg" <johan@ekenberg.se>
To: <linux-kernel@vger.kernel.org>
Subject: Lockups with 2.4.14 and 2.4.16
Date: Wed, 12 Dec 2001 00:29:38 +0100
Message-ID: <000901c1829b$b38e1720$050010ac@FUTURE>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook 8.5, Build 4.71.2377.0
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4807.1700
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We recently upgraded 10 servers from 2.2.19 to 2.4.14/2.4.16. Since then,
several servers have experienced severe lockups forcing hardware resets. The
machines are Intel PIII (Dual) SMP running Epox motherboards. Here are the
details:

## The Story:
 - Suddenly a machine gets a load average of about 500-1000.
 - It's not possible to log in either at the console or by SSH.
 - Some commands are possible to run through ssh from a remote server, like:
   "ssh badserver ps auxwf" or "ssh badserver free"
 - Despite a system load of 1000, commands like "free", "ps" and "uptime"
often respond quickly, no "sluggishness".
 - The locked up machine seems to use all available memory plus a good deal
of swap
 - The process table gets bigger and bigger, mainly ipop3d processes from
users trying to fetch mail but getting no reply.
 - The processors seem to be mostly idle.
 - Killing processes doesn't work, not even with SIGKILL.
 - We haven't been able to find a time pattern for the lockups, or to
reproduce them at will.
 - No kernel error messages are written to the console or logs.
 - Ctrl-alt-delete produces a "Rebooting"-message on the console, but there
is no actual reboot. Power cycling is the only way out.
 - My not-so-professional guess is that the machine is locked up waiting for
some disk i/o that never happens, either to swap or normal filesystem. But,
I might be all wrong.

## Hardware:
 - Dual PIII 850 on Epox BXB-S and Epox KP6-BS
 - 1Gb RAM (4x256)
 - Mylex AcceleRAID 352 PCI RAID Controller,
   IBM disks, 3x36Gb Raid-5 mounted on /
   and 2x18 Raid-1 mounted on /var/spool
 - 1x20Gb IDE for /boot and swap (2 x 2Gb swap partitions)
 - 1x36Gb IDE for backups

## Kernel:
 - 2.4.14 and 2.4.16
 - Patched for reiserfs-quota with patches found at
   ftp://ftp.suse.com/pub/people/mason/patches/reiserfs/quota-2.4/
     ( * 50_quota-patch
       * dquota_deadlock
       * nesting
       * reiserfs-quota )
 - Complete kernel-config found here:
http://www.ekenberg.se/2.4-trouble/2.4.16-config
 - Boot parameters are: "ether=0,0,eth1 panic=60 noapic"

## Filesystems:
 - ReiserFS (3.6) except /boot which is ext2

## General
 - The servers are used mainly for:
   * Apache/PHP with ~1000 VHosts
   * Mail (Sendmail, imap, pop3)
   * MySQL

## /etc/fstab:
/dev/rd/c0d0    /           reiserfs    defaults,usrquota,noatime,notail   1
1
/dev/rd/c0d1    /var/spool  reiserfs    defaults,usrquota,noatime,notail   1
1
/dev/hdb1       /hdb1       reiserfs    defaults,noatime,notail 0 0
/dev/hda1       /boot       ext2        defaults  1  1
/dev/hda2       swap        swap        defaults  0  0
/dev/hda3       swap        swap        defaults  0  0
none            /dev/pts    devpts      gid=5,mode=620  0   0
none            /proc       proc        defaults   0   0

## lspci:
00:00.0 Host bridge: Intel Corporation 440BX/ZX - 82443BX/ZX Host bridge
(rev 03)
00:01.0 PCI bridge: Intel Corporation 440BX/ZX - 82443BX/ZX AGP bridge (rev
03)
00:07.0 ISA bridge: Intel Corporation 82371AB PIIX4 ISA (rev 02)
00:07.1 IDE interface: Intel Corporation 82371AB PIIX4 IDE (rev 01)
00:07.2 USB Controller: Intel Corporation 82371AB PIIX4 USB (rev 01)
00:07.3 Bridge: Intel Corporation 82371AB PIIX4 ACPI (rev 02)
00:08.0 Ethernet controller: 3Com Corporation 3c905B 100BaseTX [Cyclone]
(rev 30)
00:09.0 Ethernet controller: 3Com Corporation 3c905B 100BaseTX [Cyclone]
(rev 30)
00:0a.0 PCI bridge: Intel Corporation: Unknown device 0964 (rev 02)
00:0a.1 RAID bus controller: Mylex Corporation: Unknown device 0050 (rev 02)
00:0c.0 SCSI storage controller: Adaptec AHA-2940U2/W / 7890
01:00.0 VGA compatible controller: S3 Inc. 86c368 [Trio 3D/2X] (rev 02)


This is my first post to LKML, please forgive me if I forgot some relevant
info.
Please Cc: replies as I'm not subscribed to LKML.

Best regards,
/Johan Ekenberg


