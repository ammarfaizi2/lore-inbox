Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262092AbUJZBuO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262092AbUJZBuO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 21:50:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262091AbUJZBsn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 21:48:43 -0400
Received: from zeus.kernel.org ([204.152.189.113]:25045 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S261899AbUJZBU5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 21:20:57 -0400
Date: Mon, 25 Oct 2004 19:47:36 -0400
From: Ryan Anderson <ryan@michonline.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Len Brown <len.brown@intel.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Versioning of tree
Message-ID: <20041025234736.GF10638@michonline.com>
Mail-Followup-To: Linus Torvalds <torvalds@osdl.org>,
	Len Brown <len.brown@intel.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Linux Kernel list <linux-kernel@vger.kernel.org>
References: <1098254970.3223.6.camel@gaston> <1098256951.26595.4296.camel@d845pe> <Pine.LNX.4.58.0410200728040.2317@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0410200728040.2317@ppc970.osdl.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 20, 2004 at 07:33:47AM -0700, Linus Torvalds wrote:
> Personally, I much rather go the way we have gone, because I don't care
> about module versioning nearly as much as I care about bug-report
> versioning. And if I hear about a bug with 2.6.10-rc1, I want to know that
> it really is at _least_ 2.6.10-rc1, if you see what I mean..

Well, here's a patch that adds -BKxxxxxxxx to LOCALVERSION when a
top-level BitKeeper tree is detected.

Signed-off-by: Ryan Anderson <ryan@michonline.com>


diff -Nru a/Makefile b/Makefile
--- a/Makefile	2004-10-25 19:45:55 -04:00
+++ b/Makefile	2004-10-25 19:45:55 -04:00
@@ -149,6 +149,12 @@
 # careful not to include files twice if building in the source
 # directory. LOCALVERSION from the command line override all of this
 
+ifeq ($(shell ls -d $(srctree)/BitKeeper 2>/dev/null),$(srctree)/BitKeeper)
+localversion-bk := $(shell perl $(srctree)/scripts/setlocalversion $(srctree) $(objtree))
+else
+localversion-bk :=
+endif
+
 ifeq ($(objtree),$(srctree))
 localversion-files := $(wildcard $(srctree)/localversion*)
 else
@@ -157,6 +163,7 @@
 
 LOCALVERSION = $(subst $(space),, \
 	       $(shell cat /dev/null $(localversion-files)) \
+	       $(subst ",,$(localversion-bk)) \
 	       $(subst ",,$(CONFIG_LOCALVERSION)))
 
 KERNELRELEASE=$(VERSION).$(PATCHLEVEL).$(SUBLEVEL)$(EXTRAVERSION)$(LOCALVERSION)
diff -Nru a/scripts/setlocalversion b/scripts/setlocalversion
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/scripts/setlocalversion	2004-10-25 19:45:55 -04:00
@@ -0,0 +1,62 @@
+#!/usr/bin/perl
+# Copyright 2004 - Ryan Anderson <ryan@michonline.com>  GPL v2
+
+use strict;
+use warnings;
+use Digest::MD5;
+require 5.006;
+
+if (@ARGV != 2) {
+	print <<EOT;
+Usage: setlocalversion <srctree> <objtree>
+EOT
+	exit(1);
+}
+
+my $debug = 0;
+
+my ($srctree,$objtree) = @ARGV;
+
+my @LOCALVERSIONS = ();
+
+# BitKeeper Version Checks
+
+# We are going to use the following commands to try and determine if
+# this repository is at a Version boundary (i.e, 2.6.10 vs 2.6.10 + some patches)
+# We currently assume that all meaningful version boundaries are marked by a tag.
+# We don't care what the tag is, just that something exists.
+
+#ryan@mythryan2 ~/dev/linux/local$ T=`bk changes -r+ -k`
+#ryan@mythryan2 ~/dev/linux/local$ bk prs -h -d':TAG:\n' -r$T
+
+sub do_bk_checks {
+	chdir($srctree);
+	my $changeset = `bk changes -r+ -k`;
+	chomp $changeset;
+	my $tag = `bk prs -h -d':TAG:' -r'$changeset'`;
+
+	printf("ChangeSet Key = '%s'\nTAG = '%s'\n", $changeset, $tag) if ($debug > 0);
+
+	if (length($tag) == 0) {
+		# We do not have a tag at the Top of Tree, so we need to generate a localversion file
+		# We'll use the given $changeset as input into this.
+		my $localversion = Digest::MD5::md5_hex($changeset);
+		$localversion = substr($localversion,0,8);
+
+		printf("localversion = '%s'\n",$localversion) if ($debug > 0);
+
+		push @LOCALVERSIONS, "BK" . $localversion;
+
+	}
+}
+
+
+if ( -d "BitKeeper" ) {
+	my $bk = `which bk`;
+	chomp $bk;
+	if (length($bk) != 0) {
+		do_bk_checks();
+	}
+}
+
+printf "-%s\n", join("-",@LOCALVERSIONS) if (scalar @LOCALVERSIONS > 0);


-- 

Ryan Anderson
  sometimes Pug Majere
