Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129391AbQK2BVX>; Tue, 28 Nov 2000 20:21:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129764AbQK2BVN>; Tue, 28 Nov 2000 20:21:13 -0500
Received: from etpmod.phys.tue.nl ([131.155.111.35]:64271 "EHLO
        etpmod.phys.tue.nl") by vger.kernel.org with ESMTP
        id <S129391AbQK2BVB>; Tue, 28 Nov 2000 20:21:01 -0500
Date: Wed, 29 Nov 2000 01:48:40 +0100
From: Kurt Garloff <garloff@suse.de>
To: Keith Owens <kaos@ocs.com.au>,
        Linux kernel list <linux-kernel@vger.kernel.org>
Subject: Re: modutils-2.3.21: modprobe looping
Message-ID: <20001129014840.D1777@garloff.etpnet.phys.tue.nl>
Mail-Followup-To: Kurt Garloff <garloff@suse.de>,
        Keith Owens <kaos@ocs.com.au>,
        Linux kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20001128202259.E27219@garloff.etpnet.phys.tue.nl> <3301.975443633@ocs3.ocs-net> <20001128222448.H27219@garloff.etpnet.phys.tue.nl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
        protocol="application/pgp-signature"; boundary="brEuL7wsLY8+TuWz"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20001128222448.H27219@garloff.etpnet.phys.tue.nl>; from garloff@suse.de on Tue, Nov 28, 2000 at 10:24:48PM +0100
X-Operating-System: Linux 2.2.16 i686
X-PGP-Info: on http://www.garloff.de/kurt/mykeys.pgp
X-PGP-Key: 1024D/1C98774E, 1024R/CEFC9215
Organization: TUE/NL, SuSE/FRG
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--brEuL7wsLY8+TuWz
Content-Type: multipart/mixed; boundary="sgneBHv3152wZ8jf"
Content-Disposition: inline


--sgneBHv3152wZ8jf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 28, 2000 at 10:24:48PM +0100, Kurt Garloff wrote:
> This is a pity, because I think the current behaviour is not acceptable,
> as it can kill the machine by just being invoked by kmod.
> I will try to make sense out of the code and make sure that modprobe
> will not go crazy, by either detecting loops (if I can do that in a way
> wihtout breaking things) or by limiting the recursion depth. I'll send
> you a patch.

Find it attached. As the dependency generation looked indeed rather
cumbersome to me, I didn't really touch it. I just did implement the
recursion limit to prevent the modprobe process grabbing all the memory of
the system ...
root@cantaloupe:~ > modprobe -k pppoe
modprobe: Too deep recursion in module dependencies!
modprobe: Circular dependency? pppox pppoe
Aborted

Regards,
--=20
Kurt Garloff  <garloff@suse.de>                          Eindhoven, NL
GPG key: See mail header, key servers         Linux kernel development
SuSE GmbH, Nuernberg, FRG                               SCSI, Security

--sgneBHv3152wZ8jf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="modutils-2.3.21-limitrecursion.diff"
Content-Transfer-Encoding: quoted-printable

diff -uNr modutils-2.3.21/insmod/modprobe.c modutils-2.3.21.SuSE/insmod/mod=
probe.c
--- modutils-2.3.21/insmod/modprobe.c	Tue Nov 21 10:10:54 2000
+++ modutils-2.3.21.SuSE/insmod/modprobe.c	Wed Nov 29 00:39:54 2000
@@ -363,6 +363,9 @@
 	return desc;
 }
=20
+/* KG, 2000-11-29: Limit recursion in build_stack() */
+#define BSTACKRECMAX 128
+static int bstackrecurs =3D 0;
 /*
  * Create a linked list of the stack of modules needed in the kernel
  * in order to satisfy a request for "name"
@@ -395,6 +398,15 @@
 	if (rev && strcmp(rev->kname, desc->kname) =3D=3D 0)
 		return 0;
=20
+	if (++bstackrecurs > BSTACKRECMAX) {
+		fprintf (stderr, "modprobe: Too deep recursion in module dependencies!\n=
");
+		fprintf (stderr, "modprobe: Circular dependency?");
+		for (lp =3D *stack; lp; lp =3D lp->next)
+			fprintf (stderr, " %s", lp->item.d->kname);
+		fprintf (stderr, "\n");
+		abort ();
+	}
+					=20
 	/*
 	 * Get the modules that this one should pull in
 	 * according to modules.conf ("above")
@@ -414,7 +426,7 @@
 							rev ? rev : desc,
 							MODE_ABOVE, 1);
 					if (r < 0)
-						return r;
+						{ bstackrecurs--; return r; }
 				}
 			}
 		}
@@ -424,7 +436,7 @@
 		if (strcmp(desc->kname, lp->item.d->kname) =3D=3D 0) {
 			/* Avoid infinite loops ("above") */
 			if (rev && rev =3D=3D lp->item.d)
-				return 0;
+				{ bstackrecurs--; return 0; }
 			/* else */
 			/* Remove the entry, it is in the wrong place */
 			if (prev)
@@ -452,7 +464,7 @@
 						dir,
 						rev,
 						MODE_BELOW, 1)) < 0)
-					return r;
+					{ bstackrecurs--; return r; }
 			}
 		}
 	}
@@ -465,10 +477,10 @@
 	for (nod =3D desc->nod->dep; nod; nod =3D nod->next) {
 		if ((r =3D build_stack(stack, nod->key, nod->str, dir, rev,
 			MODE_NORMAL, 0)) < 0)
-			return r;
+			{ bstackrecurs--; return r; }
 	}
=20
-	return 0;
+	bstackrecurs--; return 0;
 }
=20
 /* For debugging */

--sgneBHv3152wZ8jf--

--brEuL7wsLY8+TuWz
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE6JFJnxmLh6hyYd04RAmjlAKCUsfII1SYksJBajgLtLYrY8N4W+wCgtZNV
xqKER/OSJOkg+sqdKRy8v6E=
=1bDp
-----END PGP SIGNATURE-----

--brEuL7wsLY8+TuWz--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
