Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263824AbTKML1u (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Nov 2003 06:27:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263822AbTKML1u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Nov 2003 06:27:50 -0500
Received: from dd1234.kasserver.com ([81.209.148.157]:36041 "EHLO
	dd1234.kasserver.com") by vger.kernel.org with ESMTP
	id S263824AbTKML1q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Nov 2003 06:27:46 -0500
Date: Thu, 13 Nov 2003 11:27:40 +0000
From: Jochen Voss <voss@seehuhn.de>
To: linux-kernel@vger.kernel.org
Subject: invalid SMP mptable on Toshiba Satellite 2430-301
Message-ID: <20031113112740.GA4719@seehuhn.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="XsQoSWH+UP9D9v3l"
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--XsQoSWH+UP9D9v3l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

finally I fount the time to track down the reason, why my
Toshiba Satellite 2430-301 laptop did not boot when the
"local APIC support on uniprocessors" option was enabled.

The problem occurs on 2.4.21 as well as on 2.6.0test9.  The
following analysis applies to the 2.6.0test9 kernel source
with Debian patches.  All the gory details may found at
http://bugs.debian.org/218768 .

The crash happens as follows:

    start_kernel(init/main.c):
      calls 'setup_arch'

    setup_arch(arch/i386/kernel/setup.c):
      calls 'get_smp_config'
      (this is conditional on CONFIG_X86_LOCAL_APIC)

    get_smp_config(arch/i386/kernel/mpparse.c):
      obtains struct intel_mp_floating *mpf
      the values (obtained via early_printk,
      compare memory dumps at the bottom) are
            mpf->mpf_signature=3D"_MP_"
            mpf->mpf_physptr=3D0x0009F830
            mpf->mpf_length=3D1
            mpf->mpf_specification=3D4
            mpf->mpf_checksum=3D111
            mpf->mpf_feature1=3D0
            mpf->mpf_feature2=3D0
            mpf->mpf_feature3=3D0
            mpf->mpf_feature4=3D0
            mpf->mpf_feature5=3D0
      mpf_physptr points into the second block of
      BIOS-provided physical RAM map:
         BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
         BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
         BIOS-e820: 00000000000dc000 - 0000000000100000 (reserved)
         BIOS-e820: 0000000000100000 - 000000001ff70000 (usable)
         BIOS-e820: 000000001ff70000 - 000000001ff7b000 (ACPI data)
         BIOS-e820: 000000001ff7b000 - 000000001ff80000 (ACPI NVS)
         BIOS-e820: 000000001ff80000 - 0000000020000000 (reserved)
         BIOS-e820: 00000000ff800000 - 00000000ffc00000 (reserved)
         BIOS-e820: 00000000fffffc00 - 0000000100000000 (reserved)
      smp_read_mpc is called

    smp_read_mpc(arch/i386/kernel/mpparse.c):
      The argument mpc points to a 'struct mp_config_table',
        which is filled with zero bytes (compare memory dump
        below).
      The 'if (memcmp(mpc->mpc_signature,MPC_SIGNATURE,4))' test
        fails because of this and calls 'panic'.
      The kernel never returns from the call to 'panic'.

Herbert Xu produced a patch, which converts the crash into an error
message, so the symptoms are cured for me.


Now for my questions: As far as I can see it, the invalid
SMP mptable is a BIOS bug on my machine.  Do you think so,
too?  Or are there other possibilities?

Do you think it would be helpful to contact Toshiba (my
laptop's vendor) about this?  Or would they just ignore
such a report?  I have never tried to report something like
this before, and feel a little uncomfortable about doing
so, because I don't know what a "SMP mptable" is for, and I
might write stupid things in my report.


Thank you,
Jochen


PS.: please Cc: me on replies, because I'm not on the list.

PPS.: I append a memory dump (extracted from /dev/kmem) of the
relevant regions.  Starting at the "_MP_" you can see the
'struct intel_mp_floating *mpf'

000F6A80: F0 4A F7 1F 00 00 00 00 00 00 00 00 00 00 00 00  .J..............
000F6A90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
000F6AA0: 5F 33 32 5F 80 D7 0F 00 00 01 76 00 00 00 00 00  _32_......v.....
000F6AB0: 5F 4D 50 5F 30 F8 09 00 01 04 6F 00 00 00 00 00  _MP_0.....o.....
000F6AC0: 00 00 00 00 01 10 64 95 3C 3D 6F 00 00 00 00 00  ......d.<=3Do...=
=2E.
000F6AD0: 24 50 44 4D 01 0B 2B 47 8D 00 F0 00 00 00 00 00  $PDM..+G........
000F6AE0: 24 50 6E 50 10 21 00 00 A8 00 04 00 00 B1 97 00  $PnP.!..........
000F6AF0: F0 CF 97 00 00 0F 00 00 00 00 00 40 00 00 04 00  ...........@....

This is the place where the 'struct mp_config_table' is
supposed to reside.

0009F800: 02 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
0009F810: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
0009F820: 00 00 00 00 00 00 00 02 00 00 00 00 00 00 00 00  ................
0009F830: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
0009F840: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
0009F850: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
0009F860: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
0009F870: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................

I looked for the strings "PCMP" or "_OEM" (the signatures
for 'mp_config_table' and 'mp_config_oemtable').  These
strings do not occur on word-aligned addresses in the
address ranges

    BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
    BIOS-e820: 00000000000dc000 - 0000000000100000 (reserved)
    BIOS-e820: 000000001ff70000 - 000000001ff7b000 (ACPI data)
    BIOS-e820: 000000001ff7b000 - 000000001ff80000 (ACPI NVS)
    BIOS-e820: 000000001ff80000 - 0000000020000000 (reserved)
--=20
http://seehuhn.de/

--XsQoSWH+UP9D9v3l
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/s2qsf+iD8yEbECURAoh/AKCc1uzzo22vrQAmzLzcHXxqnby0BwCdHSJV
B2DH0ZE1wz/lIdCnAOKpnwA=
=Afyo
-----END PGP SIGNATURE-----

--XsQoSWH+UP9D9v3l--
