Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932132AbVHWL0F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932132AbVHWL0F (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Aug 2005 07:26:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932134AbVHWL0E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Aug 2005 07:26:04 -0400
Received: from defiant.lowpingbastards.de ([213.178.77.226]:37763 "EHLO
	mail.lowpingbastards.de") by vger.kernel.org with ESMTP
	id S932132AbVHWL0D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Aug 2005 07:26:03 -0400
Date: Tue, 23 Aug 2005 13:25:35 +0200
From: Frederik Schueler <fs@lowpingbastards.de>
To: linux-kernel@vger.kernel.org
Subject: new qla2xxx driver breaks SAN setup with 2 controllers
Message-ID: <20050823112535.GB13391@mail.lowpingbastards.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="r5Pyd7+fXNt84Ff3"
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--r5Pyd7+fXNt84Ff3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hello,

we are experiencing problems with the new qlogic driver in 2.6.12 on
a set of servers with qla2310 HBAs.

The problem is as follows:

The Infotrend storage array we are using has two controllers, each
of them has two virtual discs with a couple of partitions exported
as shared storage.

The controllers are linked inside of the storage box, each controller
has one qlogic fabric switch attached, and half of the servers are
connected to the lefthand switch, the other half is connected to the
righthand switch.

Now, with the qlogic driver in 2.6.11.12, we can access all shares
on both controllers from every server, while the new driver allows
only access to the respective controller where the switch is attached
to directly, thus depriving the servers of half of it's shared
storage devices.

Example: on server s05, we have a boot device (lun 3 on primary
controller), and 2 shared storages (lun 9 on primary, lun 10 on
secondary controller).

With 2.6.11.12, this looks as follows:

s05:~# cat /proc/scsi/scsi
Attached devices:
Host: scsi0 Channel: 00 Id: 00 Lun: 03
  Vendor: IFT      Model: A16F-R1211       Rev: 334B
  Type:   Direct-Access                    ANSI SCSI revision: 03
Host: scsi0 Channel: 00 Id: 00 Lun: 09
  Vendor: IFT      Model: A16F-R1211       Rev: 334B
  Type:   Direct-Access                    ANSI SCSI revision: 03
Host: scsi0 Channel: 00 Id: 01 Lun: 10
  Vendor: IFT      Model: A16F-R1211       Rev: 334B
  Type:   Direct-Access                    ANSI SCSI revision: 03


and the driver sees everything:

s05:~# cat /proc/scsi/qla2xxx/0
QLogic PCI to Fibre Channel Host Adapter for QLA2310:
        Firmware version 3.03.08 IPX, Driver version 8.00.02b4-k
ISP: ISP2300, Serial# R74545
Request Queue =3D 0xcf940000, Response Queue =3D 0xcf980000
Request Queue count =3D 2048, Response Queue count =3D 512
Total number of active commands =3D 0
Total number of interrupts =3D 1117762
    Device queue depth =3D 0x20
Number of free request entries =3D 964
Number of mailbox timeouts =3D 0
Number of ISP aborts =3D 0
Number of loop resyncs =3D 0
Number of retries for empty slots =3D 0
Number of reqs in pending_q=3D 0, retry_q=3D 0, done_q=3D 0, scsi_retry_q=
=3D 0
Host adapter:loop state =3D <READY>, flags =3D 0x1a03
Dpc flags =3D 0x0
MBX flags =3D 0x0
Link down Timeout =3D 030
Port down retry =3D 030
Login retry count =3D 030
Commands retried with dropped frame(s) =3D 0
Product ID =3D 4953 5020 2020 0001


SCSI Device Information:
scsi-qla0-adapter-node=3D200000e08b1bd113;
scsi-qla0-adapter-port=3D210000e08b1bd113;
scsi-qla0-target-0=3D210000d023800002;
scsi-qla0-target-1=3D210000d023600002;

SCSI LUN Information:
(Id:Lun)  * - indicates lun is not registered with the OS.
( 0: 0): Total reqs 2, Pending reqs 0, flags 0x0*, 0:0:81 00
( 0: 3): Total reqs 470693, Pending reqs 0, flags 0x0, 0:0:81 00
( 0: 9): Total reqs 227717, Pending reqs 0, flags 0x0, 0:0:81 00
( 0:11): Total reqs 0, Pending reqs 0, flags 0x0*, 0:0:81 00
( 0:13): Total reqs 0, Pending reqs 0, flags 0x0*, 0:0:81 00
( 1: 0): Total reqs 2, Pending reqs 0, flags 0x0*, 0:0:82 00
( 1:10): Total reqs 12, Pending reqs 0, flags 0x0, 0:0:82 00
( 1:12): Total reqs 0, Pending reqs 0, flags 0x0*, 0:0:82 00
( 1:14): Total reqs 0, Pending reqs 0, flags 0x0*, 0:0:82 00


while on 2.6.12.5 and 2.6.13-rc6 it looks like this:

sm05:~# scsiadd -a 0 0 0 9
Attached devices:
Host: scsi0 Channel: 00 Id: 00 Lun: 03
  Vendor: IFT      Model: A16F-R1211       Rev: 334B
  Type:   Direct-Access                    ANSI SCSI revision: 03
Host: scsi0 Channel: 00 Id: 00 Lun: 09
  Vendor: IFT      Model: A16F-R1211       Rev: 334B
  Type:   Direct-Access                    ANSI SCSI revision: 03


sm05:~# scsiadd -a 0 0 1 10
Attached devices:
Host: scsi0 Channel: 00 Id: 00 Lun: 03
  Vendor: IFT      Model: A16F-R1211       Rev: 334B
  Type:   Direct-Access                    ANSI SCSI revision: 03
Host: scsi0 Channel: 00 Id: 00 Lun: 09
  Vendor: IFT      Model: A16F-R1211       Rev: 334B
  Type:   Direct-Access                    ANSI SCSI revision: 03


unfortunately, the proc interface was removed:

s05:/sys/devices/pci0000:00/0000:00:02.0/0000:01:00.0/0000:02:02.0/host0#
find .
=2E
=2E/rport-0:0-1
=2E/rport-0:0-1/power
=2E/rport-0:0-1/power/state
=2E/rport-0:0-0
=2E/rport-0:0-0/target0:0:0
=2E/rport-0:0-0/target0:0:0/0:0:0:9
=2E/rport-0:0-0/target0:0:0/0:0:0:9/ioerr_cnt
=2E/rport-0:0-0/target0:0:0/0:0:0:9/iodone_cnt
=2E/rport-0:0-0/target0:0:0/0:0:0:9/iorequest_cnt
=2E/rport-0:0-0/target0:0:0/0:0:0:9/iocounterbits
=2E/rport-0:0-0/target0:0:0/0:0:0:9/timeout
=2E/rport-0:0-0/target0:0:0/0:0:0:9/state
=2E/rport-0:0-0/target0:0:0/0:0:0:9/delete
=2E/rport-0:0-0/target0:0:0/0:0:0:9/rescan
=2E/rport-0:0-0/target0:0:0/0:0:0:9/rev
=2E/rport-0:0-0/target0:0:0/0:0:0:9/model
=2E/rport-0:0-0/target0:0:0/0:0:0:9/vendor
=2E/rport-0:0-0/target0:0:0/0:0:0:9/scsi_level
=2E/rport-0:0-0/target0:0:0/0:0:0:9/type
=2E/rport-0:0-0/target0:0:0/0:0:0:9/queue_type
=2E/rport-0:0-0/target0:0:0/0:0:0:9/queue_depth
=2E/rport-0:0-0/target0:0:0/0:0:0:9/device_blocked
=2E/rport-0:0-0/target0:0:0/0:0:0:9/bus
=2E/rport-0:0-0/target0:0:0/0:0:0:9/driver
=2E/rport-0:0-0/target0:0:0/0:0:0:9/block
=2E/rport-0:0-0/target0:0:0/0:0:0:9/power
=2E/rport-0:0-0/target0:0:0/0:0:0:9/power/state
=2E/rport-0:0-0/target0:0:0/0:0:0:3
=2E/rport-0:0-0/target0:0:0/0:0:0:3/ioerr_cnt
=2E/rport-0:0-0/target0:0:0/0:0:0:3/iodone_cnt
=2E/rport-0:0-0/target0:0:0/0:0:0:3/iorequest_cnt
=2E/rport-0:0-0/target0:0:0/0:0:0:3/iocounterbits
=2E/rport-0:0-0/target0:0:0/0:0:0:3/timeout
=2E/rport-0:0-0/target0:0:0/0:0:0:3/state
=2E/rport-0:0-0/target0:0:0/0:0:0:3/delete
=2E/rport-0:0-0/target0:0:0/0:0:0:3/rescan
=2E/rport-0:0-0/target0:0:0/0:0:0:3/rev
=2E/rport-0:0-0/target0:0:0/0:0:0:3/model
=2E/rport-0:0-0/target0:0:0/0:0:0:3/vendor
=2E/rport-0:0-0/target0:0:0/0:0:0:3/scsi_level
=2E/rport-0:0-0/target0:0:0/0:0:0:3/type
=2E/rport-0:0-0/target0:0:0/0:0:0:3/queue_type
=2E/rport-0:0-0/target0:0:0/0:0:0:3/queue_depth
=2E/rport-0:0-0/target0:0:0/0:0:0:3/device_blocked
=2E/rport-0:0-0/target0:0:0/0:0:0:3/bus
=2E/rport-0:0-0/target0:0:0/0:0:0:3/driver
=2E/rport-0:0-0/target0:0:0/0:0:0:3/block
=2E/rport-0:0-0/target0:0:0/0:0:0:3/power
=2E/rport-0:0-0/target0:0:0/0:0:0:3/power/state
=2E/rport-0:0-0/target0:0:0/power
=2E/rport-0:0-0/target0:0:0/power/state
=2E/rport-0:0-0/power
=2E/rport-0:0-0/power/state
=2E/nvram
=2E/fw_dump
=2E/power
=2E/power/state


apparently the targets on rport-0:0-1 are not scanned at all, and
so the devices on the secondary controller are not reachable.

placing an additional link between the two fabric switches did
double the amount of targets, but not solve our problem.
It seems to us the 2.6.12+ driver does not allow access to
controllers not directly attached to the very same fabric switch.

how can this be fixed?


Best regards
Frederik Schueler

--=20
ENOSIG

--r5Pyd7+fXNt84Ff3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFDCwev6n7So0GVSSARAmVCAJ0TK54zvXkHBbUnyzNWMJTtRNPMlgCeODAG
cSuijmUp4JJfegDp4XQ2pOQ=
=uKiP
-----END PGP SIGNATURE-----

--r5Pyd7+fXNt84Ff3--
