Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422822AbWJPS5a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422822AbWJPS5a (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Oct 2006 14:57:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422813AbWJPS5a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Oct 2006 14:57:30 -0400
Received: from mxsf24.cluster1.charter.net ([209.225.28.224]:53221 "EHLO
	mxsf24.cluster1.charter.net") by vger.kernel.org with ESMTP
	id S1422822AbWJPS51 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Oct 2006 14:57:27 -0400
X-IronPort-AV: i="4.09,316,1157342400"; 
   d="scan'208"; a="840652976:sNHT690698634"
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17715.54798.646517.200326@smtp.charter.net>
Date: Mon, 16 Oct 2006 14:57:18 -0400
From: "John Stoffel" <john@stoffel.org>
To: "John Stoffel" <john@stoffel.org>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Jeff Garzik <jeff@garzik.org>
Subject: Re: 2.6.19-rc2 - total hang with libata, CDRW and grip
In-Reply-To: <17714.52331.657287.564246@smtp.charter.net>
References: <17714.52331.657287.564246@smtp.charter.net>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Ok, now I've got a bunch of error reports from the 120GB HD as well,
which I'm using for a staging disk with Bacula for backups.  A bunch
of data gets written and then read from the disk before being written
to tape.  I see the following errors in the logs:

   ....
   end_request: I/O error, dev sdc, sector 87
   ata2: EH complete
   ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
   ata2.00: (BMDMA stat 0x20)
   ata2.00: tag 0 cmd 0xc8 Emask 0x81 stat 0x51 err 0x10 (invalid
   argument)
   sd 3:0:0:0: SCSI error: return code = 0x08000002
   sdc: Current: sense key: Aborted Command
       Additional sense: Recorded entity not found
   end_request: I/O error, dev sdc, sector 95
   ata2: EH complete
   SCSI device sdc: drive cache: write back
   ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
   ata2.00: (BMDMA stat 0x20)
   ata2.00: tag 0 cmd 0xc8 Emask 0x81 stat 0x51 err 0x10 (invalid
   argument)
   sd 3:0:0:0: SCSI error: return code = 0x08000002
   sdc: Current: sense key: Aborted Command
       Additional sense: Recorded entity not found
   end_request: I/O error, dev sdc, sector 95
   ata2: EH complete
   ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
   ata2.00: (BMDMA stat 0x20)
   ata2.00: tag 0 cmd 0xc8 Emask 0x81 stat 0x51 err 0x10 (invalid
   argument)
   sd 3:0:0:0: SCSI error: return code = 0x08000002
   sdc: Current: sense key: Aborted Command
       Additional sense: Recorded entity not found
   end_request: I/O error, dev sdc, sector 95
   ata2: EH complete
   SCSI device sdc: 234441648 512-byte hdwr sectors (120034 MB)
   sdc: Write Protect is off
   sdc: Mode Sense: 00 3a 00 00
   SCSI device sdc: drive cache: write back
   SCSI device sdc: 234441648 512-byte hdwr sectors (120034 MB)
   sdc: Write Protect is off
   sdc: Mode Sense: 00 3a 00 00
   SCSI device sdc: drive cache: write back
   ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
   ata2.00: (BMDMA stat 0x20)
   ata2.00: tag 0 cmd 0xc8 Emask 0x81 stat 0x51 err 0x10 (invalid
   argument)
   sd 3:0:0:0: SCSI error: return code = 0x08000002
   sdc: Current: sense key: Aborted Command
       Additional sense: Recorded entity not found
   end_request: I/O error, dev sdc, sector 63
   ata2: EH complete
   SCSI device sdc: 234441648 512-byte hdwr sectors (120034 MB)
   sdc: Write Protect is off
   sdc: Mode Sense: 00 3a 00 00
   SCSI device sdc: drive cache: write back


This is 2.6.19-rc2, libata, regular old IDE running an HPT302 Rev 1
controller with two 12gb HDs, an 18G SCSI disk holding /, /usr, /var &
/boot, dual CPU Xeon PIII 550mhz, 768Gb RAM, Debian unstable updated
within the last two days.

The filesystem (/staging) gets remounted read-only.  Now when I run
badblocks against the drive, it just complains and complains about all
the blocks.  

If I reboot, the system comes up cleanly and I can access the drive
again.  A pass with badblocks completes, as does doing the various
pvcreate, vgcreate, lvcreate, mke2fs commands to setup the filesystem
all over again on the disk. 

It's /dev/sdc1 hold the PV, holds the VG, holds the LV, holds the
filesystem.  

> sudo pvs
  /dev/sdc1: read failed after 0 of 2048 at 0: Input/output error
  PV         VG      Fmt  Attr PSize   PFree
  /dev/md0   data_vg lvm2 a-   111.79G 1.79G

> sudo vgs
  /dev/sdc1: read failed after 0 of 2048 at 0: Input/output error
  VG      #PV #LV #SN Attr   VSize   VFree
  data_vg   1   3   0 wz--n- 111.79G 1.79G

> sudo lvs
Password:
  /dev/sdc1: read failed after 0 of 2048 at 0: Input/output error
  LV       VG      Attr   LSize  Origin Snap%  Move Log Copy% 
  home_lv  data_vg -wi-ao 67.00G                              
  local_lv data_vg -wi-ao 35.00G                              
  staging  data_vg -wi-a-  8.00G                

I can either reboot the system and get more details, or I can leave it
like it is now and try some suggestions to get the disk back online.

  > sdparm --version
  version: 0.98 20060509

  > sudo sdparm -v /dev/sdc
      /dev/sdc: ATA       WDC WD1200JB-00C  17.0
      Request Sense cmd: 03 00 00 00 40 00 
  request sense:  Fixed format, current;  Sense key: Illegal Request
   Additional sense: Invalid command operation code
  REQUEST SENSE failed


Thanks,
John
