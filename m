Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264723AbUFGMqY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264723AbUFGMqY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jun 2004 08:46:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264414AbUFGMoT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jun 2004 08:44:19 -0400
Received: from mail.donpac.ru ([80.254.111.2]:33773 "EHLO donpac.ru")
	by vger.kernel.org with ESMTP id S264733AbUFGMlj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jun 2004 08:41:39 -0400
Date: Mon, 7 Jun 2004 16:41:25 +0400
From: Andrey Panin <pazke@donpac.ru>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.7-rc2-mm2
Message-ID: <20040607124125.GT3776@pazke>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org
References: <20040603015356.709813e9.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="D/26AIznG/rf8cgR"
Content-Disposition: inline
In-Reply-To: <20040603015356.709813e9.akpm@osdl.org>
User-Agent: Mutt/1.5.6i
X-SMTP-Authenticated: pazke@donpac.ru (cram)
X-SMTP-TLS: TLSv1:AES256-SHA:256
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--D/26AIznG/rf8cgR
Content-Type: multipart/mixed; boundary="28wbjzzu+2Xmo01Z"
Content-Disposition: inline


--28wbjzzu+2Xmo01Z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 155, 06 03, 2004 at 01:53:56AM -0700, Andrew Morton wrote:
>=20
> - As soon as I merged Andrey's big dmi cleanup patches everyone started
>   madly patching dmi_scan.c.  The subsequent reject storm forced me to dr=
op
>   them.

Could you apply attached patch (only exports DMI check functions) instead o=
f them ?
With this patch applied these "mad patchers" will have an alternative
to pushing their crap^H^H^Hhanges into dmi_scan.c

I tried to make this patch as nonintrusive as possible.

Best regards.

--=20
Andrey Panin		| Linux and UNIX system administrator
pazke@donpac.ru		| PGP key: wwwkeys.pgp.net

--28wbjzzu+2Xmo01Z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch-dmi-api
Content-Transfer-Encoding: quoted-printable

diff -urpN -X /usr/share/dontdiff linux-2.6.7-rc1-mm1.vanilla/arch/i386/ker=
nel/dmi_scan.c linux-2.6.7-rc1-mm1/arch/i386/kernel/dmi_scan.c
--- linux-2.6.7-rc1-mm1.vanilla/arch/i386/kernel/dmi_scan.c	Fri May  7 22:5=
6:24 2004
+++ linux-2.6.7-rc1-mm1/arch/i386/kernel/dmi_scan.c	Fri May  7 23:14:09 2004
@@ -10,6 +10,7 @@
 #include <asm/io.h>
 #include <linux/pm.h>
 #include <asm/system.h>
+#include <linux/dmi.h>
 #include <linux/bootmem.h>
=20
 unsigned long dmi_broken;
@@ -139,21 +140,6 @@ static int __init dmi_iterate(void (*dec
 	return -1;
 }
=20
-
-enum
-{
-	DMI_BIOS_VENDOR,
-	DMI_BIOS_VERSION,
-	DMI_BIOS_DATE,
-	DMI_SYS_VENDOR,
-	DMI_PRODUCT_NAME,
-	DMI_PRODUCT_VERSION,
-	DMI_BOARD_VENDOR,
-	DMI_BOARD_NAME,
-	DMI_BOARD_VERSION,
-	DMI_STRING_MAX
-};
-
 static char *dmi_ident[DMI_STRING_MAX];
=20
 /*
@@ -176,26 +162,11 @@ static void __init dmi_save_ident(struct
 }
=20
 /*
- *	DMI callbacks for problem boards
+ * Ugly compatibility crap.
  */
-
-struct dmi_strmatch
-{
-	u8 slot;
-	char *substr;
-};
-
-#define NONE	255
-
-struct dmi_blacklist
-{
-	int (*callback)(struct dmi_blacklist *);
-	char *ident;
-	struct dmi_strmatch matches[4];
-};
-
-#define NO_MATCH	{ NONE, NULL}
-#define MATCH(a,b)	{ a, b }
+#define dmi_blacklist	dmi_system_id
+#define NO_MATCH	{ DMI_NONE, NULL}
+#define MATCH		DMI_MATCH
=20
 /*=20
  * Reboot options and system auto-detection code provided by
@@ -1072,9 +1043,6 @@ static __initdata struct dmi_blacklist d
=20
 static __init void dmi_check_blacklist(void)
 {
-	struct dmi_blacklist *d;
-	int i;
-	=09
 #ifdef	CONFIG_ACPI_BOOT
 #define	ACPI_BLACKLIST_CUTOFF_YEAR	2001
=20
@@ -1096,25 +1064,7 @@ static __init void dmi_check_blacklist(v
 		}
 	}
 #endif
-
-	d=3D&dmi_blacklist[0];
-	while(d->callback)
-	{
-		for(i=3D0;i<4;i++)
-		{
-			int s =3D d->matches[i].slot;
-			if(s=3D=3DNONE)
-				continue;
-			if(dmi_ident[s] && strstr(dmi_ident[s], d->matches[i].substr))
-				continue;
-			/* No match */
-			goto fail;
-		}
-		if(d->callback(d))
-			return;
-fail:		=09
-		d++;
-	}
+ 	dmi_check_system(dmi_blacklist);
 }
=20
 =09
@@ -1181,3 +1131,52 @@ void __init dmi_scan_machine(void)
 }
=20
 EXPORT_SYMBOL(is_unsafe_smbus);
+
+
+/**
+ *	dmi_check_system - check system DMI data
+ *	@list: array of dmi_system_id structures to match against
+ *
+ *	Walk the blacklist table running matching functions until someone
+ *	returns non zero or we hit the end. Callback function is called for
+ *	each successfull match. Returns the number of matches.
+ */
+int dmi_check_system(struct dmi_system_id *list)
+{
+	int i, count =3D 0;
+	struct dmi_system_id *d =3D list;
+
+	while (d->ident) {
+		for (i =3D 0; i < ARRAY_SIZE(d->matches); i++) {
+			int s =3D d->matches[i].slot;
+			if (s =3D=3D DMI_NONE)
+				continue;
+			if (dmi_ident[s] && strstr(dmi_ident[s], d->matches[i].substr))
+				continue;
+			/* No match */
+			goto fail;
+		}
+		if (d->callback && d->callback(d))
+			break;
+		count++;
+fail:		d++;
+	}
+
+	return count;
+}
+
+EXPORT_SYMBOL(dmi_check_system);
+
+/**
+ *	dmi_get_system_info - return DMI data value
+ *	@field: data index (see enum dmi_filed)
+ *
+ *	Returns one DMI data value, can be used to perform
+ *	complex DMI data checks.
+ */
+char * dmi_get_system_info(int field)
+{
+	return dmi_ident[field];
+}
+
+EXPORT_SYMBOL(dmi_get_system_info);
diff -urpN -X /usr/share/dontdiff linux-2.6.7-rc1-mm1.vanilla/include/linux=
/dmi.h linux-2.6.7-rc1-mm1/include/linux/dmi.h
--- linux-2.6.7-rc1-mm1.vanilla/include/linux/dmi.h	Thu Jan  1 03:00:00 1970
+++ linux-2.6.7-rc1-mm1/include/linux/dmi.h	Fri May  7 23:28:38 2004
@@ -0,0 +1,47 @@
+#ifndef __DMI_H__
+#define __DMI_H__
+
+enum dmi_field {
+	DMI_NONE,
+	DMI_BIOS_VENDOR,
+	DMI_BIOS_VERSION,
+	DMI_BIOS_DATE,
+	DMI_SYS_VENDOR,
+	DMI_PRODUCT_NAME,
+	DMI_PRODUCT_VERSION,
+	DMI_BOARD_VENDOR,
+	DMI_BOARD_NAME,
+	DMI_BOARD_VERSION,
+	DMI_STRING_MAX,
+};
+
+/*
+ *	DMI callbacks for problem boards
+ */
+struct dmi_strmatch {
+	u8 slot;
+	char *substr;
+};
+
+struct dmi_system_id {
+	int (*callback)(struct dmi_system_id *);
+	char *ident;
+	struct dmi_strmatch matches[4];
+	void *driver_data;
+};
+
+#define DMI_MATCH(a,b)	{ a, b }
+
+#if defined(CONFIG_X86) && !defined(CONFIG_X86_64)
+
+extern int dmi_check_system(struct dmi_system_id *list);
+extern char * dmi_get_system_info(int field);
+
+#else
+
+static inline int dmi_check_system(struct dmi_system_id *list) { return 0;=
 }
+static inline char * dmi_get_system_info(int field) { return NULL; }
+
+#endif
+
+#endif	/* __DMI_H__ */

--28wbjzzu+2Xmo01Z--

--D/26AIznG/rf8cgR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAxGJ1by9O0+A2ZecRAk0/AJwODuJXqy62J2Opgpx+AF1d8/UGYwCfexe7
Cqx7u/juDdh1O1qQlmKu5Kw=
=y/Sj
-----END PGP SIGNATURE-----

--D/26AIznG/rf8cgR--
