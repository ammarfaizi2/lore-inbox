Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129051AbRBNDmE>; Tue, 13 Feb 2001 22:42:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129322AbRBNDly>; Tue, 13 Feb 2001 22:41:54 -0500
Received: from ppp0.ocs.com.au ([203.34.97.3]:14087 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S129051AbRBNDln>;
	Tue, 13 Feb 2001 22:41:43 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.4.1ac12 mkdep -I support - take 2
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 14 Feb 2001 14:41:38 +1100
Message-ID: <12665.982122098@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Get rid of the special case in drivers/acpi/Makefile.  mkdep now uses
the same -I options in the same order as the compiler.  Against 2.4.1ac12.

Change from take 1 - make is too dumb to realise that /path/name/file.h
is the same as file.h when current directory is /path/name, so do not
use the full pathname to files in the current directory.

--- 2.4.1-ac12/scripts/mkdep.c.orig	Wed Feb 14 14:21:54 2001
+++ 2.4.1-ac12/scripts/mkdep.c	Sun Feb 11 15:06:46 2001
@@ -221,15 +221,10 @@
 	char resolved_path[PATH_MAX+1];
 	const char *name2;
 
-	if (strcmp(name, ".")) {
-		name2 = realpath(name, resolved_path);
-		if (!name2) {
-			fprintf(stderr, "realpath(%s) failed, %m\n", name);
-			exit(1);
-		}
-	}
-	else {
-		name2 = "";
+	name2 = realpath(name, resolved_path);
+	if (!name2) {
+		fprintf(stderr, "realpath(%s) failed, %m\n", name);
+		exit(1);
 	}
 
 	path_array = realloc(path_array, (++paths)*sizeof(*path_array));
@@ -246,7 +241,7 @@
 		exit(1);
 	}
 	strcpy(path->buffer, name2);
-	if (path->len && *(path->buffer+path->len-1) != '/') {
+	if (*(path->buffer+path->len-1) != '/') {
 		*(path->buffer+path->len) = '/';
 		*(path->buffer+(++(path->len))) = '\0';
 	}

