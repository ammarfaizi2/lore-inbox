Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262333AbVCJFPe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262333AbVCJFPe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Mar 2005 00:15:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261719AbVCJFMw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Mar 2005 00:12:52 -0500
Received: from mail.autoweb.net ([198.172.237.26]:10500 "EHLO mail.autoweb.net")
	by vger.kernel.org with ESMTP id S261860AbVCJFHV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Mar 2005 00:07:21 -0500
Date: Thu, 10 Mar 2005 00:06:53 -0500
From: Ryan Anderson <ryan@michonline.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Omkhar Arasaratnam <iamroot@ca.ibm.com>,
       Linux Kernel list <linux-kernel@vger.kernel.org>, tgall@us.ibm.com,
       antonb@au1.ibm.com, Sam Ravnborg <sam@ravnborg.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [BUG] 2.6.11- sym53c8xx Broken on pp64
Message-ID: <20050310050653.GX7828@mythryan2.michonline.com>
Mail-Followup-To: Linus Torvalds <torvalds@osdl.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Omkhar Arasaratnam <iamroot@ca.ibm.com>,
	Linux Kernel list <linux-kernel@vger.kernel.org>, tgall@us.ibm.com,
	antonb@au1.ibm.com, Sam Ravnborg <sam@ravnborg.org>,
	Andrew Morton <akpm@osdl.org>
References: <422FA817.4060400@ca.ibm.com> <1110420620.32525.145.camel@gaston> <Pine.LNX.4.58.0503091821570.2530@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0503091821570.2530@ppc970.osdl.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 09, 2005 at 06:25:56PM -0800, Linus Torvalds wrote:
> On Thu, 10 Mar 2005, Benjamin Herrenschmidt wrote:
> > 
> > BTW, Linus: Any chance you ever change something to version or
> > extraversion in bk just after a release ? I know I already ask and it
> > degenerated into a flamefest, and I don't know if that is specifically
> > the case now, but I keep getting report of people saying "I have a bug
> > in 2.6.xx" while in fact, they have some kind of bk clone of sometime
> > after 2.6.xx...
> 
> The answer is the same: I'd still like to have somebody (preferably Sam)  
> who is comfortable with all the build scripts get a revision-control-
> specific version at build-time, so that BK users would get the top-of-tree 
> key value, and other people could get some CVS revision or something.

I've got something that fixes up the version by adding -BK and then 8
hex characters from the md5 hash of the top of tree changeset key.

I was starting to work on stuffing that same value into a /proc file so
that you can figure out what the tree looked like, but at the moment,
you at least get a semi-random string appended to the version.

I resent the patch yesterday, but I'll put it here, too:
 
> I have this dim memory that Sam might even have had some early trials, but 
> maybe thats just wishful thinking.. Sam?

I think that was my patch - Sam was going to look at it, but I suspect
it got lost in more interesting things. :)

(I sent a better described version to Andrew yesterday, if you want to
grab that description and use it instead.)
 
Signed-Off-By: Ryan Anderson <ryan@michonline.com>

diff -Nru a/Makefile b/Makefile
--- a/Makefile	2005-03-09 02:51:15 -05:00
+++ b/Makefile	2005-03-09 02:51:15 -05:00
@@ -550,6 +550,24 @@
 
 #export	INSTALL_PATH=/boot
 
+# If CONFIG_LOCALVERSION_AUTO is set, we automatically perform some tests
+# and try to determine if the current source tree is a release tree, of any sort,
+# or if is a pure development tree.
+# A 'release tree' is any tree with a BitKeeper TAG associated with it.
+# The primary goal of this is to make it safe for a native BitKeeper user to
+# build a release tree (i.e, 2.6.9) and also to continue developing against the
+# current Linus tree, without having the Linus tree overwrite the 2.6.9 tree 
+# when installed.
+#
+# (In the future, CVS and SVN support will be added as well.)
+
+ifeq ($(CONFIG_LOCALVERSION_AUTO),y)
+	ifeq ($(shell ls -d $(srctree)/BitKeeper 2>/dev/null),$(srctree)/BitKeeper)
+		localversion-bk := $(shell $(srctree)/scripts/setlocalversion.sh $(srctree) $(objtree))
+		LOCALVERSION := $(LOCALVERSION)$(localversion-bk)
+	endif
+endif
+
 #
 # INSTALL_MOD_PATH specifies a prefix to MODLIB for module directory
 # relocations required by build roots.  This is not defined in the
diff -Nru a/init/Kconfig b/init/Kconfig
--- a/init/Kconfig	2005-03-09 02:51:15 -05:00
+++ b/init/Kconfig	2005-03-09 02:51:15 -05:00
@@ -69,6 +69,18 @@
 	  object and source tree, in that order.  Your total string can
 	  be a maximum of 64 characters.
 
+config LOCALVERSION_AUTO
+	bool "Automatically append version information to the version string"
+	default y
+	help
+	  This will try to automatically determine if the current tree is a
+	  release tree by looking for BitKeeper tags that belong to the
+	  current top of tree revision.
+	  A string of the format -BKxxxxxxxx will be added to the
+	  localversion.  The string generated by this will be appended 
+	  after any matching localversion* files, and after the 
+	  value set in CONFIG_LOCALVERSION
+
 config SWAP
 	bool "Support for paging of anonymous memory (swap)"
 	depends on MMU
diff -Nru a/scripts/setlocalversion b/scripts/setlocalversion
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/scripts/setlocalversion	2005-03-09 02:51:15 -05:00
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
diff -Nru a/scripts/setlocalversion.sh b/scripts/setlocalversion.sh
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/scripts/setlocalversion.sh	2005-03-09 02:51:15 -05:00
@@ -0,0 +1,26 @@
+#!/bin/sh
+
+BK=`which bk`
+MD5SUM=`which md5sum`
+
+srctree=$1
+objtree=$2
+
+if [ "$BK" == "" ];
+then
+	echo "scripts/setlocalversion.sh: Failed to find BK, not appending a -BK* version" >&2
+	exit 0
+fi
+
+if [ "$MD5SUM" == "" ];
+then
+	echo "scripts/setlocalversion.sh: Couldn't find md5sum, trying Perl version instead." >&2
+	exec perl scripts/setlocalversion $srctree $objtree
+fi
+
+cd $srctree
+changeset=`$BK changes -r+ -k`
+tag=`$BK prs -h -d':TAG:' -r'$changeset'`
+if [ "$tag" == "" ]; then
+	echo -n $changeset | md5sum | awk '{printf "-BK%s",substr($1,1,8)}'
+fi


-- 

Ryan Anderson
  sometimes Pug Majere
