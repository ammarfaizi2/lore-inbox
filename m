Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262221AbTEEQb5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 May 2003 12:31:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263673AbTEEQbh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 May 2003 12:31:37 -0400
Received: from patan.Sun.COM ([192.18.98.43]:36772 "EHLO patan.sun.com")
	by vger.kernel.org with ESMTP id S262221AbTEEQ3y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 May 2003 12:29:54 -0400
Date: Mon, 05 May 2003 09:42:24 -0700
From: Thomas Duffy <Thomas.Duffy.99@alumni.brown.edu>
Subject: Re: Announce: kdb v4.2 is available for kernel 2.4.20, i386 and	ia64
In-reply-to: <11249.1051859696@kao2.melbourne.sgi.com>
To: Keith Owens <kaos@sgi.com>
Cc: kdb@oss.sgi.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-id: <1052152943.4374.39.camel@biznatch>
Organization: 
MIME-version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5)
Content-type: multipart/mixed; boundary="Boundary_(ID_MIB9FgS6QiMUcG0zz6X4Kg)"
References: <11249.1051859696@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary_(ID_MIB9FgS6QiMUcG0zz6X4Kg)
Content-type: text/plain
Content-transfer-encoding: 7BIT

On Fri, 2003-05-02 at 00:14, Keith Owens wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Content-Type: text/plain; charset=us-ascii
> 
> ftp://oss.sgi.com/projects/kdb/download/v4.2/
> 
>   kdb-v4.2-2.4.20-common-1.bz2
>   kdb-v4.2-2.4.20-i386-1.bz2
>   kdb-v4.2-2.4.20-ia64-021210-1.bz2

REPOST

This patch is needed as part of kdb common to get sparc64 kdb to build.

* include/linux/kdb.h references task_struct, needs to include sched.h
* kdb/kdbmain.c #define's WRAP already defined in
     include/asm-sparc64/termbits.h

-- 
Thomas Duffy <Thomas.Duffy.99@alumni.brown.edu>

--Boundary_(ID_MIB9FgS6QiMUcG0zz6X4Kg)
Content-type: text/x-patch; name=kdb-v4.2-2.4.20-sparc-build-fix.patch;
 charset=ISO-8859-1
Content-transfer-encoding: 7BIT
Content-disposition: attachment; filename=kdb-v4.2-2.4.20-sparc-build-fix.patch

diff -Nur -X /home/tduffy/dontdiff linux-2.4.20+kdb-v4.2/include/linux/kdb.h linux-2.4.20+kdb-v4.2+sparc64/include/linux/kdb.h
--- linux-2.4.20+kdb-v4.2/include/linux/kdb.h	2003-05-02 10:29:34.000000000 -0700
+++ linux-2.4.20+kdb-v4.2+sparc64/include/linux/kdb.h	2003-05-02 11:45:27.000000000 -0700
@@ -38,6 +38,7 @@
 
 #include <linux/config.h>
 #include <linux/init.h>
+#include <linux/sched.h>
 #include <asm/kdb.h>
 
 #define KDB_MAJOR_VERSION	4
diff -Nur -X /home/tduffy/dontdiff linux-2.4.20+kdb-v4.2/kdb/kdbmain.c linux-2.4.20+kdb-v4.2+sparc64/kdb/kdbmain.c
--- linux-2.4.20+kdb-v4.2/kdb/kdbmain.c	2003-05-02 10:29:34.000000000 -0700
+++ linux-2.4.20+kdb-v4.2+sparc64/kdb/kdbmain.c	2003-05-02 10:37:15.000000000 -0700
@@ -2570,17 +2570,17 @@
 	logsize = syslog_data[1] - syslog_data[0];
 	start = syslog_data[0] + (syslog_data[2] - syslog_data[0]) % logsize;
 	end = syslog_data[0] + (syslog_data[3] - syslog_data[0]) % logsize;
-#define WRAP(p) if (p < syslog_data[0]) p = syslog_data[1]-1; else if (p >= syslog_data[1]) p = syslog_data[0]
+#define KDB_WRAP(p) if (p < syslog_data[0]) p = syslog_data[1]-1; else if (p >= syslog_data[1]) p = syslog_data[0]
 	if (lines) {
 		char *p = end;
 		++lines;
 		do {
 			--p;
-			WRAP(p);
+			KDB_WRAP(p);
 			if (*p == '\n') {
 				if (--lines == 0) {
 					++p;
-					WRAP(p);
+					KDB_WRAP(p);
 					break;
 				}
 			}
@@ -2595,7 +2595,7 @@
 		if (!*start) {
 			while (!*start) {
 				++start;
-				WRAP(start);
+				KDB_WRAP(start);
 				if (start == end)
 					break;
 			}
@@ -2607,7 +2607,7 @@
 			c = *start;
 			++chars;
 			++start;
-			WRAP(start);
+			KDB_WRAP(start);
 			if (start == end || c == '\n')
 				break;
 		}

--Boundary_(ID_MIB9FgS6QiMUcG0zz6X4Kg)--
