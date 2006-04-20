Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932101AbWDTWg7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932101AbWDTWg7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 18:36:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932089AbWDTWg7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 18:36:59 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.146]:25996 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932101AbWDTWg7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 18:36:59 -0400
To: linux-kernel@vger.kernel.org
Subject: [RFC PATCH 2/3] export symbol report: export-symbol usage report generator.
Cc: akpm@osdl.org, arjan@infradead.org, bunk@stusta.de, greg@kroah.com,
       hch@infradead.org, linuxram@us.ibm.com, mathur@us.ibm.com
Message-Id: <20060420223654.2E5CA470031@localhost>
Date: Thu, 20 Apr 2006 15:36:54 -0700 (PDT)
From: linuxram@us.ibm.com (Ram Pai)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following patch provides the ability to generate a report of
     (1) All the exported symbols and their in-kernel-module usage count 
     (2) For each module, lists the modules and their exported symbols, on
		which it depends.

The report generation is integrated in the build process.
'make export_report' prints out the report.
'make export_report EXPORT_REPORT=Documentation/export_report.txt'
	generates the report in the file Documentation/export_report.txt


Signed-off-by: Ram Pai <linuxram@us.ibm.com>

 Makefile                 |   12 ++++
 scripts/Makefile.modpost |    7 ++
 scripts/export_report.pl    |  135 +++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 154 insertions(+)

Index: 2617rc1/scripts/Makefile.modpost
===================================================================
--- 2617rc1.orig/scripts/Makefile.modpost	2006-04-02 20:22:10.000000000 -0700
+++ 2617rc1/scripts/Makefile.modpost	2006-04-20 04:16:51.000000000 -0700
@@ -60,9 +60,16 @@
 	$(if $(KBUILD_EXTMOD),-o $(modulesymfile)) \
 	$(filter-out FORCE,$^)
 
+quiet_cmd_importfile = IMPORT_EXTRACT
+      cmd_importfile =  perl $(objtree)/scripts/export_report.pl  \
+	-k $(kernelsymfile) \
+	$(if $(KBUILD_EXPORT_REPORT:1=),-o $(KBUILD_EXPORT_REPORT),) \
+	$(patsubst %.o,%.mod.c,$(filter-out vmlinux FORCE, $^))
+
 PHONY += __modpost
 __modpost: $(wildcard vmlinux) $(modules:.ko=.o) FORCE
 	$(call cmd,modpost)
+	$(if $(KBUILD_EXPORT_REPORT), $(call cmd,importfile))
 
 # Declare generated files as targets for modpost
 $(symverfile):         __modpost ;
Index: 2617rc1/scripts/export_report.pl
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ 2617rc1/scripts/export_report.pl	2006-04-18 16:02:32.000000000 -0700
@@ -0,0 +1,134 @@
+#!/usr/bin/perl
+#
+# (C) Copyright IBM Corporation 2006.
+#	Released under GPL v2.
+#	Author : Ram Pai (linuxram@us.ibm.com)
+#
+# Usage: export_report.pl -k Module.symvers [-o report_file ] *.mod.c
+# 
+
+use Getopt::Std;
+
+sub numerically {
+	($sym, $no1) = split / /, $a;
+	($sym, $no2) = split / /, $b;
+	return $no1 <=> $no2;
+}
+
+sub alphabetically {
+	($module1, $value1, undef) = split / /, "@{$a}";
+	($module2, $value2, undef) = split / /, "@{$b}";
+	if ($value1 == $value2) {
+		if ($module1 lt $module2) {
+			return 1;
+		} elsif ($module1 eq $module2) {
+			return 0;
+		} 
+		return -1;
+	}
+	return $value1 <=> $value2;
+}
+
+sub print_depends_on {
+	my ($href) = @_;
+	print "\n";
+	while (($mod, $list) = each %$href) {
+		print "\t$mod:\n";
+		foreach $sym (sort numerically @{$list}) {
+			($symbol, $no) = split / /, $sym;
+			printf("\t\t%-25s\t%-25d\n", $symbol, $no);
+		}
+		print "\n";
+	}
+	print "\n";
+	print "~"x80 , "\n";
+}
+
+sub usage {
+        die "Usage: @_ -h -k Module.symvers  [ -o outputfile ] \n";
+}
+
+
+if (not getopts('hk:o:') or defined $opt_h or not defined $opt_k) {
+        usage($0);
+}
+
+unless (open(MODULE_SYMVERS, $opt_k)) {
+	die "Sorry, cannot open $opt_k: $!\n";
+}
+
+if (defined $opt_o) {
+	unless (open(OUTPUT_HANDLE, ">$opt_o")) {
+		die "Sorry, cannot open $opt_o: $!\n";
+	}
+	select OUTPUT_HANDLE;
+}
+
+#
+# collect all the symbols and their attributes from the 
+# Module.symvers file
+#
+while ( <MODULE_SYMVERS> ) {
+	chomp;
+	($crc, $symbol, $module, $gpl) = split;
+	$SYMBOL { $symbol } =  [ $module , "0" , $symbol, $gpl];
+}
+close(MODULE_SYMVERS);
+
+#
+# collect the usage count of each symbol.
+#
+for ($i = 0; $i <= $#ARGV; $i++) {
+	$thismod = $ARGV[$i];
+	unless (open(MODULE_MODULE, $thismod)) {
+		print "Sorry, cannot open $kernel: $!\n";
+		next;
+	}
+	while ( <MODULE_MODULE> ) {
+		chomp;
+		if ( $_ !~ /0x[0-9a-f]{7,8},/ ) {
+			next;
+		}
+		(undef, undef, undef, undef, $symbol) = split /([,"])/, $_;
+		($module, $value, $symbol, $gpl) = @{$SYMBOL{$symbol}};
+		$SYMBOL{ $symbol } =  [ $module , $value+1 , $symbol, $gpl];
+		push(@{$MODULE{$thismod}} , $symbol);
+	}
+	close(MODULE_MODULE);
+}
+
+
+print "\tTHIS FILE REPORTS THE USAGE PATTERNS OF EXPORTED SYMBOLS BY IN_TREE\n";
+print "\t\t\t\tMODULES\n";
+printf("%s\n\n\n","x"x80);
+printf("\t\t\t\INDEX\n\n\n");
+printf("SECTION 1: USAGE COUNTS OF ALL EXPORTED SYMBOLS\n");
+printf("SECTION 2: LIST OF MODULES AND THE EXPORTED SYMBOLS THEY USE\n");
+printf("%s\n\n\n","x"x80);
+printf("SECTION 1:\tTHE EXPORTED SYMBOLS AND THEIR USAGE COUNT\n\n");
+printf("%-25s\t%-25s\t%-5s\t%-25s\n", "SYMBOL", "MODULE", "USAGE COUNT", "EXPORT TYPE");
+#
+# print the list of unused exported symbols
+#
+foreach $list (sort alphabetically values(%SYMBOL)) {
+	($module, $value, $symbol, $gpl) = split / /, "@{$list}";
+	printf("%-25s\t%-25s\t%-10s\t%-25s\n", $symbol, $module, $value, $gpl);
+}
+printf("%s\n\n\n","x"x80);
+
+
+printf("SECTION 2:\n\tThis section reports export-symbol-usage of in-kernel
+modules. Each module lists all the modules, and the symbols from the module it
+depends on.  Each listed symbol reports the number of modules using that
+symbols.\n");
+
+print "~"x80 , "\n";
+while (($thismod, $list) = each %MODULE) {
+	undef %depends;
+	print "\t\t\t$thismod\n";
+	foreach $symbol (@{$list}) {
+		($module, $value, undef, $gpl) = @{$SYMBOL{$symbol}};
+		push (@{$depends{"$module"}}, "$symbol $value");
+	}
+	print_depends_on(\%depends);
+}
Index: 2617rc1/Makefile
===================================================================
--- 2617rc1.orig/Makefile	2006-04-02 20:22:10.000000000 -0700
+++ 2617rc1/Makefile	2006-04-20 06:24:10.000000000 -0700
@@ -185,8 +185,10 @@
 
 HOSTCC  	= gcc
 HOSTCXX  	= g++
-HOSTCFLAGS	= -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer
-HOSTCXXFLAGS	= -O2
+#HOSTCFLAGS	= -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer
+HOSTCFLAGS	= -Wall -Wstrict-prototypes -g -fomit-frame-pointer
+#HOSTCXXFLAGS	= -O2
+HOSTCXXFLAGS	= -g
 
 # 	Decide whether to build built-in, modular, or both.
 #	Normally, just do built-in.
@@ -433,6 +435,7 @@
 core-y		:= usr/
 endif # KBUILD_EXTMOD
 
+
 ifeq ($(dot-config),1)
 # In this section, we need .config
 
@@ -873,7 +876,6 @@
 	@echo '  Building modules, stage 2.';
 	$(Q)$(MAKE) -rR -f $(srctree)/scripts/Makefile.modpost
 
-
 # Target to prepare building external modules
 PHONY += modules_prepare
 modules_prepare: prepare scripts
@@ -1033,6 +1035,7 @@
 	@echo  'Static analysers'
 	@echo  '  checkstack      - Generate a list of stack hogs'
 	@echo  '  namespacecheck  - Name space analysis on compiled kernel'
+	@echo  '  export_report	  - Export symbols usage analysis on compile kernel'
 	@echo  ''
 	@echo  'Kernel packaging:'
 	@$(MAKE) $(build)=$(package-dir) help
@@ -1259,6 +1262,19 @@
 namespacecheck:
 	$(PERL) $(srctree)/scripts/namespace.pl
 
+ifeq ($(MAKECMDGOALS), export_report)
+  	KBUILD_EXPORT_REPORT := 1
+	ifdef EXPORT_REPORT
+	  ifeq ("$(origin EXPORT_REPORT)", "command line")
+  		KBUILD_EXPORT_REPORT = $(EXPORT_REPORT)
+	  endif
+	endif
+	export KBUILD_EXPORT_REPORT
+endif
+
+PHONY += export_report
+export_report: vmlinux modules
+
 endif #ifeq ($(config-targets),1)
 endif #ifeq ($(mixed-targets),1)
 
