Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262270AbVBQPsS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262270AbVBQPsS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Feb 2005 10:48:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262263AbVBQPsS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Feb 2005 10:48:18 -0500
Received: from dea.vocord.ru ([217.67.177.50]:34444 "EHLO vocord.com")
	by vger.kernel.org with ESMTP id S262270AbVBQPrw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Feb 2005 10:47:52 -0500
Subject: Re: [PATCH 2.6.11-rc3-mm2] connector: Add a fork connector
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Reply-To: johnpol@2ka.mipt.ru
To: Guillaume Thouvenin <guillaume.thouvenin@bull.net>
Cc: Andrew Morton <akpm@osdl.org>, Greg KH <greg@kroah.com>,
       lkml <linux-kernel@vger.kernel.org>,
       elsa-devel <elsa-devel@lists.sourceforge.net>,
       Gerrit Huizenga <gh@us.ibm.com>, Erich Focht <efocht@hpce.nec.com>
In-Reply-To: <1108652114.21392.144.camel@frecb000711.frec.bull.fr>
References: <1108652114.21392.144.camel@frecb000711.frec.bull.fr>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-I0Fp9mDTFMNgLlaQWRCJ"
Organization: MIPT
Date: Thu, 17 Feb 2005 18:50:54 +0300
Message-Id: <1108655454.14089.105.camel@uganda>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.4 (vocord.com [192.168.0.1]); Thu, 17 Feb 2005 18:45:02 +0300 (MSK)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-I0Fp9mDTFMNgLlaQWRCJ
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2005-02-17 at 15:55 +0100, Guillaume Thouvenin wrote:
> Hello,

Hello, I have small note about connector's usage in your module
in particular and others in general.

>     It's a new patch that implements a fork connector in the
> kernel/fork.c:do_fork() routine. The connector sends information about
> parent PID and child PID over a netlink interface. It allows to several
> user space applications to be alerted when a fork occurs in the kernel.
> The main drawback is that even if nobody listens, a message is send. I
> don't know how to avoid that. I added an option (FORK_CONNECTOR) to
> enable the fork connector (or disable) when compiling the kernel. To
> work, connector must be compiled as built-in (CONFIG_CONNECTOR=3Dy). It
> has been tested on a 2.6.11-rc3-mm2 kernel with two user space
> applications connected.=20
>=20
>     It is used by ELSA to manage group of processes in user space. In
> conjunction with a per-process accounting information, like BSD or CSA,
> ELSA provides a per-group of processes accounting.

I think people will complain here...
=46rom rom one point of view it is step to the chaotic microkernel message
flows,=20
from the other side why only fork is monitored in this way?
I still think that lsm with all calls logging is the best way to
achieve=20
this goal.

>     Every comments are welcome,
>=20
> Guillaume
>=20
> Signed-off-by: Guillaume Thouvenin <guillaume.thouvenin@bull.net>
> ---=20
>=20
>  drivers/connector/Kconfig |   10 ++++++++++
>  include/linux/connector.h |    2 ++
>  kernel/fork.c             |   41 +++++++++++++++++++++++++++++++++++++++=
++
>  3 files changed, 53 insertions(+)
>=20
> diff -uprN -X dontdiff linux-2.6.11-rc3-mm2/drivers/connector/Kconfig lin=
ux-2.6.11-rc3-mm2-cnfork/drivers/connector/Kconfig
> --- linux-2.6.11-rc3-mm2/drivers/connector/Kconfig	2005-02-11 11:00:16.00=
0000000 +0100
> +++ linux-2.6.11-rc3-mm2-cnfork/drivers/connector/Kconfig	2005-02-17 15:4=
8:41.000000000 +0100
> @@ -10,4 +10,14 @@ config CONNECTOR
>  	  Connector support can also be built as a module.  If so, the module
>  	  will be called cn.ko.
> =20
> +config FORK_CONNECTOR
> +	bool "Enable fork connector"
> +	depends on CONNECTOR
> +	---help---
> +	  It adds a connector in kernel/fork.c:do_fork() function. When a fork
> +	  occurs, netlink is used to transfer information about the parent and=20
> +	  its child. This information can be used by a user space application.=20
> +	 =20
> +	  Note: it only works if connector is built in the kernel.
> +	 =20
>  endmenu
> diff -uprN -X dontdiff linux-2.6.11-rc3-mm2/include/linux/connector.h lin=
ux-2.6.11-rc3-mm2-cnfork/include/linux/connector.h
> --- linux-2.6.11-rc3-mm2/include/linux/connector.h	2005-02-11 11:00:18.00=
0000000 +0100
> +++ linux-2.6.11-rc3-mm2-cnfork/include/linux/connector.h	2005-02-16 15:0=
7:46.000000000 +0100
> @@ -28,6 +28,8 @@
>  #define CN_VAL_KOBJECT_UEVENT		0x0000
>  #define CN_IDX_SUPERIO			0xaabb  /* SuperIO subsystem */
>  #define CN_VAL_SUPERIO			0xccdd
> +#define CN_IDX_FORK			0xfeed  /* fork events */
> +#define CN_VAL_FORK			0xbeef
> =20
>=20
>  #define CONNECTOR_MAX_MSG_SIZE 	1024
> diff -uprN -X dontdiff linux-2.6.11-rc3-mm2/kernel/fork.c linux-2.6.11-rc=
3-mm2-cnfork/kernel/fork.c
> --- linux-2.6.11-rc3-mm2/kernel/fork.c	2005-02-11 11:00:18.000000000 +010=
0
> +++ linux-2.6.11-rc3-mm2-cnfork/kernel/fork.c	2005-02-17 13:43:48.0000000=
00 +0100
> @@ -41,6 +41,7 @@
>  #include <linux/profile.h>
>  #include <linux/rmap.h>
>  #include <linux/acct.h>
> +#include <linux/connector.h>
> =20
>  #include <asm/pgtable.h>
>  #include <asm/pgalloc.h>
> @@ -63,6 +64,44 @@ DEFINE_PER_CPU(unsigned long, process_co
> =20
>  EXPORT_SYMBOL(tasklist_lock);
> =20
> +#if defined(CONFIG_CONNECTOR) && defined(CONFIG_FORK_CONNECTOR)

I suspect CONFIG_FORK_CONNECTOR is enough.

> +#define FORK_CN_INFO_SIZE	64=20
> +static inline void fork_connector(pid_t parent, pid_t child)
> +{
> +	struct cb_id fork_id =3D {CN_IDX_FORK, CN_VAL_FORK};
> +	static __u32 seq; /* used to test if we lost message */
> +=09
> +	if (cn_already_initialized) {
> +		struct cn_msg *msg;
> +		size_t size;
> +
> +		size =3D sizeof(*msg) + FORK_CN_INFO_SIZE;
> +		msg =3D kmalloc(size, GFP_KERNEL);
> +		if (msg) {
> +			memset(msg, '\0', size);
> +			memcpy(&msg->id, &fork_id, sizeof(msg->id));
> +			msg->seq =3D seq++;
> +			msg->ack =3D 0; /* not used */
> +			/*=20
> +			 * size of data is the number of characters=20
> +			 * printed plus one for the trailing '\0'
> +			 */
> +			msg->len =3D snprintf(msg->data, FORK_CN_INFO_SIZE-1,=20
> +					    "%i %i", parent, child) + 1;
> +
> +			cn_netlink_send(msg, 1);

"1" here means that this message will be delivered to any group
which has it's first bit set(1, 3, and so on) in given socket queue.
I suspect it is not what you want.
By design connector's users should send messages to the group it was
registered with
(which is obtained from idx field of the struct cb_id), in your case it
is CN_IDX_FORK,
and connector userspace consumers should bind to the same group (idx
value).
It is of course not requirement, but a fair path(hmm, I can add more
strict checks into connector).
By setting 0 as second parameter for cn_netlink_send() you will force
connector's core
to select proper group for you.

> +			kfree(msg);
> +		}
> +	}
> +}
> +#else
> +static inline void fork_connector(pid_t parent, pid_t child)=20
> +{
> +	return;=20
> +}
> +#endif
> +
>  int nr_processes(void)
>  {
>  	int cpu;
> @@ -1238,6 +1277,8 @@ long do_fork(unsigned long clone_flags,
>  			if (unlikely (current->ptrace & PT_TRACE_VFORK_DONE))
>  				ptrace_notify ((PTRACE_EVENT_VFORK_DONE << 8) | SIGTRAP);
>  		}
> +
> +		fork_connector(current->pid, p->pid);
>  	} else {
>  		free_pidmap(pid);
>  		pid =3D PTR_ERR(p);
>=20
--=20
        Evgeniy Polyakov

Crash is better than data corruption -- Arthur Grabowski

--=-I0Fp9mDTFMNgLlaQWRCJ
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBCFL1eIKTPhE+8wY0RAsoTAJ9i1sodC1+1PVgnLW0PTVgme79TCgCcCRXR
VxPm148qbPXa87Cfs5s1H+E=
=YhXT
-----END PGP SIGNATURE-----

--=-I0Fp9mDTFMNgLlaQWRCJ--

