Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268260AbUIWEro@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268260AbUIWEro (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 00:47:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268269AbUIWEro
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 00:47:44 -0400
Received: from pauli.thundrix.ch ([213.239.201.101]:18401 "EHLO
	pauli.thundrix.ch") by vger.kernel.org with ESMTP id S268260AbUIWErh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 00:47:37 -0400
Date: Thu, 23 Sep 2004 06:45:49 +0200
From: Tonnerre <tonnerre@thundrix.ch>
To: Thomas Habets <thomas@habets.pp.se>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] oom_pardon, aka don't kill my xlock
Message-ID: <20040923044549.GE6889@thundrix.ch>
References: <200409230123.30858.thomas@habets.pp.se>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="YkJPYEFdoxh/AXLE"
Content-Disposition: inline
In-Reply-To: <200409230123.30858.thomas@habets.pp.se>
X-GPG-KeyID: 0x8BE1C38D
X-GPG-Fingerprint: 1AB0 9AD6 D0C8 B9D5 C5C9  9C2A FF86 CBEE 8BE1 C38D
X-GPG-KeyURL: http://users.thundrix.ch/~tonnerre/tonnerre.asc
User-Agent: Mutt/1.5.6+20040803i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--YkJPYEFdoxh/AXLE
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Salut,

On Thu, Sep 23, 2004 at 01:23:08AM +0200, Thomas Habets wrote:
> diff -Nur linux-2.6.7.orig/CREDITS linux-2.6.7/CREDITS
> --- linux-2.6.7.orig/CREDITS 2004-06-16 07:19:43.000000000 +0200
> +++ linux-2.6.7/CREDITS 2004-09-23 00:02:44.000000000 +0200
> @@ -1210,6 +1210,14 @@
>  W: http://www.inf.fu-berlin.de/~ehaase
>  D: Driver for the Commodore A2232 serial board
> =20
> +N: Thomas Habets
> +E: thomas@habets.pp.se
> +D: random Linux hacker
> +P: 1024D/AD48E854 A8A3 D1DD 4AE0 8467 7FDE  0945 286A E90A AD48 E854
> +S: Tunnlandsv=E4gen 40
> +S: 168 36 Bromma
> +S: Sweden
> +
>  N: Bruno Haible
>  E: haible@ma2s2.mathematik.uni-karlsruhe.de
>  D: SysV FS, shm swapping, memory management fixes

That should be D: OOM killer exceptions or whatever, I suppose.

> diff -Nur linux-2.6.7.orig/kernel/sysctl.c linux-2.6.7/kernel/sysctl.c
> --- linux-2.6.7.orig/kernel/sysctl.c 2004-06-16 07:18:58.000000000 +0200
> +++ linux-2.6.7/kernel/sysctl.c 2004-09-23 00:28:51.000000000 +0200
> @@ -795,6 +795,15 @@
>    .strategy =3D &sysctl_intvec,
>    .extra1  =3D &zero,
>   },
> +        {
> +                .ctl_name       =3D VM_OOM_PARDON,
> +                .procname       =3D "oom_pardon",
> +                .data           =3D &vm_oom_pardon,
> +                .maxlen         =3D sizeof(vm_oom_pardon),
> +                .mode           =3D 0644,
> +                .proc_handler   =3D &proc_doutsstring,
> +                .strategy       =3D &sysctl_string,
> +        },
>   { .ctl_name =3D 0 }
>  };
> =20

A sysctl is  a bad implementation since you can  only store one single
string in it.

> diff -Nur linux-2.6.7.orig/mm/oom_kill.c linux-2.6.7/mm/oom_kill.c
> --- linux-2.6.7.orig/mm/oom_kill.c 2004-06-16 07:19:29.000000000 +0200
> +++ linux-2.6.7/mm/oom_kill.c 2004-09-23 00:31:12.000000000 +0200
> @@ -16,14 +16,56 @@
>   */
> =20
>  #include <linux/mm.h>
> +#include <linux/utsname.h>
>  #include <linux/sched.h>
>  #include <linux/swap.h>
>  #include <linux/timex.h>
>  #include <linux/jiffies.h>
> =20
> +char vm_oom_pardon[VM_OOM_PARDON_LEN];
>  /* #define DEBUG */
> =20
>  /**
> + * For the love of kbaek, don't kill processes in /proc/sys/vm/oom_pardon
> + */
> +static int pardon(struct task_struct *task)
> +{
> +       static char buf[256];

That 256 should be VM_OOM_PARDON_LEN ?

> +       const struct qstr *exe;
> +       const char *p;
> +       int len;
> +
> +       exe =3D &task->proc_dentry->d_name;
> +       len =3D min((int)exe->len, (int)(sizeof(buf) - 2));

Dito.

> +       memcpy(buf, exe->name, len);
> +       buf[len] =3D 0;
> +       buf[len+1] =3D 0;
> +
> +       if (strchr(buf, ' ')) {
> +               return 0;
> +       }
> +
> +       down_read(&uts_sem);

We're under  the task lock, and you  want us to sleep  here? There's a
little problem: we'd want to switch  the task, and since the task lock
is taken, we'll wait an  infinite amount of time (yes, literally!) for
it to become free.

> +       p =3D vm_oom_pardon;
> +       do {
> +               buf[len] =3D ' ';
> +               if (!strncmp(p, buf, len)) {
> +                       return 1;
> +               }
> +
> +               buf[len] =3D 0;
> +               if (!strcmp(p, buf)) {
> +                       return 1;
> +               }
> +               p =3D strchr(p, ' ');
> +       } while(p++);

What about programs with spaces in its names?

Actually,  I'd  really  use  a  different interface  to  register  and
unregister processes  to protect. And  maybe not (just) by  the binary
name. Make a real filter list, or track them by pid.

> +       up_read(&uts_sem);
> +
> +       return 0;
> +}
> +
> +/**
>   * oom_badness - calculate a numeric value for how bad this task has been
>   * @p: task struct of which task we should calculate
>   *

				    Tonnerre

--YkJPYEFdoxh/AXLE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.9.2 (GNU/Linux)

iD8DBQFBUlT8/4bL7ovhw40RAoV9AJwLIFoYoTUiiJeCRf6fKjTH2zPV3ACfUSye
+DwvFOuZiHDHzE6SR39/VYI=
=SVa/
-----END PGP SIGNATURE-----

--YkJPYEFdoxh/AXLE--
