Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265680AbTIFEkk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Sep 2003 00:40:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265682AbTIFEkk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Sep 2003 00:40:40 -0400
Received: from fw.osdl.org ([65.172.181.6]:47522 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265680AbTIFEkg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Sep 2003 00:40:36 -0400
Date: Fri, 5 Sep 2003 21:38:28 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: torvalds <torvalds@osdl.org>
Cc: lkml <linux-kernel@vger.kernel.org>, sam@ravnborg.org
Subject: [PATCH] rename make check* targets, add versioncheck
Message-Id: <20030905213828.5af10391.rddunlap@osdl.org>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

Please apply to 2.6.0-test4-current.

description:	rename make check* targets to make *check (per Sam)
		since 'make checkconfig' currently doesn't work;
		add versioncheck and scripts/checkversion.pl;


patch_name:	make_checks.patch
patch_version:	2003-09-05.21:27:18
author:		Randy.Dunlap <rddunlap@osdl.org>
product:	Linux
product_versions: 2.6.0-test4
diffstat:	=
 Makefile                |    9 ++++--
 scripts/checkversion.pl |   72 ++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 79 insertions(+), 2 deletions(-)


diff -Naur ./scripts/checkversion.pl~checks ./scripts/checkversion.pl
--- ./scripts/checkversion.pl~checks	2003-09-05 21:11:35.000000000 -0700
+++ ./scripts/checkversion.pl	2003-09-05 21:09:38.000000000 -0700
@@ -0,0 +1,72 @@
+#! /usr/bin/perl
+#
+# checkversion find uses of LINUX_VERSION_CODE, KERNEL_VERSION, or
+# UTS_RELEASE without including <linux/version.h>, or cases of
+# including <linux/version.h> that don't need it.
+# Copyright (C) 2003, Randy Dunlap <rddunlap@osdl.org>
+
+$| = 1;
+
+my $debugging = 0;
+
+foreach $file (@ARGV)
+{
+    # Open this file.
+    open(FILE, $file) || die "Can't open $file: $!\n";
+
+    # Initialize variables.
+    my $fInComment   = 0;
+    my $fInString    = 0;
+    my $fUseVersion   = 0;
+    my $iLinuxVersion = 0;
+
+    LINE: while ( <FILE> )
+    {
+	# Strip comments.
+	$fInComment && (s+^.*?\*/+ +o ? ($fInComment = 0) : next);
+	m+/\*+o && (s+/\*.*?\*/+ +go, (s+/\*.*$+ +o && ($fInComment = 1)));
+
+	# Pick up definitions.
+	if ( m/^\s*#/o ) {
+	    $iLinuxVersion      = $. if m/^\s*#\s*include\s*"linux\/version\.h"/o;
+	}
+
+	# Strip strings.
+	$fInString && (s+^.*?"+ +o ? ($fInString = 0) : next);
+	m+"+o && (s+".*?"+ +go, (s+".*$+ +o && ($fInString = 1)));
+
+	# Pick up definitions.
+	if ( m/^\s*#/o ) {
+	    $iLinuxVersion      = $. if m/^\s*#\s*include\s*<linux\/version\.h>/o;
+	}
+
+	# Look for uses: LINUX_VERSION_CODE, KERNEL_VERSION, UTS_RELEASE
+	if (($_ =~ /LINUX_VERSION_CODE/) || ($_ =~ /\WKERNEL_VERSION/) ||
+		($_ =~ /UTS_RELEASE/)) {
+	    $fUseVersion = 1;
+	    last LINE if $iLinuxVersion;
+	}
+    }
+
+    # Report used version IDs without include?
+    if ($fUseVersion && ! $iLinuxVersion) {
+	print "$file: $.: need linux/version.h\n";
+    }
+
+    # Report superfluous includes.
+    if ($iLinuxVersion && ! $fUseVersion) {
+	print "$file: $iLinuxVersion linux/version.h not needed.\n";
+    }
+
+    # debug: report OK results:
+    if ($debugging) {
+        if ($iLinuxVersion && $fUseVersion) {
+	    print "$file: version use is OK ($iLinuxVersion)\n";
+        }
+        if (! $iLinuxVersion && ! $fUseVersion) {
+	    print "$file: version use is OK (none)\n";
+        }
+    }
+
+    close(FILE);
+}
diff -Naur ./Makefile~checks ./Makefile
--- ./Makefile~checks	2003-09-04 16:27:43.000000000 -0700
+++ ./Makefile	2003-09-05 21:11:23.000000000 -0700
@@ -828,16 +828,21 @@
 # Scripts to check various things for consistency
 # ---------------------------------------------------------------------------
 
-checkconfig:
+configcheck:
 	find * $(RCS_FIND_IGNORE) \
 		-name '*.[hcS]' -type f -print | sort \
 		| xargs $(PERL) -w scripts/checkconfig.pl
 
-checkincludes:
+includecheck:
 	find * $(RCS_FIND_IGNORE) \
 		-name '*.[hcS]' -type f -print | sort \
 		| xargs $(PERL) -w scripts/checkincludes.pl
 
+versioncheck:
+	find * $(RCS_FIND_IGNORE) \
+		-name '*.[hcS]' -type f -print | sort \
+		| xargs $(PERL) -w scripts/checkversion.pl
+
 endif #ifeq ($(config-targets),1)
 endif #ifeq ($(mixed-targets),1)
 


--
~Randy
