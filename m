Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261346AbTJAJsi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Oct 2003 05:48:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261354AbTJAJsi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Oct 2003 05:48:38 -0400
Received: from wohnheim.fh-wedel.de ([213.39.233.138]:42467 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S261346AbTJAJse (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Oct 2003 05:48:34 -0400
Date: Wed, 1 Oct 2003 11:48:25 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Sam Ravnborg <sam@ravnborg.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] check headers for complete includes, etc.
Message-ID: <20031001094825.GB31698@wohnheim.fh-wedel.de>
References: <Pine.LNX.4.44.0309281213240.4929-100000@callisto> <Pine.LNX.4.44.0309281035370.6307-100000@home.osdl.org> <20030928184642.GA1681@mars.ravnborg.org> <20030928191622.GA16921@wohnheim.fh-wedel.de> <20030928193150.GA3074@mars.ravnborg.org> <20030928194431.GB16921@wohnheim.fh-wedel.de> <20030929133624.GA14611@wohnheim.fh-wedel.de> <20030929145057.GA1002@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20030929145057.GA1002@mars.ravnborg.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 September 2003 16:50:57 +0200, Sam Ravnborg wrote:
> On Mon, Sep 29, 2003 at 03:36:24PM +0200, Jörn Engel wrote:
> > First version of the script.  Seems to work, but it catches a lot,
> > maybe too much.
> 
> What about adding a negative list, so headerfiles that we decide
> shall not be able to compile stand-alone are filtered away.
> But new headers are added.

New version, picking up suggestions from you, Dominik and Arnd
Bergmann:
- checks all headers from include/linux and include/asm.
- uses nm to find declarations.
- ignores headers that "#define PRAGMA_INDIRECT_HEADER"

If there are no big complaints, I consider this version to be final.

Sam, will you check this and pass it on to Linus?

Jörn

-- 
Mundie uses a textbook tactic of manipulation: start with some
reasonable talk, and lead the audience to an unreasonable conclusion.
-- Bruce Perens

--- /dev/null	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.0-test5/scripts/checkheader.pl	2003-09-30 21:41:14.000000000 +0200
@@ -0,0 +1,54 @@
+#!/usr/bin/perl -w
+use strict;
+
+my $verbose = 1;	# TODO make this optional
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
+my @headers = sort(map({prune($_);}
+	`(cd include/ && find linux -name "*.h" ; find asm/ -name "*.h")`));
+my $basename = "lib/header";
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
--- linux-2.6.0-test5/Makefile~headercheck	2003-09-28 21:37:19.000000000 +0200
+++ linux-2.6.0-test5/Makefile	2003-09-29 15:31:13.000000000 +0200
@@ -838,6 +838,9 @@
 		-name '*.[hcS]' -type f -print | sort \
 		| xargs $(PERL) -w scripts/checkincludes.pl
 
+headercheck:
+	$(PERL) scripts/checkheader.pl
+
 versioncheck:
 	find * $(RCS_FIND_IGNORE) \
 		-name '*.[hcS]' -type f -print | sort \
