Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314128AbSECOpl>; Fri, 3 May 2002 10:45:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314149AbSECOpk>; Fri, 3 May 2002 10:45:40 -0400
Received: from noose.gt.owl.de ([62.52.19.4]:24338 "HELO noose.gt.owl.de")
	by vger.kernel.org with SMTP id <S314128AbSECOph>;
	Fri, 3 May 2002 10:45:37 -0400
Date: Fri, 3 May 2002 16:45:11 +0200
From: Florian Lohoff <flo@rfc822.org>
To: linux-kernel@vger.kernel.org
Subject: gdth race ?
Message-ID: <20020503144510.GA11945@paradigm.rfc822.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/9DWx/yDrRhgMJTb"
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Organization: rfc822 - pure communication
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--/9DWx/yDrRhgMJTb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


Hi,
i am looking into silent crashes on some of our boxes running with
icp vortex controllers - I have seens CPU lockups with the gdth driver
from the icp-vortex pages but also with the kernel plain driver. While
staring at the code trying to explaint a backtrace from a=20

 NMI Watchdog detected LOCKUP on CPU0, eip c01c877d, registers:
[...]
 >>EIP; c01c877d <.text.lock.gdth+e1/154>   <=3D=3D=3D=3D=3D
 Trace; c01c7753 <gdth_interrupt+613/620>
 Trace; c01c5564 <gdth_wait+5c/ac>
 Trace; c01c5726 <gdth_internal_cmd+172/1b8>
 Trace; c01c825e <gdth_eh_bus_reset+18e/304>
 Trace; c01b4c33 <scsi_try_bus_reset+73/f4>
 Trace; c01b53b7 <scsi_unjam_host+34f/724>
 Trace; c01b58fb <scsi_error_handler+16f/1cc>
 Trace; c01070d4 <kernel_thread+28/38>

I think i spotted a race:

gdth.c:scsi_eh_bus_reset

   4478             if (ha->hdr[i].present) {
   4479                 GDTH_LOCK_HA(ha, flags);
   4480                 gdth_polling =3D TRUE;
   4481                 while (gdth_test_busy(hanum))
   4482                     gdth_delay(0);
   4483                 if (gdth_internal_cmd(hanum, CACHESERVICE,
   4484                                       GDT_CLUST_RESET, i, 0, 0))
   4485                     ha->hdr[i].cluster_type &=3D ~CLUSTER_RESERVED;
   4486                 gdth_polling =3D FALSE;
   4487                 GDTH_UNLOCK_HA(ha, flags);
   4488             }

If we catch an interrupt between acquirering GDTH_LOCK_HA and
setting gdth_polling =3D TRUE we execute:

gdth.c:gdth_interrupt

   3181     if (!gdth_polling)
   3182         GDTH_LOCK_HA((gdth_ha_str *)dev_id,flags);

Now we should be stuck.=20

 From looking at my vmstat 30 output running on the serial console
i would guess that only one "Host Drive" on the controller got stuck
but not the other - The machine only has drives on the Raid controller:

   procs                      memory    swap          io     system cpu
 r  b  w   swpd   free   buff  cache  si  so    bi    bo   in    cs  us sy =
 id
 1  0  0  14008   4348   4144 802828   1   0  6390    13 4828  1765  14 22 =
 64
 0  0  1  14008   4472   4148 802596   0   0  6254    23 4808  1717   8 22 =
 70
 0  0  0  14008   4420   4128 802892   0   0  6186     8 4747  1721   7 21 =
 72
 3  0  0  14008   4444   4148 803084   0   0  6195    13 4709  1717   6 20 =
 74
 0  1  1  14008   6104   4072 803216   0   0  5759     9 4548  1690   5 18 =
 77
 0  1  0  14008   4428   4080 804840   0   0    56     8  490   332   2 2  =
96
 0  1  0  14008   6676   4080 806172   0   0    51    13  726   472   6 3  =
91
 1  1  0  14008   4848   4084 807900   0   0    51     4  826   464   9 3  =
87
 0  1  0  14008   5700   4088 808860   0   0    51     8  758   417   9 3  =
87
 0  1  0  14008   4520   4108 810976   1   0    91     8  722   399   9 3  =
88
Adapter 0: Host Drive 0: resetted locally
NMI Watchdog detected LOCKUP on CPU0, eip c01c877d, registers:
CPU:    0
EIP:    0010:[<c01c877d>]    Not tainted
[...]

I dont think that this specific race can be held responsible for
the lockup i saw as it locked up in gdth_wait executing gdth_interrupt.

I am overlooking some facts ?

Flo
--=20
Florian Lohoff                  flo@rfc822.org             +49-5201-669912
                        Heisenberg may have been here.

--/9DWx/yDrRhgMJTb
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE80qJ2Uaz2rXW+gJcRAnmFAJ9ftWrJtdC/m8ySAc9DmWZg6YahtACeOlvI
YF647U+qoMPOg6jxXKHZtFo=
=Z2Vl
-----END PGP SIGNATURE-----

--/9DWx/yDrRhgMJTb--
