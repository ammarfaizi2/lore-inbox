Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262437AbSJPMOi>; Wed, 16 Oct 2002 08:14:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262465AbSJPMNd>; Wed, 16 Oct 2002 08:13:33 -0400
Received: from uni01du.unity.ncsu.edu ([152.1.13.101]:33152 "EHLO
	uni01du.unity.ncsu.edu") by vger.kernel.org with ESMTP
	id <S262437AbSJPMMr>; Wed, 16 Oct 2002 08:12:47 -0400
From: jlnance@unity.ncsu.edu
Date: Wed, 16 Oct 2002 08:18:42 -0400
To: Ben Collins <bcollins@debian.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux v2.5.43
Message-ID: <20021016121842.GA2292@ncsu.edu>
References: <Pine.LNX.4.44.0210152040540.1708-100000@penguin.transmeta.com> <20021016073154.GF4827@suse.de> <20021016120528.GI5613@phunnypharm.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="2oS5YaxWCcQjTEyO"
Content-Disposition: inline
In-Reply-To: <20021016120528.GI5613@phunnypharm.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--2oS5YaxWCcQjTEyO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Oct 16, 2002 at 08:05:29AM -0400, Ben Collins wrote:

> > The binary rpms are built on SuSE 8.1, there's a source rpm there too
> > though. This is 1.11a37 with Linus patch that allows you do to
> 
> Can us non-rpm'ers get a tarball, please? Even an upstream tarball with
> patches in the topdir would be fine.

Hi Ben,
    I attached a perl script to this email that will let you turn an rpm
into a cpio file.  To use it do:

	rpm2cpio some.file.rpm | cpio --extract

Hope this helps.

Jim

--2oS5YaxWCcQjTEyO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=rpm2cpio

#! /usr/bin/env perl

# why does the world need another rpm2cpio?  because the existing one
# won't build unless you have half a ton of things that aren't really
# required for it, since it uses the same library used to extract RPM's.
# in particular, it won't build on the HPsUX box i'm on.

# add a path if desired
$gzip = "gzip";

sub printhelp {
  print "rpm2cpio, perl version by orabidoo <odar\@pobox.com>\n";
  print "use: rpm2cpio [file.rpm]\n";
  print "dumps the contents to stdout as a GNU cpio archive\n";
  exit 0;
}

if ($#ARGV == -1) {
  printhelp if -t STDIN;
  $f = "STDIN";
} elsif ($#ARGV == 0) {
  open(F, "< $ARGV[0]") or die "Can't read file $ARGV[0]\n";
  $f = 'F';
} else {
  printhelp;
}

printhelp if -t STDOUT;

# gobble the file up
undef $/;
$|=1;
$rpm = <$f>;
close ($f);

($magic, $major, $minor, $crap) = unpack("NCC C90", $rpm);

die "Not an RPM\n" if $magic != 0xedabeedb;
die "Not a version 3 RPM\n" if $major != 3;

$rpm = substr($rpm, 96);

while ($rpm ne '') {
  $rpm =~ s/^\c@*//s;
  ($magic, $crap, $sections, $bytes) = unpack("N4", $rpm);
  $smagic = unpack("n", $rpm);
  last if $smagic eq 0x1f8b;
  die "Error: header not recognized\n" if $magic != 0x8eade801;
  $rpm = substr($rpm, 16*(1+$sections) + $bytes);
}

die "bogus RPM\n" if $rpm eq '';

open(ZCAT, "|gzip -cd") || die "can't pipe to gzip\n";
print STDERR "CPIO archive found!\n";

print ZCAT $rpm;
close ZCAT;




--2oS5YaxWCcQjTEyO--
