Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261645AbUJ0Ijm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261645AbUJ0Ijm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 04:39:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262334AbUJ0Ijm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 04:39:42 -0400
Received: from mail.autoweb.net ([198.172.237.26]:19724 "EHLO mail.autoweb.net")
	by vger.kernel.org with ESMTP id S261645AbUJ0Ijc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 04:39:32 -0400
Date: Wed, 27 Oct 2004 04:38:57 -0400
From: Ryan Anderson <ryan@michonline.com>
To: David Vrabel <dvrabel@arcom.com>, Linus Torvalds <torvalds@osdl.org>,
       Len Brown <len.brown@intel.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Sam Ravnborg <sam@ravnborg.org>
Subject: Re: Versioning of tree
Message-ID: <20041027083857.GK10638@michonline.com>
Mail-Followup-To: David Vrabel <dvrabel@arcom.com>,
	Linus Torvalds <torvalds@osdl.org>, Len Brown <len.brown@intel.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Linux Kernel list <linux-kernel@vger.kernel.org>,
	Sam Ravnborg <sam@ravnborg.org>
References: <1098254970.3223.6.camel@gaston> <1098256951.26595.4296.camel@d845pe> <Pine.LNX.4.58.0410200728040.2317@ppc970.osdl.org> <20041025234736.GF10638@michonline.com> <417E39AE.5020209@arcom.com> <20041026122632.GH10638@michonline.com> <20041026190815.GA8338@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041026190815.GA8338@mars.ravnborg.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 26, 2004 at 09:08:15PM +0200, Sam Ravnborg wrote:
> On Tue, Oct 26, 2004 at 08:26:33AM -0400, Ryan Anderson wrote:
> > > Surely there's no need for this?  Can't the script spit out an 
> > > appropriate localversion* file instead?
> > 
> > It can, and yes, my first version used that method.
> > 
> > Except it never worked.  I was able to generate the file before
> > include/linux/version.h was rebuilt, but failed to get it picked up in
> > that.  I'm not really sure why.
> 
> The $(wildcard ...) function was executed before you created the file.

Can you explain why?

i.e, if I do this:

	localversion-bk := $(shell echo x > localversion-bk)
	localversion-files := $(wildcard localversion*)

I seem to get "localversion-bk" in my localversion-files variable, but
when I do something similar in the master Makefile, it doesn't seem to
get picked up correctly.

i.e, this doesn't work the same way, for some reason:

	localversion-test := $(shell echo x > localversion)
	ifeq ($(objtree),$(srctree))
	localversion-files := $(wildcard $(srctree)/localversion*)
	else
	localversion-files := $(wildcard $(objtree)/localversion* $(srctree)/localversion*)
	endif

This is all mostly off-topic, however, as it's irrelevant to what you
asked later.

> If we shall retreive the version from a SCM then as you already do
> must hide it in a script.

> I want the script only to be executed when we actually ask kbuild to
> build a kernel - so it has to be part of the prepare rule set.

As part of the prepare ruleset, should I simply add a prepare3 (and hook
it in appropriately), or do you mean, just have it in the same section

> Furthermore I like to avoid a dependency on perl for a basic kernel.
> Can you retreive the version from bk using a simple shell script?

After thinking about it - yes (I instead add a dependency on md5sum, so,
I guess, take your pick as to which is more likely to be a problem.)

The patch below has both the Perl and shell script in it, as well as the
added config option to disable this feature.

Signed-off-by: Ryan Anderson <ryan@michonline.com>


diff -Nru a/Makefile b/Makefile
--- a/Makefile	2004-10-27 04:33:05 -04:00
+++ b/Makefile	2004-10-27 04:33:05 -04:00
@@ -513,6 +513,24 @@
 
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
--- a/init/Kconfig	2004-10-27 04:33:05 -04:00
+++ b/init/Kconfig	2004-10-27 04:33:05 -04:00
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
+++ b/scripts/setlocalversion	2004-10-27 04:33:05 -04:00
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
+++ b/scripts/setlocalversion.sh	2004-10-27 04:33:05 -04:00
@@ -0,0 +1,19 @@
+#!/bin/sh
+
+BK=`which bk`
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
+cd $srctree
+changeset=`$BK changes -r+ -k`
+tag=`$BK prs -h -d':TAG:' -r'$changeset'`
+if [ "$tag" == "" ]; then
+	echo -n $changeset | md5sum | awk '{printf "-BK%s",substr($1,1,8)}'
+fi

