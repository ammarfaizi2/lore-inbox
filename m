Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262403AbTJBIhi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Oct 2003 04:37:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263264AbTJBIhi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Oct 2003 04:37:38 -0400
Received: from wohnheim.fh-wedel.de ([213.39.233.138]:49029 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S262403AbTJBIhf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Oct 2003 04:37:35 -0400
Date: Thu, 2 Oct 2003 10:37:28 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Sam Ravnborg <sam@ravnborg.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH v4] check headers for complete includes, etc.
Message-ID: <20031002083728.GA10382@wohnheim.fh-wedel.de>
References: <20030928184642.GA1681@mars.ravnborg.org> <20030928191622.GA16921@wohnheim.fh-wedel.de> <20030928193150.GA3074@mars.ravnborg.org> <20030928194431.GB16921@wohnheim.fh-wedel.de> <20030929133624.GA14611@wohnheim.fh-wedel.de> <20030929145057.GA1002@mars.ravnborg.org> <20031001094825.GB31698@wohnheim.fh-wedel.de> <20031001163930.GA11493@mars.ravnborg.org> <20031001180114.GA9657@wohnheim.fh-wedel.de> <20031001210926.GA1011@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20031001210926.GA1011@mars.ravnborg.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 October 2003 23:09:26 +0200, Sam Ravnborg wrote:
> On Wed, Oct 01, 2003 at 08:01:14PM +0200, Jörn Engel wrote:
> > 
> > Doesn't work in include/, there is no include/Makefile.  But lib/ is a
> > hack, I agree.
> 
> Sigh, OK.

Things can be so simple: touch include/Makefile :)

> > > So we need something like the following here: (untested)
> > > >  
> > > > +headercheck: prepare-all
> > > > +	$(PERL) scripts/checkheader.pl $(if $(KBUILD_VERBOSE),-verbose)
> > > > +
> 
> Forgot that KBUILD_VERBOSE is always defined.
> Try:
> $(if $(KBUILD_VERBOSE:0=),--verbose)

Works, except for one oddity/bug.  Not defining V=something on the
command line sets KBUILD_VERBOSE = "0 ".  Note the space behind the 0.
Suggestions?

> prepare-all exist in BK-latest.
> The purpose is to create the asm-$(ARCH) -> asm symlink.
> Add an dependency on include/asm, that should do it.

Too lazy to move to BK-Latest for now.  Dependency on include/asm it
is. :)

One more thing: Since the Makefile target is *check, not check*, I've
renamed the script to headercheck.pl.  This is inconsistent with the
existing scripts, but makes more sense to me.  Hope you don't mind.

Jörn

-- 
Time? What's that? Time is only worth what you do with it.
-- Theo de Raadt

--- /dev/null	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.0-test5/scripts/headercheck.pl	2003-10-02 10:27:54.000000000 +0200
@@ -0,0 +1,65 @@
+#!/usr/bin/perl -w
+use strict;
+use Getopt::Long;
+
+Getopt::Long::Configure("no_auto_abbrev");	# Could cause unexpected things
+Getopt::Long::Configure("bundling");		# We want -sA to work
+Getopt::Long::Configure("no_ignore_case");	# We don't want -a == -A
+
+my $verbose = 0;
+
+GetOptions('v|verbose' => \$verbose) || die("bad options");
+
+
+sub prune($)
+{
+	my $h = shift;
+	chomp($h);
+	open(HDR, "include/$h")
+		or return;
+	while (<HDR>) {
+		if ($_ =~ /^#\s*define\s+PRAGMA_INDIRECT_HEADER\s/) {
+			return;
+		}
+	}
+	close(HDR);
+	return $h;
+}
+
+my @headers = sort(map({prune($_);} `(cd include/ &&
+	[ -d linux/ ] && find linux/ -name "*.h" &&
+	[ -d asm/ ] && find asm/ -name "*.h")`)); # XXX this is fragile
+my $basename = "include/headercheck";
+system("touch", "include/Makefile");
+
+foreach my $h (@headers) {
+	close(STDERR);
+	open(STDERR, ">", "$basename.err");
+
+	open(HC, '>', "$basename.c");
+	print(HC "#include <$h>\n");
+	close(HC);
+
+	# tests
+	if (system("make", "$basename.o") != 0) {
+		print("WARNING: header doesn't build standalone: $h\n");
+		if ($verbose) {
+			system("cat", "$basename.err");
+		}
+		next;
+	}
+
+	my $symbols = `nm $basename.o`;
+	if ($symbols !~ /^$/) {
+		print("WARNING: Symbols may be declared: $h:\n");
+		if ($verbose) {
+			print("$symbols");
+		}
+	}
+} continue {
+	# cleanup
+	unlink("$basename.c");
+	unlink("$basename.err");
+	unlink("$basename.o");
+}
+unlink("system/Makefile");
--- linux-2.6.0-test5/Makefile~headercheck	2003-10-02 10:27:19.000000000 +0200
+++ linux-2.6.0-test5/Makefile	2003-10-02 10:35:27.000000000 +0200
@@ -833,6 +833,9 @@
 		-name '*.[hcS]' -type f -print | sort \
 		| xargs $(PERL) -w scripts/checkconfig.pl
 
+headercheck: include/asm
+	$(PERL) scripts/headercheck.pl $(if $(KBUILD_VERBOSE:0=),--verbose)
+
 includecheck:
 	find * $(RCS_FIND_IGNORE) \
 		-name '*.[hcS]' -type f -print | sort \
