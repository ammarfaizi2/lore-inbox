Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262879AbUCOXEo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Mar 2004 18:04:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262872AbUCOXEm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Mar 2004 18:04:42 -0500
Received: from smtp-out3.iol.cz ([194.228.2.91]:64678 "EHLO smtp-out3.iol.cz")
	by vger.kernel.org with ESMTP id S262667AbUCOXBz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Mar 2004 18:01:55 -0500
From: Chris Moore <chris.moore@mail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16470.13793.211260.738789@chrislap.ourcpu.com>
Date: Tue, 16 Mar 2004 00:01:53 +0100
To: linux-kernel@vger.kernel.org
Subject: problem with sbp2 / ieee1394 in kernel 2.6.3
X-Mailer: VM 7.18 under Emacs 21.3.50.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a Maxtor 5000XT external ieee1394/USB2 disk drive, which I
connect to my PC's ieee1394 port.  It works well with Linux under
both kernels 2.4.x and 2.6.3 for a while.  I see messages like these
in syslog (under 2.6.3):

  Mar 15 13:21:55 chrislap kernel:   Vendor: Maxtor    Model: 5000XT            Rev: 0100
  Mar 15 13:21:55 chrislap kernel:   Type:   Direct-Access                      ANSI SCSI revision: 06
  Mar 15 13:21:55 chrislap kernel: SCSI device sda: 490232832 512-byte hdwr sectors (250999 MB)
  Mar 15 13:21:55 chrislap kernel: sda: asking for cache data failed
  Mar 15 13:21:55 chrislap kernel: sda: assuming drive cache: write through
  Mar 15 13:21:55 chrislap kernel:  /dev/scsi/host0/bus0/target0/lun0: p1 p2 p3 p4 < p5 p6 >
  Mar 15 13:21:55 chrislap kernel: Attached scsi disk sda at scsi0, channel 0, id 0, lun 0

Unfortunately, at some point problems always occur.  Sometimes the
drive stops working very quickly, other times I can transfer tens of
gigabytes of data to and from the drive before anything goes wrong
with it, but eventually it always breaks, under both 2.4.x and 2.6.3.

When it breaks I see messages like these in the syslog:

  Mar 15 23:32:26 chrislap kernel: ieee1394: sbp2: aborting sbp2 command
  Mar 15 23:32:26 chrislap kernel: Read (10) 00 04 d0 26 6f 00 00 b0 00
  Mar 15 23:32:36 chrislap kernel: ieee1394: sbp2: aborting sbp2 command
  Mar 15 23:32:36 chrislap kernel: Test Unit Ready 00 00 00 00 00
  Mar 15 23:32:36 chrislap kernel: ieee1394: sbp2: reset requested
  Mar 15 23:32:36 chrislap kernel: ieee1394: sbp2: Generating sbp2 fetch agent reset
  Mar 15 23:32:46 chrislap kernel: ieee1394: sbp2: aborting sbp2 command
  Mar 15 23:32:46 chrislap kernel: Test Unit Ready 00 00 00 00 00
  Mar 15 23:32:46 chrislap kernel: ieee1394: sbp2: reset requested
  Mar 15 23:32:46 chrislap kernel: ieee1394: sbp2: Generating sbp2 fetch agent reset
  Mar 15 23:33:06 chrislap kernel: ieee1394: sbp2: aborting sbp2 command
  Mar 15 23:33:06 chrislap kernel: Test Unit Ready 00 00 00 00 00
  Mar 15 23:33:06 chrislap kernel: ieee1394: sbp2: reset requested
  Mar 15 23:33:06 chrislap kernel: ieee1394: sbp2: Generating sbp2 fetch agent reset
  Mar 15 23:33:26 chrislap kernel: ieee1394: sbp2: aborting sbp2 command
  Mar 15 23:33:26 chrislap kernel: Test Unit Ready 00 00 00 00 00
  Mar 15 23:33:26 chrislap kernel: scsi: Device offlined - not ready after error recovery: host 0 channel 0 id 0 lun 0
  Mar 15 23:33:26 chrislap kernel: SCSI error : <0 0 0 0> return code = 0x50000
  Mar 15 23:33:26 chrislap kernel: end_request: I/O error, dev sda, sector 80750191
  Mar 15 23:33:26 chrislap kernel: scsi0 (0:0): rejecting I/O to offline device
  Mar 15 23:33:26 chrislap kernel: Buffer I/O error on device sda2, logical block 110592
  Mar 15 23:33:26 chrislap kernel: lost page write due to I/O error on sda2
  Mar 15 23:33:26 chrislap kernel: scsi0 (0:0): rejecting I/O to offline device
  Mar 15 23:33:26 chrislap kernel: scsi0 (0:0): rejecting I/O to offline device
  Mar 15 23:33:26 chrislap kernel: Buffer I/O error on device sda2, logical block 3547
  Mar 15 23:33:26 chrislap kernel: lost page write due to I/O error on sda2
  Mar 15 23:33:26 chrislap kernel: Aborting journal on device sda2.
  Mar 15 23:33:26 chrislap kernel: scsi0 (0:0): rejecting I/O to offline device
  Mar 15 23:33:26 chrislap kernel: ext3_abort called.
  Mar 15 23:33:26 chrislap kernel: EXT3-fs abort (device sda2): ext3_journal_start: Detected aborted journal
  Mar 15 23:33:26 chrislap kernel: Remounting filesystem read-only
  Mar 15 23:33:26 chrislap kernel: scsi0 (0:0): rejecting I/O to offline device
  Mar 15 23:33:26 chrislap kernel: EXT3-fs error (device sda2): ext3_get_inode_loc: unable to read inode block - inode=327681, block=655362

When this happens I umount the firewire filesystems and then try to
"modprobe -r -v sbp2", but the modprobe command always hangs.  I find
I cannot access the drive again until I reboot.

Please, if there's anything more you need to know, or anything I can
do to help diagnose this problem, just reply to this message.  I would
love to see it fixed.

Chris.
