Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271602AbTGRLUA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jul 2003 07:20:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271616AbTGRLUA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jul 2003 07:20:00 -0400
Received: from mx02.qsc.de ([213.148.130.14]:65508 "EHLO mx02.qsc.de")
	by vger.kernel.org with ESMTP id S271602AbTGRLT4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jul 2003 07:19:56 -0400
Date: Fri, 18 Jul 2003 13:34:36 +0200
From: Wiktor Wodecki <wodecki@gmx.de>
To: Con Kolivas <kernel@kolivas.org>
Cc: Mike Galbraith <efault@gmx.de>, Nick Piggin <piggin@cyberone.com.au>,
       Davide Libenzi <davidel@xmailserver.org>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>
Subject: Re: [PATCH] O6int for interactivity
Message-ID: <20030718113436.GA627@gmx.de>
References: <5.2.1.1.2.20030718071656.01af84d0@pop.gmx.net> <5.2.1.1.2.20030718120229.01a8fcf0@pop.gmx.net> <20030718103105.GE622@gmx.de> <200307182043.06029.kernel@kolivas.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="XsQoSWH+UP9D9v3l"
Content-Disposition: inline
In-Reply-To: <200307182043.06029.kernel@kolivas.org>
X-message-flag: Linux - choice of the GNU generation
X-Operating-System: Linux 2.6.0-test1-mm1-O6 i686
X-PGP-KeyID: 182C9783
X-Info: X-PGP-KeyID, send an email with the subject 'public key request' to wodecki@gmx.de
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--XsQoSWH+UP9D9v3l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 18, 2003 at 08:43:05PM +1000, Con Kolivas wrote:
> On Fri, 18 Jul 2003 20:31, Wiktor Wodecki wrote:
> > On Fri, Jul 18, 2003 at 12:18:33PM +0200, Mike Galbraith wrote:
> > > That _might_ (add salt) be priorities of kernel threads dropping too =
low.
> > >
> > > I'm also seeing occasional total stalls under heavy I/O in the order =
of
> > > 10-12 seconds (even the disk stops).  I have no idea if that's someth=
ing
> > > in mm or the scheduler changes though, as I've yet to do any isolation
> > > and/or tinkering.  All I know at this point is that I haven't seen it=
 in
> > > stock yet.
> >
> > I've seen this too while doing a huge nfs transfer from a 2.6 machine to
> > a 2.4 machine (sparc32). Thought it'd be something with the nfs changes
> > which were recently, might be the scheduler, tho. Ah, and it is fully
> > reproducable.
>=20
> Well I didn't want to post this yet because I'm not sure if it's a good=
=20
> workaround yet but it looks like a reasonable compromise, and since you h=
ave a=20
> testcase it will be interesting to see if it addresses it. It's possible =
that=20
> a task is being requeued every millisecond, and this is a little smarter.=
 It=20
> allows cpu hogs to run for 100ms before being round robinned, but shorter=
 for=20
> interactive tasks. Can you try this O7 which applies on top of O6.1 pleas=
e:
>=20
> available here:
> http://kernel.kolivas.org/2.5

sorry, the problem still persists. Aborting the cp takes less time, tho
(about 10 seconds now, before it was about 30 secs). I'm aborting during
a big file, FYI.

>=20
> and here:
>=20
> --- linux-2.6.0-test1-mm1/kernel/sched.c	2003-07-17 19:59:16.000000000 +1=
000
> +++ linux-2.6.0-testck1/kernel/sched.c	2003-07-18 00:10:55.000000000 +1000
> @@ -1310,10 +1310,12 @@ void scheduler_tick(int user_ticks, int=20
>  			enqueue_task(p, rq->expired);
>  		} else
>  			enqueue_task(p, rq->active);
> -	} else if (p->prio < effective_prio(p)){
> +	} else if (!((task_timeslice(p) - p->time_slice) %
> +		 (MIN_TIMESLICE * (MAX_BONUS + 1 - p->sleep_avg * MAX_BONUS / MAX_SLEE=
P_AVG)))){
>  		/*
> -		 * Tasks that have lowered their priority are put to the end
> -		 * of the active array with their remaining timeslice
> +		 * Running tasks get requeued with their remaining timeslice
> +		 * after a period proportional to how cpu intensive they are to
> +		 * minimise the duration one interactive task can starve another
>  		 */
>  		dequeue_task(p, rq->active);
>  		set_tsk_need_resched(p);
>=20
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

--=20
Regards,

Wiktor Wodecki

--XsQoSWH+UP9D9v3l
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE/F9tM6SNaNRgsl4MRAgyEAJ41d7Fi95ZeELQMHpAKRMyU2DPl7gCdGUL/
d1EblL+uy3vU+UJAJ+SzYTw=
=V3rC
-----END PGP SIGNATURE-----

--XsQoSWH+UP9D9v3l--
