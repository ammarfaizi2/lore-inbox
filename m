Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262429AbTEAFjM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 May 2003 01:39:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262473AbTEAFjM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 May 2003 01:39:12 -0400
Received: from pD9E23BA5.dip.t-dialin.net ([217.226.59.165]:45524 "EHLO
	hawkeye.luckynet.adm") by vger.kernel.org with ESMTP
	id S262429AbTEAFjK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 May 2003 01:39:10 -0400
Date: Wed, 30 Apr 2003 22:36:55 +0200
From: Thunder Anklin <thunder@keepsake.ch>
To: linux-kernel@vger.kernel.org
Subject: [SCRIPT] The universal include stepping script
Message-ID: <20030430203654.GF5470@hawkeye.luckynet.adm>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ZPDwMsyfds7q4mrK"
Content-Disposition: inline
X-Location: Dorndorf-Steudnitz, Germany
X-GPG-KeyID: 0x30F8436E
X-GPG-Fingerprint: 22F7 F950 CCCF DC35 408C  4A4C 2CDE 7159 E070 C1EC
X-GPG-Key: http://lightweight.ods.org/~thunder/thunder.asc
X-Priority: I really don't care.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--ZPDwMsyfds7q4mrK
Content-Type: multipart/mixed; boundary="XRI2XbIfl/05pQwm"
Content-Disposition: inline


--XRI2XbIfl/05pQwm
Content-Type: text/plain; charset=us-ascii
Content-Description: The mail
Content-Disposition: inline

Salut,

the appended script  can be used for almost  everything. It might even
be a  first step to the solution  of the problem mentioned  a few days
ago...

I'm working on it. However, this is a template script for everyone.

			Thunder

--XRI2XbIfl/05pQwm
Content-Type: application/x-perl
Content-Description: The universal include stepping script
Content-Disposition: attachment; filename="scaninclude.pl"
Content-Transfer-Encoding: quoted-printable

#!/usr/bin/perl -w=0A#=0A# Analyze whether a symbol is defined  in the incl=
ude tree of a source=0A# file.=0A#=0A# This script is only supposed to  wor=
k in the Linux kernel! If you're=0A# lucky, you might find it to work somew=
here else.=0A#=0A# (c) 2003, Thunder Anklin <thunder@keepsake.ch>=0A#=0A=0A=
my @includefiles =3D ();=0Amy @parsedfiles =3D ();=0Amy @file_lifo =3D ();=
=0Amy @includepath =3D ();=0Amy $arg;=0Amy $gcc_searchpath;=0Amy $debug =3D=
 0;=0A=0Asub for_each_include {=0A	# Please  enter code  here which  shall =
be  executed  for each=0A	# includefile.=0A	#=0A	# $_[0] is the filename.=
=0A}=0A=0Asub for_each_processed {=0A	# Please enter code here which  shall=
 be executed after a file=0A	# was processed.=0A	#=0A	# $_[0] is the filena=
me.=0A}=0A=0Asub printd {=0A	if ($debug) {=0A		printf @_;=0A	}=0A}=0A=0Asub=
 gcc_get_searchpath {=0A	local ($fd, $buf, $retval);=0A=0A	$retval =3D "";=
=0A	open($fd, "gcc -print-search-dirs |") or goto out;=0A=0A	while (defined=
($buf =3D <$fd>)) {=0A		if ($buf =3D~ /^install:\s+(.*)\r?\n/) {=0A			if (-=
e $1 . "/include") {=0A				$retval =3D $1 . "/include";=0A			}=0A		}=0A	}=
=0A=0A	close($fd);=0A=0A      out:=0A	return $retval;=0A}=0A=0Asub includep=
ath_add {=0A	local ($dirname) =3D @_;=0A=0A	if ($dirname eq ".") {=0A		$dir=
name =3D $ENV{"PWD"};=0A	}=0A=0A	if (!($dirname =3D~ /^\//)) {=0A		$dirname=
 =3D $ENV{"PWD"} . "/" . $dirname;=0A	}=0A	push(@includepath, $dirname) unl=
ess (! -d $dirname);=0A=0A	return;=0A}=0A=0Asub elem_in_stack {=0A	local ($=
elem, @stack) =3D @_;=0A	local ($i) =3D (0);=0A=0A	for ($i =3D 0; $i < scal=
ar(@stack); $i++) {=0A		if ($stack[$i] eq $elem) {=0A			return 1;=0A		}=0A	=
}=0A=0A	return 0;=0A}=0A=0Asub process_file {=0A	local ($filename) =3D @_;=
=0A	local ($buf, $i) =3D ("", 0);=0A	local ($fd);=0A=0A	printd("Hit " . $fi=
lename . "\n");=0A	push(@parsedfiles, $filename);=0A=0A	for ($i =3D 0; $i <=
 scalar(@includepath); $i++) {=0A		if (-e $includepath[$i] . "/" . $filenam=
e) {=0A			if (open($fd, "<" . $includepath[$i] . "/" .=0A				 $filename)) {=
=0A				goto found_file;=0A			}=0A			printd("Whoops: %s: %s\n", $includepath=
[$i] . "/" .=0A			       $filename, $!);=0A		}=0A	}=0A=0A	if ($! =3D=3D 2) =
{=0A		printd("WARNING: %s: no file found!\n", $filename);=0A		return 0;=0A	=
}=0A	return $!;=0A=0A      found_file:=0A	while (defined($buf =3D <$fd>)) {=
=0A		if ($buf =3D~ /^\s*\#\s*include\s*\<([^\>]+)\>/) {=0A			local ($includ=
efile) =3D ($1);=0A=0A			if (!elem_in_stack($includefile, @includefiles)) {=
=0A				for_each_include($includefile);=0A=0A				push(@includefiles, $includ=
efile);=0A				push(@file_lifo, $includefile);=0A			}=0A		}=0A	}=0A=0A	close=
($fd) or return($!);=0A=0A	for_each_processed($filename);=0A=0A	return 0;=
=0A}=0A=0Aif (!scalar(@ARGV)) {=0A	print(STDERR "Usage:\n" .=0A	      __FIL=
E__ . " [ -Iincludepath ... ] file [ file ... ]\n");=0A	exit(1);=0A}=0A=0Ai=
ncludepath_add(".");=0Aincludepath_add("include");=0A=0A$gcc_searchpath =3D=
 gcc_get_searchpath();=0A=0Aif (length($gcc_searchpath) && -e $gcc_searchpa=
th) {=0A	includepath_add($gcc_searchpath);=0A}=0A=0Awhile (($ARGV[0] . "\n"=
) =3D~ /^-I(.*)$/) {=0A	includepath_add($1);=0A	shift();=0A}=0A=0Aprintd("I=
nclude path:");=0Aforeach $arg (@includepath) {=0A	print(" " . $arg);=0A}=
=0Aprint("\n");=0A=0Aif (!scalar(@ARGV)) {=0A	print(STDERR "Usage:\n" .=0A	=
      __FILE__ . " [ -Iincludepath ... ] file [ file ... ]\n");=0A	exit(1);=
=0A}=0A=0Aforeach $arg (@ARGV) {=0A	local ($retval) =3D (0);=0A=0A	@include=
files =3D (); @parsedfiles =3D (); @file_lifo =3D ($arg);=0A=0A	while (scal=
ar(@file_lifo)) {=0A		$retval =3D process_file(shift(@file_lifo));=0A=0A		i=
f ($retval) {=0A			printf("%s: Error: %i\n", $parsedfiles[-1],=0A			       =
$retval);=0A		}=0A	}=0A=0A	printd("%s: Processed %i includefiles.\n", $arg,=
=0A	       scalar(@parsedfiles));=0A}=0A=0Aexit(0);=0A=0A# Local variables:=
=0A#  perl-indent-level: 8=0A# End:=0A
--XRI2XbIfl/05pQwm--

--ZPDwMsyfds7q4mrK
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (FreeBSD)

iD8DBQE+sDPgLN5xWeBwwewRAus3AKDQ2gyE3JQY0IKkVUO1fnmS7TJkNACfXjxo
bOHAW1KdXLNznTXtyexbsFQ=
=dcoE
-----END PGP SIGNATURE-----

--ZPDwMsyfds7q4mrK--
