Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132611AbRDOJZx>; Sun, 15 Apr 2001 05:25:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132615AbRDOJZn>; Sun, 15 Apr 2001 05:25:43 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:42447 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S132611AbRDOJZa>;
	Sun, 15 Apr 2001 05:25:30 -0400
Message-ID: <3AD96904.9274E46C@mandrakesoft.com>
Date: Sun, 15 Apr 2001 05:25:24 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.4-pre3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: PATCH 2.4.4.3: 3rdparty driver support for kbuild
Content-Type: multipart/mixed;
 boundary="------------0B8210B1C97FFD4565C19AFC"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------0B8210B1C97FFD4565C19AFC
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

The attached patch, against kernel 2.4.4-pre3, adds a feature I call
"3rd-party support."

When vendors put additional kernel modules and drivers in their kernel
package, typically they do so via a patch.  For the case where totally
new file(s) are added to a kernel, this results in patch conflicts time
and again, because all these patches are updating central files: 
drivers/foo/Config.in and drivers/foo/Makefile.

The attached patch allows the addition of new kernel features without
patching.

A vendor can simply have their kernel package build process untar a
tarball inside the 3rdparty directory, or 'cp' a .c file into the
3rdparty directory.  You simply run the "mkbuild.pl" script to make the
kernel build and configuration system aware of the new kernel module,
and then rebuild with your normal kernel build process.  Additional
details are included in Documentation/3rdparty.txt, in the patch.

-- 
Jeff Garzik       | "Give a man a fish, and he eats for a day. Teach a
Building 1024     |  man to fish, and a US Navy submarine will make sure
MandrakeSoft      |  he's never hungry again." -- Chris Neufeld
--------------0B8210B1C97FFD4565C19AFC
Content-Type: text/plain; charset=us-ascii;
 name="3rdparty-2.4.4.3.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="3rdparty-2.4.4.3.patch"

Index: linux_2_4/Makefile
diff -u linux_2_4/Makefile:1.1.1.85 linux_2_4/Makefile:1.1.1.85.2.1
--- linux_2_4/Makefile:1.1.1.85	Fri Apr 13 17:13:43 2001
+++ linux_2_4/Makefile	Fri Apr 13 18:16:59 2001
@@ -124,7 +124,7 @@
 		 drivers/net/net.o \
 		 drivers/media/media.o
 LIBS		=$(TOPDIR)/lib/lib.a
-SUBDIRS		=kernel drivers mm fs net ipc lib
+SUBDIRS		=kernel drivers mm fs net ipc lib 3rdparty
 
 DRIVERS-n :=
 DRIVERS-y :=
@@ -180,6 +180,7 @@
 
 DRIVERS += $(DRIVERS-y)
 
+include 3rdparty/Makefile.drivers
 
 # files removed with 'make clean'
 CLEAN_FILES = \
@@ -219,7 +220,8 @@
 	.menuconfig.log \
 	include/asm \
 	.hdepend scripts/mkdep scripts/split-include scripts/docproc \
-	$(TOPDIR)/include/linux/modversions.h
+	$(TOPDIR)/include/linux/modversions.h \
+	3rdparty/Makefile.meta
 # directories removed with 'make mrproper'
 MRPROPER_DIRS = \
 	include/config \
@@ -407,7 +409,19 @@
 	rm -rf $(CLEAN_DIRS)
 	$(MAKE) -C Documentation/DocBook clean
 
-mrproper: clean archmrproper
+3rdpartyproper:
+	@echo "#" > 3rdparty/Config.in
+	@echo "# THIS IS AN AUTOMATICALLY GENERATED FILE. DO NOT EDIT." >> 3rdparty/Config.in
+	@echo "#" >> 3rdparty/Config.in
+	@echo "#" > 3rdparty/Makefile
+	@echo "# THIS IS AN AUTOMATICALLY GENERATED FILE. DO NOT EDIT." >> 3rdparty/Makefile
+	@echo "#" >> 3rdparty/Makefile
+	@echo 'include $$(TOPDIR)/Rules.make' >> 3rdparty/Makefile
+	@echo "#" > 3rdparty/Makefile.drivers
+	@echo "# THIS IS AN AUTOMATICALLY GENERATED FILE. DO NOT EDIT." >> 3rdparty/Makefile.drivers
+	@echo "#" >> 3rdparty/Makefile.drivers
+
+mrproper: clean archmrproper 3rdpartyproper
 	find . \( -size 0 -o -name .depend \) -type f -print | xargs rm -f
 	rm -f $(MRPROPER_FILES)
 	rm -rf $(MRPROPER_DIRS)
Index: linux_2_4/3rdparty/Makefile.drivers
diff -u /dev/null linux_2_4/3rdparty/Makefile.drivers:1.1.4.1
--- /dev/null	Sun Apr 15 02:15:05 2001
+++ linux_2_4/3rdparty/Makefile.drivers	Sun Apr 15 02:14:41 2001
@@ -0,0 +1,3 @@
+#
+# THIS IS AN AUTOMATICALLY GENERATED FILE. DO NOT EDIT.
+#
Index: linux_2_4/3rdparty/mkbuild.pl
diff -u /dev/null linux_2_4/3rdparty/mkbuild.pl:1.1.6.1
--- /dev/null	Sun Apr 15 02:15:05 2001
+++ linux_2_4/3rdparty/mkbuild.pl	Fri Apr 13 18:16:59 2001
@@ -0,0 +1,366 @@
+#!/usr/bin/perl -w
+#
+# Copyright 2001 Jeff Garzik <jgarzik@mandrakesoft.com>
+#
+# This software may be used and distributed according to the terms
+# of the GNU General Public License, incorporated herein by reference.
+#
+#
+# Run "mkbuild.pl -h" for a usage summary.
+#
+# Makefile.meta datafile format:
+# 2D table with columns separated by formfeeds,
+# and rows separated by newlines.  Columns 1-N meanings
+# differ based on column 0 value.
+#
+# Column 0: 'D' or 'F' character -- directory or file
+# Column 1(D): sub-directory containing kernel module
+# Column 2(D): Config.in CONFIG_xxx symbol for this sub-directory
+# Column 3(D): Config.in line, verbatim, for this sub-directory
+# Column 4(D): Filename of target, from [LO]_TARGET in subdir/Makefile
+# Column 1(F): Base name of kernel module
+# Column 2(F): Config.in CONFIG_xxx symbol for this module
+# Column 3(F): Config.in line, verbatim, for this module
+# Column 4(F): Export symbols flag: 'Y' or 'N'
+
+
+use strict;
+use Getopt::Std;
+
+my $MetadataFile = "Makefile.meta";
+
+my (%opts, $InstDir, $InstFile);
+my ($FileDesc, $ConfigIn, $ExportSyms, $ConfigSym, @db);
+
+
+&parse_cmd_line;
+
+if ($opts{'c'}) {
+	print STDERR "Creating new database (ignoring any existing one).\n";
+} else {
+	&read_database;
+}
+
+if ($opts{'r'}) {
+	# do nothing
+} elsif ($InstDir) {
+	&update_from_dir;
+} else {
+	&update_from_file;
+}
+
+&update_database;
+&regen_files;
+
+exit(0);
+
+##########################################################################
+
+sub regen_makefile {
+	my (@ent, @export_objs, @dirs);
+	my ($modname, @modules, $rc);
+	
+	foreach (@db) {
+		@ent = split(/\f/);
+		if ($ent[0] eq "D") {
+			push(@dirs, $ent[1]);
+		}
+		elsif ($ent[0] eq "F") {
+			$modname = $ent[1] . ".o";
+			if ($ent[4] eq "Y") {
+				push(@export_objs, $modname);
+			}
+		}
+	}
+
+	open (F, ">Makefile") or die "Cannot create new Makefile: $!\n";
+	print F <<"EOM";
+#
+# THIS IS AN AUTOMATICALLY GENERATED FILE.  DO NOT EDIT.
+#
+
+EOM
+
+	if (!@dirs && !$modname) {
+		close(F);
+		return;
+	}
+
+	print F <<"EOM";
+
+O_TARGET := 3rdparty.o
+
+EOM
+	
+	print F "export-objs := ", join(" ", @export_objs), "\n\n"
+		if (@export_objs);
+	print F "mod-subdirs := ", join(" ", @dirs), "\n\n"
+		if (@dirs);
+
+	foreach (@db) {
+		@ent = split(/\f/);
+		if ($ent[0] eq "D") {
+			printf F "subdir-\$(%s) += %s\n", $ent[2], $ent[1];
+		}
+		elsif ($ent[0] eq "F") {
+			printf F "obj-\$(%s) += %s.o\n", $ent[2], $ent[1];
+		}
+	}
+
+	print F <<"EOM";
+
+include \$(TOPDIR)/Rules.make
+
+EOM
+
+	close(F);
+
+	$rc = 0;
+	$rc |= 0x01 if @dirs;
+	$rc |= 0x02 if $modname;
+	return $rc;
+}
+
+
+sub regen_drivers_makefile {
+	my ($havemask) = @_;
+	my $have_dirs = $havemask & 0x01;
+	my $have_files = $havemask & 0x02;
+	my (@ent);
+	
+	open (F, ">Makefile.drivers") or
+		die "Cannot create Makefile.drivers: $!\n";
+	print F <<"EOM";
+#
+# THIS IS AN AUTOMATICALLY GENERATED FILE.  DO NOT EDIT.
+#
+
+DRIVERS-y :=
+DRIVERS += 3rdparty/3rdparty.o
+EOM
+
+	foreach (@db) {
+		@ent = split(/\f/);
+		if ($ent[0] eq "D") {
+			printf F "DRIVERS-\$(%s) += 3rdparty/%s\n",
+				 $ent[2], $ent[4];
+		}
+	}
+
+	print F <<"EOM";
+
+DRIVERS += \$(DRIVERS-y)
+
+EOM
+
+	close(F);
+}
+
+
+sub regen_config_in {
+	my (@ent);
+
+	open (F, ">Config.in") or
+		die "Cannot create Config.in: $!\n";
+	print F <<"EOM";
+#
+# THIS IS AN AUTOMATICALLY GENERATED FILE.  DO NOT EDIT.
+#
+
+mainmenu_option next_comment
+comment 'Unofficial 3rd party kernel additions'
+
+EOM
+	
+	foreach (@db) {
+		@ent = split(/\f/);
+		print F $ent[3], "\n";
+	}
+
+	print F "\n\nendmenu\n";
+	close(F);
+}
+
+
+sub regen_files {
+	my $havemask = &regen_makefile;
+	&regen_drivers_makefile($havemask);
+	&regen_config_in;
+}
+
+
+sub update_database {
+	my ($s);
+
+	open (F, ">$MetadataFile") or
+		die "Cannot create new file $MetadataFile: $!\n";
+
+	foreach $s (@db) {
+		print F "$s\n";
+	}
+
+	close F;
+}
+
+
+sub find_target {
+	open(F, "$InstDir/Makefile") or die "$InstDir/Makefile: $!\n";
+	while (<F>) {
+		chomp;
+		return $1 if (/[LO]_TARGET.*:=\s+(\S+)/);
+	}
+	close(F);
+	die "Cannot find O/L_TARGET in $InstDir/Makefile.\n";
+}
+
+
+sub update_from_dir {
+	die "No CONFIG_xxx symbol specified for directory\n"
+		unless ($ConfigSym);
+	die "No Makefile in $InstDir.\n" if (! -r "$InstDir/Makefile");
+	if (-r "$InstDir/Config.in") {
+		$ConfigIn = sprintf "source 3rdparty/%s/Config.in", $InstDir;
+	} else {
+		$ConfigIn = sprintf "tristate '%s' %s", $FileDesc, $ConfigSym;
+	}
+	my $target = &find_target;
+	push(@db, "D\f$InstDir\f$ConfigSym\f$ConfigIn\f$target");
+}
+
+
+sub file_find_config_sym {
+	open(F, $InstFile) or die "Cannot open file $InstFile: $!\n";
+	while (<F>) {
+		chomp;
+		$ConfigSym = $1 if (/^c-help-symbol:\s+(CONFIG_\S+)/);
+	}
+	close(F);
+}
+
+
+sub file_find_config_in {
+	open(F, $InstFile) or die "Cannot open file $InstFile: $!\n";
+	while (<F>) {
+		chomp;
+		$ConfigIn = $1 if (/^config-in:\s+(.*)$/);
+	}
+	close(F);
+}
+
+
+sub update_from_file {
+	my ($basename) = ($InstFile =~ /^(.*)\.c$/);
+
+	if (!$ConfigSym) {
+		&file_find_config_sym;
+		die "No CONFIG_xxx variable assigned to $InstFile\n"
+			if (!$ConfigSym);
+	}
+
+	&file_find_config_in;
+	$ConfigIn = sprintf "tristate '%s' %s\n", $FileDesc, $ConfigSym
+		if (!$ConfigIn);
+
+	my $ent = sprintf "F\f$basename\f$ConfigSym\f%s\f%s\n",
+			  $ConfigIn, $ExportSyms ? "Y" : "N";
+	push(@db, $ent);
+}
+
+
+sub read_database {
+	if (open F, $MetadataFile) {
+		@db = <F>;
+		close F;
+		chomp @db;
+	} else {
+		print STDERR "No database found, creating new one.\n";
+	}
+}
+
+
+sub show_usage {
+	print <<"EOM";
+Usage:
+mkbuild.pl [options]
+
+Options:
+-h, -?		Display this usage summary.
+-c		Clear database (do not read it on startup).
+-d DIR		Setup module installed in DIR sub-directory.
+-D \"my desc\"	Override Config.in description for FILE, with -f.
+		Provide Config.in line instead of using Config.in
+		file in sub-directory DIR, with -d.
+-e		Flag FILE as a module which exports symbols.
+		Only valid with -f.
+-f FILE		Setup module from file FILE.
+-r		Do not add anything, simply regenerate
+		make and config.in files from metadata.
+		-d, -f, and related options are ignored.
+-s PREFIX	Override Config.in and Makefile CONFIG_xxx
+		symbol with PREFIX.  If the string 'CONFIG_'
+		is not present, it is prepended.  If any chars
+		in the PREFIX are lowercase, they are made uppercase.
+		If -s is missing and -d is present, the prefix will
+		be derived from the sub-directory name.
+EOM
+}
+
+
+sub parse_cmd_line {
+	getopts('cd:D:ef:hrs:?', \%opts);
+
+	if ($opts{'?'} || $opts{'h'}) {
+		&show_usage;
+		exit(0);
+	}
+
+	if ($opts{'s'}) {
+		if ($opts{'s'} !~ /^config_/i) {
+			$ConfigSym = "CONFIG_" . $opts{'s'};
+		} else {
+			$ConfigSym = $opts{'s'};
+		}
+		$ConfigSym =~ tr/a-z/A-Z/;
+	}
+	$FileDesc = $opts{'D'} if $opts{'D'};
+
+	if ($opts{'r'}) {
+		# do nothing
+	}
+
+	elsif ($opts{'d'}) {
+		$InstDir = $opts{'d'};
+		die "Directory $InstDir does not exist\n" if (! -e $InstDir);
+		die "$InstDir is not a directory\n" if (! -d $InstDir);
+		die "Directory $InstDir is not readable\n" if (! -r $InstDir);
+		die "Directory $InstDir is not a subdir\n"
+			if (($InstDir =~ m#^/#) || ($InstDir =~ m#^\.#));
+
+		if (!$ConfigSym) {
+			$ConfigSym = 'CONFIG_' . $InstDir;
+			$ConfigSym =~ tr/a-z/A-Z/;
+			$ConfigSym =~ s/[\-\. ]/_/g;
+		}
+
+		print "Updating from directory $InstDir.\n";
+	}
+
+	elsif ($opts{'f'} ) {
+		$InstFile = $opts{'f'};
+		die "$InstFile is not a .c file\n"
+			if ($InstFile !~ /\.c$/);
+		die "File $InstFile does not exist\n" if (! -e $InstFile);
+		die "$InstFile is not a file\n" if (! -f $InstFile);
+		die "File $InstFile is not readable\n" if (! -r $InstFile);
+		print "Updating from file $InstFile.\n";
+	
+		$ExportSyms = $opts{'e'};
+	}
+	
+	else {
+		print STDERR "No valid operation mode, aborting.\n";
+		exit(1);
+	}
+}
+
+
Index: linux_2_4/Documentation/3rdparty.txt
diff -u /dev/null linux_2_4/Documentation/3rdparty.txt:1.1.6.1
--- /dev/null	Sun Apr 15 02:15:05 2001
+++ linux_2_4/Documentation/3rdparty.txt	Fri Apr 13 18:16:59 2001
@@ -0,0 +1,108 @@
+
+Third-Party Kernel Source Module Support, or
+an easy way to add modules to your kernel build.
+
+
+
+Vendors quite often add additional drivers and features to the kernel
+which require nothing more than modifying Config.in, Makefile, and
+adding one or more files to a sub-directory.  As a single discrete task,
+this is not a problem.  However, using patches to add modules to the
+kernel very often results in patch conflicts, resulting in needless time
+wastage as developers regenerate an otherwise working kernel patch.
+
+This is designed as a solution to these problems.  It is NOT designed as
+a replacement for the kernel build system, but merely as a tool for
+vendors and system administrators to ease the pain of patch management.
+
+The key feature of this system is the distinct lack of patches.  Drivers
+are installed via copying a file, and/or unpacking a tarball.
+
+
+
+Adding a single-file kernel module to the build
+-----------------------------------------------
+Command summary:
+
+	cd /usr/src/linux-2.4.3/3rdparty
+	cp /tmp/my-driver.c .
+	./mkbuild.pl -f my-driver.c
+
+Notice the lack of CONFIG_xxx information.  This is all taken from
+the .c file itself, using a system found in Donald Becker's device
+drivers.  The format is self-documenting if you are familiar with the
+makefile system.  Here is an example, from drivers/net/winbond-840.c:
+
+/* Automatically extracted configuration info:
+probe-func: winbond840_probe
+config-in: tristate 'Winbond W89c840 Ethernet support' CONFIG_WINBOND_840
+
+c-help-name: Winbond W89c840 PCI Ethernet support
+c-help-symbol: CONFIG_WINBOND_840
+c-help: This driver is for the Winbond W89c840 chip.  It also works with
+c-help: the TX9882 chip on the Compex RL100-ATX board.
+c-help: More specific information and updates are available from 
+c-help: http://www.scyld.com/network/drivers.html
+*/
+
+NOTE that mkbuild.pl only uses "config-in" and "c-help-symbol" tokens
+at this time.
+
+
+
+Adding a single-file kernel module to the build
+(without inline source info)
+-----------------------------------------------
+If the source file does not include inline source configuration info,
+you must supply it on the mkbuild.pl command line.
+
+	cd /usr/src/linux-2.4.3/3rdparty
+	cp /tmp/my-driver.c .
+	./mkbuild.pl -f my-driver.c -s my_driver \
+		-D "Support for Foo Wizbang Hardware 4001"
+
+The -s option creates the CONFIG_xxx variable, in this example
+CONFIG_MY_DRIVER.  The -D option supplies the description that appears
+in the Config.in file.
+
+
+
+Adding a directory to the build (usually from a tarball)
+--------------------------------------------------------
+If a directory exists inside the 3rdparty sub-directory that contains a
+proper Makefile, it can be added to the build.  It is highly recommended
+that a Config.in file is supplied as well, but this is not necessary.
+
+	cd /usr/src/linux-2.4.3/3rdparty
+	bzcat /tmp/my-driver2.tar.bz2 | tar xf - # creates "my2" dir
+	./mkbuild.pl -d my2
+
+If a Config.in is not available, then you should use the -s and -D
+mkbuild.pl options to create a Config.in entry.
+
+
+
+
+Limitations
+-----------
+There are some limitations to this system.  This system is only
+designed to support a very common case.  If you find yourself running
+into limitations (kernel build experts can spot them right off),
+then you should probably be patching the kernel instead of using
+mkbuild.pl for that particular module.
+
+FIXME: actually list the limitations
+
+
+
+Other notes
+-----------
+Link order is controlled by the order of mkbuild.pl executions.
+
+"make mrproper" will erase Makefile.meta, and empty Config.in, Makefile,
+and Makefile.drivers.
+
+IMPORTANT NOTE: Because this feature modifies the kernel's makefiles and
+configuration system, you MUST complete all mkbuild.pl runs before
+running any "make" command.
+
Index: linux_2_4/arch/i386/config.in
diff -u linux_2_4/arch/i386/config.in:1.1.1.48 linux_2_4/arch/i386/config.in:1.1.1.48.2.1
--- linux_2_4/arch/i386/config.in:1.1.1.48	Fri Apr 13 17:26:04 2001
+++ linux_2_4/arch/i386/config.in	Fri Apr 13 18:17:01 2001
@@ -377,3 +377,6 @@
 #bool 'Debug kmalloc/kfree' CONFIG_DEBUG_MALLOC
 bool 'Magic SysRq key' CONFIG_MAGIC_SYSRQ
 endmenu
+
+source 3rdparty/Config.in
+

--------------0B8210B1C97FFD4565C19AFC--

