Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265008AbTGBOBr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jul 2003 10:01:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265009AbTGBOBr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jul 2003 10:01:47 -0400
Received: from mail2.sonytel.be ([195.0.45.172]:48873 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S265008AbTGBOBm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jul 2003 10:01:42 -0400
Date: Wed, 2 Jul 2003 16:15:51 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: david nicol <whatever@davidnicol.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: build from RO source tree?
In-Reply-To: <1057139553.5088.20.camel@plaza.davidnicol.com>
Message-ID: <Pine.GSO.4.21.0307021615150.15047-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2 Jul 2003, david nicol wrote:
> Is there a make option for building from a read-only kernel source,
> possibly by doing a pre-pass to create a mess of symlinks?
> 
> Something like
> 
> 	(chdir $readonly_sourceroot && find . -type d ) \
> 	| xargs -n5 mkdir
> 	(chdir $readonly_sourceroot && find . -type f ) \
> 	| xargs -i ln -s $readonly_sourceroot/{} {}
> 	make
> 
> 
> but as a configure option of some kind.

>From geert@linux-m68k.org Wed Jul  2 15:22:08 2003
Date: Fri, 23 May 2003 15:49:45 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: [PATCH] touchless dependencies for 2.4.x

	Hi,

The 2.4.x dependency system depends on being able to `touch' include files in
case of recursive dependencies.  This fails when using a revision control
system (e.g. ClearCase) where non-checked out files are read-only and cannot be
touch'ed.

The patch below solves this by making object files depend on (recursive) lists,
containing the list of dependencies for each header file.

Example:
  - Dependencies:
      o file.c includes header.h
      o header.h includes header2.h

  - Old way:

      o .depend:

	    file.o:	file.c header.h

      o .hdepend:

	    header.h:	header2.h
			touch header.h

  - New way:

      o .depend:

	    file.o:	file.c header.h $(dep_header.h)

      o .hdepend:

	    dep_header.h += header2.h $(dep_header2.h)

Is this OK? So far I didn't notice any regressions.
    
--- linux-2.4.x/scripts/mkdep.c.orig	Tue Apr  1 17:04:24 2003
+++ linux-2.4.x/scripts/mkdep.c	Wed Apr  2 17:39:59 2003
@@ -45,8 +45,7 @@
 
 
 
-char __depname[512] = "\n\t@touch ";
-#define depname (__depname+9)
+char depname[512];
 int hasdep;
 
 struct path_struct {
@@ -75,9 +74,14 @@
 {
 	if (!hasdep) {
 		hasdep = 1;
-		printf("%s:", depname);
-		if (g_filename)
+		if (g_filename) {
+			/* Source file (*.[cS]) */
+			printf("%s:", depname);
 			printf(" %s", g_filename);
+		} else {
+			/* header file (*.h) */
+			printf("dep_%s +=", depname);
+		}
 	}
 }
 
@@ -203,7 +207,8 @@
 		path->buffer[path->len+len] = '\0';
 		if (access(path->buffer, F_OK) == 0) {
 			do_depname();
-			printf(" \\\n   %s", path->buffer);
+			printf(" \\\n   %s $(dep_%s)", path->buffer,
+			       path->buffer);
 			return;
 		}
 	}
@@ -520,7 +525,7 @@
 /*
  * Generate dependencies for one file.
  */
-void do_depend(const char * filename, const char * command)
+void do_depend(const char * filename)
 {
 	int mapsize;
 	int pagesizem1 = getpagesize()-1;
@@ -559,9 +564,7 @@
 	clear_config();
 	state_machine(map, map+st.st_size);
 	if (hasdep) {
-		puts(command);
-		if (*command)
-			define_precious(filename);
+		puts("");
 	}
 
 	munmap(map, mapsize);
@@ -607,7 +610,6 @@
 
 	while (--argc > 0) {
 		const char * filename = *++argv;
-		const char * command  = __depname;
 		g_filename = 0;
 		len = strlen(filename);
 		memcpy(depname, filename, len+1);
@@ -615,10 +617,9 @@
 			if (filename[len-1] == 'c' || filename[len-1] == 'S') {
 			    depname[len-1] = 'o';
 			    g_filename = filename;
-			    command = "";
 			}
 		}
-		do_depend(filename, command);
+		do_depend(filename);
 	}
 	if (len_precious) {
 		*(str_precious+len_precious) = '\0';

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

