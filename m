Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314491AbSEMWLR>; Mon, 13 May 2002 18:11:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314496AbSEMWLQ>; Mon, 13 May 2002 18:11:16 -0400
Received: from [64.76.155.18] ([64.76.155.18]:27606 "EHLO alumno.inacap.cl")
	by vger.kernel.org with ESMTP id <S314491AbSEMWLN>;
	Mon, 13 May 2002 18:11:13 -0400
Date: Mon, 13 May 2002 18:05:48 -0400 (CLT)
From: Robinson Maureira Castillo <rmaureira@alumno.inacap.cl>
To: Tomas Szepe <szepe@pinerecords.com>
cc: Marcus Alanen <maalanen@ra.abo.fi>, <matthias.andree@gmx.de>,
        <riel@conectiva.com.br>, Johnny Mnemonic <johnny@themnemonic.org>,
        <linux-kernel@vger.kernel.org>, Russell King <rmk@arm.linux.org.uk>
Subject: Re: Changelogs on kernel.org
In-Reply-To: <20020513144519.GC5134@louise.pinerecords.com>
Message-ID: <Pine.LNX.4.44.0205131759480.5254-100000@alumno.inacap.cl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 May 2002, Tomas Szepe wrote:

> > > Somebody make the mode changeable via command-line option...
> > 
> > Done... in a slightly different manner :)
> > 
> > cl:
> > - clean up
> > - indentation
> > - CMODE environment variable
> > 
> > ./fmt /usr/src/ChangeLog-2.5.14			gives output in orig. mode
> > CMODE=2 ./fmt /usr/src/ChangeLog-2.5.14		gives output in orig. mode
> > CMODE=1 ./fmt /usr/src/ChangeLog-2.5.14		gives output in full mode
> > CMODE=0 ./fmt /usr/src/ChangeLog-2.5.14		gives output in terse mode
> 
> Version 0.91.
> 	- Add a missing "last;" statement (major major speedup! :D)
> 	- Add a couple comments
> 	- More indentation changes and cleanups
> 
> 

What do you think about this patch for a 0.92 version?

- Added an usage note
- Changed CMODE environment variable for a command line argument

Best regards
Robinson Maureira C.

--- fmclog.pl.orig	Mon May 13 17:56:35 2002
+++ fmclog.pl	Mon May 13 17:55:13 2002
@@ -5,9 +5,13 @@
 #
 # (C) Copyright 2002 by Matthias Andree <matthias.andree@gmx.de>,
 #			Marcus Alanen <maalanen@abo.fi>,
-#			Tomas Szepe <szepe@pinerecords.com>
+#			Tomas Szepe <szepe@pinerecords.com>,
+#			Robinson Maureira <rmaureira@alumno.inacap.cl>
+#
+# Version 0.92.
+#
+# Changed use of an environment variable for a command line argument
 #
-# Version 0.91.
 # (Please don't bump this if you've just added another email-to-name
 # mapping entry to the db.)
 #
@@ -47,20 +51,23 @@
 
 use strict;
 
-# CMODE environment variable selects output mode:
-# 0 for short, 1 for full, 2 for "original changelog"
-# (default is 2 if $CMODE unset)
-#
+# Dump usage if we get no arguments
+
+die "Usage $0 [-n] <Changelog file>\nThis Perl script is meant to simplify/beautify BK ChangeLogs\nfor the linux kernel\n\nn\tFormat for the output\n\t0 - Short mode (one changelog == one line)\n\t1 - Full mode (changelogs separated by dashed line)\n\t2 - Original mode (one line consisting of changelog and author)[DEFAULT]\n" unless defined $ARGV[0];
+
+# Check if we received an argument for the mode
+# If we do, we set $mode properly an set the apropiate name for $fd
+# Also, we default to $mode = 2 and $fd being the first parameter
+# TODO: Check for a non-numeric character in $mode
+
 my $mode = 2;
-foreach my $en (keys(%ENV)) {
-	if ($en eq "CMODE") {
-		$mode = $ENV{CMODE};
-		if ($mode ne "0" && $mode ne "1" && $mode ne "2") {
-			print "CMODE has to be 0 for short, 1 for full, 2 for orig. Undefined defaults to 2.\n";
-			die();
-		}
-		last;
-	}
+my $fd = $ARGV[0];
+
+if (grep(/^-/,$ARGV[0])) {
+	$mode = $ARGV[0];
+	$mode =~ s/-//;
+	$mode = 2 if ($mode > 2);
+	$fd = $ARGV[1];
 }
 
 # minimum space between entry and author for the original mode
@@ -160,7 +167,9 @@
 	}
 }
 
-while (<>)
+open FD,$fd;
+
+while (<FD>)
 {
 	# Match address
 	if (/^<([^>]+)>/) {
@@ -177,6 +186,8 @@
 		print;
 	}
 }
+
+close(FD);
 append_item();
 
 # Print the information


