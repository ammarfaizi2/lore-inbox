Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313678AbSDEWoV>; Fri, 5 Apr 2002 17:44:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313672AbSDEWoN>; Fri, 5 Apr 2002 17:44:13 -0500
Received: from smtp012.mail.yahoo.com ([216.136.173.32]:39182 "HELO
	smtp012.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S313665AbSDEWoC>; Fri, 5 Apr 2002 17:44:02 -0500
Subject: [PATCH] PnP BIOS catch up
From: Thomas Hood <jdthood@yahoo.co.uk>
To: linux-kernel@vger.kernel.org
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-qZNdp1IG7SCeaeqMYraa"
Message-Id: <1018042857.12139.124.camel@thanatos>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.0.3 
Date: 05 Apr 2002 17:45:35 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-qZNdp1IG7SCeaeqMYraa
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

The patch to the PnP BIOS driver that was in 2.5.7-dj and which
just went into 2.5.8-pre1 did not include Brian Gerst's SMP fix.
I append it below.  Dave: Please feed to Linus.

The pnpbios driver in 2.4.19-pre-ac is up to date.  Alan: Please
feed to Marcelo!                                    // Thomas Hood

--- linux-2.5.8-pre1/drivers/pnp/pnpbios_core.c.orig	Fri Apr  5 13:48:15 20=
02
+++ linux-2.5.8-pre1/drivers/pnp/pnpbios_core.c	Fri Apr  5 16:32:28 2002
@@ -1,10 +1,19 @@
 /*
- * PnP BIOS services
+ * pnpbios -- PnP BIOS driver
+ *
+ * This driver provides access to Plug-'n'-Play services provided by
+ * the PnP BIOS firmware, described in the following documents:
+ *   Plug and Play BIOS Specification, Version 1.0A, 5 May 1994
+ *   Plug and Play BIOS Clarification Paper, 6 October 1994
+ *     Compaq Computer Corporation, Phoenix Technologies Ltd., Intel Corp.
  *=20
  * Originally (C) 1998 Christian Schmidt <schmidt@digadd.de>
- * Modifications (c) 1998 Tom Lees <tom@lpsg.demon.co.uk>
+ * Modifications (C) 1998 Tom Lees <tom@lpsg.demon.co.uk>
  * Minor reorganizations by David Hinds <dahinds@users.sourceforge.net>
- * Modifications (c) 2001,2002 by Thomas Hood <jdthood@mail.com>
+ * Further modifications (C) 2001, 2002 by:
+ *   Alan Cox <alan@redhat.com>
+ *   Thomas Hood <jdthood@mail.com>
+ *   Brian Gerst <bgerst@didntduck.org>
  *
  * This program is free software; you can redistribute it and/or modify it
  * under the terms of the GNU General Public License as published by the
@@ -19,12 +28,6 @@
  * You should have received a copy of the GNU General Public License
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  U=
SA
- *
- * References:
- *   Compaq Computer Corporation, Phoenix Technologies Ltd., Intel Corpora=
tion
- *   Plug and Play BIOS Specification, Version 1.0A, May 5, 1994
- *   Plug and Play BIOS Clarification Paper, October 6, 1994
- *
  */
=20
 #include <linux/types.h>
@@ -141,7 +144,9 @@
 static spinlock_t pnp_bios_lock;
=20
 static inline u16 call_pnp_bios(u16 func, u16 arg1, u16 arg2, u16 arg3,
-                                u16 arg4, u16 arg5, u16 arg6, u16 arg7)
+				u16 arg4, u16 arg5, u16 arg6, u16 arg7,
+				void *ts1_base, u32 ts1_size,
+				void *ts2_base, u32 ts2_size)
 {
 	unsigned long flags;
 	u16 status;
@@ -155,7 +160,12 @@
=20
 	/* On some boxes IRQ's during PnP BIOS calls are deadly.  */
 	spin_lock_irqsave(&pnp_bios_lock, flags);
-	__cli();
+
+	if (ts1_size)
+		Q2_SET_SEL(PNP_TS1, ts1_base, ts1_size);
+	if (ts2_size)
+		Q2_SET_SEL(PNP_TS2, ts2_base, ts2_size);
+
 	__asm__ __volatile__(
 	        "pushl %%ebp\n\t"
 		"pushl %%edi\n\t"
@@ -258,8 +268,8 @@
 	u16 status;
 	if (!pnp_bios_present())
 		return PNP_FUNCTION_NOT_SUPPORTED;
-	Q2_SET_SEL(PNP_TS1, data, sizeof(struct pnp_dev_node_info));
-	status =3D call_pnp_bios(PNP_GET_NUM_SYS_DEV_NODES, 0, PNP_TS1, 2, PNP_TS=
1, PNP_DS, 0, 0);
+	status =3D call_pnp_bios(PNP_GET_NUM_SYS_DEV_NODES, 0, PNP_TS1, 2, PNP_TS=
1, PNP_DS, 0, 0,
+			       data, sizeof(struct pnp_dev_node_info), 0, 0);
 	data->no_nodes &=3D 0xff;
 	return status;
 }
@@ -293,9 +303,8 @@
 		return PNP_FUNCTION_NOT_SUPPORTED;
 	if ( !boot & pnpbios_dont_use_current_config )
 		return PNP_FUNCTION_NOT_SUPPORTED;
-	Q2_SET_SEL(PNP_TS1, nodenum, sizeof(char));
-	Q2_SET_SEL(PNP_TS2, data, 64 * 1024);
-	status =3D call_pnp_bios(PNP_GET_SYS_DEV_NODE, 0, PNP_TS1, 0, PNP_TS2, bo=
ot ? 2 : 1, PNP_DS, 0);
+	status =3D call_pnp_bios(PNP_GET_SYS_DEV_NODE, 0, PNP_TS1, 0, PNP_TS2, bo=
ot ? 2 : 1, PNP_DS, 0,
+			       nodenum, sizeof(char), data, 65536);
 	return status;
 }
=20
@@ -322,8 +331,8 @@
 		return PNP_FUNCTION_NOT_SUPPORTED;
 	if ( !boot & pnpbios_dont_use_current_config )
 		return PNP_FUNCTION_NOT_SUPPORTED;
-	Q2_SET_SEL(PNP_TS1, data, /* *((u16 *) data)*/ 65536);
-	status =3D call_pnp_bios(PNP_SET_SYS_DEV_NODE, nodenum, 0, PNP_TS1, boot =
? 2 : 1, PNP_DS, 0, 0);
+	status =3D call_pnp_bios(PNP_SET_SYS_DEV_NODE, nodenum, 0, PNP_TS1, boot =
? 2 : 1, PNP_DS, 0, 0,
+			       data, 65536, 0, 0);
 	return status;
 }
=20
@@ -354,8 +363,8 @@
 	u16 status;
 	if (!pnp_bios_present())
 		return PNP_FUNCTION_NOT_SUPPORTED;
-	Q2_SET_SEL(PNP_TS1, event, sizeof(u16));
-	status =3D call_pnp_bios(PNP_GET_EVENT, 0, PNP_TS1, PNP_DS, 0, 0 ,0 ,0);
+	status =3D call_pnp_bios(PNP_GET_EVENT, 0, PNP_TS1, PNP_DS, 0, 0 ,0 ,0,
+			       event, sizeof(u16), 0, 0);
 	return status;
 }
 #endif
@@ -369,7 +378,7 @@
 	u16 status;
 	if (!pnp_bios_present())
 		return PNP_FUNCTION_NOT_SUPPORTED;
-	status =3D call_pnp_bios(PNP_SEND_MESSAGE, message, PNP_DS, 0, 0, 0, 0, 0=
);
+	status =3D call_pnp_bios(PNP_SEND_MESSAGE, message, PNP_DS, 0, 0, 0, 0, 0=
, 0, 0, 0, 0);
 	return status;
 }
 #endif
@@ -383,8 +392,8 @@
 	u16 status;
 	if (!pnp_bios_present())
 		return PNP_FUNCTION_NOT_SUPPORTED;
-	Q2_SET_SEL(PNP_TS1, data, sizeof(struct pnp_docking_station_info));
-	status =3D call_pnp_bios(PNP_GET_DOCKING_STATION_INFORMATION, 0, PNP_TS1,=
 PNP_DS, 0, 0, 0, 0);
+	status =3D call_pnp_bios(PNP_GET_DOCKING_STATION_INFORMATION, 0, PNP_TS1,=
 PNP_DS, 0, 0, 0, 0,
+			       data, sizeof(struct pnp_docking_station_info), 0, 0);
 	return status;
 }
 #endif
@@ -399,8 +408,8 @@
 	u16 status;
 	if (!pnp_bios_present())
 		return PNP_FUNCTION_NOT_SUPPORTED;
-	Q2_SET_SEL(PNP_TS1, info, *((u16 *) info));
-	status =3D call_pnp_bios(PNP_SET_STATIC_ALLOCED_RES_INFO, 0, PNP_TS1, PNP=
_DS, 0, 0, 0, 0);
+	status =3D call_pnp_bios(PNP_SET_STATIC_ALLOCED_RES_INFO, 0, PNP_TS1, PNP=
_DS, 0, 0, 0, 0,
+			       info, *((u16 *) info), 0, 0);
 	return status;
 }
 #endif
@@ -414,8 +423,8 @@
 	u16 status;
 	if (!pnp_bios_present())
 		return PNP_FUNCTION_NOT_SUPPORTED;
-	Q2_SET_SEL(PNP_TS1, info, 64 * 1024);
-	status =3D call_pnp_bios(PNP_GET_STATIC_ALLOCED_RES_INFO, 0, PNP_TS1, PNP=
_DS, 0, 0, 0, 0);
+	status =3D call_pnp_bios(PNP_GET_STATIC_ALLOCED_RES_INFO, 0, PNP_TS1, PNP=
_DS, 0, 0, 0, 0,
+			       info, 65536, 0, 0);
 	return status;
 }
=20
@@ -437,9 +446,8 @@
 	u16 status;
 	if (!pnp_bios_present())
 		return PNP_FUNCTION_NOT_SUPPORTED;
-	Q2_SET_SEL(PNP_TS1, table, *size);
-	Q2_SET_SEL(PNP_TS2, size, sizeof(u16));
-	status =3D call_pnp_bios(PNP_GET_APM_ID_TABLE, 0, PNP_TS2, 0, PNP_TS1, PN=
P_DS, 0, 0);
+	status =3D call_pnp_bios(PNP_GET_APM_ID_TABLE, 0, PNP_TS2, 0, PNP_TS1, PN=
P_DS, 0, 0,
+			       table, *size, size, sizeof(u16));
 	return status;
 }
 #endif
@@ -452,8 +460,8 @@
 	u16 status;
 	if (!pnp_bios_present())
 		return PNP_FUNCTION_NOT_SUPPORTED;
-	Q2_SET_SEL(PNP_TS1, data, sizeof(struct pnp_isa_config_struc));
-	status =3D call_pnp_bios(PNP_GET_PNP_ISA_CONFIG_STRUC, 0, PNP_TS1, PNP_DS=
, 0, 0, 0, 0);
+	status =3D call_pnp_bios(PNP_GET_PNP_ISA_CONFIG_STRUC, 0, PNP_TS1, PNP_DS=
, 0, 0, 0, 0,
+			       data, sizeof(struct pnp_isa_config_struc), 0, 0);
 	return status;
 }
=20
@@ -474,8 +482,8 @@
 	u16 status;
 	if (!pnp_bios_present())
 		return ESCD_FUNCTION_NOT_SUPPORTED;
-	Q2_SET_SEL(PNP_TS1, data, sizeof(struct escd_info_struc));
-	status =3D call_pnp_bios(PNP_GET_ESCD_INFO, 0, PNP_TS1, 2, PNP_TS1, 4, PN=
P_TS1, PNP_DS);
+	status =3D call_pnp_bios(PNP_GET_ESCD_INFO, 0, PNP_TS1, 2, PNP_TS1, 4, PN=
P_TS1, PNP_DS,
+			       data, sizeof(struct escd_info_struc), 0, 0);
 	return status;
 }
=20
@@ -497,10 +505,8 @@
 	u16 status;
 	if (!pnp_bios_present())
 		return ESCD_FUNCTION_NOT_SUPPORTED;
-	Q2_SET_SEL(PNP_TS1, data, 64 * 1024);
-	set_base(gdt[PNP_TS2 >> 3], nvram_base);
-	set_limit(gdt[PNP_TS2 >> 3], 64 * 1024);
-	status =3D call_pnp_bios(PNP_READ_ESCD, 0, PNP_TS1, PNP_TS2, PNP_DS, 0, 0=
, 0);
+	status =3D call_pnp_bios(PNP_READ_ESCD, 0, PNP_TS1, PNP_TS2, PNP_DS, 0, 0=
, 0,
+			       data, 65536, (void *)nvram_base, 65536);
 	return status;
 }
=20
@@ -522,10 +528,8 @@
 	u16 status;
 	if (!pnp_bios_present())
 		return ESCD_FUNCTION_NOT_SUPPORTED;
-	Q2_SET_SEL(PNP_TS1, data, 64 * 1024);
-	set_base(gdt[PNP_TS2 >> 3], nvram_base);
-	set_limit(gdt[PNP_TS2 >> 3], 64 * 1024);
-	status =3D call_pnp_bios(PNP_WRITE_ESCD, 0, PNP_TS1, PNP_TS2, PNP_DS, 0, =
0, 0);
+	status =3D call_pnp_bios(PNP_WRITE_ESCD, 0, PNP_TS1, PNP_TS2, PNP_DS, 0, =
0, 0,
+			       data, 65536, nvram_base, 65536);
 	return status;
 }
 #endif

--=-qZNdp1IG7SCeaeqMYraa
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQA8rhnoJnAhHStZL6ERArbFAJ9YaI8iUebqJ4y33+juKTR6IGMjZACfaj8z
DW1AJm57YNhADbvuf8aaqgU=
=ezBq
-----END PGP SIGNATURE-----

--=-qZNdp1IG7SCeaeqMYraa--



_________________________________________________________
Do You Yahoo!?
Get your free @yahoo.com address at http://mail.yahoo.com

