Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136354AbRDWDAM>; Sun, 22 Apr 2001 23:00:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136353AbRDWDAC>; Sun, 22 Apr 2001 23:00:02 -0400
Received: from gear.torque.net ([204.138.244.1]:10509 "EHLO gear.torque.net")
	by vger.kernel.org with ESMTP id <S136351AbRDWC7u>;
	Sun, 22 Apr 2001 22:59:50 -0400
Message-ID: <3AE39A86.8AB3FB30@torque.net>
Date: Sun, 22 Apr 2001 22:59:18 -0400
From: Douglas Gilbert <dougg@torque.net>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.3-ac11 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: MO drives (2048 byte block vfat fs) in lk 2.4
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The "MO" bug (also 2048 byte block vfat problem) has been
reported several times in the lk 2.4 series. Since the
finger was being pointed at the SCSI subsystem I decided
to investigate. As far as I can see the sd driver offers
the same physical block (other than 512 byte) capabilities
in lk 2.4 as it did in lk 2.2 .

One error report stated that a MO drive with a vfat
fs based on 2048 byte sectors can be mounted and read
but any significant write causes a system lockup. I
have been able to replicate this behaviour. Luckily
Alt-SysRq-P did work. Pressing this sequence multiple
times gave similar addresses. Rebooting the machine
and rerunning the experiment multiple time gave 
addresses in the same area.

The EIP resolved most often to cont_prepare_write() in
fs/buffer. A disassembly suggests line 1802 in buffer.c
[2.4.3ac11]. That is around a memset() between
__block_prepare_write() and __block_commit_write() calls
within the while loop. Most other addresses were within
the same while loop. Perhaps someone with expertize
in this area may like to examine that loop.


Details: I modified the "scsi_debug" adapter driver to look
like it had one 2048 byte block MO drive connected to it.
The driver uses 8 MB of RAM to simulate a storage device.
[For anyone who wants to run similar experiments, I have
placed the driver at www.torque.net/sg/p/scsi_debug_mo.tgz ].
The sequence of commands that lead up to the failure was:
 $ modprobe scsi_debug
 $ cat /proc/scsi/scsi        # "optical" device should be there
 $ fdisk -ul /dev/sdb         # should see 3 partitions
 $ mkdosfs -S 2048 /dev/sdb3
 $ mount /dev/sdb3 /mnt/extra
 $ cd /mnt/extra
 $ touch t                    # worked ok
 $ cp /boot/vml-2.2.18 u      # system locks up

Doug Gilbert
