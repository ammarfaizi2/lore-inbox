Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316614AbSFGEWR>; Fri, 7 Jun 2002 00:22:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316634AbSFGEWQ>; Fri, 7 Jun 2002 00:22:16 -0400
Received: from zok.SGI.COM ([204.94.215.101]:32201 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id <S316614AbSFGEWP>;
	Fri, 7 Jun 2002 00:22:15 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: "Kevin P. Fleming" <kpfleming@cox.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kbuild-2.5 on 2.4.19-pre10-ac2 build error when modular support turned off 
In-Reply-To: Your message of "Thu, 06 Jun 2002 18:48:53 MST."
             <000d01c20dc5$7a5b08e0$66aca8c0@kpfhome> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 07 Jun 2002 14:22:07 +1000
Message-ID: <11636.1023423727@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Jun 2002 18:48:53 -0700, 
"Kevin P. Fleming" <kpfleming@cox.net> wrote:
>I had a kernel built and working fine with module support turned on, only a
>single driver (ide-floppy) compiled as a module. I then did "make -f
>Makefile-2.5 menuconfig" and turned off loadable module support, kmod and
>double-checked that ide-floppy changed to built-in (it did).
>
>I then did "make -f Makefile-2.5 -j2 installable", and kbuild rebuilt very
>little, and the final link died with failed references to "request_module".
>It appears that kbuild did not rebuild the entire kernel, even though would
>have been necessary.

Missing case for common source/object.  Since the bug will have
resulted in an incomplete database, bump the version number to ensure
that any existing kbuild database is deleted and rebuilt correctly.
This fix will be in core-18.

diff -ur 2.5.20-kbuild-2.5/scripts/pp_db.h 2.5.20-kbuild-2.5.new/scripts/pp_db.h
--- 2.5.20-kbuild-2.5/scripts/pp_db.h	Fri Jun  7 14:17:45 2002
+++ 2.5.20-kbuild-2.5.new/scripts/pp_db.h	Fri Jun  7 14:11:58 2002
@@ -19,7 +19,7 @@
  * for migrating a kbuild database from one version to another, rebuild the
  * database from scratch.
  */
-#define DB_VERSION	8
+#define DB_VERSION	9
 
 typedef struct ppdb				PPDB;
 typedef struct db_token				DB_TOKEN;
diff -ur 2.5.20-kbuild-2.5/scripts/pp_makefile5.c 2.5.20-kbuild-2.5.new/scripts/pp_makefile5.c
--- 2.5.20-kbuild-2.5/scripts/pp_makefile5.c	Fri Jun  7 14:17:45 2002
+++ 2.5.20-kbuild-2.5.new/scripts/pp_makefile5.c	Fri Jun  7 14:10:56 2002
@@ -991,6 +991,8 @@
 		} else if (common_src_obj && *index == objtree_treename_index) {
 			s = read_db_source(db, token);
 			*index = s->index;
+		} else if (common_src_obj && *index == -1) {
+			*index = 0;
 		}
 	}
 

