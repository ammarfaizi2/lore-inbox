Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274596AbRJAGEi>; Mon, 1 Oct 2001 02:04:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274612AbRJAGE2>; Mon, 1 Oct 2001 02:04:28 -0400
Received: from codepoet.org ([166.70.14.212]:2679 "HELO winder.codepoet.org")
	by vger.kernel.org with SMTP id <S274596AbRJAGEP>;
	Mon, 1 Oct 2001 02:04:15 -0400
Date: Mon, 1 Oct 2001 00:04:46 -0600
From: Erik Andersen <andersen@codepoet.org>
To: Alexander Viro <viro@math.psu.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [CFT][PATCH] cleanup of partition code
Message-ID: <20011001000446.A24245@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: Erik Andersen <andersen@codepoet.org>,
	Alexander Viro <viro@math.psu.edu>, linux-kernel@vger.kernel.org
In-Reply-To: <20010930222210.A24037@codepoet.org> <Pine.GSO.4.21.0110010126001.14026-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.21.0110010126001.14026-100000@weyl.math.psu.edu>
User-Agent: Mutt/1.3.22i
X-Operating-System: Linux 2.4.9-ac10-rmk1, Rebel-NetWinder(Intel sa110 rev 3), 262.14 BogoMips
X-No-Junk-Mail: I do not want to get *any* junk mail.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon Oct 01, 2001 at 01:27:54AM -0400, Alexander Viro wrote:
> 
> 
> On Sun, 30 Sep 2001, Erik Andersen wrote:
> 
> > On Sun Sep 30, 2001 at 06:31:55PM -0400, Alexander Viro wrote:
> > > 
> > > 	One thing that doesn't work yet is support of Acorn partitions -
> > > I'm switching it to pagecache right now.
> > 
> > Well, acorn is broken anyways....  Try enabling in on a device
> > with native 2048 byte sectors and _no_ partition table will be
> > found on those devices (just an error msg resulting from acorn)
> 
> Could you send me an example of such animal?  I don't mean the disk itself -
> just the contents of relevant sectors (i.e. everything except the contents
> of partitions themselves).

Here is what I normally see (in this case with 2.4.9-ac17):

	scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.1
		<Adaptec 2940 Ultra SCSI adapter>
		aic7880: Ultra Single Channel A, SCSI Id=7, 16/255 SCBs

	(scsi0:A:4): 10.000MB/s transfers (10.000MHz, offset 15)
	  Vendor: OLYMPUS   Model: MOS364            Rev: 1.02
	  Type:   Optical Device                     ANSI SCSI revision: 02
	(scsi0:A:5): 10.000MB/s transfers (10.000MHz, offset 15)
	  Vendor: OLYMPUS   Model: MOS364            Rev: 1.02
	  Type:   Optical Device                     ANSI SCSI revision: 02
	[----------snip-------------]
	Attached scsi removable disk sda at scsi0, channel 0, id 4, lun 0
	Attached scsi removable disk sdb at scsi0, channel 0, id 5, lun 0
	SCSI device sda: 310352 2048-byte hdwr sectors (636 MB)
	sda: Write Protect is off
	 sda: sda1
	SCSI device sdb: 310352 2048-byte hdwr sectors (636 MB)
	sdb: Write Protect is off
	 sdb: sdb1

Everything looks fairly normal...  I have 2 640Meg SCSI magneto optical drives
with a single partiton on the media in each (working as expected).  Now lets
enable some stuff: 

	+CONFIG_ACORN_PARTITION=y
	+CONFIG_ACORN_PARTITION_ICS=y
	+CONFIG_ACORN_PARTITION_ADFS=y
	+CONFIG_ACORN_PARTITION_POWERTEC=y
	+CONFIG_ACORN_PARTITION_RISCIX=y


Now I see:

	Attached scsi removable disk sda at scsi0, channel 0, id 4, lun 0
	Attached scsi removable disk sdb at scsi0, channel 0, id 5, lun 0
	SCSI device sda: 310352 2048-byte hdwr sectors (636 MB)
	sda: Write Protect is off
	 sda:<5>ll_rw_block: device 08:00: only 2048-char blocks implemented (1024)
	 unable to read boot sectors / partition sectors
	SCSI device sdb: 310352 2048-byte hdwr sectors (636 MB)
	sdb: Write Protect is off
	 sdb:<5>ll_rw_block: device 08:10: only 2048-char blocks implemented (1024)
	 unable to read boot sectors / partition sectors

Note the ll_rw_block msg from where the acorn stuff is not reading in units
of the physical sector size?  Also notice the "unable to read..." msg, which
is where acorn chokes the partition table scanning...


So now, while fdisk is still able to see that partitions exist

	[andersen@dillweed andersen]$ fdisk -l /dev/sda
	Note: sector size is 2048 (not 512)

	Disk /dev/sda: 64 heads, 32 sectors, 151 cylinders
	Units = cylinders of 2048 * 2048 bytes

	   Device Boot    Start       End    Blocks   Id  System
	/dev/sda1   *         1       151    618432   83  Linux

the acorn stuff has caused the partition scan to abort prematurely, such that
proc partitions (and Linux) know nothing about the device's partitions.  I can
give you a dd from one of these disks, but I doubt that would show the error... 

 -Erik

--
Erik B. Andersen   email:  andersee@debian.org, formerly of Lineo
--This message was written using 73% post-consumer electrons--
