Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261919AbVCAOOo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261919AbVCAOOo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Mar 2005 09:14:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261916AbVCAOOn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Mar 2005 09:14:43 -0500
Received: from dea.vocord.ru ([217.67.177.50]:34192 "EHLO vocord.com")
	by vger.kernel.org with ESMTP id S261919AbVCAONc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Mar 2005 09:13:32 -0500
Subject: Re: [Lse-tech] Re: A common layer for Accounting packages
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Reply-To: johnpol@2ka.mipt.ru
To: Guillaume Thouvenin <guillaume.thouvenin@bull.net>
Cc: Kaigai Kohei <kaigai@ak.jp.nec.com>, hadi@cyberus.ca,
       Thomas Graf <tgraf@suug.ch>, Andrew Morton <akpm@osdl.org>,
       marcelo.tosatti@cyclades.com, "David S. Miller" <davem@redhat.com>,
       jlan@sgi.com, LSE-Tech <lse-tech@lists.sourceforge.net>,
       lkml <linux-kernel@vger.kernel.org>, netdev@oss.sgi.com,
       elsa-devel <elsa-devel@lists.sourceforge.net>
In-Reply-To: <1109685236.8594.75.camel@frecb000711.frec.bull.fr>
References: <4221E548.4000008@ak.jp.nec.com>
	 <20050227140355.GA23055@logos.cnet> <42227AEA.6050002@ak.jp.nec.com>
	 <1109575236.8549.14.camel@frecb000711.frec.bull.fr>
	 <20050227233943.6cb89226.akpm@osdl.org>
	 <1109592658.2188.924.camel@jzny.localdomain>
	 <20050228132051.GO31837@postel.suug.ch>
	 <1109598010.2188.994.camel@jzny.localdomain>
	 <20050228135307.GP31837@postel.suug.ch>
	 <1109599803.2188.1014.camel@jzny.localdomain>
	 <20050228142551.GQ31837@postel.suug.ch>
	 <1109604693.1072.8.camel@jzny.localdomain>
	 <20050228191759.6f7b656e@zanzibar.2ka.mipt.ru>
	 <1109665299.8594.55.camel@frecb000711.frec.bull.fr>
	 <42247051.7070303@ak.jp.nec.com>
	 <1109685236.8594.75.camel@frecb000711.frec.bull.fr>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-T+HcrVsRNtFuhZ2bJkzx"
Organization: MIPT
Date: Tue, 01 Mar 2005 17:17:57 +0300
Message-Id: <1109686677.28266.66.camel@uganda>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.4 (vocord.com [192.168.0.1]); Tue, 01 Mar 2005 17:11:37 +0300 (MSK)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-T+HcrVsRNtFuhZ2bJkzx
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2005-03-01 at 14:53 +0100, Guillaume Thouvenin wrote:
> On Tue, 2005-03-01 at 22:38 +0900, Kaigai Kohei wrote:
> > > I tested without user space listeners and the cost is negligible. I w=
ill
> > > test with a user space listeners and see the results. I'm going to ru=
n
> > > the test this week after improving the mechanism that switch on/off t=
he
> > > sending of the message.
> >=20
> > I'm also trying to mesure the process-creation/destruction performance =
on following three environment.
> > Archtechture: i686 / Distribution: Fedora Core 3
> > * Kernel Preemption is DISABLE
> > * SMP kernel but UP-machine / Not Hyper Threading
> > [1] 2.6.11-rc4-mm1 normal
> > [2] 2.6.11-rc4-mm1 with PAGG based Process Accounting Module
> > [3] 2.6.11-rc4-mm1 with fork-connector notification (it's enabled)
> >=20
> > When 367th-fork() was called after fork-connector notification, kernel =
was locked up.
> > (User-Space-Listener has been also run until 366th-fork() notification =
was received)
>=20
> I don't see this limit on my computer. I'm currently running the lmbench
> with a new fork connector patch (one that enable/disable fork connector)
> on an SMP computer. I will send results and the new patch tomorrow
> because the test takes a while...
>=20
> I'm using a small patch provided by Evgeniy and not included in the
> 2.6.11-rc4-mm1 tree.

2.6.11-rc4-mm1 tree does not have the latest connector.
Various fixes were added, not only that.

I run the latest patch Guillaume sent to me(with small updates),=20
fork bomb with more than 100k forks passed already without any freeze.
I do not have numbers thought.

> Best regards,
> Guillaume
>=20
> --- orig/connector.c
> +++ mod/connector.c
> @@ -168,12 +168,11 @@
>         group =3D NETLINK_CB((skb)).groups;
>         msg =3D (struct cn_msg *)NLMSG_DATA(nlh);
>=20
> -       if (msg->len !=3D nlh->nlmsg_len - sizeof(*msg) - sizeof(*nlh)) {
> +       if (NLMSG_SPACE(msg->len + sizeof(*msg)) !=3D nlh->nlmsg_len) {
>                 printk(KERN_ERR "skb does not have enough length: "
> -                               "requested msg->len=3D%u[%u], nlh->nlmsg_=
len=3D%u[%u], skb->len=3D%u[must be %u].\n",
> -                               msg->len, NLMSG_SPACE(msg->len),
> -                               nlh->nlmsg_len, nlh->nlmsg_len - sizeof(*=
nlh),
> -                               skb->len, msg->len + sizeof(*msg));
> +                               "requested msg->len=3D%u[%u], nlh->nlmsg_=
len=3D%u, skb->len=3D%u.\n",
> +                               msg->len, NLMSG_SPACE(msg->len + sizeof(*=
msg)),
> +                               nlh->nlmsg_len, skb->len);
>                 kfree_skb(skb);
>                 return -EINVAL;
>         }
>=20
--=20
        Evgeniy Polyakov

Crash is better than data corruption -- Arthur Grabowski

--=-T+HcrVsRNtFuhZ2bJkzx
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBCJHmVIKTPhE+8wY0RArr4AJ43/qPErT1WsYHIXDcSs3Z4g7tKCwCfSdjl
s1xDdJ3ZZYS4zmbpUe3+J1M=
=U897
-----END PGP SIGNATURE-----

--=-T+HcrVsRNtFuhZ2bJkzx--

