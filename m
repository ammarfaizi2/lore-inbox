Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130038AbRCDFZJ>; Sun, 4 Mar 2001 00:25:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130043AbRCDFY6>; Sun, 4 Mar 2001 00:24:58 -0500
Received: from horus.its.uow.edu.au ([130.130.68.25]:42994 "EHLO
	horus.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S130038AbRCDFYm>; Sun, 4 Mar 2001 00:24:42 -0500
Message-ID: <3AA1D1A9.3A35557A@uow.edu.au>
Date: Sun, 04 Mar 2001 16:24:57 +1100
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.4.2-pre2 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Keith Owens <kaos@ocs.com.au>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: 2.4.2-pre1 mkdep and symlinked $TOPDIR
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keith,

I do builds in /usr/src/linux, which is a symlink
to /usr/src/linux-akpm.  The recent `mkdep' changes
have broken this practice most horridly.  When searching
.hdepend, `make' doesn't recognise that nested headers
have changed. This is because .hdepend has things like

/usr/src/linux/include/asm/byteorder.h: \
   /usr/src/linux-akpm/include/asm/types.h \

So when it looks for dependencies for
	/usr/src/linux-akpm/include/asm/byteorder.h

it doesn't find anything.  In earlier kernels, the
whole toolchain honoured the symlink form of the name.

The net effect of all this is that changes to included
headers are *not* causing recompiles, and use of a
symlinked $TOPDIR is not feasible.

The workaround at this time is to do a `cd' to the
real $TOPDIR directory before starting development, 
rather than a `cd' to the symlink.

If it is your intention that everything in the
build system use the "real" pathname then I suggest
we need to make it happen consistently.  Or can we
restore the old behaviour?



--- linux-2.4.3-pre1/scripts/mkdep.c	Sat Mar  3 20:52:24 2001
+++ linux-akpm/scripts/mkdep.c	Sun Mar  4 16:16:00 2001
@@ -218,19 +218,12 @@
 void add_path(const char * name)
 {
 	struct path_struct *path;
-	char resolved_path[PATH_MAX+1];
 	const char *name2;
 
-	if (strcmp(name, ".")) {
-		name2 = realpath(name, resolved_path);
-		if (!name2) {
-			fprintf(stderr, "realpath(%s) failed, %m\n", name);
-			exit(1);
-		}
-	}
-	else {
+	if (strcmp(name, "."))
+		name2 = name;
+	else
 		name2 = "";
-	}
 
 	path_array = realloc(path_array, (++paths)*sizeof(*path_array));
 	if (!path_array) {
