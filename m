Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293589AbSCPAR3>; Fri, 15 Mar 2002 19:17:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293591AbSCPARW>; Fri, 15 Mar 2002 19:17:22 -0500
Received: from air-2.osdl.org ([65.201.151.6]:61455 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S293589AbSCPARP>;
	Fri, 15 Mar 2002 19:17:15 -0500
Date: Fri, 15 Mar 2002 16:16:54 -0800 (PST)
From: "Randy.Dunlap" <rddunlap@osdl.org>
X-X-Sender: <rddunlap@dragon.pdx.osdl.net>
To: <linux-kernel@vger.kernel.org>
Subject: CONFIG_sv_kconfig_in_kimage
Message-ID: <Pine.LNX.4.33L2.0203151606550.14689-200000@dragon.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="346823425-111816671-1016237814=:14689"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--346823425-111816671-1016237814=:14689
Content-Type: TEXT/PLAIN; charset=US-ASCII


Hi-

Here's my latest version of
CONFIG_save_kernel_config_in_kernel_image
(a.k.a. CONFIG_IKCONFIG).
This patch is for Linux 2.5.7-pre1.

There is a script to extract the config ("extract-ikconfig").
extract-ikconfig uses a program called binoffset which
is not part of the patch, but is attached.

Comments, suggestions, feedback?

Thanks,
-- 
~Randy
==================================================


--- linux/kernel/Makefile.ikc	Sun Sep 16 21:22:40 2001
+++ linux/kernel/Makefile	Thu Feb 28 15:08:20 2002
@@ -20,6 +20,7 @@
 obj-$(CONFIG_UID16) += uid16.o
 obj-$(CONFIG_MODULES) += ksyms.o
 obj-$(CONFIG_PM) += pm.o
+obj-$(CONFIG_IKCONFIG) += configs.o

 ifneq ($(CONFIG_IA64),y)
 # According to Alan Modra <alan@linuxcare.com.au>, the -fno-omit-frame-pointer is
@@ -31,3 +32,14 @@
 endif

 include $(TOPDIR)/Rules.make
+
+configs.o: $(TOPDIR)/scripts/mkconfigs configs.c
+	echo obj-y == $(obj-y)
+	$(CC) $(CFLAGS) $(CFLAGS_KERNEL) -DEXPORT_SYMTAB -c -o configs.o configs.c
+
+$(TOPDIR)/scripts/mkconfigs: $(TOPDIR)/scripts/mkconfigs.c
+	$(HOSTCC) $(HOSTCFLAGS) -o $(TOPDIR)/scripts/mkconfigs $(TOPDIR)/scripts/mkconfigs.c
+
+configs.c: $(TOPDIR)/.config $(TOPDIR)/scripts/mkconfigs
+	$(TOPDIR)/scripts/mkconfigs $(TOPDIR)/.config configs.c
+
--- linux/arch/i386/defconfig.ikc	Mon Feb 25 11:37:52 2002
+++ linux/arch/i386/defconfig	Thu Feb 28 13:30:39 2002
@@ -112,6 +112,7 @@
 CONFIG_BINFMT_AOUT=y
 CONFIG_BINFMT_ELF=y
 CONFIG_BINFMT_MISC=y
+CONFIG_IKCONFIG=n
 CONFIG_PM=y
 # CONFIG_APM is not set

--- linux/arch/i386/config.in.ikc	Mon Feb 25 11:37:52 2002
+++ linux/arch/i386/config.in	Wed Feb 27 13:25:50 2002
@@ -259,6 +259,8 @@
 tristate 'Kernel support for ELF binaries' CONFIG_BINFMT_ELF
 tristate 'Kernel support for MISC binaries' CONFIG_BINFMT_MISC

+bool 'Kernel .config support' CONFIG_IKCONFIG
+
 bool 'Power Management support' CONFIG_PM

 if [ "$CONFIG_EXPERIMENTAL" = "y" ]; then
--- linux/scripts/mkconfigs.c.ikc	Wed Feb 27 13:13:30 2002
+++ linux/scripts/mkconfigs.c	Fri Mar  1 09:27:54 2002
@@ -0,0 +1,181 @@
+/***************************************************************************
+ * mkconfigs.c
+ * (C) 2002 Randy Dunlap <rddunlap@osdl.org>
+
+#   This program is free software; you can redistribute it and/or modify
+#   it under the terms of the GNU General Public License as published by
+#   the Free Software Foundation; either version 2 of the License, or
+#   (at your option) any later version.
+#
+#   This program is distributed in the hope that it will be useful,
+#   but WITHOUT ANY WARRANTY; without even the implied warranty of
+#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+#   GNU General Public License for more details.
+#
+#   You should have received a copy of the GNU General Public License
+#   along with this program; if not, write to the Free Software
+#   Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+
+# Rules for scripts/mkconfigs.c input.config output.c
+# to generate configs.c from linux/.config:
+# - drop lines that begin with '#'
+# - drop blank lines
+# - lines that use double-quotes must \\-escape-quote them
+
+################## skeleton configs.c file: ####################
+
+#include <linux/init.h>
+#include <linux/module.h>
+
+static char *configs[] __initdata =
+
+  <insert lines selected lines of .config, quoted, with added '\n'>,
+
+;
+
+################### end configs.c file ######################
+
+ * Changelog for ver. 0.2, 2002-02-15, rddunlap@osdl.org:
+ - strip leading "CONFIG_" from config option strings;
+ - use "static" and "__attribute__((unused))";
+ - don't use EXPORT_SYMBOL();
+ - separate each config line with \newline instead of space;
+
+ * Changelog for ver. 0.3, 2002-02-18, rddunlap@osdl.org:
+ - keep all "not set" comment lines from .config so that 'make *config'
+   will be happy, but don't keep other comments;
+ - keep leading "CONFIG_" on each line;
+
+****************************************************************/
+
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <errno.h>
+
+#define VERSION		"0.2"
+#define LINE_SIZE	1000
+
+int include_all_lines = 1;	// whether to include "=n" lines in the output
+
+void usage (const char *progname)
+{
+	fprintf (stderr, "%s ver. %s\n", progname, VERSION);
+	fprintf (stderr, "usage:  %s input.config.name path/configs.c\n",
+			progname);
+	exit (1);
+}
+
+void make_intro (FILE *sourcefile)
+{
+	fprintf (sourcefile, "#include <linux/init.h>\n");
+	fprintf (sourcefile, "#include <linux/module.h>\n");
+	fprintf (sourcefile, "\n");
+/////	fprintf (sourcefile, "char *configs[] __initdata = {\n");
+	fprintf (sourcefile, "static char __attribute__ ((unused)) *configs[] __initdata = {\n");
+	fprintf (sourcefile, "  \"CONFIG_BEGIN=n\\n\" ,\n");
+}
+
+void make_ending (FILE *sourcefile)
+{
+	fprintf (sourcefile, "  \"CONFIG_END=n\\n\"\n");
+	fprintf (sourcefile, "};\n");
+/////	fprintf (sourcefile, "EXPORT_SYMBOL (configs);\n");
+}
+
+void make_lines (FILE *configfile, FILE *sourcefile)
+{
+	char cfgline[LINE_SIZE];
+	char *ch;
+
+	while (fgets (cfgline, LINE_SIZE, configfile)) {
+		/* kill the trailing newline in cfgline */
+		cfgline[strlen (cfgline) - 1] = '\0';
+
+		/* don't keep #-only line or an empty/blank line */
+		if ((cfgline[0] == '#' && cfgline[1] == '\0') ||
+		    cfgline[0] == '\0')
+			continue;
+
+		if (!include_all_lines &&
+		    cfgline[0] == '#') // strip out all comment lines
+			continue;
+
+		/* really only want to keep lines that begin with
+		 * "CONFIG_" or "# CONFIG_" */
+		if (strncmp (cfgline, "CONFIG_", 7) &&
+		    strncmp (cfgline, "# CONFIG_", 9))
+		    	continue;
+
+		/*
+		 * use strchr() to check for "-quote in cfgline;
+		 * if not found, output the line, quoted;
+		 * if found, output a char at a time, with \\-quote
+		 * preceding double-quote chars
+		 */
+		if (!strchr (cfgline, '"')) {
+			fprintf (sourcefile, "  \"%s\\n\" ,\n", cfgline);
+			continue;
+		}
+
+		/* go to char-at-a-time mode for this config and
+		 * precede any double-quote with a backslash */
+		fprintf (sourcefile, "  \"");	/* lead-in */
+		for (ch = cfgline; *ch; ch++) {
+			if (*ch == '"')
+				fputc ('\\', sourcefile);
+			fputc (*ch, sourcefile);
+		}
+		fprintf (sourcefile, "\\n\" ,\n");
+	}
+}
+
+int make_configs (FILE *configfile, FILE *sourcefile)
+{
+	make_intro (sourcefile);
+	make_lines (configfile, sourcefile);
+	make_ending (sourcefile);
+}
+
+int main (int argc, char *argv[])
+{
+	char *progname = argv[0];
+	char *configname, *sourcename;
+	FILE *configfile, *sourcefile;
+
+	if (argc != 3)
+		usage (progname);
+
+	configname = argv[1];
+	sourcename = argv[2];
+
+	configfile = fopen (configname, "r");
+	if (!configfile) {
+		fprintf (stderr, "%s: cannot open '%s'\n",
+				progname, configname);
+		exit (2);
+	}
+	sourcefile = fopen (sourcename, "w");
+	if (!sourcefile) {
+		fprintf (stderr, "%s: cannot open '%s'\n",
+				progname, sourcename);
+		exit (2);
+	}
+
+	make_configs (configfile, sourcefile);
+
+	if (fclose (sourcefile)) {
+		fprintf (stderr, "%s: error %d closing '%s'\n",
+				progname, errno, sourcename);
+		exit (3);
+	}
+	if (fclose (configfile)) {
+		fprintf (stderr, "%s: error %d closing '%s'\n",
+				progname, errno, configname);
+		exit (3);
+	}
+
+	exit (0);
+}
+
+/* end mkconfigs.c */
--- linux/scripts/extract-ikconfig.ikc	Wed Feb 27 13:14:02 2002
+++ linux/scripts/extract-ikconfig	Tue Feb 19 00:17:10 2002
@@ -0,0 +1,23 @@
+#! /bin/bash
+# extracts .config info from a [b]zImage file
+# uses: binoffset (new), dd, zcat, strings, grep
+# $arg1 is [b]zImage filename
+
+vmlinuz=$1
+if [ -z $vmlinuz ] ; then
+	echo "  usage: extract-ikconfig [b]zImage_filename"
+	exit
+fi
+
+HDR=`binoffset $vmlinuz 0x1f 0x8b 0x08 0x0`
+PID=$$
+TMPFILE="$vmlinuz.$PID"
+
+# dd if=$vmlinuz bs=1 skip=$HDR | zcat - | strings /dev/stdin \
+# | grep "[A-Za-z_0-9]=[ynm]$" | sed "s/^/CONFIG_/" > $vmlinuz.oldconfig.$PID
+# exit
+
+dd if=$vmlinuz bs=1 skip=$HDR | zcat - > $TMPFILE
+strings $TMPFILE | grep "^[\#[:blank:]]*CONFIG_[A-Za-z_0-9]*" > $vmlinuz.oldconfig.$PID
+wc $vmlinuz.oldconfig.$PID
+rm $TMPFILE
--- linux/Makefile.ikc	Wed Feb 27 09:54:42 2002
+++ linux/Makefile	Thu Feb 28 14:26:09 2002
@@ -197,6 +197,7 @@
 	kernel/ksyms.lst include/linux/compile.h \
 	vmlinux System.map \
 	.tmp* \
+	scripts/mkconfigs kernel/configs.c kernel/configs.o \
 	drivers/char/consolemap_deftbl.c drivers/video/promcon_tbl.c \
 	drivers/char/conmakehash \
 	drivers/char/drm/*-mod.c \
@@ -236,6 +237,7 @@
 	include/asm \
 	.hdepend scripts/mkdep scripts/split-include scripts/docproc \
 	$(TOPDIR)/include/linux/modversions.h \
+	scripts/mkconfigs kernel/configs.c kernel/configs.o \
 	kernel.spec

 # directories removed with 'make mrproper'
--- linux/arch/i386/Config.help.ikc	Thu Mar  7 18:18:12 2002
+++ linux/arch/i386/Config.help	Fri Mar 15 13:51:12 2002
@@ -630,6 +630,18 @@

   See <file:Documentation/mtrr.txt> for more information.

+CONFIG_IKCONFIG
+  This option enables the complete Linux kernel ".config" file contents
+  to be saved in the kernel (zipped) image file.  It provides
+  documentation of which kernel options are used in a running kernel or
+  in an on-disk kernel.  It can be extracted from the kernel image file
+  with a script and used as input to rebuild the current kernel or to
+  build another kernel.  Since the kernel image is zipped, using this
+  option adds approximately 8 KB to a kernel image file.
+  This option is not available as a module.  If you want a separate
+  file to save the kernel's .config contents, use 'installkernel' or 'cp'
+  or a similar tool, or just save it in '/lib/modules/<kernel-version>'.
+
 CONFIG_PM
   "Power Management" means that parts of your computer are shut
   off or put into a power conserving "sleep" mode if they are not

--346823425-111816671-1016237814=:14689
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="binoffset.c"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.33L2.0203151616540.14689@dragon.pdx.osdl.net>
Content-Description: 
Content-Disposition: attachment; filename="binoffset.c"

LyoqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKg0KICogYmlub2Zmc2V0
LmMNCiAqIChDKSAyMDAyIFJhbmR5IER1bmxhcCA8cmRkdW5sYXBAb3NkbC5v
cmc+DQoNCiMgICBUaGlzIHByb2dyYW0gaXMgZnJlZSBzb2Z0d2FyZTsgeW91
IGNhbiByZWRpc3RyaWJ1dGUgaXQgYW5kL29yIG1vZGlmeQ0KIyAgIGl0IHVu
ZGVyIHRoZSB0ZXJtcyBvZiB0aGUgR05VIEdlbmVyYWwgUHVibGljIExpY2Vu
c2UgYXMgcHVibGlzaGVkIGJ5DQojICAgdGhlIEZyZWUgU29mdHdhcmUgRm91
bmRhdGlvbjsgZWl0aGVyIHZlcnNpb24gMiBvZiB0aGUgTGljZW5zZSwgb3IN
CiMgICAoYXQgeW91ciBvcHRpb24pIGFueSBsYXRlciB2ZXJzaW9uLg0KIw0K
IyAgIFRoaXMgcHJvZ3JhbSBpcyBkaXN0cmlidXRlZCBpbiB0aGUgaG9wZSB0
aGF0IGl0IHdpbGwgYmUgdXNlZnVsLA0KIyAgIGJ1dCBXSVRIT1VUIEFOWSBX
QVJSQU5UWTsgd2l0aG91dCBldmVuIHRoZSBpbXBsaWVkIHdhcnJhbnR5IG9m
DQojICAgTUVSQ0hBTlRBQklMSVRZIG9yIEZJVE5FU1MgRk9SIEEgUEFSVElD
VUxBUiBQVVJQT1NFLiAgU2VlIHRoZQ0KIyAgIEdOVSBHZW5lcmFsIFB1Ymxp
YyBMaWNlbnNlIGZvciBtb3JlIGRldGFpbHMuDQojDQojICAgWW91IHNob3Vs
ZCBoYXZlIHJlY2VpdmVkIGEgY29weSBvZiB0aGUgR05VIEdlbmVyYWwgUHVi
bGljIExpY2Vuc2UNCiMgICBhbG9uZyB3aXRoIHRoaXMgcHJvZ3JhbTsgaWYg
bm90LCB3cml0ZSB0byB0aGUgRnJlZSBTb2Z0d2FyZQ0KIyAgIEZvdW5kYXRp
b24sIEluYy4sIDY3NSBNYXNzIEF2ZSwgQ2FtYnJpZGdlLCBNQSAwMjEzOSwg
VVNBLg0KDQojIGJpbm9mZnNldC5jOg0KIyAtIHNlYXJjaGVzIGEgKGJpbmFy
eSkgZmlsZSBmb3IgYSBzcGVjaWZpZWQgKGJpbmFyeSkgcGF0dGVybg0KIyAt
IHJldHVybnMgdGhlIG9mZnNldCBvZiB0aGUgbG9jYXRlZCBwYXR0ZXJuIG9y
IH4wIGlmIG5vdCBmb3VuZA0KIyAtIGV4aXRzIHdpdGggZXhpdCBzdGF0dXMg
MCBub3JtYWxseSBvciBub24tMCBpZiBwYXR0ZXJuIGlzIG5vdCBmb3VuZA0K
IyAgIG9yIGFueSBvdGhlciBlcnJvciBvY2N1cnMuDQoNCioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKiovDQoNCiNpbmNsdWRlIDxzdGRpby5oPg0KI2luY2x1ZGUgPHN0
ZGxpYi5oPg0KI2luY2x1ZGUgPHN0cmluZy5oPg0KI2luY2x1ZGUgPGVycm5v
Lmg+DQojaW5jbHVkZSA8dW5pc3RkLmg+DQojaW5jbHVkZSA8ZmNudGwuaD4N
CiNpbmNsdWRlIDxzeXMvdHlwZXMuaD4NCiNpbmNsdWRlIDxzeXMvc3RhdC5o
Pg0KI2luY2x1ZGUgPHN5cy9tbWFuLmg+DQoNCiNkZWZpbmUgVkVSU0lPTgkJ
IjAuMSINCiNkZWZpbmUgQlVGX1NJWkUJKDE2ICogMTAyNCkNCiNkZWZpbmUg
UEFUX1NJWkUJMTAwDQoNCmNoYXIJCSpwcm9nbmFtZTsNCmNoYXIJCSppbnB1
dG5hbWU7DQppbnQJCWlucHV0ZmQ7DQppbnQJCWJpeDsJCQkvKiBidWYgaW5k
ZXggKi8NCnVuc2lnbmVkIGNoYXIJcGF0dGVybnMgW1BBVF9TSVpFXSA9IHsw
fTsgLyogYnl0ZS1zaXplZCBwYXR0ZXJuIGFycmF5ICovDQppbnQJCXBhdF9s
ZW47CQkvKiBhY3R1YWwgbnVtYmVyIG9mIHBhdHRlcm4gYnl0ZXMgKi8NCnVu
c2lnbmVkIGNoYXIJKm1hZHI7CQkJLyogbW1hcCBhZGRyZXNzICovDQpzaXpl
X3QJCWZpbGVzaXplOw0KaW50CQludW1fbWF0Y2hlcyA9IDA7DQpvZmZfdAkJ
Zmlyc3Rsb2MgPSAwOw0KDQp2b2lkIHVzYWdlICh2b2lkKQ0Kew0KCWZwcmlu
dGYgKHN0ZGVyciwgIiVzIHZlci4gJXNcbiIsIHByb2duYW1lLCBWRVJTSU9O
KTsNCglmcHJpbnRmIChzdGRlcnIsICJ1c2FnZTogICVzIGZpbGVuYW1lIHBh
dHRlcm5fYnl0ZXNcbiIsDQoJCQlwcm9nbmFtZSk7DQoJZnByaW50ZiAoc3Rk
ZXJyLCAiICAgICAgICBbcHJpbnRzIGxvY2F0aW9uIG9mIHBhdHRlcm5fYnl0
ZXMgaW4gZmlsZV1cbiIpOw0KCWV4aXQgKDEpOw0KfQ0KDQppbnQgZ2V0X3Bh
dHRlcm4gKGludCBwYXRfY291bnQsIGNoYXIgKnBhdHMgW10pDQp7DQoJaW50
IGl4LCBlcnIsIHRtcDsNCg0KI2lmZGVmIERFQlVHDQoJZnByaW50ZiAoc3Rk
ZXJyLCJnZXRfcGF0dGVybjogY291bnQgPSAlZFxuIiwgcGF0X2NvdW50KTsN
Cglmb3IgKGl4ID0gMDsgaXggPCBwYXRfY291bnQ7IGl4KyspDQoJCWZwcmlu
dGYgKHN0ZGVyciwgIiAgcGF0ICMgJWQ6ICBbJXNdXG4iLCBpeCwgcGF0c1tp
eF0pOw0KI2VuZGlmDQoNCglmb3IgKGl4ID0gMDsgaXggPCBwYXRfY291bnQ7
IGl4KyspIHsNCgkJdG1wID0gMDsNCgkJZXJyID0gc3NjYW5mIChwYXRzW2l4
XSwgIiU1aSIsICZ0bXApOw0KCQlpZiAoZXJyICE9IDEgfHwgdG1wID4gMHhm
Zikgew0KCQkJZnByaW50ZiAoc3RkZXJyLCAicGF0dGVybiBvciB2YWx1ZSBl
cnJvciBpbiBwYXR0ZXJuICMgJWQgWyVzXVxuIiwNCgkJCQkJaXgsIHBhdHNb
aXhdKTsNCgkJCXVzYWdlICgpOw0KCQl9DQoJCXBhdHRlcm5zIFtpeF0gPSB0
bXA7DQoJfQ0KCXBhdF9sZW4gPSBwYXRfY291bnQ7DQp9DQoNCmludCBzZWFy
Y2hfcGF0dGVybiAodm9pZCkNCnsNCglmb3IgKGJpeCA9IDA7IGJpeCA8IGZp
bGVzaXplOyBiaXgrKykgew0KCQlpZiAobWFkcltiaXhdID09IHBhdHRlcm5z
WzBdKSB7DQoJCQlpZiAobWVtY21wICgmbWFkcltiaXhdLCBwYXR0ZXJucywg
cGF0X2xlbikgPT0gMCkgew0KCQkJCWlmIChudW1fbWF0Y2hlcyA9PSAwKQ0K
CQkJCQlmaXJzdGxvYyA9IGJpeDsNCgkJCQludW1fbWF0Y2hlcysrOw0KCQkJ
fQ0KCQl9DQoJfQ0KfQ0KDQojaWZkZWYgTk9UREVGDQpzaXplX3QgZ2V0X2Zp
bGVzaXplIChpbnQgZmQpDQp7DQoJb2ZmX3QgZW5kX29mZiA9IGxzZWVrIChm
ZCwgMCwgU0VFS19FTkQpOw0KCWxzZWVrIChmZCwgMCwgU0VFS19TRVQpOw0K
CXJldHVybiAoc2l6ZV90KSBlbmRfb2ZmOw0KfQ0KI2VuZGlmDQoNCnNpemVf
dCBnZXRfZmlsZXNpemUgKGludCBmZCkNCnsNCglpbnQgZXJyOw0KCXN0cnVj
dCBzdGF0IHN0YXQ7DQoNCgllcnIgPSBmc3RhdCAoZmQsICZzdGF0KTsNCglm
cHJpbnRmIChzdGRlcnIsICJmaWxlc2l6ZTogJWRcbiIsIGVyciA8IDAgPyBl
cnIgOiBzdGF0LnN0X3NpemUpOw0KCWlmIChlcnIgPCAwKQ0KCQlyZXR1cm4g
ZXJyOw0KCXJldHVybiAoc2l6ZV90KSBzdGF0LnN0X3NpemU7DQp9DQoNCmlu
dCBtYWluIChpbnQgYXJnYywgY2hhciAqYXJndiBbXSkNCnsNCglwcm9nbmFt
ZSA9IGFyZ3ZbMF07DQoNCglpZiAoYXJnYyA8IDMpDQoJCXVzYWdlICgpOw0K
DQoJZ2V0X3BhdHRlcm4gKGFyZ2MgLSAyLCBhcmd2ICsgMik7DQoNCglpbnB1
dG5hbWUgPSBhcmd2WzFdOw0KDQoJaW5wdXRmZCA9IG9wZW4gKGlucHV0bmFt
ZSwgT19SRE9OTFkpOw0KCWlmIChpbnB1dGZkID09IC0xKSB7DQoJCWZwcmlu
dGYgKHN0ZGVyciwgIiVzOiBjYW5ub3Qgb3BlbiAnJXMnXG4iLA0KCQkJCXBy
b2duYW1lLCBpbnB1dG5hbWUpOw0KCQlleGl0ICgzKTsNCgl9DQoNCglmaWxl
c2l6ZSA9IGdldF9maWxlc2l6ZSAoaW5wdXRmZCk7DQoNCgltYWRyID0gbW1h
cCAoMCwgZmlsZXNpemUsIFBST1RfUkVBRCwgTUFQX1BSSVZBVEUsIGlucHV0
ZmQsIDApOw0KCWlmIChtYWRyID09IE1BUF9GQUlMRUQpIHsNCgkJZnByaW50
ZiAoc3RkZXJyLCAibW1hcCBlcnJvciA9ICVkXG4iLCBlcnJubyk7DQoJCWNs
b3NlIChpbnB1dGZkKTsNCgkJZXhpdCAoNCk7DQoJfQ0KDQoJc2VhcmNoX3Bh
dHRlcm4gKCk7DQoNCglpZiAobXVubWFwIChtYWRyLCBmaWxlc2l6ZSkpDQoJ
CWZwcmludGYgKHN0ZGVyciwgIm11bm1hcCBlcnJvciA9ICVkXG4iLCBlcnJu
byk7DQoNCglpZiAoY2xvc2UgKGlucHV0ZmQpKQ0KCQlmcHJpbnRmIChzdGRl
cnIsICIlczogZXJyb3IgJWQgY2xvc2luZyAnJXMnXG4iLA0KCQkJCXByb2du
YW1lLCBlcnJubywgaW5wdXRuYW1lKTsNCg0KCWZwcmludGYgKHN0ZGVyciwg
Im51bWJlciBvZiBwYXR0ZXJuIG1hdGNoZXMgPSAlZFxuIiwgbnVtX21hdGNo
ZXMpOw0KCWlmIChudW1fbWF0Y2hlcyA9PSAwKQ0KCQlmaXJzdGxvYyA9IH4w
Ow0KCXByaW50ZiAoIiVkXG4iLCBmaXJzdGxvYyk7DQoJZnByaW50ZiAoc3Rk
ZXJyLCAiJWRcbiIsIGZpcnN0bG9jKTsNCg0KCWV4aXQgKG51bV9tYXRjaGVz
ID8gMCA6IDIpOw0KfQ0KDQovKiBlbmQgYmlub2Zmc2V0LmMgKi8NCg==
--346823425-111816671-1016237814=:14689--
