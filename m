Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261544AbSKRP0A>; Mon, 18 Nov 2002 10:26:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261613AbSKRP0A>; Mon, 18 Nov 2002 10:26:00 -0500
Received: from h-64-105-34-70.SNVACAID.covad.net ([64.105.34.70]:60102 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S261544AbSKRPZ6>; Mon, 18 Nov 2002 10:25:58 -0500
Date: Mon, 18 Nov 2002 07:32:47 -0800
From: "Adam J. Richter" <adam@yggdrasil.com>
To: rusty@rustcorp.com.au
Cc: linux-kernel@vger.kernel.org
Subject: Patch: module-init-tools-0.6/modprobe.c - support subdirectories
Message-ID: <20021118073247.A10109@adam.yggdrasil.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="y0ulUmNC+osPPQO6"
Content-Disposition: inline
User-Agent: Mutt/1.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--y0ulUmNC+osPPQO6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

	The following untested patch adds subdirectory support to
module-init-tools-0.6/modprobe.c.  I really need this for tools that I
use for building initial ramdisks to do things like select all SCSI
and IDE drivers without having to release a new version of the ramdisk
maker every time a new SCSI or IDE driver is added.  The patch is a net
addition of four lines to modprobe.c.

	I am sorry I was not able to test this change, but it would be
a lot of work for me to bring up a system without module device ID
table support.  I know your ChangeLog says that support is coming.  I
wonder if it would break your module utilities to leave the old macros
device ID macros in place and let people run the existing depmod.

	I also worry about about the latency of reading the
kernel symbols for all modules every time modprobe is called.  If I
want to have all of the modules installed, that's at least 1143
modules on x86, and this might be the standard installation of a Linux
distribution.  Here again, the existing depmod program could be used.
What would be needed would be some code to make modprobe try
modules.dep first if it exists.

	Finally, I am skeptical of the benefits being worth the cost
of putting an ELF relocator and symbol table parser in the kernel.  We
don't need to do that just have try_mod_inc_use_count or to lock
modules during a load that a new module depends on.  I'd much
apportioning this complexity to user space, where it does not consume
unswappable memory, where it is easier to make changes, where there is
slightly more protection against bugs.  The user space code already
has to do a little ELF parsing to figure out the dependecies.  I would
be interested in knowing what new thing I can do with my computer, or
what performance gain or other real benefit all of this additional
kernel code will buy.

-- 
Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."

--y0ulUmNC+osPPQO6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="modprobe.diff"

--- module-init-tools-0.6/modprobe.c	2002-10-30 20:03:06.000000000 -0800
+++ module-init-tools-0.6.ajr/modprobe.c	2002-11-18 07:20:59.000000000 -0800
@@ -36,7 +36,7 @@
 
 #include "backwards_compat.c"
 
-#define MODULE_DIR "/lib/modules/%s/kernel/"
+#define MODULE_DIR "/lib/modules"
 #define MODULE_EXTENSION ".o"
 
 #define MODULE_NAME_LEN (64 - ELF_TYPE / 8)
@@ -227,14 +227,14 @@
 	return new;
 }
 
-static struct module *load_all_exports(const char *revision)
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
@@ -242,6 +242,9 @@
 			if (ends_in(dirent->d_name, MODULE_EXTENSION))
 				mods = add_module(dirname, dirent->d_name,
 						  mods);
+			else
+				mods = load_all_exports(dirname,
+							dirent->d_name, mods);
 		}
 		closedir(dir);
 	}
@@ -440,12 +443,13 @@
 	struct module *modules;
 	struct module *i;
 	char pathname[strlen(revision) + sizeof(MODULE_DIR) + strlen(modname)
-		     + sizeof(MODULE_EXTENSION)];
+		     + sizeof(MODULE_EXTENSION) + 1];
 
 	/* Create path name */
-	sprintf(pathname, MODULE_DIR "%s" MODULE_EXTENSION, revision, modname);
+	sprintf(pathname, "%s/%s/%s%s", MODULE_DIR,
+		revision, modname, MODULE_EXTENSION);
 
-	modules = load_all_exports(revision);
+	modules = load_all_exports(MODULE_DIR, revision, NULL);
 	order = 1;
 	if (get_deps(order, pathname, modules, verbose)) {
 		/* We need some other modules. */

--y0ulUmNC+osPPQO6--
