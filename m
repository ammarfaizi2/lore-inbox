Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275745AbRI0ChJ>; Wed, 26 Sep 2001 22:37:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275746AbRI0Cg7>; Wed, 26 Sep 2001 22:36:59 -0400
Received: from adsl-206-170-148-147.dsl.snfc21.pacbell.net ([206.170.148.147]:50953
	"HELO gw.goop.org") by vger.kernel.org with SMTP id <S275745AbRI0Cgp>;
	Wed, 26 Sep 2001 22:36:45 -0400
To: linux-kernel@vger.kernel.org
Subject: 2.4.9: strange stale buffers when reading partition table (USB/SCSI)
Message-ID: <1001558230.3bb290d6a8b8e@www.goop.org>
Date: Wed, 26 Sep 2001 19:37:10 -0700 (PDT)
From: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: jeremy@goop.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: IMP/PHP IMAP webmail program 2.2.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a Sony DSC F505V digital camera, which allows you to download images by
presenting itself as a USB storage device containing a single partition with a
FAT filesystem on it.

The camera is detected by USB, and SCSI will talk to it, but it fails to find
the partition table.  I added some code after the bread() in
fs/partitions/msdos.c:443 to dump the read data, which shows that it is getting
garbage.  It has relation to anything on the actual device, and it changes from
time to time.

The strange thing is that reading the device via /dev/sda works fine.  fdisk
shows a valid partition table, and the partition itself looks fine. 

If I add:

        bh = getblk(dev, 0, get_ptable_blocksize(dev));
        if (bh)
                bforget(bh);

just before the bread(), the bread gets the correct stuff and can read the
partition table.  Everything works fine from there on:

hub.c: USB new device connect on bus1/1, assigned device number 2
scsi0 : SCSI emulation for USB Mass Storage devices
  Vendor: Sony      Model: Sony DSC          Rev: 2.10
  Type:   Direct-Access                      ANSI SCSI revision: 02
Attached scsi removable disk sda at scsi0, channel 0, id 0, lun 0
SCSI device sda: 253696 512-byte hdwr sectors (130 MB)
usb-uhci.c: interrupt, status 3, frame# 207
usb-uhci.c: interrupt, status 3, frame# 213
sda: Write Protect is off
 /dev/scsi/host0/bus0/target0/lun0: p1
WARNING: USB Mass Storage data integrity not assured
USB Mass Storage device found at 2
scsi singledevice 0 0 0 0
usb-uhci.c: interrupt, status 3, frame# 48
...

So it looks like someone is leaking buffers or something.  The bforget() looks
like its simply papering over the symptoms of some other problem, but I don't
know where to start looking.  Perhaps there's a SCSI problem which is leaving
stale blocks around, perhaps related to it being a removeable device?

This is 2.4.9-linus with ext3 (though plain 2.4.9 without ext3 behaves in
exactly the same way).

I haven't tried 2.4.10 yet, but it sounds like everything has changed in this
area anyway...

        J
