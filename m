Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263489AbTJVTCs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Oct 2003 15:02:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263531AbTJVTCs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Oct 2003 15:02:48 -0400
Received: from 208.177.141.226.ptr.us.xo.net ([208.177.141.226]:59009 "HELO
	ash.lnxi.com") by vger.kernel.org with SMTP id S263489AbTJVTCl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Oct 2003 15:02:41 -0400
Subject: [BUG][PATCH] BIOS reserved regions block iomem registration
From: Thayne Harbaugh <tharbaugh@lnxi.com>
Reply-To: tharbaugh@lnxi.com
To: linux-kernel@vger.kernel.org
Cc: trivial@rustcorp.com.au, Eric Biederman <ebiederman@lnxi.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-6VpZpG3GMFPuVLMw/dQW"
Organization: Linux Networx
Message-Id: <1066849062.6281.190.camel@tubarao>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 22 Oct 2003 12:57:43 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-6VpZpG3GMFPuVLMw/dQW
Content-Type: multipart/mixed; boundary="=-FYKdobl1tfny3zXUWPG6"


--=-FYKdobl1tfny3zXUWPG6
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

arch/i386/kernel/setup.c:register_memory() marks e820 memory regions -
some of which are "reserved".  These "reserved" regions prevent FLASH
chip drivers from registering the memory range occupied by BIOS code:

bash-2.05# cat /proc/iomem
.
.
.
fec00000-fec003ff : reserved
fee00000-fee00fff : reserved
fff80000-ffffffff : reserved

The last range marked as "reserved" (fff80000-ffffffff) is occupied by
the FLASH chip containing the BIOS code.  I'd like the MTD drivers to
register the correct ranges like this:

fec00000-fec003ff : reserved
fee00000-fee00fff : reserved
ffb00000-ffffffff : amd76xrom
  fff80000-ffffffff : mtd0

That way the iomem resources will be correct and can be used to map
FLASH chip updates.

There are at least two ways to fix this problem:

1) Don't mark the BIOS reserved regions.  Some BIOSes don't mark these
and the kernel works fine.  This is a trivial patch of removing the
"reserved" line in setup.c:register_memory().  See
remove_reserved.patch.

2) Leave the "reserved" regions but mark them with a IORESOURCE_GUESS so
that they can be removed by a driver that knows better and is capable of
correctly using the memory range.  See resource_guess_flag.patch.

Both of these patches were made on 2.4.20, but will likely apply
trivially to any 2.4.x or 2.6.


--=20
Thayne Harbaugh
Linux Networx

--=-FYKdobl1tfny3zXUWPG6
Content-Disposition: attachment; filename=remove_reserved.patch
Content-Type: text/plain; name=remove_reserved.patch; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

--- linux-2.4.20/arch/i386/kernel/setup.c	2002-11-28 16:53:09.000000000 -07=
00
+++ linux-2.4.20-bs/arch/i386/kernel/setup.c	2003-10-17 12:01:12.000000000 =
-0600
@@ -1047,7 +1047,6 @@
 		case E820_RAM:	res->name =3D "System RAM"; break;
 		case E820_ACPI:	res->name =3D "ACPI Tables"; break;
 		case E820_NVS:	res->name =3D "ACPI Non-volatile Storage"; break;
-		default:	res->name =3D "reserved";
 		}
 		res->start =3D e820.map[i].addr;
 		res->end =3D res->start + e820.map[i].size - 1;

--=-FYKdobl1tfny3zXUWPG6
Content-Disposition: attachment; filename=resource_guess_flag.patch
Content-Type: text/plain; name=resource_guess_flag.patch; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

--- linux-2.4.20/kernel/resource.c	2002-11-28 16:53:15.000000000 -0700
+++ linux-2.4.20-bs/kernel/resource.c	2003-10-16 16:17:15.000000000 -0600
@@ -70,6 +70,8 @@
 	unsigned long end =3D new->end;
 	struct resource *tmp, **p;
=20
+	if (root->flags & IORESOURCE_GUESS)
+		return root;
 	if (end < start)
 		return root;
 	if (start < root->start)
@@ -121,6 +123,70 @@
 	return conflict ? -EBUSY : 0;
 }
=20
+int request_resource_remove_guess(struct resource *root, struct resource *=
new)
+{
+	struct resource *conflict, *sibling, *conflict_head =3D NULL;
+	int rc =3D -EBUSY;
+
+	write_lock(&resource_lock);
+	for (;;) {
+		conflict =3D __request_resource(root, new);
+		if (! conflict) {
+			/* success - free any IORESOURCE_GUESS resources */
+#if 0
+/* this doesn't work because the resources are alloc_bootmem_low() */
+			while (conflict_head) {
+				sibling =3D conflict_head->sibling;
+				kfree(conflict_head);
+				conflict_head =3D sibling;
+			}
+#endif
+			rc =3D 0;
+			break;
+		}
+		/* something is in the way - check to see what it is */
+		if (conflict->flags & IORESOURCE_GUESS) {
+			/* It's a guess that can be removed */
+			if (__release_resource(conflict)) {
+				printk(KERN_ERR __FILE__
+				       " %s(): unable to remove conflict:"
+				       " %s %08lx-%08lx\n",
+				       __func__,
+				       conflict_head->name,
+				       conflict_head->start,
+				       conflict_head->end);
+				break;
+			}
+			conflict->sibling =3D conflict_head;
+			conflict_head =3D conflict;
+			continue;
+		}
+		/* Can't remove the conflict */
+		break;
+	}
+
+	/* If we have anything then put it back */
+	while (conflict_head) {
+		sibling =3D conflict_head->sibling;
+		if ((conflict =3D __request_resource(root, conflict_head))) {
+			/* We hold the lock so why can't the
+			   resource be replaced? */
+			printk(KERN_ERR __FILE__
+			       " %s(): failed to replace resource:"
+			       " %s %08lx-%08lx\n",
+			       __func__,
+			       conflict_head->name,
+			       conflict_head->start,
+			       conflict_head->end);
+			kfree(conflict);
+		}
+		conflict_head =3D sibling;
+	}
+
+	write_unlock(&resource_lock);
+	return rc;
+}
+
 int release_resource(struct resource *old)
 {
 	int retval;
--- linux-2.4.20/include/linux/ioport.h	2002-11-28 16:53:15.000000000 -0700
+++ linux-2.4.20-bs/include/linux/ioport.h	2003-10-16 10:15:53.000000000 -0=
600
@@ -42,6 +42,15 @@
 #define IORESOURCE_SHADOWABLE	0x00010000
 #define IORESOURCE_BUS_HAS_VGA	0x00080000
=20
+#define IORESOURCE_GUESS	0x08000000	/* These regions are reserved
+						   but it's unknown if it's
+						   100% accurate.  Must not have
+						   children.  Can be removed by
+						   request_resource_remove_guess()
+						   which will also kfree() the
+						   resource - handles for these
+						   aren't tracked by anything. */
+
 #define IORESOURCE_UNSET	0x20000000
 #define IORESOURCE_AUTO		0x40000000
 #define IORESOURCE_BUSY		0x80000000	/* Driver has marked this resource bus=
y */
@@ -87,6 +96,7 @@
=20
 extern int check_resource(struct resource *root, unsigned long, unsigned l=
ong);
 extern int request_resource(struct resource *root, struct resource *new);
+extern int request_resource_remove_guess(struct resource *root, struct res=
ource *new);
 extern int release_resource(struct resource *new);
 extern int allocate_resource(struct resource *root, struct resource *new,
 			     unsigned long size,
--- linux-2.4.20/kernel/ksyms.c	2003-06-18 17:04:08.000000000 -0600
+++ linux-2.4.20-bs/kernel/ksyms.c	2003-10-16 10:58:15.000000000 -0600
@@ -431,6 +431,7 @@
=20
 /* resource handling */
 EXPORT_SYMBOL(request_resource);
+EXPORT_SYMBOL(request_resource_remove_guess);
 EXPORT_SYMBOL(release_resource);
 EXPORT_SYMBOL(allocate_resource);
 EXPORT_SYMBOL(check_resource);

--=-FYKdobl1tfny3zXUWPG6--

--=-6VpZpG3GMFPuVLMw/dQW
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA/ltMmfsBPTKE6HMkRAtygAJ9D/NRKgjJ2X2IAgHSbgG/HZfP1PwCfbbDW
uk2Drc3QeBXwzzzkLnNLwkk=
=Dtlh
-----END PGP SIGNATURE-----

--=-6VpZpG3GMFPuVLMw/dQW--

