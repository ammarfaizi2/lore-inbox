Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266754AbSK1VuX>; Thu, 28 Nov 2002 16:50:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266763AbSK1VuX>; Thu, 28 Nov 2002 16:50:23 -0500
Received: from mta5.snfc21.pbi.net ([206.13.28.241]:33692 "EHLO
	mta5.snfc21.pbi.net") by vger.kernel.org with ESMTP
	id <S266754AbSK1VuU>; Thu, 28 Nov 2002 16:50:20 -0500
Date: Thu, 28 Nov 2002 14:01:50 -0800
From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH] Module alias and table support
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: "Adam J. Richter" <adam@yggdrasil.com>, greg@kroah.com,
       linux-kernel@vger.kernel.org
Message-id: <3DE6924E.9060609@pacbell.net>
MIME-version: 1.0
Content-type: multipart/mixed; boundary="Boundary_(ID_zYrgqFCZLJC8sMvnv77nIw)"
X-Accept-Language: en-us, en, fr
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020513
References: <20021128041136.35CA02C081@lists.samba.org>
 <3DE5BB48.5090606@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

--Boundary_(ID_zYrgqFCZLJC8sMvnv77nIw)
Content-type: text/plain; charset=us-ascii; format=flowed
Content-transfer-encoding: 7BIT


> Hmm, with 2.5.50 and module-init-tools 0.8a two "modules.*map" files
> are created -- but they're empty.  That's with the latest 2.5 modutils
> 
>   http://www.kernel.org/pub/linux/kernel/people/rusty/modules/
> 
> So that's not quite working yet. ...

OK -- good news!

I now have USB hotplugging behaving again, with three patches on
top of 2.5.50 and modutils 0.8a :

- The <linux/module.h> patch included with your 0.8a announce:
    http://marc.theaimsgroup.com/?l=linux-kernel&m=103845080926386&w=2

- A tweak to that patch to still include <linux/elf.h> (to compile)

- The attached patch to your "modprobe", implementing "-n" and (so
   I can see it works at least partially) using "-v".

Will you merge the modprobe patch?  TIA!

- Dave







--Boundary_(ID_zYrgqFCZLJC8sMvnv77nIw)
Content-type: text/plain; name=modprobe.patch
Content-transfer-encoding: 7BIT
Content-disposition: inline; filename=modprobe.patch

--- modprobe.c-orig	Thu Nov 28 13:18:37 2002
+++ modprobe.c	Thu Nov 28 13:34:55 2002
@@ -53,6 +53,9 @@
 
 #define MODULE_DIR "/lib/modules"
 
+int show_only = 0;
+int verbose = 0;
+
 static void fatal(const char *fmt, ...)
 __attribute__ ((noreturn, format (printf, 1, 2)));
 
@@ -384,7 +387,7 @@
 	for (dep = mod->dependencies; dep != NULL; dep = dep->next)
 		insmod(dep->module, options, NULL, 0, &call_history);
 
-	/* If we fail to load after this piont, we abort the whole program. */
+	/* If we fail to load after this point, we abort the whole program. */
 	mod->state = LOADED;
 
 	/* Now, it may already be loaded: check /proc/modules */
@@ -428,13 +431,18 @@
 	if (newname)
 		rename_module(mod, map, st.st_size, newname);
 
-	ret = syscall(__NR_init_module, map, st.st_size, options);
-	if (ret != 0) {
-		if (dont_fail)
-			fatal("Error inserting %s (%s): %s\n",
-			      modname, mod->filename, moderror(errno));
-		warn("Error inserting %s (%s): %s\n",
-		     modname, mod->filename, moderror(errno));
+	if (verbose)
+		printf ("insmod %s\n", mod->filename);
+
+	if (!show_only) {
+		ret = syscall(__NR_init_module, map, st.st_size, options);
+		if (ret != 0) {
+			if (dont_fail)
+				fatal("Error inserting %s (%s): %s\n",
+				      modname, mod->filename, moderror(errno));
+			warn("Error inserting %s (%s): %s\n",
+			     modname, mod->filename, moderror(errno));
+		}
 	}
 	free(map);
  out_fd:
@@ -505,6 +513,7 @@
 				   { "showconfig", 0, NULL, 'c' },
 				   { "autoclean", 0, NULL, 'k' },
 				   { "quiet", 0, NULL, 'q' },
+				   { "show", 0, NULL, 'n' },
 				   { "syslog", 0, NULL, 's' },
 				   { NULL, 0, NULL, 0 } };
 
@@ -515,7 +524,6 @@
 	struct utsname buf;
 	int opt;
 	int dump_only = 0;
-	int verbose = 0;
 	const char *config = NULL;
 	char *dirname, *optstring = NOFAIL(strdup(""));
 	char *modname, *newname = NULL;
@@ -523,7 +531,7 @@
 
 	try_old_version("modprobe", argv);
 
-	while ((opt = getopt_long(argc, argv, "vVC:o:kqsc", options, NULL)) != -1){
+	while ((opt = getopt_long(argc, argv, "vVC:o:knqsc", options, NULL)) != -1){
 		switch (opt) {
 		case 'v':
 			verbose = 1;
@@ -543,6 +551,9 @@
 		case 'k':
 			/* FIXME: This should actually do something */
 			break;
+		case 'n':
+			show_only = 1;
+			break;
 		case 'q':
 			/* FIXME: This should actually do something */
 			break;
@@ -550,7 +561,7 @@
 			/* FIXME: This should actually do something */
 			break;
 		default:
-			fprintf(stderr, "Unknown option `%s'\n", argv[optind]);
+			fprintf(stderr, "Unknown option `%c'\n", opt);
 			print_usage(argv[0]);
 		}
 	}

--Boundary_(ID_zYrgqFCZLJC8sMvnv77nIw)--
