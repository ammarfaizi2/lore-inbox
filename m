Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261680AbVDAId5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261680AbVDAId5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Apr 2005 03:33:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261750AbVDAId5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Apr 2005 03:33:57 -0500
Received: from dea.vocord.ru ([217.67.177.50]:12719 "EHLO vocord.com")
	by vger.kernel.org with ESMTP id S261680AbVDAIdn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Apr 2005 03:33:43 -0500
Subject: Re: cn_queue.c
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Reply-To: johnpol@2ka.mipt.ru
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050331235706.5b5981db.akpm@osdl.org>
References: <20050331173215.49c959a0.akpm@osdl.org>
	 <1112341236.9334.97.camel@uganda>  <20050331235706.5b5981db.akpm@osdl.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-yHCa/8LZWy/E4heVd7B4"
Organization: MIPT
Date: Fri, 01 Apr 2005 12:40:11 +0400
Message-Id: <1112344811.9334.146.camel@uganda>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-2) 
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.4 (vocord.com [192.168.0.1]); Fri, 01 Apr 2005 12:33:33 +0400 (MSD)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-yHCa/8LZWy/E4heVd7B4
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2005-03-31 at 23:57 -0800, Andrew Morton wrote:
> Evgeniy Polyakov <johnpol@2ka.mipt.ru> wrote:
> >
> > > > static void cn_queue_wrapper(void *data)
> > > > {
> > > > 	struct cn_callback_entry *cbq =3D (struct cn_callback_entry *)data=
;
> > > >=20
> > > > 	smp_mb__before_atomic_inc();
> > > > 	atomic_inc(&cbq->cb->refcnt);
> > > > 	smp_mb__after_atomic_inc();
> > > > 	cbq->cb->callback(cbq->cb->priv);
> > > > 	smp_mb__before_atomic_inc();
> > > > 	atomic_dec(&cbq->cb->refcnt);
> > > > 	smp_mb__after_atomic_inc();
> > > >=20
> > > > 	cbq->destruct_data(cbq->ddata);
> > > > }
> > >=20
> > > What on earth are all these barriers for?  Barriers should have an
> > > associated comment describing why they were added, and what they are
> > > defending against, becuase it is very hard to tell that from reading =
the
> > > code.
> > >=20
> > > Please describe (via code comments) what the refcounting rules are fo=
r
> > > these data structures.  It all looks very strange.  You basically hav=
e:
> > >=20
> > >=20
> > > 	atomic_inc(refcnt);
> > > 	use(some_object);
> > > 	atomic_dec(refcnt);
> > >=20
> > > Which looks very racy.  Some other CPU could see a zero refcount just
> > > before this CPU did the atomic_inc() and the other CPU will go and fr=
ee up
> > > some_object.  There should be locking associated with refcounting to
> > > prevent such races, and I don't see any.
> >=20
> > It can not happen in the above case.
> > It can race with callback removing, but remove path=20
> > call cancel_delayed_work() which calls del_timer_sync(),=20
> > so above code can not be run or will not run,=20
> > only after it refcnt is being checked to be zero.
> > It is probably an overhead since sinchronization is done
> > in other places.
> > All above barriers are introduced to remove already not theoretical
> > atomic vs. non-atomic reordering [ppc64 very like it],
> > when reference counter must be decremented after object was used,=20
> > but due to reordering it can happen before use [and it will be seen
> > atomically on all CPUs],=20
> > and other CPU may free object based on knowledge that
> > refcnt is zero.
>=20
> But all the above seems to be tied into the
> poll-until-refcount-goes-to-zero cleanup code.  I think - it's quite
> unclear what the refcount protocol is for these objects.
>=20
> Why cannot we manage object lifetimes here in the same manner as dentries=
,
> inodes, skbuffs, etc?

It was easier to implement it in a that way.
Differencies will be only in function names - instead of msleep() it
will
be sleep_on.
Since it is atomic refcnt that is being checked wait_event can not be
used there directly.
I can change it's logic, it is quite simple.
Is it ok to postpone it until documentation changes are made in the
source code?

> > > > static struct cn_callback_entry *cn_queue_alloc_callback_entry(stru=
ct cn_callback *cb)
> > >=20
> > > 80 cols again.
> > >=20
> > > > static void cn_queue_free_callback(struct cn_callback_entry *cbq)
> > > > {
> > > > 	cancel_delayed_work(&cbq->work);
> > > >=20
> > > > 	while (atomic_read(&cbq->cb->refcnt)) {
> > > > 		printk(KERN_INFO "Waiting for %s to become free: refcnt=3D%d.\n",
> > > > 		       cbq->pdev->name, atomic_read(&cbq->cb->refcnt));
> > > >=20
> > > > 		msleep_interruptible(1000);
> > > >=20
> > > > 		if (current->flags & PF_FREEZE)
> > > > 			refrigerator(PF_FREEZE);
> > > >=20
> > > > 		if (signal_pending(current))
> > > > 			flush_signals(current);
> > > > 	}
> > > >=20
> > > > 	kfree(cbq);
> > > > }
> > >=20
> > > erp.  Can you please do this properly?
> > >=20
> > > Free the object on the refcount going to zero (with appropriate locki=
ng)?=20
> > > If you want (for some reason) to wait until all users of an object ha=
ve
> > > gone away then you should take a ref on the object (inside locking), =
then
> > > sleep on a waitqueue_head embedded in that object.  Make all
> > > refcount-droppers do a wake_up.
> > >=20
> > > Why is this function playing with signals?
> >=20
> > It is not, just can be interrupted to check state befor timeout expires=
.
> > It is not a problem to remove signal interrupting here.
>=20
> If this function is called by userspace tasks then we've just dumped any
> signals which that task might have had pending.

It is only rmmod/insmod who can call it=20
[it is called from module unloading/error path].
Implemented just to check state when Ctrl+C is pressed.

> > > > 			break;
> > > > 		}
> > > > 	}
> > > > 	if (!found) {
> > > > 		atomic_set(&cbq->cb->refcnt, 1);
> > > > 		list_add_tail(&cbq->callback_entry, &dev->queue_list);
> > > > 	}
> > > > 	spin_unlock_bh(&dev->queue_lock);
> > >=20
> > > Why use spin_lock_bh()?  Does none of this code ever get called from =
IRQ
> > > context?
> >=20
> > Test documentation module that lives in
> > Documentation/connector/cn_test.c
> > describes different usage cases for connector, and it uses
> > cn_netlink_send()
> > from irq context, which may race with the callback adding/removing.
>=20
> But cn_netlink_send() takes ->queue_lock.  If this CPU happened to be
> holding the same lock in process or bh context it will deadlock in IRQ
> context.

I need to state that sending must be limited to BH context too.
I thought about it when creating locking schema and decided to=20
not allow hard irq context, since receiving is already limited to
BH context.
I definitely need to put it into documentation.

> >=20
> > >=20
> > > > struct cn_queue_dev *cn_queue_alloc_dev(char *name, struct sock *nl=
s)
> > > > {
> > > > 	struct cn_queue_dev *dev;
> > > >=20
> > > > 	dev =3D kmalloc(sizeof(*dev), GFP_KERNEL);
> > > > 	if (!dev) {
> > > > 		printk(KERN_ERR "%s: Failed to allocte new struct cn_queue_dev.\n=
",
> > > > 		       name);
> > > > 		return NULL;
> > > > 	}
> > > >=20
> > > > 	memset(dev, 0, sizeof(*dev));
> > > >=20
> > > > 	snprintf(dev->name, sizeof(dev->name), "%s", name);
> > >=20
> > > scnprintf?
> >=20
> > Return value is ignored here, but I will change function though.
>=20
> scnprintf() null-terminates the destination even if it hits the end of it=
s
> buffer.

Hmm...
snprintf() differs from scnprintf() only by returning value:

int snprintf(char * buf, size_t size, const char *fmt, ...)
{
	va_list args;
	int i;

	va_start(args, fmt);
	i=3Dvsnprintf(buf,size,fmt,args);
	va_end(args);
	return i;
}

int scnprintf(char * buf, size_t size, const char *fmt, ...)
{
	va_list args;
	int i;

	va_start(args, fmt);
	i =3D vsnprintf(buf, size, fmt, args);
	va_end(args);
	return (i >=3D size) ? (size - 1) : i;
}

> > >=20
> > > Again, why is this code playing with signals?  Hopefully it is never =
called
> > > by user tasks - that would be very bad.
> >=20
> > I will remove signal interrupting.
>=20
> And use the kthread API, please.

Yep.

> > According to wait queue inside the object - it can have it, but it will
> > be used only for waiting and repeated checking in a slow path.
> > Let's postpone it for now until other isssues are resolved first.
>=20
> This all ties into the refcounting and object lifetime design.  What you
> have there appears quite unconventional.  Maybe there's good reason for
> that and maybe the code is race-free.  I don't understand what you've don=
e
> there sufficiently well to be able to say.

New object has 0 reference counter when created.
If some work is appointed to the object, then it's counter is atomically
incremented. It is decremented when the work is finished.
If object is supposed to be removed while some work
may be appointed to it, core ensures that no work _is_ appointed,=20
and atomically disallows[for example removing workqueue, removing
callback, all with appropriate locks being hold]=20
any other work appointment for the given object.
After it [when no work can be appointed to the object] if object
still has pending work [and thus has it's refcounter not zero],=20
removing path waits untill appropriate refcnt hits zero.=20
Since no _new_ work can be appointed at that level it is just
while (atomic_read(refcnt) !=3D 0)
  msleep();


--=20
        Evgeniy Polyakov

Crash is better than data corruption -- Arthur Grabowski

--=-yHCa/8LZWy/E4heVd7B4
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBCTQjrIKTPhE+8wY0RAqgpAJ9RRo7zjFyBxUH2TMrEGg6JrFg9BQCeOCKp
xwEmHyvr7gzt2H2RHn6xVZM=
=qqK/
-----END PGP SIGNATURE-----

--=-yHCa/8LZWy/E4heVd7B4--

