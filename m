Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268735AbUILOWA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268735AbUILOWA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Sep 2004 10:22:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268737AbUILOV7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Sep 2004 10:21:59 -0400
Received: from natnoddy.rzone.de ([81.169.145.166]:398 "EHLO natnoddy.rzone.de")
	by vger.kernel.org with ESMTP id S268735AbUILOVU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Sep 2004 10:21:20 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: kernel-janitors@lists.osdl.org
Subject: Re: [PATCH] detect indirect header dependencies
Date: Sun, 12 Sep 2004 16:20:49 +0200
User-Agent: KMail/1.6.2
Cc: linux-kernel@vger.kernel.org
References: <200409112257.09662.arnd@arndb.de>
In-Reply-To: <200409112257.09662.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: multipart/signed;
  protocol="application/pgp-signature";
  micalg=pgp-sha1;
  boundary="Boundary-02=_CtFRBULzHG/pVwq";
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <200409121620.50172.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-02=_CtFRBULzHG/pVwq
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

[Just noticed I had sent a -p0 patch accidentally, this is the -p1 patch]

The kernel generally follows the rule that header files are included
from every other source file using its declarations and not just
through intermediate headers. We already have scripts to check
this for version.h and config.h, but not for anything else.

I have used the algorithm from scripts/checkversion.pl to make
the checks far more general. With scripts/checkheaders.pl,
it is possible to check source files against the input from
a ctags file, similar to checkversion.
On top of that, checkheaders.sh can be used in place of sparse
to do automated checks during a kernel build.

The required coding policy is:
- For every C or preprocessor symbol, include the header declaring
  it directly from the file using it.
- If the declaration is in include/asm-generic/foo.h, include the
  file as <asm/foo.h>.
- If the declaration is in include/asm-*/foo.h and include/linux/foo.h
  exists, include the file as <linux/foo.h>.
- Some exceptions to these rules are hardcoded into the scripts.

There are tons of warnings from this, including a small number of
false positives, so I doubt it makes much sense to attempt to fix
them all. Also, some parts of the kernel might have conflicting
policies.

Still, this might turn out as a helpful tool for janitors trying to
clean up the include hierarchy.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>

---
Index: linux/scripts/checkheaders.sh
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux/scripts/checkheaders.sh	2004-09-12 12:37:22.776599760 +0200
@@ -0,0 +1,58 @@
+#!/bin/sh
+# NAME
+#   checkheaders.sh - check a source file for correct use of header files
+#
+# SYNOPSIS
+#   scripts/checkheaders.sh [cpp-options] file
+#
+# DESCRIPTION
+#   This is meant as a simple frontend for scripts/checkheader.pl
+#   that automatically determines the headers to check.
+#
+#   It will print a warning for every directly included header
+#   that does not contain any referenced identifier as well as
+#   every indirectly included header that is referenced.
+#
+#   When both include/asm/foo.h and include/linux/foo.h exist,
+#   assume that we need to include <linux/foo.h>, even if we
+#   only use identifiers from <asm/foo.h>.
+#
+# EXAMPLES:
+#   scripts/checkheaders.sh -Iinclude -Iobj/include2 -D__KERNEL__ foo/bar.c
+#	checks only the file foo/bar.c
+#
+#   make C=1 CHECK=$PWD/scripts/checkheaders.sh
+#	builds the kernel while using this script to check every
+#	single C source file.
+#
+# AUTHOR
+#   Arnd Bergmann <arnd@arndb.de>
+#
+
+srctree="${srctree:-.}"
+CPP="${CPP:-gcc -E}"
+
+# argument processing: assume the last non-option argument
+# is the source file
+for i in "$@" ; do
+	if [ "$i" = "${i#-}" ] ; then
+		file="$i"
+	fi
+done
+
+if [ ! $file ] ; then
+	echo $0: no input file
+	exit 1
+fi
+
+# use the preprocessor to find all included files, then
+# get the found definitions from ctags and feed them to
+# the checkheaders.pl backend.
+${CPP} "$@" |
+	grep '^#.*\".*include' |
+	cut -f 2 -d'"' |
+	sort |
+	uniq |
+	ctags --filter --c-kinds=cdefgpstuvx |
+	perl "${srctree}"/scripts/checkheaders.pl "${file}" |
+	sort -k2 -t: -n 1>&2
Index: linux/scripts/checkheaders.pl
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux/scripts/checkheaders.pl	2004-09-12 12:37:22.777599608 +0200
@@ -0,0 +1,193 @@
+#! /usr/bin/perl
+#
+# NAME
+#   scripts/checkheaders.pl
+#
+# COPYRIGHT
+#     Copyright (C) 2004, Arnd Bergmann <arnd@arndb.de>
+#
+#   Based on the code of scripts/checkversion.pl
+#     Copyright (C) 2003, Randy Dunlap <rddunlap@osdl.org>
+#
+# DESCRIPTION
+#   checkheaders find uses of header files that are not actually
+#   needed and headers that are required but not included directly
+#   from a source file. It is a generalized version of both
+#   the checkconfig.pl and checkversion.pl scripts in the linux
+#   source tree.
+#
+#   Names of files to examine are read from the command line, while
+#   a list of definitions to check against is read from standard
+#   input. The format is that of ctags.
+#   Findings are written to standard output.
+#
+# EXAMPLE
+#   ctags --c-kinds=cdefgpstuvx include/linux/*.h -o- | \
+#	perl scripts/checkheaders.pl kernel/*.[ch]
+#
+#     Checks for incorrect use of any header in include/linux
+#     from a file in kernel.
+#
+# SEE ALSO
+#   scripts/checkheaders.sh
+#
+# BUGS
+#   If you use both a large ctags input and a large number of
+#   files, the script will take a long time to finish.
+#
+#   It probably does not work well with ctags implementations
+#   other than exuberant ctags.
+#
+#   The output is not 100% reliable, because the script does
+#   not care about different namespaces for preprocessor
+#   definitions, structures, variables/functions and typedefs.
+#
+#   Identifiers for structure members are ignored because they
+#   frequently clash with local variables.
+#
+#   My perl skills suck. This script is probably not very good
+#   concerning style or performance or even correctness, but it
+#   does the job for me.
+
+$| = 1;
+
+my $debugging = 0;
+my $reportonce = 1;
+my $srctree = $ENV{"srctree"};
+if (!$srctree) {
+    $srctree = ".";
+}
+
+# initialize with information for generated headers
+my %tags;
+$tags{"linux/version.h"} = "LINUX_VERSION_CODE|KERNEL_VERSION|UTS_RELEASE";
+$tags{"linux/config.h"} = "CONFIG_\\W*";
+my @headers = (
+    "linux/version.h",
+    "linux/config.h"
+);
+
+# read tag info from standard input
+while ( <STDIN> )
+{
+    my @line = split /\t/;
+    my $file = $line[1];
+    # skip tags comments
+    if ( m/^!./o ) {
+	next;
+    }
+
+    # normalize the file name: strip everything until a leading
+    # "include/", also replace asm-* includes with plain asm.
+    $file =~ s+.*include2?/++;
+    $file =~ s+asm(-\w*)?\/+asm\/+;
+    # some known substitutions for files that are generally
+    # not included directly
+    $file =~ s/dma-mapping-broken\.h/dma-mapping.h/;
+    $file =~ s/errno-base\.h/errno.h/;
+    $file =~ s/compiler-.*\.h/compiler.h/;
+    $file =~ s/stddef\.h/kernel.h/;
+    $file =~ s/autoconf.h/config.h/;
+    $file =~ s/pda\.h/processor.h/; # work around a bug in ctags.
+
+    # replace "asm/" with "linux/" if a file with the same
+    # name exists there.
+    if ($file =~ m+^asm/+ ) {
+	my $tmp = $file;
+	$tmp =~ s+^asm/(.*)$+linux/\1+;
+	if ( -e "$srctree/include/$tmp") {
+	    $file = $tmp;
+	}
+    }
+
+    # ignore struct member identifiers
+    if ( m/\tm(\t[0-9a-zA-Z_:<>]*)?$/ ) {
+	next;
+    }
+    # match structs as "struct foo" instead of "foo"
+    if ( m/\ts(\t[0-9a-zA-Z_:<>]*)?$/ ) {
+	$line[0] = "struct\\W*$line[0]";
+    }
+    if ( "@headers" !~ m+(^|\W)$file+) {
+	# first identifier for a header
+	@headers = (@headers, $file);
+	$tags{$file} = "$line[0]";
+    } else {
+	# new identifier for a header
+	$tags{$file} = "$tags{$file}|$line[0]";
+    }
+}
+
+# cache compiled regexes
+my %usestrings;
+my %includestrings;
+foreach $header (@headers) {
+    $usestrings{$header} = qr/(\A|\W)($tags{$header})[\Z\W]/;
+    $includestrings{$header} = qr/^\s*#\s*include\s*[\"<]$header[\">]/;
+}
+
+foreach $file (@ARGV)
+{
+  HEADER: foreach $header (@headers) {
+    # Initialize variables.
+    my $usestring = $usestrings{$header};
+    my $includestring = $includestrings{$header};
+    my $fInComment   = 0;
+    my $fInString    = 0;
+    my $fUseHeader   = 0;
+    my $iLine = 0;
+
+    # Open this file.
+    open(FILE, $file) || die "Can't open $file: $!\n";
+
+    LINE: while ( <FILE> )
+    {
+	# Strip comments.
+	$fInComment && (s+^.*?\*/+ +o ? ($fInComment = 0) : next);
+	m+/\*+o && (s+/\*.*?\*/+ +go, (s+/\*.*$+ +o && ($fInComment = 1)));
+
+	# Pick up definitions.
+	if ( m/^\s*#\s*include/o ) {
+	    $iLine = $. if m/$includestring/;
+	}
+
+	# Strip strings.
+	$fInString && (s+^.*?"+ +o ? ($fInString = 0) : next);
+	m+"+o && (s+".*?"+ +go, (s+".*$+ +o && ($fInString = 1))); # "
+
+	# Pick up definitions.
+	if ( m/^\s*#\s*include/o ) {
+	    $iLine = $. if m/$includestring/;
+	    next LINE;
+	}
+
+	if (($_ =~ /$usestring/)) {
+	    if (!$iLine) {
+		# Report uses before or without include
+		$_ =~ s/^.*($usestring).*$/\3/;
+		chomp;
+		print "$file:$.: need $header\: $_\n";
+	    }
+	    $fUseHeader = 1;
+	    last LINE if ($reportonce);
+	}
+    }
+
+    # Report superfluous includes.
+    if ($iLine && ! $fUseHeader) {
+	print "$file:$iLine: $header not needed.\n";
+    }
+
+    # debug: report OK results:
+    if ($debugging) {
+	if (($iLine != 0) && $fUseHeader) {
+	    print "$file:$iLine: $header header use is OK\n";
+	}
+        if (! $iLine && ! $fUseHeader) {
+	    print "$file: $header header use is OK (none)\n";
+        }
+    }
+
+    close(FILE);
+  }
+}

--Boundary-02=_CtFRBULzHG/pVwq
Content-Type: application/pgp-signature
Content-Description: signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBBRFtC5t5GS2LDRf4RAmDNAJ99IB/npfMuXxJoNoKKJhE/LO+IugCglRmF
YTHial3erbG67r3OiA/VHbM=
=kgkV
-----END PGP SIGNATURE-----

--Boundary-02=_CtFRBULzHG/pVwq--
