Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264830AbTFQOzJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jun 2003 10:55:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264829AbTFQOzI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jun 2003 10:55:08 -0400
Received: from [66.155.158.133] ([66.155.158.133]:29824 "EHLO
	ns.waumbecmill.com") by vger.kernel.org with ESMTP id S264830AbTFQOyo convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jun 2003 10:54:44 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: joe briggs <jbriggs@briggsmedia.com>
Organization: BMS
To: linux-kernel@vger.kernel.org
Subject: IDE data corruption.
Date: Tue, 17 Jun 2003 12:06:34 -0400
User-Agent: KMail/1.4.3
Cc: ryan@rdasys.net
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200306171206.34304.jbriggs@briggsmedia.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have sent several postings over the last few weeks with data supporting a 
potential weakness in the IDE driver that results in file system corruption 
on systems with heavy PCI activity (specifically, video capture for 
surveillance systems).  Affected hardware includes Tyan 2460/6 dual athlon 
motherboards, GigaByte GA7VXP athlon, and Aopen G4MX P4/2.4 motherboards.  

On all of these systems running Debian 2.4.19 and 2.4.21 kernels, data 
corruption would occur when sustaining an aggregrate video  capture and 
transfer rate of approximately 40 320x240 YUV (12 bit/pixel) frames per 
second.  Test systems where not runing X, and used ReiserFS.  All systems had 
one IDE boot/system drive, and a 2-drive IDE raid using Promise or 3-ware pci 
controllers.  The frame-grabbers used the bttv driver.  The RAID was used for 
the frame data and database.

Eventually, the system will just freeze while trying to swap.  Errors present 
on the console or system log, if any, where "memory.c: 100: pmd", a plethora 
of ReiserFS errors, and/or a page fault.  Occassionally we would see a 'hda 
missed interrupt" in there.  Reboot and subsequent remount of the file 
systems frequently failed, and would require complete rebuilding as 
reisferfsck --fix-fixable or -rebuild-tree would not clean it all up.  

Shiftng the RAID from Promise to 3ware stopped corrption on the data drives, 
limiting it to the system drive.  

I then modified the fstab on the system drive to mount the 3ware as the root 
filesystem,  eliminating all data access to the /dev/hda drive after startup, 
and it eliminated the file system corruption completely.

The 3ware controller is a scsi controller that reads and writes to ide drives.  
Whereas the Promise is just anlother ide chip (my understanding).

I tried these experiments under both Debian/2.4.19/ReiserFS and RedHat 
7.3/ext3 with similar results, so I don't think that it is a filesystem 
issue.

It is my opinion based on this data that EITHER the IDE hardware misses 
interrupts or can corrupt data under heavy PCI DMA activity, OR the driver is 
not detecting or handling issues correctly.

I am available to test any patches or ideas that the maintainers might be so 
kind as to offer.




-- 
Joe Briggs
Briggs Media Systems
105 Burnsen Ave.
Manchester NH 01304 USA
TEL/FAX 603-232-3115 MOBILE 603-493-2386
www.briggsmedia.com
