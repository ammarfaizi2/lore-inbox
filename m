Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262654AbVDAHez@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262654AbVDAHez (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Apr 2005 02:34:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262656AbVDAHek
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Apr 2005 02:34:40 -0500
Received: from dea.vocord.ru ([217.67.177.50]:43927 "EHLO vocord.com")
	by vger.kernel.org with ESMTP id S262654AbVDAHeE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Apr 2005 02:34:04 -0500
Subject: Re: cn_queue.c
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Reply-To: johnpol@2ka.mipt.ru
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050331173215.49c959a0.akpm@osdl.org>
References: <20050331173215.49c959a0.akpm@osdl.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-IErdqn7FJUag8KZDE0Jc"
Organization: MIPT
Date: Fri, 01 Apr 2005 11:40:36 +0400
Message-Id: <1112341236.9334.97.camel@uganda>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-2) 
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.4 (vocord.com [192.168.0.1]); Fri, 01 Apr 2005 11:33:58 +0400 (MSD)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-IErdqn7FJUag8KZDE0Jc
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2005-03-31 at 17:32 -0800, Andrew Morton wrote:
> > /*
> >  * 	cn_queue.c
> >  *=20
> >  * 2004 Copyright (c) Evgeniy Polyakov <johnpol@2ka.mipt.ru>
> >  * All rights reserved.
> >  *=20
> >  * This program is free software; you can redistribute it and/or modify
> >  * it under the terms of the GNU General Public License as published by
> >  * the Free Software Foundation; either version 2 of the License, or
> >  * (at your option) any later version.
> >  *
> >  * This program is distributed in the hope that it will be useful,
> >  * but WITHOUT ANY WARRANTY; without even the implied warranty of
> >  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> >  * GNU General Public License for more details.
> >  *
> >  * You should have received a copy of the GNU General Public License
> >  * along with this program; if not, write to the Free Software
> >  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307=
  USA
> >  *
> >  */
>=20
> It's conventinal to add at the start of the file a description of what it
> all does.

Yep,  I need to force myself to write better docs...

> > static void cn_queue_wrapper(void *data)
> > {
> > 	struct cn_callback_entry *cbq =3D (struct cn_callback_entry *)data;
> >=20
> > 	smp_mb__before_atomic_inc();
> > 	atomic_inc(&cbq->cb->refcnt);
> > 	smp_mb__after_atomic_inc();
> > 	cbq->cb->callback(cbq->cb->priv);
> > 	smp_mb__before_atomic_inc();
> > 	atomic_dec(&cbq->cb->refcnt);
> > 	smp_mb__after_atomic_inc();
> >=20
> > 	cbq->destruct_data(cbq->ddata);
> > }
>=20
> What on earth are all these barriers for?  Barriers should have an
> associated comment describing why they were added, and what they are
> defending against, becuase it is very hard to tell that from reading the
> code.
>=20
> Please describe (via code comments) what the refcounting rules are for
> these data structures.  It all looks very strange.  You basically have:
>=20
>=20
> 	atomic_inc(refcnt);
> 	use(some_object);
> 	atomic_dec(refcnt);
>=20
> Which looks very racy.  Some other CPU could see a zero refcount just
> before this CPU did the atomic_inc() and the other CPU will go and free u=
p
> some_object.  There should be locking associated with refcounting to
> prevent such races, and I don't see any.

It can not happen in the above case.
It can race with callback removing, but remove path=20
call cancel_delayed_work() which calls del_timer_sync(),=20
so above code can not be run or will not run,=20
only after it refcnt is being checked to be zero.
It is probably an overhead since sinchronization is done
in other places.
All above barriers are introduced to remove already not theoretical
atomic vs. non-atomic reordering [ppc64 very like it],
when reference counter must be decremented after object was used,=20
but due to reordering it can happen before use [and it will be seen
atomically on all CPUs],=20
and other CPU may free object based on knowledge that
refcnt is zero.

> > static struct cn_callback_entry *cn_queue_alloc_callback_entry(struct c=
n_callback *cb)
>=20
> 80 cols again.
>=20
> > static void cn_queue_free_callback(struct cn_callback_entry *cbq)
> > {
> > 	cancel_delayed_work(&cbq->work);
> >=20
> > 	while (atomic_read(&cbq->cb->refcnt)) {
> > 		printk(KERN_INFO "Waiting for %s to become free: refcnt=3D%d.\n",
> > 		       cbq->pdev->name, atomic_read(&cbq->cb->refcnt));
> >=20
> > 		msleep_interruptible(1000);
> >=20
> > 		if (current->flags & PF_FREEZE)
> > 			refrigerator(PF_FREEZE);
> >=20
> > 		if (signal_pending(current))
> > 			flush_signals(current);
> > 	}
> >=20
> > 	kfree(cbq);
> > }
>=20
> erp.  Can you please do this properly?
>=20
> Free the object on the refcount going to zero (with appropriate locking)?=
=20
> If you want (for some reason) to wait until all users of an object have
> gone away then you should take a ref on the object (inside locking), then
> sleep on a waitqueue_head embedded in that object.  Make all
> refcount-droppers do a wake_up.
>=20
> Why is this function playing with signals?

It is not, just can be interrupted to check state befor timeout expires.
It is not a problem to remove signal interrupting here.

> > int cn_cb_equal(struct cb_id *i1, struct cb_id *i2)
> > {
> > #if 0
> > 	printk(KERN_INFO "%s: comparing %04x.%04x and %04x.%04x\n",
> > 			__func__,
> > 			i1->idx, i1->val,
> > 			i2->idx, i2->val);
> > #endif
> > 	return ((i1->idx =3D=3D i2->idx) && (i1->val =3D=3D i2->val));
> > }
>=20
> Please review all functions, check that they really need kernel-wide scop=
e.

It is not exported, but is used in the other files which build
connector.
Only callback adding/removing and message sending functions are
exported.

> Please comment all functions.

Yep...

> > int cn_queue_add_callback(struct cn_queue_dev *dev, struct cn_callback =
*cb)
> > {
> > 	struct cn_callback_entry *cbq, *n, *__cbq;
> > 	int found =3D 0;
> >=20
> > 	cbq =3D cn_queue_alloc_callback_entry(cb);
> > 	if (!cbq)
> > 		return -ENOMEM;
> >=20
> > 	atomic_inc(&dev->refcnt);
> > 	smp_mb__after_atomic_inc();
> > 	cbq->pdev =3D dev;
> >=20
> > 	spin_lock_bh(&dev->queue_lock);
> > 	list_for_each_entry_safe(__cbq, n, &dev->queue_list, callback_entry) {
> > 		if (cn_cb_equal(&__cbq->cb->id, &cb->id)) {
> > 			found =3D 1;
> > 			break;
> > 		}
> > 	}
> > 	if (!found) {
> > 		atomic_set(&cbq->cb->refcnt, 1);
> > 		list_add_tail(&cbq->callback_entry, &dev->queue_list);
> > 	}
> > 	spin_unlock_bh(&dev->queue_lock);
>=20
> Why use spin_lock_bh()?  Does none of this code ever get called from IRQ
> context?

Test documentation module that lives in
Documentation/connector/cn_test.c
describes different usage cases for connector, and it uses
cn_netlink_send()
from irq context, which may race with the callback adding/removing.

> > 	if (found) {
> > 		smp_mb__before_atomic_inc();
> > 		atomic_dec(&dev->refcnt);
> > 		smp_mb__after_atomic_inc();
> > 		atomic_set(&cbq->cb->refcnt, 0);
> > 		cn_queue_free_callback(cbq);
> > 		return -EINVAL;
> > 	}
>=20
> More strange barriers.  This practice seems to be unique to this part of =
the
> kernel.  That's probably a bad sign.

It was introduced recently in network stack, where skb may be freed
erroneously due to atomic reordering.
It is similar case.
It could be just smb_mb(), but it is more expensive.

>=20
> > struct cn_queue_dev *cn_queue_alloc_dev(char *name, struct sock *nls)
> > {
> > 	struct cn_queue_dev *dev;
> >=20
> > 	dev =3D kmalloc(sizeof(*dev), GFP_KERNEL);
> > 	if (!dev) {
> > 		printk(KERN_ERR "%s: Failed to allocte new struct cn_queue_dev.\n",
> > 		       name);
> > 		return NULL;
> > 	}
> >=20
> > 	memset(dev, 0, sizeof(*dev));
> >=20
> > 	snprintf(dev->name, sizeof(dev->name), "%s", name);
>=20
> scnprintf?

Return value is ignored here, but I will change function though.

> > void cn_queue_free_dev(struct cn_queue_dev *dev)
> > {
> > 	struct cn_callback_entry *cbq, *n;
> >=20
> > 	flush_workqueue(dev->cn_queue);
> > 	destroy_workqueue(dev->cn_queue);
> >=20
> > 	spin_lock_bh(&dev->queue_lock);
> > 	list_for_each_entry_safe(cbq, n, &dev->queue_list, callback_entry) {
> > 		list_del(&cbq->callback_entry);
> > 		smp_mb__before_atomic_inc();
> > 		atomic_dec(&cbq->cb->refcnt);
> > 		smp_mb__after_atomic_inc();
> > 	}
> > 	spin_unlock_bh(&dev->queue_lock);
> >=20
> > 	while (atomic_read(&dev->refcnt)) {
> > 		printk(KERN_INFO "Waiting for %s to become free: refcnt=3D%d.\n",
> > 		       dev->name, atomic_read(&dev->refcnt));
> >=20
> > 		msleep_interruptible(1000);
> >=20
> > 		if (current->flags & PF_FREEZE)
> > 			refrigerator(PF_FREEZE);
> >=20
> > 		if (signal_pending(current))
> > 			flush_signals(current);
> > 	}
> >=20
> > 	memset(dev, 0, sizeof(*dev));
> > 	kfree(dev);
> > 	dev =3D NULL;
> > }
>=20
> Again, why is this code playing with signals?  Hopefully it is never call=
ed
> by user tasks - that would be very bad.

I will remove signal interrupting.

According to wait queue inside the object - it can have it, but it will
be used only for waiting and repeated checking in a slow path.
Let's postpone it for now until other isssues are resolved first.

> With proper refcounting and lifetime management and the use of the kthrea=
d
> API we should be able to make all this go away.
>=20
> Once we're trying to free up the controlling device, what prevents new
> messages from being queued?

Before callback device is removed it is unregistered from the callback
subsystem,
so all messages will be discarded, until main socket is removed
(actually only released so it can be properly freed in network subsystem
later).


Andrew, thank you for your comments,=20
I will cook up patches against your tree soon.

--=20
        Evgeniy Polyakov

Crash is better than data corruption -- Arthur Grabowski

--=-IErdqn7FJUag8KZDE0Jc
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBCTPr0IKTPhE+8wY0RAidNAJ9yOZZeescSSPQ6uetHfjghaLrg3QCgkdXb
pmlWtN5rdiPr4AxUd5DowSE=
=UhOR
-----END PGP SIGNATURE-----

--=-IErdqn7FJUag8KZDE0Jc--

