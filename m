Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261500AbTJASBY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Oct 2003 14:01:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262412AbTJASBY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Oct 2003 14:01:24 -0400
Received: from wohnheim.fh-wedel.de ([213.39.233.138]:52149 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S261500AbTJASBU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Oct 2003 14:01:20 -0400
Date: Wed, 1 Oct 2003 20:01:14 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Sam Ravnborg <sam@ravnborg.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH v3] check headers for complete includes, etc.
Message-ID: <20031001180114.GA9657@wohnheim.fh-wedel.de>
References: <Pine.LNX.4.44.0309281213240.4929-100000@callisto> <Pine.LNX.4.44.0309281035370.6307-100000@home.osdl.org> <20030928184642.GA1681@mars.ravnborg.org> <20030928191622.GA16921@wohnheim.fh-wedel.de> <20030928193150.GA3074@mars.ravnborg.org> <20030928194431.GB16921@wohnheim.fh-wedel.de> <20030929133624.GA14611@wohnheim.fh-wedel.de> <20030929145057.GA1002@mars.ravnborg.org> <20031001094825.GB31698@wohnheim.fh-wedel.de> <20031001163930.GA11493@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20031001163930.GA11493@mars.ravnborg.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 October 2003 18:39:30 +0200, Sam Ravnborg wrote:
> On Wed, Oct 01, 2003 at 11:48:25AM +0200, Jörn Engel wrote:
> > 
> > +my $verbose = 1;	# TODO make this optional
> Could you make this controlable with option -verbose, see below.

-v or --verbose

> > +my @headers = sort(map({prune($_);}
> > +	`(cd include/ && find linux -name "*.h" ; find asm/ -name "*.h")`));
> 1) you uses include but asm/ - use final '/' for consistency.
> 2) Using asm/ you require the symlink to be present. Which obvious
> it a most when  doing this check, so we better secure that.

A bit better now, but still not too nice.

> > +my $basename = "lib/header";
> I much rather have it be: include/headercheck
> then people realise where eventual temporary files comes from.

Doesn't work in include/, there is no include/Makefile.  But lib/ is a
hack, I agree.

> So we need something like the following here: (untested)
> >  
> > +headercheck: prepare-all
> > +	$(PERL) scripts/checkheader.pl $(if $(KBUILD_VERBOSE),-verbose)
> > +

What is prepare-all supposed to do?  Target doesn't exist.
Changed option to --verbose, see above.

make headercheck, make V=0 headercheck and make V=1 headercheck are
all verbose.  Is this intended?

Jörn

-- 
Victory in war is not repetitious.
-- Sun Tzu

--- /dev/null	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.0-test5/scripts/checkheader.pl	2003-10-01 19:54:26.000000000 +0200
@@ -0,0 +1,63 @@
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
+my $basename = "lib/headercheck";
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
--- linux-2.6.0-test5/Makefile~headercheck	2003-10-01 19:48:46.000000000 +0200
+++ linux-2.6.0-test5/Makefile	2003-10-01 19:53:38.000000000 +0200
@@ -833,6 +833,9 @@
 		-name '*.[hcS]' -type f -print | sort \
 		| xargs $(PERL) -w scripts/checkconfig.pl
 
+headercheck:
+	$(PERL) scripts/checkheader.pl $(if $(KBUILD_VERBOSE),--verbose)
+
 includecheck:
 	find * $(RCS_FIND_IGNORE) \
 		-name '*.[hcS]' -type f -print | sort \
