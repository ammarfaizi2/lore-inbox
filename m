Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271135AbTGPVp1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jul 2003 17:45:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271136AbTGPVp0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jul 2003 17:45:26 -0400
Received: from mx02.qsc.de ([213.148.130.14]:5519 "EHLO mx02.qsc.de")
	by vger.kernel.org with ESMTP id S271135AbTGPVo6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jul 2003 17:44:58 -0400
Date: Wed, 16 Jul 2003 23:59:47 +0200
From: Wiktor Wodecki <wodecki@gmx.de>
To: Con Kolivas <kernel@kolivas.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] O6int for interactivity
Message-ID: <20030716215947.GE670@gmx.de>
Reply-To: Wiktor Wodecki <wodecki@gmx.net>
References: <200307170030.25934.kernel@kolivas.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2Z2K0IlrPCVsbNpk"
Content-Disposition: inline
In-Reply-To: <200307170030.25934.kernel@kolivas.org>
X-message-flag: Linux - choice of the GNU generation
X-Operating-System: Linux 2.6.0-test1-mm1-O6 i686
X-PGP-KeyID: 182C9783
X-Info: X-PGP-KeyID, send an email with the subject 'public key request' to wodecki@gmx.de
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--2Z2K0IlrPCVsbNpk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

I have been gone from the computer for a couple of hours, and now
everything is very chopping. For example I'm transfering some huge data
over nfs to another linux box (on sun, tho) where there is not enough
space available. It happens that in the middle of the copying the
process 'hangs'. I cannot interrupt it with ctrl-[cz], it takes a couple
of seconds (~20). I cannot tell for sure that the problem is with the O6
patch, since I haven't done it on an other kernel, yet.

On Thu, Jul 17, 2003 at 12:30:25AM +1000, Con Kolivas wrote:
> O*int patches trying to improve the interactivity of the 2.5/6 scheduler =
for=20
> desktops. It appears possible to do this without moving to nanosecond=20
> resolution.
>=20
> This one makes a massive difference... Please test this to death.
>=20
> Changes:
> The big change is in the way sleep_avg is incremented. Any amount of slee=
p=20
> will now raise you by at least one priority with each wakeup. This causes=
=20
> massive differences to startup time, extremely rapid conversion to intera=
ctive=20
> state, and recovery from non-interactive state rapidly as well (prevents =
X=20
> stalling after thrashing around under high loads for many seconds).
>=20
> The sleep buffer was dropped to just 10ms. This has the effect of causing=
 mild=20
> round robinning of very interactive tasks if they run for more than 10ms.=
 The=20
> requeuing was changed from (unlikely()) to an ordinary if.. branch as thi=
s=20
> will be hit much more now.
>=20
> MAX_BONUS as a #define was made easier to understand
>=20
> Idle tasks were made slightly less interactive to prevent cpu hogs from=
=20
> becoming interactive on their very first wakeup.
>=20
> Con
>=20
> This patch-O6int-0307170012 applies on top of 2.6.0-test1-mm1 and can be =
found=20
> here:
> http://kernel.kolivas.org/2.5
>=20
> and here:
>=20
> --- linux-2.6.0-test1-mm1/kernel/sched.c	2003-07-16 20:27:32.000000000 +1=
000
> +++ linux-2.6.0-testck1/kernel/sched.c	2003-07-17 00:13:24.000000000 +1000
> @@ -76,9 +76,9 @@
>  #define MIN_SLEEP_AVG		(HZ)
>  #define MAX_SLEEP_AVG		(10*HZ)
>  #define STARVATION_LIMIT	(10*HZ)
> -#define SLEEP_BUFFER		(HZ/20)
> +#define SLEEP_BUFFER		(HZ/100)
>  #define NODE_THRESHOLD		125
> -#define MAX_BONUS		((MAX_USER_PRIO - MAX_RT_PRIO) * PRIO_BONUS_RATIO / 1=
00)
> +#define MAX_BONUS		(40 * PRIO_BONUS_RATIO / 100)
> =20
>  /*
>   * If a task is 'interactive' then we reinsert it in the active
> @@ -399,7 +399,7 @@ static inline void activate_task(task_t=20
>  		 */
>  		if (sleep_time > MIN_SLEEP_AVG){
>  			p->avg_start =3D jiffies - MIN_SLEEP_AVG;
> -			p->sleep_avg =3D MIN_SLEEP_AVG * (MAX_BONUS - INTERACTIVE_DELTA - 1) /
> +			p->sleep_avg =3D MIN_SLEEP_AVG * (MAX_BONUS - INTERACTIVE_DELTA - 2) /
>  				MAX_BONUS;
>  		} else {
>  			/*
> @@ -413,14 +413,10 @@ static inline void activate_task(task_t=20
>  			p->sleep_avg +=3D sleep_time;
> =20
>  			/*
> -			 * Give a bonus to tasks that wake early on to prevent
> -			 * the problem of the denominator in the bonus equation
> -			 * from continually getting larger.
> +			 * Processes that sleep get pushed to a higher priority
> +			 * each time they sleep
>  			 */
> -			if ((runtime - MIN_SLEEP_AVG) < MAX_SLEEP_AVG)
> -				p->sleep_avg +=3D (runtime - p->sleep_avg) *
> -					(MAX_SLEEP_AVG + MIN_SLEEP_AVG - runtime) *
> -					(MAX_BONUS - INTERACTIVE_DELTA) / MAX_BONUS / MAX_SLEEP_AVG;
> +			p->sleep_avg =3D (p->sleep_avg * MAX_BONUS / runtime + 1) * runtime /=
 MAX_BONUS;
> =20
>  			/*
>  			 * Keep a small buffer of SLEEP_BUFFER sleep_avg to
> @@ -1311,7 +1307,7 @@ void scheduler_tick(int user_ticks, int=20
>  			enqueue_task(p, rq->expired);
>  		} else
>  			enqueue_task(p, rq->active);
> -	} else if (unlikely(p->prio < effective_prio(p))){
> +	} else if (p->prio < effective_prio(p)){
>  		/*
>  		 * Tasks that have lowered their priority are put to the end
>  		 * of the active array with their remaining timeslice
>=20
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

--=20
Regards,

Wiktor Wodecki

--2Z2K0IlrPCVsbNpk
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE/FcrT6SNaNRgsl4MRArPKAJ9gegev7hiyZsO8QRV/dnIF2Id0KQCg0py4
C25vvH4d38yfQuA79NsjMRg=
=9HO4
-----END PGP SIGNATURE-----

--2Z2K0IlrPCVsbNpk--
