Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S131237AbQK0Ome>; Mon, 27 Nov 2000 09:42:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S131398AbQK0OmY>; Mon, 27 Nov 2000 09:42:24 -0500
Received: from p3EE3C9DF.dip.t-dialin.net ([62.227.201.223]:3844 "HELO
        emma1.emma.line.org") by vger.kernel.org with SMTP
        id <S131237AbQK0OmG>; Mon, 27 Nov 2000 09:42:06 -0500
Date: Mon, 27 Nov 2000 08:57:03 +0100
From: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
To: Kurt Garloff <garloff@suse.de>
Cc: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [2.2.17] oops in /proc/scsi/scsi
Message-ID: <20001127085703.A535@emma1.emma.line.org>
Mail-Followup-To: Kurt Garloff <garloff@suse.de>,
        Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <20001122020618.A1411@emma1.emma.line.org> <20001123010712.C32555@garloff.etpnet.phys.tue.nl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
        protocol="application/pgp-signature"; boundary="n8g4imXOkfNTN/H1"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20001123010712.C32555@garloff.etpnet.phys.tue.nl>; from garloff@suse.de on Thu, Nov 23, 2000 at 01:07:12 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--n8g4imXOkfNTN/H1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Kurt Garloff schrieb am Donnerstag, den 23. November 2000:

> On Wed, Nov 22, 2000 at 02:06:18AM +0100, Matthias Andree wrote:
> > I ran that script several times since it did not collect all devices,
>=20
> Strange.
>=20

> While 2.0e3 contains a bug that can cause an OOps inside the driver (just
> use the echo "INQUIRY 0" >/proc/scsi/tmscsim/?), the normal bus rescanning
> should not be able to trigger it. The above looks like the bug is occuring
> somewhere else.
> Having said this, I'd like to ask you to try 2.0e6 of the tmscsim driver =
and
> check whether you are able to reproduce the bug.

Good thing first: I can't trigger the oopses with 2.0e6. I tried hard, didn=
't
manage to.

However, trying to trigger a race condition, I found that your script suffe=
rs
from too small a kernel API in this place, since it uses the
remove-single-device and all-single-devices in a non-locked manner, so if y=
ou
run several instances of your script in parallel (simple rescan-scsi-bus.sh=
 -r
& will do) it will give a mess and may leave you with missing devices.

I don't currently recall if your web site states that your script may only =
be
run once at the same time; lock files would be nice :-]

To recall my devices:
#2 Plextor PX-32TS 1.02
#3 Yamaha CRW4416S 1.0j
#4 HP 35480A 12.09
#5 Plextor PX-20TS 1.00
#6 Tandberg TDC4222

The first run of your rescan-scsi-script showed that the "scsi
singledevice 1 0 2 0" command was aborted due to timeout, and the
Plextor PX-32TS is known to require at least 5 s settling time after a
bus reset in my Tekram DC-390U (SYM53C875) BIOS, so it may actually be the
drive itself that gives us headaches.

Result of first rescan-scsi-bus.sh -r:
all 5 devices removed, and only #3 ... #6 added (#2, Plextor PX-32
missing)

During scanning, I got these (the first two aborts and the SCSI bus reset l=
ook
right since I hotplugged the entire bus to the other adaptor)

 scsi singledevice 1 0 2 0
 scsi : aborting command due to timeout : pid 46, scsi1, channel 0, id 2, l=
un 0 Inquiry 00 00 00 ff 00
 DC390: Abort command (pid 46, Device 02-00)
 DC390: SRB: Xferred 00000000, Remain 00000100, State 00000100, Phase 01
 DC390: AdpaterStatus: 00, SRB Status 00
 DC390: Status of last IRQ (DMA/SC/Int/IRQ): 00818418
 DC390: Register dump: SCSI block:
 DC390: XferCnt  Cmd Stat IntS IRQS FFIS Ctl1 Ctl2 Ctl3 Ctl4
 DC390:  0000ff   90   01   c4   00   81   17   48   08   84
 DC390: FIFO: 20
 DC390: Register dump: DMA engine:
 DC390: Cmd   STrCnt    SBusA    WrkBC    WrkAC Stat SBusCtrl
 DC390:  83 00000100 071c5da4 00000100 071c5da4   00 03184200
 DC390: Register dump: PCI Status: c200
 DC390: In case of driver trouble read linux/drivers/scsi/README.tmscsim
 DC390: Abort current command (pid 46, SRB c7e3c13c)
 DC390: Aborted pid 46 with status 3
 scsi : aborting command due to timeout : pid 46, scsi1, channel 0, id 2, l=
un 0 Inquiry 00 00 00 ff 00
 DC390: Abort command (pid 46, Device 02-00)
 DC390: SRB: Xferred 00000000, Remain 00000100, State 00000100, Phase 01
 DC390: AdpaterStatus: 00, SRB Status 00
 DC390: Status of last IRQ (DMA/SC/Int/IRQ): 00818418
 DC390: Register dump: SCSI block:
 DC390: XferCnt  Cmd Stat IntS IRQS FFIS Ctl1 Ctl2 Ctl3 Ctl4
 DC390:  0000ff   90   01   c4   00   80   17   48   08   84
 DC390: Register dump: DMA engine:
 DC390: Cmd   STrCnt    SBusA    WrkBC    WrkAC Stat SBusCtrl
 DC390:  83 00000100 071c5da4 00000100 071c5da4   00 03184200
 DC390: Register dump: PCI Status: c200
 DC390: In case of driver trouble read linux/drivers/scsi/README.tmscsim
 DC390: Abort current command (pid 46, SRB c7e3c13c)
 DC390: Aborted pid 46 with status 3
 SCSI host 1 abort (pid 46) timed out - resetting
 SCSI bus is being reset for host 1 channel 0.
 DC390: RESET ... done

 scsi singledevice 1 0 3 0
 DC390: Illegal Operation detected (00c38418)!
 DC390: SRB: Xferred 00000000, Remain 00000000, State 00000040, Phase 05
 DC390: AdpaterStatus: 00, SRB Status 00
 DC390: Status of last IRQ (DMA/SC/Int/IRQ): 00c38418
 DC390: Register dump: SCSI block:
 DC390: XferCnt  Cmd Stat IntS IRQS FFIS Ctl1 Ctl2 Ctl3 Ctl4
 DC390:  0000ff   42   03   84   00   80   17   48   08   84
 DC390: Register dump: DMA engine:
 DC390: Cmd   STrCnt    SBusA    WrkBC    WrkAC Stat SBusCtrl
 DC390:  00 00000100 071c5da4 00000100 071c5da4   00 031a4602
 DC390: Register dump: PCI Status: c200
 DC390: In case of driver trouble read linux/drivers/scsi/README.tmscsim

A subsequent rescan-scsi-bus.sh will find the PX-32TS and add it, this time,
without bus resets and aborts.

Should the reset->inquiry delay be applied after ANY reset? Is it actually
applied but too short for my Plextor?

--n8g4imXOkfNTN/H1
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: Weitere Infos: siehe http://www.gnupg.org

iQCVAwUBOiITzydEoB0mv1ypAQE9hQP7BDj7cO280TFGjjNXAAmMmLWorkmSyRem
J+fJDClYUgPx33NsZT/WnERkJ6lAaWm70MYh3HDd0RigIpi5OWgDWBRChGYFqaYe
WtpBAEWLgpdi/gVecID5Akg7Ymh3g4rg0Z8ny9PURtzc73Sz8r/amgP4iLkJP8Vn
joWD+bkHSUk=
=Dr3F
-----END PGP SIGNATURE-----

--n8g4imXOkfNTN/H1--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
