Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261374AbVDZH20@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261374AbVDZH20 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Apr 2005 03:28:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261381AbVDZH2Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Apr 2005 03:28:25 -0400
Received: from user-edvans3.msk.internet2.ru ([217.25.93.4]:41421 "EHLO
	vocord.com") by vger.kernel.org with ESMTP id S261374AbVDZH2A (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Apr 2005 03:28:00 -0400
Subject: Re: [RFC/PATCH 0/22] W1: sysfs, lifetime and other fixes
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Reply-To: johnpol@2ka.mipt.ru
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: sensors@stimpy.netroedge.com, LKML <linux-kernel@vger.kernel.org>,
       Greg KH <gregkh@suse.de>
In-Reply-To: <200504260216.10560.dtor_core@ameritech.net>
References: <200504210207.02421.dtor_core@ameritech.net>
	 <200504260150.00948.dtor_core@ameritech.net>
	 <1114499202.8527.85.camel@uganda>
	 <200504260216.10560.dtor_core@ameritech.net>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-xtI4sTyX2BQNX2z0Pxsd"
Organization: MIPT
Date: Tue, 26 Apr 2005 11:35:11 +0400
Message-Id: <1114500911.8527.105.camel@uganda>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-2) 
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.4 (vocord.com [192.168.0.1]); Tue, 26 Apr 2005 11:27:41 +0400 (MSD)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-xtI4sTyX2BQNX2z0Pxsd
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2005-04-26 at 02:16 -0500, Dmitry Torokhov wrote:

> > > > It has explicit barrieres, which guarantees that
> > > > there will not be atomic operation vs. non atomic
> > > > reordering.=20
> > >=20
> > > And you can't use explicit barriers - why exactly?
> >=20
> > I used them - code was following:
> > smp_mb__before_atomic_dec();
> > atomic_dec();
> > smp_mb__after_atomic_dec();
> >=20
> > I think simple atomic_dec_and_test() or even atomic_dec_and_lock()
> > is better.
>=20
> This is usually indicates that there some kiond of a problem. Consider
> following fragment:
>=20
> > +static void cn_queue_wrapper(void *data)
> > +{
> > +       struct cn_callback_entry *cbq =3D (struct cn_callback_entry *)d=
ata;
> > +
> > +       atomic_inc_and_test(&cbq->cb->refcnt);
> > +       cbq->cb->callback(cbq->cb->priv);
> > +       atomic_dec_and_test(&cbq->cb->refcnt);
> >=20
>=20
> What exactly this refcount protects? Can it be that other code decrements
> refcount and frees the object right when one CPU is entering this functio=
n?
> If not that means that cb structure is protected by some other means, so
> why we need to increment refcout here and consider ordering?

It does not needed there. I pointed it to Andrew when we discuss it=20
couple of weeks ago, but forget to remove.

> Btw, cb refcount can be complelely removed, something like the patch belo=
w
> (won't apply cleanly as I have some other stuff).

I will think of it some more, probably you are right,
it looks like flush_workqueue() is sufficient for that.

> --=20
> Dmitry
>=20
>  drivers/connector/cn_queue.c |   85 +++++++++++-------------------------=
-------
>  include/linux/connector.h    |    2 -
>  2 files changed, 23 insertions(+), 64 deletions(-)
>=20
> Index: linux-2.6.11/drivers/connector/cn_queue.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-2.6.11.orig/drivers/connector/cn_queue.c
> +++ linux-2.6.11/drivers/connector/cn_queue.c
> @@ -33,49 +33,12 @@
> =20
>  static void cn_queue_wrapper(void *data)
>  {
> -	struct cn_callback_entry *cbq =3D (struct cn_callback_entry *)data;
> +	struct cn_callback_entry *cbq =3D data;
> =20
> -	atomic_inc_and_test(&cbq->cb->refcnt);
>  	cbq->cb->callback(cbq->cb->priv);
> -	atomic_dec_and_test(&cbq->cb->refcnt);
> -
>  	cbq->destruct_data(cbq->ddata);
>  }
> =20
> -static struct cn_callback_entry *cn_queue_alloc_callback_entry(struct cn=
_callback *cb)
> -{
> -	struct cn_callback_entry *cbq;
> -
> -	cbq =3D kmalloc(sizeof(*cbq), GFP_KERNEL);
> -	if (!cbq) {
> -		printk(KERN_ERR "Failed to create new callback queue.\n");
> -		return NULL;
> -	}
> -
> -	memset(cbq, 0, sizeof(*cbq));
> -
> -	cbq->cb =3D cb;
> -
> -	INIT_WORK(&cbq->work, &cn_queue_wrapper, cbq);
> -
> -	return cbq;
> -}
> -
> -static void cn_queue_free_callback(struct cn_callback_entry *cbq)
> -{
> -	cancel_delayed_work(&cbq->work);
> -	flush_workqueue(cbq->pdev->cn_queue);
> -
> -	while (atomic_read(&cbq->cb->refcnt)) {
> -		printk(KERN_INFO "Waiting for %s to become free: refcnt=3D%d.\n",
> -		       cbq->pdev->name, atomic_read(&cbq->cb->refcnt));
> -
> -		msleep(1000);
> -	}
> -
> -	kfree(cbq);
> -}
> -
>  int cn_cb_equal(struct cb_id *i1, struct cb_id *i2)
>  {
>  #if 0
> @@ -90,40 +53,37 @@ int cn_cb_equal(struct cb_id *i1, struct
>  int cn_queue_add_callback(struct cn_queue_dev *dev, struct cn_callback *=
cb)
>  {
>  	struct cn_callback_entry *cbq, *__cbq;
> -	int found =3D 0;
> +	int retval =3D 0;
> =20
> -	cbq =3D cn_queue_alloc_callback_entry(cb);
> -	if (!cbq)
> +	cbq =3D kmalloc(sizeof(*cbq), GFP_KERNEL);
> +	if (!cbq) {
> +		printk(KERN_ERR "Failed to create new callback queue.\n");
>  		return -ENOMEM;
> +	}
> =20
>  	atomic_inc(&dev->refcnt);
> +
> +	memset(cbq, 0, sizeof(*cbq));
> +	INIT_WORK(&cbq->work, &cn_queue_wrapper, cbq);
> +	cbq->cb =3D cb;
>  	cbq->pdev =3D dev;
> +	cbq->nls =3D dev->nls;
> +	cbq->seq =3D 0;
> +	cbq->group =3D cbq->cb->id.idx;
> =20
>  	spin_lock_bh(&dev->queue_lock);
> +
>  	list_for_each_entry(__cbq, &dev->queue_list, callback_entry) {
>  		if (cn_cb_equal(&__cbq->cb->id, &cb->id)) {
> -			found =3D 1;
> -			break;
> +			retval =3D -EEXIST;
> +			kfree(cbq);
> +			goto out;
>  		}
>  	}
> -	if (!found) {
> -		atomic_set(&cbq->cb->refcnt, 1);
> -		list_add_tail(&cbq->callback_entry, &dev->queue_list);
> -	}
> +	list_add_tail(&cbq->callback_entry, &dev->queue_list);
> + out:
>  	spin_unlock_bh(&dev->queue_lock);
> -
> -	if (found) {
> -		atomic_dec(&dev->refcnt);
> -		atomic_set(&cbq->cb->refcnt, 0);
> -		cn_queue_free_callback(cbq);
> -		return -EINVAL;
> -	}
> -
> -	cbq->nls =3D dev->nls;
> -	cbq->seq =3D 0;
> -	cbq->group =3D cbq->cb->id.idx;
> -
> -	return 0;
> +	return retval;
>  }
> =20
>  void cn_queue_del_callback(struct cn_queue_dev *dev, struct cb_id *id)
> @@ -142,8 +102,9 @@ void cn_queue_del_callback(struct cn_que
>  	spin_unlock_bh(&dev->queue_lock);
> =20
>  	if (found) {
> -		atomic_dec(&cbq->cb->refcnt);
> -		cn_queue_free_callback(cbq);
> +		cancel_delayed_work(&cbq->work);
> +		flush_workqueue(cbq->pdev->cn_queue);
> +		kfree(cbq);
>  		atomic_dec_and_test(&dev->refcnt);
>  	}
>  }
> Index: linux-2.6.11/include/linux/connector.h
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-2.6.11.orig/include/linux/connector.h
> +++ linux-2.6.11/include/linux/connector.h
> @@ -115,8 +115,6 @@ struct cn_callback
>  	struct cb_id		id;
>  	void			(* callback)(void *);
>  	void			*priv;
> -
> -	atomic_t		refcnt;
>  };
> =20
>  struct cn_callback_entry
--=20
        Evgeniy Polyakov

Crash is better than data corruption -- Arthur Grabowski

--=-xtI4sTyX2BQNX2z0Pxsd
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBCbe8vIKTPhE+8wY0RAueJAJ9eMqO0IMmIVKM54Yj8ZFt0V1gSlQCfdIyV
6/fnxJoq8mrOHmua+ix3wc4=
=A+OA
-----END PGP SIGNATURE-----

--=-xtI4sTyX2BQNX2z0Pxsd--

