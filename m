Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262956AbVD2UUG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262956AbVD2UUG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Apr 2005 16:20:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262950AbVD2URu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Apr 2005 16:17:50 -0400
Received: from hg-msq-srv.levigo.de ([62.206.214.5]:31239 "EHLO mail.levigo.de")
	by vger.kernel.org with ESMTP id S262949AbVD2UQy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Apr 2005 16:16:54 -0400
Message-ID: <4272962B.9000502@levigo.de>
Date: Fri, 29 Apr 2005 22:16:43 +0200
From: =?ISO-8859-1?Q?J=F6rg_Henne?= <j.henne@levigo.de>
Organization: levigo software gmbh
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: de, de-at, en, en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Spurious disk change detections interferes with disk access
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

using a CompactFlash based system, I am experiencing a very weird 
behaviour I just don't understand.

The system is based on
- 2.4.28
- devfs
- a CompactFlash IDE drive attached to a real IDE controller (in 
contrast to a PC-Card adapter)
- the root filesystem resides on the CF

While booting, there are irregular but frequent errors which manifest in 
messages like
    hda1: bad access: block=<something> count=<something>
which are followed by error messages from the filesystem and finally 
errors in the boot process itself.

I added some more debug output to drivers/ide/ide-io.c and found that 
while the block offset was well within the nominal bounds of the device, 
the message was actually caused by the fact that while the error 
occurred, the partition table was all zeroed-out, i.e. 
drive->part[minor&PARTN_MASK].nr_sects == 0.
The reason why the drive's partition table is zeroed-out temporarily 
seems to be that there is an ide_revalidate_disk() going on at that 
time, which in turn is explained by messages like
    VFS: Disk change detected on device 03:00
     /dev/ide/host0/bus0/target0/lun0: p1 p2
which precede the "bad access" message.

As I see it, the core of the problem is:
- something accesses the devfs directory associated with the drive (ls 
/dev/ide/host0/bus0/target0/lun0 will do)
- defvs runs a check_media_change which ends up at 
ide-disk.c:idedisk_media_change() which is implemented like this:
     /* if removable, always assume it was changed */
        return drive->removable;
- devfs decides that a revalidate is appropriate since the media hash 
changed, which trashes the partition table for a brief moment
- processes accessing the drive at that time see lots of errors

Is it really true, that for removable devices, a simple directory access 
on the devfs can interfere with accesses to the drive? Sounds like a 
great start for DOSing the system.
I see two possible solutions for the problem:
- A lock is put in place which guards access to the drive while the 
partition table is re-built. Seems fairly hacky to me.
- The media change detection mechanism is improved, so that it can 
detect when the media REALLY changed.

Thanks in advance for any input on this.
Joerg Henne

