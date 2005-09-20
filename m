Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964909AbVITI3M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964909AbVITI3M (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Sep 2005 04:29:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964910AbVITI3M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Sep 2005 04:29:12 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:27273 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S964909AbVITI3L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Sep 2005 04:29:11 -0400
X-Mailer: exmh version 2.6.3_20040314 03/14/2004 with nmh-1.1
From: Keith Owens <kaos@ocs.com.au>
To: Ben Dooks <ben-linux@fluff.org>
cc: linux-kernel@vger.kernel.org, patch-out@fluff.rog
Subject: Re: [PATCH] scripts - use $OBJDUMP to get correct objdump (cross compile) 
In-reply-to: Your message of "Mon, 19 Sep 2005 22:06:45 +0100."
             <20050919210645.GA20669@home.fluff.org> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 20 Sep 2005 18:28:49 +1000
Message-ID: <12002.1127204929@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Sep 2005 22:06:45 +0100, 
Ben Dooks <ben-linux@fluff.org> wrote:
>The scripts for `make buildcheck` are executing
>objdump straight, which is wrong if the system
>is using `make CROSS_COMPILE=....`. 
>
>Change the scripts to use $OBJDUMP passed from
>the Makefile's environment, so that the correct
>objdump is used, and the symbols are printed
>correctly

Those scripts are meant to work even when they are invoked by hand,
without OBJDUMP being defined in the environment.  This is the correct
fix.

Signed-off-by: Keith Owens <kaos@ocs.com.au>

Index: linux/scripts/namespace.pl
===================================================================
--- linux.orig/scripts/namespace.pl	2005-08-29 09:41:01.000000000 +1000
+++ linux/scripts/namespace.pl	2005-09-20 18:25:12.124090186 +1000
@@ -67,11 +67,17 @@ use strict;
 use File::Find;
 
 my $nm = "/usr/bin/nm -p";
-my $objdump = "/usr/bin/objdump -s -j .comment";
 my $srctree = "";
 my $objtree = "";
 $srctree = "$ENV{'srctree'}/" if (exists($ENV{'srctree'}));
 $objtree = "$ENV{'objtree'}/" if (exists($ENV{'objtree'}));
+my $objdump;
+if (exists($ENV{'OBJDUMP'})) {
+	$objdump = $ENV{'OBJDUMP'};
+} else {
+	$objdump = 'objdump';
+}
+$objdump .= ' -s -j .comment';
 
 if ($#ARGV != -1) {
 	print STDERR "usage: $0 takes no parameters\n";
Index: linux/scripts/reference_discarded.pl
===================================================================
--- linux.orig/scripts/reference_discarded.pl	2005-09-20 16:36:32.095627904 +1000
+++ linux/scripts/reference_discarded.pl	2005-09-20 18:22:00.117517858 +1000
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
@@ -74,7 +80,7 @@ foreach $object (keys(%object)) {
 $errorcount = 0;
 foreach $object (keys(%object)) {
 	my $from;
-	open(OBJDUMP, "objdump -r $object|") || die "cannot objdump -r $object";
+	open(OBJDUMP, "$objdump -r $object|") || die "cannot objdump -r $object";
 	while (defined($line = <OBJDUMP>)) {
 		chomp($line);
 		if ($line =~ /RELOCATION RECORDS FOR /) {
Index: linux/scripts/reference_init.pl
===================================================================
--- linux.orig/scripts/reference_init.pl	2005-09-20 16:36:32.095627904 +1000
+++ linux/scripts/reference_init.pl	2005-09-20 18:24:14.060854489 +1000
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

