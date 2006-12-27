Return-Path: <linux-kernel-owner+w=401wt.eu-S932884AbWL0BuU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932884AbWL0BuU (ORCPT <rfc822;w@1wt.eu>);
	Tue, 26 Dec 2006 20:50:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932883AbWL0BuU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Dec 2006 20:50:20 -0500
Received: from iucha.net ([209.98.146.184]:46059 "EHLO mail.iucha.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932881AbWL0BuS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Dec 2006 20:50:18 -0500
Date: Tue, 26 Dec 2006 19:50:17 -0600
To: Ingo Molnar <mingo@elte.hu>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: Linux 2.6.20-rc2
Message-ID: <20061227015017.GE22307@iucha.net>
References: <20061225224047.GB6087@iucha.net> <20061225225616.GA22307@iucha.net> <20061226022538.13ea8b3f.akpm@osdl.org> <20061226124019.GA3701@elte.hu> <20061226142041.GC22307@iucha.net> <20061226152224.GA27528@elte.hu> <20061226234206.GD22307@iucha.net> <20061226234253.GA7523@elte.hu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="k1BdFSKqAqVdu8k/"
Content-Disposition: inline
In-Reply-To: <20061226234253.GA7523@elte.hu>
X-GPG-Key: http://iucha.net/florin_iucha.gpg
X-GPG-Fingerprint: 5E59 C2E7 941E B592 3BA4  7DCF 343D 2B14 2376 6F5B
User-Agent: Mutt/1.5.13 (2006-08-11)
From: florin@iucha.net (Florin Iucha)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--k1BdFSKqAqVdu8k/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 27, 2006 at 12:42:53AM +0100, Ingo Molnar wrote:
> * Florin Iucha <florin@iucha.net> wrote:
> > I saw your subsequent message and will apply the patch, retest and=20
> > report.
>=20
> yeah. Just to make sure i've attached the latest and greatest version of=
=20
> the patch - please make sure you have this one applied.

The good news is, with this patch there is no oops.

The bad news is, the USB keyboard is still not functioning, but the
mice plugged in the keyboard hub are working.

One down, one more to go...

florin

> ---------------------->
> Subject: [patch] sched: fix cond_resched_softirq() offset
> From: Ingo Molnar <mingo@elte.hu>
>=20
> remove the __resched_legal() check: it is conceptually broken.
> The biggest problem it had is that it can mask buggy cond_resched()
> calls. A cond_resched() call is only legal if we are not in an
> atomic context, with two narrow exceptions:
>=20
>  - if the system is booting
>  - a reacquire_kernel_lock() down() done while PREEMPT_ACTIVE is set
>=20
> But __resched_legal() hid this and just silently returned whenever
> these primitives were called from invalid contexts. (Same goes for
> cond_resched_locked() and cond_resched_softirq()).
>=20
> furthermore, the __legal_resched(0) call was buggy in that it caused
> unnecessarily long softirq latencies via cond_resched_softirq(). (which
> is only called from softirq-off sections, hence the code did nothing.)
>=20
> the fix is to resurrect the efficiency of the might_sleep checks and to
> only allow the narrow exceptions.
>=20
> Signed-off-by: Ingo Molnar <mingo@elte.hu>
> ---
>  kernel/sched.c |   18 ++++--------------
>  1 file changed, 4 insertions(+), 14 deletions(-)
>=20
> Index: linux/kernel/sched.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux.orig/kernel/sched.c
> +++ linux/kernel/sched.c
> @@ -4617,17 +4617,6 @@ asmlinkage long sys_sched_yield(void)
>  	return 0;
>  }
> =20
> -static inline int __resched_legal(int expected_preempt_count)
> -{
> -#ifdef CONFIG_PREEMPT
> -	if (unlikely(preempt_count() !=3D expected_preempt_count))
> -		return 0;
> -#endif
> -	if (unlikely(system_state !=3D SYSTEM_RUNNING))
> -		return 0;
> -	return 1;
> -}
> -
>  static void __cond_resched(void)
>  {
>  #ifdef CONFIG_DEBUG_SPINLOCK_SLEEP
> @@ -4647,7 +4636,8 @@ static void __cond_resched(void)
> =20
>  int __sched cond_resched(void)
>  {
> -	if (need_resched() && __resched_legal(0)) {
> +	if (need_resched() && !(preempt_count() & PREEMPT_ACTIVE) &&
> +					system_state =3D=3D SYSTEM_RUNNING) {
>  		__cond_resched();
>  		return 1;
>  	}
> @@ -4673,7 +4663,7 @@ int cond_resched_lock(spinlock_t *lock)
>  		ret =3D 1;
>  		spin_lock(lock);
>  	}
> -	if (need_resched() && __resched_legal(1)) {
> +	if (need_resched() && system_state =3D=3D SYSTEM_RUNNING) {
>  		spin_release(&lock->dep_map, 1, _THIS_IP_);
>  		_raw_spin_unlock(lock);
>  		preempt_enable_no_resched();
> @@ -4689,7 +4679,7 @@ int __sched cond_resched_softirq(void)
>  {
>  	BUG_ON(!in_softirq());
> =20
> -	if (need_resched() && __resched_legal(0)) {
> +	if (need_resched() && system_state =3D=3D SYSTEM_RUNNING) {
>  		raw_local_irq_disable();
>  		_local_bh_enable();
>  		raw_local_irq_enable();
>=20

--=20
Bruce Schneier expects the Spanish Inquisition.
      http://geekz.co.uk/schneierfacts/fact/163

--k1BdFSKqAqVdu8k/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFFkdFZND0rFCN2b1sRAkhpAJ97xzTyvpPy3GNkJxhtR6NBCMtUQgCbBrZK
8H3LFskKYSS97GKMRdWpd4A=
=XFmd
-----END PGP SIGNATURE-----

--k1BdFSKqAqVdu8k/--
