Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262164AbVBXKj5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262164AbVBXKj5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Feb 2005 05:39:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262181AbVBXKj5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Feb 2005 05:39:57 -0500
Received: from dea.vocord.ru ([217.67.177.50]:27341 "EHLO vocord.com")
	by vger.kernel.org with ESMTP id S262164AbVBXKjo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Feb 2005 05:39:44 -0500
Subject: Re: [PATCH 2.6.11-rc4-mm1] connector: Add a fork connector
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Reply-To: johnpol@2ka.mipt.ru
To: Guillaume Thouvenin <guillaume.thouvenin@bull.net>
Cc: Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>,
       elsa-devel <elsa-devel@lists.sourceforge.net>,
       Jay Lan <jlan@engr.sgi.com>, Gerrit Huizenga <gh@us.ibm.com>,
       Erich Focht <efocht@hpce.nec.com>
In-Reply-To: <1109240677.1738.196.camel@frecb000711.frec.bull.fr>
References: <1109240677.1738.196.camel@frecb000711.frec.bull.fr>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-/xZDK/qQy+EdMgFO08Ag"
Organization: MIPT
Date: Thu, 24 Feb 2005 13:45:01 +0300
Message-Id: <1109241901.6728.47.camel@uganda>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.4 (vocord.com [192.168.0.1]); Thu, 24 Feb 2005 13:38:49 +0300 (MSK)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-/xZDK/qQy+EdMgFO08Ag
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2005-02-24 at 11:24 +0100, Guillaume Thouvenin wrote:
>   This patch replaces the relay_fork module and it implements a fork
> connector in the kernel/fork.c:do_fork() routine. It applies on a kernel
> 2.6.11-rc4-mm1. The connector sends information about parent PID and
> child PID over a netlink interface. It allows to several user space
> applications to be informed when a fork occurs in the kernel. The main
> drawback is that even if nobody listens, message is send. I don't know
> how to avoid that.
>     =20
>   It is used by ELSA to manage group of processes in user space and can
> be used by any other user space application that needs this kind of
> information.
>=20
>   I add a callback that turns on/off the fork connector. It's a very
> simple mechanism and, as Evgeniy suggested, it may need a more complex
> protocol. =20
>=20
>   ChangeLog:
>=20
>     - "fork_id" is now declared as a static const
>     - Replace snprintf() by scnprintf()
>     - Protect "seq" by a spin lock because the seq number can be
>       used by the daemon to check if all forks are intercepted=20
>     - "msg" send is now local
>     - Add a callback that turns on/off the fork connector.
>     - memset is only used to clear the msg->data part instead of all
>       message.=20
>=20
>   Todo:
>=20
>     - Test the performance impact with lmbench
>     - Improve the callback that turns on/off the fork connector
>     - Create a specific module to register the callback.

Besides connector.c changes I do not have technical objections...
But I really would like to see your second and third TODO entries in=20
ChangeLog before you will push it upstream.

> Thanks to Andrew, Evgeniy and everyone for the comments,
> Guillaume
>=20
> Signed-off-by: Guillaume Thouvenin <guillaume.thouvenin@bull.net>
>=20
> ---
>=20
>  drivers/connector/Kconfig     |   11 ++++++++++
>  drivers/connector/connector.c |   20 ++++++++++++++++++
>  include/linux/connector.h     |    3 ++
>  kernel/fork.c                 |   45 +++++++++++++++++++++++++++++++++++=
+++++++
>  4 files changed, 79 insertions(+)
>=20
> diff -uprN -X dontdiff linux-2.6.11-rc4-mm1/drivers/connector/connector.c=
 linux-2.6.11-rc4-mm1-cnfork/drivers/connector/connector.c
> --- linux-2.6.11-rc4-mm1/drivers/connector/connector.c	2005-02-23 11:12:1=
5.000000000 +0100
> +++ linux-2.6.11-rc4-mm1-cnfork/drivers/connector/connector.c	2005-02-24 =
10:21:59.000000000 +0100
> @@ -45,8 +45,10 @@ static DEFINE_SPINLOCK(notify_lock);
>  static LIST_HEAD(notify_list);
> =20
>  static struct cn_dev cdev;
> +static struct cb_id cn_fork_id =3D { CN_IDX_FORK, CN_VAL_FORK };
> =20
>  int cn_already_initialized =3D 0;
> +int cn_fork_enable =3D 0;
> =20
>  /*
>   * msg->seq and msg->ack are used to determine message genealogy.
> @@ -467,6 +469,14 @@ static void cn_callback(void * data)
>  	}
>  }
> =20
> +static void cn_fork_callback(void *data)=20
> +{
> +	if (cn_already_initialized)
> +		cn_fork_enable =3D cn_fork_enable ? 0 : 1;
> +	=09
> +	printk(KERN_NOTICE "cn_fork_enable is set to %i\n", cn_fork_enable);
> +}
> +
>  static int cn_init(void)
>  {
>  	struct cn_dev *dev =3D &cdev;
> @@ -498,6 +508,15 @@ static int cn_init(void)
>  		return -EINVAL;
>  	}
> =20
> +	err =3D cn_add_callback(&cn_fork_id, "cn_fork", &cn_fork_callback);
> +	if (err) {
> +		cn_del_callback(&dev->id);
> +		cn_queue_free_dev(dev->cbdev);
> +		if (dev->nls->sk_socket)
> +			sock_release(dev->nls->sk_socket);
> +		return -EINVAL;
> +	}
> +=09
>  	cn_already_initialized =3D 1;
> =20
>  	return 0;
> @@ -507,6 +526,7 @@ static void cn_fini(void)
>  {
>  	struct cn_dev *dev =3D &cdev;
> =20
> +	cn_del_callback(&cn_fork_id);
>  	cn_del_callback(&dev->id);
>  	cn_queue_free_dev(dev->cbdev);
>  	if (dev->nls->sk_socket)


All above should really live in the separate module.

> diff -uprN -X dontdiff linux-2.6.11-rc4-mm1/drivers/connector/Kconfig lin=
ux-2.6.11-rc4-mm1-cnfork/drivers/connector/Kconfig
> --- linux-2.6.11-rc4-mm1/drivers/connector/Kconfig	2005-02-23 11:12:15.00=
0000000 +0100
> +++ linux-2.6.11-rc4-mm1-cnfork/drivers/connector/Kconfig	2005-02-24 10:2=
9:11.000000000 +0100
> @@ -10,4 +10,15 @@ config CONNECTOR
>  	  Connector support can also be built as a module.  If so, the module
>  	  will be called cn.ko.
> =20
> +config FORK_CONNECTOR
> +	bool "Enable fork connector"
> +	depends on CONNECTOR=3Dy
> +	default y
> +	---help---
> +	  It adds a connector in kernel/fork.c:do_fork() function. When a fork
> +	  occurs, netlink is used to transfer information about the parent and=20
> +	  its child. This information can be used by a user space application.
> +	  The fork connector can be enable/disable by sending a message to the
> +	  connector with the corresponding group id.
> +	 =20
>  endmenu
> diff -uprN -X dontdiff linux-2.6.11-rc4-mm1/include/linux/connector.h lin=
ux-2.6.11-rc4-mm1-cnfork/include/linux/connector.h
> --- linux-2.6.11-rc4-mm1/include/linux/connector.h	2005-02-23 11:12:17.00=
0000000 +0100
> +++ linux-2.6.11-rc4-mm1-cnfork/include/linux/connector.h	2005-02-24 10:2=
5:22.000000000 +0100
> @@ -28,6 +28,8 @@
>  #define CN_VAL_KOBJECT_UEVENT		0x0000
>  #define CN_IDX_SUPERIO			0xaabb  /* SuperIO subsystem */
>  #define CN_VAL_SUPERIO			0xccdd
> +#define CN_IDX_FORK			0xfeed  /* fork events */
> +#define CN_VAL_FORK			0xbeef
> =20
>=20
>  #define CONNECTOR_MAX_MSG_SIZE 	1024
> @@ -133,6 +135,7 @@ struct cn_dev
>  };
> =20
>  extern int cn_already_initialized;
> +extern int cn_fork_enable;
> =20
>  int cn_add_callback(struct cb_id *, char *, void (* callback)(void *));
>  void cn_del_callback(struct cb_id *);
> diff -uprN -X dontdiff linux-2.6.11-rc4-mm1/kernel/fork.c linux-2.6.11-rc=
4-mm1-cnfork/kernel/fork.c
> --- linux-2.6.11-rc4-mm1/kernel/fork.c	2005-02-23 11:12:17.000000000 +010=
0
> +++ linux-2.6.11-rc4-mm1-cnfork/kernel/fork.c	2005-02-24 10:27:02.0000000=
00 +0100
> @@ -41,6 +41,7 @@
>  #include <linux/profile.h>
>  #include <linux/rmap.h>
>  #include <linux/acct.h>
> +#include <linux/connector.h>
> =20
>  #include <asm/pgtable.h>
>  #include <asm/pgalloc.h>
> @@ -63,6 +64,48 @@ DEFINE_PER_CPU(unsigned long, process_co
> =20
>  EXPORT_SYMBOL(tasklist_lock);
> =20
> +#ifdef CONFIG_FORK_CONNECTOR
> +
> +#define CN_FORK_INFO_SIZE	64
> +#define CN_FORK_MSG_SIZE 	sizeof(struct cn_msg) + CN_FORK_INFO_SIZE
> +
> +spinlock_t fork_cn_lock =3D SPIN_LOCK_UNLOCKED;
> +
> +static inline void fork_connector(pid_t parent, pid_t child)
> +{
> +	static const struct cb_id fork_id =3D { CN_IDX_FORK, CN_VAL_FORK };
> +	static __u32 seq;   /* used to test if message is lost */
> +
> +	if (cn_fork_enable) {
> +		struct cn_msg *msg;
> +		__u8 buffer[CN_FORK_MSG_SIZE];=09
> +
> +		msg =3D (struct cn_msg *)buffer;
> +		=09
> +		memcpy(&msg->id, &fork_id, sizeof(msg->id));
> +		spin_lock(&fork_cn_lock);
> +		msg->seq =3D seq++;
> +		spin_unlock(&fork_cn_lock);
> +		msg->ack =3D 0; /* not used */
> +		/*=20
> +		 * size of data is the number of characters=20
> +		 * printed plus one for the trailing '\0'
> +		 */
> +		/* just fill the data part with '\0' */
> +		memset(msg->data, '\0', CN_FORK_INFO_SIZE);
> +		msg->len =3D scnprintf(msg->data, CN_FORK_INFO_SIZE-1,=20
> +				    "%i %i", parent, child) + 1;
> +
> +		cn_netlink_send(msg, CN_IDX_FORK);
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
> @@ -1238,6 +1281,8 @@ long do_fork(unsigned long clone_flags,
>  			if (unlikely (current->ptrace & PT_TRACE_VFORK_DONE))
>  				ptrace_notify ((PTRACE_EVENT_VFORK_DONE << 8) | SIGTRAP);
>  		}
> +
> +		fork_connector(current->pid, p->pid);
>  	} else {
>  		free_pidmap(pid);
>  		pid =3D PTR_ERR(p);
>=20
>=20
--=20
        Evgeniy Polyakov

Crash is better than data corruption -- Arthur Grabowski

--=-/xZDK/qQy+EdMgFO08Ag
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBCHbAtIKTPhE+8wY0RApaLAJwK353MVUE4NDC2suFuQ8fO2SqFIACeKqhp
6x2N2qSKiGXb4CbiLZUHWao=
=ClSj
-----END PGP SIGNATURE-----

--=-/xZDK/qQy+EdMgFO08Ag--

