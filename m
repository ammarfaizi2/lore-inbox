Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262224AbUKQHQW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262224AbUKQHQW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Nov 2004 02:16:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262225AbUKQHQW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Nov 2004 02:16:22 -0500
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:9384 "EHLO
	pd4mo3so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S262224AbUKQHPq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Nov 2004 02:15:46 -0500
Date: Wed, 17 Nov 2004 00:10:15 -0800
From: "Robin H. Johnson" <robbat2@gentoo.org>
Subject: Ksymoops and objdump/nm complain 'File format is ambiguous' - Patch
 included
To: linux-kernel@vger.kernel.org
Message-id: <20041117081015.GA14601@curie-int.orbis-terrarum.net>
MIME-version: 1.0
Content-type: multipart/signed; boundary=gj572EiMnwbLXET9;
 protocol="application/pgp-signature"; micalg=pgp-sha1
Content-disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--gj572EiMnwbLXET9
Content-Type: multipart/mixed; boundary="qDbXVdCdHGoSgWSk"
Content-Disposition: inline


--qDbXVdCdHGoSgWSk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

(I wrote this ~5 months ago, sent it to the author in August, had no
response, resent it to another address for the author in early October,
still had no response, so now I'm posting it here).

Under certain binutils configurations (primarily when multiple targets
are enabled), objdump and nm give an error 'File format is ambiguous'
and require explicit specification of the target after listing the
possible options. This break ksymoops badly.

I've attached a patch that explicitly passes the --target option to nm
and objdump to resolve this issue. Also included is an extra section for
INSTALL on using ksymoops on non-native kernels without having a
complete cross-development suite installed.

Please CC your responses, I'm not on the list (but I do follow the
archives).

--=20
Robin Hugh Johnson
E-Mail     : robbat2@orbis-terrarum.net
Home Page  : http://www.orbis-terrarum.net/?l=3Dpeople.robbat2
ICQ#       : 30269588 or 41961639
GnuPG FP   : 11AC BA4F 4778 E3F6 E4ED  F38E B27B 944E 3488 4E85

--qDbXVdCdHGoSgWSk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="ksymoops-2.4.9-target-fix.patch"
Content-Transfer-Encoding: quoted-printable

diff -Nuar --exclude=3DMakefile -p ksymoops-2.4.9/Changelog ksymoops-2.4.9.=
mod/Changelog
--- ksymoops-2.4.9/Changelog	2003-03-20 02:12:01.000000000 -0800
+++ ksymoops-2.4.9.mod/Changelog	2004-08-26 00:45:46.718443934 -0700
@@ -1,3 +1,7 @@
+2004-08-24  Robin Johnson <robbat2@gentoo.org>
+	* Explictly pass --target on calls to nm and objdump.  Resolves cases
+	  where objdump/nm complain 'File format is ambiguous'.
+
 2003-03-20  Keith Owens  <kaos@ocs.com.au>
=20
 	ksymoops 2.4.9
diff -Nuar --exclude=3DMakefile -p ksymoops-2.4.9/INSTALL ksymoops-2.4.9.mo=
d/INSTALL
--- ksymoops-2.4.9/INSTALL	2003-03-20 02:12:01.000000000 -0800
+++ ksymoops-2.4.9.mod/INSTALL	2004-08-26 00:24:11.333872899 -0700
@@ -55,3 +55,21 @@ will build ksymoops -
 Any variable starting with DEF_ takes a string value.  These variables go
 through two levels of expansion, shell (use '...' to avoid shell expansion=
),
 and make commands (prefix " with \ to preserve " characters).
+
+Building ksymoops for cross-debugging only
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+(Or how to get to get away with not having a cross-compiler and still use
+ksymoops on a non-native kernel/crashfile).
+
+When building and installing your host binutils, pass '--enable-targets=3D=
all' to
+configure or at least enable the targets you want to debug in addition to =
your
+host target.  Using the 'all' route means you only need a single binutils =
on
+your system to debug targets supported by binutils.  To check that you have
+this done right, run nm or objdump with '-H' and look for 'supported targe=
ts'.
+It should list the targets that you are interested in.
+
+After this, build ksymoops as you would normally.
+As an example of usage:
+ksymoops -v vmlinux -K -L -O -m System.map -t elf32-tradlittlemips -a mips=
 <input
+Where vmlinux and System.map are from your cross-compiled kernel tree, and=
 your
+-t/-a options are set appropriately.
diff -Nuar --exclude=3DMakefile -p ksymoops-2.4.9/ksymoops.c ksymoops-2.4.9=
=2Emod/ksymoops.c
--- ksymoops-2.4.9/ksymoops.c	2003-03-17 23:50:39.000000000 -0800
+++ ksymoops-2.4.9.mod/ksymoops.c	2004-08-25 20:29:42.399329062 -0700
@@ -646,7 +646,7 @@ void read_symbol_sources(const OPTIONS *
     if (ss_ksyms_modules) {
 	expand_objects(options);
 	for (i =3D 0; i < ss_objects; ++i)
-	    read_object(ss_object[i]->source, i);
+	    read_object(ss_object[i]->source, i, options);
     }
     else if (options->objects)
 	printf("No modules in ksyms, skipping objects\n");
diff -Nuar --exclude=3DMakefile -p ksymoops-2.4.9/ksymoops.h ksymoops-2.4.9=
=2Emod/ksymoops.h
--- ksymoops-2.4.9/ksymoops.h	2003-03-17 23:51:36.000000000 -0800
+++ ksymoops-2.4.9.mod/ksymoops.h	2004-08-25 20:30:48.822180055 -0700
@@ -209,7 +209,7 @@ extern void compare_maps(const SYMBOL_SE
 extern SYMBOL_SET *adjust_object_offsets(SYMBOL_SET *ss);
 extern void read_vmlinux(const OPTIONS *options);
 extern void expand_objects(const OPTIONS *options);
-extern void read_object(const char *object, int i);
+extern void read_object(const char *object, int i, const OPTIONS *options);
=20
 /* oops.c */
 extern int Oops_read(OPTIONS *options);
diff -Nuar --exclude=3DMakefile -p ksymoops-2.4.9/object.c ksymoops-2.4.9.m=
od/object.c
--- ksymoops-2.4.9/object.c	2002-10-13 03:46:12.000000000 -0700
+++ ksymoops-2.4.9.mod/object.c	2004-08-26 00:35:49.594670544 -0700
@@ -14,21 +14,26 @@
 #include <sys/stat.h>
=20
 /* Extract all symbols definitions from an object using nm */
-static void read_nm_symbols(SYMBOL_SET *ss, const char *file)
+static void read_nm_symbols(SYMBOL_SET *ss, const char *file, const OPTION=
S *options)
 {
     FILE *f;
     char *cmd, *line =3D NULL, **string =3D NULL;
-    int i, size =3D 0;
+    int i, cmd_strlen, size =3D 0;
     static char const procname[] =3D "read_nm_symbols";
+	static char const nm_options[] =3D "--target=3D";
=20
     if (!regular_file(file, procname))
 	return;
=20
-    cmd =3D malloc(strlen(path_nm)+strlen(file)+2);
+    cmd_strlen =3D strlen(path_nm)+1+strlen(nm_options)+strlen(options->ta=
rget)+1+strlen(file)+1;
+	cmd =3D malloc(cmd_strlen);
     if (!cmd)
 	malloc_error("nm command");
     strcpy(cmd, path_nm);
     strcat(cmd, " ");
+	strcat(cmd, nm_options);
+	strcat(cmd, options->target);
+	strcat(cmd, " ");
     strcat(cmd, file);
     DEBUG(2, "command '%s'", cmd);
     if (!(f =3D popen_local(cmd, procname)))
@@ -58,7 +63,7 @@ void read_vmlinux(const OPTIONS *options
     if (!vmlinux)
 	return;
     ss_init(&ss_vmlinux, "vmlinux");
-    read_nm_symbols(&ss_vmlinux, vmlinux);
+    read_nm_symbols(&ss_vmlinux, vmlinux, options);
     if (ss_vmlinux.used) {
 	ss_sort_na(&ss_vmlinux);
 	extract_Version(&ss_vmlinux);
@@ -69,11 +74,11 @@ void read_vmlinux(const OPTIONS *options
 }
=20
 /* Read the symbols from one object (module) */
-void read_object(const char *object, int i)
+void read_object(const char *object, int i, const OPTIONS *options)
 {
     static char procname[] =3D "read_object";
     ss_init(ss_object[i], object);
-    read_nm_symbols(ss_object[i], object);
+    read_nm_symbols(ss_object[i], object, options);
     if ((ss_object[i])->used) {
 	ss_sort_na(ss_object[i]);
 	extract_Version(ss_object[i]);
diff -Nuar --exclude=3DMakefile -p ksymoops-2.4.9/oops.c ksymoops-2.4.9.mod=
/oops.c
--- ksymoops-2.4.9/oops.c	2003-03-17 23:54:46.000000000 -0800
+++ ksymoops-2.4.9.mod/oops.c	2004-08-26 00:32:53.657201466 -0700
@@ -217,15 +217,20 @@ static FILE *Oops_objdump(const char *fi
 {
     char *cmd;
     FILE *f;
-    static char const objdump_options[] =3D "-dhf ";
+	int cmd_strlen;
+    static char const objdump_options[] =3D "-dhf --target=3D";
     static char const procname[] =3D "Oops_objdump";
=20
-    cmd =3D malloc(strlen(path_objdump)+1+strlen(objdump_options)+strlen(f=
ile)+1);
+    // remember to leave space for spaces
+	cmd_strlen =3D strlen(path_objdump)+1+strlen(objdump_options)+strlen(opti=
ons->target)+1+strlen(file)+1;
+	cmd =3D malloc(cmd_strlen);
     if (!cmd)
-	malloc_error(procname);
+		malloc_error(procname);
     strcpy(cmd, path_objdump);
     strcat(cmd, " ");
     strcat(cmd, objdump_options);
+	strcat(cmd, options->target);
+	strcat(cmd, " ");
     strcat(cmd, file);
     DEBUG(2, "command '%s'", cmd);
     f =3D popen_local(cmd, procname);

--qDbXVdCdHGoSgWSk--

--gj572EiMnwbLXET9
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Robbat2 @ Orbis-Terrarum Networks

iD8DBQFBmwdnPpIsIjIzwiwRAuB0AJ4w/s4Nsw1aSPy45M/mSFWYMGtidwCgscwr
GbSplf3O8KC3Sk/8Gg8LD0g=
=Yte7
-----END PGP SIGNATURE-----

--gj572EiMnwbLXET9--
