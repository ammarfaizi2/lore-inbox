Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932365AbVHWUAu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932365AbVHWUAu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Aug 2005 16:00:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932362AbVHWUAu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Aug 2005 16:00:50 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.142]:17070 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932353AbVHWUAt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Aug 2005 16:00:49 -0400
Date: Tue, 23 Aug 2005 13:00:40 -0700
From: Patrick Mansfield <patmans@us.ibm.com>
To: Frederik Schueler <fs@lowpingbastards.de>
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: new qla2xxx driver breaks SAN setup with 2 controllers
Message-ID: <20050823200040.GA8310@us.ibm.com>
References: <20050823112535.GB13391@mail.lowpingbastards.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050823112535.GB13391@mail.lowpingbastards.de>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 23, 2005 at 01:25:35PM +0200, Frederik Schueler wrote:
> hello,
> 
> we are experiencing problems with the new qlogic driver in 2.6.12 on
> a set of servers with qla2310 HBAs.
> 
> The problem is as follows:
> 
> The Infotrend storage array we are using has two controllers, each
> of them has two virtual discs with a couple of partitions exported
> as shared storage.
> 
> The controllers are linked inside of the storage box, each controller
> has one qlogic fabric switch attached, and half of the servers are
> connected to the lefthand switch, the other half is connected to the
> righthand switch.
> 
> Now, with the qlogic driver in 2.6.11.12, we can access all shares
> on both controllers from every server, while the new driver allows
> only access to the respective controller where the switch is attached
> to directly, thus depriving the servers of half of it's shared
> storage devices.
> 
> Example: on server s05, we have a boot device (lun 3 on primary
> controller), and 2 shared storages (lun 9 on primary, lun 10 on
> secondary controller).

The use of scsiadd script implies that you are attaching or somehow
modifying the storage after the driver has loaded. Is that correct?

There is a fix for scanning initiated via user space, this change:

http://www.kernel.org/git/?p=linux/kernel/git/jejb/scsi-rc-fixes-2.6.git;a=commit;h=5c44cd2afad3f7b015542187e147a820600172f1

The above fix is in the current 2.6 git tree. Does that fix your problem?

If so, reloading the driver should also rescan correctly (even in
2.6.12.5).

unplugging/plugging the cable might also fix the problem.

> With 2.6.11.12, this looks as follows:
> 
> s05:~# cat /proc/scsi/scsi
> Attached devices:
> Host: scsi0 Channel: 00 Id: 00 Lun: 03
>   Vendor: IFT      Model: A16F-R1211       Rev: 334B
>   Type:   Direct-Access                    ANSI SCSI revision: 03
> Host: scsi0 Channel: 00 Id: 00 Lun: 09
>   Vendor: IFT      Model: A16F-R1211       Rev: 334B
>   Type:   Direct-Access                    ANSI SCSI revision: 03
> Host: scsi0 Channel: 00 Id: 01 Lun: 10
>   Vendor: IFT      Model: A16F-R1211       Rev: 334B
>   Type:   Direct-Access                    ANSI SCSI revision: 03
> 
> 
> and the driver sees everything:
> 
> s05:~# cat /proc/scsi/qla2xxx/0
> QLogic PCI to Fibre Channel Host Adapter for QLA2310:
>         Firmware version 3.03.08 IPX, Driver version 8.00.02b4-k
> ISP: ISP2300, Serial# R74545
> Request Queue = 0xcf940000, Response Queue = 0xcf980000
> Request Queue count = 2048, Response Queue count = 512
> Total number of active commands = 0
> Total number of interrupts = 1117762
>     Device queue depth = 0x20
> Number of free request entries = 964
> Number of mailbox timeouts = 0
> Number of ISP aborts = 0
> Number of loop resyncs = 0
> Number of retries for empty slots = 0
> Number of reqs in pending_q= 0, retry_q= 0, done_q= 0, scsi_retry_q= 0
> Host adapter:loop state = <READY>, flags = 0x1a03
> Dpc flags = 0x0
> MBX flags = 0x0
> Link down Timeout = 030
> Port down retry = 030
> Login retry count = 030
> Commands retried with dropped frame(s) = 0
> Product ID = 4953 5020 2020 0001
> 
> 
> SCSI Device Information:
> scsi-qla0-adapter-node=200000e08b1bd113;
> scsi-qla0-adapter-port=210000e08b1bd113;
> scsi-qla0-target-0=210000d023800002;
> scsi-qla0-target-1=210000d023600002;
> 
> SCSI LUN Information:
> (Id:Lun)  * - indicates lun is not registered with the OS.
> ( 0: 0): Total reqs 2, Pending reqs 0, flags 0x0*, 0:0:81 00
> ( 0: 3): Total reqs 470693, Pending reqs 0, flags 0x0, 0:0:81 00
> ( 0: 9): Total reqs 227717, Pending reqs 0, flags 0x0, 0:0:81 00
> ( 0:11): Total reqs 0, Pending reqs 0, flags 0x0*, 0:0:81 00
> ( 0:13): Total reqs 0, Pending reqs 0, flags 0x0*, 0:0:81 00
> ( 1: 0): Total reqs 2, Pending reqs 0, flags 0x0*, 0:0:82 00
> ( 1:10): Total reqs 12, Pending reqs 0, flags 0x0, 0:0:82 00
> ( 1:12): Total reqs 0, Pending reqs 0, flags 0x0*, 0:0:82 00
> ( 1:14): Total reqs 0, Pending reqs 0, flags 0x0*, 0:0:82 00
> 
> 
> while on 2.6.12.5 and 2.6.13-rc6 it looks like this:
> 
> sm05:~# scsiadd -a 0 0 0 9
> Attached devices:
> Host: scsi0 Channel: 00 Id: 00 Lun: 03
>   Vendor: IFT      Model: A16F-R1211       Rev: 334B
>   Type:   Direct-Access                    ANSI SCSI revision: 03
> Host: scsi0 Channel: 00 Id: 00 Lun: 09
>   Vendor: IFT      Model: A16F-R1211       Rev: 334B
>   Type:   Direct-Access                    ANSI SCSI revision: 03
> 
> 
> sm05:~# scsiadd -a 0 0 1 10
> Attached devices:
> Host: scsi0 Channel: 00 Id: 00 Lun: 03
>   Vendor: IFT      Model: A16F-R1211       Rev: 334B
>   Type:   Direct-Access                    ANSI SCSI revision: 03
> Host: scsi0 Channel: 00 Id: 00 Lun: 09
>   Vendor: IFT      Model: A16F-R1211       Rev: 334B
>   Type:   Direct-Access                    ANSI SCSI revision: 03
> 
> 
> unfortunately, the proc interface was removed:

Why, is some data missing?

Also try using lsscsi.

> s05:/sys/devices/pci0000:00/0000:00:02.0/0000:01:00.0/0000:02:02.0/host0#
> find .
> .
> ./rport-0:0-1
> ./rport-0:0-1/power
> ./rport-0:0-1/power/state
> ./rport-0:0-0
> ./rport-0:0-0/target0:0:0
> ./rport-0:0-0/target0:0:0/0:0:0:9
> ./rport-0:0-0/target0:0:0/0:0:0:9/ioerr_cnt
> ./rport-0:0-0/target0:0:0/0:0:0:9/iodone_cnt
> ./rport-0:0-0/target0:0:0/0:0:0:9/iorequest_cnt
> ./rport-0:0-0/target0:0:0/0:0:0:9/iocounterbits
> ./rport-0:0-0/target0:0:0/0:0:0:9/timeout
> ./rport-0:0-0/target0:0:0/0:0:0:9/state
> ./rport-0:0-0/target0:0:0/0:0:0:9/delete
> ./rport-0:0-0/target0:0:0/0:0:0:9/rescan
> ./rport-0:0-0/target0:0:0/0:0:0:9/rev
> ./rport-0:0-0/target0:0:0/0:0:0:9/model
> ./rport-0:0-0/target0:0:0/0:0:0:9/vendor
> ./rport-0:0-0/target0:0:0/0:0:0:9/scsi_level
> ./rport-0:0-0/target0:0:0/0:0:0:9/type
> ./rport-0:0-0/target0:0:0/0:0:0:9/queue_type
> ./rport-0:0-0/target0:0:0/0:0:0:9/queue_depth
> ./rport-0:0-0/target0:0:0/0:0:0:9/device_blocked
> ./rport-0:0-0/target0:0:0/0:0:0:9/bus
> ./rport-0:0-0/target0:0:0/0:0:0:9/driver
> ./rport-0:0-0/target0:0:0/0:0:0:9/block
> ./rport-0:0-0/target0:0:0/0:0:0:9/power
> ./rport-0:0-0/target0:0:0/0:0:0:9/power/state
> ./rport-0:0-0/target0:0:0/0:0:0:3
> ./rport-0:0-0/target0:0:0/0:0:0:3/ioerr_cnt
> ./rport-0:0-0/target0:0:0/0:0:0:3/iodone_cnt
> ./rport-0:0-0/target0:0:0/0:0:0:3/iorequest_cnt
> ./rport-0:0-0/target0:0:0/0:0:0:3/iocounterbits
> ./rport-0:0-0/target0:0:0/0:0:0:3/timeout
> ./rport-0:0-0/target0:0:0/0:0:0:3/state
> ./rport-0:0-0/target0:0:0/0:0:0:3/delete
> ./rport-0:0-0/target0:0:0/0:0:0:3/rescan
> ./rport-0:0-0/target0:0:0/0:0:0:3/rev
> ./rport-0:0-0/target0:0:0/0:0:0:3/model
> ./rport-0:0-0/target0:0:0/0:0:0:3/vendor
> ./rport-0:0-0/target0:0:0/0:0:0:3/scsi_level
> ./rport-0:0-0/target0:0:0/0:0:0:3/type
> ./rport-0:0-0/target0:0:0/0:0:0:3/queue_type
> ./rport-0:0-0/target0:0:0/0:0:0:3/queue_depth
> ./rport-0:0-0/target0:0:0/0:0:0:3/device_blocked
> ./rport-0:0-0/target0:0:0/0:0:0:3/bus
> ./rport-0:0-0/target0:0:0/0:0:0:3/driver
> ./rport-0:0-0/target0:0:0/0:0:0:3/block
> ./rport-0:0-0/target0:0:0/0:0:0:3/power
> ./rport-0:0-0/target0:0:0/0:0:0:3/power/state
> ./rport-0:0-0/target0:0:0/power
> ./rport-0:0-0/target0:0:0/power/state
> ./rport-0:0-0/power
> ./rport-0:0-0/power/state
> ./nvram
> ./fw_dump
> ./power
> ./power/state
> 
> 
> apparently the targets on rport-0:0-1 are not scanned at all, and
> so the devices on the secondary controller are not reachable.
> 
> placing an additional link between the two fabric switches did
> double the amount of targets, but not solve our problem.
> It seems to us the 2.6.12+ driver does not allow access to
> controllers not directly attached to the very same fabric switch.
> 
> how can this be fixed?
> 
> 
> Best regards
> Frederik Schueler

-- Patrick Mansfield
