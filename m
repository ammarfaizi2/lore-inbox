Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263596AbUCYUGc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Mar 2004 15:06:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263602AbUCYUGa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Mar 2004 15:06:30 -0500
Received: from noose.gt.owl.de ([62.52.19.4]:59662 "EHLO noose.gt.owl.de")
	by vger.kernel.org with ESMTP id S263592AbUCYUFF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Mar 2004 15:05:05 -0500
Date: Thu, 25 Mar 2004 21:04:57 +0100
From: Florian Lohoff <flo@rfc822.org>
To: linux-kernel@vger.kernel.org
Cc: linux-scsi@vger.kernel.org
Subject: 2.6.3 gdth driver NMI Watchdog detected LOCKUP
Message-ID: <20040325200456.GA7749@paradigm.rfc822.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="sHrvAb52M6C8blB9"
Content-Disposition: inline
Organization: rfc822 - pure communication
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--sHrvAb52M6C8blB9
Content-Type: multipart/mixed; boundary="UHN/qo2QbUvPLonB"
Content-Disposition: inline


--UHN/qo2QbUvPLonB
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


Hi,
i got this NMI on one of our Machines - I have seen these kinds of deadlocks
on 2.4 too - Iirc its a locking problem on long overdue requests and the sc=
si_eh
kicking in. I think i spotted this already in 2.4.18 back in May 2002 (Mail=
 attached).

Dual PIII 1Ghz, Serverworks Chipset, ICP Vortex
Vanilla 2.6.3

00:05.0 SCSI storage controller: ICP Vortex Computersysteme GmbH GDT 6123RS=
/6523RS
        Subsystem: ICP Vortex Computersysteme GmbH GDT 6123RS/6523RS
        Flags: bus master, medium devsel, latency 32, IRQ 18
        Memory at fe000000 (32-bit, prefetchable) [size=3D16K]
        Expansion ROM at <unassigned> [disabled] [size=3D32K]
        Capabilities: [80] Power Management version 2

Adapter 0: Host Drive 0: resetted locally
Adapter 0: Host Drive 0: resetted locally
NMI Watchdog detected LOCKUP on CPU0, eip c0116e24, registers:
CPU:    0
EIP:    0060:[<c0116e24>]    Not tainted
EFLAGS: 00000083
EIP is at delay_tsc+0x14/0x20
eax: 52bff37b   ebx: 000f0b90   ecx: 52b42ab1   edx: 00006b5a
esi: c00981c0   edi: 00000000   ebp: 00000002   esp: f7fabe8c
ds: 007b   es: 007b   ss: 0068
Process scsi_eh_2 (pid: 18, threadinfo=3Df7faa000 task=3Df7dc6c00)
Stack: ffffffff c01eade2 000f0b90 c0261ffd 000f0b90 0001734e c026258a 00000=
001
       c00981c0 00000000 00000000 c009ae80 c00981c0 00000002 00000000 c0262=
6e0
       00000000 00000002 000186a0 000186a0 00000018 09000000 00000000 c0098=
1c0
Call Trace:
 [<c01eade2>] __delay+0x12/0x20
 [<c0261ffd>] gdth_delay+0x2d/0x60
 [<c026258a>] gdth_wait+0x6a/0xc0
 [<c02626e0>] gdth_internal_cmd+0x100/0x1e0
 [<c026582c>] gdth_eh_bus_reset+0x24c/0x2c0
 [<c024e456>] scsi_try_bus_reset+0x56/0xf0
 [<c024b7e4>] __scsi_iterate_devices+0x84/0xa0
 [<c024e639>] scsi_eh_bus_reset+0x59/0xf0
 [<c024eb80>] scsi_eh_ready_devs+0x50/0x80
 [<c024ed20>] scsi_unjam_host+0xe0/0xf0
 [<c024ee28>] scsi_error_handler+0xf8/0x150
 [<c024ed30>] scsi_error_handler+0x0/0x150
 [<c0108c19>] kernel_thread_helper+0x5/0xc
=20
Code: 29 c8 39 d8 72 f6 5b c3 8d 74 26 00 55 b8 00 e0 ff ff 57 56
console shuts up ...
 EIP is at __preempt_spin_lock+ 0x50/0x70




I guess modifying "gdth_polling" needs to be move infront of taking the
lock and needs to be guranteed written out to mem (memory barrier ?
atomic_set ?)

drivers/scsi/gdth.c:gdth_eh_bus_reset

   4779
   4780     if (b =3D=3D ha->virt_bus) {
   4781         /* host drives */
   4782         for (i =3D 0; i < MAX_HDRIVES; ++i) {
   4783             if (ha->hdr[i].present) {
   4784                 GDTH_LOCK_HA(ha, flags);
   4785                 gdth_polling =3D TRUE;
   4786                 while (gdth_test_busy(hanum))
   4787                     gdth_delay(0);
   4788                 if (gdth_internal_cmd(hanum, CACHESERVICE,
   4789                                       GDT_CLUST_RESET, i, 0, 0))
   4790                     ha->hdr[i].cluster_type &=3D ~CLUSTER_RESERVED;
   4791                 gdth_polling =3D FALSE;
   4792                 GDTH_UNLOCK_HA(ha, flags);
   4793             }
   4794         }
   4795     } else {
   4796         /* raw devices */
   4797         GDTH_LOCK_HA(ha, flags);
   4798         for (i =3D 0; i < MAXID; ++i)
   4799             ha->raw[BUS_L2P(ha,b)].io_cnt[i] =3D 0;
   4800         gdth_polling =3D TRUE;
   4801         while (gdth_test_busy(hanum))
   4802             gdth_delay(0);
   4803         gdth_internal_cmd(hanum, SCSIRAWSERVICE, GDT_RESET_BUS,
   4804                           BUS_L2P(ha,b), 0, 0);
   4805         gdth_polling =3D FALSE;
   4806         GDTH_UNLOCK_HA(ha, flags);
   4807     }
   4808     return SUCCESS;
   4809 }
   4810

vs.

drivers/scsi/gdth.c:gdth_interrupt

   3390     if (!gdth_polling)
   3391         GDTH_LOCK_HA((gdth_ha_str *)dev_id,flags);
   3392     wait_index =3D 0;

So we have a small race.

I would propose something like this:


--- linux-2.6.3/drivers/scsi/gdth.c.orig	2004-03-25 20:58:18.000000000 +0100
+++ linux-2.6.3/drivers/scsi/gdth.c	2004-03-25 20:59:28.000000000 +0100
@@ -4781,29 +4781,29 @@
         /* host drives */
         for (i =3D 0; i < MAX_HDRIVES; ++i) {
             if (ha->hdr[i].present) {
-                GDTH_LOCK_HA(ha, flags);
                 gdth_polling =3D TRUE;
+                GDTH_LOCK_HA(ha, flags);
                 while (gdth_test_busy(hanum))
                     gdth_delay(0);
                 if (gdth_internal_cmd(hanum, CACHESERVICE,=20
                                       GDT_CLUST_RESET, i, 0, 0))
                     ha->hdr[i].cluster_type &=3D ~CLUSTER_RESERVED;
-                gdth_polling =3D FALSE;
                 GDTH_UNLOCK_HA(ha, flags);
+                gdth_polling =3D FALSE;
             }
         }
     } else {
         /* raw devices */
+        gdth_polling =3D TRUE;
         GDTH_LOCK_HA(ha, flags);
         for (i =3D 0; i < MAXID; ++i)
             ha->raw[BUS_L2P(ha,b)].io_cnt[i] =3D 0;
-        gdth_polling =3D TRUE;
         while (gdth_test_busy(hanum))
             gdth_delay(0);
         gdth_internal_cmd(hanum, SCSIRAWSERVICE, GDT_RESET_BUS,
                           BUS_L2P(ha,b), 0, 0);
-        gdth_polling =3D FALSE;
         GDTH_UNLOCK_HA(ha, flags);
+        gdth_polling =3D FALSE;
     }
     return SUCCESS;
 }


--=20
Florian Lohoff                  flo@rfc822.org             +49-171-2280134
                        Heisenberg may have been here.

--UHN/qo2QbUvPLonB
Content-Type: message/rfc822
Content-Disposition: inline

Date: Fri, 3 May 2002 16:45:10 +0200
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
Sender: flo@rfc822.org


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

--UHN/qo2QbUvPLonB--

--sHrvAb52M6C8blB9
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQFAYztoUaz2rXW+gJcRAs3HAKCP71yPjUVFH1HJ6Mw8qy2bzr4HZACgpth3
bp4BOkOVU2CDmiF5QgFWiBo=
=TCT0
-----END PGP SIGNATURE-----

--sHrvAb52M6C8blB9--
