Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267767AbUJRXUh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267767AbUJRXUh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Oct 2004 19:20:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267783AbUJRXUg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Oct 2004 19:20:36 -0400
Received: from mail.metronet.co.uk ([213.162.97.75]:746 "EHLO
	mail.metronet.co.uk") by vger.kernel.org with ESMTP id S267767AbUJRXU1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Oct 2004 19:20:27 -0400
Date: Tue, 19 Oct 2004 00:18:18 +0100
From: Alexander Clouter <alex@digriz.org.uk>
To: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
Cc: Dominik Brodowski <linux@dominikbrodowski.de>, cpufreq@www.linux.org.uk,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpufreq_ondemand
Message-ID: <20041018231818.GA19954@inskipp.digriz.org.uk>
References: <88056F38E9E48644A0F562A38C64FB60031DA62A@scsmsx403.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Q68bSM7Ycu6FN28Q"
Content-Disposition: inline
In-Reply-To: <88056F38E9E48644A0F562A38C64FB60031DA62A@scsmsx403.amr.corp.intel.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Q68bSM7Ycu6FN28Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Oct 18, Pallipadi, Venkatesh wrote:
>=20
> >The improvements (well I think they are) I have made:
> >
> >1. I have replaced the algoritm it used to one which=20
> >calculates the number of
> >	cpu idle cycles that have passed and compares it to the=20
> >number of cpu
> >	cycles it would have expected to pass (for, the=20
> >defaults, 20%/80%)
> >
> >	this means a couple of divisions have been removed,=20
> >which is always=20
> >	nice and it lead to clearer code (for me at least), that was=20
> >	until I added the handful of 'if' conditionals though.... :-/
>=20
>=20
> Good idea. This part of the patch has to go into ondemand governor.
>
What I will do over the next few days is split up the patch to little bits=
=20
(seems to keep the kernel gods happier, cannot say I blame them) and then=
=20
post that for you all to pull apart and mull over?

> But, I think there is a minor bug in the code though.
> With current ondemand governor, we poll at some X freq and check=20
> whether we need to increase the freq. And with some Y freq (Y > X and=20
> a multiple of it), we check whether we need to decrase the freq.
> That is the reason I have two different variables=20
> prev_cpu_idle_down and prev_cpu_idle_up to store the previous idle=20
> times at these two different polling intervals (X and Y).
> Now, you have previous idle time at only one point. So, this may=20
> not work cleanly. From the code I feel what will happen is
> You will only see the CPU activity in last X time and decide on=20
> frequency down decisions (even though you check this with Y polling=20
> interval). Not sure whether I was clear with this explanation.
>=20
My code records the number of both the total idle ticks and the overall tic=
ks
at the last interval.  This means if I subtract those values for the ones at
the next interval I can work out what the 'cpu use' is over that period tha=
ts
just passed by looking at the percentage difference between (total-idle) an=
d=20
if it trips the expected values if an increase or decrease in frequency was=
=20
needed.

This is really the main reason why the polling interval has to be decreased=
=20
by a large amount (I make it occur 50 times fewer times) so the period does=
=20
not get skewed by *very* brief cpu spikes.

> Note, I haven't really run your version yet. This is what=20
> I feel by looking at the patch. I may well be wrong.
>=20
Well in the fashion of the netfilter folk, "Works for Me(tm)" :)  Sitting=
=20
there with 'watch' on /sys/.../ondemand/requested_freq seems to return=20
perfectly sane results.

> > 2. controllable through=20
> >	/sys/.../ondemand/ignore_nice, you can tell it to=20
> >consider 'nice'=20
> >	time as also idle cpu cycles.  Set it to '1' to treat=20
> >'nice' as cpu=20
> >	in an active state.
> >
>=20
> OK. This has to be in ondemand governor as well.
>=20
I'll split this out as I think it should be in there.

> >3. (major) the scaling up and down of the cpufreq is now=20
> >smoother.  I found=20
> >	it really nasty that if it tripped < 20% idle time that=20
> >the freq was=20
> >	set to 100%.  This code smoothly increases the cpufreq=20
> >as well as=20
> >	doing a better job of decreasing it too
> >
> >4. (minor) I changed DEF_SAMPLING_RATE_LATENCY_MULTIPLIER to 50000 and
> >	DEF_SAMPLING_DOWN_FACTOR to 5 as I found the defaults a=20
> >bit annoying=20
> >	on my system and resulted in the cpufreq constantly jumping.
> >
> >	For my patch it works far better if the sampling rate=20
> >is much lower=20
> >	anyway, which can only be good for cpu efficiency in=20
> >the long run
>=20
> Somehow, I feel quick response time for increased load is more=20
> important than smooth increase in frequency. As the CPU latency for=20
> doing the freq transition is lower, I think governor should use that=20
> and do quick adjustments to the freq depending on the load. Probably, I=
=20
> am thinking more in terms of places where performance is critical.
> As Dominik pointed out, it's the time to fork put a new ondemand=20
> governor with this algorithm....
>=20
I have been chatting to a few people and on desktop machines this is the
behaviour they of course prefer.  Overshoot and then pull down.  However all
us laptop users have a crotch to protect :) We (well four people out of the
*whole* linux community; better than a US poll I hear though) we prefer a
overly conservative approach; hence my approach.  I did write it to suit mo=
re
my needs obviously :)

> >5. the grainity of how much cpufreq is increased or decreased=20
> >is controlled=20
> >	with sending a percentage to /sys/.../ondemand/freq_step_percent
> >
> >6. debugging (with 'watch -n1 cat=20
> >/sys/.../ondemand/requested_freq') and=20
> >	backwards 'compatibility' to act like the 'userspace'=20
> >governor is=20
> >	avaliable with /sys/.../ondemand/requested_freq if=20
> >	'freq_step_percent' is set to zero
>=20
> I again agree with Dominik's opinion on this :)
>=20
guess the world domination plans go back to....

1. steal all the pants....
2. ....
3. rule the world

I do though think the step_freq bit should be there.

> Thanks for all the experiments and all these improvements.
> I will rollout a patch for ondemand governor soon, by=20
> stealing some code from your patch below :)
>=20
Not a problem.  I'm in a 'powersaving' mode so will race you if you want to
produce those patches :) After that I have to tell 'wmpower' its a Bad
Idea(tm) to suck up 5% cpu time to poll for the whole ACPI state every 0.5s
with a host of other major issues :-/ Then there is....and...<complains to
himself>

Cheers all

Alex

--=20
 _____________________________________=20
/ A bird in the hand is worth what it \
\ will bring.                         /
 -------------------------------------=20
        \   ^__^
         \  (oo)\_______
            (__)\       )\/\
                ||----w |
                ||     ||

--Q68bSM7Ycu6FN28Q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFBdE86Nv5Ugh/sRBYRAifiAKCRt5T1PjmEG4m//sDMrRXlpN32yQCeKvO7
/rj62D1JymGODPczjjVhIlI=
=K0Yw
-----END PGP SIGNATURE-----

--Q68bSM7Ycu6FN28Q--
