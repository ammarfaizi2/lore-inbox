Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261367AbVBNX5b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261367AbVBNX5b (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Feb 2005 18:57:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261348AbVBNX5b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Feb 2005 18:57:31 -0500
Received: from smtp09.auna.com ([62.81.186.19]:8183 "EHLO smtp09.retemail.es")
	by vger.kernel.org with ESMTP id S261367AbVBNX5I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Feb 2005 18:57:08 -0500
Date: Mon, 14 Feb 2005 23:57:07 +0000
From: "J.A. Magallon" <jamagallon@able.es>
Subject: udev and cdsymlinks
To: Lista Linux-Kernel <linux-kernel@vger.kernel.org>
Cc: Greg KH <gregkh@suse.de>
X-Mailer: Balsa 2.3.0
Message-Id: <1108425427l.23313l.1l@werewolf.able.es>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
	protocol="application/pgp-signature"; boundary="=-+tQ5BUxpbw6DOLkdcO+U"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-+tQ5BUxpbw6DOLkdcO+U
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi all...

There are some problems with current udev. I wil try to propose an acceptab=
le
solution (ie, patch ;) ).

My problems are with cdsymlinks (the C version, mandrake cooker uses that;
all I say is applicable also to the bash version).

Problems with udev-053:cdymlinks.c:

- Does not obey the NUMBERED_LINKS flag. Just a problem with string lengths=
.
  Fixed below.
- The nunbered links sould always be present (ie, kill NUMBERED_LINKS).
  Why ?
    - In a box with several optical units, you obviously need numbered link=
s.
      You also need a 'default' unit for each class (cdrom, dvd, cdrw...)
    - In a box with only one unit, you also need the numbered links for
      compatibility (a program can try to open cdrom{i}, i in 0.., ) until
      it fails...)
- In a box with just one DVDRW it fails, typo in the strtok.

Is this patch acceptable ?

TIA

--- cdsymlinks.c.orig	2005-02-14 23:18:16.000000000 +0100
+++ cdsymlinks.c	2005-02-15 00:30:16.000000000 +0100
@@ -55,7 +55,6 @@
=20
 /* Configuration variables */
 static struct list_t allowed_output =3D {0};
-static int numbered_links =3D 1;
=20
 /* Available devices */
 static struct list_t Devices =3D {0};
@@ -218,7 +217,7 @@
 list_assign_split (struct list_t *list, char *text)
 {
   char *token =3D strchr (text, ':');
-  token =3D strtok (token ? token + 1 : text, " \t");
+  token =3D strtok (token ? token + 1 : text, " \t\n");
   while (token)
   {
     list_prepend (list, token);
@@ -267,8 +266,6 @@
             list_delete (&allowed_output);
             list_assign_split (&allowed_output, p.we_wordv[0] + 7);
           }
-          else if (!strncmp (p.we_wordv[0], "NUMBERED_LINKS=3D", 14))
-            numbered_links =3D atoi (p.we_wordv[0] + 14);
           break;
 	}
 	/* fall through */
@@ -325,9 +322,9 @@
       list_assign_split (&cap_CDRW, text);
     else if (!strncasecmp (text, "Can write CD-R", 14))
       list_assign_split (&cap_CDR, text);
-    else if (!strncasecmp (text, "Can read MRW", 14))
+    else if (!strncasecmp (text, "Can read MRW", 12))
       list_assign_split (&cap_CDMRW, text);
-    else if (!strncasecmp (text, "Can write MRW", 14))
+    else if (!strncasecmp (text, "Can write MRW", 13))
       list_assign_split (&cap_CDWMRW, text);
   }
   if (!feof (info))
@@ -408,24 +405,30 @@
        */
       present =3D 1;
       if (isdev)
-        printf (" %s", list_nth (&devls, li)->data);
+        printf ("%s ", list_nth (&devls, li)->data);
     }
=20
     /* If we found no existing symlinks for the target device... */
     if (!present)
     {
       char buf[256];
-      snprintf (buf, sizeof (buf), count ? "%s%d" : "%s", link, count);
-      /* Find the next available (not present) symlink name.
-       * We always need to do this for reasons of output consistency: if a
-       * symlink is created by udev as a result of use of this program, we
-       * DON'T want different output!
-       */
-      while (list_search (&devls, buf))
-        snprintf (buf, sizeof (buf), "%s%d", link, ++count);
-      /* If ISDEV, output it. */
-      if (isdev && (numbered_links || count =3D=3D 0))
-        printf (" %s", buf);
+      if (!count)=20
+	  {
+        snprintf (buf, sizeof (buf), "%s", link);
+        if (isdev && !list_search (&devls, buf))
+          printf ("%s ", buf);
+	  }
+	  /* Find the next available (not present) symlink name.
+	   * We always need to do this for reasons of output consistency: if a
+	   * symlink is created by udev as a result of use of this program, we
+	   * DON'T want different output!
+	   */
+	  snprintf (buf, sizeof (buf), "%s%d", link, count);
+	  while (list_search (&devls, buf))
+		snprintf (buf, sizeof (buf), "%s%d", link, ++count);
+	  /* If ISDEV, output it. */
+	  if (isdev)
+		printf ("%s ", buf);
       /* If the link isn't in our "existing links" list, add it and increm=
ent
        * our counter.
        */

--
J.A. Magallon <jamagallon()able!es>     \               Software is like se=
x:
werewolf!able!es                         \         It's better when it's fr=
ee
Mandrakelinux release 10.2 (Cooker) for i586
Linux 2.6.10-jam9 (gcc 3.4.3 (Mandrakelinux 10.2 3.4.3-3mdk)) #1


--=-+tQ5BUxpbw6DOLkdcO+U
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQBCETrTRlIHNEGnKMMRAiljAJ0Q10NMvvhf5vLSiFlm+RP1zmaT7wCeIr08
NZ3CJbQdQFGnnf8H9vdlZA4=
=oPG/
-----END PGP SIGNATURE-----

--=-+tQ5BUxpbw6DOLkdcO+U--

