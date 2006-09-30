Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751072AbWI3PGh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751072AbWI3PGh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Sep 2006 11:06:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751080AbWI3PGh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Sep 2006 11:06:37 -0400
Received: from wx-out-0506.google.com ([66.249.82.224]:17205 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751072AbWI3PGf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Sep 2006 11:06:35 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:mime-version:content-type:content-transfer-encoding:x-mailer:x-mimeole:thread-index:message-id;
        b=OUqRACwropanoUuL3WAwD3c+9TDcUmWg/f3wlUZgzbeIAVFpdy0m696uHPVAAvqPVp5aG4458QqIl4Cr6LD/hJUDBUU8H8JU90ZBNAaejeeR6hhIOLjOBpg5lTV0oP4/aV1ZoEvfxFQ+ZdRI8/0CRlqRjukljPad7zUQfwc9POo=
From: "Chris Lee" <labmonkey42@gmail.com>
To: <linux-kernel@vger.kernel.org>
Subject: Problem with legacy megaraid
Date: Sat, 30 Sep 2006 10:06:36 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1807
Thread-Index: AcbkogXX1Z9/IABhT5urx/IUwmUU0w==
Message-ID: <451e87fa.60a54fb4.44c0.4562@mx.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am not subscribed to this list.  Please CC me on replies.

I have a machine I'm trying to use as a file server.  I have a RAID10 and a
RAID5 on a single Dell PERC2/DC (AMI Megaraid 467) controller.  Both arrays
are also on the same SCSI channel.  The system runs fine for days on end
until I put some heavy I/O load on either array and sustain it for a few
seconds.

Distro: Gentoo Linux
Kernel: 2.6.17-gentoo-r7

Hardware:
Motherboard: Tyan Thunder i7501 Pro (S2721-533)
CPUs: Dual 2.8Ghz P4 HT Xeons
RAM: 4GB registered (3/1 split, flat model)
RAID: Dell PERC2/DC (AMI Megaraid 467)
SCSI: Adaptec AHA-2940U2/U2W PCI
NICs: onboard e100 and dual onboard e1000

There are 14 hard drives on channel 0 of the perc2/dc.  IDs 1-6 are RAID10
mounted in an external enclosure; IDs 8-15 are RAID5 mounted internally.
The I/O problems occur on either array, which suggests to me that it is not
a cabling issue.

To reproduce the problem for the purpose of this email I ran `bonnie++ -d
/home/nobody -u nobody:nogroup` where /home is the mountpoint of the RAID5
and bonnie++ created an 8GB file.  I have reproduced this problem numerous
times and the sustained I/O time required to create the fault varies.  Once
it happened running a ./configure script for some rather small package.
However, this time it took approximately 20-30 minutes before it freaked
out.

Once the problem occurs I have to reboot the machine to regain use of the
affected array(s).  I should note that the controller bios finds nothing
wrong with the arrays, and when e2fsck is forced on boot it replays the
journal and reports no other problems aside from a "Superblock last write
time is in the future.  FIXED." which I attribute to a misconfiguration on
my part for saving system time to hardware clock.  If I attempt to unmount
the array and mount it again without rebooting I get an error message that
sdXX is not a valid block device.

Logs/info:

active vt says (this is copied via eyeball):
[4513644.094000] ext3_aboart called.
[4513644.101000] EXT3-fs error (device sdb1): ext3_journal_start_sb: <3>sd
0:0:1:0: rejecting I/O to offline device
[4513644.109000] Remounting filesystem read-only

dmesg stuff about megaraid:
[4294675.180000] megaraid: found 0x8086:0x1960:bus 3:slot 3:func 1
[4294675.191000] scsi0:Found MegaRAID controller at 0xf8806000, IRQ:177
[4294675.254000] megaraid: [1.06:1p00] detected 2 logical drives.
[4294675.316000] megaraid: channel[0] is raid.
[4294675.326000] megaraid: channel[1] is raid.
[4294675.362000] scsi0 : LSI Logic MegaRAID 1.06 254 commands 16 targs 5
chans 7 luns
[4294675.372000] scsi0: scanning scsi channel 0 for logical drives.
[4294675.383000]   Vendor: MegaRAID  Model: LD0 RAID1 09634R  Rev: 1.06
[4294675.393000]   Type:   Direct-Access                      ANSI SCSI
revision: 02
[4294675.404000]   Vendor: MegaRAID  Model: LD1 RAID5 38288R  Rev: 1.06
[4294675.415000]   Type:   Direct-Access                      ANSI SCSI
revision: 02
[4294675.428000] scsi0: scanning scsi channel 4 [P0] for physical devices.
[4294675.726000] scsi0: scanning scsi channel 5 [P1] for physical devices.
[4294680.126000] megaraid cmm: 2.20.2.6 (Release Date: Mon Mar 7 00:01:03
EST 2005)
[4294680.136000] megaraid: 2.20.4.8 (Release Date: Mon Apr 11 12:27:22 EST
2006)
[4294680.157000] SCSI device sda: 429330432 512-byte hdwr sectors (219817
MB)
[4294680.167000] sda: Write Protect is off
[4294680.198000] SCSI device sda: 429330432 512-byte hdwr sectors (219817
MB)
[4294680.208000] sda: Write Protect is off
[4294680.237000]  sda: sda1 sda2
[4294680.247000] sd 0:0:0:0: Attached scsi disk sda
[4294680.257000] SCSI device sdb: 2126413824 512-byte hdwr sectors (1088724
MB)
[4294680.267000] sdb: Write Protect is off
[4294680.296000] SCSI device sdb: 2126413824 512-byte hdwr sectors (1088724
MB)
[4294680.305000] sdb: Write Protect is off
[4294680.334000]  sdb: sdb1
[4294680.345000] sd 0:0:1:0: Attached scsi disk sdb
[4294680.355000] sd 0:0:0:0: Attached scsi generic sg0 type 0
[4294680.365000] sd 0:0:1:0: Attached scsi generic sg1 type 0

/var/log/messages:
Sep 29 07:46:16 hostname kernel: [4513615.601000] sd 0:0:1:0: SCSI error:
return code = 0x40001
Sep 29 07:46:16 hostname kernel: [4513615.601000] end_request: I/O error,
dev sdb, sector 1744348567
Sep 29 07:46:16 hostname kernel: [4513615.601000] Buffer I/O error on device
sdb1, logical block 218043563
Sep 29 07:46:16 hostname kernel: [4513615.601000] lost page write due to I/O
error on sdb1
Sep 29 07:46:16 hostname kernel: [4513615.601000] sd 0:0:1:0: SCSI error:
return code = 0x40001
Sep 29 07:46:16 hostname kernel: [4513615.601000] end_request: I/O error,
dev sdb, sector 1744348695
Sep 29 07:46:16 hostname kernel: [4513615.601000] Buffer I/O error on device
sdb1, logical block 218043579
Sep 29 07:46:16 hostname kernel: [4513615.601000] lost page write due to I/O
error on sdb1
Sep 29 07:46:16 hostname kernel: [4513615.778000] sd 0:0:1:0: SCSI error:
return code = 0x40001
Sep 29 07:46:16 hostname kernel: [4513615.778000] end_request: I/O error,
dev sdb, sector 1744348823
Sep 29 07:46:16 hostname kernel: [4513615.778000] Buffer I/O error on device
sdb1, logical block 218043595
Sep 29 07:46:16 hostname kernel: [4513615.778000] lost page write due to I/O
error on sdb1
Sep 29 07:46:16 hostname kernel: [4513615.778000] sd 0:0:1:0: SCSI error:
return code = 0x40001
Sep 29 07:46:44 hostname kernel: [4513615.778000] end_request: I/O error,
dev sdb, sector 1744348951
Sep 29 07:46:44 hostname kernel: [4513615.778000] Buffer I/O error on device
sdb1, logical block 218043611
Sep 29 07:46:44 hostname kernel: [4513615.778000] lost page write due to I/O
error on sdb1
Sep 29 07:46:44 hostname kernel: [4513615.778000] sd 0:0:1:0: SCSI error:
return code = 0x40001
Sep 29 07:46:44 hostname kernel: [4513615.778000] end_request: I/O error,
dev sdb, sector 1744348959
Sep 29 07:46:44 hostname kernel: [4513615.778000] Buffer I/O error on device
sdb1, logical block 218043612
Sep 29 07:46:44 hostname kernel: [4513615.778000] lost page write due to I/O
error on sdb1
Sep 29 07:46:44 hostname kernel: [4513643.303000] sd 0:0:1:0: rejecting I/O
to offline device
Sep 29 07:46:44 hostname last message repeated 92 times

The last two lines repeat as long as something continues trying to access
that logical drive.

If any other logs/info would be useful please let me know and I will by
happy to include them.  TIA for any help.  Also I apologise if this is not
relevant for the list.

Thanks,
Chris 

