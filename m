Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262317AbVDAGj1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262317AbVDAGj1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Apr 2005 01:39:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262374AbVDAGj0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Apr 2005 01:39:26 -0500
Received: from dea.vocord.ru ([217.67.177.50]:56705 "EHLO vocord.com")
	by vger.kernel.org with ESMTP id S262317AbVDAGhv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Apr 2005 01:37:51 -0500
Subject: Re: [1/1] CBUS: new very fast (for insert operations) message bus
	based on kenel connector.
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Reply-To: johnpol@2ka.mipt.ru
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, guillaume.thouvenin@bull.net,
       jlan@engr.sgi.com, efocht@hpce.nec.com, linuxram@us.ibm.com,
       gh@us.ibm.com, elsa-devel@lists.sourceforge.net, greg@kroah.com
In-Reply-To: <20050331162758.44aeaf44.akpm@osdl.org>
References: <20050320112336.2b082e27@zanzibar.2ka.mipt.ru>
	 <20050331162758.44aeaf44.akpm@osdl.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-oHPuYbwMEFOTlPnE6T/M"
Organization: MIPT
Date: Fri, 01 Apr 2005 10:43:34 +0400
Message-Id: <1112337814.9334.42.camel@uganda>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-2) 
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.4 (vocord.com [192.168.0.1]); Fri, 01 Apr 2005 10:36:58 +0400 (MSD)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-oHPuYbwMEFOTlPnE6T/M
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2005-03-31 at 16:27 -0800, Andrew Morton wrote:
> Evgeniy Polyakov <johnpol@2ka.mipt.ru> wrote:
> >
> > I'm pleased to annouce CBUS - ultra fast (for insert operations)
> > message bus.
>=20
> > +static int cbus_enqueue(struct cbus_event_container *c, struct cn_msg =
*msg)
> > +{
> > +	int err;
> > +	struct cbus_event *event;
> > +	unsigned long flags;
> > +
> > +	event =3D kmalloc(sizeof(*event) + msg->len, GFP_ATOMIC);
>=20
> Using GFP_ATOMIC is a bit lame.  It would be better to require the caller
> to pass in the gfp_flags.  Or simply require that all callers not hold
> locks and use GFP_KERNEL.

New API with GFP flags provided is a next step in connector's TODO list.

> > +static int cbus_process(struct cbus_event_container *c, int all)
> > +{
> > +	struct cbus_event *event;
> > +	int len, i, num;
> > +=09
> > +	if (list_empty(&c->event_list))
> > +		return 0;
> > +
> > +	if (all)
> > +		len =3D c->qlen;
> > +	else
> > +		len =3D 1;
> > +
> > +	num =3D 0;
> > +	for (i=3D0; i<len; ++i) {
> > +		event =3D cbus_dequeue(c);
> > +		if (!event)
> > +			continue;
> > +
> > +		cn_netlink_send(&event->msg, 0);
> > +		num++;
> > +
> > +		kfree(event);
> > +	}
> > +=09
> > +	return num;
> > +}
>=20
> It might be cleaner to pass in an item count rather than a boolean `all'
> here.  Then again, it seems racy.

It was called somehow like
we_are_at_the_end_and_must_process_all_events_remain,=20
so cbus_process() could be called from the ->exit() routing.
So I decided to call it that way, but I'm not so impracticabile about
it.

> The initial list_empty() call could fail to detect new events due to lack
> of locking and memory barriers.

It is perfectly normal, and locking does not exist here for performance
reasons.
cbus_process() is too low priority in comparison with insert operation,
so it can easily miss one entry and process it next time.

> We conventionally code for loops as
>=20
> 	for (i =3D 0; i < len; i++)

Grrr....

> > +static int cbus_event_thread(void *data)
> > +{
> > +	int i, non_empty =3D 0, empty =3D 0;
> > +	struct cbus_event_container *c;
> > +
> > +	daemonize(cbus_name);
> > +	allow_signal(SIGTERM);
> > +	set_user_nice(current, 19);
>=20
> Please use the kthread api for managing this thread.
>=20
> Is a new kernel thread needed?

Logic behind cbus is following:=20
1. make insert operation return as soon as possible,
2. deferring actual message delivering to the safe time

That thread does second point.

> > +	while (!cbus_need_exit) {
> > +		if (empty || non_empty =3D=3D 0 || non_empty > 10) {
> > +			interruptible_sleep_on_timeout(&cbus_wait_queue, 10);
>=20
> interruptible_sleep_on_timeout() is heavily deprecated and is racy withou=
t
> external locking (it pretty much has to be the BKL).  Use wait_event_time=
out().

Ok.

> > +int __devinit cbus_init(void)
> > +{
> > +	int i, err =3D 0;
> > +	struct cbus_event_container *c;
> > +=09
> > +	for_each_cpu(i) {
> > +		c =3D &per_cpu(cbus_event_list, i);
> > +		cbus_init_event_container(c);
> > +	}
> > +
> > +	init_completion(&cbus_thread_exited);
> > +
> > +	cbus_pid =3D kernel_thread(cbus_event_thread, NULL, CLONE_FS | CLONE_=
FILES);
>=20
> Using the kthread API would clean this up.
>=20
> > +	if (IS_ERR((void *)cbus_pid)) {
>=20
> The weird cast here might not even work at all on 64-bit architectures.  =
It
> depends if they sign extend ints when casting them to pointers.  I guess
> they do.  If cbus_pid is indeed an s32.
>=20
> Much better to do
>=20
> 	if (cbus_pid < 0)

I will do it after above issues resolved.

> > +void __devexit cbus_fini(void)
> > +{
> > +	int i;
> > +	struct cbus_event_container *c;
> > +
> > +	cbus_need_exit =3D 1;
> > +	kill_proc(cbus_pid, SIGTERM, 0);
> > +	wait_for_completion(&cbus_thread_exited);
> > +=09
> > +	for_each_cpu(i) {
> > +		c =3D &per_cpu(cbus_event_list, i);
> > +		cbus_fini_event_container(c);
> > +	}
> > +}
>=20
> I think this is racy.  What stops new events from being queued while this
> function is in progress?

cbus_insert() should check need_exit flag - patch exists,=20
but against my tree, so I wait untill CBUS showed in public,
so I can resync with it.

--=20
        Evgeniy Polyakov

Crash is better than data corruption -- Arthur Grabowski

--=-oHPuYbwMEFOTlPnE6T/M
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBCTO2WIKTPhE+8wY0RAp9IAJ4xgs9/TG9b8DhEetQWw6qA+0s2FwCfRE9Q
c3Ms54zcoRnMrujQ4iLJ874=
=fXR1
-----END PGP SIGNATURE-----

--=-oHPuYbwMEFOTlPnE6T/M--

