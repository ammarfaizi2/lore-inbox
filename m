Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261620AbVCCLN7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261620AbVCCLN7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 06:13:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261622AbVCCLNA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 06:13:00 -0500
Received: from faui3es.informatik.uni-erlangen.de ([131.188.33.16]:181 "EHLO
	faui3es.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id S261582AbVCCK7z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 05:59:55 -0500
Date: Thu, 3 Mar 2005 11:59:50 +0100
From: Martin Waitz <tali@admingilde.org>
To: linux-kernel@vger.kernel.org
Subject: script to send changesets per mail
Message-ID: <20050303105950.GH8617@admingilde.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="uAgJxtfIS94j9H4T"
Content-Disposition: inline
X-Habeas-SWE-1: winter into spring
X-Habeas-SWE-2: brightly anticipated
X-Habeas-SWE-3: like Habeas SWE (tm)
X-Habeas-SWE-4: Copyright 2002 Habeas (tm)
X-Habeas-SWE-5: Sender Warranted Email (SWE) (tm). The sender of this
X-Habeas-SWE-6: email in exchange for a license for this Habeas
X-Habeas-SWE-7: warrant mark warrants that this is a Habeas Compliant
X-Habeas-SWE-8: Message (HCM) and not spam. Please report use of this
X-Habeas-SWE-9: mark in spam to <http://www.habeas.com/report/>.
X-PGP-Fingerprint: B21B 5755 9684 5489 7577  001A 8FF1 1AC5 DFE8 0FB2
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--uAgJxtfIS94j9H4T
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hoi :)

I just tested my little script that can send changesets per mail.
okok, it still had a bug when I first tested it but that should be
fixed now.

If anyone is interested (perhaps for Documentation/BK-usage), here it
is:


#!/usr/bin/perl -w

# after sending an announcement (created by Documentation/BK-usage/bk-make-=
sum)
# just pipe your mail through this script.
# It will create one new mail per Changeset, properly threaded.

# Copyright =A9 2005 Martin Waitz <tali@admingilde.org>

use strict;

my $from;
my $to;
my $cc;
my $references;

# all local repositories are in ~/src/.
# you have to adjust this function if you keep them elsewhere.
sub local_repository($) {
	my $repo;
=09
	$repo=3D shift;

	$repo =3D~ s,.*/,"$ENV{HOME}/src/",e;
	return $repo;
}

# this checks if we are allowed to send mails with this sender
# please modify the regexp to check for your adress!
sub check_from($) {
	my $from =3D shift;

	exit 1 unless $from =3D~ /insert-your-email-here/; #FIXME
}

# send one changeset.
# Parameters: the cset number, description prefix and the actual descriptio=
n.
sub send_cset($$$$) {
	my ($cset, $serial, $desc, $longdesc) =3D @_;

	open (MAIL, "| /usr/sbin/sendmail -t") or die "fork sendmail: $!";
	print MAIL "From: $from\n";
	print MAIL "To: $to\n";
	print MAIL "Cc: $cc\n" if $cc;
	print MAIL "References: $references\n" if $references;
	print MAIL "Subject: [PATCH $serial] $desc\n";
	print MAIL "\n";
	print MAIL "$desc\n";
	print MAIL "$longdesc\n";
	print MAIL "\n";
	print MAIL `bk export -tpatch -du -r $cset`;
	close (MAIL) or die "could not send mail: error code $?";
}



# Parse header
while (<>) {
	chomp;
	last if /^$/;

	if (/^From:\s+(.+)$/i) {
		$from =3D $1;
	} elsif (/^To:\s+(.+)$/i) {
		$to =3D $1;
	} elsif (/^Cc:\s+(.+)$/i) {
		$cc =3D $1;
	} elsif (/^Message-Id:\s+(.+)$/i) {
		$references =3D $1;
	}
}

my @cset;
my @desc;
my @longdesc;

# Parse body
my $cset;
while (<>) {
	chomp;
	if (/^\s+bk pull (\S+)$/) {
		chdir local_repository($1) ||
			die "could not find local repository for $1\n";
	} elsif (/^<\S+> \(\S+ ([\d.]+)\)$/) {
		# start of new ChangeSet
		$cset =3D $1;
	} elsif (/^   (.*)$/ && $cset) {
		# first line of a description
		unshift @cset, $cset;
		unshift @desc, $1;
		unshift @longdesc, "";
		$cset =3D "";
	} elsif (/^   (.*)$/) {
		# next lines of description
		$longdesc[0] .=3D "$1\n";
	}
}


check_from($from);


my $i;
my $count;
$count =3D scalar @cset;
foreach $i (1 .. $count) {
	print "$desc[$i-1]\n";
	send_cset($cset[$i-1], "$i/$count", $desc[$i-1], $longdesc[$i-1]);
	# let sendmail process the mail...
	sleep 3;
}
exit(0);



--=20
Martin Waitz

--uAgJxtfIS94j9H4T
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQFCJu4mj/Eaxd/oD7IRAnYZAJ4xQUd+JBpT4BGqln+xR20lp206JwCfR5Xa
Zh3YNrSXCidClxt8QQPGAtQ=
=onHN
-----END PGP SIGNATURE-----

--uAgJxtfIS94j9H4T--
