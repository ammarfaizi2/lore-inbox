Return-Path: <linux-kernel-owner+w=401wt.eu-S1751779AbXAOCHz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751779AbXAOCHz (ORCPT <rfc822;w@1wt.eu>);
	Sun, 14 Jan 2007 21:07:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751780AbXAOCHz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Jan 2007 21:07:55 -0500
Received: from ozlabs.org ([203.10.76.45]:44035 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751779AbXAOCHy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Jan 2007 21:07:54 -0500
Subject: Re: [PATCH] Cell SPU task notification
From: Michael Ellerman <michael@ellerman.id.au>
Reply-To: michael@ellerman.id.au
To: Maynard Johnson <maynardj@us.ibm.com>
Cc: cbe-oss-dev@ozlabs.org, linux-kernel@vger.kernel.org,
       linuxppc-dev@ozlabs.org, Arnd Bergmann <arnd.bergmann@de.ibm.com>
In-Reply-To: <45A805A0.2080000@us.ibm.com>
References: <45A805A0.2080000@us.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-AVX79Qe2LogecPhSuc8P"
Date: Mon, 15 Jan 2007 13:07:51 +1100
Message-Id: <1168826871.4622.32.camel@concordia.ozlabs.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-AVX79Qe2LogecPhSuc8P
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

> Subject: Enable SPU switch notification to detect currently active SPU ta=
sks.
>=20
> From: Maynard Johnson <maynardj@us.ibm.com>
>=20
> This patch adds to the capability of spu_switch_event_register so that th=
e
> caller is also notified of currently active SPU tasks.  It also exports
> spu_switch_event_register and spu_switch_event_unregister.

Hi Maynard,

It'd be really good if you could convince your mailer to send patches inlin=
e :)

> Index: linux-2.6.19-rc6-arnd1+patches/arch/powerpc/platforms/cell/spufs/s=
ched.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-2.6.19-rc6-arnd1+patches.orig/arch/powerpc/platforms/cell/spufs=
/sched.c	2006-12-04 10:56:04.730698720 -0600
> +++ linux-2.6.19-rc6-arnd1+patches/arch/powerpc/platforms/cell/spufs/sche=
d.c	2007-01-11 09:45:37.918333128 -0600
> @@ -46,6 +46,8 @@
> =20
>  #define SPU_MIN_TIMESLICE 	(100 * HZ / 1000)
> =20
> +int notify_active[MAX_NUMNODES];

You're basing the size of the array on MAX_NUMNODES
(1 << CONFIG_NODES_SHIFT), but then indexing it by spu->number.

It's quite possible we'll have a system with MAX_NUMNODES =3D=3D 1, but > 1
spus, in which case this code is going to break. The PS3 is one such
system.

Instead I think you should have a flag in the spu struct.

>  #define SPU_BITMAP_SIZE (((MAX_PRIO+BITS_PER_LONG)/BITS_PER_LONG)+1)
>  struct spu_prio_array {
>  	unsigned long bitmap[SPU_BITMAP_SIZE];
> @@ -81,18 +83,45 @@
>  static void spu_switch_notify(struct spu *spu, struct spu_context *ctx)
>  {
>  	blocking_notifier_call_chain(&spu_switch_notifier,
> -			    ctx ? ctx->object_id : 0, spu);
> +				     ctx ? ctx->object_id : 0, spu);
> +}

Try not to make whitespace only changes in the same patch as actual code ch=
anges.

> +
> +static void notify_spus_active(void)
> +{
> +	int node;
> +	/* Wake up the active spu_contexts. When the awakened processes=20
> +	 * sees their notify_active flag is set, they will call
> +	 * spu_notify_already_active().
> +	 */
> +	for (node =3D 0; node < MAX_NUMNODES; node++) {
> +		struct spu *spu;
> +		mutex_lock(&spu_prio->active_mutex[node]);
> +                list_for_each_entry(spu, &spu_prio->active_list[node], l=
ist) {
> +			struct spu_context *ctx =3D spu->ctx;
> +			wake_up_all(&ctx->stop_wq);
> +			notify_active[ctx->spu->number] =3D 1;
> +			smp_mb();
> +		}

I don't understand why you're setting the notify flag after you do the
wake_up_all() ?

You only need a smp_wmb() here.

Does the scheduler guarantee that ctxs won't swap nodes? Otherwise
between releasing the lock on one node and getting the lock on the next,
a ctx could migrate between them - which would cause either spurious
wake ups, or missing a ctx altogether. Although I'm not sure if it's
that important.

> +                mutex_unlock(&spu_prio->active_mutex[node]);
> +	}
> +	yield();
>  }
> =20
>  int spu_switch_event_register(struct notifier_block * n)
>  {
> -	return blocking_notifier_chain_register(&spu_switch_notifier, n);
> +	int ret;
> +	ret =3D blocking_notifier_chain_register(&spu_switch_notifier, n);
> +	if (!ret)
> +		notify_spus_active();
> +	return ret;
>  }
> +EXPORT_SYMBOL_GPL(spu_switch_event_register);
> =20
>  int spu_switch_event_unregister(struct notifier_block * n)
>  {
>  	return blocking_notifier_chain_unregister(&spu_switch_notifier, n);
>  }
> +EXPORT_SYMBOL_GPL(spu_switch_event_unregister);
> =20
> =20
>  static inline void bind_context(struct spu *spu, struct spu_context *ctx=
)
> @@ -250,6 +279,14 @@
>  	return spu_get_idle(ctx, flags);
>  }
> =20
> +void spu_notify_already_active(struct spu_context *ctx)
> +{
> +	struct spu *spu =3D ctx->spu;
> +	if (!spu)
> +		return;
> +	spu_switch_notify(spu, ctx);
> +}
> +
>  /* The three externally callable interfaces
>   * for the scheduler begin here.
>   *
> Index: linux-2.6.19-rc6-arnd1+patches/arch/powerpc/platforms/cell/spufs/s=
pufs.h
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-2.6.19-rc6-arnd1+patches.orig/arch/powerpc/platforms/cell/spufs=
/spufs.h	2007-01-08 18:18:40.093354608 -0600
> +++ linux-2.6.19-rc6-arnd1+patches/arch/powerpc/platforms/cell/spufs/spuf=
s.h	2007-01-08 18:31:03.610345792 -0600
> @@ -183,6 +183,7 @@
>  void spu_yield(struct spu_context *ctx);
>  int __init spu_sched_init(void);
>  void __exit spu_sched_exit(void);
> +void spu_notify_already_active(struct spu_context *ctx);
> =20
>  extern char *isolated_loader;
> =20
> Index: linux-2.6.19-rc6-arnd1+patches/arch/powerpc/platforms/cell/spufs/r=
un.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-2.6.19-rc6-arnd1+patches.orig/arch/powerpc/platforms/cell/spufs=
/run.c	2007-01-08 18:33:51.979311680 -0600
> +++ linux-2.6.19-rc6-arnd1+patches/arch/powerpc/platforms/cell/spufs/run.=
c	2007-01-11 10:17:20.777344984 -0600
> @@ -10,6 +10,8 @@
> =20
>  #include "spufs.h"
> =20
> +extern int notify_active[MAX_NUMNODES];
> +
>  /* interrupt-level stop callback function. */
>  void spufs_stop_callback(struct spu *spu)
>  {
> @@ -45,7 +47,9 @@
>  	u64 pte_fault;
> =20
>  	*stat =3D ctx->ops->status_read(ctx);
> -	if (ctx->state !=3D SPU_STATE_RUNNABLE)
> +	smp_mb();

And smp_rmb() should be sufficient here.

> +	if (ctx->state !=3D SPU_STATE_RUNNABLE || notify_active[ctx->spu->numbe=
r])
>  		return 1;
>  	spu =3D ctx->spu;
>  	pte_fault =3D spu->dsisr &
> @@ -319,6 +323,11 @@
>  		ret =3D spufs_wait(ctx->stop_wq, spu_stopped(ctx, &status));
>  		if (unlikely(ret))
>  			break;
> +		if (unlikely(notify_active[ctx->spu->number])) {
> +			notify_active[ctx->spu->number] =3D 0;
> +			if (!(status & SPU_STATUS_STOPPED_BY_STOP))
> +				spu_notify_already_active(ctx);
> +		}
>  		if ((status & SPU_STATUS_STOPPED_BY_STOP) &&
>  		    (status >> SPU_STOP_STATUS_SHIFT =3D=3D 0x2104)) {
>  			ret =3D spu_process_callback(ctx);

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-AVX79Qe2LogecPhSuc8P
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)

iD8DBQBFquH3dSjSd0sB4dIRAhuVAJ4jb8hKSWR1Bz2doF2Sl0j41tNISACfRMcx
i8WBYYqUa7mwYmJPfpUpYg8=
=kQfD
-----END PGP SIGNATURE-----

--=-AVX79Qe2LogecPhSuc8P--

