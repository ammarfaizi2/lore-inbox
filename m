Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261585AbVDEG7l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261585AbVDEG7l (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 02:59:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261587AbVDEG7l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 02:59:41 -0400
Received: from ns2.vocord.com ([194.220.215.56]:63170 "EHLO vocord.com")
	by vger.kernel.org with ESMTP id S261585AbVDEG7a (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 02:59:30 -0400
Subject: Re: Netlink Connector / CBUS
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Reply-To: johnpol@2ka.mipt.ru
To: James Morris <jmorris@redhat.com>
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com,
       "David S. Miller" <davem@davemloft.net>,
       Herbert Xu <herbert@gondor.apana.org.au>, rml@novell.com,
       Greg KH <greg@kroah.com>, Andrew Morton <akpm@osdl.org>
In-Reply-To: <Xine.LNX.4.44.0504050030230.9273-100000@thoron.boston.redhat.com>
References: <Xine.LNX.4.44.0504050030230.9273-100000@thoron.boston.redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-p5aA2EfudVVDZNSzIBGU"
Organization: MIPT
Date: Tue, 05 Apr 2005 11:03:16 +0400
Message-Id: <1112684596.28858.4.camel@uganda>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-2) 
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.4 (vocord.com [192.168.0.1]); Tue, 05 Apr 2005 10:57:35 +0400 (MSD)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-p5aA2EfudVVDZNSzIBGU
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2005-04-05 at 01:05 -0400, James Morris wrote:=20
> Evgeniy,
>=20
> Please send networking patches to netdev@oss.sgi.com.

It was sent there two times.

> Your connector code (under drivers/connector) is now in the -mm tree and=20
> as far as I can tell, has not received any review from the network=20
> developers.

I received comments and feature requests from Herbert Xu and Jamal Hadi
Salim,
almost all were successfully resolved.

> Looking at it briefly, it seems quite unfinished.

Hmmm...
I think it is fully functional and ready for inclusion.

> I'm not entirely sure what it's purpose is.

1. Provide very flexible userspace control over netlink.
2. Provide very flexible notification mechanism.

> A clear explanation of its purpose would be helpful (to me, at least), as=
=20
> well as documentation of the API and majore data structures (which akpm=20
> has also asked for, IIRC).

Documentation exists in Documentation/connector/connector.txt.
Patch with brief source documentation was already created,
so I will post it with other minor updates soon.

> I can see one example of where it's being used with kobject_uevent, and i=
t=20
> seems to have arrived via Greg-KH's I2C tree...

It also is used in SuperIO and acrypto subsystems.

> If you're trying to add a generic, psuedo-reliable Netlink communication=20
> system, perhaps this should be built into Netlink itself as an extension=20
> of the existing Netlink API.

So, you recommend to create for each driver, that wants to be controlled
over netlink, new netlink socket, register it's unit and learn
how SKB is allocated, processed and so on?
This is wrong.
Much easier to just register a callback.

> I don't think this should be done as a separate "driver" off somewhere=20
> else with a new API.

It is much easier to use connector instead of direct netlink sockets.
One should only register callback and identifier. When driver receives
special netlink message with appropriate identifier, appropriate
callback will be called.

=46rom the userspace point of view it's quite straightforward:
socket();
bind();
send();
recv();

But if kernelspace want to use full power of such connections, driver
writer must create special sockets, must know about struct sk_buff
handling...
Connector allows any kernelspace agents to use netlink based
networking for inter-process communication in a significantly easier
way:

int cn_add_callback(struct cb_id *id, char *name, void (*callback) (void
*));
void cn_netlink_send(struct cn_msg *msg, u32 __groups);


>=20
> A few questions:
>=20
> - Why does it by default use NETLINK_NFLOG a kernel socket, and also allo=
w=20
> this to be overriden by a module parameter?

Because while this driver lived outside kernel tree there were no empty=20
registered socket.
It can be changed if driver will go upstream.

> - Why does the cn.o module (poor namespace choice) add a callback itself
> on initialization?

Because that callback is used for notification requests.

> - Where is the userspace code which uses this?  I checked out dbus from=20
> cvs and couldn't see anything obvious.

I posted it with SuperIO, kobject_uevent, acrypto and fork changes.
It is quite straightforward:

        s =3D socket(PF_NETLINK, SOCK_DGRAM, NETLINK_NFLOG);
        if (s =3D=3D -1) {
                perror("socket");
                return -1;
        }

        l_local.nl_family =3D AF_NETLINK;
        l_local.nl_groups =3D CN_ACRYPTO_IDX;
        l_local.nl_pid =3D getpid();

        if (bind(s, (struct sockaddr *)&l_local, sizeof(struct
sockaddr_nl)) =3D=3D -1) {
                perror("bind");
                close(s);
                return -1;
        }


                case NLMSG_DONE:
                        data =3D (struct cn_msg *)NLMSG_DATA(reply);
                        m =3D (struct crypto_conn_data *)(data + 1);
                        stat =3D (struct crypto_device_stat *)(m+1);

                        time(&tm);
                        fprintf(out,
                                "%.24s : [%x.%x] [seq=3D%u, ack=3D%u], name=
=3D
%s, cmd=3D%#02x, "
                                "sesions: completed=3D%llu, started=3D%llu,
finished=3D%llu, cache_failed=3D%llu.\n",
                                ctime(&tm), data->id.idx, data->id.val,
                                data->seq, data->ack, m->name, m->cmd,
                                stat->scompleted, stat->sstarted, stat-
>sfinished, stat->cache_failed);
                        fflush(out);
                        break;


>=20
> Thanks,

Thank you for your comments.

>=20
> - James
--=20
        Evgeniy Polyakov

Crash is better than data corruption -- Arthur Grabowski

--=-p5aA2EfudVVDZNSzIBGU
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBCUjg0IKTPhE+8wY0RAtW9AJ0a0EjP0tCQ+mf28pplSyNYxtY5DgCfQq0x
oMdIKfBX1VrHHWNtXPzhMAc=
=C9qk
-----END PGP SIGNATURE-----

--=-p5aA2EfudVVDZNSzIBGU--

