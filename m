Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262536AbVDAHBr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262536AbVDAHBr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Apr 2005 02:01:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262551AbVDAHBr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Apr 2005 02:01:47 -0500
Received: from dea.vocord.ru ([217.67.177.50]:25484 "EHLO vocord.com")
	by vger.kernel.org with ESMTP id S262536AbVDAHBL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Apr 2005 02:01:11 -0500
Subject: Re: connector.c
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Reply-To: johnpol@2ka.mipt.ru
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050331173026.3de81a05.akpm@osdl.org>
References: <20050331173026.3de81a05.akpm@osdl.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-al5iwwQQOg+gSkF7/vGa"
Organization: MIPT
Date: Fri, 01 Apr 2005 11:07:18 +0400
Message-Id: <1112339238.9334.66.camel@uganda>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-2) 
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.4 (vocord.com [192.168.0.1]); Fri, 01 Apr 2005 11:00:59 +0400 (MSD)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-al5iwwQQOg+gSkF7/vGa
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2005-03-31 at 17:30 -0800, Andrew Morton wrote:
> Some belated comments...
>=20
>=20
> >=20
> > module_param(unit, int, 0);
> > module_param(cn_idx, uint, 0);
> > module_param(cn_val, uint, 0);
>=20
> MODULE_PARM_DESC needed, please.

Yep.

> > static DEFINE_SPINLOCK(notify_lock);
> > static LIST_HEAD(notify_list);
> >=20
> > static struct cn_dev cdev;
> >=20
> > int cn_already_initialized =3D 0;
> >=20
> > /*
> >  * msg->seq and msg->ack are used to determine message genealogy.
> >  * When someone sends message it puts there locally unique sequence=20
> >  * and random acknowledge numbers.
> >  * Sequence number may be copied into nlmsghdr->nlmsg_seq too.
> >  *
> >  * Sequence number is incremented with each message to be sent.
> >  *
> >  * If we expect reply to our message,=20
> >  * then sequence number in received message MUST be the same as in orig=
inal message,
> >  * and acknowledge number MUST be the same + 1.
> >  *
> >  * If we receive message and it's sequence number is not equal to one w=
e are expecting,=20
> >  * then it is new message.
> >  * If we receive message and it's sequence number is the same as one we=
 are expecting,
> >  * but it's acknowledge is not equal acknowledge number in original mes=
sage + 1,
> >  * then it is new message.
> >  *
> >  */
>=20
> This comment looks crappy in an 80-col xterm.

Does anyone still use it? :)

> What happens if we expect a reply to our message but userspace never send=
s
> one?  Does the kernel leak memory?  Do other processes hang?

It is only advice, one may easily skip seq/ack initialization.
I could remove it totally from the header, but decided to=20
place it to force people to use more reliable protocols over netlink
by introducing such overhead.

> > void cn_netlink_send(struct cn_msg *msg, u32 __groups)
> > {
> > 	struct cn_callback_entry *n, *__cbq;
> > 	unsigned int size;
> > 	struct sk_buff *skb, *uskb;
> > 	struct nlmsghdr *nlh;
> > 	struct cn_msg *data;
> > 	struct cn_dev *dev =3D &cdev;
> > 	u32 groups =3D 0;
> > 	int found =3D 0;
> >=20
> > 	if (!__groups)
> > 	{
>=20
> Wrong indenting.

Yep, my fault...

> > 		spin_lock_bh(&dev->cbdev->queue_lock);
> > 		list_for_each_entry_safe(__cbq, n, &dev->cbdev->queue_list, callback_=
entry) {
> > 			if (cn_cb_equal(&__cbq->cb->id, &msg->id)) {
> > 				found =3D 1;
> > 				groups =3D __cbq->group;
> > 			}
> > 		}
> > 		spin_unlock_bh(&dev->cbdev->queue_lock);
> >=20
> > 		if (!found) {
> > 			printk(KERN_ERR "Failed to find multicast netlink group for callback=
[0x%x.0x%x]. seq=3D%u\n",
> > 			       msg->id.idx, msg->id.val, msg->seq);
>=20
> Needs wrapping.
>=20
> > 			return;
> > 		}
> > 	}
> > 	else
> > 		groups =3D __groups;
> >=20
> > 	size =3D NLMSG_SPACE(sizeof(*msg) + msg->len);
> >=20
> > 	skb =3D alloc_skb(size, GFP_ATOMIC);
>=20
> GFP_ATOMIC is quite unreliable.  Better to find a way to use GFP_KERNEL h=
ere.

It can be used in bh context, my first TODO entryf for connector is
provideing
extended API with GFP flags provided by caller.

> > 	if (!skb) {
> > 		printk(KERN_ERR "Failed to allocate new skb with size=3D%u.\n", size)=
;
> > 		return;
> > 	}
>=20
> Surely we should return -ENOMEM here?  How is the caller to know that the
> send attempt worked?

It is notification area, notification may fail and original applicant
can not=20
and should not know about it.
If it was direct call, then error must be propagated to the caller,=20
but indirect notification is not.

> > 	nlh =3D NLMSG_PUT(skb, 0, msg->seq, NLMSG_DONE, size - sizeof(*nlh));
> >=20
> > 	data =3D (struct cn_msg *)NLMSG_DATA(nlh);
>=20
> Unneeded typecast.

Is it really an issue?
I try to always dereference void pointer to the given type...

> > 	memcpy(data, msg, sizeof(*data) + msg->len);
> > #if 0
> > 	printk("%s: len=3D%u, seq=3D%u, ack=3D%u, group=3D%u.\n",
> > 	       __func__, msg->len, msg->seq, msg->ack, groups);
> > #endif
> > =09
> > 	NETLINK_CB(skb).dst_groups =3D groups;
> >=20
> > 	uskb =3D skb_clone(skb, GFP_ATOMIC);
> > 	if (uskb) {
> > 		netlink_unicast(dev->nls, uskb, 0, 0);
> > 	}
>=20
> Unneeded {}

Ok.

> > 	netlink_broadcast(dev->nls, skb, 0, groups, GFP_ATOMIC);
>=20
> GFP_ATOMIC is quite undesirable.

It will be changed to provided GFP flags by caller soon.

> >=20
> > static int cn_call_callback(struct cn_msg *msg, void (*destruct_data) (=
void *), void *data)
>=20
> 80 cols
>=20
> > {
> > 	struct cn_callback_entry *n, *__cbq;
> > 	struct cn_dev *dev =3D &cdev;
> > 	int found =3D 0;
> >=20
> > 	spin_lock_bh(&dev->cbdev->queue_lock);
> > 	list_for_each_entry_safe(__cbq, n, &dev->cbdev->queue_list, callback_e=
ntry) {
>=20
> 80 cols

Grrr....

> > 		if (cn_cb_equal(&__cbq->cb->id, &msg->id)) {
> > 			__cbq->cb->priv =3D msg;
> >=20
> > 			__cbq->ddata =3D data;
> > 			__cbq->destruct_data =3D destruct_data;
> >=20
> > 			queue_work(dev->cbdev->cn_queue, &__cbq->work);
> > 			found =3D 1;
> > 			break;
> > 		}
> > 	}
> > 	spin_unlock_bh(&dev->cbdev->queue_lock);
> >=20
> > 	return found;
> > }
>=20
> Why is spin_lock_bh() being used here?

skb may be delivered in soft irq context, and may race with sending.
And actually it can be sent from irq context, like it is done in test
module.

> > static int __cn_rx_skb(struct sk_buff *skb, struct nlmsghdr *nlh)
> > {
> > 	u32 pid, uid, seq, group;
> > 	struct cn_msg *msg;
> >=20
> > 	pid =3D NETLINK_CREDS(skb)->pid;
> > 	uid =3D NETLINK_CREDS(skb)->uid;
> > 	seq =3D nlh->nlmsg_seq;
> > 	group =3D NETLINK_CB((skb)).groups;
> > 	msg =3D (struct cn_msg *)NLMSG_DATA(nlh);
> >=20
> > 	if (NLMSG_SPACE(msg->len + sizeof(*msg)) !=3D nlh->nlmsg_len) {
> > 		printk(KERN_ERR "skb does not have enough length: "
> > 				"requested msg->len=3D%u[%u], nlh->nlmsg_len=3D%u, skb->len=3D%u.\n=
",
>=20
> 80 cols (all over the place)

Ok...

> > static void cn_notify(struct cb_id *id, u32 notify_event)
> > {
> > 	struct cn_ctl_entry *ent;
> >=20
> > 	spin_lock_bh(&notify_lock);
> > 	list_for_each_entry(ent, &notify_list, notify_entry) {
> > 		int i;
> > 		struct cn_notify_req *req;
> > 		struct cn_ctl_msg *ctl =3D ent->msg;
> > 		int a, b;
> >=20
> > 		a =3D b =3D 0;
> > 	=09
> > 		req =3D (struct cn_notify_req *)ctl->data;
> > 		for (i=3D0; i<ctl->idx_notify_num; ++i, ++req) {
>=20
> 		for (i =3D 0; i < ctl->idx_notify_num; i++, req++) {
>=20
> > 			if (id->idx >=3D req->first && id->idx < req->first + req->range) {
> > 				a =3D 1;
> > 				break;
> > 			}
> > 		}
> > 	=09
> > 		for (i=3D0; i<ctl->val_notify_num; ++i, ++req) {
> > 			if (id->val >=3D req->first && id->val < req->first + req->range) {
> > 				b =3D 1;
> > 				break;
> > 			}
> > 		}
> >=20
> > 		if (a && b) {
> > 			struct cn_msg m;
> > 		=09
> > 			printk(KERN_INFO "Notifying group %x with event %u about %x.%x.\n",=20
> > 					ctl->group, notify_event,=20
> > 					id->idx, id->val);
> >=20
> > 			memset(&m, 0, sizeof(m));
> > 			m.ack =3D notify_event;
> >=20
> > 			memcpy(&m.id, id, sizeof(m.id));
> > 			cn_netlink_send(&m, ctl->group);
> > 		}
>=20
> What's all the above code doing?  What do `a' and `b' mean?  Needs
> commentary and better-chosen identifiers.

It searches for idx and val to match requested notification,=20
if "a" is true - idx is found, if b - val is found.

> > 	}
> > 	spin_unlock_bh(&notify_lock);
> > }
> >=20
> > int cn_add_callback(struct cb_id *id, char *name, void (*callback) (voi=
d *))
> > {
> > 	int err;
> > 	struct cn_dev *dev =3D &cdev;
> > 	struct cn_callback *cb;
> >=20
> > 	cb =3D kmalloc(sizeof(*cb), GFP_KERNEL);
> > 	if (!cb) {
> > 		printk(KERN_INFO "%s: Failed to allocate new struct cn_callback.\n",
> > 		       dev->cbdev->name);
> > 		return -ENOMEM;
> > 	}
> >=20
> > 	memset(cb, 0, sizeof(*cb));
> >=20
> > 	snprintf(cb->name, sizeof(cb->name), "%s", name);
>=20
> scnprintf?

Returned value is ignored here, so they do not differ.
Will change it though.

> > 	memcpy(&cb->id, id, sizeof(cb->id));
> > 	cb->callback =3D callback;
> >=20
> > 	atomic_set(&cb->refcnt, 0);
> >=20
> > 	err =3D cn_queue_add_callback(dev->cbdev, cb);
> > 	if (err) {
> > 		kfree(cb);
> > 		return err;
> > 	}
> > 		=09
> > 	cn_notify(id, 0);
> >=20
> > 	return 0;
> > }
> >=20
> > void cn_del_callback(struct cb_id *id)
> > {
> > 	struct cn_dev *dev =3D &cdev;
> > 	struct cn_callback_entry *n, *__cbq;
> >=20
> > 	list_for_each_entry_safe(__cbq, n, &dev->cbdev->queue_list, callback_e=
ntry) {
> > 		if (cn_cb_equal(&__cbq->cb->id, id)) {
> > 			cn_queue_del_callback(dev->cbdev, __cbq->cb);
> > 			cn_notify(id, 1);
> > 			break;
> > 		}
> > 	}
> > }
>=20
> Doesn't this list walk need locking?

Ugh, you are tight, I totally wrong here.
It requires dev->queue_lock to be hold.

> Please document all functions with comments.  Functions which constitute
> part of the external API should be commented using the kernel-doc format.

There is Documentation/connector/connector.txt which describes all
exported functions and structures.
Should it be ported to docbook?

> > static void cn_callback(void * data)
> > {
> > 	struct cn_msg *msg =3D (struct cn_msg *)data;
> > 	struct cn_ctl_msg *ctl;
> > 	struct cn_ctl_entry *ent;
> > 	u32 size;
> > =20
> > 	if (msg->len < sizeof(*ctl)) {
> > 		printk(KERN_ERR "Wrong connector request size %u, must be >=3D %u.\n"=
,=20
> > 				msg->len, sizeof(*ctl));
> > 		return;
> > 	}
> > =09
> > 	ctl =3D (struct cn_ctl_msg *)msg->data;
> >=20
> > 	size =3D sizeof(*ctl) + (ctl->idx_notify_num + ctl->val_notify_num)*si=
zeof(struct cn_notify_req);
> >=20
> > 	if (msg->len !=3D size) {
> > 		printk(KERN_ERR "Wrong connector request size %u, must be =3D=3D %u.\=
n",=20
> > 				msg->len, size);
> > 		return;
> > 	}
> >=20
> > 	if (ctl->len + sizeof(*ctl) !=3D msg->len) {
> > 		printk(KERN_ERR "Wrong message: msg->len=3D%u must be equal to inner_=
len=3D%u [+%u].\n",=20
> > 				msg->len, ctl->len, sizeof(*ctl));
> > 		return;
> > 	}
> >=20
> > 	/*
> > 	 * Remove notification.
> > 	 */
> > 	if (ctl->group =3D=3D 0) {
> > 		struct cn_ctl_entry *n;
> > 	=09
> > 		spin_lock_bh(&notify_lock);
> > 		list_for_each_entry_safe(ent, n, &notify_list, notify_entry) {
> > 			if (cn_ctl_msg_equals(ent->msg, ctl)) {
> > 				list_del(&ent->notify_entry);
> > 				kfree(ent);
> > 			}
> > 		}
> > 		spin_unlock_bh(&notify_lock);
> >=20
> > 		return;
> > 	}
> >=20
> > 	size +=3D sizeof(*ent);
> >=20
> > 	ent =3D kmalloc(size, GFP_ATOMIC);
>=20
> Another GFP_ATOMIC :(  In what context can this function be called?

It is called from BH context.
It is only one place that can not be moved to the different GFP
allocation,
but it is notification area, that is quite rarely used as fas as I can
see...

> > 	{
> > 		int i;
> > 		struct cn_notify_req *req;
>=20
> May as well move these up to the top of the function, save the ugly inden=
t.
>=20
> > 		printk("Notify group %x for idx: ", ctl->group);
> >=20
> > 		req =3D (struct cn_notify_req *)ctl->data;
> > 		for (i=3D0; i<ctl->idx_notify_num; ++i, ++req) {
> > 			printk("%u-%u ", req->first, req->first+req->range-1);
> > 		}
>=20
> Unneeded braces.
>=20
> This file is full of trailing whitespace, btw.  Please fix that up, then
> find a new editor.
>=20
> > 		printk("\nNotify group %x for val: ", ctl->group);
> >=20
> > 		for (i=3D0; i<ctl->val_notify_num; ++i, ++req) {
> > 			printk("%u-%u ", req->first, req->first+req->range-1);
> > 		}
>=20
> Braces.

It is debug code and I will remove it.

--=20
        Evgeniy Polyakov

Crash is better than data corruption -- Arthur Grabowski

--=-al5iwwQQOg+gSkF7/vGa
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBCTPMmIKTPhE+8wY0RApJ4AKCB5VxboJTV9mHFPz6YS44vLJ8i2QCgkmpC
OQl8qiYbq4P3ekdPTQf/8D0=
=Tdyl
-----END PGP SIGNATURE-----

--=-al5iwwQQOg+gSkF7/vGa--

