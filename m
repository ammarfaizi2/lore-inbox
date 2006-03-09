Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751939AbWCIPkd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751939AbWCIPkd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 10:40:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752002AbWCIPkd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 10:40:33 -0500
Received: from ftp.linux-mips.org ([194.74.144.162]:37272 "EHLO
	ftp.linux-mips.org") by vger.kernel.org with ESMTP id S1751939AbWCIPkd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 10:40:33 -0500
Date: Thu, 9 Mar 2006 15:40:30 +0000
From: Ralf Baechle <ralf@linux-mips.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] Fix scripts/namespace.pl portability
Message-ID: <20060309154030.GA14682@linux-mips.org>
References: <20060309130150.GA10275@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060309130150.GA10275@linux-mips.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 09, 2006 at 01:01:50PM +0000, Ralf Baechle wrote:

> scripts/namespace.pl was assuming the nm and objdump tools to use are
> always just named that which breaks things in a crosscompilation
> environment.
> 
> Fixed by honouring $NM and $OBJDUMP if passed by make, otherwise
> defaulting to just nm rsp. objdump just as we used to.
> 
> Signed-off-by: Ralf Baechle <ralf@linux-mips.org>

Atsushi Nemoto pointed me to http://lkml.org/lkml/2005/9/20/68.  This
old patch which seems more complete than mine but made it into the kernel.
 I just refreshed the patch and added the bits to ensure namespace.pl
uses the right nm binary also - Keith's original patch only fixed the
objdump use.

From: Keith Owens <kaos@ocs.com.au>

Those scripts are meant to work even when they are invoked by hand,
without OBJDUMP being defined in the environment.  This is the correct
fix.

Signed-off-by: Keith Owens <kaos@ocs.com.au>
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>

---
 scripts/namespace.pl           |   16 ++++++++++++++--
 scripts/reference_discarded.pl |   10 ++++++++--
 scripts/reference_init.pl      |   10 ++++++++--
 3 files changed, 30 insertions(+), 6 deletions(-)

Index: linux-mips/scripts/namespace.pl
===================================================================
--- linux-mips.orig/scripts/namespace.pl	2006-03-09 15:27:52.000000000 +0000
+++ linux-mips/scripts/namespace.pl	2006-03-09 15:33:59.000000000 +0000
@@ -66,12 +66,24 @@ require 5;	# at least perl 5
 use strict;
 use File::Find;
 
-my $nm = "/usr/bin/nm -p";
-my $objdump = "/usr/bin/objdump -s -j .comment";
 my $srctree = "";
 my $objtree = "";
 $srctree = "$ENV{'srctree'}/" if (exists($ENV{'srctree'}));
 $objtree = "$ENV{'objtree'}/" if (exists($ENV{'objtree'}));
+my $nm;
+if (exists($ENV{'NM'})) {
+	$nm = $ENV{'NM'};
+} else {
+	$nm = 'nm';
+}
+$nm .= ' -p';
+my $objdump;
+if (exists($ENV{'OBJDUMP'})) {
+	$objdump = $ENV{'OBJDUMP'};
+} else {
+	$objdump = 'objdump';
+}
+$objdump .= ' -s -j .comment';
 
 if ($#ARGV != -1) {
 	print STDERR "usage: $0 takes no parameters\n";
Index: linux-mips/scripts/reference_discarded.pl
===================================================================
--- linux-mips.orig/scripts/reference_discarded.pl	2006-02-20 21:48:11.000000000 +0000
+++ linux-mips/scripts/reference_discarded.pl	2006-03-09 15:28:02.000000000 +0000
@@ -14,11 +14,17 @@ my $object;
 my $line;
 my $ignore;
 my $errorcount;
+my $objdump;
+if (exists($ENV{'OBJDUMP'})) {
+	$objdump = $ENV{'OBJDUMP'};
+} else {
+	$objdump = 'objdump';
+}
 
 $| = 1;
 
 # printf("Finding objects, ");
-open(OBJDUMP_LIST, "find . -name '*.o' | xargs objdump -h |") || die "getting objdump list failed";
+open(OBJDUMP_LIST, "find . -name '*.o' | xargs $objdump -h |") || die "getting objdump list failed";
 while (defined($line = <OBJDUMP_LIST>)) {
 	chomp($line);
 	if ($line =~ /:\s+file format/) {
@@ -79,7 +85,7 @@ foreach $object (keys(%object)) {
 $errorcount = 0;
 foreach $object (keys(%object)) {
 	my $from;
-	open(OBJDUMP, "objdump -r $object|") || die "cannot objdump -r $object";
+	open(OBJDUMP, "$objdump -r $object|") || die "cannot objdump -r $object";
 	while (defined($line = <OBJDUMP>)) {
 		chomp($line);
 		if ($line =~ /RELOCATION RECORDS FOR /) {
Index: linux-mips/scripts/reference_init.pl
===================================================================
--- linux-mips.orig/scripts/reference_init.pl	2006-02-20 21:48:11.000000000 +0000
+++ linux-mips/scripts/reference_init.pl	2006-03-09 15:28:02.000000000 +0000
@@ -22,11 +22,17 @@ my %object;
 my $object;
 my $line;
 my $ignore;
+my $objdump;
+if (exists($ENV{'OBJDUMP'})) {
+	$objdump = $ENV{'OBJDUMP'};
+} else {
+	$objdump = 'objdump';
+}
 
 $| = 1;
 
 printf("Finding objects, ");
-open(OBJDUMP_LIST, "find . -name '*.o' | xargs objdump -h |") || die "getting objdump list failed";
+open(OBJDUMP_LIST, "find . -name '*.o' | xargs $objdump -h |") || die "getting objdump list failed";
 while (defined($line = <OBJDUMP_LIST>)) {
 	chomp($line);
 	if ($line =~ /:\s+file format/) {
@@ -81,7 +87,7 @@ printf("ignoring %d conglomerate(s)\n", 
 printf("Scanning objects\n");
 foreach $object (sort(keys(%object))) {
 	my $from;
-	open(OBJDUMP, "objdump -r $object|") || die "cannot objdump -r $object";
+	open(OBJDUMP, "$objdump -r $object|") || die "cannot objdump -r $object";
 	while (defined($line = <OBJDUMP>)) {
 		chomp($line);
 		if ($line =~ /RELOCATION RECORDS FOR /) {
