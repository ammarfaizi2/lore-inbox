Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261644AbSLLJlY>; Thu, 12 Dec 2002 04:41:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267447AbSLLJlY>; Thu, 12 Dec 2002 04:41:24 -0500
Received: from dp.samba.org ([66.70.73.150]:18924 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S261644AbSLLJlV>;
	Thu, 12 Dec 2002 04:41:21 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Jeff Chua <jchua@fedex.com>
Cc: "Adam J. Richter" <adam@yggdrasil.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.51 ide module problem (fwd) 
In-reply-to: Your message of "Thu, 12 Dec 2002 14:22:02 +0800."
             <Pine.LNX.4.50.0212121419410.15261-100000@boston.corp.fedex.com> 
Date: Thu, 12 Dec 2002 20:48:01 +1100
Message-Id: <20021212094909.67D3D2C0F7@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <Pine.LNX.4.50.0212121419410.15261-100000@boston.corp.fedex.com> you
 write:
> 
> Rusty,
> 
> Any chance that module-init-tools-0.9.3 can be modified to stop looping
> when it detected it has repeated scanning the same module again?
> 
> I'm still having problem loading ide as a module under 2.5.51

And you will continue to.  There really is a loop, which means neither
module can be loaded (ide_dump_status is in ide.ko, and ide-io.ko wants
it, however ide.ko uses lots of things in ide-io.ko).  However, this
patch will stop depmod from crashing.

Ask the IDE people,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

Only in module-init-tools-current/: .deps
diff -ur module-init-tools-0.9.3/ChangeLog module-init-tools-current/ChangeLog
--- module-init-tools-0.9.3/ChangeLog	2002-12-10 17:42:36.000000000 +1100
+++ module-init-tools-current/ChangeLog	2002-12-12 20:43:40.000000000 +1100
@@ -1,3 +1,6 @@
+0.9.4 Version
+o Implement primitive loop detection.
+
 0.9.3 Version
 o Fix modprobe -r ordering (tried to remove backwards) (Jim Radford's report)
 o David Brownell's extra rmmod options (modified)
diff -ur module-init-tools-0.9.3/depmod.c module-init-tools-current/depmod.c
--- module-init-tools-0.9.3/depmod.c	2002-12-09 11:14:37.000000000 +1100
+++ module-init-tools-current/depmod.c	2002-12-12 20:37:30.000000000 +1100
@@ -291,30 +291,70 @@
 	return next;
 }
 
-static void write_dep(struct module *mod, unsigned int skipchars, FILE *out)
+static char *basename(char *name)
+{
+	char *base = strrchr(name, '/');
+	if (base) return base + 1;
+	return name;
+}
+
+static void report_loop(struct module *start)
+{
+	struct module *i;
+	warn("Loop detected: %s ", start->pathname);
+
+	for (i = start->next_dep; i != start; i = i->next_dep)
+		fprintf(stderr, "needs %s ", basename(i->pathname));
+	fprintf(stderr, "which needs %s again!\n", basename(start->pathname));
+}
+
+/* Only want to report head loops, since we usually are doing all
+   modules anyway. */
+static void write_dep(struct module *start,
+		      struct module *mod, unsigned int skipchars, FILE *out)
 {
 	unsigned int i;
 
+	/* Already done this one? */
+	if (mod->next_dep) {
+		if (mod == start)
+			report_loop(start);
+		return;
+	}
+
 	for (i = 0; i < mod->num_deps; i++) {
 		fprintf(out, " %s", mod->deps[i]->pathname + skipchars);
-		write_dep(mod->deps[i], skipchars, out);
+		mod->next_dep = mod->deps[i];
+		write_dep(start, mod->deps[i], skipchars, out);
 	}
 }
 
-/* FIXME: Don't write same dep twice: order and loop detect. --RR */
+/* Unset the duplicate detection pointers. */
+/* FIXME: Order n^2 is bad.  tsort them and do something sensible when
+   loops detected. --RR */
+static void clear_deps(struct module *modules)
+{
+	struct module *i;
+
+	for (i = modules; i; i = i->next)
+		i->next_dep = NULL;
+}
+
 static void output_deps(struct module *modules,
 			unsigned int skipchars,
-			FILE *out)
+			FILE *out,
+			int verbose)
 {
 	struct module *i;
 
 	for (i = modules; i; i = i->next)
-		i->ops->calculate_deps(i);
+		i->ops->calculate_deps(i, verbose);
 
 	/* Now dump them out. */
 	for (i = modules; i; i = i->next) {
 		fprintf(out, "%s:", i->pathname + skipchars);
-		write_dep(i, skipchars, out);
+		clear_deps(modules);
+		write_dep(i, i, skipchars, out);
 		fprintf(out, "\n");
 	}
 }
@@ -361,7 +401,7 @@
 
 int main(int argc, char *argv[])
 {
-	int opt, all = 0;
+	int opt, all = 0, verbose = 0;
 	unsigned int skipchars = 0;
 	FILE *depout = NULL, *pciout, *usbout, *ccwout;
 	char *basedir = "/lib/modules", *dirname, *version;
@@ -384,8 +424,10 @@
 		case 'e':
 			/* FIXME: Implement these together */
 			break;
-		case 'u':
 		case 'v':
+			verbose = 1;
+			break;
+		case 'u':
 		case 'q':
 			/* Ignored. */
 			break;
@@ -467,7 +509,7 @@
 		list = grab_dir(dirname, list);
 	}
 
-	output_deps(list, skipchars, depout);
+	output_deps(list, skipchars, depout, verbose);
 	output_pci_table(list, pciout);
 	output_usb_table(list, usbout);
 	output_ccw_table(list, ccwout);
diff -ur module-init-tools-0.9.3/depmod.h module-init-tools-current/depmod.h
--- module-init-tools-0.9.3/depmod.h	2002-12-09 11:14:37.000000000 +1100
+++ module-init-tools-current/depmod.h	2002-12-12 20:13:13.000000000 +1100
@@ -27,6 +27,9 @@
 	unsigned int num_deps;
 	struct module **deps;
 
+	/* Set if we're doing a dependency now (duplicate detection) */
+	struct module *next_dep;
+
 	/* Tables extracted from module by ops->fetch_tables(). */
 	/* FIXME: Do other tables too --RR */
 	unsigned int pci_size;
diff -ur module-init-tools-0.9.3/moduleops.c module-init-tools-current/moduleops.c
--- module-init-tools-0.9.3/moduleops.c	2002-12-09 11:14:37.000000000 +1100
+++ module-init-tools-current/moduleops.c	2002-12-12 19:55:47.000000000 +1100
@@ -44,7 +44,7 @@
 }
 
 /* Calculate the dependencies for this module */
-static void calculate_deps32(struct module *module)
+static void calculate_deps32(struct module *module, int verbose)
 {
 	unsigned int i;
 	unsigned long size;
@@ -72,9 +72,13 @@
 				continue;
 
 			owner = find_symbol(name);
-			if (owner)
+			if (owner) {
+				if (verbose)
+					printf("%s needs \"%s\": %s\n",
+					       module->pathname, name,
+					       owner->pathname);
 				add_dep(module, owner);
-			else
+			} else
 				unknown_symbol(module, name);
 		}
 	}
@@ -164,7 +168,7 @@
 }
 
 /* Calculate the dependencies for this module */
-static void calculate_deps64(struct module *module)
+static void calculate_deps64(struct module *module, int verbose)
 {
 	unsigned int i;
 	unsigned long size;
diff -ur module-init-tools-0.9.3/moduleops.h module-init-tools-current/moduleops.h
--- module-init-tools-0.9.3/moduleops.h	2002-11-27 20:45:07.000000000 +1100
+++ module-init-tools-current/moduleops.h	2002-12-12 19:52:33.000000000 +1100
@@ -17,7 +17,7 @@
 struct module_ops
 {
 	void (*load_symbols)(struct module *module);
-	void (*calculate_deps)(struct module *module);
+	void (*calculate_deps)(struct module *module, int verbose);
 	void (*fetch_tables)(struct module *module);
 };
 
