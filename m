Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265205AbSKSAGz>; Mon, 18 Nov 2002 19:06:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265222AbSKSAGy>; Mon, 18 Nov 2002 19:06:54 -0500
Received: from h-64-105-34-70.SNVACAID.covad.net ([64.105.34.70]:41367 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S265205AbSKSAGv>; Mon, 18 Nov 2002 19:06:51 -0500
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Mon, 18 Nov 2002 16:13:46 -0800
Message-Id: <200211190013.QAA00519@baldur.yggdrasil.com>
To: rusty@rustcorp.com.au
Subject: Re: Patch: module-init-tools-0.6/modprobe.c - support subdirectories
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Here is an updated version of my patch to
module-init-tools-0.6/modprobe.c to allow it to recursively search
subdirectories so that we can have module directory tree again.
This version I have actually run and it seems to work.

	Unfortunately, about one out of four modules that I load
will get an error from the module loading system call (memory
allocation failure).  I don't think that that is due to my
modprobe.c changes, but it could be.
	This version of the patch adds 39 lines, alas, but I think the
ability to have a module directory hierarchy if you want to is worth it
(e.g., it is a lot easier to select a class of drivers for inclusion in
a boot image).

Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."

--- module-init-tools-0.6/modprobe.c	2002-10-30 20:03:06.000000000 -0800
+++ module-init-tools-0.6.ajr/modprobe.c	2002-11-18 12:23:08.000000000 -0800
@@ -36,7 +36,7 @@
 
 #include "backwards_compat.c"
 
-#define MODULE_DIR "/lib/modules/%s/kernel/"
+#define MODULE_DIR "/lib/modules"
 #define MODULE_EXTENSION ".o"
 
 #define MODULE_NAME_LEN (64 - ELF_TYPE / 8)
@@ -114,7 +114,7 @@
 
 static int ends_in(const char *name, const char *ext)
 {
-	unsigned int namelen, extlen, i;
+	unsigned int namelen, extlen;
 
 	/* Grab lengths */
 	namelen = strlen(name);
@@ -122,11 +122,8 @@
 
 	if (namelen < extlen) return 0;
 
-	/* Look backwards */
-	for (i = 0; i < extlen; i++)
-		if (name[namelen - i] != ext[extlen - i]) return 0;
-
-	return 1;
+	name += namelen - extlen;
+	return (strcmp(name, ext) == 0);
 }
 
 static void *load_section(int fd, unsigned long shdroff,
@@ -201,8 +198,8 @@
 	Elf_Ehdr hdr;
 	int fd;
 
-	new = malloc(sizeof(*new) + strlen(dirname) + strlen(entry) + 1);
-	sprintf(new->name, "%s%s", dirname, entry);
+	new = malloc(sizeof(*new) + strlen(dirname) + strlen(entry) + 2);
+	sprintf(new->name, "%s/%s", dirname, entry);
 	new->next = last;
 	new->order = 0;
 	fd = open(new->name, O_RDONLY);
@@ -227,14 +224,46 @@
 	return new;
 }
 
-static struct module *load_all_exports(const char *revision)
+static char *find_mod(const char *parent, const char *child,
+		      const char *target)
+{
+	struct dirent *dirent;
+	DIR *dir;
+	char path[strlen(parent) + strlen(child) + 2];
+	struct stat statbuf;
+	char *result = NULL;
+
+	sprintf(path, "%s/%s", parent, child);
+
+	if (strcmp(child, target) == 0 &&
+	    stat(path, &statbuf) == 0 &&
+	    S_ISREG(statbuf.st_mode))
+		return strdup(path);
+
+	dir = opendir(path);
+	if (dir) {
+		while ((dirent = readdir(dir)) != NULL) {
+			if (!strcmp(dirent->d_name, "..") ||
+			    !strcmp(dirent->d_name, "."))
+				continue;
+		  
+			result = find_mod(path, dirent->d_name, target);
+			if (result)
+				break;
+		}
+		closedir(dir);
+	}
+	return result;
+}
+
+static struct module *load_all_exports(const char *parent, const char *subdir,
+				       struct module *mods)
 {
-	struct module *mods = NULL;
 	struct dirent *dirent;
 	DIR *dir;
-	char dirname[strlen(revision) + sizeof(MODULE_DIR)];
+	char dirname[strlen(parent) + strlen(subdir) + 2];
 
-	sprintf(dirname, MODULE_DIR, revision);
+	sprintf(dirname, "%s/%s", parent, subdir);
 	dir = opendir(dirname);
 	if (dir) {
 		while ((dirent = readdir(dir)) != NULL) {
@@ -242,6 +271,10 @@
 			if (ends_in(dirent->d_name, MODULE_EXTENSION))
 				mods = add_module(dirname, dirent->d_name,
 						  mods);
+			else if (strcmp(dirent->d_name, "..") &&
+				 strcmp(dirent->d_name, "."))
+				mods = load_all_exports(dirname,
+							dirent->d_name, mods);
 		}
 		closedir(dir);
 	}
@@ -273,6 +306,7 @@
 				found = m;
 				/* If we didn't need to load it
                                    already, we do now. */
+
 				found->order = order;
 			}
 		}
@@ -425,6 +459,7 @@
 
 	ret = syscall(__NR_init_module, map, len, "");
 	if (ret != 0) {
+		fprintf (stderr, "AJR init_module(map %p, len %d) failed, ret = %d.\n", map, len, ret);
 		if (dont_fail)
 			fatal("Error inserting %s: %s\n",name,moderror(errno));
 		else
@@ -439,13 +474,16 @@
 	unsigned int order;
 	struct module *modules;
 	struct module *i;
-	char pathname[strlen(revision) + sizeof(MODULE_DIR) + strlen(modname)
-		     + sizeof(MODULE_EXTENSION)];
+	char *pathname;
+	char modname_ext[strlen(modname) + sizeof(MODULE_EXTENSION)];
 
-	/* Create path name */
-	sprintf(pathname, MODULE_DIR "%s" MODULE_EXTENSION, revision, modname);
+	sprintf (modname_ext, "%s%s", modname, MODULE_EXTENSION);
+	pathname = find_mod(MODULE_DIR, revision, modname_ext);
+	if (!pathname)
+		fatal("No module %s in %s/%s or subdirectories.\n",
+		      modname_ext, MODULE_DIR, revision);
 
-	modules = load_all_exports(revision);
+	modules = load_all_exports(MODULE_DIR, revision, NULL);
 	order = 1;
 	if (get_deps(order, pathname, modules, verbose)) {
 		/* We need some other modules. */
@@ -475,6 +513,7 @@
 	}
 	if (verbose) printf("Loading %s\n", pathname);
 	insmod(pathname, 1);
+	free(pathname);
 }
 
 static struct option options[] = { { "verbose", 0, NULL, 'v' },
