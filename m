Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263133AbTIGLZ6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Sep 2003 07:25:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262930AbTIGLZ6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Sep 2003 07:25:58 -0400
Received: from wohnheim.fh-wedel.de ([213.39.233.138]:9129 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S263133AbTIGLZz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Sep 2003 07:25:55 -0400
Date: Sun, 7 Sep 2003 13:25:55 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: linux-kernel@vger.kernel.org
Cc: Andreas Dilger <adilger@clusterfs.com>
Subject: latest checkstack.pl
Message-ID: <20030907112555.GB20414@wohnheim.fh-wedel.de>
References: <20030907025757.A18482@schatzie.adilger.int>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="KsGdsel6WgEHnImy"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20030907025757.A18482@schatzie.adilger.int>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--KsGdsel6WgEHnImy
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hi!

Not sure when I posted my last version and Andreas just sent me some
small improvements, including ia64 support.

Since I'm off for something a bit bigger right now, here is the latest
working code.  Dan Kegel, Andreas and maybe others have some small
updates, nothing major, but still nice.  So if anyone wants to use it
or even maintain it, just go ahead.

In a while, there should be a big improvement to it, so I prefer to
ignore most of the small stuff for now.  A lot of it may become
obsolete anyway, once my vaporware comes into being.

Jörn

-- 
The wise man seeks everything in himself; the ignorant man tries to get
everything from somebody else.
-- unknown


--KsGdsel6WgEHnImy
Content-Type: application/x-perl
Content-Disposition: attachment; filename="checkstack.pl"
Content-Transfer-Encoding: quoted-printable

#!/usr/bin/perl=0A=0A#	Check the stack usage of functions=0A#=0A#	Copyright=
 Joern Engel <joern@wh.fh-wedel.de>=0A#	Inspired by Linus Torvalds=0A#	Orig=
inal idea maybe from Keith Owens=0A#	s390 port and big speedup by Arnd Berg=
mann <arnd@bergmann-dalldorf.de>=0A#	Mips port by Juan Quintela <quintela@m=
andrakesoft.com>=0A#	IA64 port via Andreas Dilger=0A#=0A#	Usage:=0A#	objdum=
p -d vmlinux | stackcheck_ppc.pl [arch]=0A#=0A#	TODO :	Port to all architec=
tures (one regex per arch)=0A=0A# check for arch=0A# =0A# $re is used for t=
hree matches:=0A# $& (whole re) matches the complete objdump line with the =
stack growth=0A# $1 (first bracket) matches the code that will be displayed=
 in the output=0A# $2 (second bracket) matches the size of the stack growth=
=0A#=0A# use anything else and feel the pain ;)=0A{=0A	my $arch =3D shift;=
=0A	if ($arch eq "") {=0A		$arch =3D `uname -m`;=0A	}=0A=0A	$x	=3D "[0-9a-f=
]";	# hex character=0A	$xs	=3D "[0-9a-f ]";	# hex character or space=0A	if =
($arch =3D~ /^i[3456]86$/) {=0A		#c0105234:       81 ec ac 05 00 00       s=
ub    $0x5ac,%esp=0A		$re =3D qr/^.*(sub    \$(0x$x{3,5}),\%esp)$/o;=0A	} e=
lsif ($arch =3D~ /^ia64$/) {=0A		#e0000000044011fc:       01 0f fc 8c     a=
dds r12=3D-384,r12=0A		$re =3D qr/.*(adds.*r12=3D-(([0-9]{2}|[3-9])[0-9]{2}=
),r12)/o;=0A	} elsif ($arch =3D~ /^mips64$/) {=0A		#8800402c:       67bdfff=
0        daddiu  sp,sp,-16=0A		$re =3D qr/.*(daddiu.*sp,sp,-(([0-9]{2}|[3-9=
])[0-9]{2}))/o;=0A	} elsif ($arch =3D~ /^mips$/) {=0A		#88003254:       27b=
dffe0        addiu   sp,sp,-32=0A		$re =3D qr/.*(addiu.*sp,sp,-(([0-9]{2}|[=
3-9])[0-9]{2}))/o;=0A	} elsif ($arch =3D~ /^ppc$/) {=0A		#c00029f4:       9=
4 21 ff 30     stwu    r1,-208(r1)=0A		$re =3D qr/.*(stwu.*r1,-($x{3,5})\(r=
1\))/o;=0A	} elsif ($arch =3D~ /^s390x?$/) {=0A		#   11160:       a7 fb ff =
60             aghi   %r15,-160=0A		$re =3D qr/.*(ag?hi.*\%r15,-(([0-9]{2}|=
[3-9])[0-9]{2}))/o;=0A	} else {=0A		print("wrong or unknown architecture\n"=
);=0A		exit=0A	}=0A}=0A=0Asub bysize($) {=0A	($asize =3D $a) =3D~ s/$re/\2/=
;=0A	($bsize =3D $b) =3D~ s/$re/\2/;=0A	$asize =3D hex($asize) if ($asize =
=3D~ /^0x/);=0A	$bsize =3D hex($bsize) if ($bsize =3D~ /^0x/);=0A	$bsize <=
=3D> $asize=0A}=0A=0A#=0A# main()=0A#=0A$funcre =3D qr/^$x* \<(.*)\>:$/;=0A=
while ($line =3D <STDIN>) {=0A	if ($line =3D~ m/$funcre/) {=0A		($func =3D =
$line) =3D~ s/$funcre/\1/;=0A		chomp($func);=0A	}=0A	if ($line =3D~ m/$re/)=
 {=0A		(my $addr =3D $line) =3D~ s/^($xs{8}).*/0x\1/o;=0A		chomp($addr);=0A=
=0A		my $intro =3D "$addr $func:";=0A		my $padlen =3D 56 - length($intro);=
=0A		while ($padlen > 0) {=0A			$intro .=3D '	';=0A			$padlen -=3D 8;=0A		}=
=0A		(my $code =3D $line) =3D~ s/$re/\1/;=0A=0A		$stack[@stack] =3D "$intro=
 $code";=0A	}=0A}=0A=0A@sortedstack =3D sort bysize @stack;=0A=0Aforeach $i=
 (@sortedstack) {=0A	print("$i");=0A}=0A
--KsGdsel6WgEHnImy--
