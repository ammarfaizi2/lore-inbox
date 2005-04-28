Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262296AbVD1Who@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262296AbVD1Who (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Apr 2005 18:37:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262308AbVD1Who
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Apr 2005 18:37:44 -0400
Received: from mail.kroah.org ([69.55.234.183]:39632 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262296AbVD1WhN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Apr 2005 18:37:13 -0400
Date: Thu, 28 Apr 2005 15:34:14 -0700
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>
Subject: kernel maintainer's HOWTO for quilt and -mm
Message-ID: <20050428223414.GA22785@kroah.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="J/dobhs11T7y2rNN"
Content-Disposition: inline
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--J/dobhs11T7y2rNN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Kernel Developer's guide to using quilt so everyone else benefits.

  Note, this is just one way to do this, if you have a different process
  for dealing with patches and making them public for others to view and
  test, by all means, please do it.  I'm offering this up as one
  possible way to achieve this goal, as a starting place for others to
  work off of.

So, You're a kernel maintainer faced with the fact that you are having
people send you loads of patches, but don't know how to stage them in a
fashion that others can see what you have and have not accepted.  You
also want to have them show up in the -mm releases and need to provide
some hint as to the order in which they should be applied.  This small
document and script will provide one solution to this.  The script is
also at:
	http://www.kernel.org/pub/linux/kernel/people/gregkh/gregkh-2.6/make_patchsets

First off, you need to be using quilt to manages the patches sent to
you.  I'm not going to try to explain how to use quilt, or set it up.
The only suggestion that I have is to use subdirectories for different
types of patches that you want to have rolled up together.  For example,
in my patches directory, I have the following structure:
	$ ls -F ~/linux/patches/
	driver/  gregkh/  i2c/  pci/  series  usb/

I place all usb related patches in the usb/ subdir, PCI related patches
in the pci/ subdir, and so on.  I leave the gregkh/ subdir for patches
that no one else would care about, and don't maintain for anyone else.

To export this mess of patches, the script below, make_patchsets, can be
used.  At the top of this script are a few items that you should edit to
customize for your own use.  They are:
	# AUTHOR is your name, it will be pre-appended to all patches
	AUTHOR=gregkh

	# KERNEL is the base kernel version your quilt series is
	# against.  You need to have this kernel tree already
	# uncompressed and waiting in the TMP directory
	KERNEL=2.6.12-rc3

	# TMP is where you want everything to happen.  You need to have
	# a base kernel version (specified by KERNEL) in here, all
	# unpacked.  This is also where the end result files will be
	# placed.
	TMP=~/linux/tmp

	# PATCH_DIR is the location of your quilt patches.  There should
	# be a file in here called "series" and a bunch of patches in
	# subdirectories below that (the subdirs are how you divide
	# stuff up by TREES)
	PATCH_DIR=~/linux/patches

	# TREES is a list of the different sets of kernel patches you
	# wish to produce.  If you only have one set of patches, this
	# can be a single value.  The strings here need to have a
	# subdirectory in the PATCH_DIR to get the patches from.
	TREES="driver i2c pci usb"

When this script is run, individual "summary" patches are generated, one
per TREES value, and a directory is created with all of the individual
patches that were used to generate this bigger patch.  In my case, this
looks like:
	$ ls -F ~/linux/tmp/ | grep gregkh
	gregkh-01-driver/
	gregkh-01-driver-2.6.12-rc3.patch
	gregkh-02-i2c/
	gregkh-02-i2c-2.6.12-rc3.patch
	gregkh-03-pci/
	gregkh-03-pci-2.6.12-rc3.patch
	gregkh-04-usb/
	gregkh-04-usb-2.6.12-rc3.patch

All of these patches are now safe to copy up to some public directory
somewhere and have others use them.  I suggest using something like:
	rsync -avP -e ssh --delete tmp/gregkh-* gregkh@some_public_box:/pub/linux/kernel/people/gregkh/gregkh-2.6/

Examples of the output of this script can be seen at:
	http://www.kernel.org/pub/linux/kernel/people/gregkh/gregkh-2.6/



--J/dobhs11T7y2rNN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=make_patchsets

#!/bin/bash
#
# Copyright 2005 Greg Kroah-Hartman <gregkh@suse.de>
#
# Released under the GPL v2 only.
#
# Horrible hack of a script to let kernel maintainers, who use quilt
# export a series of patches in a form that is rolled up, and in-order
# for others to pick up and use.  Examples of this is for the -mm releases.
#

# Here are the things you should modify:

# AUTHOR is your name, it will be pre-appended to all patches
AUTHOR=gregkh

# KERNEL is the base kernel version your quilt series is against.  You need to
# have this kernel tree already uncompressed and waiting in the TMP directory
KERNEL=2.6.12-rc3

# TMP is where you want everything to happen.  You need to have a base kernel
# version (specified by KERNEL) in here, all unpacked.  This is also where the
# end result files will be placed.
TMP=~/linux/tmp

# PATCH_DIR is the location of your quilt patches.  There should be a file in
# here called "series" and a bunch of patches in subdirectories below that (the
# subdirs are how you divide stuff up by TREES)
PATCH_DIR=~/linux/patches

# TREES is a list of the different sets of kernel patches you wish to produce.
# If you only have one set of patches, this can be a single value.  The strings
# here need to have a subdirectory in the PATCH_DIR to get the patches from.
TREES="driver i2c pci usb"


# Don't touch anything below here, unless you really want to...

do_it() {
	NEW=$BASE-$TREE
	CLEAN_TREE="$BASE$OLD_TREE"
	BASENAME=`echo "$AUTHOR" "$SERIES" "$TREE" | \
		awk '{ printf("%s-%02d-%s\n", $1, $2, $3, $4);}'`
	TMPDIR=$TMP/$BASENAME

	echo "Building series file for $TREE"
	chmod 644 $PATCH_DIR/$TREE/*.patch
	mkdir $TMPDIR
	touch $TMPDIR/series
	count=1
	for x in `grep "$TREE\/" $PATCH_DIR/series`
	do
		file=`basename $x`
		name=`echo "$AUTHOR" "$TREE" "$count" "$file" | \
			awk '{ printf("%s-%s-%03d_%s\n", $1, $2, $3, $4);}'`
		cp $PATCH_DIR/$x $TMPDIR/$name
		echo "$name" >> $TMPDIR/series
		let count++
	done

	echo "Creating $NEW kernel tree"
	cp -alp $CLEAN_TREE $NEW

	# apply quilt series
	cd $NEW
	QUILT_PATCHES=$TMPDIR QUILT_SERIES=$TMPDIR/series quilt push -aq --quiltrc
	rm $TMPDIR/series
	cd ..

	# TODO put "changelog" in patch.
	echo "diffing $CLEAN_TREE and $NEW"
	diff -Naur -X ../dontdiff $CLEAN_TREE $NEW > $BASENAME-$KERNEL.patch

	echo "cleaning up quilt remnants $NEW"
	rm -rf $NEW/.pc

	echo "Patch is at $BASENAME-$KERNEL.patch"
	echo "Dir of patches is at $TMPDIR"
	echo ""
	let SERIES++
}

BASE=linux-$KERNEL
# make sure we have a base tree to diff off of.
if [ ! -d "$TMP/$BASE" ] ; then
	echo "I need $TMP/$BASE present in order to work properly."
	exit 1
fi

# make sure everything is readable by world for when we upload the patches
find $PATCH_DIR -type f | xargs chmod 644

# initialize some variables
SERIES=1
OLD_TREE=""

# do the work
cd $TMP

for TREE in $TREES
do
	do_it
	if [ "X$OLD_TREE" != "X" ] ; then
		echo "Cleaning up $BASE$OLD_TREE"
		rm -rf $BASE$OLD_TREE
	fi
	OLD_TREE="-$TREE"
done
if [ "X$OLD_TREE" != "X" ] ; then
	echo "Cleaning up $BASE$OLD_TREE"
	rm -rf $BASE$OLD_TREE
fi


--J/dobhs11T7y2rNN--
