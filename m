Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263368AbTI2Ngi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Sep 2003 09:36:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263369AbTI2Ngi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Sep 2003 09:36:38 -0400
Received: from wohnheim.fh-wedel.de ([213.39.233.138]:43412 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S263368AbTI2Ngf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Sep 2003 09:36:35 -0400
Date: Mon, 29 Sep 2003 15:36:24 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Sam Ravnborg <sam@ravnborg.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, Russell King <rmk@arm.linux.org.uk>,
       Jamie Lokier <jamie@shareable.org>
Subject: [PATCH] check headers for complete includes, etc.
Message-ID: <20030929133624.GA14611@wohnheim.fh-wedel.de>
References: <Pine.LNX.4.44.0309281213240.4929-100000@callisto> <Pine.LNX.4.44.0309281035370.6307-100000@home.osdl.org> <20030928184642.GA1681@mars.ravnborg.org> <20030928191622.GA16921@wohnheim.fh-wedel.de> <20030928193150.GA3074@mars.ravnborg.org> <20030928194431.GB16921@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20030928194431.GB16921@wohnheim.fh-wedel.de>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 28 September 2003 21:44:31 +0200, Jörn Engel wrote:
> On Sun, 28 September 2003 21:31:50 +0200, Sam Ravnborg wrote:
> > 
> > That should do it. Can you also integrate the check Linus mentioned,
> > to make sure no declarations are present.
> 
> If it's simple enough, you'll have it tomorrow.  Linus' check might
> take a bit longer, I'm not sure yet how to define an empty object
> file.  Is it enough if objdump -tT only shows sections?
> 
> > I would name the target: headercheck:
> > to be consistent with the other targets.
> 
> ok.

First version of the script.  Seems to work, but it catches a lot,
maybe too much.

Jörn

-- 
"Error protection by error detection and correction."
-- from a university class

--- /dev/null	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.0-test5/scripts/checkheader.pl	2003-09-29 15:33:10.000000000 +0200
@@ -0,0 +1,43 @@
+#!/usr/bin/perl -w
+use strict;
+
+my $normsymbols = "^\n"
+		. "lib/header.o:     file format elf32-i386\n"
+		. "\n"
+		. "SYMBOL TABLE:\n"
+		. "00000000 l    df \\*ABS\\*	00000000 header.c\n"
+		. "00000000 l    d  .text	00000000 \n"
+		. "00000000 l    d  .data	00000000 \n"
+		. "00000000 l    d  .bss	00000000 \n"
+		. "00000000 l    d  .comment	00000000 \n"
+		. "\n"
+		. "\n\$";
+
+#my @headers = ("linux/fs.h");
+my @headers = sort(split(/\n/, `(cd include/ && find linux -name "*.h")`));
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
+		next;
+	}
+
+	my $symbols = `objdump -t $basename.o`;
+	if ($symbols !~ /$normsymbols/) {
+		print("WARNING: Symbols may be declared: $h\n");
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
