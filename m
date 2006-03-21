Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030354AbWCUQVx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030354AbWCUQVx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 11:21:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030385AbWCUQVr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 11:21:47 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:30988 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S1030386AbWCUQVO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 11:21:14 -0500
Cc: Sam Ravnborg <sam@mars.ravnborg.org>, Sam Ravnborg <sam@ravnborg.org>
Subject: [PATCH 46/46] kbuild: remove obsoleted scripts/reference_* files
In-Reply-To: <11429580571883-git-send-email-sam@ravnborg.org>
X-Mailer: git-send-email
Date: Tue, 21 Mar 2006 17:20:57 +0100
Message-Id: <1142958057783-git-send-email-sam@ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Sam Ravnborg <sam@ravnborg.org>
To: lkml <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 7BIT
From: Sam Ravnborg <sam@ravnborg.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The checks performed by scripts/reference_* has been moved to modpost.
Remove the files and their reference in top-level Makefile.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

---

 Makefile                       |    6 --
 scripts/reference_discarded.pl |  112 ----------------------------------------
 scripts/reference_init.pl      |  108 ---------------------------------------
 3 files changed, 0 insertions(+), 226 deletions(-)
 delete mode 100644 scripts/reference_discarded.pl
 delete mode 100644 scripts/reference_init.pl

eae0f536f640bb95f2ad437a57c40c7d5683d1ac
diff --git a/Makefile b/Makefile
index 0c223df..6df94f9 100644
--- a/Makefile
+++ b/Makefile
@@ -1028,8 +1028,6 @@ help:
 	@echo  '  kernelversion	  - Output the version stored in Makefile'
 	@echo  ''
 	@echo  'Static analysers'
-	@echo  '  buildcheck      - List dangling references to vmlinux discarded sections'
-	@echo  '                    and init sections from non-init sections'
 	@echo  '  checkstack      - Generate a list of stack hogs'
 	@echo  '  namespacecheck  - Name space analysis on compiled kernel'
 	@echo  ''
@@ -1255,10 +1253,6 @@ versioncheck:
 		-name '*.[hcS]' -type f -print | sort \
 		| xargs $(PERL) -w scripts/checkversion.pl
 
-buildcheck:
-	$(PERL) $(srctree)/scripts/reference_discarded.pl
-	$(PERL) $(srctree)/scripts/reference_init.pl
-
 namespacecheck:
 	$(PERL) $(srctree)/scripts/namespace.pl
 
diff --git a/scripts/reference_discarded.pl b/scripts/reference_discarded.pl
deleted file mode 100644
index 4ee6ab2..0000000
--- a/scripts/reference_discarded.pl
+++ /dev/null
@@ -1,112 +0,0 @@
-#!/usr/bin/perl -w
-#
-# reference_discarded.pl (C) Keith Owens 2001 <kaos@ocs.com.au>
-#
-# Released under GPL V2.
-#
-# List dangling references to vmlinux discarded sections.
-
-use strict;
-die($0 . " takes no arguments\n") if($#ARGV >= 0);
-
-my %object;
-my $object;
-my $line;
-my $ignore;
-my $errorcount;
-
-$| = 1;
-
-# printf("Finding objects, ");
-open(OBJDUMP_LIST, "find . -name '*.o' | xargs objdump -h |") || die "getting objdump list failed";
-while (defined($line = <OBJDUMP_LIST>)) {
-	chomp($line);
-	if ($line =~ /:\s+file format/) {
-		($object = $line) =~ s/:.*//;
-		$object{$object}->{'module'} = 0;
-		$object{$object}->{'size'} = 0;
-		$object{$object}->{'off'} = 0;
-	}
-	if ($line =~ /^\s*\d+\s+\.modinfo\s+/) {
-		$object{$object}->{'module'} = 1;
-	}
-	if ($line =~ /^\s*\d+\s+\.comment\s+/) {
-		($object{$object}->{'size'}, $object{$object}->{'off'}) = (split(' ', $line))[2,5];
-	}
-}
-close(OBJDUMP_LIST);
-# printf("%d objects, ", scalar keys(%object));
-$ignore = 0;
-foreach $object (keys(%object)) {
-	if ($object{$object}->{'module'}) {
-		++$ignore;
-		delete($object{$object});
-	}
-}
-# printf("ignoring %d module(s)\n", $ignore);
-
-# Ignore conglomerate objects, they have been built from multiple objects and we
-# only care about the individual objects.  If an object has more than one GCC:
-# string in the comment section then it is conglomerate.  This does not filter
-# out conglomerates that consist of exactly one object, can't be helped.
-
-# printf("Finding conglomerates, ");
-$ignore = 0;
-foreach $object (keys(%object)) {
-	if (exists($object{$object}->{'off'})) {
-		my ($off, $size, $comment, $l);
-		$off = hex($object{$object}->{'off'});
-		$size = hex($object{$object}->{'size'});
-		open(OBJECT, "<$object") || die "cannot read $object";
-		seek(OBJECT, $off, 0) || die "seek to $off in $object failed";
-		$l = read(OBJECT, $comment, $size);
-		die "read $size bytes from $object .comment failed" if ($l != $size);
-		close(OBJECT);
-		if ($comment =~ /GCC\:.*GCC\:/m || $object =~ /built-in\.o/) {
-			++$ignore;
-			delete($object{$object});
-		}
-	}
-}
-# printf("ignoring %d conglomerate(s)\n", $ignore);
-
-# printf("Scanning objects\n");
-
-# Keith Ownes <kaos@sgi.com> commented:
-# For our future {in}sanity, add a comment that this is the ppc .opd
-# section, not the ia64 .opd section.
-# ia64 .opd should not point to discarded sections.
-$errorcount = 0;
-foreach $object (keys(%object)) {
-	my $from;
-	open(OBJDUMP, "objdump -r $object|") || die "cannot objdump -r $object";
-	while (defined($line = <OBJDUMP>)) {
-		chomp($line);
-		if ($line =~ /RELOCATION RECORDS FOR /) {
-			($from = $line) =~ s/.*\[([^]]*).*/$1/;
-		}
-		if (($line =~ /\.text\.exit$/ ||
-		     $line =~ /\.exit\.text$/ ||
-		     $line =~ /\.data\.exit$/ ||
-		     $line =~ /\.exit\.data$/ ||
-		     $line =~ /\.exitcall\.exit$/) &&
-		    ($from !~ /\.text\.exit$/ &&
-		     $from !~ /\.exit\.text$/ &&
-		     $from !~ /\.data\.exit$/ &&
-		     $from !~ /\.opd$/ &&
-		     $from !~ /\.exit\.data$/ &&
-		     $from !~ /\.altinstructions$/ &&
-		     $from !~ /\.pdr$/ &&
-		     $from !~ /\.debug_.*$/ &&
-		     $from !~ /\.exitcall\.exit$/ &&
-		     $from !~ /\.eh_frame$/ &&
-		     $from !~ /\.stab$/)) {
-			printf("Error: %s %s refers to %s\n", $object, $from, $line);
-			$errorcount = $errorcount + 1;
-		}
-	}
-	close(OBJDUMP);
-}
-# printf("Done\n");
-
-exit(0);
diff --git a/scripts/reference_init.pl b/scripts/reference_init.pl
deleted file mode 100644
index 7f6960b..0000000
--- a/scripts/reference_init.pl
+++ /dev/null
@@ -1,108 +0,0 @@
-#!/usr/bin/perl -w
-#
-# reference_init.pl (C) Keith Owens 2002 <kaos@ocs.com.au>
-#
-# List references to vmlinux init sections from non-init sections.
-
-# Unfortunately I had to exclude references from read only data to .init
-# sections, almost all of these are false positives, they are created by
-# gcc.  The downside of excluding rodata is that there really are some
-# user references from rodata to init code, e.g. drivers/video/vgacon.c
-#
-# const struct consw vga_con = {
-#        con_startup:            vgacon_startup,
-#
-# where vgacon_startup is __init.  If you want to wade through the false
-# positives, take out the check for rodata.
-
-use strict;
-die($0 . " takes no arguments\n") if($#ARGV >= 0);
-
-my %object;
-my $object;
-my $line;
-my $ignore;
-
-$| = 1;
-
-printf("Finding objects, ");
-open(OBJDUMP_LIST, "find . -name '*.o' | xargs objdump -h |") || die "getting objdump list failed";
-while (defined($line = <OBJDUMP_LIST>)) {
-	chomp($line);
-	if ($line =~ /:\s+file format/) {
-		($object = $line) =~ s/:.*//;
-		$object{$object}->{'module'} = 0;
-		$object{$object}->{'size'} = 0;
-		$object{$object}->{'off'} = 0;
-	}
-	if ($line =~ /^\s*\d+\s+\.modinfo\s+/) {
-		$object{$object}->{'module'} = 1;
-	}
-	if ($line =~ /^\s*\d+\s+\.comment\s+/) {
-		($object{$object}->{'size'}, $object{$object}->{'off'}) = (split(' ', $line))[2,5];
-	}
-}
-close(OBJDUMP_LIST);
-printf("%d objects, ", scalar keys(%object));
-$ignore = 0;
-foreach $object (keys(%object)) {
-	if ($object{$object}->{'module'}) {
-		++$ignore;
-		delete($object{$object});
-	}
-}
-printf("ignoring %d module(s)\n", $ignore);
-
-# Ignore conglomerate objects, they have been built from multiple objects and we
-# only care about the individual objects.  If an object has more than one GCC:
-# string in the comment section then it is conglomerate.  This does not filter
-# out conglomerates that consist of exactly one object, can't be helped.
-
-printf("Finding conglomerates, ");
-$ignore = 0;
-foreach $object (keys(%object)) {
-	if (exists($object{$object}->{'off'})) {
-		my ($off, $size, $comment, $l);
-		$off = hex($object{$object}->{'off'});
-		$size = hex($object{$object}->{'size'});
-		open(OBJECT, "<$object") || die "cannot read $object";
-		seek(OBJECT, $off, 0) || die "seek to $off in $object failed";
-		$l = read(OBJECT, $comment, $size);
-		die "read $size bytes from $object .comment failed" if ($l != $size);
-		close(OBJECT);
-		if ($comment =~ /GCC\:.*GCC\:/m || $object =~ /built-in\.o/) {
-			++$ignore;
-			delete($object{$object});
-		}
-	}
-}
-printf("ignoring %d conglomerate(s)\n", $ignore);
-
-printf("Scanning objects\n");
-foreach $object (sort(keys(%object))) {
-	my $from;
-	open(OBJDUMP, "objdump -r $object|") || die "cannot objdump -r $object";
-	while (defined($line = <OBJDUMP>)) {
-		chomp($line);
-		if ($line =~ /RELOCATION RECORDS FOR /) {
-			($from = $line) =~ s/.*\[([^]]*).*/$1/;
-		}
-		if (($line =~ /\.init$/ || $line =~ /\.init\./) &&
-		    ($from !~ /\.init$/ &&
-		     $from !~ /\.init\./ &&
-		     $from !~ /\.stab$/ &&
-		     $from !~ /\.rodata$/ &&
-		     $from !~ /\.text\.lock$/ &&
-		     $from !~ /\.pci_fixup_header$/ &&
-		     $from !~ /\.pci_fixup_final$/ &&
-		     $from !~ /\.pdr$/ &&
-		     $from !~ /\__param$/ &&
-		     $from !~ /\.altinstructions/ &&
-		     $from !~ /\.eh_frame/ &&
-		     $from !~ /\.debug_/)) {
-			printf("Error: %s %s refers to %s\n", $object, $from, $line);
-		}
-	}
-	close(OBJDUMP);
-}
-printf("Done\n");
-- 
1.0.GIT


