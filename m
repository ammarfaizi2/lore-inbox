Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317004AbSFQUgy>; Mon, 17 Jun 2002 16:36:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317003AbSFQUgs>; Mon, 17 Jun 2002 16:36:48 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:10944 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S316996AbSFQUfq>;
	Mon, 17 Jun 2002 16:35:46 -0400
Date: Mon, 17 Jun 2002 13:35:34 -0700
From: Patrick Mansfield <patmans@us.ibm.com>
To: Kurt Garloff <garloff@suse.de>,
       Linux kernel list <linux-kernel@vger.kernel.org>,
       Linux SCSI list <linux-scsi@vger.kernel.org>
Subject: Re: /proc/scsi/map
Message-ID: <20020617133534.A10174@eng2.beaverton.ibm.com>
References: <20020615133606.GC11016@gum01m.etpnet.phys.tue.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20020615133606.GC11016@gum01m.etpnet.phys.tue.nl>; from garloff@suse.de on Sat, Jun 15, 2002 at 03:36:06PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 15, 2002 at 03:36:06PM +0200, Kurt Garloff wrote:
> Life would be easier if the scsi subsystem would just report which SCSI
> device (uniquely identified by the controller,bus,target,unit tuple) belongs
> to which high-level device. The information is available in the kernel.

I prefer we refer to the tuple as host, channel, id, lun (H, C, I, L), so
as to more closely match /proc/scsi/scsi, /proc/scsi/sg, and attached
messages:

[root@elm3a50 root]# cat /proc/scsi/scsi | head -4
Attached devices: 
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: IBM-PSG  Model: ST318203LC    !# Rev: B222
  Type:   Direct-Access                    ANSI SCSI revision: 02

root # cat /proc/scsi/sg/device_hdr  /proc/scsi/sg/devices | head -2
host    chan    id      lun     type    opens   qdepth  busy    online
0       0       0       0       0       4       253     0       1

Attached messages are of the form:

Attached scsi disk sdn at scsi2, channel 0, id 2, lun 0

> Attached patch does this:
> garloff@pckurt:/raid5/Kernel/src $ cat /proc/scsi/map 
> # C,B,T,U       Type    onl     sg_nm   sg_dev  nm      dev(hex)
> 0,0,00,00       0x05    1       sg0     c:15:00 sr0     b:0b:00
> 1,0,01,00       0x05    1       sg1     c:15:01 sr1     b:0b:01
> 1,0,02,00       0x01    1       sg2     c:15:02 osst0   c:ce:00
> 1,0,03,00       0x05    1       sg3     c:15:03 sr2     b:0b:02
> 1,0,05,00       0x00    1       sg4     c:15:04 sda     b:08:00
> 1,0,09,00       0x00    1       sg5     c:15:05 sdb     b:08:10
> 2,0,01,00       0x05    1       sg6     c:15:06 sr3     b:0b:03
> 2,0,02,00       0x01    1       sg7     c:15:07 osst1   c:ce:01
> 2,0,03,00       0x05    1       sg8     c:15:08 sr4     b:0b:04
> 2,0,05,00       0x00    1       sg9     c:15:09 sdc     b:08:20
> 2,0,09,00       0x00    1       sg10    c:15:0a sdd     b:08:30
> 3,0,10,00       0x00    1       sg11    c:15:0b sde     b:08:40
> 3,0,12,00       0x00    1       sg12    c:15:0c sdf     b:08:50

Why not treat each upper layer driver the same? Type is already
in /proc/scsi/scsi, or implied by the upper level drivers attached.
Online should really be part of /proc/scsi/scsi.

Then, each line is a path followed by a list of upper level devices.
This would also simplify the code, although the ordering of the upper
level devices becomes link or module load order dependent.

And similiar to sg (someone commented on parsing '^#'), have a _hdr
entry; something like:

$ cat /proc/scsi/map_hdr /proc/scsi/map

H:C:I:L      online  type:name:block/char:maj:min
00:00:00:00     1       sg:sg0:c:15:00      sr:sr0:b:0b:00
01:00:01:00     1       sg:sg1:c:15:01      sr:sr1:b:0b:01
01:00:02:00     1       sg:sg2:c:15:02      osst:osst0:c:ce:00
02:00:09:00     1       sg:sg3:c:15:03      sd:sdd:b:08:30

Or:

H:C:I:L      online  type:enumeration:block/char:maj:min
00:00:00:00     1      sg:0:c:15:00      sr:0:b:0b:00
01:00:01:00     1      sg:1:c:15:01      sr:1:b:0b:01
01:00:02:00     1      sg:2:c:15:02      osst:0:c:ce:00
02:00:09:00     1      sg:3:c:15:03      sd:d:b:08:30


> A patch for 2.5 should be done as well, if the design is OK, of course.
> 

IMO, we should use driverfs for this in 2.5. Mike Sullivan's scsi driverfs
patch currently ends up with a driverfs layout (showing one Scsi_Device
with two partitions, sg and sd attached) like this:

[root@elm3a50 devices]# tree ./root/pci1/01\:06.0/scsi2/2\:0\:2\:0/
./root/pci1/01:06.0/scsi2/2:0:2:0/
|-- 2:0:2:0:disc
|   |-- kdev
|   |-- name
|   |-- power
|   `-- type
|-- 2:0:2:0:gen
|   |-- kdev
|   |-- name
|   |-- power
|   `-- type
|-- 2:0:2:0:p1
|   |-- kdev
|   |-- name
|   |-- power
|   `-- type
|-- 2:0:2:0:p2
|   |-- kdev
|   |-- name
|   |-- power
|   `-- type
|-- name
|-- power
`-- type

Right now, the name is storing an ID; the ID is retrieved in the kernel (using
page 0x80 or page 0x83 or the path). For example disc has:

[root@elm3a50 2:0:2:0:disc]# pwd
/devices/root/pci1/01:06.0/scsi2/2:0:2:0/2:0:2:0:disc
[root@elm3a50 2:0:2:0:disc]# ls  
kdev  name  power  type
[root@elm3a50 2:0:2:0:disc]# cat *
8d0
U20000020371719e8disc
0
BLK

-- Patrick Mansfield
