Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu via listexpand id <S154038AbPGTI6K>; Tue, 20 Jul 1999 04:58:10 -0400
Received: by vger.rutgers.edu id <S153953AbPGTI56>; Tue, 20 Jul 1999 04:57:58 -0400
Received: from Cantor.suse.de ([194.112.123.193]:29491 "HELO Cantor.suse.de") by vger.rutgers.edu with SMTP id <S154012AbPGTI4P>; Tue, 20 Jul 1999 04:56:15 -0400
Date: Tue, 20 Jul 1999 10:55:51 +0200
From: Kurt Garloff <garloff@suse.de>
To: Artur Skawina <skawina@geocities.com>
Cc: linux-kernel@vger.rutgers.edu, Harald Koerfgen <Harald.Koerfgen@home.ivm.de>
Subject: Re: [RFC] increasing and masquerading HZ
Message-ID: <19990720105551.C9486@bari.suse.de>
Mail-Followup-To: Artur Skawina <skawina@geocities.com>, linux-kernel@vger.rutgers.edu, Harald Koerfgen <Harald.Koerfgen@home.ivm.de>
References: <3793EDBB.6B7D7E12@geocities.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary=DSayHWYpDlRfCAAQ; micalg=pgp-md5; protocol="application/pgp-signature"
X-Mailer: Mutt 0.95.4i
In-Reply-To: <3793EDBB.6B7D7E12@geocities.com>; from Artur Skawina on Tue, Jul 20, 1999 at 05:32:11AM +0200
X-Operating-System: Linux 2.2.10 i686
X-PGP-Info: on http://www.garloff.de/kurt/pgp.public.key.kurt.home.asc
X-PGP-Version: 2.6.3i
X-PGP-Key: 1024/CEFC9215
X-PGP-Fingerprint: 92 00 AC 56 59 50 13 83  3C 18 6F 1B 25 A0 3A 5F
Sender: owner-linux-kernel@vger.rutgers.edu


--DSayHWYpDlRfCAAQ
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 20, 1999 at 05:32:11AM +0200, Artur Skawina wrote:
> The attached patch increases HZ to 800 for kernels compiled for 686
> It tries to hide the HZ change from userspace. The places I found were:
>=20
> o /proc/stat
> o /proc/<pid>/stat
> o /proc/<pid>/cpu
> o BSD Process Accounting
> o siginfo
> o sys_times
>=20
> Not handled:
> o the ip routing sysctls [defined in jiffies...:( ]
>=20
> also note there are drivers that assume HZ=3D=3D100 (initio scsi for one).
>=20
>=20
> The numbers I've got so far doesn't look very good however,
> a 3% drop in performance (HZ=3D1024) is a bit much.
>=20
>=20
> [I did this patch from scratch so that the chance of spotting all
>  places requiring updates would be greater. turned up to be a good
>  thing - it handles a few more cases than the previously mentioned
>  patch by Kurt Garloff]
>=20
> What did I miss? :)

Hi Artur,

nice work!
Yes, you spotted a few places which I missed.

Without looking into details, I saw a place, where I did HZ conversion where
you did not, but I may be completely wrong with it:
@@ -233,26 +237,26 @@
        extern unsigned long total_forks;
  	unsigned long ticks;
 =20
-       ticks =3D jiffies * smp_num_cpus;
+       ticks =3D jiffies * smp_num_cpus / HZ_TO_STD;
  	for (i =3D 0 ; i < NR_IRQS ; i++)
  		sum +=3D kstat_irqs(i);
	=09
More comments on your patch:

> --- /img/linux-2.3.5/include/asm-i386/param.h	Tue Aug  1 15:08:17 1995
> +++ linux-2.3.5as/include/asm-i386/param.h	Tue Jul 20 02:14:21 1999
> @@ -1,8 +1,18 @@
>  #ifndef _ASMi386_PARAM_H
>  #define _ASMi386_PARAM_H
> =20
> +#include <linux/config.h>
> +
>  #ifndef HZ
>  #define HZ 100
> +#endif
> +
> +#if HZ!=3D100
> +/*#define HZTOUSER(hz) (((hz)*100)/HZ) would be better, but could overfl=
ow*/
> +#define HZTOUSER(hz)    ((hz)/(HZ/100))
> +/*#define HZFROMUSER(hz)  ((hz)*(HZ/100)) hmm, these will be small value=
s, right?*/
> +#define HZFROMUSER(hz)  (((hz)*HZ)/100)
> +#define HZ_MASQUERADING (HZ/100)    /* defined if masquerading, HZ/HZ_MA=
SQUERADING=3D=3D100 */
>  #endif
> =20
>  #define EXEC_PAGESIZE	4096

This seems to be the right thing to do, IMO. You should put a comment about
the fact, that only multiples of 100 are allowed, 1024 eg. is not.
(You would get very inaccurate results.)

You may want to merge your patch with one from=20
 Harald Koerfgen <Harald.Koerfgen@home.ivm.de>
on
 ftp://ftp.linux.sgi.com/pub/linux/mips/test/hz_patch.gz

He mailed me about necessary changes for his MIPS work. I did not yet find
time to answer him, but maybe you can contact him and get the changes merge=
d.

Basically, independance of userspace from the internal HZ is good. This is
also Linus' opinion, IIRC, and you have got good chances that your patch wi=
ll
go into the kernel (without the Makefile change, of course) if you submit it
to him. But look at it again in order to not miss anything ...

Regards,
--=20
Kurt Garloff  <garloff@suse.de>           SuSE GmbH, N=FCrnberg, FRG
Linux kernel development;      SCSI drivers: tmscsim(DC390), DC395

--DSayHWYpDlRfCAAQ
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: 2.6.3i

iQCVAwUBN5Q5lxaQN/7O/JIVAQFcxgP/S/FwQ1+tZymResxJZDNvSWIUxMIjeMcQ
a6WTytfCnO4Msr1bl0OV/rOkgAHeyV7MqRqYyIho2fYfvx6oNbcSU4b+OOibEcOC
dfljk50WYIGGeQSRG7QkSKYR/KMOIX4aft1trbCpm4O4OBQ8cFEq5Iy7baiXfOtz
qxydJXkGQLU=
=svuS
-----END PGP SIGNATURE-----

--DSayHWYpDlRfCAAQ--

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
