Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283438AbRLMGAN>; Thu, 13 Dec 2001 01:00:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283442AbRLMGAD>; Thu, 13 Dec 2001 01:00:03 -0500
Received: from adsl-64-109-202-217.dsl.milwwi.ameritech.net ([64.109.202.217]:19953
	"EHLO alphaflight.d6.dnsalias.org") by vger.kernel.org with ESMTP
	id <S283438AbRLMF7o>; Thu, 13 Dec 2001 00:59:44 -0500
Date: Wed, 12 Dec 2001 23:59:43 -0600
From: "M. R. Brown" <mrbrown@0xd6.org>
To: Keith Owens <kaos@ocs.com.au>
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com,
        marcelo@conectiva.com.br
Subject: Re: Any arch specific changes to scripts directory?
Message-ID: <20011213055943.GB7669@0xd6.org>
In-Reply-To: <20875.1008198543@ocs3.intra.ocs.com.au>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="s9fJI615cBHmzTOP"
Content-Disposition: inline
In-Reply-To: <20875.1008198543@ocs3.intra.ocs.com.au>
User-Agent: Mutt/1.3.24i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--s9fJI615cBHmzTOP
Content-Type: multipart/mixed; boundary="0eh6TmSyL6TZE2Uz"
Content-Disposition: inline


--0eh6TmSyL6TZE2Uz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On an somewhat-related subject, here are a couple of utility scripts that
make it easier to use drop-in trees with various stock kernels.  These are
used by linux-mips, linuxconsole (Ruby), and linuxsh developers, so it's
assumed they'd be useful to anyone else who needs to build those kernels.

Ok for inclusion into scripts/ ?

M. R.

* Keith Owens <kaos@ocs.com.au> on Thu, Dec 13, 2001:

> Does any architecture have local changes to the scripts directory?
> This includes scripts/mkdep.c, the config code etc.  Or to the top
> level Makefile and Rules.make?  I need to know about anything that
> affects the overall kernel build and is not in the base kernel.
>=20


--0eh6TmSyL6TZE2Uz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="treescripts.diff"

--- /usr/src/linux/scripts/treelink.sh	Wed Dec 12 23:50:08 2001
+++ linux-2.4-branch/scripts/treelink.sh	Tue Oct 16 16:25:24 2001
@@ -0,0 +1,45 @@
+#!/bin/sh
+#
+# treelink.sh - Tree Linking Script
+#
+# Copyright (C) 2001 Paul Mundt <lethal@chaoticdreams.org>
+#
+# Modified by M. R. Brown <mrbrown@0xd6.org>
+#
+# A simple shell script for linking a drop in tree into a stock
+# kernel tree. Usable for drop in trees such as the linux-mips
+# and linuxconsole trees.
+#
+# Released under the terms of the GNU GPL v2
+#
+[ "$#" -ne "2" ] && echo "Usage: $0 <drop in tree> <kernel tree>" && exit 1
+
+ODIR=${PWD}
+cd $1 || exit 1
+LDIR=${PWD}
+echo -n "Building file list ... "
+LIST=`find * \( -type d -name CVS -prune \) -o -type f -print`
+echo -e "done."
+cd ${ODIR}
+
+cd $2 || exit 1
+
+# Make this a seperate step so that the user can cancel the operation
+echo -n "Saving originals ..... "
+for file in $LIST; do
+	if [ -e $file  -a  ! -h $file ]; then
+		DIR=`dirname $file`
+		ofile=`basename $file`
+		[ ! -d ${DIR}/.orig ] && mkdir -p ${DIR}/.orig
+		cp $file ${DIR}/.orig/$ofile
+	fi
+done
+echo -e "done."
+
+echo -n "Linking files ........ "
+for file in $LIST; do
+	DIR=`dirname $file`
+	[ ! -d $DIR ] && mkdir -p $DIR
+	ln -sf $LDIR/$file $file
+done
+echo -e "done."
--- /usr/src/linux/scripts/treeunlink.sh	Wed Dec 12 23:50:10 2001
+++ linux-2.4-branch/scripts/treeunlink.sh	Tue Oct 16 16:25:24 2001
@@ -0,0 +1,31 @@
+#!/bin/sh
+#
+# treeunlink.sh - Tree Unlinking Script
+#
+# Copyright (c) 2001 M. R. Brown <mrbrown@0xd6.org>
+#
+# This script attempts to restore a previously tree-linked tree.
+# It's the anti-thesis of (and based on) treelink.sh by Paul Mundt.
+#
+# Released under the terms of the GNU GPL v2
+
+[ "$#" -ne "1" ] && echo "Usage: $0 <kernel tree>" && exit 1
+
+cd $1 || exit 1
+echo -n "Building file list ... "
+LIST=`find * \( -type d -name CVS -prune \) -o -type l -print`
+echo -e "done."
+
+[ -z "$LIST" ] && echo "No linked files to unlink." && exit 1
+
+echo -n "Restoring originals .. "
+for file in $LIST; do
+	DIR=`dirname $file`
+	ofile=`basename $file`
+	rm -f $file
+	if [ -d ${DIR}/.orig  -a  -e ${DIR}/.orig/$ofile ]; then
+		mv ${DIR}/.orig/$ofile $file
+		[ -z "`ls ${DIR}/.orig`" ] && rmdir ${DIR}/.orig
+	fi
+done
+echo -e "done."

--0eh6TmSyL6TZE2Uz--

--s9fJI615cBHmzTOP
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)

iD8DBQE8GEPPaK6pP/GNw0URAscwAJ41XyXo0oAmn6HtjQftODr9YbwNpQCgyV87
eSBs2S704dBmqsNWIFoHTuA=
=Jgp2
-----END PGP SIGNATURE-----

--s9fJI615cBHmzTOP--
