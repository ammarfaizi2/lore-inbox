Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265603AbSKYT56>; Mon, 25 Nov 2002 14:57:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265628AbSKYT56>; Mon, 25 Nov 2002 14:57:58 -0500
Received: from turing-police.cc.vt.edu ([128.173.14.107]:23940 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id <S265603AbSKYT54>; Mon, 25 Nov 2002 14:57:56 -0500
Message-Id: <200211252002.gAPK2WeU008468@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.5 07/13/2001 with nmh-1.0.4+dev
To: linux-kernel@vger.kernel.org
Subject: 2.5.49 - shutdown issues on Dell Latitude
From: Valdis.Kletnieks@vt.edu
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-119746560P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Mon, 25 Nov 2002 15:02:32 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-119746560P
Content-Type: text/plain; charset=us-ascii

(Am not on list, please cc: on replies - I *do* track via the web archive
at marc.theaimsgroup.com as well)

This is the same problem as originally reported by DevelKin in
http://marc.theaimsgroup.com/?l=linux-kernel&m=103588412714088&w=2

The problem is still present in 2.5.49, and affects the Latitude C840 as well
as the Latitude CPI.  It's also more extensive than originally reported.

1) My system uses LILO to reboot.  If the previous kernel was a 2.4.18, and I
do a  'shutdown -r', then selecting either a 2.4.x or 2.5.49 kernel at the lilo
prompt will boot just fine.  If the previous kernel was a 2.5.49, then at the
next lilo prompt selecting *EITHER* a 2.4.18 or 2.5.49 kernel will result in an
almost immediate ka-chunk as the laptop powers down. lilo produces a 'Loading
<label>' and then we power off.  I admit being puzzled as to what cruft the
shutdown could leave behind that would survive the BIOS call and not hit until
LILO tries to load the next kernel.

2) 'shutdown -h' under 2.4.18 actually powered the laptop down.  Under 2.5.49,
it prints 'Power down.' and then hangs hard - no power off, and the power
button becomes inoperative - I have to pop the batteries and pull the power
cord.

It seems almost as if there is a test with inverted sense someplace.  I've gone
over the 2.4.18 and 2.4.59 versions of kernel/sys.c and the 2.4.18 code
in arch/i386/kernel/process.c and 2.5.19's arch/i386/kernel/reboot.c, but
I don't see anything noticably different in there.

Hmm... Possibly odd:  in machine_restart(), we have this code:

        if(!reboot_thru_bios) {
                /* rebooting needs to touch the page at absolute addr 0 */
                *((unsigned short *)__va(0x472)) = reboot_mode;

I've not proven to myself that we can't reach this without setting reboot_mode
externally.

The other "suspicious" area is that the 2.5.19 dmi_scan.c includes the Dell
Latitude as 'local_apic_kills_bios', and the 2.4.18 code doesn't.  Could this
be an issue? I built with no SMP, but with local_apic, and 2.5.49 *does*
say this at boot:

Dell Latitude with broken BIOS detected. Refusing to enable the local APIC.

I wonder if the local APIC gets poked during shutdown of the 2.5.49, causing
all the uglyness?

Any other ideas?
-- 
				Valdis Kletnieks
				Computer Systems Senior Engineer
				Virginia Tech


--==_Exmh_-119746560P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE94oHYcC3lWbTT17ARAmJuAKDW9iSSez6djoHgxk3p2ABBt+o1fQCggHDe
MrLnI/Jo4ncQvltM83PfCfc=
=HH6U
-----END PGP SIGNATURE-----

--==_Exmh_-119746560P--
