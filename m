Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265132AbSLBXXV>; Mon, 2 Dec 2002 18:23:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265134AbSLBXXV>; Mon, 2 Dec 2002 18:23:21 -0500
Received: from imrelay-2.zambeel.com ([209.240.48.8]:26898 "EHLO
	imrelay-2.zambeel.com") by vger.kernel.org with ESMTP
	id <S265132AbSLBXXU>; Mon, 2 Dec 2002 18:23:20 -0500
Message-ID: <233C89823A37714D95B1A891DE3BCE5202AB1A67@xch-a.win.zambeel.com>
From: Manish Lachwani <manish@Zambeel.com>
To: "'John Bradford'" <john@grabjohn.com>, linux-kernel@vger.kernel.org
Subject: RE: More intellegent bad block reallocation in software?
Date: Mon, 2 Dec 2002 15:30:14 -0800 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The remapping of bad sectors is a house-keeping function of the drive. By
default, every drive supports this. If a drive is unable to remap a sector
(due to physical defect/lack of spares/schedule later), it becomes a pending
sector. This can be taken care of in the software by writing to that sector
and leaving it upto the drive to remap this sector. 

Different drives have different remapping strategy. Some drives allocate
zone based spares in which case the latency involved in fetching the spare
sector is anyway lesser. 

By removing this check of a bad sector from the drive, you will need to
implement a similar algorithm in the software. IMHO, this itself might
introduce latencies. You can write a disk scrubber sort of application which
reads every sector and then checks some stats (like READ times) and decides
whether that needs to be remapped or not. In any case, this would certainly
require a custom firmware to turn off this check. 



-----Original Message-----
From: John Bradford [mailto:john@grabjohn.com]
Sent: Monday, December 02, 2002 3:20 PM
To: linux-kernel@vger.kernel.org
Subject: More intellegent bad block reallocation in software?


Is it possible, or at least feasible for certain disk devices, to
disable the firmware-level re-allocation of bad blocks, (note: I am
aware that disks typically have many bad blocks that are reliant on
ECC to function - I am refering to completely bad blocks, that are
replaced with a 'spare' block), and do this in software?

The reason I'm asking, is because presumably the 'spare' blocks are
kept at the end or the disk, or at least all in one place, (or
possibly throughout the disk in each ZBR zone).  If this is the case,
then reading a single large file which is, according to the
filesystem, all in consecutive blocks, could involve several seeks to
the area where the spare blocks are.

My idea is that we could allocate one block out of every ten to be a
spare block, (which would reduce disk capacity by 10%), and then if a
block needed to be re-allocated, we could allocate one from the same
cylinder, therefore removing the need for the heads to seek across the
disk.

How easily could this be added to existing filesystems?  Presumably
we'd need extra functionality in both filesystem code and the IDE and
SCSI code, and I realise that it might be completely impossible,
without custom firmware on the disk.  It's an interesting idea
though.

John.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
