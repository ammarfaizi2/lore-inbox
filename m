Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268012AbTGIAiO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jul 2003 20:38:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268011AbTGIAiN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jul 2003 20:38:13 -0400
Received: from CPE0080c6f1c7c1-CM014160001801.cpe.net.cable.rogers.com ([24.101.63.200]:59338
	"EHLO muon.jukie.net") by vger.kernel.org with ESMTP
	id S268101AbTGIAez (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jul 2003 20:34:55 -0400
Date: Tue, 8 Jul 2003 20:49:28 -0400
From: Bart Trojanowski <bart@jukie.net>
To: linux-kernel@vger.kernel.org
Cc: kernel-janitor-discuss@lists.sourceforge.net, trivial@rustcorp.com.au
Subject: [PATCH 2.4.21] kernel fails to build in deeply nested directories
Message-ID: <20030709004927.GB27426@jukie.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+pHx0qQiF2pBVqBT"
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--+pHx0qQiF2pBVqBT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I ran into this when building the kernel in a directory whose path name
was quite long.  This is probably not a problem for most that build in
/usr/src/linux, but I was able to reproduce it when building a debian
kernel (that adds in about 40 characters on it's own) in my home
directory.

The error comes from bash telling me that ...

	scripts/mkdep -- `find $(FINDHPATH) \( -name SCCS -o -name .svn \) -prune =
-o -follow -name \*.h ! -name modversions.h -print` > .hdepend

=2E.. generates a command line that exceeds bash's limit.

The fix is to allow mkdep to take the list of parameters on stdin and as
arguments.

The patch that follows, only changes the top level Makefile's dep-files
rule.

Regards,
Bart.


diff -ruN linux-2.4.21-org/Makefile linux-2.4.21/Makefile
--- linux-2.4.21-org/Makefile	2003-06-13 10:51:39.000000000 -0400
+++ linux-2.4.21/Makefile	2003-07-08 20:40:43.000000000 -0400
@@ -493,7 +493,7 @@
 ifdef CONFIG_MODVERSIONS
 	$(MAKE) update-modverfile
 endif
-	scripts/mkdep -- `find $(FINDHPATH) \( -name SCCS -o -name .svn \) -prune=
 -o -follow -name \*.h ! -name modversions.h -print` > .hdepend
+	find $(FINDHPATH) \( -name SCCS -o -name .svn \) -prune -o -follow -name =
\*.h ! -name modversions.h -print | scripts/mkdep --stdin > .hdepend
 	scripts/mkdep -- init/*.c > .depend
=20
 ifdef CONFIG_MODVERSIONS
diff -ruN linux-2.4.21-org/scripts/mkdep.c linux-2.4.21/scripts/mkdep.c
--- linux-2.4.21-org/scripts/mkdep.c	2002-08-02 20:39:46.000000000 -0400
+++ linux-2.4.21/scripts/mkdep.c	2003-07-08 20:42:25.000000000 -0400
@@ -43,9 +43,9 @@
 #include <sys/stat.h>
 #include <sys/types.h>
=20
+#define MAX_FILE_NAME_LEN 512
=20
-
-char __depname[512] =3D "\n\t@touch ";
+char __depname[MAX_FILE_NAME_LEN] =3D "\n\t@touch ";
 #define depname (__depname+9)
 int hasdep;
=20
@@ -531,6 +531,7 @@
 	fd =3D open(filename, O_RDONLY);
 	if (fd < 0) {
 		perror(filename);
+		exit(1);
 		return;
 	}
=20
@@ -577,6 +578,7 @@
 {
 	int len;
 	const char *hpath;
+	int use_stdin =3D 0;
=20
 	hpath =3D getenv("HPATH");
 	if (!hpath) {
@@ -598,6 +600,10 @@
 				add_path(*argv);
 			}
 		}
+		else if (strcmp(*argv, "--stdin") =3D=3D 0) {
+			use_stdin =3D 1;
+			break;
+		}
 		else if (strcmp(*argv, "--") =3D=3D 0) {
 			break;
 		}
@@ -605,24 +611,58 @@
=20
 	add_path(hpath);	/* must be last entry, for config files */
=20
-	while (--argc > 0) {
-		const char * filename =3D *++argv;
-		const char * command  =3D __depname;
-		g_filename =3D 0;
-		len =3D strlen(filename);
-		memcpy(depname, filename, len+1);
-		if (len > 2 && filename[len-2] =3D=3D '.') {
-			if (filename[len-1] =3D=3D 'c' || filename[len-1] =3D=3D 'S') {
-			    depname[len-1] =3D 'o';
-			    g_filename =3D filename;
-			    command =3D "";
+	if (use_stdin) {
+		/* process entries passed in by stdin */
+
+		char buff[MAX_FILE_NAME_LEN];
+		char *line;
+
+		while ((line =3D fgets(buff, MAX_FILE_NAME_LEN, stdin))) {
+			char * filename =3D line;
+			const char * command  =3D __depname;
+			g_filename =3D 0;
+			len =3D strlen(filename);
+			while (isspace (filename[len-1])) {
+				len--;
+				filename[len]=3D0;=20
+			}
+			memcpy(depname, filename, len+1);
+			if (len > 2 && filename[len-2] =3D=3D '.') {
+				if (filename[len-1] =3D=3D 'c'=20
+						|| filename[len-1] =3D=3D 'S') {
+				    depname[len-1] =3D 'o';
+				    g_filename =3D filename;
+				    command =3D "";
+				}
 			}
+			do_depend(filename, command);
+		}
+
+	} else {
+		/* process entries passed in by command line arguments */
+
+		while (--argc > 0) {
+			const char * filename =3D *++argv;
+			const char * command  =3D __depname;
+			g_filename =3D 0;
+			len =3D strlen(filename);
+			memcpy(depname, filename, len+1);
+			if (len > 2 && filename[len-2] =3D=3D '.') {
+				if (filename[len-1] =3D=3D 'c'=20
+						|| filename[len-1] =3D=3D 'S') {
+				    depname[len-1] =3D 'o';
+				    g_filename =3D filename;
+				    command =3D "";
+				}
+			}
+			do_depend(filename, command);
 		}
-		do_depend(filename, command);
 	}
+
 	if (len_precious) {
 		*(str_precious+len_precious) =3D '\0';
 		printf(".PRECIOUS:%s\n", str_precious);
 	}
 	return 0;
 }
+

--+pHx0qQiF2pBVqBT
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE/C2aW/zRZ1SKJaI8RAkgyAKCFS8t07pGMOsUgcMaqDV4n1EtD5ACdEQBr
NAuMh5ciZGKX8bJpJr+El80=
=CvuR
-----END PGP SIGNATURE-----

--+pHx0qQiF2pBVqBT--
